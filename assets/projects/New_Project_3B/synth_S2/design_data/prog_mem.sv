

module PROG_MEM_P
(input logic [3:0] PC,
output logic [31:0] PM_OUT);



logic [31:0] P_MEM [0:15] = '{
    32'h201F0000, // PC=0: RF[1] <-- DM[RF[15]+RF[0]] = DM[15] = 15
    32'h20270000, // PC=1: RF[2] <-- DM[RF[7] +RF[0]] = DM[7]  = 7
    32'h17300000, // PC=2: RF[3] <-- 0                    ; quotient = 0
    32'h01112000, // PC=3: RF[1] <-- RF[1] - RF[2]        ; 15-7 = 8
    32'h10330001, // PC=4: RF[3] <-- RF[3] + 1            ; quotient = 1
    32'h01112000, // PC=5: RF[1] <-- RF[1] - RF[2]        ; 8-7 = 1
    32'h10330001, // PC=6: RF[3] <-- RF[3] + 1            ; quotient = 2
    32'h17400003, // PC=7: RF[4] <-- 3                    ; result address base = 3
    32'h30340000, // PC=8: DM[RF[4]+RF[0]] <-- RF[3]      ; DM[3] = 2
    32'h00000000, // PC=9 : NOP-like instruction
    32'h00000000, // PC=10: NOP-like instruction
    32'h00000000, // PC=11: NOP-like instruction
    32'h00000000, // PC=12: NOP-like instruction
    32'h00000000, // PC=13: NOP-like instruction
    32'h00000000, // PC=14: NOP-like instruction
    32'h00000000  // PC=15: NOP-like instruction
};

assign PM_OUT = P_MEM[PC];

endmodule

