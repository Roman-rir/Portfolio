//-----------------------------------------------------------------------------
//
// Title       : DORITO_SYSTEM_TOP
// Design      : MULTICYCLE_V1
// Author      : SMR
// Company     : AIUB
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\DORITO_RISC_V1\MULTICYCLE_V1\src\DORITO_SYSTEM_TOP.v
// Generated   : Tue May 27 15:53:56 2025
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

timeunit 1ns;
timeprecision 1ps;

module PROJECT_2A_TOP
(input logic SYS_CLOCK, FSM_ARESET,
input logic RD_EN, WR_EN,
input logic [17:0] CONTROL,   
output logic RDY_RD, READ, RDY_WR, WRITE,
output logic [7:0] RA, RB, RX, RY 
);

logic [17:0] RC;
logic [7:0] DATA;
logic [3:0] OPCODE;
logic M_DATA;
logic [1:0] WR_ADDR, RD_ADDR1, RD_ADDR2;
logic LD_R, LD_C;


PROJECT_2A_FSM F1 (.*);
PROJECT_2A_DATAPATH D1 (.*);

endmodule : PROJECT_2A_TOP  
