// alu_scoreboard.sv - previously defined content
`ifndef ALU_SCOREBOARD_SV
`define ALU_SCOREBOARD_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_scoreboard extends uvm_component;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_transaction, alu_scoreboard) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  // This is called when the monitor sends a transaction
  function void write(alu_transaction tx);
    logic [31:0] expected_result;
    logic        expected_zero;

    case (tx.ALUCtrl_in)
      3'b000: expected_result = tx.A_in + tx.B_in;
      3'b001: expected_result = tx.A_in - tx.B_in;
      3'b010: expected_result = tx.A_in & tx.B_in;
      3'b011: expected_result = tx.A_in | tx.B_in;
      3'b100: expected_result = tx.A_in << tx.shamt_in;
      3'b101: expected_result = tx.A_in >> tx.shamt_in;
      3'b110: expected_result = (tx.A_in < tx.B_in) ? 32'd1 : 32'd0;
      default: expected_result = 32'hDEADBEEF;
    endcase

    expected_zero = (expected_result == 0);

    if (tx.Result !== expected_result || tx.Zero !== expected_zero) begin
      `uvm_error("SCOREBOARD", $sformatf(
        "Mismatch!\nInput A=0x%08h B=0x%08h Ctrl=%b shamt=%0d\nExpected Result=0x%08h Zero=%b\nActual   Result=0x%08h Zero=%b",
        tx.A_in, tx.B_in, tx.ALUCtrl_in, tx.shamt_in,
        expected_result, expected_zero,
        tx.Result, tx.Zero
      ))
    end else begin
      `uvm_info("SCOREBOARD", $sformatf("Match: %s", tx.convert2string()), UVM_LOW)
    end
  endfunction
endclass

`endif

