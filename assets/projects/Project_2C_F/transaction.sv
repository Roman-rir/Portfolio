class transaction;

  randc bit [3:0] A, B;
   bit SRST;

  bit [7:0] Y;

  function void display(string name);

    $display("=============================");
    $display("%s", name);
    $display("[%s] A=%0d B=%0d Y=%0d",
             name, A, B, Y);
    $display("=============================");

  endfunction

endclass
