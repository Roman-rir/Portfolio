timeunit 1ns;
timeprecision 1ps;

module TB_TOP2();

// INTERNAL SIGNAL DECLARATIONS

logic SYS_CLK;
logic FSM_ARESET;

logic GO;
logic STOP;

logic [3:0]  X;
logic [13:0] Y_REG;
logic [13:0] Y;

// FSM INTERNAL SIGNALS

logic LOAD_X;
logic LOAD_REG1;
logic LOAD_Y;

logic SEL_A;
logic SEL_B;

logic CLR;

logic [2:0] P_STATE,N_STATE;


// VERIFICATION COUNTERS

integer TOTAL_ERROR = 0;
logic FIRST_SKIP = 1'b1;

logic [3:0] X_D1;
logic [3:0] X_D2;
logic [3:0] X_D3;

logic [13:0] EXPECTED;

// DATAPATH INTERNAL SIGNALS
logic [3:0]  X_REG;

logic [13:0] REG1;

logic [13:0] MUX_A_OUT;
logic [13:0] MUX_B_OUT;

logic [15:0] MULT_OUT;
logic [13:0] ADD_OUT;

// INTERNAL SIGNAL MONITORING

assign P_STATE = TB_TOP2.UUT.F1.P_STATE;
assign N_STATE = TB_TOP2.UUT.F1.N_STATE;

assign LOAD_X    = TB_TOP2.UUT.LOAD_X;
assign LOAD_REG1 = TB_TOP2.UUT.LOAD_REG1;
assign LOAD_Y    = TB_TOP2.UUT.LOAD_Y;

assign SEL_A     = TB_TOP2.UUT.SEL_A;
assign SEL_B     = TB_TOP2.UUT.SEL_B;

assign CLR       = TB_TOP2.UUT.CLR;

assign X_REG     = TB_TOP2.UUT.D2.X_REG;

assign REG1      = TB_TOP2.UUT.D2.REG1;
assign Y_REG     = TB_TOP2.UUT.D2.Y_REG;

assign MUX_A_OUT = TB_TOP2.UUT.D2.MUX_A_OUT;
assign MUX_B_OUT = TB_TOP2.UUT.D2.MUX_B_OUT;

assign MULT_OUT  = TB_TOP2.UUT.D2.MULT_OUT;
assign ADD_OUT   = TB_TOP2.UUT.D2.ADD_OUT;

// UNIT UNDER TEST

TOP UUT
(
    .SYS_CLK     (SYS_CLK),
    .FSM_ARESET  (FSM_ARESET),

    .GO          (GO),
    .STOP        (STOP),

    .X           (X),

    .Y_REG       (Y)
);

// CLOCK GENERATION

const time CLOCK_PERIOD = 100ns;

initial
begin

    SYS_CLK <= 0;

    forever
    begin

        #(CLOCK_PERIOD/2)
        SYS_CLK <= ~SYS_CLK;

    end

end

// RESET GENERATION

initial
begin

    FSM_ARESET <= 0;

    #20;
    FSM_ARESET <= 1;

    #10;
    FSM_ARESET <= 0;

end

// GO & STOP CONTROL


initial
begin

    GO   <= 0;
    STOP <= 0;

    #100;
    GO <= 1;

    #10000;
    STOP <= 1;

end

// INPUT GENERATION
always @(posedge SYS_CLK)
begin

    if (GO && !STOP)
        X <= $urandom_range(0,15);

end




// DEBUG + VERIFICATION MONITOR

always @(posedge SYS_CLK)
begin

    //-----------------------------------------
    // DELAY LINE
    //-----------------------------------------

    X_D1 <= X_REG;
    X_D2 <= X_D1;
    X_D3 <= X_D2;

    EXPECTED = (1 * X_D3 * X_D3) +
               (2 * X_D3) +
               3;

    //-----------------------------------------
    // REPORT
    //-----------------------------------------

    if (LOAD_Y && !STOP)
    begin

       
        $display("============RESOURCE SHARING EXECUTION REPORT=============");
       
        $display("");

        $display("TIME      = %0t ns", $time);
        $display("P_STATE   = %0d", P_STATE);
        $display("");

        $display("X_REG     = %0d", X_D3);
       
        $display("Y_REG     = %0d", Y_REG);
        $display("");

        $display("FORMULA   = 1*(%0d)^2 + 2*(%0d) + 3",
                 X_D3,
                 X_D3);

        $display("EXPECTED  = %0d", EXPECTED);
        $display("ACTUAL    = %0d", Y_REG);
        $display("");

        //-------------------------------------
        // SKIP FIRST INVALID OUTPUT
        //-------------------------------------

        if (FIRST_SKIP)
        begin

            FIRST_SKIP = 1'b0;

            $display("STATUS    = FIRST OUTPUT SKIPPED");

        end
        else if (Y_REG == EXPECTED)
        begin

            $display("STATUS    = PASS");

        end
        else
        begin

            $display("STATUS    = FAIL");

            TOTAL_ERROR = TOTAL_ERROR + 1;

        end

        $display("");



    end

end

// SIMULATION RUN TIME

const time RUN_TIME = 12000ns;

// FINAL VERIFICATION REPORT

initial
begin

    #RUN_TIME

    $display("");

    $display("==============FINAL VERIFICATION REPORT===============");

    $display("");

    $display("TOTAL ERRORS = %0d", TOTAL_ERROR);

    if (TOTAL_ERROR == 0)
        $display("FINAL STATUS = PASS");
    else
        $display("FINAL STATUS = FAIL");

    $display("");
  
    $display("");

    $finish;

end

endmodule : TB_TOP2

