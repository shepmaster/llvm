//===-- AVRInstPrinter.cpp - Convert AVR MCInst to assembly syntax --------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This class prints an AVR MCInst to a .s file.
//
//===----------------------------------------------------------------------===//

#include "AVRInstPrinter.h"

#include <cstring>

#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstrDesc.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/FormattedStream.h"

#include "MCTargetDesc/AVRMCTargetDesc.h"

#define DEBUG_TYPE "asm-printer"

namespace llvm {

// Include the auto-generated portion of the assembly writer.
#define PRINT_ALIAS_INSTR
#include "AVRGenAsmWriter.inc"

void AVRInstPrinter::printInst(const MCInst *MI, raw_ostream &O,
                               StringRef Annot, const MCSubtargetInfo &STI) {
  unsigned Opcode = MI->getOpcode();

  // First handle load and store instructions with postinc or predec
  // of the form "ld reg, X+".
  // TODO: is this necessary anymore now that we encode this into
  // AVRInstrInfo.td
  switch (Opcode) {
  case AVR::LDRdPtr:
  case AVR::LDRdPtrPi:
  case AVR::LDRdPtrPd:
    O << "\tld\t";
    printOperand(MI, 0, O);
    O << ", ";
    if (Opcode == AVR::LDRdPtrPd)
      O << '-';
    printOperand(MI, 1, O);
    if (Opcode == AVR::LDRdPtrPi)
      O << '+';
    return;
  case AVR::STPtrRr:
    O << "\tst\t";
    printOperand(MI, 0, O);
    O << ", ";
    printOperand(MI, 1, O);
    return;
  case AVR::STPtrPiRr:
  case AVR::STPtrPdRr:
    O << "\tst\t";
    if (Opcode == AVR::STPtrPdRr)
      O << '-';
    printOperand(MI, 1, O);
    if (Opcode == AVR::STPtrPiRr)
      O << '+';
    O << ", ";
    printOperand(MI, 2, O);
    return;
  }

  if (!printAliasInstr(MI, O))
    printInstruction(MI, O);

  printAnnotation(O, Annot);
}

const char *AVRInstPrinter::getPrettyRegisterName(unsigned RegNum,
                                                  MCRegisterInfo const &MRI) {
  // GCC prints register pairs by just printing the lower register
  // If the register contains a subregister, print it instead
  if (MRI.getNumSubRegIndices() > 0) {
    auto RegLoNum = MRI.getSubReg(RegNum, AVR::sub_lo);
    RegNum = (RegLoNum != AVR::NoRegister) ? RegLoNum : RegNum;
  }

  return getRegisterName(RegNum);
}

void AVRInstPrinter::printOperand(const MCInst *MI, unsigned OpNo,
                                  raw_ostream &O) {
  const MCOperand &Op = MI->getOperand(OpNo);
  const MCOperandInfo &MOI = this->MII.get(MI->getOpcode()).OpInfo[OpNo];

  if (Op.isReg()) {
    //.RegClass == AVR::GPR8RegClassID
    bool isPtrReg = (MOI.RegClass == AVR::PTRREGSRegClassID) ||
                    (MOI.RegClass == AVR::PTRDISPREGSRegClassID) ||
                    (MOI.RegClass == AVR::ZREGSRegClassID);

    if (isPtrReg) {
      O << getRegisterName(Op.getReg(), AVR::ptr);
    } else {
      O << getPrettyRegisterName(Op.getReg(), MRI);
    }
  } else if (Op.isImm()) {
    O << Op.getImm();
  } else {
    assert(Op.isExpr() && "Unknown operand kind in printOperand");
    O << *Op.getExpr();
  }
}

/// This is used to print an immediate value that ends up
/// being encoded as a pc-relative value.
void AVRInstPrinter::printPCRelImm(const MCInst *MI, unsigned OpNo,
                                   raw_ostream &O) {
  const MCOperand &Op = MI->getOperand(OpNo);

  if (Op.isImm()) {
    int64_t Imm = Op.getImm();
    O << '.';

    // Print a position sign if needed.
    // Negative values have their sign printed automatically.
    if (Imm >= 0)
      O << '+';

    O << Imm;
    return;
  }

  assert(Op.isExpr() && "Unknown pcrel immediate operand");
  O << *Op.getExpr();
}

void AVRInstPrinter::printMemri(const MCInst *MI, unsigned OpNo,
                                raw_ostream &O) {
  const MCOperand &RegOp = MI->getOperand(OpNo);
  const MCOperand &OffsetOp = MI->getOperand(OpNo + 1);

  assert(RegOp.isReg() && "Expected a register");

  // Print the register.
  printOperand(MI, OpNo, O);

  // Print the offset.
  {
    if (OffsetOp.isImm()) {
      auto Offset = OffsetOp.getImm();

      if (Offset >= 0)
        O << '+';

      O << Offset;
    } else if (OffsetOp.isExpr()) {
      O << *OffsetOp.getExpr();
    } else {
      llvm_unreachable("unknown type for offset");
    }
  }
}

} // end of namespace llvm
