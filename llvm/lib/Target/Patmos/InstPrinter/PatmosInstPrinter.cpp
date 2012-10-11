//===-- PatmosInstPrinter.cpp - Convert Patmos MCInst to assembly syntax --===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This class prints an Patmos MCInst to a .s file.
//
//===----------------------------------------------------------------------===//

#define DEBUG_TYPE "asm-printer"
#include "Patmos.h"
#include "PatmosInstPrinter.h"
#include "MCTargetDesc/PatmosBaseInfo.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstrDesc.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/FormattedStream.h"
#include "llvm/Support/Format.h"
using namespace llvm;


// Include the auto-generated portion of the assembly writer.
#include "PatmosGenAsmWriter.inc"

void PatmosInstPrinter::printInst(const MCInst *MI, raw_ostream &O,
                                  StringRef Annot) {
  printInstruction(MI, O);

  // if we are in a bundle, print the bundle separator (';')
  // We use an additional operand at the end of the op-list for this information
  bool isBundled = MI->getOperand(MI->getNumOperands()-1).getImm() > 0;

  if (isBundled) {
    O << "\t; ";
  }

  printAnnotation(O, Annot);
}

void PatmosInstPrinter::printGuard(const MCInst *MI, raw_ostream &O) {
  // Print the predicate register first.
  // This is a workaround. The guard cannot be printed before the mnemonic by
  // tablegen, otherwise we would not be able to generate matcher tables.
  // We therefore skip printing the guard in the AsmString and print it here
  // as a prefix instead.

  const MCInstrDesc &Desc = MII.get(MI->getOpcode());

  if (Desc.isPredicable()) {
    // We assume that the predicate is the first in operand!
    printPredicateOperand(MI, Desc.getNumDefs(), O, "guard");
  } else {
    printDefaultGuard(O, true);
  }
  O << " ";
}

void PatmosInstPrinter::printOperand(const MCInst *MI, unsigned OpNo,
                                     raw_ostream &O, const char *Modifier)
{
  // Note: this code is not used to generate inline-assembly. See
  // PatmosAsmPrinter for that.

  const MCOperand &Op = MI->getOperand(OpNo);
  if (Op.isReg()) {
    // do not print register R0 in addressing modes
    if ( !(Modifier && strcmp(Modifier, "addrmod") == 0) ||
         (Op.getReg() != Patmos::R0)) {
      printRegisterName(Op.getReg(), O);
    }
  } else if (Op.isImm()) {
    if (Modifier && strcmp(Modifier, "addrmod") == 0) {
      const MCOperand &baseOp = MI->getOperand(OpNo - 1);
      if (baseOp.getReg() == Patmos::R0)
        O << Op.getImm();
      else if (Op.getImm() != 0)
        O << ((Op.getImm() < 0) ? " - " : " + ") << std::abs(Op.getImm());
    }
    else {
      // TODO print as hex only for some instructions?
      //O << format("0x%X", Op.getImm());
      // We have the hex value in the disassembly output anyway, and we do not
      // want to print hex for LIin
      O << Op.getImm();
    }
  } else {
    assert(Op.isExpr() && "unknown operand kind in printOperand");

    if (Modifier && strcmp(Modifier, "addrmod") == 0)
      O << " + ";

    O << *Op.getExpr();
  }
}

void PatmosInstPrinter::printPredicateOperand(const MCInst *MI, unsigned OpNo,
                                              raw_ostream &O,
                                              const char *Modifier)
{
  unsigned reg  = MI->getOperand(OpNo  ).getReg();
  int      flag = MI->getOperand(OpNo+1).getImm();

  if (Modifier && strcmp(Modifier, "skip") == 0) {
    return;
  }

  if (Modifier && strcmp(Modifier, "guard") == 0) {
    if (reg == Patmos::NoRegister || ((reg == Patmos::P0) && !flag)) {
      printDefaultGuard(O, false);
    } else if (MI->getOpcode()==Patmos::NOP) {
      // no need to print guards for NOP
      printDefaultGuard(O, false);
    } else {
      O << "(" << ((flag)?"!":" ");
      printRegisterName(reg, O);
      O << ")";
    }
  } else { // not "guard":
    O << ((flag)?"!":" ");
    if (reg == Patmos::NoRegister) {
      printRegisterName(Patmos::P0, O);
    }
    else {
      printRegisterName(reg, O);
    }
  }
}

void PatmosInstPrinter::printPCRelTargetOperand(const MCInst *MI,
                                            unsigned OpNo,
                                            raw_ostream &O)
{
  const MCOperand &Op = MI->getOperand(OpNo);
  // For disassembly .. should we create a fixup for this in the disassembler,
  // or an expression??
  if (Op.isImm()) {
    // TODO print as hex value;
    O << Op.getImm();
    return;
  }

  assert(Op.isExpr() && "unknown operand kind in printCacheRelTargetOperand");

  O << *Op.getExpr();
}

void PatmosInstPrinter::printRegisterName(unsigned RegNo, raw_ostream &O) {
  if (PrefixRegisters) {
    O << "$";
  }
  O << getRegisterName(RegNo);
}

void PatmosInstPrinter::printDefaultGuard(raw_ostream &O, bool NoGuard) {
  if (PrefixRegisters) {
    O << "      "; // instead of ( $p0)
  } else {
    O << "     ";  // instead of ( p0)

  }
}
