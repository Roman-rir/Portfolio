module RISC_V3_PIPELINED_TOP
(input  logic        SYS_CLOCK, RST,
 output logic [31:0] DM_IN,
 output logic [3:0]  PC, DM_ADDR,
 output logic        DM_WR,
 output logic [31:0] IR1, IR2, ACCUM_R,
 output logic [2:0]  PSTATE);

logic [31:0] PM_OUT, DM_OUT;

PROCESSOR_V3_PIPELINED CPU (
    .SYS_CLOCK (SYS_CLOCK),
    .RST       (RST),
    .PM_OUT    (PM_OUT),
    .DM_OUT    (DM_OUT),
    .DM_IN     (DM_IN),
    .PC        (PC),
    .DM_ADDR   (DM_ADDR),
    .DM_WR     (DM_WR),
    .IR1       (IR1),
    .IR2       (IR2),
    .ACCUM_R   (ACCUM_R),
    .PSTATE    (PSTATE)
);

PROG_MEM_P PM (
    .PC     (PC),
    .PM_OUT (PM_OUT)
);

DATA_MEM_P DM (
    .SYS_CLOCK (SYS_CLOCK),
    .RST       (RST),
    .DM_WR     (DM_WR),
    .DM_ADDR   (DM_ADDR),
    .DM_IN     (DM_IN),
    .DM_OUT    (DM_OUT)
);

endmodule
