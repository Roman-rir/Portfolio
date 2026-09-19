// alu_monitor.sv - previously defined content
`ifndef ALU_MONITOR_SV
`define ALU_MONITOR_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_monitor extends uvm_component;
  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;

  uvm_analysis_port #(alu_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("MON", "Virtual interface not found")
    end
  endfunction

task run_phase(uvm_phase phase);
  alu_transaction tx;

  // Stage 1: previous inputs
  logic [31:0] prev_A, prev_B;
  logic [2:0]  prev_ctrl;
  logic [4:0]  prev_shamt;
  bit valid = 0;

  // Temp vars for current input
  logic [31:0] cur_A, cur_B;
  logic [2:0]  cur_ctrl;
  logic [4:0]  cur_shamt;

  forever begin
    @(posedge vif.clk);
    @(posedge vif.clk);
    if (vif.reset) continue;

    // Assign current inputs
    cur_A     = vif.A_in;
    cur_B     = vif.B_in;
    cur_ctrl  = vif.ALUCtrl_in;
    cur_shamt = vif.shamt_in;

    if (valid) begin
      // Use previous inputs with current output
      tx = alu_transaction::type_id::create("tx");
      tx.A_in        = prev_A;
      tx.B_in        = prev_B;
      tx.ALUCtrl_in  = prev_ctrl;
      tx.shamt_in    = prev_shamt;
      tx.Result      = vif.Result;
      tx.Zero        = vif.Zero;

      `uvm_info("MON", $sformatf("Captured transaction: %s", tx.convert2string()), UVM_MEDIUM)
      ap.write(tx);
    end

    // Stage: store current for next time
    prev_A     = cur_A;
    prev_B     = cur_B;
    prev_ctrl  = cur_ctrl;
    prev_shamt = cur_shamt;
    valid = 1;
  end
endtask


endclass

`endif

