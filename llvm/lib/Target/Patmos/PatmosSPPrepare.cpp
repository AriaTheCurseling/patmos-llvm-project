//===-- PatmosSPPrepare.cpp - Prepare for Single-Path conversion ----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This pass prepares functions marked for single-path conversion.
// It creates predicate spill slots and loop counter slots where necessary.
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
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineJumpTableInfo.h"
#include "llvm/CodeGen/MachinePostDominators.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
//#include "llvm/CodeGen/RegisterScavenging.h"
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

  class PatmosSPPrepare : public MachineFunctionPass {
  private:
    /// Pass ID
    static char ID;

    const PatmosTargetMachine &TM;
    const PatmosSubtarget &STC;
    const PatmosInstrInfo *TII;

    /// doPrepareFunction - Reduce a given MachineFunction
    void doPrepareFunction(MachineFunction &MF);

    unsigned getNumUnusedPRegs(MachineFunction &MF) const;

  public:
    /// PatmosSPPrepare - Initialize with PatmosTargetMachine
    PatmosSPPrepare(const PatmosTargetMachine &tm) :
      MachineFunctionPass(ID), TM(tm),
      STC(tm.getSubtarget<PatmosSubtarget>()),
        TII(static_cast<const PatmosInstrInfo*>(tm.getInstrInfo())) {}

    /// getPassName - Return the pass' name.
    virtual const char *getPassName() const {
      return "Patmos Single-Path Prepare";
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
      if ( PSPI.isEnabled(MF) ) {
        DEBUG( dbgs() << "[Single-Path] Preparing "
                      << MF.getFunction()->getName() << "\n" );
        doPrepareFunction(MF);
        changed |= true;
      }
      return changed;
    }
  };

  char PatmosSPPrepare::ID = 0;
} // end of anonymous namespace

///////////////////////////////////////////////////////////////////////////////

/// createPatmosSPPreparePass - Returns a new PatmosSPPrepare
/// \see PatmosSPPrepare
FunctionPass *llvm::createPatmosSPPreparePass(const PatmosTargetMachine &tm) {
  return new PatmosSPPrepare(tm);
}

///////////////////////////////////////////////////////////////////////////////



void PatmosSPPrepare::doPrepareFunction(MachineFunction &MF) {

  PatmosSinglePathInfo &PSPI = getAnalysis<PatmosSinglePathInfo>();

  MachineFrameInfo &MFI = *MF.getFrameInfo();
  PatmosMachineFunctionInfo &PMFI = *MF.getInfo<PatmosMachineFunctionInfo>();

  SPNode *root = PSPI.getRootNode();

  std::vector<unsigned> requiredPreds;

  // for all (sub-)SPNodes
  for (df_iterator<SPNode*> I = df_begin(root), E = df_end(root); I!=E; ++I) {
    SPNode *N = *I;
    MachineBasicBlock *Header = N->getHeader();
    unsigned preds = PSPI.getNumPredicates(N);
    unsigned d = N->getDepth();

    DEBUG( dbgs() << "[MBB#" << Header->getNumber()
                  << "]: d=" << d << ", " << preds << "\n");

    // keep track of the maximum required number of predicates for each SPNode
    if (d+1 > requiredPreds.size()) {
      requiredPreds.push_back(preds);
    } else {
      if (requiredPreds[d] < preds)
        requiredPreds[d] = preds;
    }
  }

  // create for each nesting level but the innermost one a byte-sized
  // spill slot for S0 in use
  for(unsigned i=0; i<requiredPreds.size()-1; i++) {
    int fi = MFI.CreateStackObject(1, 1, false);
    PMFI.SinglePathSpillFIs.push_back(fi);
  }

  // compute the required number of spill bits, depending on the number
  // of allocatable pred regs
  int numAllocatablePRegs = getNumUnusedPRegs(MF);
  int numSpillSlotsReq = 0;
  for(unsigned i=0; i<requiredPreds.size(); i++) {
    DEBUG( dbgs() << "[" << i << "]: " << requiredPreds[i] << "\n");

    int cnt = requiredPreds[i] - numAllocatablePRegs;
    if (cnt>0) {
      numSpillSlotsReq += cnt;
    }
  }

  const TargetRegisterClass *RC = &Patmos::RRegsRegClass;
  DEBUG( dbgs() << "Computed number of allocatable PRegs: "
                << numAllocatablePRegs
                << "\nRequired predicate spill slots (bits): "
                << numSpillSlotsReq << "\n");

  // create them as multiples of RRegs size
  for (unsigned j=0;
       j <= (numSpillSlotsReq+31)/(8*RC->getSize());
       j++) {
    int fi = MFI.CreateStackObject(RC->getSize(), RC->getAlignment(), false);
    PMFI.SinglePathSpillFIs.push_back(fi);
  }
}


unsigned PatmosSPPrepare::getNumUnusedPRegs(MachineFunction &MF) const {
  MachineRegisterInfo &RegInfo = MF.getRegInfo();
  unsigned count = 0;
  // Get the unused predicate registers
  for (TargetRegisterClass::iterator I=Patmos::PRegsRegClass.begin(),
      E=Patmos::PRegsRegClass.end(); I!=E; ++I ) {
    if (RegInfo.reg_empty(*I) && *I!=Patmos::P0) {
      count++;
    }
  }
  return count;
}
///////////////////////////////////////////////////////////////////////////////

