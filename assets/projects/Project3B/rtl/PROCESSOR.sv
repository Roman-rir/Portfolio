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

module PROCESSOR_PIPELINED
(
input logic SYS_CLOCK, RST,
input logic [31:0] PM_OUT,
input logic [31:0] DM_OUT,
output logic [31:0] DM_IN,
output logic [3:0] PC,
output logic [3:0] DM_ADDR,
output logic DM_WR,

output logic [31:0] IR1, IR2,
output logic [31:0] ACCUM_R,

output logic [1:0] PSTATE);

///Internal Signals///

logic [31:0] ALU_OUT;
logic [31:0] RF_IN;
logic [3:0] next_PC;
logic [3:0] next_DM_ADDR;
logic [31:0] next_IR1;
logic [31:0] next_IR2;
logic [31:0] next_ACCUM_R;

logic RF_WR;
logic [3:0] RF_WR_ADDR;
logic [31:0] RF [15:0];
logic [1:0] NSTATE;

///IR1 Fields///Execute Stage///

logic [3:0] IR1_TYPE;
logic [3:0] IR1_OPCODE;
logic [3:0] IR1_RD;
logic [3:0] IR1_RS1;
logic [3:0] IR1_RS2;

logic [31:0] IR1_IMM;


assign IR1_TYPE = IR1[31:28];
assign IR1_OPCODE = IR1[27:24];
//assign IR1_RD = IR1[23:20];//not needed
assign IR1_RS1 = IR1[19:16];
assign IR1_RS2 = IR1[15:12];

assign IR1_IMM = {{24{1'b0}},IR1[7:0]};

///IR2 Fields///Writeback Stage///

logic [3:0] IR2_TYPE;
logic [3:0] IR2_RD;
assign IR2_TYPE = IR2[31:28];
assign IR2_RD = IR2[23:20];

///Hazard Forwarding///

logic [31:0]RF_Q1;
logic [31:0]RF_Q2;

logic fwd_rs1;
logic fwd_rs2;

assign fwd_rs1= ((IR2_TYPE==4'd0)||(IR2_TYPE==4'd1)) && (IR2_RD==IR1_RS1);
assign fwd_rs2= ((IR2_TYPE==4'd0)||(IR2_TYPE==4'd1)) && (IR2_RD==IR1_RS2);

assign RF_Q1= fwd_rs1 ? ACCUM_R : RF[IR1_RS1];
assign RF_Q2= fwd_rs2 ? ACCUM_R : (IR2_TYPE==4'd3)? IR2_RD : RF[IR1_RS2];
//assign RF_Q2= fwd_rs2 ? ACCUM_R : RF[IR1_RS2];
//assign RF_WR_ADDR = IR2_RD;
//assign RF_RD_ADDR2 = ((PSTATE == 3'd4) && (INST_TYPE == 4'd3)) ? RF_WR_ADDR : IR[15:12];

///State Machine///

always_comb
begin
NSTATE = 'x;
case(PSTATE) 
3'd0: NSTATE = 3'd1;
3'd1: NSTATE = 3'd2;
3'd2: NSTATE = 3'd2;
default:
      NSTATE = 3'd0;
endcase

{ALU_OUT, DM_WR, RF_WR} = '0;
RF_IN = '0;
DM_IN = '0;
next_PC = PC;
next_DM_ADDR = DM_ADDR;
next_IR1 = IR1;
next_IR2 = IR2;
next_ACCUM_R = ACCUM_R;
//RF_WR_ADDR = IR2_RD;

case(PSTATE)

4'd0: next_PC = 0;
4'd1: begin
next_PC = PC+1;
next_IR1 = PM_OUT;
next_IR2 = IR1;
end

4'd2: 
begin
next_PC = PC+1;
next_IR1 = PM_OUT;
next_IR2 = IR1;


	case(IR1_TYPE)
	///Reg-Reg

	4'd0:
	begin
	case(IR1_OPCODE)

		        4'd0 : ALU_OUT = RF_Q1 + RF_Q2;
		        4'd1 : ALU_OUT = RF_Q1 - RF_Q2;
		        4'd2 : ALU_OUT = RF_Q2 + 1;
		        4'd3 : ALU_OUT = RF_Q2 - 1;
		        4'd4 : ALU_OUT = 32'd0;
		        4'd5 : ALU_OUT = ~RF_Q2;
		        4'd6 : ALU_OUT = {{16{1'b0}},RF_Q2[15:0]};
		        4'd7 : ALU_OUT = RF_Q2;
		        4'd8 : ALU_OUT = RF_Q1 & RF_Q2;
		        4'd9 : ALU_OUT = RF_Q1 | RF_Q2;
		        4'd10: ALU_OUT = RF_Q1 ^ RF_Q2;
		        4'd11: ALU_OUT = ~(RF_Q1 & RF_Q2);
		        4'd12: ALU_OUT = ~(RF_Q1 | RF_Q2);
		        4'd13: ALU_OUT = ~(RF_Q1 ^ RF_Q2);
		        4'd14: ALU_OUT = RF_Q1 << 1;
		        4'd15: ALU_OUT = RF_Q1 >> 1;
	endcase

	next_ACCUM_R = ALU_OUT;
	end

	///Reg-Imm

	4'd1:
	begin
	case(IR1_OPCODE)

		        4'd0 : ALU_OUT = RF_Q1 + IR1_IMM;
		        4'd1 : ALU_OUT = RF_Q1 - IR1_IMM;
		        4'd2 : ALU_OUT = IR1_IMM + 1;
		        4'd3 : ALU_OUT = IR1_IMM - 1;
		        4'd4 : ALU_OUT = 32'd0;
		        4'd5 : ALU_OUT = ~IR1_IMM;
		        4'd6 : ALU_OUT = {{16{1'b0}},IR1_IMM[15:0]};
		        4'd7 : ALU_OUT = IR1_IMM;
		        4'd8 : ALU_OUT = RF_Q1 & IR1_IMM;
		        4'd9 : ALU_OUT = RF_Q1 | IR1_IMM;
		        4'd10: ALU_OUT = RF_Q1 ^ IR1_IMM;
		        4'd11: ALU_OUT = ~(RF_Q1 & IR1_IMM);
		        4'd12: ALU_OUT = ~(RF_Q1 | IR1_IMM);
		        4'd13: ALU_OUT = ~(RF_Q1 ^ IR1_IMM);
		        4'd14: ALU_OUT = RF_Q1 << 1;
		        4'd15: ALU_OUT = RF_Q1 >> 1;
	endcase

	next_ACCUM_R = ALU_OUT;
	end


	4'd2, 4'd3:
	begin
	ALU_OUT = RF_Q1 + RF_Q2;
	next_DM_ADDR = ALU_OUT[3:0];
	next_ACCUM_R = {{28{1'b0}},ALU_OUT[3:0]};
	end

	default:;

	endcase

	///Stage 2 (IR2)///

	case(IR2_TYPE)
	4'd0, 4'd1: 
	begin 
	RF_WR = 1'b1;
	RF_WR_ADDR = IR2_RD;
	RF_IN = ACCUM_R;
	end

	4'd2: //load
	begin
	RF_WR = 1'b1;
	RF_WR_ADDR = IR2_RD;
	RF_IN = DM_OUT;
	end

	4'd3:  //store
	begin
	DM_WR = 1'b1;
	DM_IN = RF_Q2;
	end

	default:;

	endcase
end

default:; 

endcase


end



///Sequestial Logic///

always_ff @(posedge SYS_CLOCK)
begin

	if(RST)
	begin
	PC <= 0;
	IR1 <= 0;
	IR2 <= 0;
	DM_ADDR <= 0;
	ACCUM_R <= 0;

	for(int i=0; i<16; i=i+1)
	RF[i] <= i;

	end

	else
	begin

	PSTATE <= NSTATE;
	PC <= next_PC;
	IR1 <= next_IR1;
	IR2 <= next_IR2;
	DM_ADDR <= next_DM_ADDR;
	ACCUM_R <= next_ACCUM_R;

	if(RF_WR)
	RF[RF_WR_ADDR] <= RF_IN;
	end
end

endmodule

