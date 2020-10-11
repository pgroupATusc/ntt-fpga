// NTT Accelerator

module NTT_Top #(
    parameter DATA_WIDTH_PER_INPUT = 32,
    parameter INPUT_PER_CYCLE = 32
  ) (
    inData,
    outData,
    clk,
    rst,
  );

  input clk, rst;
  input        [DATA_WIDTH_PER_INPUT-1:0] inData[INPUT_PER_CYCLE-1:0];
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData[INPUT_PER_CYCLE-1:0];

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_0_1_per_outData[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_1_2_per_outData[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_2_3_per_outData[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_3_4_per_outData[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_4_5_per_outData[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_5_6_per_outData[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_6_7_per_outData[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_7_8_per_outData[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_8_9_per_outData[INPUT_PER_CYCLE-1:0];

  // TODO(Tian): stage 0 32 butterfly units

  // TODO(Yang): stage 0 -> stage 1 permutation
  // FIXME: ignore butterfly units for now.
  stage_0_permutation #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_0_1_per (
    .inData_0(inData[0]),
    .inData_1(inData[1]),
    .inData_2(inData[2]),
    .inData_3(inData[3]),
    .inData_4(inData[4]),
    .inData_5(inData[5]),
    .inData_6(inData[6]),
    .inData_7(inData[7]),
    .inData_8(inData[8]),
    .inData_9(inData[9]),
    .inData_10(inData[10]),
    .inData_11(inData[11]),
    .inData_12(inData[12]),
    .inData_13(inData[13]),
    .inData_14(inData[14]),
    .inData_15(inData[15]),
    .inData_16(inData[16]),
    .inData_17(inData[17]),
    .inData_18(inData[18]),
    .inData_19(inData[19]),
    .inData_20(inData[20]),
    .inData_21(inData[21]),
    .inData_22(inData[22]),
    .inData_23(inData[23]),
    .inData_24(inData[24]),
    .inData_25(inData[25]),
    .inData_26(inData[26]),
    .inData_27(inData[27]),
    .inData_28(inData[28]),
    .inData_29(inData[29]),
    .inData_30(inData[30]),
    .inData_31(inData[31]),
    .outData_0(stage_0_1_per_outData[0]),
    .outData_1(stage_0_1_per_outData[1]),
    .outData_2(stage_0_1_per_outData[2]),
    .outData_3(stage_0_1_per_outData[3]),
    .outData_4(stage_0_1_per_outData[4]),
    .outData_5(stage_0_1_per_outData[5]),
    .outData_6(stage_0_1_per_outData[6]),
    .outData_7(stage_0_1_per_outData[7]),
    .outData_8(stage_0_1_per_outData[8]),
    .outData_9(stage_0_1_per_outData[9]),
    .outData_10(stage_0_1_per_outData[10]),
    .outData_11(stage_0_1_per_outData[11]),
    .outData_12(stage_0_1_per_outData[12]),
    .outData_13(stage_0_1_per_outData[13]),
    .outData_14(stage_0_1_per_outData[14]),
    .outData_15(stage_0_1_per_outData[15]),
    .outData_16(stage_0_1_per_outData[16]),
    .outData_17(stage_0_1_per_outData[17]),
    .outData_18(stage_0_1_per_outData[18]),
    .outData_19(stage_0_1_per_outData[19]),
    .outData_20(stage_0_1_per_outData[20]),
    .outData_21(stage_0_1_per_outData[21]),
    .outData_22(stage_0_1_per_outData[22]),
    .outData_23(stage_0_1_per_outData[23]),
    .outData_24(stage_0_1_per_outData[24]),
    .outData_25(stage_0_1_per_outData[25]),
    .outData_26(stage_0_1_per_outData[26]),
    .outData_27(stage_0_1_per_outData[27]),
    .outData_28(stage_0_1_per_outData[28]),
    .outData_29(stage_0_1_per_outData[29]),
    .outData_30(stage_0_1_per_outData[30]),
    .outData_31(stage_0_1_per_outData[31]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Tian): stage 1 32 butterfly units

  // TODO(Yang): stage 1 -> stage 2 permutation
  // FIXME: ignore butterfly units for now.
  stage_1_permutation #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_1_2_per (
    .inData_0(stage_0_1_per_outData[0]),
    .inData_1(stage_0_1_per_outData[1]),
    .inData_2(stage_0_1_per_outData[2]),
    .inData_3(stage_0_1_per_outData[3]),
    .inData_4(stage_0_1_per_outData[4]),
    .inData_5(stage_0_1_per_outData[5]),
    .inData_6(stage_0_1_per_outData[6]),
    .inData_7(stage_0_1_per_outData[7]),
    .inData_8(stage_0_1_per_outData[8]),
    .inData_9(stage_0_1_per_outData[9]),
    .inData_10(stage_0_1_per_outData[10]),
    .inData_11(stage_0_1_per_outData[11]),
    .inData_12(stage_0_1_per_outData[12]),
    .inData_13(stage_0_1_per_outData[13]),
    .inData_14(stage_0_1_per_outData[14]),
    .inData_15(stage_0_1_per_outData[15]),
    .inData_16(stage_0_1_per_outData[16]),
    .inData_17(stage_0_1_per_outData[17]),
    .inData_18(stage_0_1_per_outData[18]),
    .inData_19(stage_0_1_per_outData[19]),
    .inData_20(stage_0_1_per_outData[20]),
    .inData_21(stage_0_1_per_outData[21]),
    .inData_22(stage_0_1_per_outData[22]),
    .inData_23(stage_0_1_per_outData[23]),
    .inData_24(stage_0_1_per_outData[24]),
    .inData_25(stage_0_1_per_outData[25]),
    .inData_26(stage_0_1_per_outData[26]),
    .inData_27(stage_0_1_per_outData[27]),
    .inData_28(stage_0_1_per_outData[28]),
    .inData_29(stage_0_1_per_outData[29]),
    .inData_30(stage_0_1_per_outData[30]),
    .inData_31(stage_0_1_per_outData[31]),
    .outData_0(outData[0]),
    .outData_1(outData[1]),
    .outData_2(outData[2]),
    .outData_3(outData[3]),
    .outData_4(outData[4]),
    .outData_5(outData[5]),
    .outData_6(outData[6]),
    .outData_7(outData[7]),
    .outData_8(outData[8]),
    .outData_9(outData[9]),
    .outData_10(outData[10]),
    .outData_11(outData[11]),
    .outData_12(outData[12]),
    .outData_13(outData[13]),
    .outData_14(outData[14]),
    .outData_15(outData[15]),
    .outData_16(outData[16]),
    .outData_17(outData[17]),
    .outData_18(outData[18]),
    .outData_19(outData[19]),
    .outData_20(outData[20]),
    .outData_21(outData[21]),
    .outData_22(outData[22]),
    .outData_23(outData[23]),
    .outData_24(outData[24]),
    .outData_25(outData[25]),
    .outData_26(outData[26]),
    .outData_27(outData[27]),
    .outData_28(outData[28]),
    .outData_29(outData[29]),
    .outData_30(outData[30]),
    .outData_31(outData[31]),
    .clk(clk),
    .rst(rst)
  );


  // TODO(Tian): stage 2 32 butterfly units

  // TODO(Yang): stage 2 -> stage 3 permutation

  // TODO(Tian): stage 3 32 butterfly units

  // TODO(Yang): stage 3 -> stage 4 permutation

  // TODO(Tian): stage 4 32 butterfly units

  // TODO(Yang): stage 4 -> stage 5 permutation

  // TODO(Tian): stage 5 32 butterfly units

  // TODO(Yang): stage 5 -> stage 6 permutation

  // TODO(Tian): stage 6 32 butterfly units

  // TODO(Yang): stage 6 -> stage 7 permutation

  // TODO(Tian): stage 7 32 butterfly units

  // TODO(Yang): stage 7 -> stage 8 permutation

  // TODO(Tian): stage 8 32 butterfly units

  // TODO(Yang): stage 8 -> stage 9 permutation

  // TODO(Tian): stage 9 32 butterfly units

endmodule
