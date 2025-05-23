set(LLVM_TARGET_DEFINITIONS Options.td)
tablegen(LLVM Options.inc -gen-opt-parser-defs)
add_public_tablegen_target(ELFOptionsTableGen)

add_lld_library(lldELF
  AArch64ErrataFix.cpp
  Arch/AArch64.cpp
  Arch/AMDGPU.cpp
  Arch/ARM.cpp
  Arch/AVR.cpp
  Arch/Hexagon.cpp
  Arch/Mips.cpp
  Arch/MipsArchTree.cpp
  Arch/MSP430.cpp
  Arch/Patmos.cpp
  Arch/PPC.cpp
  Arch/PPC64.cpp
  Arch/RISCV.cpp
  Arch/SPARCV9.cpp
  Arch/X86.cpp
  Arch/X86_64.cpp
  ARMErrataFix.cpp
  CallGraphSort.cpp
  DWARF.cpp
  Driver.cpp
  DriverUtils.cpp
  EhFrame.cpp
  ICF.cpp
  InputFiles.cpp
  InputSection.cpp
  LTO.cpp
  LinkerScript.cpp
  MapFile.cpp
  MarkLive.cpp
  OutputSections.cpp
  Relocations.cpp
  ScriptLexer.cpp
  ScriptParser.cpp
  SymbolTable.cpp
  Symbols.cpp
  SyntheticSections.cpp
  Target.cpp
  Thunks.cpp
  Writer.cpp

  LINK_COMPONENTS
  ${LLVM_TARGETS_TO_BUILD}
  BinaryFormat
  BitWriter
  Core
  DebugInfoDWARF
  Demangle
  LTO
  MC
  Object
  Option
  Passes
  Support

  LINK_LIBS
  lldCommon
  ${LLVM_PTHREAD_LIB}

  DEPENDS
  ELFOptionsTableGen
  intrinsics_gen
  )
