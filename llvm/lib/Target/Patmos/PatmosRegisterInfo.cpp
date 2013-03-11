//===- PatmosRegisterInfo.cpp - Patmos Register Information ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the Patmos implementation of the TargetRegisterInfo class.
//
//===----------------------------------------------------------------------===//

#define DEBUG_TYPE "patmos-reg-info"

#include "Patmos.h"
#include "PatmosMachineFunctionInfo.h"
#include "PatmosRegisterInfo.h"
#include "PatmosTargetMachine.h"
#include "llvm/Function.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Target/TargetOptions.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/Support/ErrorHandling.h"

#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

#define GET_REGINFO_TARGET_DESC
#include "PatmosGenRegisterInfo.inc"

using namespace llvm;

// FIXME: Provide proper call frame setup / destroy opcodes.
PatmosRegisterInfo::PatmosRegisterInfo(PatmosTargetMachine &tm,
                                       const TargetInstrInfo &tii)
  : PatmosGenRegisterInfo(Patmos::R1), TM(tm), TII(tii) {
  StackAlign = TM.getFrameLowering()->getStackAlignment();
}

const uint16_t*
PatmosRegisterInfo::getCalleeSavedRegs(const MachineFunction *MF) const {
  const TargetFrameLowering *TFI = TM.getFrameLowering();
  //const Function* F = MF->getFunction();
  static const uint16_t CalleeSavedRegs[] = {
    // Special regs
    Patmos::SZ,
    // GPR
    Patmos::R21, Patmos::R22, Patmos::R23, Patmos::R24,
    Patmos::R25, Patmos::R26,
    // return info
    Patmos::RFB, Patmos::RFO,
    // Predicate regs
    Patmos::P1, Patmos::P2, Patmos::P3, Patmos::P4,
    Patmos::P5, Patmos::P6, Patmos::P7,
    0
  };
  static const uint16_t CalleeSavedRegsFP[] = {
    // Special regs
    Patmos::SZ,
    // GPR
    Patmos::R21, Patmos::R22, Patmos::R23, Patmos::R24,
    Patmos::R25, Patmos::R26,
    Patmos::RFP,
    // return info
    Patmos::RFB, Patmos::RFO,
    // Predicate regs
    Patmos::P1, Patmos::P2, Patmos::P3, Patmos::P4,
    Patmos::P5, Patmos::P6, Patmos::P7,
    0
  };

  return (TFI->hasFP(*MF)) ? CalleeSavedRegsFP : CalleeSavedRegs;
}

BitVector PatmosRegisterInfo::getReservedRegs(const MachineFunction &MF) const {
  BitVector Reserved(getNumRegs());
  const TargetFrameLowering *TFI = TM.getFrameLowering();

  Reserved.set(Patmos::R0);
  Reserved.set(Patmos::P0);

  // All the special registers are reserved
  Reserved.set(Patmos::SZ);
  Reserved.set(Patmos::SM);
  Reserved.set(Patmos::SL);
  Reserved.set(Patmos::SH);
  Reserved.set(Patmos::S4);
  Reserved.set(Patmos::S5);
  Reserved.set(Patmos::ST);
  Reserved.set(Patmos::S7);
  Reserved.set(Patmos::S8);
  Reserved.set(Patmos::S9);
  Reserved.set(Patmos::S10);
  Reserved.set(Patmos::S11);
  Reserved.set(Patmos::S12);
  Reserved.set(Patmos::S13);
  Reserved.set(Patmos::S14);
  Reserved.set(Patmos::S15);

  // stack pointer
  Reserved.set(Patmos::RSP);
  // frame pointer
  Reserved.set(Patmos::RFP);
  // reserved temp register
  Reserved.set(Patmos::RTR);
  // return regisers
  Reserved.set(Patmos::RFB);
  Reserved.set(Patmos::RFO);
  // Mark frame pointer as reserved if needed.
  if (TFI->hasFP(MF))
    Reserved.set(Patmos::RFP);

#if 0
  Reserved.set(Patmos::P4);
  Reserved.set(Patmos::P5);
  Reserved.set(Patmos::P6);
  Reserved.set(Patmos::P7);
#endif

  return Reserved;
}

#if 0
const TargetRegisterClass *
PatmosRegisterInfo::getPointerRegClass(unsigned Kind) const {
  return &Patmos::GR16RegClass;
}
#endif

void PatmosRegisterInfo::
eliminateCallFramePseudoInstr(MachineFunction &MF, MachineBasicBlock &MBB,
                              MachineBasicBlock::iterator I) const {
  // We need to adjust the stack pointer here (and not in the prologue) to
  // handle alloca instructions that modify the stack pointer before ADJ*
  // instructions. We only need to do that if we need a frame pointer, otherwise
  // we reserve size for the call stack frame in FrameLowering in the prologue.
  if (TM.getFrameLowering()->hasFP(MF)) {
    MachineInstr &MI = *I;
    DebugLoc dl = MI.getDebugLoc();
    int Size = MI.getOperand(0).getImm();
    unsigned Opcode;
    if (MI.getOpcode() == Patmos::ADJCALLSTACKDOWN) {
      Opcode = (Size <= 0xFFF) ? Patmos::SUBi : Patmos::SUBl;
    }
    else if (MI.getOpcode() == Patmos::ADJCALLSTACKUP) {
      Opcode = (Size <= 0xFFF) ? Patmos::ADDi : Patmos::ADDl;
    }
    else {
        llvm_unreachable("Unsupported pseudo instruction.");
    }
    if (Size)
      AddDefaultPred(BuildMI(MBB, I, dl, TII.get(Opcode), Patmos::RSP))
                                                  .addReg(Patmos::RSP)
                                                  .addImm(Size);
  }
  // erase the pseudo instruction
  MBB.erase(I);
}



void
PatmosRegisterInfo::computeLargeFIOffset(MachineRegisterInfo &MRI,
                                         int &offset, unsigned &basePtr,
                                         MachineBasicBlock::iterator II,
                                         int shl) const {
  MachineBasicBlock &MBB = *II->getParent();
  DebugLoc DL            = II->getDebugLoc();

  assert(offset >= 0);

  // get offset
  unsigned offsetLeft = 63; // -64 for offsets < 0
  unsigned offsetLarge = offset - offsetLeft;
  unsigned opcode = isUInt<12>(offsetLarge << shl) ? Patmos::ADDi :
                                                     Patmos::ADDl;

  // emit instruction
  //unsigned scratchReg = MRI.createVirtualRegister(&Patmos::RRegsRegClass);
  unsigned scratchReg = Patmos::RTR;
  AddDefaultPred(BuildMI(MBB, II, DL, TII.get(opcode), scratchReg))
    .addReg(basePtr).addImm(offsetLarge << shl);

  // return value
  basePtr = scratchReg;
  offset  = offsetLeft;
}




void
PatmosRegisterInfo::expandPseudoPregInstr(MachineBasicBlock::iterator II,
                                          int offset, unsigned basePtr,
                                          bool isOnStackCache) const {
  MachineInstr &PseudoMI = *II;
  MachineBasicBlock &MBB = *PseudoMI.getParent();
  DebugLoc DL            = PseudoMI.getDebugLoc();

  switch (PseudoMI.getOpcode())
  {
    case Patmos::PSEUDO_PREG_SPILL:
      {
        unsigned st_opc = (isOnStackCache) ? Patmos::SBS : Patmos::SBC;
        MachineOperand SrcRegOpnd = PseudoMI.getOperand(2);
        // spilling predicate values is sort of hackish:
        //   we implement it as a predicated store of a non-zero value
        //   followed by a predicated (inverted) store of 0
        BuildMI(MBB, II, DL, TII.get(st_opc))
          .addReg(SrcRegOpnd.getReg()).addImm(0) // predicate
          .addReg(basePtr, false).addImm(offset) // address
          .addReg(Patmos::RSP); // a non-zero value, i.e. RSP
        BuildMI(MBB, II, DL, TII.get(st_opc))
          .addOperand(SrcRegOpnd).addImm(1) // predicate, inverted
          .addReg(basePtr, false).addImm(offset) // address
          .addReg(Patmos::R0); // zero
      }
      break;


    case Patmos::PSEUDO_PREG_RELOAD:
      {
        unsigned ld_opc = (isOnStackCache) ? Patmos::LBS : Patmos::LBC;
        unsigned DestReg = PseudoMI.getOperand(0).getReg();

        AddDefaultPred(BuildMI(MBB, II, DL, TII.get(ld_opc), Patmos::RTR))
          .addReg(basePtr, false).addImm(offset); // address
        AddDefaultPred(BuildMI(MBB, II, DL, TII.get(Patmos::MOVrp), DestReg))
          .addReg(Patmos::RTR); // mov p <- r
      }
      break;

    default:
      llvm_unreachable("Unexpected MI in expandPseudoPregInstr()!");

  }

  DEBUG( dbgs() << "Pseudo PREG instruction expanded: " << PseudoMI );

  // remove the pseudo instruction
  MBB.erase(&PseudoMI);
}


void
PatmosRegisterInfo::eliminateFrameIndex(MachineBasicBlock::iterator II,
                                        int SPAdj, RegScavenger *RS) const {
  assert(SPAdj == 0 && "Unexpected");

  // get some references
  MachineInstr &MI                = *II;
  MachineBasicBlock &MBB          = *MI.getParent();
  MachineFunction &MF             = *MBB.getParent();
  const TargetFrameLowering &TFI  = *TM.getFrameLowering();
  const MachineFrameInfo &MFI     = *MF.getFrameInfo();
  PatmosMachineFunctionInfo &PMFI = *MF.getInfo<PatmosMachineFunctionInfo>();
  MachineRegisterInfo &MRI        = MF.getRegInfo();

  bool computedLargeOffset = false;

  //----------------------------------------------------------------------------
  // find position of the FrameIndex object

  unsigned i = 0;
  while (!MI.getOperand(i).isFI()) {
    ++i;
  }
  assert(i+1 < MI.getNumOperands() && "Instr doesn't have valid FrameIndex/Offset operands!");

  // TODO: check for correctness of position
  // expect FrameIndex to be on second position for load/store operations
  //assert(i == 2 || i == 3);

  //----------------------------------------------------------------------------
  // Stack Object / Frame Index

  int FrameIndex        = MI.getOperand(i).getIndex();
  int FrameOffset       = MFI.getObjectOffset(FrameIndex);
  int FrameDisplacement = MI.getOperand(i+1).getImm();

  //----------------------------------------------------------------------------
  // Stack cache info

  const BitVector &SCFIs = PMFI.getStackCacheFIs();
  bool isOnStackCache    = !SCFIs.empty() && FrameIndex >= 0 && SCFIs[FrameIndex];

  //----------------------------------------------------------------------------
  // Offset

  // get offset
  int Offset = SCFIs.empty() ? MFI.getStackSize() + FrameOffset : FrameOffset;

  //----------------------------------------------------------------------------
  // Base register

  // which register are we using as a base register?
  unsigned BasePtr = (TFI.hasFP(MF) && !MI.getFlag(MachineInstr::FrameSetup)) ?
                                                      Patmos::RFP : Patmos::RSP;

  // no base pointer needed for stack cache
  if (isOnStackCache)
    BasePtr = Patmos::R0;

  //----------------------------------------------------------------------------
  // Update instruction

  unsigned opcode = MI.getOpcode();

  // ensure that the offset fits the instruction
  switch (opcode)
  {
    case Patmos::LWC: case Patmos::LWM:
    case Patmos::SWC: case Patmos::SWM:
      // 9 bit
      assert((Offset & 0x3) == 0);
      Offset = (Offset >> 2) + FrameDisplacement;

      // if needed expand computation of large offsets
      if (!isInt<7>(Offset)) {
        computeLargeFIOffset(MRI, Offset, BasePtr, II, 2);
        computedLargeOffset = true;
      }
      break;
    case Patmos::LHC: case Patmos::LHM:
    case Patmos::LHUC: case Patmos::LHUM:
    case Patmos::SHC: case Patmos::SHM:
      // 8 bit
      assert((Offset & 0x1) == 0);
      Offset = (Offset >> 1) + FrameDisplacement;

      // if needed expand computation of large offsets
      if (!isInt<7>(Offset)) {
        computeLargeFIOffset(MRI, Offset, BasePtr, II, 1);
        computedLargeOffset = true;
      }
      break;
    case Patmos::LBC: case Patmos::LBM:
    case Patmos::LBUC: case Patmos::LBUM:
    case Patmos::SBC: case Patmos::SBM:
    case Patmos::PSEUDO_PREG_SPILL:
    case Patmos::PSEUDO_PREG_RELOAD:
      // 7 bit
      Offset += FrameDisplacement;

      // if needed expand computation of large offsets
      if (!isInt<7>(Offset)) {
        computeLargeFIOffset(MRI, Offset, BasePtr, II, 0);
        computedLargeOffset = true;
      }
      break;
    case Patmos::ADDi:
      // 12 bit
      Offset += FrameDisplacement;

      // rewrite to ADDl if needed
      if(!isUInt<12>(Offset)) {
        const MCInstrDesc &newMCID = TII.get(Patmos::ADDl);
        MI.setDesc(newMCID);
      }
      break;
    case Patmos::ADDl:
    case Patmos::DBG_VALUE:
      // all should be fine
      Offset += FrameDisplacement;
      break;
    default:
      llvm_unreachable("Unexpected operation with FrameIndex encountered.");
  }

  // special handling of pseudo instructions: expand
  if ( opcode==Patmos::PSEUDO_PREG_SPILL ||
       opcode==Patmos::PSEUDO_PREG_RELOAD ) {
      expandPseudoPregInstr(II, Offset, BasePtr, isOnStackCache);
      return;
  }

  // do we need to rewrite the instruction opcode?
  switch (opcode)
  {
    case Patmos::LWC: case Patmos::LWM: opcode = Patmos::LWS; break;
    case Patmos::LHC: case Patmos::LHM: opcode = Patmos::LHS; break;
    case Patmos::LHUC: case Patmos::LHUM: opcode = Patmos::LHUS; break;
    case Patmos::LBC: case Patmos::LBM: opcode = Patmos::LBS; break;
    case Patmos::LBUC: case Patmos::LBUM: opcode = Patmos::LBUS; break;
    case Patmos::SWC: case Patmos::SWM: opcode = Patmos::SWS; break;
    case Patmos::SHC: case Patmos::SHM: opcode = Patmos::SHS; break;
    case Patmos::SBC: case Patmos::SBM: opcode = Patmos::SBS; break;
    case Patmos::ADDi: case Patmos::ADDl: case Patmos::DBG_VALUE:
      break;
    default:
      llvm_unreachable("Unexpected operation with FrameIndex encountered.");
  }

  if (isOnStackCache) {
    const MCInstrDesc &newMCID = TII.get(opcode);
    MI.setDesc(newMCID);
  }

  // update the instruction's operands
  MI.getOperand(i).ChangeToRegister(BasePtr, false, false, computedLargeOffset);
  MI.getOperand(i+1).ChangeToImmediate(Offset);
}

unsigned PatmosRegisterInfo::getFrameRegister(const MachineFunction &MF) const {
  const TargetFrameLowering *TFI = TM.getFrameLowering();

  return TFI->hasFP(MF) ? Patmos::RFP : Patmos::RSP;
}


bool PatmosRegisterInfo::hasReservedSpillSlot(const MachineFunction &MF,
                                          unsigned Reg, int &FrameIdx) const {

  // We don't want to create a stack frame object for PRegs, they are handled
  // by SZ, as they're aliased
  // Simply return true - this prevents creation of a stack frame object,
  // and PRegs are not spilled on their own so the FrameIdx is not queried
  if (Patmos::PRegsRegClass.contains(Reg))
    return true;

  return false;
}



