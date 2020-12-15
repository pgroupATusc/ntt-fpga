module Permutation_Wrapper #(
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

  input                             in_start[8:0];
  input [DATA_WIDTH_PER_INPUT-1:0]  in_data;

  output logic                            out_start[8:0];
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

  stage_8_permutation
  permutation_instance (
    .inData_0(input_data[0]),
    .inData_1(input_data[1]),
    .inData_2(input_data[2]),
    .inData_3(input_data[3]),
    .inData_4(input_data[4]),
    .inData_5(input_data[5]),
    .inData_6(input_data[6]),
    .inData_7(input_data[7]),
    .inData_8(input_data[8]),
    .inData_9(input_data[9]),
    .inData_10(input_data[10]),
    .inData_11(input_data[11]),
    .inData_12(input_data[12]),
    .inData_13(input_data[13]),
    .inData_14(input_data[14]),
    .inData_15(input_data[15]),
    .inData_16(input_data[16]),
    .inData_17(input_data[17]),
    .inData_18(input_data[18]),
    .inData_19(input_data[19]),
    .inData_20(input_data[20]),
    .inData_21(input_data[21]),
    .inData_22(input_data[22]),
    .inData_23(input_data[23]),
    .inData_24(input_data[24]),
    .inData_25(input_data[25]),
    .inData_26(input_data[26]),
    .inData_27(input_data[27]),
    .inData_28(input_data[28]),
    .inData_29(input_data[29]),
    .inData_30(input_data[30]),
    .inData_31(input_data[31]),
    .outData_0(output_data[0]),
    .outData_1(output_data[1]),
    .outData_2(output_data[2]),
    .outData_3(output_data[3]),
    .outData_4(output_data[4]),
    .outData_5(output_data[5]),
    .outData_6(output_data[6]),
    .outData_7(output_data[7]),
    .outData_8(output_data[8]),
    .outData_9(output_data[9]),
    .outData_10(output_data[10]),
    .outData_11(output_data[11]),
    .outData_12(output_data[12]),
    .outData_13(output_data[13]),
    .outData_14(output_data[14]),
    .outData_15(output_data[15]),
    .outData_16(output_data[16]),
    .outData_17(output_data[17]),
    .outData_18(output_data[18]),
    .outData_19(output_data[19]),
    .outData_20(output_data[20]),
    .outData_21(output_data[21]),
    .outData_22(output_data[22]),
    .outData_23(output_data[23]),
    .outData_24(output_data[24]),
    .outData_25(output_data[25]),
    .outData_26(output_data[26]),
    .outData_27(output_data[27]),
    .outData_28(output_data[28]),
    .outData_29(output_data[29]),
    .outData_30(output_data[30]),
    .outData_31(output_data[31]),
    .in_start(in_start[0]),
    .out_start(out_start[0]),
    .clk(clk),
    .rst(rst)
  );

endmodule
