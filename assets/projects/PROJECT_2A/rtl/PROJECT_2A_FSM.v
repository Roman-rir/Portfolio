//-----------------------------------------------------------------------------

//
// Title       : DORITO_FSM
// Design      : MULTICYCLE_V1
// Author      : SMR
// Company     : AIUB
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\DORITO_RISC_V1\MULTICYCLE_V1\src\DORITO_FSM.v
// Generated   : Tue May 27 15:50:06 2025
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

 module PROJECT_2A_FSM
(input  logic SYS_CLOCK,
input  logic FSM_ARESET,
input  logic RD_EN, WR_EN,
input logic [17:0] RC,
output logic RDY_RD, READ, RDY_WR, WRITE,
output logic [7:0] DATA,
output logic [3:0] OPCODE,
output logic M_DATA,
output logic [1:0] WR_ADDR, RD_ADDR1, RD_ADDR2,
output logic LD_R, LD_C
);


logic [1:0] P_STATE, N_STATE; 

assign DATA = RC [7:0];
assign OPCODE = RC [11:8]; 
assign WR_ADDR = RC [17:16];
assign RD_ADDR1 = RC [15:14];
assign RD_ADDR2 = RC [13:12]; 

always_comb
begin : NSOL

	begin :NSL
	N_STATE = 'x;

	case (P_STATE)
	0: N_STATE = 1; 

	1: if (RD_EN) N_STATE = 0;
   	else N_STATE = 2;

	2: N_STATE = 3;

	3: if (WR_EN) N_STATE = 2;
   	else N_STATE = 0;
 
	default : N_STATE = 0;

	endcase

	end : NSL

	begin : OL
	{RDY_RD, READ, RDY_WR, WRITE} = '0;
//	{DATA, OPCODE, WR_ADDR, RD_ADDR1, RD_ADDR2} = '0;
	{M_DATA, LD_R, LD_C}  = '0;
         //DATA = RC [7:0];
         //OPCODE = RC [11:8];
         //WR_ADDR = RC [17:16];
	 //RD_ADDR1 = RC [15:14];
         //RD_ADDR2 = RC [13:12];

	case (P_STATE)
	0: 	{RDY_RD, LD_C} = '1;
 
	1: 	begin
		READ = 1;
		/*
 		if (RD_EN) 
    			begin
			DATA = RC[7:0];
                        WR_ADDR = RC [17:16];
			LD_R = 1;
			end
                */
                LD_R = 1;
 		end
	2: 	{RDY_WR, LD_C} = '1;
 
	3: 	begin
                WRITE = 1;
                /*
		if (WR_EN)
                        begin
                        RD_ADDR1 = RC [15:14];
                        RD_ADDR2 = RC [13:12];
                        WR_ADDR = RC [17:16];
                        OPCODE = RC [11:8];
                        M_DATA = 1;
			LD_R = 1;
                        end
		*/
                M_DATA = 1;
                LD_R = 1;
                end
 
 
	default : ;
 
	endcase

	end : OL

end : NSOL


always_ff @ (posedge SYS_CLOCK, posedge FSM_ARESET)
begin : PSR

	if (FSM_ARESET)
		P_STATE <= '0;
	else
		P_STATE <= N_STATE;

end : PSR

endmodule : PROJECT_2A_FSM
