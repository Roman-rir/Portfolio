// tb_top.sv - previously defined content
`include "uvm_macros.svh"
import uvm_pkg::*;

//`include "alu_if.sv"
//`include "alu_test.sv"

module alu32_tb;

  logic clk;
  logic reset;

  // Instantiate interface with clk and reset
  alu_if alu_if_inst(clk, reset);

  // DUT instantiation
  alu32 dut (
    .clk(clk),
    .reset(reset),
    .A_in(alu_if_inst.A_in),
    .B_in(alu_if_inst.B_in),
    .ALUCtrl_in(alu_if_inst.ALUCtrl_in),
    .shamt_in(alu_if_inst.shamt_in),
    .Result(alu_if_inst.Result),
    .Zero(alu_if_inst.Zero)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset sequence
  initial begin
    reset = 1;
    #20 reset = 0;
    #160 reset = 1;
    #180 reset = 0;
  end

  // Start UVM test
  initial begin
    uvm_config_db#(virtual alu_if)::set(null, "*", "vif", alu_if_inst);
    run_test("alu_test");
  end

endmodule

