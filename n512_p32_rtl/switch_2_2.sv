module switch_2_2 #(
    parameter DATA_WIDTH = 28
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
  input         [DATA_WIDTH-1:0] inData_0, inData_1;
  output logic  [DATA_WIDTH-1:0] outData_0, outData_1;

  always_ff @ (posedge clk) begin
    if (rst) begin
      outData_0 <= 0;
      outData_1 <= 0;
    end else begin
      outData_0 <= (!ctrl) ? inData_0 : inData_1;
      outData_1 <= (!ctrl) ? inData_1 : inData_0;
    end
  end

endmodule
