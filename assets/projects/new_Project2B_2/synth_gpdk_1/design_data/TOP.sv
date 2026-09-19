timeunit 1ns;
timeprecision 1ps;

module TOP
(
    input  logic SYS_CLK,
    input  logic FSM_ARESET,

    input  logic GO,
    input  logic STOP,

    input  logic [3:0] X,
    output logic [13:0] Y_REG
  
);

/////////////////////////////////////////////////
//// INTERNAL CONTROL SIGNALS
/////////////////////////////////////////////////

logic LOAD_X;
logic LOAD_REG1;
logic LOAD_Y;

logic SEL_A;
logic SEL_B;

logic CLR;

/////////////////////////////////////////////////
//// FSM INSTANTIATION
/////////////////////////////////////////////////

FSM F1
(
    .SYS_CLK     (SYS_CLK),
    .FSM_ARESET  (FSM_ARESET),

    .GO          (GO),
    .STOP        (STOP),

    .LOAD_X      (LOAD_X),
    .LOAD_REG1   (LOAD_REG1),
    .LOAD_Y      (LOAD_Y),

    .SEL_A       (SEL_A),
    .SEL_B       (SEL_B),

    .CLR         (CLR)
);

/////////////////////////////////////////////////
//// DATAPATH INSTANTIATION
/////////////////////////////////////////////////

DATAPATH D2
(
    .SYS_CLK     (SYS_CLK),
    .CLR         (CLR),

    .X           (X),

    .LOAD_X      (LOAD_X),
    .LOAD_REG1   (LOAD_REG1),
    .LOAD_Y      (LOAD_Y),

    .SEL_A       (SEL_A),
    .SEL_B       (SEL_B),


    .Y_REG       (Y_REG)
);

endmodule : TOP

