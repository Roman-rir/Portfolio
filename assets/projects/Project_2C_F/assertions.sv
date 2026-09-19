`timescale 1ns/1ps

module assertions (
    input logic SYS_CLOCK,
    input logic SRST,
    input logic [3:0] A,
    input logic [3:0] B,
    input logic [7:0] Y
);

  //-----------------------------------------
  // Reset Assertion
  //-----------------------------------------
  property p_reset;
    @(posedge SYS_CLOCK)
      SRST |=> (Y == 8'd0);
  endproperty

  a_reset : assert property (p_reset)
    $display("[%0t] ASSERT PASS : Reset Working", $time);
  else
    $error("[%0t] ASSERT FAIL : Reset Failed", $time);


  //-----------------------------------------
  // No X / Z on A,B,Y
  //-----------------------------------------
  property p_no_unknown;
    @(posedge SYS_CLOCK)
    disable iff (SRST)
      !$isunknown({A,B,Y});
  endproperty

  a_no_unknown : assert property (p_no_unknown)
    $display("[%0t] ASSERT PASS : No X/Z Detected", $time);
  else
    $error("[%0t] ASSERT FAIL : X/Z Detected", $time);


  //-----------------------------------------
  // Y must be known
  //-----------------------------------------
  property p_y_known;
    @(posedge SYS_CLOCK)
    disable iff (SRST)
      !$isunknown(Y);
  endproperty

  a_y_known : assert property (p_y_known)
    $display("[%0t] ASSERT PASS : Y Known", $time);
  else
    $error("[%0t] ASSERT FAIL : Y Unknown", $time);


  //-----------------------------------------
  // A and B must stay inside 4-bit range
  //-----------------------------------------
  property p_input_range;
    @(posedge SYS_CLOCK)
    disable iff (SRST)
      (A inside {[0:15]}) && (B inside {[0:15]});
  endproperty

  a_input_range : assert property (p_input_range)
    $display("[%0t] ASSERT PASS : A/B In Range", $time);
  else
    $error("[%0t] ASSERT FAIL : A/B Out Of Range", $time);

endmodule
