timeunit 1ns;
timeprecision 1ps;

module DATAPATH
#(
    parameter logic [3:0] a = 4'd1,
    parameter logic [3:0] b = 4'd2,
    parameter logic [3:0] c = 4'd3
)
(
    input logic SYS_CLK,
    input logic CLR,

    input logic [3:0] X,

    input logic LOAD_X,
    input logic LOAD_REG1,
    input logic LOAD_Y,

    input logic SEL_A,
    input logic SEL_B,

    output logic [13:0] Y_REG
);

logic [3:0]  X_REG;
logic [13:0] REG1;

logic [13:0] MUX_A_OUT;
logic [13:0] MUX_B_OUT;

logic [15:0] MULT_OUT;
logic [13:0] ADD_OUT;



/////////////////////////////////////////////////
// MUX_A
/////////////////////////////////////////////////

always_comb
begin

    case(SEL_A)

        1'b0 :
            MUX_A_OUT = {10'd0,a};

        1'b1 :
            MUX_A_OUT = REG1;

        default :
            MUX_A_OUT = '0;

    endcase

end

/////////////////////////////////////////////////
// MUX_B
/////////////////////////////////////////////////

always_comb
begin

    case(SEL_B)

        1'b0 :
            MUX_B_OUT = {10'd0,b};

        1'b1 :
            MUX_B_OUT = {10'd0,c};

        default :
            MUX_B_OUT = '0;

    endcase

end

/////////////////////////////////////////////////
// MULTIPLIER
/////////////////////////////////////////////////

assign MULT_OUT = MUX_A_OUT * {10'd0,X_REG};

/////////////////////////////////////////////////
// ADDER
/////////////////////////////////////////////////

assign ADD_OUT = MULT_OUT[13:0] + MUX_B_OUT;

/////////////////////////////////////////////////
// REGISTERS
/////////////////////////////////////////////////

always_ff @(posedge SYS_CLK)
begin

    if(CLR)
    begin

        X_REG <= '0;
        REG1  <= '0;
        Y_REG <= '0;

    end

    else
    begin

        if(LOAD_X)
            X_REG <= X;

        if(LOAD_REG1)
            REG1 <= ADD_OUT;

        if(LOAD_Y)
            Y_REG <= REG1;

    end

end

endmodule

