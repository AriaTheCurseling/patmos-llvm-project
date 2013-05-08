//==-- Patmos.h - Top-level interface for Patmos representation --*- C++ -*-==//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the entry points for global functions defined in
// the LLVM Patmos backend.
//
//===----------------------------------------------------------------------===//

#ifndef _LLVM_TARGET_PATMOS_H_
#define _LLVM_TARGET_PATMOS_H_

#include "MCTargetDesc/PatmosMCTargetDesc.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/ADT/ArrayRef.h"


namespace llvm {
  class PatmosTargetMachine;
  class FunctionPass;
  class ModulePass;
  class formatted_raw_ostream;
  class PassRegistry;

  void initializePatmosCallGraphBuilderPass(PassRegistry&);

  FunctionPass *createPatmosISelDag(PatmosTargetMachine &TM);
  FunctionPass *createPatmosSinglePathInfoPass(const PatmosTargetMachine &tm);
  FunctionPass *createPatmosSPPreparePass(const PatmosTargetMachine &tm);
  FunctionPass *createPatmosSPReducePass(const PatmosTargetMachine &tm);
  FunctionPass *createPatmosDelaySlotFillerPass(const PatmosTargetMachine &tm);
  FunctionPass *createPatmosFunctionSplitterPass(PatmosTargetMachine &tm);
  FunctionPass *createPatmosExportPass(PatmosTargetMachine &tm,
                                       std::string& filename);
  FunctionPass *createPatmosPacketizer(PatmosTargetMachine &tm);
  ModulePass   *createPatmosModuleExportPass(PatmosTargetMachine &tm,
                                       std::string& filename,
                                       ArrayRef<std::string> roots);

  ModulePass *createPatmosCallGraphBuilder();
  ModulePass *createPatmosStackCacheAnalysis(const PatmosTargetMachine &tm);
} // end namespace llvm;

#endif // _LLVM_TARGET_PATMOS_H_
