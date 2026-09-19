// alu_driver.sv - previously defined content
`ifndef ALU_DRIVER_SV
`define ALU_DRIVER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_driver extends uvm_driver #(alu_transaction);
  `uvm_component_utils(alu_driver)

  virtual alu_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("DRV", "Virtual interface not found")
    end
  endfunction

  task run_phase(uvm_phase phase);
    alu_transaction tx;

    forever begin
      seq_item_port.get_next_item(tx);

      // Wait for posedge clk to apply inputs
      @(posedge vif.clk);
      vif.A_in        <= tx.A_in;
      vif.B_in        <= tx.B_in;
      vif.ALUCtrl_in  <= tx.ALUCtrl_in;
      vif.shamt_in    <= tx.shamt_in;

      // Hold for 1 cycle for DUT to process
      @(posedge vif.clk);

      seq_item_port.item_done();
    end
  endtask
endclass

`endif

