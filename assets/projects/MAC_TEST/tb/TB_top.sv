module TB_test;
logic SYS_CLOCK, SRST;
logic [3:0] A, B;
logic [7:0] Y;

timeunit 1ns;
timeprecision 1ps;



MAC_4BIT DUT (.SYS_CLOCK(SYS_CLOCK), .SRST(SRST), .A(A), .B(B), .Y(Y));

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
#SRST_offset SRST = 1;   //#2ns
#SRST_width SRST = 0;    //#5ns

end


/////////////////////////////////////////////////
////Generator Task
////////////////////////////////////////////////// 


task automatic gen_data(int unsigned A_low, A_high, B_low, B_high); 
                         
    logic [3:0] randA, randB;

    @(negedge SYS_CLOCK);
    randA = $urandom_range(A_low, A_high);
    randB = $urandom_range(B_low, B_high);

    $display(" %0t: Generator Task...\n", $time);
    {A, B} = {randA, randB};

   
endtask : gen_data


/////////////////////////////////////////////////
//Monitor Task
////////////////////////////////////////////////
int EdgeNo = 0;
task automatic monitor(); 
        
        @(posedge SYS_CLOCK);
        EdgeNo = EdgeNo + 1;
        $display(" %0t: Monitor Task...\n", $time); 
        $strobe("MONITOR: Time = %4t,\t+ve EdgeNo= %4d,\tSRST = %0d,\tA = %3d,\tB = %3d,\tY = %10d",$time, EdgeNo, SRST, A, B, Y);
endtask : monitor


/////////////////////////////////////////////////
//Checker Task
////////////////////////////////////////////////

int error = 0;
logic [7:0] Y_old = 0;
task automatic check(); 
                Y_old = Y;
                
                @(posedge SYS_CLOCK);
		#1ps;
                $display(" %0t: Checker Task...\n", $time);                
		
		if (SRST) 
                assert ( Y == 0) 
		
                $display("CHECKER:===============  OUTPUT IS OK  ================\n");
                
                else                                                                                                                         begin                                                                                                                        error = error + 1;                                                                                                           $display("///////////////////////////////////////////////////////////");                                                     $error("CHECKER: ERROR AT TIME = %4t,\tErrorNo = %3d\n",$time, error);                                                       $display("CHECKER: Time = %4t,\t+ve EdgeNo= %4d,\tSRST = %0d,\tA = %3d,\tB = %3d,\tY = %10d",$time, EdgeNo, SRST, A, B, Y);                                                                                                                               $display("///////////////////////////////////////////////////////////");                                                     end

                else
                assert (Y == (Y_old + (A*B)) )
                
                $display("CHECKER:===============  OUTPUT IS OK  ================\n");
                
                else
                begin
                error = error + 1;
                $display("///////////////////////////////////////////////////////////");
                $error("CHECKER: ERROR AT TIME = %4t,\tErrorNo = %3d\n",$time, error);
		$display("CHECKER: Time = %4t,\t+ve EdgeNo= %4d,\tSRST = %0d,\tA = %3d,\tB = %3d,\tY = %10d",$time, EdgeNo, SRST, A, B, Y);
                $display("///////////////////////////////////////////////////////////");
                end

endtask : check

/////////////////////////////////////////////////
//Main initial block
////////////////////////////////////////////////
	initial
	begin
	
	$timeformat (-9, 0, " ns", 4); 	
        A = 0; B = 0; 	
        $strobe("MONITOR: Time = %4t,\t+ve EdgeNo= %4d,\tSRST = %0d,\tA = %3d,\tB = %3d,\tY = %10d",$time, EdgeNo, SRST,     A, B, Y);

		repeat (16)
            	begin
		fork                	
            	gen_data (1,3,1,3);					
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
