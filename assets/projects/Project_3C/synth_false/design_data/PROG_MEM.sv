`timescale 1ns/1ps

module PROG_MEM
(
    input  logic [3:0] PC,
    output logic [31:0] PM_OUT
);

// Instruction Format:
// Type, Opcode, Rd, Rs1, Rs2, Branch Directive, Immediate Data
// 31:28, 27:24, 23:20, 19:16, 15:12, 11:8, 7:0

logic [31:0] P_MEM [0:15];

// Load program from external HEX file
initial
begin
    $readmemh("program.hex", P_MEM);
end

assign PM_OUT = P_MEM[PC];

endmodule
