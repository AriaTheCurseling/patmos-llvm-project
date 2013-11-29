//===----- SchedulePostRAList.cpp - list scheduler ------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// PatmosPostRASchedStrategy implements the scheduling strategy for the post-RA
// scheduler. 
//
// TODO merge this somehow with the pre-RA MachineSchedStrategy?
//
//===----------------------------------------------------------------------===//

#define DEBUG_TYPE "post-RA-sched"
#include "PatmosSchedStrategy.h"
#include "PatmosInstrInfo.h"
#include "PatmosRegisterInfo.h"
#include "PatmosTargetMachine.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/CodeGen/LatencyPriorityQueue.h"
#include "llvm/CodeGen/ScheduleDFS.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Target/TargetLowering.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Target/TargetRegisterInfo.h"
#include "llvm/Target/TargetSubtargetInfo.h"

#include <algorithm>

using namespace llvm;

bool ILPOrder::operator()(const SUnit *A, const SUnit *B) const {
  // Always prefer instructions with ScheduleLow flag.
  if (A->isScheduleLow != B->isScheduleLow) {
    return A->isScheduleLow;
  }

  // TODO check this .. prefer instructions that make others available, have
  // highest depth, ..

  unsigned SchedTreeA = DFSResult->getSubtreeID(A);
  unsigned SchedTreeB = DFSResult->getSubtreeID(B);
  if (SchedTreeA != SchedTreeB) {
    // Trees with shallower connections have have lower priority.
    if (DFSResult->getSubtreeLevel(SchedTreeA)
        != DFSResult->getSubtreeLevel(SchedTreeB)) {
      return DFSResult->getSubtreeLevel(SchedTreeA)
             > DFSResult->getSubtreeLevel(SchedTreeB);
    }

    // Unscheduled trees have lower priority.
    if (ScheduledTrees->test(SchedTreeA) != ScheduledTrees->test(SchedTreeB))
      return ScheduledTrees->test(SchedTreeA);

  }
  if (MaximizeILP)
    return DFSResult->getILP(A) > DFSResult->getILP(B);
  else
    return DFSResult->getILP(A) < DFSResult->getILP(B);
}


void PatmosLatencyQueue::setDFSResult(ScheduleDAGPostRA *DAG)
{
  Cmp.DFSResult = DAG->getDFSResult();
  Cmp.ScheduledTrees = &DAG->getScheduledTrees();
}

void PatmosLatencyQueue::initialize()
{
  std::sort(AvailableQueue.begin(), AvailableQueue.end(), Cmp);
}

void PatmosLatencyQueue::clear()
{
  PendingQueue.clear();
  AvailableQueue.clear();
}

/// Select a bundle for the current cycle. The selected instructions are
/// put into bundle in the correct issue order. If no instruction can be
/// issued, false is returned.
bool PatmosLatencyQueue::selectBundle(std::vector<SUnit*> &Bundle)
{
  if (AvailableQueue.empty()) return false;

  // Find best bundle:
  // - Ensure that instructions that MUST be scheduled go into the bundle.
  // - find best pair of available programs, e.g. two stores with exclusive
  //   predicates and highest ILP/.., but only if at least one of those instr.
  //   has high priority.
  // - find best instructions that fit into the bundle with highest ILP/..
  //
  // Instructions are built up into a bundle in Bundle. Instructions are removed
  // from AvailableQueue in scheduled() once the instruction is actually picked.

  unsigned CurrWidth = 0;
  // If the bundle is not empty, we should calculate the initial width
  assert(Bundle.empty());

  std::vector<bool> Selected;
  Selected.resize(AvailableQueue.size());

  // Make sure that all instructions with ScheduleLow flag go into the bundle.
  for (unsigned i = 0; i < AvailableQueue.size() && CurrWidth < IssueWidth; i++)
  {
    SUnit *SU = AvailableQueue[i];
    if (!SU->isScheduleLow) break;

    if (addToBundle(Bundle, SU, CurrWidth)) {
      Selected[i] = true;
    }
  }

  // Check if any of the highest <IssueWidth> instructions can be
  // scheduled only with a single other instruction in this queue, or if there
  // is any instruction in the queue that can only be scheduled with the highest
  // ones. Pick them in any case



  // TODO magic goes here..



  // Try to fill up the bundle with instructions from the queue by best effort
  for (unsigned i = 0; i < AvailableQueue.size() && CurrWidth < IssueWidth; i++)
  {
    if (Selected[i]) continue;
    SUnit *SU = AvailableQueue[i];

    // check the width. ignore the width for the first instruction to allow
    // ALUl even when bundling is disabled.
    unsigned width = PII.getIssueWidth(SU->getInstr());
    if (!Bundle.empty() && CurrWidth + width > IssueWidth) continue;

    addToBundle(Bundle, SU, CurrWidth);
  }

  return true;
}

/// Go back one cycle and update availability queue. If no more
/// instructions need to be scheduled, return false.
bool PatmosLatencyQueue::recedeCycle(unsigned CurrCycle)
{
  if (PendingQueue.empty() && AvailableQueue.empty()) {
    return false;
  }

  unsigned avail = 0;
  for (unsigned i = 0; i < PendingQueue.size() - avail; i++) {
    SUnit *SU = PendingQueue[i];

    if (SU->getHeight() <= CurrCycle) {
      // remove the instruction from pending
      avail++;
      PendingQueue[i] = *(PendingQueue.end() - avail);
      // revisit the moved instruction
      i--;

      // Make the instruction available
      AvailableQueue.push_back(SU);
      std::inplace_merge(AvailableQueue.begin(), AvailableQueue.end() - 1,
                         AvailableQueue.end(), Cmp);
    }
  }

  PendingQueue.resize(PendingQueue.size() - avail);

  return true;
}

/// Notify the queue that this instruction has now been scheduled.
void PatmosLatencyQueue::scheduled(SUnit *SU, unsigned CurrCycle)
{
  SU->setHeightToAtLeast(CurrCycle);

  AvailableQueue.erase(std::remove(AvailableQueue.begin(), AvailableQueue.end(),
                                   SU), AvailableQueue.end());
}

void PatmosLatencyQueue::scheduledTree(unsigned SubtreeID)
{
  std::sort(AvailableQueue.begin(), AvailableQueue.end(), Cmp);
}

/// put an instruction into the pending queue when all its successors have
/// been scheduled.
void PatmosLatencyQueue::makePending(SUnit *SU)
{
  PendingQueue.push_back(SU);
}

bool PatmosLatencyQueue::canIssueInSlot(SUnit *SU, unsigned Slot)
{
  assert(SU);
  if (!SU->getInstr()) return true;
  MachineInstr *MI = SU->getInstr();

  return PII.canIssueInSlot(MI, Slot);
}

bool PatmosLatencyQueue::addToBundle(std::vector<SUnit *> &Bundle, SUnit *SU,
                                     unsigned &CurrWidth)
{
  // check the width. ignore the width for the first instruction to allow
  // ALUl even when bundling is disabled.
  unsigned Width = PII.getIssueWidth(SU->getInstr());
  if (!Bundle.empty() && CurrWidth + Width > IssueWidth) {
    return false;
  }

  // Inline Asm always gets scheduled on its own.
  if (SU->getInstr()->isInlineAsm()) {
    if (!Bundle.empty())
      return false;
    Bundle.push_back(SU);
    CurrWidth = IssueWidth;
    return true;
  }

  // TODO We could/should use the HazardRecognizer to check if we have the
  // resources, but it is difficult to keep the HazardRecognizer state in sync.

  // This is not quite correct, the slot might depend on the width of the
  // previously scheduled instructions, but for the current ISA it makes
  // no difference since no instruction can be scheduled with an ALUl.
  if (canIssueInSlot(SU, Bundle.size())) {
    Bundle.push_back(SU);
    CurrWidth += Width;
    return true;
  }

  assert(!Bundle.empty() &&
        "Not able to issue the instruction in an empty bundle?");

  // We might need to rearrange instructions.. this is a quick hack and might
  // be improved for VLIW with >2 slots
  if (canIssueInSlot(SU, 0) && canIssueInSlot(Bundle[0], Bundle.size())) {
    Bundle.push_back(Bundle[0]);
    Bundle[0] = SU;
    CurrWidth += Width;
    return true;
  }

  return false;
}

void PatmosLatencyQueue::dump()
{
  dbgs() << "PendingQueue:";
  for (unsigned i = 0; i < PendingQueue.size(); i++) {
    SUnit *SU = PendingQueue[i];
    if (i > 0) dbgs() << ",";
    dbgs() << " SU(" << SU->NodeNum << "): Height " << SU->getHeight()
           << " Depth " << SU->getDepth()
           << " Tree: " << Cmp.DFSResult->getSubtreeID(SU) << " @"
           << Cmp.DFSResult->getSubtreeLevel(Cmp.DFSResult->getSubtreeID(SU));
    if (SU->isScheduleLow) dbgs() << " low ";
  }
  dbgs() << "\nAvailableQueue:";
  for (unsigned i = 0; i < AvailableQueue.size(); i++) {
    SUnit *SU = AvailableQueue[i];
    if (i > 0) dbgs() << ",";
    dbgs() << " SU(" << SU->NodeNum << ") Height " << SU->getHeight()
           << " Depth " << SU->getDepth()
           << " ILP: " << Cmp.DFSResult->getILP(SU);
    if (SU->isScheduleLow) dbgs() << " low ";
  }
  dbgs() << "\n";
}



PatmosPostRASchedStrategy::PatmosPostRASchedStrategy(
                                            const PatmosTargetMachine &PTM)
: PTM(PTM), PII(*PTM.getInstrInfo()), PRI(PII.getPatmosRegisterInfo()),
  DAG(0), ReadyQ(PTM), CurrCycle(0)
{
}

bool PatmosPostRASchedStrategy::isSchedulingBoundary(const MachineInstr *MI,
                                            const MachineBasicBlock *MBB,
                                            const MachineFunction &MF)
{
  if (MI->isDebugValue())
    return false;

  // Terminators and labels can't be scheduled around.
  if (MI->getDesc().isTerminator() || MI->isLabel())
    return true;

  // Do not schedule over inline asm
  // TODO This is not actually really required, but it makes things a bit less
  // error-prone. Check if we want to remove that restriction or not.
  if (MI->isInlineAsm())
    return true;

  // All CFL instructions are boundaries, we only handle one CFL per region.
  return MI->isBarrier() || MI->isBranch() || MI->isCall() || MI->isReturn();
}

void PatmosPostRASchedStrategy::postprocessDAG(ScheduleDAGPostRA *dag)
{
  DAG = dag;

  SUnit *CFL = NULL;

  // Find the branch/call/ret instruction if available
  for (std::vector<SUnit>::reverse_iterator it = DAG->SUnits.rbegin(),
       ie = DAG->SUnits.rend(); it != ie; it++)
  {
    MachineInstr *MI = it->getInstr();
    if (!MI) continue;
    if (isPatmosCFL(MI->getOpcode(), MI->getDesc().TSFlags)) {
      CFL = &*it;
      break;
    }
  }

  const PatmosSubtarget *PST = PTM.getSubtargetImpl();

  unsigned DelaySlot = CFL ? PST->getDelaySlotCycles(CFL->getInstr()) : 0;

  if (CFL) {
    // RET and CALL have implicit deps on the return values and call
    // arguments. Remove all those edges to schedule them into the delay slot
    // if the registers are not actually used by CALL and RET
    if (CFL->getInstr()->isReturn() || CFL->getInstr()->isCall())
      removeImplicitCFLDeps(*CFL);

    // TODO if CFL is a branch and we do not have enough roots/single preds of
    // roots, i.e. not enough ILP to fill delay slots, replace CFL with a
    // non-delayed branch

    // Add an artificial dep from CFL to exit for the delay slot
    SDep DelayDep(CFL, SDep::Artificial);
    DelayDep.setLatency(DelaySlot + 1);
    DelayDep.setMinLatency(DelaySlot + 1);
    DAG->ExitSU.addPred(DelayDep);

    CFL->isScheduleLow = true;
  }

  // remove barriers between loads/stores with different memory type
  removeTypedMemBarriers();

  // remove any dependency between instructions with mutually exclusive
  // predicates
  removeExclusivePredDeps();

  // TODO SWS and LWS do not have ST as implicit def edges
  // TODO CALL has chain edges to all SWS/.. instructions, remove
  // TODO MFS $r1 = $s0 has edges to all SWS/SENS/.. instructions, remove

  // TODO remove edges from MUL to other MULs to overlap MUL and MFS for
  //      pipelined muls.
}


void PatmosPostRASchedStrategy::initialize(ScheduleDAGPostRA *dag)
{
  CurrCycle = 0;
  CurrBundle.clear();
  ReadyQ.clear();

  DAG->computeDFSResult();
  ReadyQ.setDFSResult(DAG);
}

void PatmosPostRASchedStrategy::registerRoots()
{
  ReadyQ.initialize();
}

void PatmosPostRASchedStrategy::finalize(ScheduleDAGPostRA *dag)
{
  DAG = NULL;
}

bool PatmosPostRASchedStrategy::pickNode(SUnit *&SU, bool &IsTopNode,
                                         bool &IsBundled)
{
  /// We schedule at the bottom only.
  IsTopNode = false;

  if (CurrBundle.empty()) {
    IsBundled = false;

    // Not emitting a bundle at the moment, go back one cycle ..
    if (!ReadyQ.recedeCycle(++CurrCycle))
      return false;

    DEBUG(dbgs() << "\nPicking node in cycle " << CurrCycle << "\n";
          ReadyQ.dump());

    // .. and try to get a new bundle.
    if (!ReadyQ.selectBundle(CurrBundle)) {
      // emit a NOOP if nothing is available.

      // TODO try to reschedule an already scheduled node from a later bundle

      SU = NULL;
      return true;
    }
  } else {
    IsBundled = true;
  }

  // emit an instruction from the current bundle
  SU = CurrBundle.front();
  CurrBundle.erase(CurrBundle.begin());

  return true;
}

void PatmosPostRASchedStrategy::schedNode(SUnit *SU, bool IsTopNode,
                                          bool IsBundled)
{
  MachineInstr *MI = SU->getInstr();
  if (MI->isInlineAsm() ||
      getPatmosFormat(MI->getDesc().TSFlags) == PatmosII::FrmALUl)
  {
    assert(!IsBundled && "Trying to bundle ALUl or inline asm");
  }

  // TODO keep track of nodes that have been scheduled inside a bundle and
  // where no predecessor has been scheduled yet, i.e., which might be moved up
  if (IsBundled && !SU->isScheduleLow) {

  }

  ReadyQ.scheduled(SU, CurrCycle);
}

void PatmosPostRASchedStrategy::reschedNode(SUnit *SU, bool IsTopNode,
                                            bool IsBundled)
{
}

void PatmosPostRASchedStrategy::schedNoop(bool IsTopNode)
{
}

void PatmosPostRASchedStrategy::scheduleTree(unsigned SubtreeID)
{
  ReadyQ.scheduledTree(SubtreeID);
}

void PatmosPostRASchedStrategy::releaseTopNode(SUnit *SU)
{
  // Nothing to be done here, we are only scheduling bottom up. Entry nodes
  // are released nevertheless.
}

void PatmosPostRASchedStrategy::releaseBottomNode(SUnit *SU)
{
  ReadyQ.makePending(SU);
}


/// Remove dependencies to a return or call due to implicit uses of the return
/// value registers, arguments or callee saved regs. Does not remove
/// dependencies to return info registers.
/// This can be done since call and return are scheduling boundaries.
void PatmosPostRASchedStrategy::removeImplicitCFLDeps(SUnit &SU)
{
  SmallVector<SDep*,2> RemoveDeps;

  for (SUnit::pred_iterator it = SU.Preds.begin(), ie = SU.Preds.end();
       it != ie; it++)
  {
    if (!it->getSUnit()) continue;
    // We only handle Data, Anti and Output deps here.
    if (it->getKind() == SDep::Order) continue;

    MachineInstr *MI = SU.getInstr();

    // Check if it is actually only an implicit use, not a normal operand
    bool IsImplicit = true;
    for (unsigned i = 0; i < MI->getNumOperands(); i++) {
      MachineOperand &MO = MI->getOperand(i);

      if (!MO.isReg()) continue;

      // Check if the register is actually used or defined by the instruction,
      // either explicit or via a special register
      if (!isExplicitCFLOperand(MI, MO)) continue;

      // MO is an used/defined operand, check if it is defined or used by the
      // predecessor
      if (it->getKind() == SDep::Data) {
        // .. easy for Deps, since we know the register.
        if (MO.getReg() == it->getReg()) {
          IsImplicit = false;
          break;
        }
      } else if (MO.isDef() && (!MO.isImplicit())) {
        // for Anti and Output dependency we need to check the registers of
        // the predecessor.
        MachineInstr *PredMI = it->getSUnit()->getInstr();
        for (unsigned j = 0; j < PredMI->getNumOperands(); j++) {
          MachineOperand &PredMO = PredMI->getOperand(i);
          if (PredMO.isReg() && PredMO.getReg() == MO.getReg()) {
            IsImplicit = false;
            break;
          }
        }
      }
    }

    if (IsImplicit) {
      RemoveDeps.push_back(&*it);
    }
  }

  // Remove found implicit deps, add deps to exit node
  while (!RemoveDeps.empty()) {
    SDep *Dep = RemoveDeps.back();
    RemoveDeps.pop_back();

    SDep ExitDep(Dep->getSUnit(), SDep::Artificial);
    ExitDep.setLatency( computeExitLatency(*Dep->getSUnit()) );

    SU.removePred(*Dep);
    DAG->ExitSU.addPred(ExitDep);
  }
}

/// Remove barrier and memory deps between instructions that access
/// different memory types and cannot alias.
void PatmosPostRASchedStrategy::removeTypedMemBarriers()
{

}

/// Remove all dependencies between instructions with mutually exclusive
/// predicates.
void PatmosPostRASchedStrategy::removeExclusivePredDeps()
{

}

bool PatmosPostRASchedStrategy::isExplicitCFLOperand(MachineInstr *MI,
                                                     MachineOperand &MO)
{
  if (!MO.isImplicit()) return true;

  if (MO.getReg() == Patmos::SRB || MO.getReg() == Patmos::SRO ||
      MO.getReg() == Patmos::SXB || MO.getReg() == Patmos::SXO)
  {
    return true;
  }

  return false;
}

unsigned PatmosPostRASchedStrategy::computeExitLatency(SUnit &SU) {
  MachineInstr *PredMI = SU.getInstr();
  if (!PredMI) return 0;

  // TODO we should actually look into the following region/MBBs and check
  // if they are already scheduled and if we actually need a latency > 1 on
  // loads.
  unsigned Latency = 0;

  for (unsigned i = 0; i < PredMI->getNumOperands(); i++) {
    MachineOperand &MO = PredMI->getOperand(i);
    if (!MO.isReg() || !MO.isDef()) continue;

    // Get the default latency as the write cycle of the operand.
    unsigned OpLatency = DAG->getSchedModel()->computeOperandLatency(PredMI,
                                                      i, NULL, 0, false);

    Latency = std::max(Latency, OpLatency);
  }

  return Latency;
}
