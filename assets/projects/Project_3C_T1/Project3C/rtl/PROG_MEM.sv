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

module PROG_MEM 
(input logic [3:0] PC,
output logic [31:0] PM_OUT);

logic [31:0] P_MEM [15:0] ={32'h00000000,	
							32'h00000000,
							32'h00000000,
							32'h00000000,
							32'h00000000,
							32'h00000000,
							32'h00000000,   
							32'h00000000,
							32'h3xxx2x00,//DM[0] <-- RF[2];         (2)
							32'h022x2xxx,//RF[2] <-- RF[2] + 1;	   	(2)
							32'h01001xxx,//RF[0] <-- RF[0] - RF[1];	(1)						
							32'h022x2xxx,//RF[2] <-- RF[2] + 1;	   	(1)
							32'h01001xxx,//RF[0] <-- RF[0] - RF[1];	(8)
							32'h042xxxxx,//RF[2] <-- 0;		  		(0)
							32'h2x1xxx07,//RF[1] <-- DM[7];	 		(7)
							32'h2x0xxx0F //RF[0] <-- DM[15]; 		(15)
};

assign PM_OUT = P_MEM[PC];


endmodule

