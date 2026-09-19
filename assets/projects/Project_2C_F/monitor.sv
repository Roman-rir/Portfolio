//`include "transaction.sv"

class monitor;

  virtual intf vif;

  mailbox mon2scb;
  mailbox mon2cov;

  int repeat_count;

  function new (virtual intf vif,
                mailbox mon2scb,
                mailbox mon2cov);

    this.vif     = vif;
    this.mon2scb = mon2scb;
    this.mon2cov = mon2cov;

  endfunction

 task main();

  transaction trans;

  repeat(repeat_count)
  begin

    @(negedge vif.SYS_CLOCK);
    #1;

    trans = new();

    trans.A = vif.A;
    trans.B = vif.B;
    trans.Y = vif.Y;
    trans.SRST = vif.SRST;

    mon2scb.put(trans);
    mon2cov.put(trans);

    trans.display("Monitor");
    $display("[Monitor] A=%0d B=%0d SRST=%0d Y=%0d",
         trans.A, trans.B, trans.SRST, trans.Y);

  end

endtask

endclass
