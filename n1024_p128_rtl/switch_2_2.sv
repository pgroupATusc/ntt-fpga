module switch_2_2 #(
    parameter DATA_WIDTH = 32
  ) (
    inData_0,
    inData_1,
    outData_0,
    outData_1,
    ctrl,
    clk,
    rst
  );

  input ctrl, clk, rst;
  input [DATA_WIDTH-1:0] inData_0, inData_1;
  output [DATA_WIDTH-1:0] outData_0, outData_1;

  logic [DATA_WIDTH-1:0] outData_reg [1:0];

  always_ff @ (posedge clk) begin
    if (rst) begin
      outData_reg[0] <= 0;
      outData_reg[1] <= 0;
    end else begin
      outData_reg[0] <= (!ctrl) ? inData_0 : inData_1;
      outData_reg[1] <= (!ctrl) ? inData_1 : inData_0;
    end
  end

  assign outData_0 = outData_reg[0];
  assign outData_1 = outData_reg[1];

endmodule
