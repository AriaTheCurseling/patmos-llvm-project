//======-- PatmosFrameLowering.cpp - Patmos Frame Information -------=========//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the Patmos implementation of TargetFrameLowering class.
//
//===----------------------------------------------------------------------===//

#define DEBUG_TYPE "patmos-framelowering"
#include "PatmosFrameLowering.h"
#include "PatmosInstrInfo.h"
#include "PatmosMachineFunctionInfo.h"
#include "PatmosSubtarget.h"
#include "PatmosTargetMachine.h"
#include "llvm/Function.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/DataLayout.h"
#include "llvm/Target/TargetOptions.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"

using namespace llvm;

/// EnableStackCache - Command line option to disable the usage of the stack 
/// cache (enabled by default).
static cl::opt<bool> DisableStackCache("mpatmos-disable-stack-cache",
                            cl::init(false),
                            cl::desc("Disable the use of Patmos' stack cache"));


PatmosFrameLowering::PatmosFrameLowering(const PatmosTargetMachine &tm)
: TargetFrameLowering(TargetFrameLowering::StackGrowsDown, 4, 0), TM(tm),
  STC(tm.getSubtarget<PatmosSubtarget>())
{
}



bool PatmosFrameLowering::hasFP(const MachineFunction &MF) const {
  const MachineFrameInfo *MFI = MF.getFrameInfo();

  return (MF.getTarget().Options.DisableFramePointerElim(MF) ||
          MF.getFrameInfo()->hasVarSizedObjects() ||
          MFI->isFrameAddressTaken());
}

#if 0
bool PatmosFrameLowering::hasReservedCallFrame(const MachineFunction &MF) const {
  return !MF.getFrameInfo()->hasVarSizedObjects();
}
#endif

unsigned PatmosFrameLowering::assignFIsToStackCache(MachineFunction &MF) const {
  MachineFrameInfo &MFI = *MF.getFrameInfo();
  PatmosMachineFunctionInfo &PMFI = *MF.getInfo<PatmosMachineFunctionInfo>();
  const std::vector<CalleeSavedInfo> &CSI = MFI.getCalleeSavedInfo();
  unsigned maxFrameSize = MFI.getMaxCallFrameSize();

  assert(MFI.isCalleeSavedInfoValid());

  // find all FIs used for callee saved registers
  BitVector SCFIs(MFI.getObjectIndexEnd());
  for(std::vector<CalleeSavedInfo>::const_iterator i(CSI.begin()),
      ie(CSI.end()); i != ie; i++)
  {
    SCFIs[i->getFrameIdx()] = true;
  }

  // find all FIs that are spill slots
  for(unsigned FI = 0, FIe = MFI.getObjectIndexEnd(); FI != FIe; FI++) {
    if (MFI.isDeadObjectIndex(FI))
      continue;

    // find all spill slots and locations for callee saved registers
    if (MFI.isSpillSlotObjectIndex(FI))
      SCFIs[FI] = true;
  }

  // assign new offsets to FIs
  unsigned int SCOffset = 0;            // next stack slot in stack cache
  unsigned int SSOffset = maxFrameSize; // next stack slot on the shadow stack
  DEBUG(dbgs() << "PatmosSC: " << MF.getFunction()->getName() << "\n");
  DEBUG(MFI.print(MF, dbgs()));
  for(unsigned FI = 0, FIe = MFI.getObjectIndexEnd(); FI != FIe; FI++) {
    if (MFI.isDeadObjectIndex(FI))
      continue;

    unsigned FIalignment = MFI.getObjectAlignment(FI);
    unsigned FIsize = MFI.getObjectSize(FI); //XXX DP: shouldn't this be int64_t ?
    int FIoffset = MFI.getObjectOffset(FI);

    // XXX DP: can this ever happen? Apart from the condition,
    // FIsize==~0ULL => MFI.isDeadObjectIndex(FI)
    // and we shouldn't have come here anyways.
    if (FIsize == ~0U && FIsize == 0) {
      assert(false && "impossible?!");
      continue;
    }

    // be sure to catch some special stack objects not expected for Patmos
    assert(!MFI.isFixedObjectIndex(FI) && !MFI.isObjectPreAllocated(FI));

    // assigned to stack cache or shadow stack?
    if (SCFIs[FI]) {
      // alignment
      SCOffset = ((SCOffset + FIalignment - 1) / FIalignment) * FIalignment;

      DEBUG(dbgs() << "PatmosSC: FI: " << FI << " on SC: " << SCOffset
                   << "(" << FIoffset << ")\n");

      // reassign stack offset
      MFI.setObjectOffset(FI, SCOffset);

      // reserve space on the stack cache
      SCOffset += FIsize;
    }
    else {
      // alignment
      SSOffset = ((SSOffset + FIalignment - 1) / FIalignment) * FIalignment;

      DEBUG(dbgs() << "PatmosSC: FI: " << FI << " on SS: " << SSOffset
                   << "(" << FIoffset << ")\n");

      // reassign stack offset
      MFI.setObjectOffset(FI, SSOffset);

      // reserve space on the shadow stack
      SSOffset += FIsize;
    }
  }

  // align stack frame on stack cache
  unsigned stackCacheSize = ((SCOffset + STC.getStackCacheBlockSize() - 1) /
                   STC.getStackCacheBlockSize()) * STC.getStackCacheBlockSize();

  // align shadow stack. call arguments are already included in SSOffset
  unsigned stackSize = ((SSOffset + getStackAlignment() - 1) /
                        getStackAlignment()) * getStackAlignment();

  // update offset of fixed objects
  for(unsigned FI = MFI.getObjectIndexBegin(), FIe = 0; FI != FIe; FI++) {
    // reassign stack offset
    MFI.setObjectOffset(FI, MFI.getObjectOffset(FI) + stackSize);
  }

  DEBUG(MFI.print(MF, dbgs()));

  // store assignment information
  PMFI.setStackCacheReservedBytes(stackCacheSize);
  PMFI.setStackCacheFIs(SCFIs);

  PMFI.setStackReservedBytes(stackSize);
  MFI.setStackSize(stackSize);

  return stackSize;
}

void PatmosFrameLowering::emitSTC(MachineFunction &MF, MachineBasicBlock &MBB,
                                  MachineBasicBlock::iterator &MI,
                                  unsigned Opcode) const {
  PatmosMachineFunctionInfo &PMFI = *MF.getInfo<PatmosMachineFunctionInfo>();

  // align the stack cache size
  unsigned alignedStackCacheSize =
                             std::ceil((float)PMFI.getStackCacheReservedBytes()/
                                       (float)STC.getStackCacheBlockSize());

  if (alignedStackCacheSize)
  {
    assert(isUInt<22>(alignedStackCacheSize) && "Stack cache size exceeded.");

    DebugLoc DL                      = (MI != MBB.end()) ? MI->getDebugLoc()
                                                                   : DebugLoc();
    const TargetInstrInfo &TII       = *TM.getInstrInfo();

    // emit reserve instruction
    AddDefaultPred(BuildMI(MBB, MI, DL, TII.get(Opcode)))
      .addImm(alignedStackCacheSize);
  }
}

void PatmosFrameLowering::patchCallSites(MachineFunction &MF) const {
  // visit all basic blocks
  for (MachineFunction::iterator i(MF.begin()), ie(MF.end()); i != ie; ++i) {
    for (MachineBasicBlock::iterator j(i->begin()), je=(i->end()); j != je;
         j++) {
      // a call site?
      if (j->isCall()) {
        MachineBasicBlock::iterator p(next(j));
        emitSTC(MF, *i, p, Patmos::SENS);
      }
    }
  }
}
void PatmosFrameLowering::emitPrologue(MachineFunction &MF) const {
  // get some references
  MachineBasicBlock &MBB     = MF.front();
  MachineFrameInfo *MFI      = MF.getFrameInfo();
  const TargetInstrInfo *TII = TM.getInstrInfo();

  MachineBasicBlock::iterator MBBI = MBB.begin();
  DebugLoc dl = MBBI != MBB.end() ? MBBI->getDebugLoc() : DebugLoc();

  //----------------------------------------------------------------------------
  // Handle the stack cache -- if enabled.

  if (MFI->getMaxAlignment() > 4) {
    dbgs() << "Stack alignment ";
    if (MF.getFunction()) dbgs() << "in " << MF.getFunction()->getName() << " ";
    dbgs() << "too large (" << MFI->getMaxAlignment() << ").\n";

    report_fatal_error("Stack alignment other than 4 byte is not supported");
  }

  // assign some FIs to the stack cache if possible
  unsigned stackSize = 0;
  unsigned maxFrameSize = MFI->getMaxCallFrameSize();
  if (!DisableStackCache) {
    // assign some FIs to the stack cache
    stackSize = assignFIsToStackCache(MF);

    // emit a reserve instruction
    emitSTC(MF, MBB, MBBI, Patmos::SRES);

    // patch all call sites
    patchCallSites(MF);
  }
  else {
    // First, compute final stack size.
    stackSize = MFI->getStackSize() + (!hasFP(MF) ? 0 : maxFrameSize);
    MFI->setStackSize(stackSize);
  }

  //----------------------------------------------------------------------------
  // Handle the shadow stack


  // Do we need to allocate space on the stack?
  if (stackSize) {
    // adjust stack : sp -= stack size
    if (stackSize <= 0xFFF) {
      AddDefaultPred(BuildMI(MBB, MBBI, dl, TII->get(Patmos::SUBi), Patmos::RSP))
        .addReg(Patmos::RSP).addImm(stackSize);
    }
    else {
      AddDefaultPred(BuildMI(MBB, MBBI, dl, TII->get(Patmos::SUBl), Patmos::RSP))
        .addReg(Patmos::RSP).addImm(stackSize);
    }
  }

  // eliminate DYNALLOC instruction (aka. alloca)
  const MCInstrDesc &dynallocMCID = (maxFrameSize <= 0xFFF) ?
                                TII->get(Patmos::SUBi) : TII->get(Patmos::SUBl);

  for (MachineFunction::iterator BB(MF.begin()), E(MF.end()); BB != E; ++BB) {
    for (MachineBasicBlock::iterator MI(BB->begin()), MIE(BB->end()); MI != MIE;
         MI++) {
      // found a DYNALLOC instruction?
      if (MI->getOpcode() == Patmos::DYNALLOC) {
        // rewrite it to a sub immediate/sub immediate long
        MI->getOperand(4).setImm(maxFrameSize);
        MI->setDesc(dynallocMCID);
      }
    }
  }
}

void PatmosFrameLowering::emitEpilogue(MachineFunction &MF,
                                       MachineBasicBlock &MBB) const {
  MachineBasicBlock::iterator MBBI = MBB.getLastNonDebugInstr();
  MachineFrameInfo *MFI            = MF.getFrameInfo();
  const TargetInstrInfo *TII       = TM.getInstrInfo();
  DebugLoc dl                      = MBBI->getDebugLoc();

  //----------------------------------------------------------------------------
  // Handle Stack Cache

  // emit a free instruction
  emitSTC(MF, MBB, MBBI, Patmos::SFREE);

  //----------------------------------------------------------------------------
  // Handle Shadow Stack

  // Get the number of bytes from FrameInfo
  unsigned stackSize = MFI->getStackSize();

  // adjust stack  : sp += stack size
  if (stackSize) {
    if (stackSize <= 0xFFF) {
      AddDefaultPred(BuildMI(MBB, MBBI, dl, TII->get(Patmos::ADDi),
                             Patmos::RSP))
        .addReg(Patmos::RSP).addImm(stackSize);
    }
    else {
      AddDefaultPred(BuildMI(MBB, MBBI, dl, TII->get(Patmos::ADDl),
                             Patmos::RSP))
        .addReg(Patmos::RSP).addImm(stackSize);
    }
  }
}

void PatmosFrameLowering::processFunctionBeforeCalleeSavedScan(
                                  MachineFunction& MF, RegScavenger* RS) const {

  const TargetInstrInfo *TII = TM.getInstrInfo();
  MachineRegisterInfo& MRI = MF.getRegInfo();

  // Insert instructions at the beginning of the entry block;
  // callee-saved-reg spills are inserted at front afterwards
  MachineBasicBlock &EntryMBB = MF.front();

  DebugLoc DL;
  MachineBasicBlock *NBB = &EntryMBB;
  while (NBB) {
    if (!NBB->empty()) {
      DL = NBB->front().getDebugLoc();
      break;
    }
    NBB = NBB->getNextNode();
  }

  if (hasFP(MF)) {
    // if framepointer enabled, set it to point to the stack pointer.
    // Set frame pointer: FP = SP
    AddDefaultPred(BuildMI(EntryMBB, EntryMBB.begin(), DL, TII->get(Patmos::MOV), Patmos::RFP))
      .addReg(Patmos::RSP);
    // Mark RFP as used
    MRI.setPhysRegUsed(Patmos::RFP);
  }

  // load the current function base if it needs to be passed to call sites
  if (MF.getFrameInfo()->hasCalls()) {
    // load long immediate: current function symbol into RFB
    AddDefaultPred(BuildMI(EntryMBB, EntryMBB.begin(), DL, TII->get(Patmos::LIl), Patmos::RFB))
      .addGlobalAddress(MF.getFunction());
    // Mark the special registers of the method cache to be used when calls exist.
    MRI.setPhysRegUsed(Patmos::RFB);
    MRI.setPhysRegUsed(Patmos::RFO);
  } else {
    MRI.setPhysRegUnused(Patmos::RFB);
    MRI.setPhysRegUnused(Patmos::RFO);
  }
}

bool
PatmosFrameLowering::spillCalleeSavedRegisters(MachineBasicBlock &MBB,
                                        MachineBasicBlock::iterator MI,
                                        const std::vector<CalleeSavedInfo> &CSI,
                                        const TargetRegisterInfo *TRI) const {
  if (CSI.empty())
    return false;

  DebugLoc DL;
  if (MI != MBB.end()) DL = MI->getDebugLoc();

  const TargetInstrInfo &TII = *TM.getInstrInfo();

  unsigned spilledSize = 0;
  for (unsigned i = CSI.size(); i != 0; --i) {
    unsigned Reg = CSI[i-1].getReg();
    // Add the callee-saved register as live-in. It's killed at the spill.
    MBB.addLiveIn(Reg);

    // as all PRegs are aliased with SZ, a spill of a Preg will cause
    // a spill of SZ
    if (Patmos::PRegsRegClass.contains(Reg))
      continue;
    // copy to R register first, then spill
    if (Patmos::SRegsRegClass.contains(Reg)) {
      TII.copyPhysReg(MBB, MI, DL, Patmos::R9, Reg, true);
      Reg = Patmos::R9;
    }

    // spill
    const TargetRegisterClass *RC = TRI->getMinimalPhysRegClass(Reg);
    TII.storeRegToStackSlot(MBB, MI, Reg, true, CSI[i-1].getFrameIdx(), RC, TRI);
    prior(MI)->setFlag(MachineInstr::FrameSetup);

    // increment spilled size
    spilledSize += 4;
  }

  return true;
}

bool
PatmosFrameLowering::restoreCalleeSavedRegisters(MachineBasicBlock &MBB,
                                        MachineBasicBlock::iterator MI,
                                        const std::vector<CalleeSavedInfo> &CSI,
                                        const TargetRegisterInfo *TRI) const {
  if (CSI.empty())
    return false;

  DebugLoc DL;
  if (MI != MBB.end()) DL = MI->getDebugLoc();

  MachineFunction &MF = *MBB.getParent();
  const TargetInstrInfo &TII = *TM.getInstrInfo();

  // if framepointer enabled, first restore the stack pointer.
  if (hasFP(MF)) {
    // Restore stack pointer: SP = FP
    AddDefaultPred(BuildMI(MBB, MI, DL, TII.get(Patmos::MOV), Patmos::RSP))
      .addReg(Patmos::RFP);
  }

  // restore the calle saved register
  for (unsigned i = CSI.size(); i != 0; --i) {
    unsigned Reg = CSI[i-1].getReg();
    unsigned tmpReg = Reg;
    // Add the callee-saved register as live-in. It's killed at the spill.
    MBB.addLiveIn(Reg);

    // SZ is aliased with PRegs
    if (Patmos::PRegsRegClass.contains(Reg))
        continue;

    // copy to special register after reloading
    if (Patmos::SRegsRegClass.contains(Reg))
      tmpReg = Patmos::R9;

    // load
    const TargetRegisterClass *RC = TRI->getMinimalPhysRegClass(tmpReg);
    TII.loadRegFromStackSlot(MBB, MI, tmpReg, CSI[i-1].getFrameIdx(), RC, TRI);
    prior(MI)->setFlag(MachineInstr::FrameSetup);

    // copy, if needed
    if (tmpReg != Reg)
    {
      TII.copyPhysReg(MBB, MI, DL, Reg, tmpReg, true);
    }
  }

  return true;
}
