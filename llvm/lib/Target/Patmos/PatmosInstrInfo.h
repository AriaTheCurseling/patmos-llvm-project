//===- PatmosInstrInfo.h - Patmos Instruction Information -------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the Patmos implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef _LLVM_TARGET_PATMOS_INSTRINFO_H_
#define _LLVM_TARGET_PATMOS_INSTRINFO_H_

#include "llvm/Target/TargetInstrInfo.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCNullStreamer.h"
#include "PatmosRegisterInfo.h"
#include "MCTargetDesc/PatmosMCTargetDesc.h"
#include "MCTargetDesc/PatmosBaseInfo.h"

#define GET_INSTRINFO_HEADER
#include "PatmosGenInstrInfo.inc"


namespace llvm {

class PatmosTargetMachine;

// TODO move this class into a separate header, track call sites and stack
// cache control instructions, use in CallGraphBuilder, ...
class PatmosInstrAnalyzer : public MCNullStreamer {
  const MCInstrInfo &MII;
  unsigned count;
  unsigned size;
public:
  PatmosInstrAnalyzer(MCContext &ctx)
    : MCNullStreamer(ctx), MII(ctx.getInstrInfo()), count(0), size(0)
    {
    }

  void reset() {
    count = 0;
    size = 0;
  }

  unsigned getCount() const { return count; }

  unsigned getSize() const { return size; }

  virtual void EmitInstruction(const MCInst &Inst) {
    const MCInstrDesc &MID = MII.get(Inst.getOpcode());
    count++;
    size += MID.getSize();
  }
};

class PatmosInstrInfo : public PatmosGenInstrInfo {
  PatmosTargetMachine &PTM;
  const PatmosRegisterInfo RI;
public:
  explicit PatmosInstrInfo(PatmosTargetMachine &TM);

  /// getRegisterInfo - TargetInstrInfo is a superset of MRegister info.  As
  /// such, whenever a client has an instance of instruction info, it should
  /// always be able to get register info as well (through this method).
  ///
  virtual const TargetRegisterInfo &getRegisterInfo() const { return RI; }

  /// findCommutedOpIndices - If specified MI is commutable, return the two
  /// operand indices that would swap value. Return false if the instruction
  /// is not in a form which this routine understands.
  virtual bool findCommutedOpIndices(MachineInstr *MI, unsigned &SrcOpIdx1,
                                     unsigned &SrcOpIdx2) const;

  void copyPhysReg(MachineBasicBlock &MBB,
                   MachineBasicBlock::iterator I, DebugLoc DL,
                   unsigned DestReg, unsigned SrcReg,
                   bool KillSrc) const;

  void storeRegToStackSlot(MachineBasicBlock &MBB,
                           MachineBasicBlock::iterator MI,
                           unsigned SrcReg, bool isKill,
                           int FrameIndex,
                           const TargetRegisterClass *RC,
                           const TargetRegisterInfo *TRI) const;
  void loadRegFromStackSlot(MachineBasicBlock &MBB,
                            MachineBasicBlock::iterator MI,
                            unsigned DestReg, int FrameIdx,
                            const TargetRegisterClass *RC,
                            const TargetRegisterInfo *TRI) const;

  /// insertNoop - Insert a noop into the instruction stream at the specified
  /// point.
  virtual void insertNoop(MachineBasicBlock &MBB,
                          MachineBasicBlock::iterator MI) const;

  /// isSchedulingBoundary - Test if the given instruction should be
  /// considered a scheduling boundary.
  virtual bool isSchedulingBoundary(const MachineInstr *MI,
                                              const MachineBasicBlock *MBB,
                                              const MachineFunction &MF) const;

  /// CreateTargetHazardRecognizer - Return the hazard recognizer to use for
  /// this target when scheduling the DAG.
  virtual ScheduleHazardRecognizer *
  CreateTargetHazardRecognizer(const TargetMachine *TM,
                               const ScheduleDAG *DAG) const;

  /// CreateTargetMIHazardRecognizer - Allocate and return a hazard recognizer
  /// to use for this target when scheduling the machine instructions before
  /// register allocation.
  virtual ScheduleHazardRecognizer*
  CreateTargetMIHazardRecognizer(const InstrItineraryData*,
                                 const ScheduleDAG *DAG) const;

  /// CreateTargetPostRAHazardRecognizer - Return the postRA hazard recognizer
  /// to use for this target when scheduling the DAG.
  virtual ScheduleHazardRecognizer *
  CreateTargetPostRAHazardRecognizer(const InstrItineraryData *II,
                                     const ScheduleDAG *DAG) const;

  virtual DFAPacketizer*
  CreateTargetScheduleState(const TargetMachine *TM,
                            const ScheduleDAG *DAG) const;

  /// fixOpcodeForGuard - If the MCID opcode is for an unconditional
  /// instruction (e.g. by the isBarrier flag), but the predicate says
  /// otherwise (and vice versa), rewrite the instruction accordingly.
  /// Returns true iff the instruction was rewritten.
  virtual bool fixOpcodeForGuard(MachineInstr *MI) const;

  /// isStackControl - Return true if the instruction controls the stack cache.
  virtual bool isStackControl(const MachineInstr *MI) const;

  /// isSideEffectFreeSRegAccess- return true if the instruction is a MTS/MFS
  /// to/from a special register without side-effects
  virtual bool isSideEffectFreeSRegAccess(const MachineInstr *MI) const;

  /// getMemType - Return the type for Patmos' typed memory accesses.
  /// MI must be either a load or a store instruction.
  virtual unsigned getMemType(const MachineInstr *MI) const;

  // getFirstMI - Return MI or the first 'real' instruction if MI is a bundle.
  const MachineInstr* getFirstMI(const MachineInstr *MI) const;

  /// getInstrSize - get the size of an instruction
  /// correctly deals with inline assembler
  unsigned int getInstrSize(const MachineInstr *MI) const;

  /////////////////////////////////////////////////////////////////////////////
  // Branch handling
  /////////////////////////////////////////////////////////////////////////////


  /// getBranchTarget - Get the target machine basic block for direct branches
  MachineBasicBlock *getBranchTarget(const MachineInstr *MI) const;

  /// AnalyzeBranch - Analyze the branching code at the end of MBB, returning
  /// true if it cannot be understood (e.g. it's a switch dispatch or isn't
  /// implemented for a target).
  /// \see TargetInstrInfo::AnalyzeBranch
  virtual bool AnalyzeBranch(MachineBasicBlock &MBB, MachineBasicBlock *&TBB,
                             MachineBasicBlock *&FBB,
                             SmallVectorImpl<MachineOperand> &Cond,
                             bool AllowModify = false) const;

  /// RemoveBranch - Remove the branching code at the end of the specific MBB.
  /// This is only invoked in cases where AnalyzeBranch returns success. It
  /// returns the number of instructions that were removed.
  virtual unsigned RemoveBranch(MachineBasicBlock &MBB) const;

  /// InsertBranch - Insert branch code into the end of the specified
  /// MachineBasicBlock.  The operands to this method are the same as those
  /// returned by AnalyzeBranch.  This is only invoked in cases where
  /// AnalyzeBranch returns success. It returns the number of instructions
  /// inserted.
  /// \see TargetInstrInfo::InsertBranch
  virtual unsigned InsertBranch(MachineBasicBlock &MBB, MachineBasicBlock *TBB,
                                MachineBasicBlock *FBB,
                                const SmallVectorImpl<MachineOperand> &Cond,
                                DebugLoc DL) const;

  /// ReverseBranchCondition - Reverses the branch condition of the specified
  /// condition list, returning false on success and true if it cannot be
  /// reversed.
  virtual bool ReverseBranchCondition(SmallVectorImpl<MachineOperand> &Cond)
                                      const;




  /////////////////////////////////////////////////////////////////////////////
  // Predication and IfConversion
  /////////////////////////////////////////////////////////////////////////////

  /// isPredicated - If the instruction has other than default predicate
  /// operands (p0), return true.
  /// Return false if the branch instruction has default predicate operands.
  virtual bool isPredicated(const MachineInstr *MI) const;

  /// isUnpredicatedTerminator - Returns true if the instruction is a
  /// terminator instruction that has not been predicated.
  /// IMPORTANT: returns also true for conditional branches,
  ///            they are an exception
  virtual bool isUnpredicatedTerminator(const MachineInstr *MI) const;



  /// PredicateInstruction - Convert the instruction into a predicated
  /// instruction. It returns true if the operation was successful.
  virtual
  bool PredicateInstruction(MachineInstr *MI,
                            const SmallVectorImpl<MachineOperand> &Pred) const;

  /// SubsumesPredicate - Returns true if the first specified predicate
  /// subsumes the second.
  /// For Patmos, the default predicate subsumes all others.
  /// For all other cases, predicate equality is checked.
  virtual
  bool SubsumesPredicate(const SmallVectorImpl<MachineOperand> &Pred1,
                         const SmallVectorImpl<MachineOperand> &Pred2) const;

  /// DefinesPredicate - If the specified instruction defines any predicate
  /// register, it returns true as well as the defined predicate register.
  /// NOTE: currently this is the only place where only one operand is put
  ///       into the Pred vector.
  virtual bool DefinesPredicate(MachineInstr *MI,
                                std::vector<MachineOperand> &Pred) const;



  /// isProfitableToIfCvt - Return true if it's profitable to predicate
  /// instructions with accumulated instruction latency of "NumCycles"
  /// of the specified basic block, where the probability of the instructions
  /// being executed is given by Probability, and Confidence is a measure
  /// of our confidence that it will be properly predicted.
  virtual
  bool isProfitableToIfCvt(MachineBasicBlock &MBB, unsigned NumCycles,
                           unsigned ExtraPredCycles,
                           const BranchProbability &Probability) const {

    const MCInstrDesc &MCID = prior(MBB.end())->getDesc();
    if (MCID.isReturn() || MCID.isCall())
      return false;
    return NumCycles <= 8;
  }

  /// isProfitableToIfCvt - Second variant of isProfitableToIfCvt, this one
  /// checks for the case where two basic blocks from true and false path
  /// of a if-then-else (diamond) are predicated on mutally exclusive
  /// predicates, where the probability of the true path being taken is given
  /// by Probability, and Confidence is a measure of our confidence that it
  /// will be properly predicted.
  virtual bool
  isProfitableToIfCvt(MachineBasicBlock &TMBB,
                      unsigned NumTCycles, unsigned ExtraTCycles,
                      MachineBasicBlock &FMBB,
                      unsigned NumFCycles, unsigned ExtraFCycles,
                      const BranchProbability &Probability) const {
    const MCInstrDesc &TMCID = prior(TMBB.end())->getDesc();
    if (TMCID.isReturn() || TMCID.isCall())
      return false;
    const MCInstrDesc &FMCID = prior(FMBB.end())->getDesc();
    if (FMCID.isReturn() || FMCID.isCall())
      return false;
    return (NumTCycles + NumFCycles) <= 16;
  }

  /// isProfitableToDupForIfCvt - Return true if it's profitable for
  /// if-converter to duplicate instructions of specified accumulated
  /// instruction latencies in the specified MBB to enable if-conversion.
  /// The probability of the instructions being executed is given by
  /// Probability, and Confidence is a measure of our confidence that it
  /// will be properly predicted.
  virtual bool
  isProfitableToDupForIfCvt(MachineBasicBlock &MBB, unsigned NumCycles,
                            const BranchProbability &Probability) const {
    const MCInstrDesc &MCID = prior(MBB.end())->getDesc();
    if (MCID.isReturn() || MCID.isCall())
      return false;
    return NumCycles <= 4;
  }

}; // PatmosInstrInfo

static inline
const MachineInstrBuilder &AddDefaultPred(const MachineInstrBuilder &MIB) {
  // predicate: always true
  return MIB.addReg(Patmos::NoRegister).addImm(0);
}


static inline
bool HasALUlVariant(unsigned Opcode, unsigned &ALUlOpcode) {
  using namespace Patmos;

  switch (Opcode) {
  case ADDi:  ALUlOpcode = ADDl;  return true;
  case SUBi:  ALUlOpcode = SUBl;  return true;
  case XORi:  ALUlOpcode = XORl;  return true;
  // No need for ALUl versions of SL, SR, SRA: they only use 5bit immediates anyway
  case ORi:   ALUlOpcode = ORl;   return true;
  case ANDi:  ALUlOpcode = ANDl;  return true;
  case LIi:   ALUlOpcode = LIl;   return true;
  case CADDi: ALUlOpcode = CADDl; return true;
  default: return false;
  }
}

/// HasPCrelImmediate - check if the instruction with the given opcode and
/// MID has a PC relative immediate (Format == CFLb && Opcode != CALL).
static inline
bool HasPCRELImmediate(unsigned Opcode, const MCInstrDesc &MID) {
  uint64_t Format = (MID.TSFlags & PatmosII::FormMask);
  // CFLb and Opcode != call => immediate is PCrel
  if (Format != PatmosII::FrmCFLb) return false;
  return Opcode != Patmos::CALL;
}


} // end namespace llvm

#endif // _LLVM_TARGET_PATMOS_INSTRINFO_H_
