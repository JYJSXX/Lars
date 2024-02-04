enum Ins_type{
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
}

List<Ins_type> without_rd = [
    Ins_type.NOP,
    Ins_type.B,
    Ins_type.BL,
],
without_rj = [
    Ins_type.NOP,
    Ins_type.B,
    Ins_type.BL,
    Ins_type.LU12IW,
    Ins_type.PCADDU12I,
],
without_rk = [
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
],
with_ui5 = [
    Ins_type.SLLIW,
    Ins_type.SRLIW,
    Ins_type.SRAIW,
],
with_ui12 = [
    Ins_type.LU12IW,
    Ins_type.PCADDU12I,
    Ins_type.ANDI,
    Ins_type.ORI,
    Ins_type.XORI,
],
with_si12 = [
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
],
with_label16 = [
    Ins_type.BEQ,
    Ins_type.BNE,
    Ins_type.BLT,
    Ins_type.BGE,
    Ins_type.BLTU,
    Ins_type.BGEU,
],
with_label26 = [
    Ins_type.B,
    Ins_type.BL,
],
with_LDST = [
    Ins_type.LDB,
    Ins_type.LDH,
    Ins_type.LDW,
    Ins_type.STB,
    Ins_type.STH,
    Ins_type.STW,
    Ins_type.LDBU,
    Ins_type.LDHU,
],
with_label = with_label16 + with_label26;

enum analyze_mode{
    DATA,
    TEXT,
}