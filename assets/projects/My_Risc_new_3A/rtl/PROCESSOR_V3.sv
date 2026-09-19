//////////////////////////////////////////////////////////////////////////////////////////
/*
The following SystemVerilog RTL/testbench was developed by Dr. Shahriyar Masud Rizvi.

    Â© 2025 Shahriyar Masud Rizvi

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
(
    input  logic        SYS_CLOCK,
    input  logic        RST,

    input  logic [31:0] PM_OUT,
    input  logic [31:0] DM_OUT,

    output logic [31:0] DM_IN,
    output logic [3:0]  PC,
    output logic [3:0]  DM_ADDR,
    output logic        DM_WR,
    output logic [31:0] IR,
    output logic [31:0] ACCUM_R,
    output logic [2:0]  PSTATE
);

// Internal signal definitions
logic [31:0] ALU_OUT;
logic [3:0]  next_PC;
logic [3:0]  next_DM_ADDR;
logic [3:0]  RF_RD_ADDR1;
logic [3:0]  RF_RD_ADDR2;
logic [3:0]  RF_WR_ADDR;
logic [3:0]  INST_TYPE;
logic [3:0]  OPCODE;
logic [3:0]  BRANCH_DIR;
logic [31:0] RF_Q1;
logic [31:0] RF_Q2;
logic [31:0] IMM_DATA;
logic [31:0] RF_IN;
logic [31:0] next_IR;
logic        RF_WR;
logic [31:0] RF [15:0];
logic [2:0]  NSTATE;

// Segments of Instruction Register (IR)		 
assign INST_TYPE  = IR[31:28];
assign OPCODE     = IR[27:24];	
assign RF_WR_ADDR = IR[23:20];	
assign RF_RD_ADDR1 = IR[19:16];

// Normally RF_Q2 reads Rs2 = IR[15:12].
// For STORE in state 4, RF_Q2 must read Rd, because:
// State 2: DM_ADDR <= RF[Rs1] + RF[Rs2]
// State 4: DM_IN   <= RF[Rd]
assign RF_RD_ADDR2 =
    ((PSTATE == 3'd4) && (INST_TYPE == 4'd3)) ? RF_WR_ADDR : IR[15:12];

assign BRANCH_DIR = IR[11:8];
assign IMM_DATA   = {{24{1'b0}}, IR[7:0]};

// Outputs of Register File	 
assign RF_Q1 = RF[RF_RD_ADDR1];
assign RF_Q2 = RF[RF_RD_ADDR2];

// Instruction Format
// Type, Opcode, Rd, Rs1, Rs2, Branch Directive, Immediate Data
// 4,    4,      4,  4,   4,   4,                8  
// 31:28,27:24, 23:20, 19:16, 15:12, 11:8,      7:0

// Combinational FSMD control/datapath
always_comb
begin
    NSTATE = 'x;	

    case (PSTATE)
        3'd0: NSTATE = 3'd1;
        3'd1: NSTATE = 3'd2;
        3'd2: begin
            if (INST_TYPE == 4'd2)
                NSTATE = 3'd3;	
            else if (INST_TYPE == 4'd3)
                NSTATE = 3'd4;	
            else
                NSTATE = 3'd1;
        end
        3'd3: NSTATE = 3'd1;
        3'd4: NSTATE = 3'd1;				  
        default: NSTATE = 3'd0;
    endcase	

    {ALU_OUT, DM_WR, RF_WR} = '0;	 
    next_PC      = PC; 
    next_DM_ADDR = DM_ADDR;	
    next_IR      = IR;  
    RF_IN        = '0;	  
    DM_IN        = '0;

    case (PSTATE)
        3'd0: begin
            next_PC = 4'd0;
        end

        3'd1: begin 
            next_PC = PC + 4'd1;
            next_IR = PM_OUT;
        end

        // Type, Opcode, Rd, Rs1, Rs2, Branch Directive, Immediate Data
        // 4,    4,      4,  4,   4,   4,                8 
        // 31:28,27:24, 23:20, 19:16, 15:12, 11:8,      7:0
        3'd2: begin
            case (INST_TYPE) 
                4'd0: begin // Register-Register Instruction
                    RF_WR = 1'b1;
                    case (OPCODE)
                        4'd0 : ALU_OUT = RF_Q1 + RF_Q2;	
                        4'd1 : ALU_OUT = RF_Q1 - RF_Q2;
                        4'd2 : ALU_OUT = RF_Q2 + 32'd1;
                        4'd3 : ALU_OUT = RF_Q2 - 32'd1;
                        4'd4 : ALU_OUT = '0;
                        4'd5 : ALU_OUT = ~RF_Q2;
                        4'd6 : ALU_OUT = {{16{1'b0}}, RF_Q2[15:0]};
                        4'd7 : ALU_OUT = RF_Q2;
                        4'd8 : ALU_OUT = RF_Q1 & RF_Q2;
                        4'd9 : ALU_OUT = RF_Q1 | RF_Q2;
                        4'd10: ALU_OUT = RF_Q1 ^ RF_Q2;
                        4'd11: ALU_OUT = ~(RF_Q1 & RF_Q2);
                        4'd12: ALU_OUT = ~(RF_Q1 | RF_Q2);
                        4'd13: ALU_OUT = ~(RF_Q1 ^ RF_Q2);
                        4'd14: ALU_OUT = RF_Q1 << 1;
                        4'd15: ALU_OUT = RF_Q1 >> 1;
                        default: ALU_OUT = 'x;
                    endcase	  
                    RF_IN = ALU_OUT;
                end				

                4'd1: begin // Register-Immediate Instruction
                    RF_WR = 1'b1;
                    case (OPCODE)
                        4'd0 : ALU_OUT = RF_Q1 + IMM_DATA;	
                        4'd1 : ALU_OUT = RF_Q1 - IMM_DATA;
                        4'd2 : ALU_OUT = IMM_DATA + 32'd1;
                        4'd3 : ALU_OUT = IMM_DATA - 32'd1;
                        4'd4 : ALU_OUT = '0;
                        4'd5 : ALU_OUT = ~IMM_DATA;
                        4'd6 : ALU_OUT = {{16{1'b0}}, IMM_DATA[15:0]};
                        4'd7 : ALU_OUT = IMM_DATA;
                        4'd8 : ALU_OUT = RF_Q1 & IMM_DATA;
                        4'd9 : ALU_OUT = RF_Q1 | IMM_DATA;
                        4'd10: ALU_OUT = RF_Q1 ^ IMM_DATA;
                        4'd11: ALU_OUT = ~(RF_Q1 & IMM_DATA);
                        4'd12: ALU_OUT = ~(RF_Q1 | IMM_DATA);
                        4'd13: ALU_OUT = ~(RF_Q1 ^ IMM_DATA);
                        4'd14: ALU_OUT = RF_Q1 << 1;
                        4'd15: ALU_OUT = RF_Q1 >> 1;
                        default: ALU_OUT = 'x;
                    endcase	
                    RF_IN = ALU_OUT;
                end	

                4'd2, 4'd3: begin
                    // First stage of LOAD/STORE instruction.
                    // Indirect address calculation through the ALU:
                    // Effective Address EA = RF[Rs1] + RF[Rs2].
                    ALU_OUT      = RF_Q1 + RF_Q2;
                    next_DM_ADDR = ALU_OUT[3:0];
                end

                default: begin
                end
            endcase		  
        end

        3'd3: begin
            // Second stage of LOAD instruction:
            // RF[RF_WR_ADDR] <-- DM_OUT
            RF_IN = DM_OUT; 
            RF_WR = 1'b1; 		        							   
        end	

        3'd4: begin
            // Second stage of STORE instruction:
            // DM[RF[Rs1]+RF[Rs2]] <-- RF[Rd].
            // In this state, RF_RD_ADDR2 is changed to RF_WR_ADDR,
            // so RF_Q2 = RF[Rd].
            DM_WR   = 1'b1; 
            ALU_OUT = RF_Q2;
            DM_IN   = ALU_OUT;
        end

        default: begin
        end
    endcase	
end

// Sequential state/datapath registers
always_ff @(posedge SYS_CLOCK)
begin
    if (RST)
    begin
        PSTATE  <= '0;
        PC      <= '0;
        DM_ADDR <= '0;
        IR      <= '0;
        ACCUM_R <= '0;

        for (int i = 0; i <= 15; i = i + 1)
            RF[i] <= i;	 			
    end	
    else
    begin
        PSTATE  <= NSTATE; 
        PC      <= next_PC; 
        DM_ADDR <= next_DM_ADDR;	
        IR      <= next_IR;
        ACCUM_R <= ALU_OUT;	

        if (RF_WR)
            RF[RF_WR_ADDR] <= RF_IN; 		
    end	
end

endmodule

