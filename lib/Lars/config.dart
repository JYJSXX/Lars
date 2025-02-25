import 'dart:core';

enum Ins_type {
  NULL,
  NOP,
  ADDW,
  SUBW,
  SLT,
  SLTU,
  NOR,
  AND,
  OR,
  XOR,
  SLLW,
  SRLW,
  SRAW,
  MULW,
  MULHW,
  MULHWU,
  DIVW,
  MODW,
  DIVWU,
  MODWU,
  SLLIW,
  SRLIW,
  SRAIW,
  SLTI,
  SLTUI,
  ADDIW,
  ANDI,
  ORI,
  XORI,
  LU12IW,
  PCADDU12I,
  LDB,
  LDH,
  LDW,
  STB,
  STH,
  STW,
  LDBU,
  LDHU,
  JIRL,
  B,
  BL,
  BEQ,
  BNE,
  BLT,
  BGE,
  BLTU,
  BGEU,
  BREAK,
  HALT,
  LIW,
  LALOCAL,
}

Set<Ins_type> without_rd = {
      Ins_type.NOP,
      Ins_type.B,
      Ins_type.BL,
      Ins_type.BREAK,
      Ins_type.HALT,
    },
    without_rj = {
      Ins_type.NOP,
      Ins_type.B,
      Ins_type.BL,
      Ins_type.LU12IW,
      Ins_type.PCADDU12I,
      Ins_type.BREAK,
      Ins_type.HALT,
      Ins_type.LIW,
      Ins_type.LALOCAL,
    },
    without_rk = {
      Ins_type.NOP,
      Ins_type.B,
      Ins_type.BL,
      Ins_type.LU12IW,
      Ins_type.PCADDU12I,
      Ins_type.JIRL,
      Ins_type.BEQ,
      Ins_type.BNE,
      Ins_type.BLT,
      Ins_type.BGE,
      Ins_type.BLTU,
      Ins_type.BGEU,
      Ins_type.SLLIW,
      Ins_type.SRLIW,
      Ins_type.SRAIW,
      Ins_type.SLTI,
      Ins_type.SLTUI,
      Ins_type.ADDIW,
      Ins_type.ANDI,
      Ins_type.ORI,
      Ins_type.XORI,
      Ins_type.LDB,
      Ins_type.LDH,
      Ins_type.LDW,
      Ins_type.STB,
      Ins_type.STH,
      Ins_type.STW,
      Ins_type.LDBU,
      Ins_type.LDHU,
      Ins_type.BREAK,
      Ins_type.HALT,
      Ins_type.LIW,
      Ins_type.LALOCAL,
    },
    with_ui5 = {
      Ins_type.SLLIW,
      Ins_type.SRLIW,
      Ins_type.SRAIW,
    },
    with_ui12 = {
      Ins_type.ANDI,
      Ins_type.ORI,
      Ins_type.XORI,
    },
    with_si12 = {
      Ins_type.SLTI,
      Ins_type.SLTUI,
      Ins_type.ADDIW,
      Ins_type.LDB,
      Ins_type.LDH,
      Ins_type.LDW,
      Ins_type.STB,
      Ins_type.STH,
      Ins_type.STW,
      Ins_type.LDBU,
      Ins_type.LDHU,
    },
    with_si16 = {Ins_type.JIRL},
    with_si20 = {
      Ins_type.LU12IW,
      Ins_type.PCADDU12I,
    },
    with_label16 = {
      Ins_type.BEQ,
      Ins_type.BNE,
      Ins_type.BLT,
      Ins_type.BGE,
      Ins_type.BLTU,
      Ins_type.BGEU,
    },
    with_label26 = {
      Ins_type.B,
      Ins_type.BL,
    },
    with_label32 = {
      Ins_type.LALOCAL,
    },
    with_LDST = {
      Ins_type.LDB,
      Ins_type.LDH,
      Ins_type.LDW,
      Ins_type.STB,
      Ins_type.STH,
      Ins_type.STW,
      Ins_type.LDBU,
      Ins_type.LDHU,
    };
Set<Ins_type> with_label =
    (with_label16.toList() + with_label26.toList() + with_label32.toList())
        .toSet();

enum analyze_mode {
  DATA,
  TEXT,
}

enum Sign_type {
  TEXT,
  DATA,
  WORD,
  BYTE,
  HALF,
  SPACE,
}

String opString =
    r"\b(nop|add\.w|sub\.w|slt|sltu|nor|and|or|xor|sll\.w|srl\.w|sra\.w|mul\.w|mulh\.w|mulhu\.w|div\.w|mod\.w|divu\.w|modu\.w|slli\.w|srli\.w|srai\.w|slti|sltui|addi\.w|andi|ori|xori|lu12i\.w|pcaddu12i|ld\.b|ld\.h|ld\.w|st\.b|st\.h|st\.w|ld\.bu|ld\.hu|jirl|b|bl|beq|bne|blt|bge|bltu|bgeu|break|halt|li\.w|la\.local)\b";
String signString =
    r"(\.)(text|data|word|byte|half|space)|((^|\s+)([a-zA-Z_][a-zA-Z0-9_]*):)";
// String labelString = r"(^|\s+)([a-zA-Z_][a-zA-Z0-9_]*):";
String regString =
    r"((\s+)(\$?)([Rr][0-9]+|zero|ra|tp|sp|a[0-7]|t[0-8]|fp|s[0-9]|ZERO|RA|TP|SP|A[0-7]|T[0-8]|FP|S[0-9])\b)";
// String immString = r"(\s+)?(0x)?[0-9]+\b";

String opcheckString =
    r"^((NOP)|(ADD\.W)|(SUB\.W)|(SLT)|(SLTU)|(NOR)|(AND)|(OR)|(XOR)|(SLL\.W)|(SRL\.W)|(SRA\.W)|(MUL\.W)|(MULH\.W)|(MULHU\.W)|(DIV\.W)|(MOD\.W)|(DIVU\.W)|(MODU\.W)|(SLLI\.W)|(SRLI\.W)|(SRAI\.W)|(SLTI)|(SLTUI)|(ADDI\.W)|(ANDI)|(ORI)|(XORI)|(LU12I\.W)|(PCADDU12I)|(LD\.B)|(LD\.H)|(LD\.W)|(ST\.B)|(ST\.H)|(ST\.W)|(LD\.BU)|(LD\.HU)|(JIRL)|(B)|(BL)|(BEQ)|(BNE)|(BLT)|(BGE)|(BLTU)|(BGEU)|(BREAK)|(HALT)|(LI\.W)|(LA\.LOCAL))$";
