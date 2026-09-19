// alu_env.sv - previously defined content
`ifndef ALU_ENV_SV
`define ALU_ENV_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_env extends uvm_env;
  `uvm_component_utils(alu_env)

  alu_driver       drv;
  alu_monitor      mon;
  alu_scoreboard   sb;
  alu_sequencer    seqr;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    drv  = alu_driver      ::type_id::create("drv", this);
    mon  = alu_monitor     ::type_id::create("mon", this);
    sb   = alu_scoreboard  ::type_id::create("sb", this);
    seqr = alu_sequencer   ::type_id::create("seqr", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Connect sequencer to driver
    drv.seq_item_port.connect(seqr.seq_item_export);

    // Connect monitor to scoreboard
    mon.ap.connect(sb.ap);
  endfunction
endclass

`endif

