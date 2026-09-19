`timescale 1ps/1ps

module RISC_V3 
(input logic SYS_CLOCK, RST,
output logic [31:0] PC, DM_ADDR,
output logic [31:0] IR, RF_Q1, RF_Q2, IMM_DATA, ALU_OUT, DM_OUT, PM_OUT, DM_IN,
output logic DM_WR,
output logic [2:0] PSTATE);

//Internal Signal Definitions
//logic [31:0] PM_OUT, DM_OUT;
//logic [31:0] DM_IN;
//logic [3:0] PC, DM_ADDR;
//logic DM_WR;


PROCESSOR_V3 PC1 (.*);
PROG_MEM PM (.*); 
DATA_MEM DM (.*);


endmodule


