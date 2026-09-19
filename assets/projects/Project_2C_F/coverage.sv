class coverage;

  transaction trans;
  mailbox mon2cov;

  int repeat_count;

  covergroup cg;

    // A Coverage
    A_cp : coverpoint trans.A
    {
      bins low  = {[0:3]};
      bins mid  = {[4:11]};
      bins high = {[12:15]};
    }

    // B Coverage
    B_cp : coverpoint trans.B
    {
      bins low  = {[0:3]};
      bins mid  = {[4:11]};
      bins high = {[12:15]};
    }

    // Cross Coverage
    AB_cross : cross A_cp, B_cp;

  endgroup

  function new(mailbox mon2cov);

    this.mon2cov = mon2cov;

    trans = new();

    cg = new();

  endfunction

  task main();

    repeat(repeat_count)
    begin

      mon2cov.get(trans);

      cg.sample();

    end

  endtask

endclass
