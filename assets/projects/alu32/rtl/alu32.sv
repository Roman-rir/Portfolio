
module alu32 (
  input  logic        clk,
  input  logic        reset,
  input  logic [31:0] A_in,
  input  logic [31:0] B_in,
  input  logic [2:0]  ALUCtrl_in,
  input  logic [4:0]  shamt_in,
  output logic [31:0] Result,
  output logic        Zero
);

  logic [31:0] A, B;
  logic [2:0]  ALUCtrl;
  logic [4:0]  shamt;
  logic [31:0] Result_reg;
  logic        Zero_reg;
logic [31:0] next_result;
  assign Result = Result_reg;
  assign Zero   = Zero_reg;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      A <= 0; B <= 0; ALUCtrl <= 0; shamt <= 0;
      Result_reg <= 0; Zero_reg <= 0;
    end else begin
      A <= A_in; B <= B_in; ALUCtrl <= ALUCtrl_in; shamt <= shamt_in;

      unique case (ALUCtrl)
        3'b000: next_result = A + B;
        3'b001: next_result = A - B;
        3'b010: next_result = A & B;
        3'b011: next_result = A | B;
        3'b100: next_result = A << shamt;
        3'b101: next_result = A >> shamt;
        3'b110: next_result = (A < B) ? 32'd1 : 32'd0;
        default: next_result = 32'hDEADBEEF;
      endcase

      Result_reg <= next_result;
      Zero_reg   <= (next_result == 32'd0);  // now uses new result
    end
  end

endmodule
