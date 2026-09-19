`timescale 1ns/1ps

module fifo_tb;

  // Parameters
  localparam DATA_WIDTH = 32;
  localparam DEPTH = 16;

  // Signals
  logic clk, reset_n;
  logic wr_en, rd_en;
  logic [DATA_WIDTH-1:0] wr_data, rd_data;
  logic full, empty;

  logic [DATA_WIDTH-1:0] expected [0:DATA_WIDTH-1];
  int	write_index = 0; 
  int	read_index = 0; 

  // Clock generation
  always #5 clk = ~clk;

  // Instantiate FIFO
  fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH)
  ) dut (
    .clk(clk),
    .reset_n(reset_n),
    .wr_en(wr_en),
    .wr_data(wr_data),
    .rd_en(rd_en),
    .rd_data(rd_data),
    .full(full),
    .empty(empty)
  );

  // Stimulus
  initial begin
    $display("Starting FIFO test...");
    clk = 0;
    reset_n = 0;
    wr_en = 0; rd_en = 0; wr_data = 0;
    #20;
    reset_n = 1;

    // Write 4 entries
    repeat (4) begin
      @(negedge clk);
      wr_en = 1;
      wr_data = $random;
      $info("Writing Data: %0h at %0d",wr_data,write_index);
      expected[write_index++] = wr_data;
    end
    wr_en = 0;

    // Read 2 entries
    repeat (2) begin
      @(negedge clk);
      rd_en = 1;
      $info("Reading Data: %0h at %0d",rd_data,read_index);
      if (rd_data != expected[read_index]) begin
	$error("FAIL: Mismatch at index %0d: Expected: %0h | Found: %0h",read_index,expected[read_index],rd_data);
      end else begin
	$info("PASS: Match at index %0d: Expected: %0h | Found: %0h",read_index,expected[read_index],rd_data);
	end
    read_index++;
    end
    rd_en = 0;

    // Write again
    repeat (3) begin
      @(negedge clk);
      wr_en = 1;
      wr_data = $random;
    end
    wr_en = 0;

    // Drain the FIFO
    while (!empty) begin
      @(negedge clk);
      rd_en = 1;
    end
    rd_en = 0;

    $display("FIFO test complete.");
    $finish;
  end

endmodule

