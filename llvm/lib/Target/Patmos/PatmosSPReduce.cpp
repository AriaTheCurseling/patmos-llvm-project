//===-- PatmosSPReduce.cpp - Reduce the CFG for Single-Path code ----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This pass reduces functions marked for single-path conversion.
//
//===----------------------------------------------------------------------===//

#define DEBUG_TYPE "patmos-singlepath"

#include "Patmos.h"
#include "PatmosInstrInfo.h"
#include "PatmosMachineFunctionInfo.h"
#include "PatmosSubtarget.h"
#include "PatmosTargetMachine.h"
#include "llvm/Function.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/GraphTraits.h"
#include "llvm/ADT/DepthFirstIterator.h"
#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineDominators.h"
#include "llvm/CodeGen/MachineLoopInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineJumpTableInfo.h"
#include "llvm/CodeGen/MachinePostDominators.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/GraphWriter.h"
#include "llvm/Support/DOTGraphTraits.h"
#include "llvm/Support/raw_ostream.h"

#include "PatmosSinglePathInfo.h"

#include <map>
#include <sstream>
#include <iostream>


using namespace llvm;


// anonymous namespace
namespace {

  class PatmosSPReduce : public MachineFunctionPass {
  private:
    /// Pass ID
    static char ID;

    const PatmosTargetMachine &TM;
    const PatmosSubtarget &STC;
    const PatmosInstrInfo *TII;

    /// doReduceFunction - Reduce a given MachineFunction
    void doReduceFunction(MachineFunction &MF);

    /// insertPredDefinitions - Insert predicate register definitions
    void insertPredDefinitions(MachineFunction &MF);

    /// applyPredicates - Predicate instructions of MBBs
    void applyPredicates(MachineFunction &MF);

    /// insertInitializations - Insert initializations in headers
    void insertInitializations(MachineFunction &MF);

    /// mergeMBBs - Merge the linear sequence of MBBs as possible
    void mergeMBBs(MachineFunction &MF);

    /// getImm32FromBitvector - Returns an Imm32 mask for bits set in bv
    /// NB: for now, bv.size() <= 32
    uint32_t getImm32FromBitvector(BitVector bv) const;

    /// insertPredSet - Insert predicates set instruction
    void insertPredSet(MachineBasicBlock *MBB, MachineBasicBlock::iterator MI,
                       BitVector bits, SmallVector<MachineOperand, 4> &Cond);

    /// insertPredClr - Insert predicates clear instruction
    void insertPredClr(MachineBasicBlock *MBB, MachineBasicBlock::iterator MI,
                       BitVector bits);

    /// exractPReg - Extract the corect pred to PReg at the beginning of MBB
    void extractPReg(MachineBasicBlock *MBB, unsigned pred);

    // predicate registers
    /// AvailPredRegs - Predicate registers unused in the function,
    /// which are used for allocation here
    std::vector<unsigned> AvailPredRegs;
    unsigned GuardsReg; // RReg to hold all predicates
    unsigned PReg;      // current PReg
    unsigned PRTmp;     // temporary PReg

    // walker
    class LinearizeWalker : public SPNodeWalker {
      private:
        virtual void nextMBB(MachineBasicBlock *);
        virtual void enterSubnode(SPNode *);
        virtual void exitSubnode(SPNode *);
        PatmosSPReduce &Pass;
        MachineFunction &MF;

        MachineBasicBlock *LastMBB;
      public:
        explicit LinearizeWalker(PatmosSPReduce &pass, MachineFunction &mf)
          : Pass(pass), MF(mf), LastMBB(NULL) {}
    };

  public:
    /// PatmosSPReduce - Initialize with PatmosTargetMachine
    PatmosSPReduce(const PatmosTargetMachine &tm) :
      MachineFunctionPass(ID), TM(tm),
      STC(tm.getSubtarget<PatmosSubtarget>()),
        TII(static_cast<const PatmosInstrInfo*>(tm.getInstrInfo())) {}

    /// getPassName - Return the pass' name.
    virtual const char *getPassName() const {
      return "Patmos Single-Path Reducer";
    }

    /// getAnalysisUsage - Specify which passes this pass depends on
    virtual void getAnalysisUsage(AnalysisUsage &AU) const {
      AU.addRequired<PatmosSinglePathInfo>();
      MachineFunctionPass::getAnalysisUsage(AU);
    }


    /// runOnMachineFunction - Run the SP converter on the given function.
    virtual bool runOnMachineFunction(MachineFunction &MF) {
      PatmosSinglePathInfo &PSPI = getAnalysis<PatmosSinglePathInfo>();
      bool changed = false;
      // only convert function if specified on command line
      if ( PSPI.isToConvert(MF) ) {
        DEBUG( dbgs() << "[Single-Path] Reducing "
                      << MF.getFunction()->getName() << "\n" );
        doReduceFunction(MF);
        changed |= true;
      }
      return changed;
    }
  };

  char PatmosSPReduce::ID = 0;
} // end of anonymous namespace

///////////////////////////////////////////////////////////////////////////////

/// createPatmosSPReducePass - Returns a new PatmosSPReduce
/// \see PatmosSPReduce
FunctionPass *llvm::createPatmosSPReducePass(const PatmosTargetMachine &tm) {
  return new PatmosSPReduce(tm);
}

///////////////////////////////////////////////////////////////////////////////



void PatmosSPReduce::doReduceFunction(MachineFunction &MF) {

  PatmosSinglePathInfo &PSPI = getAnalysis<PatmosSinglePathInfo>();

  if (PSPI.getNumPredicates() > 32) {
    report_fatal_error("Cannot handle more than 32 Predicates yet!");
  }

  // Note: We are past tracking liveness (past BranchFolding) so we
  // cannot use RegScavenging
  MachineRegisterInfo &RegInfo = MF.getRegInfo();

  // Get the unused predicate registers
  for (TargetRegisterClass::iterator I=Patmos::PRegsRegClass.begin(),
      E=Patmos::PRegsRegClass.end(); I!=E; ++I ) {
    if (RegInfo.reg_empty(*I) && *I!=Patmos::P0) {
      AvailPredRegs.push_back(*I);
      DEBUG( dbgs() << "PReg " << PrintReg(*I,TM.getRegisterInfo())
                    << " available\n" );
    }
  }
  GuardsReg = Patmos::R26;
  PReg      = AvailPredRegs.back();
  PRTmp     = AvailPredRegs.front();



  // insert predicate definitions
  insertPredDefinitions(MF);


  DEBUG( dbgs() << "Linearize MBBs\n" );
  LinearizeWalker W(*this, MF);
  PSPI.walkRoot(W);

  applyPredicates(MF);

  insertInitializations(MF);

  mergeMBBs(MF);

  MF.RenumberBlocks();
}


void PatmosSPReduce::insertPredDefinitions(MachineFunction &MF) {
  DEBUG( dbgs() << "Insert Predicate Definitions\n" );

  PatmosSinglePathInfo &PSPI = getAnalysis<PatmosSinglePathInfo>();

  // For each MBB, check PSPI defs
  for (MachineFunction::iterator FI=MF.begin(); FI!=MF.end(); ++FI) {
    MachineBasicBlock *MBB = FI;
    BitVector bvT(PSPI.getPredDefsT(MBB)),
              bvF(PSPI.getPredDefsF(MBB));
    // check for definitions
    if (bvT.none() && bvF.none()) {
      continue;
    }

    DEBUG( dbgs() << " - MBB#" << MBB->getNumber() << "\n" );

    // get the branch condition
    MachineBasicBlock *TBB = NULL, *FBB = NULL;
    SmallVector<MachineOperand, 4> Cond;
    if (TII->AnalyzeBranch(*MBB, TBB, FBB, Cond) || Cond.empty()) {
      report_fatal_error("AnalyzeBranch failed");
    }

    // insert the predicate definitions before any branch at the MBB end
    MachineBasicBlock::iterator firstTI = MBB->getFirstTerminator();
    bool condKill = Cond[0].isKill(); // store kill flag
    Cond[0].setIsKill(false);

    // clear all preds that are going to be defined
    insertPredClr(MBB, firstTI, PSPI.getPredDefsBoth(MBB));

    // definitions for the T edge
    if (bvT.any()) {
      insertPredSet(MBB, firstTI, bvT, Cond);
    }
    // definitions for the F edge
    if (bvF.any()) {
      TII->ReverseBranchCondition(Cond);
      insertPredSet(MBB, firstTI, bvF, Cond);
    }
    // restore kill flag at the last use
    prior(firstTI)->findRegisterUseOperand(Cond[0].getReg())
                  ->setIsKill(condKill);

  } // end for each MBB
}



void PatmosSPReduce::applyPredicates(MachineFunction &MF) {
  DEBUG( dbgs() << "Applying predicates to MBBs\n" );

  PatmosSinglePathInfo &PSPI = getAnalysis<PatmosSinglePathInfo>();

  // for each MBB
  for (MachineFunction::iterator FI=MF.begin(); FI!=MF.end(); ++FI) {
    MachineBasicBlock *MBB = FI;

    int pred = PSPI.getPredUse(MBB);
    // check for use predicate
    // TODO avoid hardcoding of p0
    if (pred <= 0) {
      DEBUG_TRACE( dbgs() << "  skip: no guard for MBB#" << MBB->getNumber()
                    << "\n" );
      continue;
    }

    DEBUG_TRACE( dbgs() << "  applying pred #" << pred << " to MBB#"
                  << MBB->getNumber() << "\n" );

    // apply predicate to all instructions in block
    for( MachineBasicBlock::iterator MI = MBB->begin(), ME = MBB->end();
                                                          MI != ME; ++MI) {
      assert(!MI->isBundle() &&
             "PatmosInstrInfo::PredicateInstruction() can't handle bundles");

      // check for terminators - return? //TODO
      if (MI->isReturn()) {
          DEBUG_TRACE( dbgs() << "    skip return: " << *MI );
          continue;
      }
      // TODO properly handle calls

      if (MI->isPredicable()) {
        if (!TII->isPredicated(MI)) {
          // find first predicate operand
          int i = MI->findFirstPredOperandIdx();
          assert(i != -1);
          MachineOperand &PO1 = MI->getOperand(i);
          MachineOperand &PO2 = MI->getOperand(i+1);
          assert(PO1.isReg() && PO2.isImm() &&
                 "Unexpected Patmos predicate operand");
          PO1.setReg(PReg); // FIXME better, no hardcoded allocation
          PO2.setImm(0);
        } else {
          //TODO handle already predicated instructions better?
          DEBUG_TRACE( dbgs() << "    in MBB#" << MBB->getNumber()
                        << ": instruction already predicated: " << *MI );
          // read out the predicate
          int i = MI->findFirstPredOperandIdx();
          assert(i != -1);
          MachineOperand &PO1 = MI->getOperand(i);
          MachineOperand &PO2 = MI->getOperand(i+1);
          // build a new predicate := Preg & old pred
          AddDefaultPred(BuildMI(*MBB, MI, MI->getDebugLoc(),
                              TII->get(Patmos::PAND), PRTmp))
                .addReg(PReg).addImm(0)
                .addOperand(PO1).addOperand(PO2);
          PO1.setReg(PRTmp); // FIXME
          PO2.setImm(0);
        }
      }
    } // for each instruction in MBB

    // extract PReg (unconditionally)
    extractPReg(MBB, pred);

  } // end for each MBB
}



void PatmosSPReduce::insertInitializations(MachineFunction &MF) {
  DEBUG( dbgs() << "Insert Initializations\n" );

  PatmosSinglePathInfo &PSPI = getAnalysis<PatmosSinglePathInfo>();
  //MachineRegisterInfo &RegInfo = MF.getRegInfo();

  SPNode *root = PSPI.getRootNode();

  // for all (sub-)SPNodes
  for (df_iterator<SPNode*> I = df_begin(root), E = df_end(root); I!=E; ++I) {
    SPNode *N = *I;
    MachineBasicBlock *Header = N->getHeader();

    DEBUG( dbgs() << "- [MBB#" << Header->getNumber() << "]\n");
    // for the top level, we don't need to insert a new block
    if (N->isTopLevel()) {
      // find first def/use of GuardsReg
      MachineBasicBlock::iterator MI = Header->begin(),
                                  ME = Header->end();
      while ( !MI->definesRegister(GuardsReg) && MI!=ME ) ++MI;
      // Initialize Top-level: set all predicates of entry edge to true
      uint32_t imm = getImm32FromBitvector(PSPI.getPredEntryEdge());
      AddDefaultPred(BuildMI(*Header, MI, MI->getDebugLoc(),
            TII->get( (isUInt<12>(imm))? Patmos::LIi : Patmos::LIl),
            GuardsReg)).addImm(imm);
    } else {
      // insert initialization at top of header
      MachineBasicBlock::iterator MI = Header->begin();
      insertPredClr(Header, MI, PSPI.getInitializees(N));
    }
  }

}



void PatmosSPReduce::mergeMBBs(MachineFunction &MF) {
  DEBUG( dbgs() << "Merge MBBs\n" );

  // first, obtain the sequence of MBBs in DF order
  std::vector<MachineBasicBlock*> order(df_begin(&MF.front()),
                                        df_end(  &MF.front()));


  std::vector<MachineBasicBlock*>::iterator I = order.begin(),
                                            E = order.end();

  MachineBasicBlock *BaseMBB = *I;
  DEBUG_TRACE( dbgs() << "Base MBB#" << BaseMBB->getNumber() << "\n" );
  // iterate through order of MBBs
  while (++I != E) {
    // get MBB of iterator
    MachineBasicBlock *MBB = *I;

    if (MBB->pred_size() == 1) {
      DEBUG_TRACE( dbgs() << "  Merge MBB#" << MBB->getNumber() << "\n" );
      // transfer the instructions
      BaseMBB->splice(BaseMBB->end(), MBB, MBB->begin(), MBB->end());
      // remove the edge between BaseMBB and MBB
      BaseMBB->removeSuccessor(MBB);
      // BaseMBB gets the successors of MBB instead
      BaseMBB->transferSuccessors(MBB);
      // remove MBB from MachineFunction
      MF.erase(MBB);

      if (BaseMBB->succ_size() > 1) {
        // we have encountered a backedge
        BaseMBB = *(++I);
        DEBUG_TRACE( dbgs() << "Base MBB#" << BaseMBB->getNumber() << "\n" );
      }
    } else {
      BaseMBB = MBB;
      DEBUG_TRACE( dbgs() << "Base MBB#" << BaseMBB->getNumber() << "\n" );
    }
  }
  // invalidate order
  order.clear();
}

uint32_t PatmosSPReduce::getImm32FromBitvector(BitVector bv) const {
  assert( bv.size() <= 32);
  uint32_t res = 0;
  for (unsigned i=0; i<bv.size() && i<32; i++) {
    if (bv.test(i)) {
      res |= (1 << i);
    }
  }
  return res;
}


void PatmosSPReduce::insertPredSet(MachineBasicBlock *MBB,
                                   MachineBasicBlock::iterator MI,
                                   BitVector bits,
                                   SmallVector<MachineOperand, 4> &Cond) {

  uint32_t imm = getImm32FromBitvector(bits);
  DebugLoc DL(MI->getDebugLoc());
  // (cond) OR $Guards, $Guards, bitmask
  // i.e., if (cond) Guards |= bitmask
  BuildMI(*MBB, MI, DL,
      TII->get( (isUInt<12>(imm))? Patmos::ORi : Patmos::ORl),
      GuardsReg)
    .addOperand(Cond[0]).addOperand(Cond[1])
    .addReg(GuardsReg)
    .addImm(imm);
}

void PatmosSPReduce::insertPredClr(MachineBasicBlock *MBB,
                                   MachineBasicBlock::iterator MI,
                                   BitVector bits) {
  uint32_t imm = getImm32FromBitvector(bits);
  AddDefaultPred(BuildMI(*MBB, MI, MI->getDebugLoc(),
        TII->get(Patmos::ANDl), GuardsReg))
    .addReg(GuardsReg).addImm(~imm); // bitwise negated imm
}

void PatmosSPReduce::extractPReg(MachineBasicBlock *MBB, unsigned pred) {
  DebugLoc DL;
  MachineBasicBlock::iterator MI = MBB->begin();
  // LI $rtr, pred
  AddDefaultPred(BuildMI(*MBB, MI, DL, TII->get(Patmos::LIi),
    Patmos::RTR)).addImm(pred);
  // BTEST $Guards, $rtr
  AddDefaultPred(BuildMI(*MBB, MI, DL, TII->get(Patmos::BTEST),
    PReg)).addReg(GuardsReg).addReg(Patmos::RTR);
}


///////////////////////////////////////////////////////////////////////////////

void PatmosSPReduce::LinearizeWalker::nextMBB(MachineBasicBlock *MBB) {
  DEBUG_TRACE( dbgs() << "| MBB#" << MBB->getNumber() << "\n" );

  // remove all successors
  for ( MachineBasicBlock::succ_iterator SI = MBB->succ_begin();
        SI != MBB->succ_end();
        SI = MBB->removeSuccessor(SI) )
        ; // no body
    Pass.TII->RemoveBranch(*MBB);

  if (LastMBB) {
    // add to the last MBB as successor
    LastMBB->addSuccessor(MBB);
    // Correct the layout and remove the branch instructions
    MBB->moveAfter(LastMBB);
  }
  // move forward
  LastMBB = MBB;
}


void PatmosSPReduce::LinearizeWalker::enterSubnode(SPNode *N) {
  if (N->hasLoopBound()) {
    // insert loop preheader to load loop bound
    MachineBasicBlock *PrehdrMBB = MF.CreateMachineBasicBlock();
    MF.push_back(PrehdrMBB);
    DebugLoc DL;
    //FIXME load the actual loop bound
    AddDefaultPred(BuildMI(*PrehdrMBB, PrehdrMBB->begin(), DL,
      Pass.TII->get(Patmos::LIi),
      Patmos::RTR)).addImm(1000);
    nextMBB(PrehdrMBB);
  }
}


void PatmosSPReduce::LinearizeWalker::exitSubnode(SPNode *N) {

  PatmosSinglePathInfo &PSPI = Pass.getAnalysis<PatmosSinglePathInfo>();

  MachineBasicBlock *Header = N->getHeader();
  DEBUG_TRACE( dbgs() << "NodeRange [MBB#" <<  N->getHeader()->getNumber()
                <<  ", MBB#" <<  LastMBB->getNumber() << "]\n" );

  if (N->isTopLevel()) return;

  // insert backwards branch to header at the last block
  // TODO loop iteration counts
  MachineBasicBlock *BranchMBB = MF.CreateMachineBasicBlock();
  MF.push_back(BranchMBB);
  // weave in
  nextMBB(BranchMBB);

  // fill it
  DebugLoc DL;
  // extract the header predicate
  Pass.extractPReg(BranchMBB, PSPI.getPredUse(Header));
  // insert branch
  BuildMI(*BranchMBB, BranchMBB->end(), DL, Pass.TII->get(Patmos::BR))
    .addReg(Pass.PReg).addImm(0)
    .addMBB(Header);
  BranchMBB->addSuccessor(Header);
}


///////////////////////////////////////////////////////////////////////////////

