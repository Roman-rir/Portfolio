module DATA_MEM_P
(input  logic        SYS_CLOCK, RST, DM_WR,
 input  logic [3:0]  DM_ADDR,
 input  logic [31:0] DM_IN,
 output logic [31:0] DM_OUT);

logic [31:0] D_MEM [15:0];

always_ff @(posedge SYS_CLOCK)
begin
    if (RST)
        for (int i = 0; i <= 15; i = i+1)
            D_MEM[i] <= i;
    else if (DM_WR)
        D_MEM[DM_ADDR] <= DM_IN;
end

assign DM_OUT = D_MEM[DM_ADDR];   // asynchronous read

endmodule


