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

module PROCESSOR_V3 
(input logic SYS_CLOCK, RST,
input logic [31:0] PM_OUT, DM_OUT,
output logic [31:0] DM_IN,
output logic [3:0] PC, DM_ADDR,
output logic DM_WR,
output logic [31:0] IR, RF_Q1, RF_Q2, IMM_DATA, ALU_OUT,
output logic [2:0] PSTATE);
 							
//Internal Signal Definitions
//logic [31:0] ALU_OUT;
logic [3:0] next_PC, next_DM_ADDR, RF_RD_ADDR1, RF_RD_ADDR2, RF_WR_ADDR;
logic [3:0] INST_TYPE, OPCODE, BRANCH_DIR; 
//logic [31:0] RF_Q1, RF_Q2, IMM_DATA;
logic [31:0] RF_IN, /*IR,*/ next_IR;
logic RF_WR;	 
logic [31:0] RF [15:0];
logic [2:0] /*PSTATE,*/ NSTATE;
logic signed [31:0] PC_OFFSET; //added code---------------------------------------------

//Segments of Instruction Register (IR)		 
assign INST_TYPE = IR[31:28];
assign OPCODE = IR[27:24];	
assign RF_WR_ADDR = IR[23:20];	
assign RF_RD_ADDR1 = IR[19:16];
assign RF_RD_ADDR2 = IR[15:12]; 
assign BRANCH_DIR = IR[11:8];
assign IMM_DATA = { {24{1'b0}},IR[7:0]};
assign PC_OFFSET = {{24{IR[7]}}, IR[7:0]};
//Outputs of Register File	 
assign RF_Q1 = RF[RF_RD_ADDR1];
assign RF_Q2 = RF[RF_RD_ADDR2];	 

//Instruction Format
// Type, Opcode, Rd, Rs1, Rs2, Branch Directive, Immediate Data
//   4,    4,     4,  4,   4,  4,                8  
// 31:28, 27:24, 23:20,	19:16  15:12	  11:8             7:0

//FSMD
always_comb
begin
	NSTATE = 'x;	

	case (PSTATE)
	0: 	NSTATE = 1;
	1: 	NSTATE = 2;
	2:  if (INST_TYPE == 2)
			NSTATE = 3;	
		else if (INST_TYPE == 3)
			NSTATE = 4;	
	    else NSTATE = 1;	
	3:	NSTATE = 1;
	4:  NSTATE = 1;				  
	default: NSTATE = 0;
	endcase	
	   
	{ALU_OUT, DM_WR, RF_WR} = '0;	 
	next_PC = PC; 
	next_DM_ADDR = DM_ADDR;	
	next_IR = IR;  
	RF_IN = '0;	  
	DM_IN = 'x;
	
	case (PSTATE)
	0: 	next_PC = 0;
	1: 	begin 
		next_PC = PC+1;
		next_IR = PM_OUT;
		end
	// Type, Opcode, Rd,     Rs1,   Rs2,   Branch Directive, Immediate Data
	//   4,    4,     4,     4,     4,         4,                8 
	// 31:28, 27:24, 23:20,	19:16  15:12	  11:8             7:0
	
	2: 	case (INST_TYPE) 
		    
		0: 	begin	//Register-Register Instruction
			RF_WR = 1;
				case (OPCODE)
				0: ALU_OUT = RF_Q1 + RF_Q2;	
				1: ALU_OUT = RF_Q1 - RF_Q2;
				2: ALU_OUT = RF_Q2 + 1;
				3: ALU_OUT = RF_Q2 - 1;
				4: ALU_OUT = '0;
				5: ALU_OUT = ~RF_Q2;
				6: ALU_OUT = { {16{1'b0}},RF_Q2[15:0]};
				7: ALU_OUT = RF_Q2;
				8: ALU_OUT = RF_Q1 & RF_Q2;
				9: ALU_OUT = RF_Q1 | RF_Q2;
				10: ALU_OUT = RF_Q1 ^ RF_Q2;
				11: ALU_OUT = ~(RF_Q1 & RF_Q2);
				12: ALU_OUT = ~(RF_Q1 | RF_Q2);
				13: ALU_OUT = ~(RF_Q1 ^ RF_Q2);
				14:	ALU_OUT = RF_Q1 << 1;
				15:	ALU_OUT = RF_Q1 >> 1;
				default: ALU_OUT = 'x;
				endcase	  
				RF_IN = ALU_OUT;
			end				
			1: 	begin  //Register-Immediate Instruction
				RF_WR = 1;
				case (OPCODE)
				0: ALU_OUT = RF_Q1 + IMM_DATA;	
				1: ALU_OUT = RF_Q1 - IMM_DATA;
				2: ALU_OUT = IMM_DATA + 1;
				3: ALU_OUT = IMM_DATA - 1;
				4: ALU_OUT = '0;
				5: ALU_OUT = ~IMM_DATA;
				6: ALU_OUT = { {16{1'b0}},IMM_DATA[15:0]};
				7: ALU_OUT = IMM_DATA;
				8: ALU_OUT = RF_Q1 & IMM_DATA;
				9: ALU_OUT = RF_Q1 | IMM_DATA;
				10: ALU_OUT = RF_Q1 ^ IMM_DATA;
				11: ALU_OUT = ~(RF_Q1 & IMM_DATA);
				12: ALU_OUT = ~(RF_Q1 | IMM_DATA);
				13: ALU_OUT = ~(RF_Q1 ^ IMM_DATA);
				14:	ALU_OUT = RF_Q1 << 1;
				15:	ALU_OUT = RF_Q1 >> 1;
				default: ALU_OUT = 'x;
				endcase	
				RF_IN = ALU_OUT;
			end	
			2,3:	begin
					next_DM_ADDR = IMM_DATA[3:0];  //First Stage of Load/Store Instruction
			        							   //Address Calculation for Data Memory
					ALU_OUT = next_DM_ADDR;  //This passes address calculation to ALU_OUT (not necessary)
					                         //only to make the architecture similar to my version of DORITO 
					end
			4:	 begin   // BRANCH instruction
			    // Use ALU_OUT as comparison source (Rs1 - Rs2)
    				ALU_OUT = RF_Q1 - RF_Q2;

    				case (BRANCH_DIR)
        			4'b0000: if (ALU_OUT == 0)
                    			next_PC = PC + PC_OFFSET;
        			4'b0001: if ($signed(ALU_OUT) > 0)
                   			next_PC = PC + PC_OFFSET;
        			4'b0010: if ($signed(ALU_OUT) < 0)
                    			next_PC = PC + PC_OFFSET;
        			4'b0011: begin
                    			next_PC = PC + PC_OFFSET;
                		 end
        			default: ;
    				endcase
				end

			default:;
			endcase		  
			
	3: 	begin			//Second Stage of Load Instruction (RF[RF_WR_ADDR] <--DM_OUT) 
		RF_IN = DM_OUT; 
		RF_WR = 1; 		        							   
		end	
	
	4: 	begin			//Second Stage of Store Instruction (DM[DM_ADDR] <-- RF_Q2); 
		DM_WR = 1; 
		ALU_OUT = RF_Q2; //This passes RF_Q2 to ALU_OUT only to make the architecture similar to my version of DORITO 
		DM_IN = ALU_OUT;
		end
	default:;
	endcase	
end

always_ff@(posedge SYS_CLOCK)
begin
	if (RST)
	begin
		PSTATE <= '0;
		for (int i=0;i<=15;i=i+1)
			RF[i] <= i;	 			
	end	
		
	else
	begin
		PSTATE <= NSTATE; 
		PC <= next_PC; 
		DM_ADDR <= next_DM_ADDR;	
		IR <= next_IR;	
		
		if (RF_WR)
			RF[RF_WR_ADDR] <= RF_IN; 		
	end	
end


endmodule

