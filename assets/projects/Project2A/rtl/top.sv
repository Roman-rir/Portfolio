`timescale 1ns/1ps

module Project2A (
    input  logic        SYS_CLOCK,
    input  logic        SRST,

    input  logic [3:0]  X0, X1, X2, X3,
    input  logic [3:0]  C0, C1, C2, C3,

    output logic [9:0]  Y   // max 4-bit * 4-bit * 4 terms
);

always_ff @(posedge SYS_CLOCK) begin
    if (SRST)
        Y <= 0;
    else
        Y <= (C0 * X0) + (C1 * X1) + (C2 * X2) + (C3 * X3);
end

endmodule
