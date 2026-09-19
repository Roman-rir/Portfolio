`timescale 1ns/1ps

module DATA_MEM 
(input logic SYS_CLOCK, RST, DM_WR,
input logic [3:0] DM_ADDR,
input logic [31:0] DM_IN,
output logic [31:0] DM_OUT);

logic [31:0] D_MEM [15:0];

// Synchronous write and reset initialization.
always_ff @(posedge SYS_CLOCK)
begin
    if (RST)
    begin
        for (int i=0; i<=15; i=i+1)
            D_MEM[i] <= i;
    end
    else
    begin
        if (DM_WR)
            D_MEM[DM_ADDR] <= DM_IN;
    end
end

// Asynchronous read. Therefore, after DM_ADDR is registered, DM_OUT
// reflects the selected data without needing an additional FSM state.
assign DM_OUT = D_MEM[DM_ADDR];

endmodule


