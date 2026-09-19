// alu_sequence.sv - previously defined content
`ifndef ALU_SEQUENCE_SV
`define ALU_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_sequence extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_sequence)

  function new(string name = "alu_sequence");
    super.new(name);
  endfunction

  task body();
    alu_transaction tx;

    // Generate 50 random operations
    repeat (50) begin
      tx = alu_transaction::type_id::create("tx");
      assert(tx.randomize());

      `uvm_info("SEQ", $sformatf("Starting transaction: %s", tx.convert2string()), UVM_MEDIUM)

      start_item(tx);
      finish_item(tx);
    end
  endtask
endclass

`endif

