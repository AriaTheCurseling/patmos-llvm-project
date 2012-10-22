//===-- PatmosAsmParser.cpp - Parse Patmos assembly to MCInst instructions ----===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/PatmosMCTargetDesc.h"
#include "MCTargetDesc/PatmosBaseInfo.h"
#include "MCTargetDesc/PatmosMCAsmInfo.h"
#include "InstPrinter/PatmosInstPrinter.h"
#include "PatmosInstrInfo.h"
#include "llvm/MC/MCTargetAsmParser.h"
#include "llvm/MC/MCParser/MCAsmLexer.h"
#include "llvm/MC/MCParser/MCAsmParser.h"
#include "llvm/MC/MCParser/MCParsedAsmOperand.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCTargetAsmParser.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCInstrDesc.h"
#include "llvm/MC/MCContext.h"
#include "MCTargetDesc/PatmosMCAsmInfo.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Twine.h"
#include "llvm/ADT/OwningPtr.h"

using namespace llvm;

namespace {
struct PatmosOperand;

class PatmosAsmParser : public MCTargetAsmParser {
  MCAsmParser &Parser;
  OwningPtr<MCInstrInfo> MII;

  // keep track of the bundle bit of the last instructions
  unsigned BundleCounter;

  MCAsmParser &getParser() const { return Parser; }
  MCAsmLexer &getLexer() const { return Parser.getLexer(); }

  void Warning(SMLoc L, const Twine &Msg) { Parser.Warning(L, Msg); }
  bool Error(SMLoc L, const Twine &Msg) { return Parser.Error(L, Msg); }

  #define GET_ASSEMBLER_HEADER
  #include "PatmosGenAsmMatcher.inc"

public:
  PatmosAsmParser(MCSubtargetInfo &sti, MCAsmParser &parser)
    : MCTargetAsmParser(), Parser(parser), MII(), BundleCounter(0)
  {
    // This is a nasty workaround for LLVM interface limitations
    const Target &T = static_cast<const PatmosMCAsmInfo*>(&parser.getContext().getAsmInfo())->getTarget();
    MII.reset(T.createMCInstrInfo());
  }

  virtual bool ParsePrefix(SMLoc &PrefixLoc, SmallVectorImpl<MCParsedAsmOperand*> &Operands,
                           bool &HasPrefix);

  virtual bool ParseInstruction(StringRef Name, SMLoc NameLoc,
                                SmallVectorImpl<MCParsedAsmOperand*> &Operands);

  virtual bool ParseRegister(unsigned &RegNo, SMLoc &StartLoc, SMLoc &EndLoc);

  virtual bool ParseDirective(AsmToken DirectiveID);

  virtual bool MatchAndEmitInstruction(SMLoc IDLoc,
                               SmallVectorImpl<MCParsedAsmOperand*> &Operands,
                               MCStreamer &Out);

  void EatToEndOfStatement();

private:
  bool ParseOperand(SmallVectorImpl<MCParsedAsmOperand*> &Operands, unsigned OpNo);

  bool ParseRegister(SmallVectorImpl<MCParsedAsmOperand*> &Operands, bool EmitError = true);

  /// ParseRegister - This version does not lex the last token so the end token can be retrieved
  bool ParseRegister(unsigned &RegNo, bool Required);

  bool ParseMemoryOperand(SmallVectorImpl<MCParsedAsmOperand*> &Operands);

  /// ParsePredicateOperand - parse a predicate operand including an optional negate flag. Adds two
  /// operands.
  /// \param checkClass - if true, only add the flag operand if the register is a predicate register
  bool ParsePredicateOperand(SmallVectorImpl<MCParsedAsmOperand*> &Operands, bool checkClass = false);

  bool ParseImmediate(SmallVectorImpl<MCParsedAsmOperand*> &Operands);

  /// ParseToken - Check if the Lexer is currently over the given token kind, and add it as operand if so.
  bool ParseToken(SmallVectorImpl<MCParsedAsmOperand*> &Operands, AsmToken::TokenKind Kind);

  /// isPredSrcOperand - Check whether the operand might be a predicate source operand (i.e., has a negate flag)
  bool isPredSrcOperand(StringRef Mnemonic, unsigned OpNo);

  bool ParseDirectiveWord(unsigned Size, SMLoc L);

  bool ParseDirectiveFStart(SMLoc L);
};

/// PatmosOperand - Instances of this class represent a parsed Patmos machine
/// instruction.
struct PatmosOperand : public MCParsedAsmOperand {
    enum KindTy {
      Token,
      Immediate,
      Register,
      Memory
    } Kind;

    SMLoc StartLoc, EndLoc;

    union {
      struct {
        const char *Data;
        unsigned Length;
      } Tok;

      struct {
        unsigned RegNum;
      } Reg;

      struct {
        const MCExpr *Val;
      } Imm;

      struct {
        unsigned Base;
        const MCExpr *Off;
      } Mem;
    };

    PatmosOperand(KindTy K) : MCParsedAsmOperand(), Kind(K) {}
  public:
    PatmosOperand(const PatmosOperand &o) : MCParsedAsmOperand() {
      Kind = o.Kind;
      StartLoc = o.StartLoc;
      EndLoc = o.EndLoc;
      switch (Kind) {
      case Register:
        Reg = o.Reg;
        break;
      case Immediate:
        Imm = o.Imm;
        break;
      case Token:
        Tok = o.Tok;
        break;
      case Memory:
        Mem = o.Mem;
        break;
      }
    }

    /// getStartLoc - Get the location of the first token of this operand.
    SMLoc getStartLoc() const { return StartLoc; }

    /// getEndLoc - Get the location of the last token of this operand.
    SMLoc getEndLoc() const { return EndLoc; }

    unsigned getReg() const {
      assert(Kind == Register && "Invalid access!");
      return Reg.RegNum;
    }

    const MCExpr *getImm() const {
      assert(Kind == Immediate && "Invalid access!");
      return Imm.Val;
    }

    unsigned getMemBase() const {
      assert(Kind == Memory && "Invalid access!");
      return Mem.Base;
    }

    const MCExpr* getMemOff() const {
      assert(Kind == Memory && "Invalid access!");
      return Mem.Off;
    }

    bool isToken() const { return Kind == Token; }
    bool isImm() const { return Kind == Immediate; }
    bool isMem() const { return Kind == Memory; }
    bool isReg() const { return Kind == Register; }

    void addExpr(MCInst &Inst, const MCExpr *Expr) const {
      // Add as immediate when possible.  Null MCExpr = 0.
      if (Expr == 0)
        Inst.addOperand(MCOperand::CreateImm(0));
      else if (const MCConstantExpr *CE = dyn_cast<MCConstantExpr>(Expr))
        Inst.addOperand(MCOperand::CreateImm(CE->getValue()));
      else
        Inst.addOperand(MCOperand::CreateExpr(Expr));
    }

    void addRegOperands(MCInst &Inst, unsigned N) const {
      assert(N == 1 && "Invalid number of operands!");
      Inst.addOperand(MCOperand::CreateReg(getReg()));
    }

    void addImmOperands(MCInst &Inst, unsigned N) const {
      assert(N == 1 && "Invalid number of operands!");
      addExpr(Inst, getImm());
    }

    void addMemOperands(MCInst &Inst, unsigned N) const {
      assert(N == 2 && "Invalid number of operands!");

      Inst.addOperand(MCOperand::CreateReg(getMemBase()));

      addExpr(Inst, getMemOff());
    }

    StringRef getToken() const {
      assert(Kind == Token && "Invalid access!");
      return StringRef(Tok.Data, Tok.Length);
    }

    virtual void print(raw_ostream &OS) const;

    static PatmosOperand *CreateToken(StringRef Str, SMLoc S) {
      PatmosOperand *Op = new PatmosOperand(Token);
      Op->Tok.Data = Str.data();
      Op->Tok.Length = Str.size();
      Op->StartLoc = S;
      Op->EndLoc = S;
      return Op;
    }

    static PatmosOperand *CreateReg(unsigned RegNum, SMLoc S, SMLoc E) {
      PatmosOperand *Op = new PatmosOperand(Register);
      Op->Reg.RegNum = RegNum;
      Op->StartLoc = S;
      Op->EndLoc = E;
      return Op;
    }

    static PatmosOperand *CreateImm(const MCExpr *Val, SMLoc S, SMLoc E) {
      PatmosOperand *Op = new PatmosOperand(Immediate);
      Op->Imm.Val = Val;
      Op->StartLoc = S;
      Op->EndLoc = E;
      return Op;
    }

    static PatmosOperand *CreateConstant(int value, SMLoc S, SMLoc E, MCContext &Ctx) {
      PatmosOperand *Op = new PatmosOperand(Immediate);
      Op->Imm.Val = MCConstantExpr::Create(value, Ctx);
      Op->StartLoc = S;
      Op->EndLoc = E;
      return Op;
    }

    static PatmosOperand *CreateFlag(bool flag, SMLoc S, SMLoc E, MCContext &Ctx) {
      return CreateConstant(flag ? 1 : 0, S, E, Ctx);
    }

    static PatmosOperand *CreateMem(unsigned Base, const MCExpr *Off, SMLoc S,
                                    SMLoc E) {
      PatmosOperand *Op = new PatmosOperand(Memory);
      Op->Mem.Base = Base;
      Op->Mem.Off = Off;
      Op->StartLoc = S;
      Op->EndLoc = E;
      return Op;
    }
};

} // end anonymous namespace.

void PatmosOperand::print(raw_ostream &OS) const {
  switch (Kind) {
  case Immediate:
    getImm()->print(OS);
    break;
  case Register:
    OS << "<register ";
    OS << PatmosInstPrinter::getRegisterName(getReg()) << ">";
    break;
  case Token:
    OS << "'" << getToken() << "'";
    break;
  case Memory: {
    OS << "<memory ";
    OS << getMemBase();
    OS << ", ";

    OS << getMemOff();
    OS << ">";
    }
    break;
  }
}


/// @name Auto-generated Match Functions
/// {

#define GET_REGISTER_MATCHER
#define GET_MATCHER_IMPLEMENTATION
#include "PatmosGenAsmMatcher.inc"

/// }


bool PatmosAsmParser::
MatchAndEmitInstruction(SMLoc IDLoc,
                        SmallVectorImpl<MCParsedAsmOperand*> &Operands,
                        MCStreamer &Out) {
  MCInst Inst;
  SMLoc ErrorLoc;
  unsigned ErrorInfo;
  bool isBundled = false;

  PatmosOperand *Op = (PatmosOperand*)Operands.back();
  if (Op->isToken() && Op->getToken() == ";") {
    isBundled = true;
    Operands.pop_back();

    if (isBundled && BundleCounter >= 1) {
      Error(Op->getStartLoc(), "an instruction can consist of at most two separate operations");
      delete Op;
      return true;
    }
    delete Op;
  }

  BundleCounter = isBundled ? BundleCounter + 1 : 0;

  switch (MatchInstructionImpl(Operands, Inst, ErrorInfo)) {
  default: break;
  case Match_Success:
  {
    // Add bundle marker
    Inst.addOperand(MCOperand::CreateImm(isBundled));

    // If we have an ALUi immediate instruction and the immediate does not fit 12bit, use ALUl version of instruction
    const MCInstrDesc &MID = MII->get(Inst.getOpcode());
    uint64_t Format = MID.TSFlags & PatmosII::FormMask;
    unsigned ImmOpNo = getPatmosImmediateOpNo( MID.TSFlags );
    bool ImmSigned = getPatmosImmediateSigned( MID.TSFlags );

    // TODO should we shift the constant? (This must be done in printer too in this case)

    unsigned ALUlOpcode;
    if (Format == PatmosII::FrmALUi && ImmOpNo > 0) {
      MCOperand &MCO = Inst.getOperand( ImmOpNo );

      if (MCO.isExpr() && !isBundled) {
        // TODO hack? if we have an expression, use ALUl, but not if this is a bundled op
        if (HasALUlVariant(Inst.getOpcode(), ALUlOpcode)) {
          Inst.setOpcode(ALUlOpcode);
          // ALUl counts as two operations
          BundleCounter++;
        }
      } else {
        assert(MCO.isImm() && "expected immediate operand for ALUi format");

        if (!isUInt<12>(MCO.getImm())) {
          if (isUInt<12>(-MCO.getImm()) && Inst.getOpcode() == Patmos::LIi) {
            // Make this an rsub instead
            MCO.setImm(-MCO.getImm());
            Inst.setOpcode(Patmos::LIin);
          }
          else if (isBundled) {
            return Error(IDLoc, "immediate operand too large for bundled ALUi instruction");
          }
          else if (HasALUlVariant(Inst.getOpcode(), ALUlOpcode)) {
            Inst.setOpcode(ALUlOpcode);
            // ALUl counts as two operations
            BundleCounter++;
          }
          else {
            return Error(IDLoc, "immediate operand too large for ALUi format and ALUl is not used for this opcode");
          }
        }
      }
      if (BundleCounter > 1) {
        return Error(IDLoc, "operand size requires ALUl instruction, it cannot be bundled with the previous operation");
      }
    }
    else if (Format == PatmosII::FrmALUl) {
      // ALUl counts as two operations
      BundleCounter++;
    }

    if (Format == PatmosII::FrmCFLb || Format == PatmosII::FrmSTC) {
      const MCOperand &MCO = Inst.getOperand(ImmOpNo);
      if (!MCO.isExpr()) {
        assert(MCO.isImm() && "expected immediate operand for ALUi format");

        if (( ImmSigned && !isInt<22>(MCO.getImm())) ||
            (!ImmSigned && !isUInt<22>(MCO.getImm()))) {
          return Error(IDLoc, "immediate operand is out of range");
        }
      }
    }

    if (Format == PatmosII::FrmSTT || Format == PatmosII::FrmLDT) {
      const MCOperand &MCO = Inst.getOperand(ImmOpNo);
      if (!MCO.isExpr()) {
        assert(MCO.isImm() && "expected immediate operand for ALUi format");

        if (( ImmSigned && !isInt<7>(MCO.getImm())) ||
            (!ImmSigned && !isUInt<7>(MCO.getImm()))) {
          return Error(IDLoc, "immediate offset is out of range");
        }
      }
    }

    Out.EmitInstruction(Inst);
    return false;
  }
  case Match_MissingFeature:
    return Error(IDLoc, "instruction use requires an option to be enabled");
  case Match_MnemonicFail:
      return Error(IDLoc, "unrecognized instruction mnemonic");
  case Match_ConversionFail:
    return Error(IDLoc, "unable to convert operands to instruction");
  case Match_InvalidOperand:
    ErrorLoc = IDLoc;
    if (ErrorInfo != ~0U) {
      if (ErrorInfo >= Operands.size())
        return Error(IDLoc, "too few operands for instruction");

      ErrorLoc = ((PatmosOperand*)Operands[ErrorInfo])->getStartLoc();
      if (ErrorLoc == SMLoc()) ErrorLoc = IDLoc;
    }

    return Error(ErrorLoc, "invalid operand for instruction or syntax mismatch");
  }

  llvm_unreachable("Implement any new match types added!");
}

bool PatmosAsmParser::
ParseRegister(SmallVectorImpl<MCParsedAsmOperand*> &Operands, bool EmitError) {
  MCAsmLexer &Lexer = getLexer();
  SMLoc S = Lexer.getLoc();

  unsigned RegNo = 0;
  if (ParseRegister(RegNo, false)) {
    // syntax error
    return true;
  }
  if (RegNo == 0) {
    // missing register
    return !EmitError || Error(S, "Missing register name");
  }

  SMLoc E = Lexer.getLoc();
  Lexer.Lex();

  Operands.push_back(PatmosOperand::CreateReg(RegNo, S, E));

  return false;
}

bool PatmosAsmParser::
ParseRegister(unsigned &RegNo, SMLoc &StartLoc, SMLoc &EndLoc) {
  if (ParseRegister(RegNo, false)) {
    return true;
  }
  getLexer().Lex();
  return false;
}

bool PatmosAsmParser::
ParseRegister(unsigned &RegNo, bool Required) {
  MCAsmLexer &Lexer = getLexer();

  if (Lexer.getKind() == AsmToken::Dollar) {
    Lexer.Lex();
  } else {
    return Required;
  }
  if (Lexer.getKind() == AsmToken::Identifier) {
    StringRef RegName = Lexer.getTok().getIdentifier();
    RegNo = MatchRegisterName(RegName);

    // Handle alternative register names
    if (!RegNo) {
      RegNo = StringSwitch<unsigned>(RegName)
        .Case("s1", Patmos::SM)
        .Case("s2", Patmos::SL)
        .Case("s3", Patmos::SH)
        .Case("s6", Patmos::ST)
        .Default(0);
    }

    // If name does not match after $ prefix, this is always an error
    return (RegNo == 0) && Error(Lexer.getLoc(), "register name not valid");
  }
  // Syntax error: $ and no identifier is always an error
  return Error(Lexer.getLoc(), "register prefix $ is not followed by a register name");
}

bool PatmosAsmParser::
ParseMemoryOperand(SmallVectorImpl<MCParsedAsmOperand*> &Operands)  {
  MCAsmLexer &Lexer = getLexer();
  SMLoc StartLoc = Lexer.getLoc();

  if (ParseToken(Operands, AsmToken::LBrac)) {
    return true;
  }

  // try to match rN +/- Imm, rN, or Imm

  if (ParseRegister(Operands, false)) {

    // add default register
    SMLoc EndLoc = Lexer.getLoc();
    Operands.push_back(PatmosOperand::CreateReg(Patmos::R0, StartLoc, EndLoc));

  } else {

    if (Lexer.is(AsmToken::RBrac)) {
      // Default offset
      SMLoc E = Lexer.getLoc();
      Operands.push_back(PatmosOperand::CreateConstant(0, E, E, getParser().getContext()));

      return ParseToken(Operands, AsmToken::RBrac);

    } else if (Lexer.is(AsmToken::Plus)) {
      // lex away the plus symbol, leave a minus, fail on everything else
      Lexer.Lex();
    } else if (Lexer.isNot(AsmToken::Minus)) {
      return Error(Lexer.getLoc(), "invalid separator between register and offset");
    }
  }

  if (ParseImmediate(Operands)) {
    return true;
  }

  return ParseToken(Operands, AsmToken::RBrac);
}

bool PatmosAsmParser::
ParsePredicateOperand(SmallVectorImpl<MCParsedAsmOperand*> &Operands, bool checkClass)  {
  MCAsmLexer &Lexer = getLexer();
  SMLoc StartLoc = Lexer.getLoc();

  bool flag = false;
  if (Lexer.is(AsmToken::Exclaim)) {
    flag = true;
    Lexer.Lex();
  }

  SMLoc RegLoc = Lexer.getLoc();

  if (ParseRegister(Operands)) {
    return true;
  }

  if (checkClass) {
    PatmosOperand *Op = (PatmosOperand*)Operands.back();
    if (!Op->isReg()) return Error(Lexer.getLoc(), "magic happened: we found a register but the operand is not a register");

    // TODO There really should be a nicer way of doing this, but we do not have access to the RegisterInfo stuff here
    if (PatmosInstPrinter::getRegisterName(Op->getReg())[0] != 'p') {
      // Not a predicate register, do not emit a flag operand
      if (flag) {
        Error(StartLoc, "Negation of registers other than predicates is invalid.");
      }
      return false;
    }
  }

  Operands.push_back(PatmosOperand::CreateFlag(flag, StartLoc, RegLoc, getParser().getContext()));

  return false;
}

bool PatmosAsmParser::
ParseOperand(SmallVectorImpl<MCParsedAsmOperand*> &Operands, unsigned OpNo)  {
  MCAsmLexer &Lexer = getLexer();

  // Handle all the various operand types here: Imm, reg, memory, predicate, label
  if (Lexer.is(AsmToken::LBrac)) {
    return ParseMemoryOperand(Operands);
  }
  if (Lexer.is(AsmToken::Exclaim)) {
    // we never allow a negated predicate as first out operand
    if (OpNo == 0) {
      return Error(Lexer.getLoc(), "destination predicate cannot be negated");
    }
    return ParsePredicateOperand(Operands);
  }
  if (Lexer.is(AsmToken::Dollar)) {

    StringRef Mnemonic = ((PatmosOperand*)Operands[0])->getToken();
    if (isPredSrcOperand(Mnemonic, OpNo)) {
      return ParsePredicateOperand(Operands, true);
    }

    return ParseRegister(Operands);
  }
  if (Lexer.is(AsmToken::Identifier)) {
    // Parse it as a label
    return ParseImmediate(Operands);
  }

  // Parse as immediate or some other form of symbolic expression
  return ParseImmediate(Operands);
}

bool PatmosAsmParser::ParseImmediate(SmallVectorImpl<MCParsedAsmOperand*> &Operands) {
  MCAsmLexer &Lexer = getLexer();
  SMLoc S = Lexer.getLoc();

  const MCExpr *EVal;
  switch (Lexer.getKind()) {
  default: return true;
  case AsmToken::LParen:
  case AsmToken::Plus:
  case AsmToken::Minus:
  case AsmToken::Integer:
  case AsmToken::Identifier:
    if (getParser().ParseExpression(EVal))
      return true;

    SMLoc E = Lexer.getLoc();
    Operands.push_back(PatmosOperand::CreateImm(EVal, S, E));
    return false;
  }
}

bool PatmosAsmParser::ParseToken(SmallVectorImpl<MCParsedAsmOperand*> &Operands, AsmToken::TokenKind Kind) {
  MCAsmLexer &Lexer = getLexer();

  if (Lexer.isNot(Kind)) {
    return Error(Lexer.getLoc(), "unexpected token");
  }

  Operands.push_back(PatmosOperand::CreateToken(Lexer.getTok().getString(), Lexer.getLoc()));
  Lexer.Lex();

  return false;
}


bool PatmosAsmParser::
ParsePrefix(SMLoc &PrefixLoc, SmallVectorImpl<MCParsedAsmOperand*> &Operands, bool &HasPrefix) {
  MCAsmLexer &Lexer = getLexer();

  // If it starts with '(', assume this is a guard, and try to parse it, otherwise skip
  if (Lexer.isNot(AsmToken::LParen)) {
    return false;
  }
  Lexer.Lex();

  HasPrefix = true;

  if (ParsePredicateOperand(Operands)) {
    return true;
  }

  if (Lexer.isNot(AsmToken::RParen)) {
    return true;
  }
  Lexer.Lex();

  return false;
}

bool PatmosAsmParser::
ParseInstruction(StringRef Name, SMLoc NameLoc,
                 SmallVectorImpl<MCParsedAsmOperand*> &Operands)
{
  // The first operand is the token for the instruction name
  Operands.insert(Operands.begin(), PatmosOperand::CreateToken(Name,NameLoc));

  // If this instruction has no guard, we just add a default one.
  // We do not yet know if the instruction actually requires one, so we might need to undo this
  // if we do not find a match (if we actually have instructions that have no guard).
  if (Operands.size() == 1) {
    Operands.push_back(PatmosOperand::CreateReg(Patmos::P0, NameLoc, NameLoc));
    Operands.push_back(PatmosOperand::CreateFlag(false, NameLoc, NameLoc, getParser().getContext()));
  }

  unsigned OpNo = 0;

  MCAsmLexer &Lexer = getLexer();

  // If there are no more operands then finish
  while (Lexer.isNot(AsmToken::EndOfStatement)) {

    // we have a bundled operation?
    if (Lexer.is(AsmToken::Semicolon)) {
      // handle bundle marker by adding it as last operand
      if (ParseToken(Operands, AsmToken::Semicolon)) {
        return true;
      }
      // Disallow ;; directly after ;
      // We could also undo the ';' in this case but then the behaviour of \n and # would
      // make the syntax a bit too complicated to understand.
      // TODO get the SeparatorString from MCAsmInfo
      if (Lexer.is(AsmToken::EndOfStatement) && Lexer.getTok().getString() == ";;") {
        return Error(Lexer.getLoc(), "unexpected bundle separator after bundled instruction separator");
      }
      return false;
    }

    if (Lexer.is(AsmToken::Comma)) {
      // we do not start with a comma before any operands
      if (OpNo == 0) {
        SMLoc TokLoc = Lexer.getLoc();
        EatToEndOfStatement();
        return Error(TokLoc, "comma before first operand");
      }
      Lex();
    } else if (Lexer.is(AsmToken::Equal)) {
      // add it as a token for the matcher
      // TODO if somebody writes something like 'r1, r2, r3' instead of 'r1 = r2, r3', he will
      //      get a 'register type mismatch' error for 'r3', which is *very* confusing.
      if (ParseToken(Operands, AsmToken::Equal)) {
        EatToEndOfStatement();
        return true;
      }
    } else if (OpNo > 0) {
      // We need some separation between operands
      SMLoc TokLoc = Lexer.getLoc();
      EatToEndOfStatement();
      return Error(TokLoc, "missing separator between operands or instructions");
    }

    if (ParseOperand(Operands, OpNo)) {
      EatToEndOfStatement();
      return true;
    }

    OpNo++;
  }

  return false;
}

bool PatmosAsmParser::
ParseDirective(AsmToken DirectiveID) {
  StringRef IDVal = DirectiveID.getIdentifier();
  if (IDVal == ".word")
    return ParseDirectiveWord(4, DirectiveID.getLoc());
  if (IDVal == ".half" || IDVal == ".hword")
    return ParseDirectiveWord(2, DirectiveID.getLoc());
  if (IDVal == ".fstart")
    return ParseDirectiveFStart(DirectiveID.getLoc());
  return true;
}

/// ParseDirectiveWord
///  ::= .word [ expression (, expression)* ]
bool PatmosAsmParser::ParseDirectiveWord(unsigned Size, SMLoc L) {
  if (getLexer().isNot(AsmToken::EndOfStatement)) {
    for (;;) {
      const MCExpr *Value;
      if (getParser().ParseExpression(Value))
        return true;

      getParser().getStreamer().EmitValue(Value, Size, 0 /*addrspace*/);

      if (getLexer().is(AsmToken::EndOfStatement))
        break;

      // FIXME: Improve diagnostic.
      if (getLexer().isNot(AsmToken::Comma))
        return Error(L, "unexpected token in directive");
      Parser.Lex();
    }
  }

  Parser.Lex();
  return false;
}

/// ParseDirectiveFStart
///  ::= .fstart [ symbol , length, align ]
bool PatmosAsmParser::ParseDirectiveFStart(SMLoc L) {
  if (getLexer().is(AsmToken::EndOfStatement)) {
    return Error(L, "missing arguments to .fstart directive");
  }

  const MCSymbol *Start;
  const MCExpr *StartExpr;
  if (getParser().ParseExpression(StartExpr)) {
    return true;
  }
  if (StartExpr->getKind() == MCExpr::SymbolRef) {
    const MCSymbolRefExpr *SymRef = dyn_cast<MCSymbolRefExpr>(StartExpr);
    Start = &SymRef->getSymbol();
  } else {
    return Error(L, "first parameter of this directive must be a symbol name");
  }

  if (getLexer().isNot(AsmToken::Comma))
    return Error(L, "unexpected token in directive");
  Parser.Lex();

  const MCExpr *Length;
  if (getParser().ParseExpression(Length)) {
    return true;
  }

  if (getLexer().isNot(AsmToken::Comma))
    return Error(L, "unexpected token in directive");
  Parser.Lex();

  int64_t Align;
  if (getParser().ParseAbsoluteExpression(Align)) {
    return true;
  }
  if (Align < 0) {
    return Error(L, "alignment value must be a positive value");
  }

  if (getLexer().isNot(AsmToken::EndOfStatement)) {
    return Error(L, "unexpected token in directive");
  }
  Parser.Lex();

  getParser().getStreamer().EmitFStart(Start, Length, (unsigned)Align);

  return false;
}

bool PatmosAsmParser::isPredSrcOperand(StringRef Mnemonic, unsigned OpNo)
{
  // only src operands, only combine ops
  if (OpNo == 0) return false;

  // We check if the src op is actually a predicate register later in the parse method
  if (Mnemonic == "or"  || Mnemonic == "and" || Mnemonic == "xor" || Mnemonic == "nor") return true;
  if (Mnemonic == "mov" || Mnemonic == "neg" || Mnemonic == "not") return true;

  return false;
}

void PatmosAsmParser::EatToEndOfStatement() {
  MCAsmLexer &Lexer = getLexer();
  while (Lexer.isNot(AsmToken::EndOfStatement) &&
         Lexer.isNot(AsmToken::Semicolon) &&
         Lexer.isNot(AsmToken::Eof)) {
    Lexer.Lex();
  }
}


extern "C" void LLVMInitializePatmosAsmLexer();

extern "C" void LLVMInitializePatmosAsmParser() {
  RegisterMCAsmParser<PatmosAsmParser> X(ThePatmosTarget);
  LLVMInitializePatmosAsmLexer();
}

