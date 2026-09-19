`timescale 1ns/1ps
//`include "interface.sv"
//`include "test.sv"


module testbench;

  intf i_ntff();

  test t1(i_ntff);

  MAC_4BIT DUT (
    .SYS_CLOCK(i_ntff.SYS_CLOCK),
    .SRST(i_ntff.SRST),
    .A(i_ntff.A),
    .B(i_ntff.B),
    .Y(i_ntff.Y)
  );

assertions ASSERTION_INST (
    .SYS_CLOCK(i_ntff.SYS_CLOCK),
    .SRST(i_ntff.SRST),
    .A(i_ntff.A),
    .B(i_ntff.B),
    .Y(i_ntff.Y)
);
  

  initial begin
    i_ntff.SYS_CLOCK = 0;
    forever #5 i_ntff.SYS_CLOCK = ~i_ntff.SYS_CLOCK;
  end

  initial begin
    i_ntff.SRST = 1;
    #20;
    i_ntff.SRST = 0;
  end

// Initialize inputs
  initial begin
    i_ntff.A = 0;
    i_ntff.B = 0;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,testbench);
  end

endmodule
