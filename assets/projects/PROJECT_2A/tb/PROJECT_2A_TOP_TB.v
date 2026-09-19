//-----------------------------------------------------------------------------
//
// Title       : DORITO_SYSTEM_TOP_tb
// Design      : MULTICYCLE_V3
// Author      : SMR
// Company     : AIUB
//
//-----------------------------------------------------------------------------
//
// File        : DORITO_SYSTEM_TOP_TB.v
// Generated   : Fri May 30 15:20:26 2025
// From        : c:\My_Designs\DORITO_RISC_V1\MULTICYCLE_V3\src\TestBench\DORITO_SYSTEM_TOP_TB_settings.txt
// By          : tb_verilog.pl ver. ver 1.2s
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
timeunit 1ns;
timeprecision 1ps;

module PROJECT_2A_TOP_tb();

//Internal signals declarations:
logic SYS_CLOCK;
logic FSM_ARESET;	
logic RD_EN, WR_EN;
logic [17:0] CONTROL;
logic RDY_RD, READ, RDY_WR, WRITE;
logic [7:0] RA, RB, RX, RY;

//logic [17:0] RC;
logic [3:0] OPCODE;
logic [7:0] DATA;
logic [1:0] WR_ADDR, RD_ADDR1, RD_ADDR2;
logic M_DATA, LD_C, LD_R;
logic [1:0] P_STATE, N_STATE;
logic [17:0] RC;
logic [7:0] ALU_OUT, DATA_IN, RA_IN, RB_IN, RX_IN, RY_IN, SRC1, SRC2;


assign P_STATE = PROJECT_2A_TOP_tb.UUT.F1.P_STATE;
assign N_STATE = PROJECT_2A_TOP_tb.UUT.F1.N_STATE;
assign RC = PROJECT_2A_TOP_tb.UUT.RC;
assign LD_R = PROJECT_2A_TOP_tb.UUT.LD_R;
assign LD_C = PROJECT_2A_TOP_tb.UUT.LD_C;
assign M_DATA = PROJECT_2A_TOP_tb.UUT.M_DATA;
assign DATA = PROJECT_2A_TOP_tb.UUT.DATA;
assign OPCODE = PROJECT_2A_TOP_tb.UUT.OPCODE;
assign WR_ADDR = PROJECT_2A_TOP_tb.UUT.WR_ADDR;
assign RD_ADDR1 = PROJECT_2A_TOP_tb.UUT.RD_ADDR1;
assign RD_ADDR2 = PROJECT_2A_TOP_tb.UUT.RD_ADDR2;
assign ALU_OUT = PROJECT_2A_TOP_tb.UUT.D1.ALU_OUT;
assign DATA_IN = PROJECT_2A_TOP_tb.UUT.D1.DATA_IN;
assign RA_IN = PROJECT_2A_TOP_tb.UUT.D1.RA_IN;
assign RB_IN = PROJECT_2A_TOP_tb.UUT.D1.RB_IN;
assign RX_IN = PROJECT_2A_TOP_tb.UUT.D1.RX_IN;
assign RY_IN = PROJECT_2A_TOP_tb.UUT.D1.RY_IN;
assign SRC1 = PROJECT_2A_TOP_tb.UUT.D1.SRC1;
assign SRC2 = PROJECT_2A_TOP_tb.UUT.D1.SRC2;

// Unit Under Test port map
PROJECT_2A_TOP UUT (.*);


const time CLOCK_PERIOD = 100ns;

initial
begin
//FSM_ARESET <= '0; 
SYS_CLOCK <= '0; 

	forever
	begin
	#(CLOCK_PERIOD/2) SYS_CLOCK <= ~ SYS_CLOCK;
	end

end


initial
begin
FSM_ARESET <= 0;
#20 FSM_ARESET <= 1;
#10 FSM_ARESET <= 0;
end

initial
begin
RD_EN <= 1;
WR_EN <= 0;

	forever
	begin
		#1000;
 		RD_EN = ~ RD_EN;
		WR_EN = ~ WR_EN;
	end
end


initial
begin
CONTROL <= '0;

        forever
        begin
                #1000;
                CONTROL <= $urandom ();
        end
end



const time RUN_TIME = 12000;
initial
begin
#RUN_TIME $finish;

end

endmodule : PROJECT_2A_TOP_tb
