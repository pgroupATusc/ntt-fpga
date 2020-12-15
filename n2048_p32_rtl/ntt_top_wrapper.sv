// NTT Accelerator
// Wrapper to remove IO constraints.

module NTT_Top_Wrapper #(
    parameter DATA_WIDTH_PER_INPUT = 28,
    parameter INPUT_PER_CYCLE = 32
  ) (
    clk,
    rst,
    in_start,
    in_data,
    out_start,
    out_data
  );

  localparam COUNTER_WIDTH = $clog2(INPUT_PER_CYCLE);

  input                             clk;
  input                             rst;

  input                             in_start[9:0];
  input [DATA_WIDTH_PER_INPUT-1:0]  in_data;

  output logic                            out_start[9:0];
  output logic [DATA_WIDTH_PER_INPUT-1:0] out_data;

  logic [COUNTER_WIDTH-1:0]         counter;

  logic [DATA_WIDTH_PER_INPUT-1:0]  input_data[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0]  output_data[INPUT_PER_CYCLE-1:0];

  integer i;
  always_ff @ (posedge clk) begin
    if (rst) begin
      counter <= 0;
    end else begin
      out_data <= output_data[counter];

      for (i = 0; i < INPUT_PER_CYCLE; i = i + 1) begin
        if (i == counter) begin
          input_data[i] <= in_data;
        end else begin
          input_data[i] <= 0;
        end
      end

      counter <= counter + 1'b1;
    end
  end

  NTT_Top #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  ntt_top_instance (
    .inData(input_data),
    .outData(output_data),
    .in_start(in_start),
    .out_start(out_start),
    .clk(clk),
    .rst(rst)
  );

endmodule
