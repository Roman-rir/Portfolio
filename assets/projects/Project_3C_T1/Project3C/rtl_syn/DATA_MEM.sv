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

module DATA_MEM 
(input logic RST, DM_WR,
input logic [3:0] DM_ADDR,
input logic [31:0] DM_IN,
output logic [31:0] DM_OUT);

logic [31:0] D_MEM [15:0];

always_latch
begin
	if (RST)	
		begin
		for (int i=0;i<=15;i=i+1)
			D_MEM[i] = i;	
		end	
	else if (DM_WR)
		D_MEM[DM_ADDR] = DM_IN; 
end	

assign DM_OUT = D_MEM[DM_ADDR];

endmodule
