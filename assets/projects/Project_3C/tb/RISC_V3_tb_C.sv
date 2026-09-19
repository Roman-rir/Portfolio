`timescale 1ps / 1ps
module RISC_V3_tb_C;


//Internal signals declarations:
logic SYS_CLOCK;
logic RST;
logic [31:0] ACCUM_R;



// Unit Under Test port map
	RISC_V3 DUV (
		.SYS_CLOCK(SYS_CLOCK),
		.RST(RST),
		.ACCUM_R(ACCUM_R));

initial
begin
$timeformat(-9, 0, " ns", 0);

end


/////////////////////////////////////////////////
////Generator
//////////////////////////////////////////////////

//////////////CLOCK GENERATOR////////////
time CLK_PERIOD = 10ns;
initial 
begin
SYS_CLOCK =0;
	forever
	begin
	#(CLK_PERIOD/2);
	SYS_CLOCK = ~SYS_CLOCK;
	end
end

//////////////RESET GENERATOR////////////

time RST_OFFSET = 2ns;
time RST_WIDTH = 5ns;
initial
begin
RST = '0;
#RST_OFFSET;
RST = '1;
#RST_WIDTH;
RST = '0;
end

/////////////////////////////////////////////////
//Monitor
////////////////////////////////////////////////  

//Internal Signal Definitions for Hierarchical Reference
logic [2:0] PSTATE;	
logic [3:0] PC;
logic [31:0] PM_OUT;
logic [31:0] IR;  

logic [3:0] RF_WR_ADDR;	
logic [3:0] RF_RD_ADDR1;
logic [3:0] RF_RD_ADDR2;
logic [31:0] RF_Q1;
logic [31:0] RF_Q2;
logic [31:0] IMM_DATA;
logic [31:0] ALU_OUT; 
logic RF_WR;
logic [31:0] RF_IN;		 
logic [31:0] RF [15:0];

logic [3:0] DM_ADDR;
logic DM_WR; 
logic [31:0] DM_IN;
logic [31:0] D_MEM [15:0];
logic [31:0] DM_OUT;
logic [3:0] BRANCH_DIR;
//Extra	 
/*
logic [31:0] next_IR;
logic [3:0] next_PC;
logic [3:0] next_DM_ADDR;

logic [3:0] INST_TYPE;
logic [3:0] OPCODE;
logic [3:0] BRANCH_DIR; 

logic [3:0] RF_RD_ADDR1;
logic [3:0] RF_RD_ADDR2;
logic [3:0] RF_WR_ADDR;

logic [2:0] NSTATE;
*/	 

//Hierarchical References 
assign PM_OUT  	= RISC_V3_tb_C.DUV.PM_OUT;	
assign DM_OUT  	= RISC_V3_tb_C.DUV.DM_OUT;
assign DM_IN   	= RISC_V3_tb_C.DUV.DM_IN;
assign PC      	= RISC_V3_tb_C.DUV.PC;
assign DM_ADDR 	= RISC_V3_tb_C.DUV.DM_ADDR;
assign DM_WR	= RISC_V3_tb_C.DUV.DM_WR;  

assign ALU_OUT 	= RISC_V3_tb_C.DUV.PC1.ALU_OUT;
assign IR 		= RISC_V3_tb_C.DUV.PC1.IR;
assign RF_IN 	= RISC_V3_tb_C.DUV.PC1.RF_IN;
assign RF_Q1 	= RISC_V3_tb_C.DUV.PC1.RF_Q1;
assign RF_Q2 	= RISC_V3_tb_C.DUV.PC1.RF_Q2;
assign RF_WR_ADDR 	= RISC_V3_tb_C.DUV.PC1.RF_WR_ADDR;
assign RF_RD_ADDR1 	= RISC_V3_tb_C.DUV.PC1.RF_RD_ADDR1;
assign RF_RD_ADDR2 	= RISC_V3_tb_C.DUV.PC1.RF_RD_ADDR2;
assign BRANCH_DIR = RISC_V3_tb_C.DUV.PC1.BRANCH_DIR;

assign IMM_DATA = RISC_V3_tb_C.DUV.PC1.IMM_DATA;
assign RF_WR 	= RISC_V3_tb_C.DUV.PC1.RF_WR;  
assign RF 		= RISC_V3_tb_C.DUV.PC1.RF; 
assign PSTATE 	= RISC_V3_tb_C.DUV.PC1.PSTATE;

assign D_MEM 	= RISC_V3_tb_C.DUV.DM.D_MEM; 


initial
begin
    forever
    begin
        @(posedge SYS_CLOCK);
        $strobe("Time=%4t, PSTATE=%0d, PC=%0d, IR=%h, BR_DIR=%0d, IMM=%0d, RF_Q1=%0d, RF_Q2=%0d, ALU_OUT=%0d, ACCUM_R=%0d",
        $time, PSTATE, PC, IR, BRANCH_DIR, IMM_DATA, RF_Q1, RF_Q2, ALU_OUT, ACCUM_R);
    end
end

/*
initial
begin
        forever
        begin
        @(posedge SYS_CLOCK); 
        $strobe("Time = %4t,\tPSTATE = %1d,\tDATA = %2d,\tX_OUT = %2d,\tC_OUT = %2d,\tPROD = %2d,\tY =%4d", $time, PSTATE, DATA, X_OUT, C_OUT, PROD, Y);
        end
end
*/
/////////////////////////////////////////////////
//Simulation Control
////////////////////////////////////////////////

time run_time = 600ns;

initial
begin
#run_time;
$finish;
end

endmodule


