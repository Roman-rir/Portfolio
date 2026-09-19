`timescale 1ns/1ps
module PROCESSOR_V3 
(input  logic        SYS_CLOCK, RST,
 input  logic [31:0] PM_OUT, DM_OUT,
 output logic [31:0] DM_IN,
 output logic [3:0]  PC, DM_ADDR,
 output logic        DM_WR,
 output logic [31:0] IR, ACCUM_R,
 output logic [2:0]  PSTATE);


//Internal Signal Definitions
logic [31:0] ALU_OUT;
logic [3:0] next_PC, next_DM_ADDR, RF_RD_ADDR1, RF_RD_ADDR2, RF_WR_ADDR;
logic [3:0] INST_TYPE, OPCODE, BRANCH_DIR; 
logic [31:0] RF_Q1, RF_Q2, IMM_DATA;
logic [31:0] RF_IN, next_IR;
logic RF_WR;	 
logic [31:0] RF [15:0];
logic [2:0] NSTATE;


// Instruction Register Field Extraction

assign INST_TYPE   = IR[31:28];
assign OPCODE      = IR[27:24];

assign RF_WR_ADDR  = IR[23:20];

assign RF_RD_ADDR1 = IR[19:16];

assign RF_RD_ADDR2 =((PSTATE == 3'd4) && (INST_TYPE == 4'd3))? RF_WR_ADDR: IR[15:12];

assign BRANCH_DIR  = IR[11:8];

assign IMM_DATA = {{24{IR[7]}}, IR[7:0]}; // Sign Extended Immediate


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
					// First Stage of Load/Store Instruction
					// Indirect address calculation through the ALU:
					// Effective Address EA = RF[Rs1] + RF[Rs2].
					ALU_OUT = RF_Q1 + RF_Q2;
					next_DM_ADDR = ALU_OUT[3:0];
					end
	               4:
                          begin

                          ALU_OUT = RF_Q1 - RF_Q2;

                         case (BRANCH_DIR)

                         // Branch if Zero
                         4'b0000:
                              if (ALU_OUT == 0)
                              next_PC = PC + IMM_DATA;

                        // Branch if Positive
                        4'b0001:
                         if ($signed(ALU_OUT) > 0)
                         next_PC = PC + IMM_DATA;

                       // Branch if Negative
                       4'b0010:
                         if ($signed(ALU_OUT) < 0)
                        next_PC = PC + IMM_DATA;

                        // Branch Always
                         4'b0011:
                         next_PC = PC + IMM_DATA;
          
                        default: ;

                    endcase

                end

        default: ;

    endcase
			
	3: 	begin			//Second Stage of Load Instruction (RF[RF_WR_ADDR] <--DM_OUT) 
		RF_IN = DM_OUT; 
		RF_WR = 1; 		        							   
		end	
	
	4: 	begin			//Second Stage of Store Instruction
		// Store format for indirect addressing:
		// DM[RF[Rs1]+RF[Rs2]] <-- RF[Rd].
		DM_WR = 1; 
		ALU_OUT = RF_Q2;
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
		ACCUM_R <= '0;
		for (int i=0;i<=15;i=i+1)
			RF[i] <= i;	 			
	end	
		
	else
	begin
		PSTATE <= NSTATE; 
		PC <= next_PC; 
		DM_ADDR <= next_DM_ADDR;	
		IR <= next_IR;
		ACCUM_R <= ALU_OUT;	
		
		if (RF_WR)
			RF[RF_WR_ADDR] <= RF_IN; 		
	end	
end


endmodule





