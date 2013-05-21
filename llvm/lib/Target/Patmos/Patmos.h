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
  FunctionPass *createPatmosDelaySlotFillerPass(PatmosTargetMachine &tm,
                                                bool ForceDisable);
  FunctionPass *createPatmosFunctionSplitterPass(PatmosTargetMachine &tm);
  FunctionPass *createPatmosExportPass(PatmosTargetMachine &TM,
                                       std::string& Filename,
                                       std::string& BitcodeFilename);
  FunctionPass *createPatmosPacketizer(PatmosTargetMachine &tm);
  FunctionPass *createPatmosBundleSanitizer(PatmosTargetMachine &tm);
  ModulePass *createPatmosModuleExportPass(PatmosTargetMachine &TM,
                                           std::string& Filename,
                                           std::string& BitcodeFilename,
                                           ArrayRef<std::string> Roots);
  ModulePass *createPatmosCallGraphBuilder();
  ModulePass *createPatmosStackCacheAnalysis(const PatmosTargetMachine &tm);
} // end namespace llvm;

#endif // _LLVM_TARGET_PATMOS_H_
