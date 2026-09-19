//-----------------------------------------------------------------------------
//
// Title       : DORITO_DATAPATH
// Design      : MULTICYCLE_V1
// Author      : SMR
// Company     : AIUB
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\DORITO_RISC_V1\MULTICYCLE_V1\src\DORITO_DATAPATH.v
// Generated   : Tue May 27 15:47:02 2025
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

 module PROJECT_2A_DATAPATH
(input logic SYS_CLOCK,
input logic [17:0] CONTROL,
input  logic [7:0] DATA,
input  logic [3:0] OPCODE,
input  logic M_DATA,
input  logic [1:0] WR_ADDR, RD_ADDR1, RD_ADDR2, 	
input  logic LD_R, LD_C,		
output  logic [7:0] RA, RB, RX, RY, 
output logic [17:0] RC	
);

//INTERNAL SIGNAL DEFINITIONS
logic [7:0] DATA_IN, RA_IN, RB_IN, RX_IN, RY_IN, SRC1, SRC2, ALU_OUT;

/////////////////////////////////////////////////
////REGISTERS
//////////////////////////////////////////////////


always_ff @ (posedge SYS_CLOCK)
begin : R_A
if (LD_R)
	RA <= RA_IN; 
end : R_A

always_ff @ (posedge SYS_CLOCK)
begin : R_B
if (LD_R)
        RB <= RB_IN;
end : R_B

always_ff @ (posedge SYS_CLOCK)
begin : R_X
if (LD_R)
        RX <= RX_IN;
end : R_X

always_ff @ (posedge SYS_CLOCK)
begin : R_Y
if (LD_R)
        RY <= RY_IN;
end : R_Y


always_ff @ (posedge SYS_CLOCK)
begin : R_C
if (LD_C)
        RC <= CONTROL;
end : R_C

/////////////////////////////////////////////////
////ALU
////////////////////////////////////////////////

always_comb
begin : ALU

case (OPCODE)
0 : ALU_OUT = SRC1 + SRC2;
1 : ALU_OUT = SRC1 - SRC2;
2 : ALU_OUT = SRC1[3:0] * SRC2 [3:0];
3 : ALU_OUT = SRC1[7:4] * SRC2 [7:4];
4 : ALU_OUT = SRC1 & SRC2;
5 : ALU_OUT = SRC1 | SRC2;
6 : ALU_OUT = ~(SRC1 & SRC2);
7 : ALU_OUT = ~(SRC1 | SRC2);
8 : ALU_OUT = SRC1 ^ SRC2;
9 : ALU_OUT = ~(SRC1 ^ SRC2);
10: ALU_OUT = ~SRC1;
11: ALU_OUT = ~SRC2;
12: ALU_OUT = SRC1;
13: ALU_OUT = SRC2;
14: ALU_OUT = SRC1 << 1;
15: ALU_OUT = SRC1 >> 1 ;

default : ALU_OUT = 'x;

endcase

end : ALU


/////////////////////////////////////////////////
//////MUXES
//////////////////////////////////////////////////

always_comb
begin : MUX_DATA

case (M_DATA)
0 : DATA_IN = DATA;
1 : DATA_IN = ALU_OUT;
default : DATA_IN = 'x;
endcase

end	: MUX_DATA

always_comb
begin : MUX_SOURCE1

case (RD_ADDR1)
0 : SRC1 = RA;
1 : SRC1 = RB;
2 : SRC1 = RX;
3 : SRC1 = RY;
default : SRC1 = 'x;
endcase

end	: MUX_SOURCE1

always_comb
begin : MUX_SOURCE2

case (RD_ADDR2)
0 : SRC2 = RA;
1 : SRC2 = RB;
2 : SRC2 = RX;
3 : SRC2 = RY;
default : SRC2 = 'x;
endcase

end     : MUX_SOURCE2


/////////////////////////////////////////////////
//////DEMUX
//////////////////////////////////////////////////

always_comb
begin : DEMUX

{RA_IN, RB_IN, RX_IN, RY_IN} = '0;
case (WR_ADDR)
0 : RA_IN = DATA_IN;
1 : RB_IN = DATA_IN;
2 : RX_IN = DATA_IN;
3 : RY_IN = DATA_IN;
default : ;
endcase

end     : DEMUX

endmodule : PROJECT_2A_DATAPATH



	




