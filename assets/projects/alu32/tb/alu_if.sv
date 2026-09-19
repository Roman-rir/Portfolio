// alu_if.sv - previously defined content
interface alu_if(input logic clk, input logic reset);

  // ALU Inputs (driven by driver)
  logic [31:0] A_in;
  logic [31:0] B_in;
  logic [2:0]  ALUCtrl_in;
  logic [4:0]  shamt_in;

  // ALU Outputs (observed by monitor)
  logic [31:0] Result;
  logic        Zero;

endinterface
