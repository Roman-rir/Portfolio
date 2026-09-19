
module fifo #(
	parameter DATA_WIDTH = 32,
	parameter DEPTH = 16,
	parameter ADDR_WIDTH = $clog2(DATA_WIDTH)
)(
	input	logic			clk,
	input	logic			reset_n,
	input 	logic [DATA_WIDTH-1:0]	wr_data,
	input 	logic			wr_en,
	output 	logic [DATA_WIDTH-1:0]	rd_data,
	input 	logic			rd_en,
	output 	logic			full,
	output	logic 			empty
);


	logic	[DATA_WIDTH-1:0]	mem	[0:DEPTH-1];
	logic	[ADDR_WIDTH-1:0]	wr_ptr, rd_ptr;
	logic	[ADDR_WIDTH:0]		count;

	assign	full =	(count == DEPTH);
	assign	empty =	(count == 0);

	always_ff @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			wr_ptr <= 0;
			rd_ptr <= 0;
			count <= 0;
		end else begin
			if (wr_en && !full) begin
				mem[wr_ptr] <= wr_data;
				wr_ptr <= wr_ptr + 1;
			end
			if (rd_en && !empty) begin
				rd_ptr <= rd_ptr + 1; 
			end
			case ({wr_en && !full,rd_en && !empty})
				2'b10	:	count <= count + 1; // Write Only
				2'b01	:	count <= count - 1; // Read Only
				default :	count <= count;
			endcase
		end
	end
	assign rd_data = (!empty) ? mem[rd_ptr] : '0;
endmodule : fifo

