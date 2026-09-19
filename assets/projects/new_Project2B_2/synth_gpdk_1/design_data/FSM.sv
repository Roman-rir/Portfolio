timeunit 1ns;
timeprecision 1ps;

module FSM
(
    input  logic SYS_CLK,
    input  logic FSM_ARESET,

    input  logic GO,
    input  logic STOP,

    //////////////////////////////////////////////////
    // CONTROL OUTPUTS
    //////////////////////////////////////////////////

    output logic LOAD_X,
    output logic LOAD_REG1,
    output logic LOAD_Y,

    output logic SEL_A,
    output logic SEL_B,

    output logic CLR
);

/////////////////////////////////////////////////
//// STATE DEFINITIONS
/////////////////////////////////////////////////

logic [2:0] P_STATE, N_STATE;

/////////////////////////////////////////////////
//// NEXT STATE LOGIC
/////////////////////////////////////////////////

always_comb
begin : NSL

    N_STATE = P_STATE;

    case(P_STATE)

        //-------------------------------------
        // S0 : IDLE
        //-------------------------------------
        3'd0:
        begin

            if (GO)
                N_STATE = 3'd1;
            else
                N_STATE = 3'd0;

        end

        //-------------------------------------
        // S1 : LOAD_X
        //-------------------------------------
        3'd1:
        begin

            N_STATE = 3'd2;

        end

        //-------------------------------------
        // S2 : REG1 = aX+b
        //-------------------------------------
        3'd2:
        begin

            N_STATE = 3'd3;

        end

        //-------------------------------------
        // S3 : REG1 = REG1*X+c
        //-------------------------------------
        3'd3:
        begin

            N_STATE = 3'd4;

        end

        //-------------------------------------
        // S4 : Y = REG1
        //-------------------------------------
        3'd4:
        begin

            if (STOP)
                N_STATE = 3'd0;
            else
                N_STATE = 3'd1;

        end

        //-------------------------------------
        // DEFAULT
        //-------------------------------------
        default:
        begin

            N_STATE = 3'd0;

        end

    endcase

end : NSL

/////////////////////////////////////////////////
//// OUTPUT LOGIC
/////////////////////////////////////////////////

always_comb
begin : OL

    //-----------------------------------------
    // DEFAULTS
    //-----------------------------------------

    LOAD_X    = 1'b0;
    LOAD_REG1 = 1'b0;
    LOAD_Y    = 1'b0;

    SEL_A     = 1'b0;
    SEL_B     = 1'b0;

    CLR       = 1'b0;

    case(P_STATE)

        //-------------------------------------
        // S0 : IDLE
        //-------------------------------------
        3'd0:
        begin

            CLR = 1'b1;

        end

        //-------------------------------------
        // S1 : LOAD_X
        //-------------------------------------
        3'd1:
        begin

            LOAD_X = 1'b1;

        end

        //-------------------------------------
        // S2 : REG1 = aX+b
        //-------------------------------------
        3'd2:
        begin

            SEL_A     = 1'b0;   // a
            SEL_B     = 1'b0;   // b

            LOAD_REG1 = 1'b1;

        end

        //-------------------------------------
        // S3 : REG1 = REG1*X+c
        //-------------------------------------
        3'd3:
        begin

            SEL_A     = 1'b1;   // REG1
            SEL_B     = 1'b1;   // c

            LOAD_REG1 = 1'b1;

        end

        //-------------------------------------
        // S4 : Y = REG1
        //-------------------------------------
        3'd4:
        begin

            LOAD_Y = 1'b1;

        end

        //-------------------------------------
        // DEFAULT
        //-------------------------------------
        default:
        begin

            CLR = 1'b1;

        end

    endcase

end : OL

/////////////////////////////////////////////////
//// PRESENT STATE REGISTER
/////////////////////////////////////////////////

always_ff @(posedge SYS_CLK or posedge FSM_ARESET)
begin : PSR

    if (FSM_ARESET)
        P_STATE <= 3'd0;
    else
        P_STATE <= N_STATE;

end : PSR

endmodule : FSM

