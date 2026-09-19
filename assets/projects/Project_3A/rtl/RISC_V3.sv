//----------------------------//////////////////////////////////////////////////////////////////////////////////////////
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
/////////////////////////////////////////////////////////////////////////////////////////////-------------------------------------------------

`timescale 1ns/1ps
module RISC_V3 
(input  logic        SYS_CLOCK, RST,
 output logic [31:0] DM_IN,
 output logic [3:0]  PC, DM_ADDR,
 output logic        DM_WR,
 output logic [31:0] IR, ACCUM_R,
 output logic [2:0]  PSTATE);

// Internal memory-to-processor buses
logic [31:0] PM_OUT, DM_OUT;

PROCESSOR_V3 PC1 (
    .SYS_CLOCK (SYS_CLOCK),
    .RST       (RST),
    .PM_OUT    (PM_OUT),
    .DM_OUT    (DM_OUT),
    .DM_IN     (DM_IN),
    .PC        (PC),
    .DM_ADDR   (DM_ADDR),
    .DM_WR     (DM_WR),
    .IR        (IR),
    .ACCUM_R   (ACCUM_R),
    .PSTATE    (PSTATE)
);

PROG_MEM PM (
    .PC     (PC),
    .PM_OUT (PM_OUT)
); 

DATA_MEM DM (
    .SYS_CLOCK (SYS_CLOCK),
    .RST       (RST),
    .DM_WR     (DM_WR),
    .DM_ADDR   (DM_ADDR),
    .DM_IN     (DM_IN),
    .DM_OUT    (DM_OUT)
);

endmodule


