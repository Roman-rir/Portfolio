`timescale 1ns/1ps
module MAC_4BIT
(input logic SYS_CLOCK,
input logic SRST,
input logic [3:0] A, B,
output logic [7:0] Y);


always_ff@(posedge SYS_CLOCK)
begin

        if (SRST)
        Y <= 0;
        else
        Y <= Y + A*B;

end


endmodule
