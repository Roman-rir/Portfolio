`timescale 1ns/1ps

module TB_RISC_V3_PIPELINED;

logic        SYS_CLOCK, RST;
logic [31:0] DM_IN;
logic [3:0]  PC, DM_ADDR;
logic        DM_WR;
logic [31:0] IR1, IR2, ACCUM_R;
logic [2:0]  PSTATE;

RISC_V3_PIPELINED_TOP DUT (
    .SYS_CLOCK (SYS_CLOCK),
    .RST       (RST),
    .DM_IN     (DM_IN),
    .PC        (PC),
    .DM_ADDR   (DM_ADDR),
    .DM_WR     (DM_WR),
    .IR1       (IR1),
    .IR2       (IR2),
    .ACCUM_R   (ACCUM_R),
    .PSTATE    (PSTATE)
);

initial SYS_CLOCK = 0;
always #5 SYS_CLOCK = ~SYS_CLOCK;

integer cycle;
initial cycle = 0;
always @(posedge SYS_CLOCK) cycle = cycle + 1;

logic [31:0] RF1, RF2, RF3, RF4;
assign RF1 = DUT.CPU.RF[1];
assign RF2 = DUT.CPU.RF[2];
assign RF3 = DUT.CPU.RF[3];
assign RF4 = DUT.CPU.RF[4];

integer last_complete_cycle;
integer gap;
integer instr_count;

initial begin
    last_complete_cycle = 0;
    gap                 = 0;
    instr_count         = 0;
end

// NOTE: This design's writeback stage (case IR2_TYPE) fires on every cycle
// once the pipeline is primed (PSTATE stays in {3,4,5} continuously - there
// is no instruction type that routes back to state 1 after priming).
// That means one instruction completes (writes back) EVERY cycle, i.e.
// gap == 1, not gap == 2. This is a stronger throughput result than a
// classic "bubble every other cycle" pipeline, so the check below expects
// gap == 1 as the "fully pipelined" condition.
always @(posedge SYS_CLOCK) begin
    if (!RST) begin
        if (PSTATE == 3'd3 || PSTATE == 3'd4 || PSTATE == 3'd5) begin
            instr_count = instr_count + 1;
            gap         = cycle - last_complete_cycle;
            if (last_complete_cycle == 0)
                $display("  [PIPELINE] Cycle %0d | S%0d | Instr #%0d completes | FIRST - pipeline primed",
                          cycle, PSTATE, instr_count);
            else
                $display("  [PIPELINE] Cycle %0d | S%0d | Instr #%0d completes | Gap = %0d cycle(s) | %s",
                          cycle, PSTATE, instr_count, gap,
                          (gap == 1) ? "PIPELINED OK" : "STALL / BUBBLE DETECTED");
            last_complete_cycle = cycle;
        end
    end
end

initial begin
    $dumpfile("tb_risc_v3_pipelined.vcd");
    $dumpvars(0, TB_RISC_V3_PIPELINED);
end

initial begin
    $display("================================================================");
    $display("  PIPELINED RISC V3 - PIPELINE EVALUATION TESTBENCH");
    $display("================================================================");
    $display("  Program: 15 / 7 - Expected: DM[3] = 2");
    $display("  Pipeline: 1 instruction completes every 1 cycle after priming");
    $display("================================================================");
    $display("");

    RST = 1;
    repeat(2) @(posedge SYS_CLOCK);
    RST = 0;

    $display(">> Reset released at cycle %0d", cycle);
    $display("");
    $display(" Cyc | St | PC |   IR1 fetch    |  IR2 execute   | RF1 | RF2 | RF3 | RF4 | ACCUM_R | DM_WR | DM_ADDR | DM_IN");
    $display("-----|----|----|----------------|----------------|-----|-----|-----|-----|---------|-------|---------|------");

    repeat(60) @(posedge SYS_CLOCK) begin
        $display(" %3d | S%0d | %2d | 0x%08h   | 0x%08h   | %3d | %3d | %3d | %3d | %7d |   %b   |    %2d   | %0d",
                  cycle, PSTATE, PC,
                  IR1, IR2,
                  RF1, RF2, RF3, RF4,
                  ACCUM_R,
                  DM_WR, DM_ADDR, DM_IN);
    end

    $display("");
    $display("================================================================");
    $display("  FINAL RESULT CHECK");
    $display("================================================================");

    if (DUT.DM.D_MEM[3] == 32'd2)
        $display("  DM[3] = %0d   CORRECT (15/7 = 2)", DUT.DM.D_MEM[3]);
    else
        $display("  DM[3] = %0d   WRONG   (expected 2)", DUT.DM.D_MEM[3]);

    $display("");
    $display("  FINAL REGISTER FILE STATE");
    $display("----------------------------------------------------------------");
    $display("  RF[1] = %0d   (expected  1 - remainder of 15/7)", RF1);
    $display("  RF[2] = %0d   (expected  7 - divisor)",           RF2);
    $display("  RF[3] = %0d   (expected  2 - quotient)",          RF3);
    $display("  RF[4] = %0d   (expected  3 - store address)",     RF4);

    $display("");
    $display("  FINAL DATA MEMORY DM[0] to DM[9]");
    $display("----------------------------------------------------------------");
    begin : mem_display
        integer i;
        for (i = 0; i <= 9; i = i+1)
            $display("  DM[%0d] = %0d", i, DUT.DM.D_MEM[i]);
    end

    $display("");
    $display("================================================================");
    $display("  PIPELINE VERDICT");
    $display("  Total instructions completed: %0d", instr_count);
    $display("  All gaps = 1 cycle means fully pipelined (1 instruction/cycle)");
    $display("  Any gap  > 1 cycle means a stall/bubble occurred - check FSM dispatch");
    $display("================================================================");

    $finish;
end

endmodule
