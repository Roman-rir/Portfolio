//////////////////////////////////////////////////////////////////////////////////////////
/*
The following SystemVerilog RTL/testbench was developed by Dr. Shahriyar Masud Rizvi.

    © 2025 Shahriyar Masud Rizvi

Attribution Requirement:
If you use the following SystemVerilog sources, in whole or in part,
you MUST include visible credit to the original authors in:
  - Documentation or README of your project, OR
  - About/Info section of your tool, OR
  - Academic citation/reference if used in research

Citation Example:
"This project uses work from S. M. Rizvi, "RISC Processor (version V3) Example", RTL Design, Verification, Synthesis & PnR for Digital VLSI Design, American International University-Bangladesh, Dhaka, Bangladesh, 2025."
*/
/////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ps / 1ps
module RISC_V3_tb1;

//Internal signals declarations
logic SYS_CLOCK;
logic RST;
logic [31:0] ACCUM_R;
logic [3:0]  PC, DM_ADDR;
logic [31:0] IR, DM_IN;
logic DM_WR;
logic [2:0] PSTATE;


// Unit Under Test port map
	RISC_V3 DUV (.*);

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


logic [3:0] RF_WR_ADDR;	
logic [3:0] RF_RD_ADDR1;
logic [3:0] RF_RD_ADDR2;

logic RF_WR;
logic [31:0] RF_IN;		 
logic [31:0] RF [15:0];


logic [31:0] D_MEM [15:0];


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

assign RF_IN 	= RISC_V3_tb1.DUV.PC1.RF_IN;

assign RF_WR_ADDR 	= RISC_V3_tb1.DUV.PC1.RF_WR_ADDR;
assign RF_RD_ADDR1 	= RISC_V3_tb1.DUV.PC1.RF_RD_ADDR1;
assign RF_RD_ADDR2 	= RISC_V3_tb1.DUV.PC1.RF_RD_ADDR2;


assign RF_WR 	= RISC_V3_tb1.DUV.PC1.RF_WR;  
assign RF 		= RISC_V3_tb1.DUV.PC1.RF; 


assign D_MEM 	= RISC_V3_tb1.DUV.DM.D_MEM; 

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

time run_time = 230ns;

initial
begin
#run_time;
$finish;
end

endmodule


