module TB_top;

logic SYS_CLOCK;
logic  SRST;
logic [3:0] X0, X1, X2, X3;
logic [3:0] C0, C1, C2, C3;
logic [9:0] Y;

timeunit 1ns;
timeprecision 1ps;

// DUT
MAC_4BIT DUT (.SYS_CLOCK(SYS_CLOCK), .SRST(SRST), .X0(X0), .X1(X1), .X2(X2), .X3(X3), .C0(C0), .C1(C1), .C2(C2), .C3(C3), .Y(Y));

/////////////////////////////////////////////////
//Generator
////////////////////////////////////////////////


///////////CLOCK GENERATOR////////////

time CLK_PERIOD = 10ns;

initial
begin
    SYS_CLOCK = 0;
    forever
    begin
       #(CLK_PERIOD/2);
       SYS_CLOCK = ~ SYS_CLOCK;
    end
end


///////////RESET GENERATOR/////////////

time SRST_offset = 2ns;
time SRST_width = 5ns;

initial
begin
    SRST = 0;
    #SRST_offset SRST = 1;
    #SRST_width SRST = 0;
end

/////////////////////////////////////////////////
////Generator Task
////////////////////////////////////////////////// 
task automatic gen_data(int unsigned X_low, X_high); 
                         
    logic [3:0] randX0,randX1,randX2,randX3;

    @(negedge SYS_CLOCK);

    randX0 = $urandom_range(X_low, X_high);
    randX1 = $urandom_range(X_low, X_high);
    randX2 = $urandom_range(X_low, X_high);
    randX3 = $urandom_range(X_low, X_high);

    $display(" %0t: Generator Task...\n", $time);

    {X0, X1, X2, X3} = {randX0, randX1, randX2, randX3 };

    // FIXED CONSTANTS
    C0 = 4'd1;
    C1 = 4'd1;
    C2 = 4'd1;
    C3 = 4'd1;

endtask : gen_data

/////////////////////////////////////////////////
//Monitor Task
////////////////////////////////////////////////
int EdgeNo = 0;

task automatic monitor(); 
        
    @(posedge SYS_CLOCK);
    EdgeNo = EdgeNo + 1;

    $display(" %0t: Monitor Task...\n", $time); 

    $strobe("MONITOR: Time = %4t,\t+ve EdgeNo= %4d,\tSRST = %0d,\tX = %3d,%3d,%3d,%3d,\tY = %10d",
             $time, EdgeNo, SRST, X0, X1, X2, X3, Y);

endtask : monitor

/////////////////////////////////////////////////
//Checker Task
////////////////////////////////////////////////

int error = 0;
logic [9:0] expected = 0;

task automatic check(); 

    @(posedge SYS_CLOCK);
    #2ps;   // ?? race condition fix

    $display(" %0t: Checker Task...\n", $time);                

    if (SRST) 
    begin
        if (Y !== 0) 
        begin
            error = error + 1;
            $display("///////////////////////////////////////////////////////////");   
            $error("RESET ERROR AT TIME = %4t,\tErrorNo = %3d\n",$time, error); 
            $display("///////////////////////////////////////////////////////////");
        end
        expected = 0;
    end

    else 
    begin
        // ?? compare with previous expected
        if (Y !== expected) 
        begin
            error = error + 1;
            $display("///////////////////////////////////////////////////////////");
            $error("CHECKER: ERROR AT TIME = %4t,\tErrorNo = %3d\n",$time, error);
            $display("EXPECTED = %0d, GOT = %0d", expected, Y);
            $display("CHECKER: Time = %4t,\t+ve EdgeNo= %4d,\tSRST = %0d,\tX = %3d,%3d,%3d,%3d",
                     $time, EdgeNo, SRST, X0, X1, X2, X3);
            $display("///////////////////////////////////////////////////////////");
        end
    end

    // ?? update for next cycle
    expected = (C0*X0 + C1*X1 + C2*X2 + C3*X3);

endtask : check

/////////////////////////////////////////////////
//Main initial block
////////////////////////////////////////////////
initial
begin
	
    $timeformat (-9, 0, " ns", 4); 	

    X0 = 0; X1 = 0; X2 = 0; X3 = 0;
    C0 = 1; C1 = 1; C2 = 1; C3 = 1;

    $strobe("MONITOR: Time = %4t,\t+ve EdgeNo= %4d,\tSRST = %0d,\tX = %3d,%3d,%3d,%3d,\tY = %10d",
             $time, EdgeNo, SRST, X0, X1, X2, X3, Y);

    repeat (16)
    begin
        fork                	
            gen_data (0,15);					
            monitor();
            check();
        join
    end
	
    #1;

    if (error == 0)
        $display("\nTEST PASSED: No errors detected.\n");
    else
        $display("\nTEST FAILED: %0d errors detected.\n", error);

    $finish;
	
end

endmodule
