module stage_0_permutation #(
    parameter DATA_WIDTH_PER_INPUT = 32,
    parameter INPUT_PER_CYCLE = 32
  ) (
    inData_0,
    inData_1,
    inData_2,
    inData_3,
    inData_4,
    inData_5,
    inData_6,
    inData_7,
    inData_8,
    inData_9,
    inData_10,
    inData_11,
    inData_12,
    inData_13,
    inData_14,
    inData_15,
    inData_16,
    inData_17,
    inData_18,
    inData_19,
    inData_20,
    inData_21,
    inData_22,
    inData_23,
    inData_24,
    inData_25,
    inData_26,
    inData_27,
    inData_28,
    inData_29,
    inData_30,
    inData_31,
    outData_0,
    outData_1,
    outData_2,
    outData_3,
    outData_4,
    outData_5,
    outData_6,
    outData_7,
    outData_8,
    outData_9,
    outData_10,
    outData_11,
    outData_12,
    outData_13,
    outData_14,
    outData_15,
    outData_16,
    outData_17,
    outData_18,
    outData_19,
    outData_20,
    outData_21,
    outData_22,
    outData_23,
    outData_24,
    outData_25,
    outData_26,
    outData_27,
    outData_28,
    outData_29,
    outData_30,
    outData_31,
    in_start,
    out_start,
    clk,
    rst
  );

  input clk, rst;
  input in_start;
  output logic out_start;

  input [DATA_WIDTH_PER_INPUT-1:0] inData_0;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_1;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_2;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_3;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_4;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_5;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_6;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_7;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_8;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_9;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_10;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_11;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_12;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_13;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_14;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_15;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_16;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_17;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_18;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_19;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_20;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_21;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_22;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_23;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_24;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_25;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_26;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_27;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_28;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_29;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_30;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_31;

  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_0;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_1;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_2;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_3;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_4;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_5;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_6;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_7;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_8;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_9;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_10;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_11;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_12;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_13;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_14;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_15;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_16;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_17;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_18;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_19;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_20;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_21;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_22;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_23;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_24;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_25;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_26;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_27;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_28;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_29;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_30;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_31;

  always_ff @ (posedge clk) begin
    if (rst) begin
      outData_0 <= 0;
      outData_1 <= 0;
      outData_2 <= 0;
      outData_3 <= 0;
      outData_4 <= 0;
      outData_5 <= 0;
      outData_6 <= 0;
      outData_7 <= 0;
      outData_8 <= 0;
      outData_9 <= 0;
      outData_10 <= 0;
      outData_11 <= 0;
      outData_12 <= 0;
      outData_13 <= 0;
      outData_14 <= 0;
      outData_15 <= 0;
      outData_16 <= 0;
      outData_17 <= 0;
      outData_18 <= 0;
      outData_19 <= 0;
      outData_20 <= 0;
      outData_21 <= 0;
      outData_22 <= 0;
      outData_23 <= 0;
      outData_24 <= 0;
      outData_25 <= 0;
      outData_26 <= 0;
      outData_27 <= 0;
      outData_28 <= 0;
      outData_29 <= 0;
      outData_30 <= 0;
      outData_31 <= 0;
    end else begin
      outData_0 <= inData_0;
      outData_1 <= inData_2;
      outData_2 <= inData_1;
      outData_3 <= inData_3;
      outData_4 <= inData_4;
      outData_5 <= inData_6;
      outData_6 <= inData_5;
      outData_7 <= inData_7;
      outData_8 <= inData_8;
      outData_9 <= inData_10;
      outData_10 <= inData_9;
      outData_11 <= inData_11;
      outData_12 <= inData_12;
      outData_13 <= inData_14;
      outData_14 <= inData_13;
      outData_15 <= inData_15;
      outData_16 <= inData_16;
      outData_17 <= inData_18;
      outData_18 <= inData_17;
      outData_19 <= inData_19;
      outData_20 <= inData_20;
      outData_21 <= inData_22;
      outData_22 <= inData_21;
      outData_23 <= inData_23;
      outData_24 <= inData_24;
      outData_25 <= inData_26;
      outData_26 <= inData_25;
      outData_27 <= inData_27;
      outData_28 <= inData_28;
      outData_29 <= inData_30;
      outData_30 <= inData_29;
      outData_31 <= inData_31;
    end
  end

endmodule
