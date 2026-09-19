class scoreboard;

  mailbox mon2scb;

  int repeat_count;
  bit [7:0] expected_y;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
    expected_y = 0;
  endfunction

  task main();

    transaction trans;
    bit [7:0] check_value;

    repeat(repeat_count)
    begin

      mon2scb.get(trans);

      check_value = expected_y;

      if(trans.Y == check_value)
        $display("******** PASS ********");
      else
        $display("!!!!!!!! FAIL !!!!!!!! Expected=%0d Actual=%0d",
                 check_value, trans.Y);

      $display("SCB: A=%0d B=%0d SRST=%0d Expected=%0d Actual=%0d",
               trans.A, trans.B, trans.SRST,
               check_value, trans.Y);

      if(trans.SRST)
        expected_y = 0;
      else
        expected_y = expected_y + (trans.A * trans.B);

    end

  endtask

endclass
