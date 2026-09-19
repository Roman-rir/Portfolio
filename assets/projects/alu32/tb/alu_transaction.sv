// alu_transaction.sv - previously defined content
`ifndef ALU_TRANSACTION_SV
`define ALU_TRANSACTION_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_transaction extends uvm_sequence_item;
  // Inputs to ALU
  rand logic [31:0] A_in;
  rand logic [31:0] B_in;
  rand logic [2:0]  ALUCtrl_in;
  rand logic [4:0]  shamt_in;

  // Observed outputs from ALU (captured by monitor)
  logic [31:0] Result;
  logic        Zero;

  `uvm_object_utils(alu_transaction)

  function new(string name = "alu_transaction");
    super.new(name);
  endfunction

  function string convert2string();
    return $sformatf("A=0x%08h B=0x%08h Ctrl=%0b shamt=%0d => Result=0x%08h Zero=%0b",
                     A_in, B_in, ALUCtrl_in, shamt_in, Result, Zero);
  endfunction
endclass

`endif

