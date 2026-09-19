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


`timescale 1ns/1ps

module RISC_V3_tb;

logic SYS_CLOCK;
logic RST;
logic [31:0] ACCUM_R;

//////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////

RISC_V3 DUV
(
    .SYS_CLOCK(SYS_CLOCK),
    .RST(RST),
    .ACCUM_R(ACCUM_R)
);

//////////////////////////////////////////////////////
// Clock Generation
//////////////////////////////////////////////////////

initial
begin
    $timeformat(-9,0," ns",0);
end

time CLK_PERIOD = 10ns;

initial
begin
    SYS_CLOCK = 0;

    forever
    begin
        #(CLK_PERIOD/2);
        SYS_CLOCK = ~SYS_CLOCK;
    end
end

//////////////////////////////////////////////////////
// Reset Generation
//////////////////////////////////////////////////////

time RST_OFFSET = 2ns;
time RST_WIDTH  = 5ns;

initial
begin
    RST = 0;

    #RST_OFFSET;
    RST = 1;

    #RST_WIDTH;
    RST = 0;
end

//////////////////////////////////////////////////////
// Internal Signal Probes
//////////////////////////////////////////////////////

logic [31:0] PM_OUT;
logic [31:0] DM_OUT;
logic [31:0] DM_IN;

logic [3:0] PC;
logic [3:0] DM_ADDR;
logic DM_WR;

logic [31:0] ALU_OUT;

logic [31:0] IR1;
logic [31:0] IR2;

logic [31:0] next_IR1;
logic [31:0] next_IR2;

logic [31:0] RF_IN;

logic RF_WR;

logic [31:0] RF [15:0];

logic [3:0] next_PC;
logic [3:0] next_DM_ADDR;

logic [31:0] RF_Q1;
logic [31:0] RF_Q2;

logic [3:0] IR1_TYPE;
logic [3:0] IR1_OPCODE;
logic [3:0] IR1_RD;
logic [3:0] IR1_RS1;
logic [3:0] IR1_RS2;
logic [31:0] IR1_IMM;

logic [3:0] IR2_TYPE;
logic [3:0] IR2_RD;

logic [2:0] PSTATE;
logic [2:0] NSTATE;

logic fwd_rs1;
logic fwd_rs2;

logic [31:0] D_MEM [15:0];

//////////////////////////////////////////////////////
// Hierarchical Connection
//////////////////////////////////////////////////////

assign PM_OUT       = DUV.PM_OUT;
assign DM_OUT       = DUV.DM_OUT;
assign DM_IN        = DUV.DM_IN;

assign PC           = DUV.PC;
assign DM_ADDR      = DUV.DM_ADDR;
assign DM_WR        = DUV.DM_WR;

assign ALU_OUT      = DUV.PC1.ALU_OUT;

assign IR1          = DUV.PC1.IR1;
assign IR2          = DUV.PC1.IR2;

assign next_IR1     = DUV.PC1.next_IR1;
assign next_IR2     = DUV.PC1.next_IR2;

assign RF_IN        = DUV.PC1.RF_IN;
assign RF_WR        = DUV.PC1.RF_WR;

assign next_PC      = DUV.PC1.next_PC;
assign next_DM_ADDR = DUV.PC1.next_DM_ADDR;

assign RF_Q1        = DUV.PC1.RF_Q1;
assign RF_Q2        = DUV.PC1.RF_Q2;

assign IR1_TYPE     = DUV.PC1.IR1_TYPE;
assign IR1_OPCODE   = DUV.PC1.IR1_OPCODE;
assign IR1_RD       = DUV.PC1.IR1_RD;
assign IR1_RS1      = DUV.PC1.IR1_RS1;
assign IR1_RS2      = DUV.PC1.IR1_RS2;
assign IR1_IMM      = DUV.PC1.IR1_IMM;

assign IR2_TYPE     = DUV.PC1.IR2_TYPE;
assign IR2_RD       = DUV.PC1.IR2_RD;

assign PSTATE       = DUV.PC1.PSTATE;
assign NSTATE       = DUV.PC1.NSTATE;

assign fwd_rs1      = DUV.PC1.fwd_rs1;
assign fwd_rs2      = DUV.PC1.fwd_rs2;

assign RF           = DUV.PC1.RF;

assign D_MEM        = DUV.DM.D_MEM;

//////////////////////////////////////////////////////
// Pipeline Monitor
//////////////////////////////////////////////////////

initial
begin
    forever
    begin
        @(posedge SYS_CLOCK);

        $strobe(
        "TIME=%0t  PSTATE=%0d  PC=%0d  IR1=%h  IR2=%h  ALU_OUT=%0d  ACCUM=%0d",
        $time,
        PSTATE,
        PC,
        IR1,
        IR2,
        ALU_OUT,
        ACCUM_R
        );
    end
end

//////////////////////////////////////////////////////
// Decode Monitor
//////////////////////////////////////////////////////

initial
begin
    forever
    begin

        @(posedge SYS_CLOCK);

        $strobe(
        "TIME=%0t  IR1_TYPE=%0d OPC=%0d RD=%0d RS1=%0d RS2=%0d IMM=%0d | IR2_TYPE=%0d IR2_RD=%0d | RF_Q1=%0d RF_Q2=%0d | FWD1=%0b FWD2=%0b | RF_WR=%0b RF_IN=%0d | DM_ADDR=%0d DM_OUT=%0d DM_WR=%0b DM_IN=%0d",
        $time,
        IR1_TYPE,
        IR1_OPCODE,
        IR1_RD,
        IR1_RS1,
        IR1_RS2,
        IR1_IMM,

        IR2_TYPE,
        IR2_RD,

        RF_Q1,
        RF_Q2,

        fwd_rs1,
        fwd_rs2,

        RF_WR,
        RF_IN,

        DM_ADDR,
        DM_OUT,
        DM_WR,
        DM_IN
        );

    end
end

//////////////////////////////////////////////////////
// Register Dump
//////////////////////////////////////////////////////

initial
begin
    forever
    begin

        @(posedge SYS_CLOCK);

        $strobe(
        "RF[1]=%0d RF[2]=%0d RF[3]=%0d RF[4]=%0d RF[15]=%0d",
        RF[1],
        RF[2],
        RF[3],
        RF[4],
        RF[15]
        );

    end
end

//////////////////////////////////////////////////////
// Memory Dump
//////////////////////////////////////////////////////

initial
begin
    forever
    begin

        @(posedge SYS_CLOCK);

        $strobe(
        "DM[0]=%0d DM[1]=%0d DM[2]=%0d DM[3]=%0d DM[7]=%0d DM[15]=%0d",
        D_MEM[0],
        D_MEM[1],
        D_MEM[2],
        D_MEM[3],
        D_MEM[7],
        D_MEM[15]
        );

    end
end

//////////////////////////////////////////////////////
// End of Simulation
//////////////////////////////////////////////////////

time run_time = 500ns;

initial
begin

    #run_time;

    $display("========================================");
    $display("FINAL RESULTS");
    $display("========================================");

    $display("RF[1]  = %0d", RF[1]);
    $display("RF[2]  = %0d", RF[2]);
    $display("RF[3]  = %0d", RF[3]);
    $display("RF[4]  = %0d", RF[4]);

    $display("DM[3]  = %0d", D_MEM[3]);

    if(D_MEM[3] == 32'd2)
        $display("PASS : Quotient correctly stored in DM[3]");
    else
        $display("FAIL : Expected DM[3]=2, Found DM[3]=%0d", D_MEM[3]);

    $finish;
end

endmodule
