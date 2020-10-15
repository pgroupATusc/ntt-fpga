// NTT Accelerator

module NTT_Top #(
    parameter DATA_WIDTH_PER_INPUT = 28,
    parameter INPUT_PER_CYCLE = 32
  ) (
    inData,
    outData,
    in_start,
    out_start,
    clk,
    rst,
  );

  input clk, rst;
  input in_start;
  output logic out_start;

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

  logic stage_start[9:0];

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
    .in_start(in_start),
    .out_start(stage_start[1]),
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
    .outData_0(stage_1_2_per_outData[0]),
    .outData_1(stage_1_2_per_outData[1]),
    .outData_2(stage_1_2_per_outData[2]),
    .outData_3(stage_1_2_per_outData[3]),
    .outData_4(stage_1_2_per_outData[4]),
    .outData_5(stage_1_2_per_outData[5]),
    .outData_6(stage_1_2_per_outData[6]),
    .outData_7(stage_1_2_per_outData[7]),
    .outData_8(stage_1_2_per_outData[8]),
    .outData_9(stage_1_2_per_outData[9]),
    .outData_10(stage_1_2_per_outData[10]),
    .outData_11(stage_1_2_per_outData[11]),
    .outData_12(stage_1_2_per_outData[12]),
    .outData_13(stage_1_2_per_outData[13]),
    .outData_14(stage_1_2_per_outData[14]),
    .outData_15(stage_1_2_per_outData[15]),
    .outData_16(stage_1_2_per_outData[16]),
    .outData_17(stage_1_2_per_outData[17]),
    .outData_18(stage_1_2_per_outData[18]),
    .outData_19(stage_1_2_per_outData[19]),
    .outData_20(stage_1_2_per_outData[20]),
    .outData_21(stage_1_2_per_outData[21]),
    .outData_22(stage_1_2_per_outData[22]),
    .outData_23(stage_1_2_per_outData[23]),
    .outData_24(stage_1_2_per_outData[24]),
    .outData_25(stage_1_2_per_outData[25]),
    .outData_26(stage_1_2_per_outData[26]),
    .outData_27(stage_1_2_per_outData[27]),
    .outData_28(stage_1_2_per_outData[28]),
    .outData_29(stage_1_2_per_outData[29]),
    .outData_30(stage_1_2_per_outData[30]),
    .outData_31(stage_1_2_per_outData[31]),
    .in_start(stage_start[1]),
    .out_start(stage_start[2]),
    .clk(clk),
    .rst(rst)
  );


  // TODO(Tian): stage 2 32 butterfly units

  // TODO(Yang): stage 2 -> stage 3 permutation
  // FIXME: ignore butterfly units for now.
  stage_2_permutation #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_2_3_per (
    .inData_0(stage_1_2_per_outData[0]),
    .inData_1(stage_1_2_per_outData[1]),
    .inData_2(stage_1_2_per_outData[2]),
    .inData_3(stage_1_2_per_outData[3]),
    .inData_4(stage_1_2_per_outData[4]),
    .inData_5(stage_1_2_per_outData[5]),
    .inData_6(stage_1_2_per_outData[6]),
    .inData_7(stage_1_2_per_outData[7]),
    .inData_8(stage_1_2_per_outData[8]),
    .inData_9(stage_1_2_per_outData[9]),
    .inData_10(stage_1_2_per_outData[10]),
    .inData_11(stage_1_2_per_outData[11]),
    .inData_12(stage_1_2_per_outData[12]),
    .inData_13(stage_1_2_per_outData[13]),
    .inData_14(stage_1_2_per_outData[14]),
    .inData_15(stage_1_2_per_outData[15]),
    .inData_16(stage_1_2_per_outData[16]),
    .inData_17(stage_1_2_per_outData[17]),
    .inData_18(stage_1_2_per_outData[18]),
    .inData_19(stage_1_2_per_outData[19]),
    .inData_20(stage_1_2_per_outData[20]),
    .inData_21(stage_1_2_per_outData[21]),
    .inData_22(stage_1_2_per_outData[22]),
    .inData_23(stage_1_2_per_outData[23]),
    .inData_24(stage_1_2_per_outData[24]),
    .inData_25(stage_1_2_per_outData[25]),
    .inData_26(stage_1_2_per_outData[26]),
    .inData_27(stage_1_2_per_outData[27]),
    .inData_28(stage_1_2_per_outData[28]),
    .inData_29(stage_1_2_per_outData[29]),
    .inData_30(stage_1_2_per_outData[30]),
    .inData_31(stage_1_2_per_outData[31]),
    .outData_0(stage_2_3_per_outData[0]),
    .outData_1(stage_2_3_per_outData[1]),
    .outData_2(stage_2_3_per_outData[2]),
    .outData_3(stage_2_3_per_outData[3]),
    .outData_4(stage_2_3_per_outData[4]),
    .outData_5(stage_2_3_per_outData[5]),
    .outData_6(stage_2_3_per_outData[6]),
    .outData_7(stage_2_3_per_outData[7]),
    .outData_8(stage_2_3_per_outData[8]),
    .outData_9(stage_2_3_per_outData[9]),
    .outData_10(stage_2_3_per_outData[10]),
    .outData_11(stage_2_3_per_outData[11]),
    .outData_12(stage_2_3_per_outData[12]),
    .outData_13(stage_2_3_per_outData[13]),
    .outData_14(stage_2_3_per_outData[14]),
    .outData_15(stage_2_3_per_outData[15]),
    .outData_16(stage_2_3_per_outData[16]),
    .outData_17(stage_2_3_per_outData[17]),
    .outData_18(stage_2_3_per_outData[18]),
    .outData_19(stage_2_3_per_outData[19]),
    .outData_20(stage_2_3_per_outData[20]),
    .outData_21(stage_2_3_per_outData[21]),
    .outData_22(stage_2_3_per_outData[22]),
    .outData_23(stage_2_3_per_outData[23]),
    .outData_24(stage_2_3_per_outData[24]),
    .outData_25(stage_2_3_per_outData[25]),
    .outData_26(stage_2_3_per_outData[26]),
    .outData_27(stage_2_3_per_outData[27]),
    .outData_28(stage_2_3_per_outData[28]),
    .outData_29(stage_2_3_per_outData[29]),
    .outData_30(stage_2_3_per_outData[30]),
    .outData_31(stage_2_3_per_outData[31]),
    .in_start(stage_start[2]),
    .out_start(stage_start[3]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 3 32 butterfly units

  // TODO(Yang): stage 3 -> stage 4 permutation
  // FIXME: ignore butterfly units for now.
  stage_3_permutation #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_3_4_per (
    .inData_0(stage_2_3_per_outData[0]),
    .inData_1(stage_2_3_per_outData[1]),
    .inData_2(stage_2_3_per_outData[2]),
    .inData_3(stage_2_3_per_outData[3]),
    .inData_4(stage_2_3_per_outData[4]),
    .inData_5(stage_2_3_per_outData[5]),
    .inData_6(stage_2_3_per_outData[6]),
    .inData_7(stage_2_3_per_outData[7]),
    .inData_8(stage_2_3_per_outData[8]),
    .inData_9(stage_2_3_per_outData[9]),
    .inData_10(stage_2_3_per_outData[10]),
    .inData_11(stage_2_3_per_outData[11]),
    .inData_12(stage_2_3_per_outData[12]),
    .inData_13(stage_2_3_per_outData[13]),
    .inData_14(stage_2_3_per_outData[14]),
    .inData_15(stage_2_3_per_outData[15]),
    .inData_16(stage_2_3_per_outData[16]),
    .inData_17(stage_2_3_per_outData[17]),
    .inData_18(stage_2_3_per_outData[18]),
    .inData_19(stage_2_3_per_outData[19]),
    .inData_20(stage_2_3_per_outData[20]),
    .inData_21(stage_2_3_per_outData[21]),
    .inData_22(stage_2_3_per_outData[22]),
    .inData_23(stage_2_3_per_outData[23]),
    .inData_24(stage_2_3_per_outData[24]),
    .inData_25(stage_2_3_per_outData[25]),
    .inData_26(stage_2_3_per_outData[26]),
    .inData_27(stage_2_3_per_outData[27]),
    .inData_28(stage_2_3_per_outData[28]),
    .inData_29(stage_2_3_per_outData[29]),
    .inData_30(stage_2_3_per_outData[30]),
    .inData_31(stage_2_3_per_outData[31]),
    .outData_0(stage_3_4_per_outData[0]),
    .outData_1(stage_3_4_per_outData[1]),
    .outData_2(stage_3_4_per_outData[2]),
    .outData_3(stage_3_4_per_outData[3]),
    .outData_4(stage_3_4_per_outData[4]),
    .outData_5(stage_3_4_per_outData[5]),
    .outData_6(stage_3_4_per_outData[6]),
    .outData_7(stage_3_4_per_outData[7]),
    .outData_8(stage_3_4_per_outData[8]),
    .outData_9(stage_3_4_per_outData[9]),
    .outData_10(stage_3_4_per_outData[10]),
    .outData_11(stage_3_4_per_outData[11]),
    .outData_12(stage_3_4_per_outData[12]),
    .outData_13(stage_3_4_per_outData[13]),
    .outData_14(stage_3_4_per_outData[14]),
    .outData_15(stage_3_4_per_outData[15]),
    .outData_16(stage_3_4_per_outData[16]),
    .outData_17(stage_3_4_per_outData[17]),
    .outData_18(stage_3_4_per_outData[18]),
    .outData_19(stage_3_4_per_outData[19]),
    .outData_20(stage_3_4_per_outData[20]),
    .outData_21(stage_3_4_per_outData[21]),
    .outData_22(stage_3_4_per_outData[22]),
    .outData_23(stage_3_4_per_outData[23]),
    .outData_24(stage_3_4_per_outData[24]),
    .outData_25(stage_3_4_per_outData[25]),
    .outData_26(stage_3_4_per_outData[26]),
    .outData_27(stage_3_4_per_outData[27]),
    .outData_28(stage_3_4_per_outData[28]),
    .outData_29(stage_3_4_per_outData[29]),
    .outData_30(stage_3_4_per_outData[30]),
    .outData_31(stage_3_4_per_outData[31]),
    .in_start(stage_start[3]),
    .out_start(stage_start[4]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 4 32 butterfly units

  // TODO(Yang): stage 4 -> stage 5 permutation
  // FIXME: ignore butterfly units for now.
  stage_4_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_4_5_per (
    .inData_0(stage_3_4_per_outData[0]),
    .inData_1(stage_3_4_per_outData[1]),
    .inData_2(stage_3_4_per_outData[2]),
    .inData_3(stage_3_4_per_outData[3]),
    .inData_4(stage_3_4_per_outData[4]),
    .inData_5(stage_3_4_per_outData[5]),
    .inData_6(stage_3_4_per_outData[6]),
    .inData_7(stage_3_4_per_outData[7]),
    .inData_8(stage_3_4_per_outData[8]),
    .inData_9(stage_3_4_per_outData[9]),
    .inData_10(stage_3_4_per_outData[10]),
    .inData_11(stage_3_4_per_outData[11]),
    .inData_12(stage_3_4_per_outData[12]),
    .inData_13(stage_3_4_per_outData[13]),
    .inData_14(stage_3_4_per_outData[14]),
    .inData_15(stage_3_4_per_outData[15]),
    .inData_16(stage_3_4_per_outData[16]),
    .inData_17(stage_3_4_per_outData[17]),
    .inData_18(stage_3_4_per_outData[18]),
    .inData_19(stage_3_4_per_outData[19]),
    .inData_20(stage_3_4_per_outData[20]),
    .inData_21(stage_3_4_per_outData[21]),
    .inData_22(stage_3_4_per_outData[22]),
    .inData_23(stage_3_4_per_outData[23]),
    .inData_24(stage_3_4_per_outData[24]),
    .inData_25(stage_3_4_per_outData[25]),
    .inData_26(stage_3_4_per_outData[26]),
    .inData_27(stage_3_4_per_outData[27]),
    .inData_28(stage_3_4_per_outData[28]),
    .inData_29(stage_3_4_per_outData[29]),
    .inData_30(stage_3_4_per_outData[30]),
    .inData_31(stage_3_4_per_outData[31]),
    .outData_0(stage_4_5_per_outData[0]),
    .outData_1(stage_4_5_per_outData[1]),
    .outData_2(stage_4_5_per_outData[2]),
    .outData_3(stage_4_5_per_outData[3]),
    .outData_4(stage_4_5_per_outData[4]),
    .outData_5(stage_4_5_per_outData[5]),
    .outData_6(stage_4_5_per_outData[6]),
    .outData_7(stage_4_5_per_outData[7]),
    .outData_8(stage_4_5_per_outData[8]),
    .outData_9(stage_4_5_per_outData[9]),
    .outData_10(stage_4_5_per_outData[10]),
    .outData_11(stage_4_5_per_outData[11]),
    .outData_12(stage_4_5_per_outData[12]),
    .outData_13(stage_4_5_per_outData[13]),
    .outData_14(stage_4_5_per_outData[14]),
    .outData_15(stage_4_5_per_outData[15]),
    .outData_16(stage_4_5_per_outData[16]),
    .outData_17(stage_4_5_per_outData[17]),
    .outData_18(stage_4_5_per_outData[18]),
    .outData_19(stage_4_5_per_outData[19]),
    .outData_20(stage_4_5_per_outData[20]),
    .outData_21(stage_4_5_per_outData[21]),
    .outData_22(stage_4_5_per_outData[22]),
    .outData_23(stage_4_5_per_outData[23]),
    .outData_24(stage_4_5_per_outData[24]),
    .outData_25(stage_4_5_per_outData[25]),
    .outData_26(stage_4_5_per_outData[26]),
    .outData_27(stage_4_5_per_outData[27]),
    .outData_28(stage_4_5_per_outData[28]),
    .outData_29(stage_4_5_per_outData[29]),
    .outData_30(stage_4_5_per_outData[30]),
    .outData_31(stage_4_5_per_outData[31]),
    .in_start(stage_start[4]),
    .out_start(stage_start[5]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 5 32 butterfly units

  // TODO(Yang): stage 5 -> stage 6 permutation
  // FIXME: ignore butterfly units for now.
  stage_5_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_5_6_per (
    .inData_0(stage_4_5_per_outData[0]),
    .inData_1(stage_4_5_per_outData[1]),
    .inData_2(stage_4_5_per_outData[2]),
    .inData_3(stage_4_5_per_outData[3]),
    .inData_4(stage_4_5_per_outData[4]),
    .inData_5(stage_4_5_per_outData[5]),
    .inData_6(stage_4_5_per_outData[6]),
    .inData_7(stage_4_5_per_outData[7]),
    .inData_8(stage_4_5_per_outData[8]),
    .inData_9(stage_4_5_per_outData[9]),
    .inData_10(stage_4_5_per_outData[10]),
    .inData_11(stage_4_5_per_outData[11]),
    .inData_12(stage_4_5_per_outData[12]),
    .inData_13(stage_4_5_per_outData[13]),
    .inData_14(stage_4_5_per_outData[14]),
    .inData_15(stage_4_5_per_outData[15]),
    .inData_16(stage_4_5_per_outData[16]),
    .inData_17(stage_4_5_per_outData[17]),
    .inData_18(stage_4_5_per_outData[18]),
    .inData_19(stage_4_5_per_outData[19]),
    .inData_20(stage_4_5_per_outData[20]),
    .inData_21(stage_4_5_per_outData[21]),
    .inData_22(stage_4_5_per_outData[22]),
    .inData_23(stage_4_5_per_outData[23]),
    .inData_24(stage_4_5_per_outData[24]),
    .inData_25(stage_4_5_per_outData[25]),
    .inData_26(stage_4_5_per_outData[26]),
    .inData_27(stage_4_5_per_outData[27]),
    .inData_28(stage_4_5_per_outData[28]),
    .inData_29(stage_4_5_per_outData[29]),
    .inData_30(stage_4_5_per_outData[30]),
    .inData_31(stage_4_5_per_outData[31]),
    .outData_0(stage_5_6_per_outData[0]),
    .outData_1(stage_5_6_per_outData[1]),
    .outData_2(stage_5_6_per_outData[2]),
    .outData_3(stage_5_6_per_outData[3]),
    .outData_4(stage_5_6_per_outData[4]),
    .outData_5(stage_5_6_per_outData[5]),
    .outData_6(stage_5_6_per_outData[6]),
    .outData_7(stage_5_6_per_outData[7]),
    .outData_8(stage_5_6_per_outData[8]),
    .outData_9(stage_5_6_per_outData[9]),
    .outData_10(stage_5_6_per_outData[10]),
    .outData_11(stage_5_6_per_outData[11]),
    .outData_12(stage_5_6_per_outData[12]),
    .outData_13(stage_5_6_per_outData[13]),
    .outData_14(stage_5_6_per_outData[14]),
    .outData_15(stage_5_6_per_outData[15]),
    .outData_16(stage_5_6_per_outData[16]),
    .outData_17(stage_5_6_per_outData[17]),
    .outData_18(stage_5_6_per_outData[18]),
    .outData_19(stage_5_6_per_outData[19]),
    .outData_20(stage_5_6_per_outData[20]),
    .outData_21(stage_5_6_per_outData[21]),
    .outData_22(stage_5_6_per_outData[22]),
    .outData_23(stage_5_6_per_outData[23]),
    .outData_24(stage_5_6_per_outData[24]),
    .outData_25(stage_5_6_per_outData[25]),
    .outData_26(stage_5_6_per_outData[26]),
    .outData_27(stage_5_6_per_outData[27]),
    .outData_28(stage_5_6_per_outData[28]),
    .outData_29(stage_5_6_per_outData[29]),
    .outData_30(stage_5_6_per_outData[30]),
    .outData_31(stage_5_6_per_outData[31]),
    .in_start(stage_start[5]),
    .out_start(stage_start[6]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 6 32 butterfly units

  // TODO(Yang): stage 6 -> stage 7 permutation
  // FIXME: ignore butterfly units for now.
  stage_6_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_6_7_per (
    .inData_0(stage_5_6_per_outData[0]),
    .inData_1(stage_5_6_per_outData[1]),
    .inData_2(stage_5_6_per_outData[2]),
    .inData_3(stage_5_6_per_outData[3]),
    .inData_4(stage_5_6_per_outData[4]),
    .inData_5(stage_5_6_per_outData[5]),
    .inData_6(stage_5_6_per_outData[6]),
    .inData_7(stage_5_6_per_outData[7]),
    .inData_8(stage_5_6_per_outData[8]),
    .inData_9(stage_5_6_per_outData[9]),
    .inData_10(stage_5_6_per_outData[10]),
    .inData_11(stage_5_6_per_outData[11]),
    .inData_12(stage_5_6_per_outData[12]),
    .inData_13(stage_5_6_per_outData[13]),
    .inData_14(stage_5_6_per_outData[14]),
    .inData_15(stage_5_6_per_outData[15]),
    .inData_16(stage_5_6_per_outData[16]),
    .inData_17(stage_5_6_per_outData[17]),
    .inData_18(stage_5_6_per_outData[18]),
    .inData_19(stage_5_6_per_outData[19]),
    .inData_20(stage_5_6_per_outData[20]),
    .inData_21(stage_5_6_per_outData[21]),
    .inData_22(stage_5_6_per_outData[22]),
    .inData_23(stage_5_6_per_outData[23]),
    .inData_24(stage_5_6_per_outData[24]),
    .inData_25(stage_5_6_per_outData[25]),
    .inData_26(stage_5_6_per_outData[26]),
    .inData_27(stage_5_6_per_outData[27]),
    .inData_28(stage_5_6_per_outData[28]),
    .inData_29(stage_5_6_per_outData[29]),
    .inData_30(stage_5_6_per_outData[30]),
    .inData_31(stage_5_6_per_outData[31]),
    .outData_0(stage_6_7_per_outData[0]),
    .outData_1(stage_6_7_per_outData[1]),
    .outData_2(stage_6_7_per_outData[2]),
    .outData_3(stage_6_7_per_outData[3]),
    .outData_4(stage_6_7_per_outData[4]),
    .outData_5(stage_6_7_per_outData[5]),
    .outData_6(stage_6_7_per_outData[6]),
    .outData_7(stage_6_7_per_outData[7]),
    .outData_8(stage_6_7_per_outData[8]),
    .outData_9(stage_6_7_per_outData[9]),
    .outData_10(stage_6_7_per_outData[10]),
    .outData_11(stage_6_7_per_outData[11]),
    .outData_12(stage_6_7_per_outData[12]),
    .outData_13(stage_6_7_per_outData[13]),
    .outData_14(stage_6_7_per_outData[14]),
    .outData_15(stage_6_7_per_outData[15]),
    .outData_16(stage_6_7_per_outData[16]),
    .outData_17(stage_6_7_per_outData[17]),
    .outData_18(stage_6_7_per_outData[18]),
    .outData_19(stage_6_7_per_outData[19]),
    .outData_20(stage_6_7_per_outData[20]),
    .outData_21(stage_6_7_per_outData[21]),
    .outData_22(stage_6_7_per_outData[22]),
    .outData_23(stage_6_7_per_outData[23]),
    .outData_24(stage_6_7_per_outData[24]),
    .outData_25(stage_6_7_per_outData[25]),
    .outData_26(stage_6_7_per_outData[26]),
    .outData_27(stage_6_7_per_outData[27]),
    .outData_28(stage_6_7_per_outData[28]),
    .outData_29(stage_6_7_per_outData[29]),
    .outData_30(stage_6_7_per_outData[30]),
    .outData_31(stage_6_7_per_outData[31]),
    .in_start(stage_start[6]),
    .out_start(stage_start[7]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 7 32 butterfly units

  // TODO(Yang): stage 7 -> stage 8 permutation
  // FIXME: ignore butterfly units for now.
  stage_7_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_7_8_per (
    .inData_0(stage_6_7_per_outData[0]),
    .inData_1(stage_6_7_per_outData[1]),
    .inData_2(stage_6_7_per_outData[2]),
    .inData_3(stage_6_7_per_outData[3]),
    .inData_4(stage_6_7_per_outData[4]),
    .inData_5(stage_6_7_per_outData[5]),
    .inData_6(stage_6_7_per_outData[6]),
    .inData_7(stage_6_7_per_outData[7]),
    .inData_8(stage_6_7_per_outData[8]),
    .inData_9(stage_6_7_per_outData[9]),
    .inData_10(stage_6_7_per_outData[10]),
    .inData_11(stage_6_7_per_outData[11]),
    .inData_12(stage_6_7_per_outData[12]),
    .inData_13(stage_6_7_per_outData[13]),
    .inData_14(stage_6_7_per_outData[14]),
    .inData_15(stage_6_7_per_outData[15]),
    .inData_16(stage_6_7_per_outData[16]),
    .inData_17(stage_6_7_per_outData[17]),
    .inData_18(stage_6_7_per_outData[18]),
    .inData_19(stage_6_7_per_outData[19]),
    .inData_20(stage_6_7_per_outData[20]),
    .inData_21(stage_6_7_per_outData[21]),
    .inData_22(stage_6_7_per_outData[22]),
    .inData_23(stage_6_7_per_outData[23]),
    .inData_24(stage_6_7_per_outData[24]),
    .inData_25(stage_6_7_per_outData[25]),
    .inData_26(stage_6_7_per_outData[26]),
    .inData_27(stage_6_7_per_outData[27]),
    .inData_28(stage_6_7_per_outData[28]),
    .inData_29(stage_6_7_per_outData[29]),
    .inData_30(stage_6_7_per_outData[30]),
    .inData_31(stage_6_7_per_outData[31]),
    .outData_0(stage_7_8_per_outData[0]),
    .outData_1(stage_7_8_per_outData[1]),
    .outData_2(stage_7_8_per_outData[2]),
    .outData_3(stage_7_8_per_outData[3]),
    .outData_4(stage_7_8_per_outData[4]),
    .outData_5(stage_7_8_per_outData[5]),
    .outData_6(stage_7_8_per_outData[6]),
    .outData_7(stage_7_8_per_outData[7]),
    .outData_8(stage_7_8_per_outData[8]),
    .outData_9(stage_7_8_per_outData[9]),
    .outData_10(stage_7_8_per_outData[10]),
    .outData_11(stage_7_8_per_outData[11]),
    .outData_12(stage_7_8_per_outData[12]),
    .outData_13(stage_7_8_per_outData[13]),
    .outData_14(stage_7_8_per_outData[14]),
    .outData_15(stage_7_8_per_outData[15]),
    .outData_16(stage_7_8_per_outData[16]),
    .outData_17(stage_7_8_per_outData[17]),
    .outData_18(stage_7_8_per_outData[18]),
    .outData_19(stage_7_8_per_outData[19]),
    .outData_20(stage_7_8_per_outData[20]),
    .outData_21(stage_7_8_per_outData[21]),
    .outData_22(stage_7_8_per_outData[22]),
    .outData_23(stage_7_8_per_outData[23]),
    .outData_24(stage_7_8_per_outData[24]),
    .outData_25(stage_7_8_per_outData[25]),
    .outData_26(stage_7_8_per_outData[26]),
    .outData_27(stage_7_8_per_outData[27]),
    .outData_28(stage_7_8_per_outData[28]),
    .outData_29(stage_7_8_per_outData[29]),
    .outData_30(stage_7_8_per_outData[30]),
    .outData_31(stage_7_8_per_outData[31]),
    .in_start(stage_start[7]),
    .out_start(stage_start[8]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 8 32 butterfly units

  // TODO(Yang): stage 8 -> stage 9 permutation
  // FIXME: ignore butterfly units for now.
  stage_8_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_8_9_per (
    .inData_0(stage_7_8_per_outData[0]),
    .inData_1(stage_7_8_per_outData[1]),
    .inData_2(stage_7_8_per_outData[2]),
    .inData_3(stage_7_8_per_outData[3]),
    .inData_4(stage_7_8_per_outData[4]),
    .inData_5(stage_7_8_per_outData[5]),
    .inData_6(stage_7_8_per_outData[6]),
    .inData_7(stage_7_8_per_outData[7]),
    .inData_8(stage_7_8_per_outData[8]),
    .inData_9(stage_7_8_per_outData[9]),
    .inData_10(stage_7_8_per_outData[10]),
    .inData_11(stage_7_8_per_outData[11]),
    .inData_12(stage_7_8_per_outData[12]),
    .inData_13(stage_7_8_per_outData[13]),
    .inData_14(stage_7_8_per_outData[14]),
    .inData_15(stage_7_8_per_outData[15]),
    .inData_16(stage_7_8_per_outData[16]),
    .inData_17(stage_7_8_per_outData[17]),
    .inData_18(stage_7_8_per_outData[18]),
    .inData_19(stage_7_8_per_outData[19]),
    .inData_20(stage_7_8_per_outData[20]),
    .inData_21(stage_7_8_per_outData[21]),
    .inData_22(stage_7_8_per_outData[22]),
    .inData_23(stage_7_8_per_outData[23]),
    .inData_24(stage_7_8_per_outData[24]),
    .inData_25(stage_7_8_per_outData[25]),
    .inData_26(stage_7_8_per_outData[26]),
    .inData_27(stage_7_8_per_outData[27]),
    .inData_28(stage_7_8_per_outData[28]),
    .inData_29(stage_7_8_per_outData[29]),
    .inData_30(stage_7_8_per_outData[30]),
    .inData_31(stage_7_8_per_outData[31]),
    .outData_0(stage_8_9_per_outData[0]),
    .outData_1(stage_8_9_per_outData[1]),
    .outData_2(stage_8_9_per_outData[2]),
    .outData_3(stage_8_9_per_outData[3]),
    .outData_4(stage_8_9_per_outData[4]),
    .outData_5(stage_8_9_per_outData[5]),
    .outData_6(stage_8_9_per_outData[6]),
    .outData_7(stage_8_9_per_outData[7]),
    .outData_8(stage_8_9_per_outData[8]),
    .outData_9(stage_8_9_per_outData[9]),
    .outData_10(stage_8_9_per_outData[10]),
    .outData_11(stage_8_9_per_outData[11]),
    .outData_12(stage_8_9_per_outData[12]),
    .outData_13(stage_8_9_per_outData[13]),
    .outData_14(stage_8_9_per_outData[14]),
    .outData_15(stage_8_9_per_outData[15]),
    .outData_16(stage_8_9_per_outData[16]),
    .outData_17(stage_8_9_per_outData[17]),
    .outData_18(stage_8_9_per_outData[18]),
    .outData_19(stage_8_9_per_outData[19]),
    .outData_20(stage_8_9_per_outData[20]),
    .outData_21(stage_8_9_per_outData[21]),
    .outData_22(stage_8_9_per_outData[22]),
    .outData_23(stage_8_9_per_outData[23]),
    .outData_24(stage_8_9_per_outData[24]),
    .outData_25(stage_8_9_per_outData[25]),
    .outData_26(stage_8_9_per_outData[26]),
    .outData_27(stage_8_9_per_outData[27]),
    .outData_28(stage_8_9_per_outData[28]),
    .outData_29(stage_8_9_per_outData[29]),
    .outData_30(stage_8_9_per_outData[30]),
    .outData_31(stage_8_9_per_outData[31]),
    .in_start(stage_start[8]),
    .out_start(out_start),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 9 32 butterfly units

  assign outData[0] = stage_8_9_per_outData[0];
  assign outData[1] = stage_8_9_per_outData[1];
  assign outData[2] = stage_8_9_per_outData[2];
  assign outData[3] = stage_8_9_per_outData[3];
  assign outData[4] = stage_8_9_per_outData[4];
  assign outData[5] = stage_8_9_per_outData[5];
  assign outData[6] = stage_8_9_per_outData[6];
  assign outData[7] = stage_8_9_per_outData[7];
  assign outData[8] = stage_8_9_per_outData[8];
  assign outData[9] = stage_8_9_per_outData[9];
  assign outData[10] = stage_8_9_per_outData[10];
  assign outData[11] = stage_8_9_per_outData[11];
  assign outData[12] = stage_8_9_per_outData[12];
  assign outData[13] = stage_8_9_per_outData[13];
  assign outData[14] = stage_8_9_per_outData[14];
  assign outData[15] = stage_8_9_per_outData[15];
  assign outData[16] = stage_8_9_per_outData[16];
  assign outData[17] = stage_8_9_per_outData[17];
  assign outData[18] = stage_8_9_per_outData[18];
  assign outData[19] = stage_8_9_per_outData[19];
  assign outData[20] = stage_8_9_per_outData[20];
  assign outData[21] = stage_8_9_per_outData[21];
  assign outData[22] = stage_8_9_per_outData[22];
  assign outData[23] = stage_8_9_per_outData[23];
  assign outData[24] = stage_8_9_per_outData[24];
  assign outData[25] = stage_8_9_per_outData[25];
  assign outData[26] = stage_8_9_per_outData[26];
  assign outData[27] = stage_8_9_per_outData[27];
  assign outData[28] = stage_8_9_per_outData[28];
  assign outData[29] = stage_8_9_per_outData[29];
  assign outData[30] = stage_8_9_per_outData[30];
  assign outData[31] = stage_8_9_per_outData[31];

endmodule
