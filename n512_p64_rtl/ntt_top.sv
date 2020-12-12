// NTT Accelerator

module NTT_Top #(
    parameter DATA_WIDTH_PER_INPUT = 28,
    parameter INPUT_PER_CYCLE = 64
  ) (
    inData,
    outData,
    in_start,
    out_start,
    clk,
    rst,
  );

  input clk, rst;

  input in_start[7:0];
  output logic out_start[7:0];

  input        [DATA_WIDTH_PER_INPUT-1:0] inData[INPUT_PER_CYCLE-1:0];
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData[INPUT_PER_CYCLE-1:0];

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_0_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_0_per_out[INPUT_PER_CYCLE-1:0];

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_1_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_1_per_out[INPUT_PER_CYCLE-1:0];

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_2_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_2_per_out[INPUT_PER_CYCLE-1:0];

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_3_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_3_per_out[INPUT_PER_CYCLE-1:0];

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_4_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_4_per_out[INPUT_PER_CYCLE-1:0];

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_5_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_5_per_out[INPUT_PER_CYCLE-1:0];

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_6_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_6_per_out[INPUT_PER_CYCLE-1:0];

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_7_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_7_per_out[INPUT_PER_CYCLE-1:0];

  parameter [6:0] START_CYCLE[8] = {0, 7, 14, 21, 28, 35, 58, 82};

  // TODO(Tian): stage 0 32 butterfly units
  butterfly #(
    .start(START_CYCLE[0]),
    .factors({1562592, 142306631, 6010959, 154421517, 168676526, 77981460, 68559335, 203044972}))
  stage_0_butterfly_0 (
    .x_in(inData[0]),
    .y_in(inData[1]),
    .x_out(stage_0_per_in[0]),
    .y_out(stage_0_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({19223387, 170930026, 42156432, 40718170, 87088032, 98861208, 118377542, 69773246}))
  stage_0_butterfly_1 (
    .x_in(inData[2]),
    .y_in(inData[3]),
    .x_out(stage_0_per_in[2]),
    .y_out(stage_0_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({50222736, 103731033, 95861179, 251138298, 79136411, 226014319, 202127782, 59284831}))
  stage_0_butterfly_2 (
    .x_in(inData[4]),
    .y_in(inData[5]),
    .x_out(stage_0_per_in[4]),
    .y_out(stage_0_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({185685569, 258257144, 234350511, 50138453, 131377029, 132750946, 67321994, 144929841}))
  stage_0_butterfly_3 (
    .x_in(inData[6]),
    .y_in(inData[7]),
    .x_out(stage_0_per_in[6]),
    .y_out(stage_0_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({210770212, 196328787, 6574921, 181167649, 57574719, 48631162, 148390399, 212760505}))
  stage_0_butterfly_4 (
    .x_in(inData[8]),
    .y_in(inData[9]),
    .x_out(stage_0_per_in[8]),
    .y_out(stage_0_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({137346680, 177340471, 242302870, 193915204, 186863562, 24688427, 172809179, 50986641}))
  stage_0_butterfly_5 (
    .x_in(inData[10]),
    .y_in(inData[11]),
    .x_out(stage_0_per_in[10]),
    .y_out(stage_0_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({166955734, 173118058, 58786546, 224794776, 87074609, 34481514, 119568150, 49057739}))
  stage_0_butterfly_6 (
    .x_in(inData[12]),
    .y_in(inData[13]),
    .x_out(stage_0_per_in[12]),
    .y_out(stage_0_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({219898221, 97318594, 137672988, 47375162, 100229847, 263530653, 183117409, 71598752}))
  stage_0_butterfly_7 (
    .x_in(inData[14]),
    .y_in(inData[15]),
    .x_out(stage_0_per_in[14]),
    .y_out(stage_0_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({233514072, 160807241, 23892097, 91704337, 263070789, 23405380, 263077695, 5905084}))
  stage_0_butterfly_8 (
    .x_in(inData[16]),
    .y_in(inData[17]),
    .x_out(stage_0_per_in[16]),
    .y_out(stage_0_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({55567611, 109902969, 165872957, 8950678, 234113027, 178386996, 209725121, 82155735}))
  stage_0_butterfly_9 (
    .x_in(inData[18]),
    .y_in(inData[19]),
    .x_out(stage_0_per_in[18]),
    .y_out(stage_0_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({69584498, 83725194, 266756542, 175719113, 225650462, 157966005, 200102186, 153883128}))
  stage_0_butterfly_10 (
    .x_in(inData[20]),
    .y_in(inData[21]),
    .x_out(stage_0_per_in[20]),
    .y_out(stage_0_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({54534442, 13083849, 158727274, 210914061, 224586596, 240127751, 210734246, 77389872}))
  stage_0_butterfly_11 (
    .x_in(inData[22]),
    .y_in(inData[23]),
    .x_out(stage_0_per_in[22]),
    .y_out(stage_0_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({258226806, 61574386, 242025902, 103019692, 8411857, 256173379, 9842125, 212214167}))
  stage_0_butterfly_12 (
    .x_in(inData[24]),
    .y_in(inData[25]),
    .x_out(stage_0_per_in[24]),
    .y_out(stage_0_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({202059197, 225389748, 256869432, 238382196, 253800975, 199633043, 61345534, 173087458}))
  stage_0_butterfly_13 (
    .x_in(inData[26]),
    .y_in(inData[27]),
    .x_out(stage_0_per_in[26]),
    .y_out(stage_0_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({257649131, 21080194, 232445568, 143969870, 108115637, 141849606, 206252403, 94612904}))
  stage_0_butterfly_14 (
    .x_in(inData[28]),
    .y_in(inData[29]),
    .x_out(stage_0_per_in[28]),
    .y_out(stage_0_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({237102043, 220490426, 21116414, 16128104, 203485423, 222683851, 126945619, 258366673}))
  stage_0_butterfly_15 (
    .x_in(inData[30]),
    .y_in(inData[31]),
    .x_out(stage_0_per_in[30]),
    .y_out(stage_0_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({67970382, 204886617, 129101436, 206372598, 62408001, 107527972, 262540431, 20857483}))
  stage_0_butterfly_16 (
    .x_in(inData[32]),
    .y_in(inData[33]),
    .x_out(stage_0_per_in[32]),
    .y_out(stage_0_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({167366585, 165134943, 49675259, 67620310, 75073484, 67225153, 168977833, 228211497}))
  stage_0_butterfly_17 (
    .x_in(inData[34]),
    .y_in(inData[35]),
    .x_out(stage_0_per_in[34]),
    .y_out(stage_0_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({39269267, 256272276, 25853611, 35918322, 224068691, 17861009, 32087335, 25944135}))
  stage_0_butterfly_18 (
    .x_in(inData[36]),
    .y_in(inData[37]),
    .x_out(stage_0_per_in[36]),
    .y_out(stage_0_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({32260862, 146037274, 149200070, 211426643, 151148155, 134877507, 212123710, 16985430}))
  stage_0_butterfly_19 (
    .x_in(inData[38]),
    .y_in(inData[39]),
    .x_out(stage_0_per_in[38]),
    .y_out(stage_0_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({206649748, 44144526, 24153138, 161171966, 63079505, 216395023, 128003797, 195748297}))
  stage_0_butterfly_20 (
    .x_in(inData[40]),
    .y_in(inData[41]),
    .x_out(stage_0_per_in[40]),
    .y_out(stage_0_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({49286409, 134100899, 43078133, 237438985, 56094099, 66298746, 195288398, 84058929}))
  stage_0_butterfly_21 (
    .x_in(inData[42]),
    .y_in(inData[43]),
    .x_out(stage_0_per_in[42]),
    .y_out(stage_0_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({172935357, 186841927, 49504466, 21739535, 82934386, 254132077, 61644903, 187864761}))
  stage_0_butterfly_22 (
    .x_in(inData[44]),
    .y_in(inData[45]),
    .x_out(stage_0_per_in[44]),
    .y_out(stage_0_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({250071443, 143102859, 73698550, 61664240, 158890265, 167911982, 138879618, 207329882}))
  stage_0_butterfly_23 (
    .x_in(inData[46]),
    .y_in(inData[47]),
    .x_out(stage_0_per_in[46]),
    .y_out(stage_0_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({223822620, 83231671, 201863951, 143779572, 191444307, 98889920, 75537498, 181468172}))
  stage_0_butterfly_24 (
    .x_in(inData[48]),
    .y_in(inData[49]),
    .x_out(stage_0_per_in[48]),
    .y_out(stage_0_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({209886001, 43104106, 60072008, 112003761, 205525433, 189720821, 188517169, 27056737}))
  stage_0_butterfly_25 (
    .x_in(inData[50]),
    .y_in(inData[51]),
    .x_out(stage_0_per_in[50]),
    .y_out(stage_0_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({194276347, 68493159, 215146927, 171541778, 190319963, 142181410, 136878682, 40550456}))
  stage_0_butterfly_26 (
    .x_in(inData[52]),
    .y_in(inData[53]),
    .x_out(stage_0_per_in[52]),
    .y_out(stage_0_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({203605228, 34971158, 110201077, 43194148, 202955937, 232615475, 209658551, 137065607}))
  stage_0_butterfly_27 (
    .x_in(inData[54]),
    .y_in(inData[55]),
    .x_out(stage_0_per_in[54]),
    .y_out(stage_0_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({174900371, 93740850, 85678851, 225784463, 254911070, 102915173, 176209504, 155060883}))
  stage_0_butterfly_28 (
    .x_in(inData[56]),
    .y_in(inData[57]),
    .x_out(stage_0_per_in[56]),
    .y_out(stage_0_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({260909397, 123335450, 11100143, 202776751, 244763177, 99187435, 138793148, 183029478}))
  stage_0_butterfly_29 (
    .x_in(inData[58]),
    .y_in(inData[59]),
    .x_out(stage_0_per_in[58]),
    .y_out(stage_0_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({222861227, 16471674, 6292910, 117507527, 182702557, 135886841, 60548134, 25345558}))
  stage_0_butterfly_30 (
    .x_in(inData[60]),
    .y_in(inData[61]),
    .x_out(stage_0_per_in[60]),
    .y_out(stage_0_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({71847431, 258559590, 36946189, 171362072, 100123291, 170284131, 117274103, 266671862}))
  stage_0_butterfly_31 (
    .x_in(inData[62]),
    .y_in(inData[63]),
    .x_out(stage_0_per_in[62]),
    .y_out(stage_0_per_in[63]),
    .clk(clk),
    .rst(rst)
  );




  // TODO(Yang): stage 0 -> stage 1 permutation
  // FIXME: ignore butterfly units for now.
  stage_0_permutation #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_0_1_per (
    .inData_0(stage_0_per_in[0]),
    .inData_1(stage_0_per_in[1]),
    .inData_2(stage_0_per_in[2]),
    .inData_3(stage_0_per_in[3]),
    .inData_4(stage_0_per_in[4]),
    .inData_5(stage_0_per_in[5]),
    .inData_6(stage_0_per_in[6]),
    .inData_7(stage_0_per_in[7]),
    .inData_8(stage_0_per_in[8]),
    .inData_9(stage_0_per_in[9]),
    .inData_10(stage_0_per_in[10]),
    .inData_11(stage_0_per_in[11]),
    .inData_12(stage_0_per_in[12]),
    .inData_13(stage_0_per_in[13]),
    .inData_14(stage_0_per_in[14]),
    .inData_15(stage_0_per_in[15]),
    .inData_16(stage_0_per_in[16]),
    .inData_17(stage_0_per_in[17]),
    .inData_18(stage_0_per_in[18]),
    .inData_19(stage_0_per_in[19]),
    .inData_20(stage_0_per_in[20]),
    .inData_21(stage_0_per_in[21]),
    .inData_22(stage_0_per_in[22]),
    .inData_23(stage_0_per_in[23]),
    .inData_24(stage_0_per_in[24]),
    .inData_25(stage_0_per_in[25]),
    .inData_26(stage_0_per_in[26]),
    .inData_27(stage_0_per_in[27]),
    .inData_28(stage_0_per_in[28]),
    .inData_29(stage_0_per_in[29]),
    .inData_30(stage_0_per_in[30]),
    .inData_31(stage_0_per_in[31]),
    .inData_32(stage_0_per_in[32]),
    .inData_33(stage_0_per_in[33]),
    .inData_34(stage_0_per_in[34]),
    .inData_35(stage_0_per_in[35]),
    .inData_36(stage_0_per_in[36]),
    .inData_37(stage_0_per_in[37]),
    .inData_38(stage_0_per_in[38]),
    .inData_39(stage_0_per_in[39]),
    .inData_40(stage_0_per_in[40]),
    .inData_41(stage_0_per_in[41]),
    .inData_42(stage_0_per_in[42]),
    .inData_43(stage_0_per_in[43]),
    .inData_44(stage_0_per_in[44]),
    .inData_45(stage_0_per_in[45]),
    .inData_46(stage_0_per_in[46]),
    .inData_47(stage_0_per_in[47]),
    .inData_48(stage_0_per_in[48]),
    .inData_49(stage_0_per_in[49]),
    .inData_50(stage_0_per_in[50]),
    .inData_51(stage_0_per_in[51]),
    .inData_52(stage_0_per_in[52]),
    .inData_53(stage_0_per_in[53]),
    .inData_54(stage_0_per_in[54]),
    .inData_55(stage_0_per_in[55]),
    .inData_56(stage_0_per_in[56]),
    .inData_57(stage_0_per_in[57]),
    .inData_58(stage_0_per_in[58]),
    .inData_59(stage_0_per_in[59]),
    .inData_60(stage_0_per_in[60]),
    .inData_61(stage_0_per_in[61]),
    .inData_62(stage_0_per_in[62]),
    .inData_63(stage_0_per_in[63]),
    .outData_0(stage_0_per_out[0]),
    .outData_1(stage_0_per_out[1]),
    .outData_2(stage_0_per_out[2]),
    .outData_3(stage_0_per_out[3]),
    .outData_4(stage_0_per_out[4]),
    .outData_5(stage_0_per_out[5]),
    .outData_6(stage_0_per_out[6]),
    .outData_7(stage_0_per_out[7]),
    .outData_8(stage_0_per_out[8]),
    .outData_9(stage_0_per_out[9]),
    .outData_10(stage_0_per_out[10]),
    .outData_11(stage_0_per_out[11]),
    .outData_12(stage_0_per_out[12]),
    .outData_13(stage_0_per_out[13]),
    .outData_14(stage_0_per_out[14]),
    .outData_15(stage_0_per_out[15]),
    .outData_16(stage_0_per_out[16]),
    .outData_17(stage_0_per_out[17]),
    .outData_18(stage_0_per_out[18]),
    .outData_19(stage_0_per_out[19]),
    .outData_20(stage_0_per_out[20]),
    .outData_21(stage_0_per_out[21]),
    .outData_22(stage_0_per_out[22]),
    .outData_23(stage_0_per_out[23]),
    .outData_24(stage_0_per_out[24]),
    .outData_25(stage_0_per_out[25]),
    .outData_26(stage_0_per_out[26]),
    .outData_27(stage_0_per_out[27]),
    .outData_28(stage_0_per_out[28]),
    .outData_29(stage_0_per_out[29]),
    .outData_30(stage_0_per_out[30]),
    .outData_31(stage_0_per_out[31]),
    .outData_32(stage_0_per_out[32]),
    .outData_33(stage_0_per_out[33]),
    .outData_34(stage_0_per_out[34]),
    .outData_35(stage_0_per_out[35]),
    .outData_36(stage_0_per_out[36]),
    .outData_37(stage_0_per_out[37]),
    .outData_38(stage_0_per_out[38]),
    .outData_39(stage_0_per_out[39]),
    .outData_40(stage_0_per_out[40]),
    .outData_41(stage_0_per_out[41]),
    .outData_42(stage_0_per_out[42]),
    .outData_43(stage_0_per_out[43]),
    .outData_44(stage_0_per_out[44]),
    .outData_45(stage_0_per_out[45]),
    .outData_46(stage_0_per_out[46]),
    .outData_47(stage_0_per_out[47]),
    .outData_48(stage_0_per_out[48]),
    .outData_49(stage_0_per_out[49]),
    .outData_50(stage_0_per_out[50]),
    .outData_51(stage_0_per_out[51]),
    .outData_52(stage_0_per_out[52]),
    .outData_53(stage_0_per_out[53]),
    .outData_54(stage_0_per_out[54]),
    .outData_55(stage_0_per_out[55]),
    .outData_56(stage_0_per_out[56]),
    .outData_57(stage_0_per_out[57]),
    .outData_58(stage_0_per_out[58]),
    .outData_59(stage_0_per_out[59]),
    .outData_60(stage_0_per_out[60]),
    .outData_61(stage_0_per_out[61]),
    .outData_62(stage_0_per_out[62]),
    .outData_63(stage_0_per_out[63]),
    .in_start(in_start[0]),
    .out_start(out_start[0]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Tian): stage 1 32 butterfly units
  butterfly #(
    .start(START_CYCLE[1]),
    .factors({64217206, 163585105, 180525688, 144414946, 265950570, 6576175, 258612781, 189881206}))
  stage_1_butterfly_0 (
    .x_in(stage_0_per_out[0]),
    .y_in(stage_0_per_out[1]),
    .x_out(stage_1_per_in[0]),
    .y_out(stage_1_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({64217206, 163585105, 180525688, 144414946, 265950570, 6576175, 258612781, 189881206}))
  stage_1_butterfly_1 (
    .x_in(stage_0_per_out[2]),
    .y_in(stage_0_per_out[3]),
    .x_out(stage_1_per_in[2]),
    .y_out(stage_1_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({202221416, 3883583, 69161747, 56700993, 27692847, 188210893, 209086118, 81777479}))
  stage_1_butterfly_2 (
    .x_in(stage_0_per_out[4]),
    .y_in(stage_0_per_out[5]),
    .x_out(stage_1_per_in[4]),
    .y_out(stage_1_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({202221416, 3883583, 69161747, 56700993, 27692847, 188210893, 209086118, 81777479}))
  stage_1_butterfly_3 (
    .x_in(stage_0_per_out[6]),
    .y_in(stage_0_per_out[7]),
    .x_out(stage_1_per_in[6]),
    .y_out(stage_1_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({108083129, 133503098, 22541719, 25569479, 166530134, 116401819, 94666956, 139182289}))
  stage_1_butterfly_4 (
    .x_in(stage_0_per_out[8]),
    .y_in(stage_0_per_out[9]),
    .x_out(stage_1_per_in[8]),
    .y_out(stage_1_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({108083129, 133503098, 22541719, 25569479, 166530134, 116401819, 94666956, 139182289}))
  stage_1_butterfly_5 (
    .x_in(stage_0_per_out[10]),
    .y_in(stage_0_per_out[11]),
    .x_out(stage_1_per_in[10]),
    .y_out(stage_1_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({229216409, 227283585, 13250338, 122008382, 256040960, 249640399, 177772804, 10130658}))
  stage_1_butterfly_6 (
    .x_in(stage_0_per_out[12]),
    .y_in(stage_0_per_out[13]),
    .x_out(stage_1_per_in[12]),
    .y_out(stage_1_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({229216409, 227283585, 13250338, 122008382, 256040960, 249640399, 177772804, 10130658}))
  stage_1_butterfly_7 (
    .x_in(stage_0_per_out[14]),
    .y_in(stage_0_per_out[15]),
    .x_out(stage_1_per_in[14]),
    .y_out(stage_1_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({254509489, 113201512, 84143174, 225636920, 181639510, 101483624, 34339674, 176471684}))
  stage_1_butterfly_8 (
    .x_in(stage_0_per_out[16]),
    .y_in(stage_0_per_out[17]),
    .x_out(stage_1_per_in[16]),
    .y_out(stage_1_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({254509489, 113201512, 84143174, 225636920, 181639510, 101483624, 34339674, 176471684}))
  stage_1_butterfly_9 (
    .x_in(stage_0_per_out[18]),
    .y_in(stage_0_per_out[19]),
    .x_out(stage_1_per_in[18]),
    .y_out(stage_1_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({55721255, 163812837, 71933862, 147433882, 216143425, 197305753, 41155851, 184516225}))
  stage_1_butterfly_10 (
    .x_in(stage_0_per_out[20]),
    .y_in(stage_0_per_out[21]),
    .x_out(stage_1_per_in[20]),
    .y_out(stage_1_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({55721255, 163812837, 71933862, 147433882, 216143425, 197305753, 41155851, 184516225}))
  stage_1_butterfly_11 (
    .x_in(stage_0_per_out[22]),
    .y_in(stage_0_per_out[23]),
    .x_out(stage_1_per_in[22]),
    .y_out(stage_1_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({220618744, 96142103, 37667151, 210298252, 119707826, 68136911, 106640438, 27244461}))
  stage_1_butterfly_12 (
    .x_in(stage_0_per_out[24]),
    .y_in(stage_0_per_out[25]),
    .x_out(stage_1_per_in[24]),
    .y_out(stage_1_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({220618744, 96142103, 37667151, 210298252, 119707826, 68136911, 106640438, 27244461}))
  stage_1_butterfly_13 (
    .x_in(stage_0_per_out[26]),
    .y_in(stage_0_per_out[27]),
    .x_out(stage_1_per_in[26]),
    .y_out(stage_1_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({15417588, 149528048, 124400208, 197074908, 39141691, 11101448, 85021501, 243304319}))
  stage_1_butterfly_14 (
    .x_in(stage_0_per_out[28]),
    .y_in(stage_0_per_out[29]),
    .x_out(stage_1_per_in[28]),
    .y_out(stage_1_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({15417588, 149528048, 124400208, 197074908, 39141691, 11101448, 85021501, 243304319}))
  stage_1_butterfly_15 (
    .x_in(stage_0_per_out[30]),
    .y_in(stage_0_per_out[31]),
    .x_out(stage_1_per_in[30]),
    .y_out(stage_1_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({204666342, 265574867, 9446767, 248876054, 123185272, 261314274, 75673633, 245906264}))
  stage_1_butterfly_16 (
    .x_in(stage_0_per_out[32]),
    .y_in(stage_0_per_out[33]),
    .x_out(stage_1_per_in[32]),
    .y_out(stage_1_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({204666342, 265574867, 9446767, 248876054, 123185272, 261314274, 75673633, 245906264}))
  stage_1_butterfly_17 (
    .x_in(stage_0_per_out[34]),
    .y_in(stage_0_per_out[35]),
    .x_out(stage_1_per_in[34]),
    .y_out(stage_1_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({26687688, 161827885, 98878775, 258649698, 85922744, 23486645, 159404461, 78777967}))
  stage_1_butterfly_18 (
    .x_in(stage_0_per_out[36]),
    .y_in(stage_0_per_out[37]),
    .x_out(stage_1_per_in[36]),
    .y_out(stage_1_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({26687688, 161827885, 98878775, 258649698, 85922744, 23486645, 159404461, 78777967}))
  stage_1_butterfly_19 (
    .x_in(stage_0_per_out[38]),
    .y_in(stage_0_per_out[39]),
    .x_out(stage_1_per_in[38]),
    .y_out(stage_1_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({227816219, 246744565, 128814716, 132703565, 13919506, 135288005, 231318087, 54284329}))
  stage_1_butterfly_20 (
    .x_in(stage_0_per_out[40]),
    .y_in(stage_0_per_out[41]),
    .x_out(stage_1_per_in[40]),
    .y_out(stage_1_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({227816219, 246744565, 128814716, 132703565, 13919506, 135288005, 231318087, 54284329}))
  stage_1_butterfly_21 (
    .x_in(stage_0_per_out[42]),
    .y_in(stage_0_per_out[43]),
    .x_out(stage_1_per_in[42]),
    .y_out(stage_1_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({118518376, 164195239, 28824907, 168407516, 97765534, 29871855, 137812299, 63350037}))
  stage_1_butterfly_22 (
    .x_in(stage_0_per_out[44]),
    .y_in(stage_0_per_out[45]),
    .x_out(stage_1_per_in[44]),
    .y_out(stage_1_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({118518376, 164195239, 28824907, 168407516, 97765534, 29871855, 137812299, 63350037}))
  stage_1_butterfly_23 (
    .x_in(stage_0_per_out[46]),
    .y_in(stage_0_per_out[47]),
    .x_out(stage_1_per_in[46]),
    .y_out(stage_1_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({108810259, 191032230, 195631434, 252442032, 40475021, 189762285, 74998629, 236144340}))
  stage_1_butterfly_24 (
    .x_in(stage_0_per_out[48]),
    .y_in(stage_0_per_out[49]),
    .x_out(stage_1_per_in[48]),
    .y_out(stage_1_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({108810259, 191032230, 195631434, 252442032, 40475021, 189762285, 74998629, 236144340}))
  stage_1_butterfly_25 (
    .x_in(stage_0_per_out[50]),
    .y_in(stage_0_per_out[51]),
    .x_out(stage_1_per_in[50]),
    .y_out(stage_1_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({214551729, 234250032, 171721518, 106338196, 14542514, 246656426, 150873005, 209161759}))
  stage_1_butterfly_26 (
    .x_in(stage_0_per_out[52]),
    .y_in(stage_0_per_out[53]),
    .x_out(stage_1_per_in[52]),
    .y_out(stage_1_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({214551729, 234250032, 171721518, 106338196, 14542514, 246656426, 150873005, 209161759}))
  stage_1_butterfly_27 (
    .x_in(stage_0_per_out[54]),
    .y_in(stage_0_per_out[55]),
    .x_out(stage_1_per_in[54]),
    .y_out(stage_1_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({234890903, 67012048, 18399308, 220375582, 98142515, 176917280, 250166212, 37011073}))
  stage_1_butterfly_28 (
    .x_in(stage_0_per_out[56]),
    .y_in(stage_0_per_out[57]),
    .x_out(stage_1_per_in[56]),
    .y_out(stage_1_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({234890903, 67012048, 18399308, 220375582, 98142515, 176917280, 250166212, 37011073}))
  stage_1_butterfly_29 (
    .x_in(stage_0_per_out[58]),
    .y_in(stage_0_per_out[59]),
    .x_out(stage_1_per_in[58]),
    .y_out(stage_1_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({223427563, 226739459, 50725340, 13519489, 257798138, 81956368, 100484142, 230433664}))
  stage_1_butterfly_30 (
    .x_in(stage_0_per_out[60]),
    .y_in(stage_0_per_out[61]),
    .x_out(stage_1_per_in[60]),
    .y_out(stage_1_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({223427563, 226739459, 50725340, 13519489, 257798138, 81956368, 100484142, 230433664}))
  stage_1_butterfly_31 (
    .x_in(stage_0_per_out[62]),
    .y_in(stage_0_per_out[63]),
    .x_out(stage_1_per_in[62]),
    .y_out(stage_1_per_in[63]),
    .clk(clk),
    .rst(rst)
  );


  
  // TODO(Yang): stage 1 -> stage 2 permutation
  // FIXME: ignore butterfly units for now.
  stage_1_permutation #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_1_2_per (
    .inData_0(stage_1_per_in[0]),
    .inData_1(stage_1_per_in[1]),
    .inData_2(stage_1_per_in[2]),
    .inData_3(stage_1_per_in[3]),
    .inData_4(stage_1_per_in[4]),
    .inData_5(stage_1_per_in[5]),
    .inData_6(stage_1_per_in[6]),
    .inData_7(stage_1_per_in[7]),
    .inData_8(stage_1_per_in[8]),
    .inData_9(stage_1_per_in[9]),
    .inData_10(stage_1_per_in[10]),
    .inData_11(stage_1_per_in[11]),
    .inData_12(stage_1_per_in[12]),
    .inData_13(stage_1_per_in[13]),
    .inData_14(stage_1_per_in[14]),
    .inData_15(stage_1_per_in[15]),
    .inData_16(stage_1_per_in[16]),
    .inData_17(stage_1_per_in[17]),
    .inData_18(stage_1_per_in[18]),
    .inData_19(stage_1_per_in[19]),
    .inData_20(stage_1_per_in[20]),
    .inData_21(stage_1_per_in[21]),
    .inData_22(stage_1_per_in[22]),
    .inData_23(stage_1_per_in[23]),
    .inData_24(stage_1_per_in[24]),
    .inData_25(stage_1_per_in[25]),
    .inData_26(stage_1_per_in[26]),
    .inData_27(stage_1_per_in[27]),
    .inData_28(stage_1_per_in[28]),
    .inData_29(stage_1_per_in[29]),
    .inData_30(stage_1_per_in[30]),
    .inData_31(stage_1_per_in[31]),
    .inData_32(stage_1_per_in[32]),
    .inData_33(stage_1_per_in[33]),
    .inData_34(stage_1_per_in[34]),
    .inData_35(stage_1_per_in[35]),
    .inData_36(stage_1_per_in[36]),
    .inData_37(stage_1_per_in[37]),
    .inData_38(stage_1_per_in[38]),
    .inData_39(stage_1_per_in[39]),
    .inData_40(stage_1_per_in[40]),
    .inData_41(stage_1_per_in[41]),
    .inData_42(stage_1_per_in[42]),
    .inData_43(stage_1_per_in[43]),
    .inData_44(stage_1_per_in[44]),
    .inData_45(stage_1_per_in[45]),
    .inData_46(stage_1_per_in[46]),
    .inData_47(stage_1_per_in[47]),
    .inData_48(stage_1_per_in[48]),
    .inData_49(stage_1_per_in[49]),
    .inData_50(stage_1_per_in[50]),
    .inData_51(stage_1_per_in[51]),
    .inData_52(stage_1_per_in[52]),
    .inData_53(stage_1_per_in[53]),
    .inData_54(stage_1_per_in[54]),
    .inData_55(stage_1_per_in[55]),
    .inData_56(stage_1_per_in[56]),
    .inData_57(stage_1_per_in[57]),
    .inData_58(stage_1_per_in[58]),
    .inData_59(stage_1_per_in[59]),
    .inData_60(stage_1_per_in[60]),
    .inData_61(stage_1_per_in[61]),
    .inData_62(stage_1_per_in[62]),
    .inData_63(stage_1_per_in[63]),
    .outData_0(stage_1_per_out[0]),
    .outData_1(stage_1_per_out[1]),
    .outData_2(stage_1_per_out[2]),
    .outData_3(stage_1_per_out[3]),
    .outData_4(stage_1_per_out[4]),
    .outData_5(stage_1_per_out[5]),
    .outData_6(stage_1_per_out[6]),
    .outData_7(stage_1_per_out[7]),
    .outData_8(stage_1_per_out[8]),
    .outData_9(stage_1_per_out[9]),
    .outData_10(stage_1_per_out[10]),
    .outData_11(stage_1_per_out[11]),
    .outData_12(stage_1_per_out[12]),
    .outData_13(stage_1_per_out[13]),
    .outData_14(stage_1_per_out[14]),
    .outData_15(stage_1_per_out[15]),
    .outData_16(stage_1_per_out[16]),
    .outData_17(stage_1_per_out[17]),
    .outData_18(stage_1_per_out[18]),
    .outData_19(stage_1_per_out[19]),
    .outData_20(stage_1_per_out[20]),
    .outData_21(stage_1_per_out[21]),
    .outData_22(stage_1_per_out[22]),
    .outData_23(stage_1_per_out[23]),
    .outData_24(stage_1_per_out[24]),
    .outData_25(stage_1_per_out[25]),
    .outData_26(stage_1_per_out[26]),
    .outData_27(stage_1_per_out[27]),
    .outData_28(stage_1_per_out[28]),
    .outData_29(stage_1_per_out[29]),
    .outData_30(stage_1_per_out[30]),
    .outData_31(stage_1_per_out[31]),
    .outData_32(stage_1_per_out[32]),
    .outData_33(stage_1_per_out[33]),
    .outData_34(stage_1_per_out[34]),
    .outData_35(stage_1_per_out[35]),
    .outData_36(stage_1_per_out[36]),
    .outData_37(stage_1_per_out[37]),
    .outData_38(stage_1_per_out[38]),
    .outData_39(stage_1_per_out[39]),
    .outData_40(stage_1_per_out[40]),
    .outData_41(stage_1_per_out[41]),
    .outData_42(stage_1_per_out[42]),
    .outData_43(stage_1_per_out[43]),
    .outData_44(stage_1_per_out[44]),
    .outData_45(stage_1_per_out[45]),
    .outData_46(stage_1_per_out[46]),
    .outData_47(stage_1_per_out[47]),
    .outData_48(stage_1_per_out[48]),
    .outData_49(stage_1_per_out[49]),
    .outData_50(stage_1_per_out[50]),
    .outData_51(stage_1_per_out[51]),
    .outData_52(stage_1_per_out[52]),
    .outData_53(stage_1_per_out[53]),
    .outData_54(stage_1_per_out[54]),
    .outData_55(stage_1_per_out[55]),
    .outData_56(stage_1_per_out[56]),
    .outData_57(stage_1_per_out[57]),
    .outData_58(stage_1_per_out[58]),
    .outData_59(stage_1_per_out[59]),
    .outData_60(stage_1_per_out[60]),
    .outData_61(stage_1_per_out[61]),
    .outData_62(stage_1_per_out[62]),
    .outData_63(stage_1_per_out[63]),
    .in_start(in_start[1]),
    .out_start(out_start[1]),
    .clk(clk),
    .rst(rst)
  );


  // TODO(Tian): stage 2 32 butterfly units
  butterfly #(
    .start(START_CYCLE[2]),
    .factors({49823188, 172642311, 128164980, 75324254, 111284191, 143450922, 235204060, 149429971}))
  stage_2_butterfly_0 (
    .x_in(stage_1_per_out[0]),
    .y_in(stage_1_per_out[1]),
    .x_out(stage_2_per_in[0]),
    .y_out(stage_2_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({49823188, 172642311, 128164980, 75324254, 111284191, 143450922, 235204060, 149429971}))
  stage_2_butterfly_1 (
    .x_in(stage_1_per_out[2]),
    .y_in(stage_1_per_out[3]),
    .x_out(stage_2_per_in[2]),
    .y_out(stage_2_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({49823188, 172642311, 128164980, 75324254, 111284191, 143450922, 235204060, 149429971}))
  stage_2_butterfly_2 (
    .x_in(stage_1_per_out[4]),
    .y_in(stage_1_per_out[5]),
    .x_out(stage_2_per_in[4]),
    .y_out(stage_2_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({49823188, 172642311, 128164980, 75324254, 111284191, 143450922, 235204060, 149429971}))
  stage_2_butterfly_3 (
    .x_in(stage_1_per_out[6]),
    .y_in(stage_1_per_out[7]),
    .x_out(stage_2_per_in[6]),
    .y_out(stage_2_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({189517632, 52673254, 170752771, 17079898, 102065274, 185598009, 131798756, 62045777}))
  stage_2_butterfly_4 (
    .x_in(stage_1_per_out[8]),
    .y_in(stage_1_per_out[9]),
    .x_out(stage_2_per_in[8]),
    .y_out(stage_2_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({189517632, 52673254, 170752771, 17079898, 102065274, 185598009, 131798756, 62045777}))
  stage_2_butterfly_5 (
    .x_in(stage_1_per_out[10]),
    .y_in(stage_1_per_out[11]),
    .x_out(stage_2_per_in[10]),
    .y_out(stage_2_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({189517632, 52673254, 170752771, 17079898, 102065274, 185598009, 131798756, 62045777}))
  stage_2_butterfly_6 (
    .x_in(stage_1_per_out[12]),
    .y_in(stage_1_per_out[13]),
    .x_out(stage_2_per_in[12]),
    .y_out(stage_2_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({189517632, 52673254, 170752771, 17079898, 102065274, 185598009, 131798756, 62045777}))
  stage_2_butterfly_7 (
    .x_in(stage_1_per_out[14]),
    .y_in(stage_1_per_out[15]),
    .x_out(stage_2_per_in[14]),
    .y_out(stage_2_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({40758458, 175792128, 200054106, 202257393, 59966873, 228776079, 71471012, 152865265}))
  stage_2_butterfly_8 (
    .x_in(stage_1_per_out[16]),
    .y_in(stage_1_per_out[17]),
    .x_out(stage_2_per_in[16]),
    .y_out(stage_2_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({40758458, 175792128, 200054106, 202257393, 59966873, 228776079, 71471012, 152865265}))
  stage_2_butterfly_9 (
    .x_in(stage_1_per_out[18]),
    .y_in(stage_1_per_out[19]),
    .x_out(stage_2_per_in[18]),
    .y_out(stage_2_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({40758458, 175792128, 200054106, 202257393, 59966873, 228776079, 71471012, 152865265}))
  stage_2_butterfly_10 (
    .x_in(stage_1_per_out[20]),
    .y_in(stage_1_per_out[21]),
    .x_out(stage_2_per_in[20]),
    .y_out(stage_2_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({40758458, 175792128, 200054106, 202257393, 59966873, 228776079, 71471012, 152865265}))
  stage_2_butterfly_11 (
    .x_in(stage_1_per_out[22]),
    .y_in(stage_1_per_out[23]),
    .x_out(stage_2_per_in[22]),
    .y_out(stage_2_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({196909902, 70582130, 191662816, 25574347, 109254766, 29274521, 100099056, 175609590}))
  stage_2_butterfly_12 (
    .x_in(stage_1_per_out[24]),
    .y_in(stage_1_per_out[25]),
    .x_out(stage_2_per_in[24]),
    .y_out(stage_2_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({196909902, 70582130, 191662816, 25574347, 109254766, 29274521, 100099056, 175609590}))
  stage_2_butterfly_13 (
    .x_in(stage_1_per_out[26]),
    .y_in(stage_1_per_out[27]),
    .x_out(stage_2_per_in[26]),
    .y_out(stage_2_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({196909902, 70582130, 191662816, 25574347, 109254766, 29274521, 100099056, 175609590}))
  stage_2_butterfly_14 (
    .x_in(stage_1_per_out[28]),
    .y_in(stage_1_per_out[29]),
    .x_out(stage_2_per_in[28]),
    .y_out(stage_2_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({196909902, 70582130, 191662816, 25574347, 109254766, 29274521, 100099056, 175609590}))
  stage_2_butterfly_15 (
    .x_in(stage_1_per_out[30]),
    .y_in(stage_1_per_out[31]),
    .x_out(stage_2_per_in[30]),
    .y_out(stage_2_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({146694818, 78462606, 88552238, 115957373, 111341228, 70982951, 155896930, 191727270}))
  stage_2_butterfly_16 (
    .x_in(stage_1_per_out[32]),
    .y_in(stage_1_per_out[33]),
    .x_out(stage_2_per_in[32]),
    .y_out(stage_2_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({146694818, 78462606, 88552238, 115957373, 111341228, 70982951, 155896930, 191727270}))
  stage_2_butterfly_17 (
    .x_in(stage_1_per_out[34]),
    .y_in(stage_1_per_out[35]),
    .x_out(stage_2_per_in[34]),
    .y_out(stage_2_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({146694818, 78462606, 88552238, 115957373, 111341228, 70982951, 155896930, 191727270}))
  stage_2_butterfly_18 (
    .x_in(stage_1_per_out[36]),
    .y_in(stage_1_per_out[37]),
    .x_out(stage_2_per_in[36]),
    .y_out(stage_2_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({146694818, 78462606, 88552238, 115957373, 111341228, 70982951, 155896930, 191727270}))
  stage_2_butterfly_19 (
    .x_in(stage_1_per_out[38]),
    .y_in(stage_1_per_out[39]),
    .x_out(stage_2_per_in[38]),
    .y_out(stage_2_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({202366126, 233560477, 158816719, 4690923, 30748955, 119224607, 122985686, 227285679}))
  stage_2_butterfly_20 (
    .x_in(stage_1_per_out[40]),
    .y_in(stage_1_per_out[41]),
    .x_out(stage_2_per_in[40]),
    .y_out(stage_2_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({202366126, 233560477, 158816719, 4690923, 30748955, 119224607, 122985686, 227285679}))
  stage_2_butterfly_21 (
    .x_in(stage_1_per_out[42]),
    .y_in(stage_1_per_out[43]),
    .x_out(stage_2_per_in[42]),
    .y_out(stage_2_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({202366126, 233560477, 158816719, 4690923, 30748955, 119224607, 122985686, 227285679}))
  stage_2_butterfly_22 (
    .x_in(stage_1_per_out[44]),
    .y_in(stage_1_per_out[45]),
    .x_out(stage_2_per_in[44]),
    .y_out(stage_2_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({202366126, 233560477, 158816719, 4690923, 30748955, 119224607, 122985686, 227285679}))
  stage_2_butterfly_23 (
    .x_in(stage_1_per_out[46]),
    .y_in(stage_1_per_out[47]),
    .x_out(stage_2_per_in[46]),
    .y_out(stage_2_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({147699054, 153962078, 262046585, 47317233, 177255039, 169276669, 193689173, 67307067}))
  stage_2_butterfly_24 (
    .x_in(stage_1_per_out[48]),
    .y_in(stage_1_per_out[49]),
    .x_out(stage_2_per_in[48]),
    .y_out(stage_2_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({147699054, 153962078, 262046585, 47317233, 177255039, 169276669, 193689173, 67307067}))
  stage_2_butterfly_25 (
    .x_in(stage_1_per_out[50]),
    .y_in(stage_1_per_out[51]),
    .x_out(stage_2_per_in[50]),
    .y_out(stage_2_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({147699054, 153962078, 262046585, 47317233, 177255039, 169276669, 193689173, 67307067}))
  stage_2_butterfly_26 (
    .x_in(stage_1_per_out[52]),
    .y_in(stage_1_per_out[53]),
    .x_out(stage_2_per_in[52]),
    .y_out(stage_2_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({147699054, 153962078, 262046585, 47317233, 177255039, 169276669, 193689173, 67307067}))
  stage_2_butterfly_27 (
    .x_in(stage_1_per_out[54]),
    .y_in(stage_1_per_out[55]),
    .x_out(stage_2_per_in[54]),
    .y_out(stage_2_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({86517113, 11695616, 103143177, 240684902, 57801361, 126821849, 162373432, 138074788}))
  stage_2_butterfly_28 (
    .x_in(stage_1_per_out[56]),
    .y_in(stage_1_per_out[57]),
    .x_out(stage_2_per_in[56]),
    .y_out(stage_2_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({86517113, 11695616, 103143177, 240684902, 57801361, 126821849, 162373432, 138074788}))
  stage_2_butterfly_29 (
    .x_in(stage_1_per_out[58]),
    .y_in(stage_1_per_out[59]),
    .x_out(stage_2_per_in[58]),
    .y_out(stage_2_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({86517113, 11695616, 103143177, 240684902, 57801361, 126821849, 162373432, 138074788}))
  stage_2_butterfly_30 (
    .x_in(stage_1_per_out[60]),
    .y_in(stage_1_per_out[61]),
    .x_out(stage_2_per_in[60]),
    .y_out(stage_2_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({86517113, 11695616, 103143177, 240684902, 57801361, 126821849, 162373432, 138074788}))
  stage_2_butterfly_31 (
    .x_in(stage_1_per_out[62]),
    .y_in(stage_1_per_out[63]),
    .x_out(stage_2_per_in[62]),
    .y_out(stage_2_per_in[63]),
    .clk(clk),
    .rst(rst)
  );



  // TODO(Yang): stage 2 -> stage 3 permutation
  // FIXME: ignore butterfly units for now.
  stage_2_permutation #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_2_3_per (
    .inData_0(stage_2_per_in[0]),
    .inData_1(stage_2_per_in[1]),
    .inData_2(stage_2_per_in[2]),
    .inData_3(stage_2_per_in[3]),
    .inData_4(stage_2_per_in[4]),
    .inData_5(stage_2_per_in[5]),
    .inData_6(stage_2_per_in[6]),
    .inData_7(stage_2_per_in[7]),
    .inData_8(stage_2_per_in[8]),
    .inData_9(stage_2_per_in[9]),
    .inData_10(stage_2_per_in[10]),
    .inData_11(stage_2_per_in[11]),
    .inData_12(stage_2_per_in[12]),
    .inData_13(stage_2_per_in[13]),
    .inData_14(stage_2_per_in[14]),
    .inData_15(stage_2_per_in[15]),
    .inData_16(stage_2_per_in[16]),
    .inData_17(stage_2_per_in[17]),
    .inData_18(stage_2_per_in[18]),
    .inData_19(stage_2_per_in[19]),
    .inData_20(stage_2_per_in[20]),
    .inData_21(stage_2_per_in[21]),
    .inData_22(stage_2_per_in[22]),
    .inData_23(stage_2_per_in[23]),
    .inData_24(stage_2_per_in[24]),
    .inData_25(stage_2_per_in[25]),
    .inData_26(stage_2_per_in[26]),
    .inData_27(stage_2_per_in[27]),
    .inData_28(stage_2_per_in[28]),
    .inData_29(stage_2_per_in[29]),
    .inData_30(stage_2_per_in[30]),
    .inData_31(stage_2_per_in[31]),
    .inData_32(stage_2_per_in[32]),
    .inData_33(stage_2_per_in[33]),
    .inData_34(stage_2_per_in[34]),
    .inData_35(stage_2_per_in[35]),
    .inData_36(stage_2_per_in[36]),
    .inData_37(stage_2_per_in[37]),
    .inData_38(stage_2_per_in[38]),
    .inData_39(stage_2_per_in[39]),
    .inData_40(stage_2_per_in[40]),
    .inData_41(stage_2_per_in[41]),
    .inData_42(stage_2_per_in[42]),
    .inData_43(stage_2_per_in[43]),
    .inData_44(stage_2_per_in[44]),
    .inData_45(stage_2_per_in[45]),
    .inData_46(stage_2_per_in[46]),
    .inData_47(stage_2_per_in[47]),
    .inData_48(stage_2_per_in[48]),
    .inData_49(stage_2_per_in[49]),
    .inData_50(stage_2_per_in[50]),
    .inData_51(stage_2_per_in[51]),
    .inData_52(stage_2_per_in[52]),
    .inData_53(stage_2_per_in[53]),
    .inData_54(stage_2_per_in[54]),
    .inData_55(stage_2_per_in[55]),
    .inData_56(stage_2_per_in[56]),
    .inData_57(stage_2_per_in[57]),
    .inData_58(stage_2_per_in[58]),
    .inData_59(stage_2_per_in[59]),
    .inData_60(stage_2_per_in[60]),
    .inData_61(stage_2_per_in[61]),
    .inData_62(stage_2_per_in[62]),
    .inData_63(stage_2_per_in[63]),
    .outData_0(stage_2_per_out[0]),
    .outData_1(stage_2_per_out[1]),
    .outData_2(stage_2_per_out[2]),
    .outData_3(stage_2_per_out[3]),
    .outData_4(stage_2_per_out[4]),
    .outData_5(stage_2_per_out[5]),
    .outData_6(stage_2_per_out[6]),
    .outData_7(stage_2_per_out[7]),
    .outData_8(stage_2_per_out[8]),
    .outData_9(stage_2_per_out[9]),
    .outData_10(stage_2_per_out[10]),
    .outData_11(stage_2_per_out[11]),
    .outData_12(stage_2_per_out[12]),
    .outData_13(stage_2_per_out[13]),
    .outData_14(stage_2_per_out[14]),
    .outData_15(stage_2_per_out[15]),
    .outData_16(stage_2_per_out[16]),
    .outData_17(stage_2_per_out[17]),
    .outData_18(stage_2_per_out[18]),
    .outData_19(stage_2_per_out[19]),
    .outData_20(stage_2_per_out[20]),
    .outData_21(stage_2_per_out[21]),
    .outData_22(stage_2_per_out[22]),
    .outData_23(stage_2_per_out[23]),
    .outData_24(stage_2_per_out[24]),
    .outData_25(stage_2_per_out[25]),
    .outData_26(stage_2_per_out[26]),
    .outData_27(stage_2_per_out[27]),
    .outData_28(stage_2_per_out[28]),
    .outData_29(stage_2_per_out[29]),
    .outData_30(stage_2_per_out[30]),
    .outData_31(stage_2_per_out[31]),
    .outData_32(stage_2_per_out[32]),
    .outData_33(stage_2_per_out[33]),
    .outData_34(stage_2_per_out[34]),
    .outData_35(stage_2_per_out[35]),
    .outData_36(stage_2_per_out[36]),
    .outData_37(stage_2_per_out[37]),
    .outData_38(stage_2_per_out[38]),
    .outData_39(stage_2_per_out[39]),
    .outData_40(stage_2_per_out[40]),
    .outData_41(stage_2_per_out[41]),
    .outData_42(stage_2_per_out[42]),
    .outData_43(stage_2_per_out[43]),
    .outData_44(stage_2_per_out[44]),
    .outData_45(stage_2_per_out[45]),
    .outData_46(stage_2_per_out[46]),
    .outData_47(stage_2_per_out[47]),
    .outData_48(stage_2_per_out[48]),
    .outData_49(stage_2_per_out[49]),
    .outData_50(stage_2_per_out[50]),
    .outData_51(stage_2_per_out[51]),
    .outData_52(stage_2_per_out[52]),
    .outData_53(stage_2_per_out[53]),
    .outData_54(stage_2_per_out[54]),
    .outData_55(stage_2_per_out[55]),
    .outData_56(stage_2_per_out[56]),
    .outData_57(stage_2_per_out[57]),
    .outData_58(stage_2_per_out[58]),
    .outData_59(stage_2_per_out[59]),
    .outData_60(stage_2_per_out[60]),
    .outData_61(stage_2_per_out[61]),
    .outData_62(stage_2_per_out[62]),
    .outData_63(stage_2_per_out[63]),
    .in_start(in_start[2]),
    .out_start(out_start[2]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Tian): stage 3 32 butterfly units
  butterfly #(
    .start(START_CYCLE[3]),
    .factors({216372172, 160020761, 229105823, 19095174, 165790423, 265190919, 99790517, 47877183}))
  stage_3_butterfly_0 (
    .x_in(stage_2_per_out[0]),
    .y_in(stage_2_per_out[1]),
    .x_out(stage_3_per_in[0]),
    .y_out(stage_3_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({216372172, 160020761, 229105823, 19095174, 165790423, 265190919, 99790517, 47877183}))
  stage_3_butterfly_1 (
    .x_in(stage_2_per_out[2]),
    .y_in(stage_2_per_out[3]),
    .x_out(stage_3_per_in[2]),
    .y_out(stage_3_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({216372172, 160020761, 229105823, 19095174, 165790423, 265190919, 99790517, 47877183}))
  stage_3_butterfly_2 (
    .x_in(stage_2_per_out[4]),
    .y_in(stage_2_per_out[5]),
    .x_out(stage_3_per_in[4]),
    .y_out(stage_3_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({216372172, 160020761, 229105823, 19095174, 165790423, 265190919, 99790517, 47877183}))
  stage_3_butterfly_3 (
    .x_in(stage_2_per_out[6]),
    .y_in(stage_2_per_out[7]),
    .x_out(stage_3_per_in[6]),
    .y_out(stage_3_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({216372172, 160020761, 229105823, 19095174, 165790423, 265190919, 99790517, 47877183}))
  stage_3_butterfly_4 (
    .x_in(stage_2_per_out[8]),
    .y_in(stage_2_per_out[9]),
    .x_out(stage_3_per_in[8]),
    .y_out(stage_3_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({216372172, 160020761, 229105823, 19095174, 165790423, 265190919, 99790517, 47877183}))
  stage_3_butterfly_5 (
    .x_in(stage_2_per_out[10]),
    .y_in(stage_2_per_out[11]),
    .x_out(stage_3_per_in[10]),
    .y_out(stage_3_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({216372172, 160020761, 229105823, 19095174, 165790423, 265190919, 99790517, 47877183}))
  stage_3_butterfly_6 (
    .x_in(stage_2_per_out[12]),
    .y_in(stage_2_per_out[13]),
    .x_out(stage_3_per_in[12]),
    .y_out(stage_3_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({216372172, 160020761, 229105823, 19095174, 165790423, 265190919, 99790517, 47877183}))
  stage_3_butterfly_7 (
    .x_in(stage_2_per_out[14]),
    .y_in(stage_2_per_out[15]),
    .x_out(stage_3_per_in[14]),
    .y_out(stage_3_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({221840088, 183300662, 234642902, 62061822, 148889498, 165596304, 249836082, 83571649}))
  stage_3_butterfly_8 (
    .x_in(stage_2_per_out[16]),
    .y_in(stage_2_per_out[17]),
    .x_out(stage_3_per_in[16]),
    .y_out(stage_3_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({221840088, 183300662, 234642902, 62061822, 148889498, 165596304, 249836082, 83571649}))
  stage_3_butterfly_9 (
    .x_in(stage_2_per_out[18]),
    .y_in(stage_2_per_out[19]),
    .x_out(stage_3_per_in[18]),
    .y_out(stage_3_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({221840088, 183300662, 234642902, 62061822, 148889498, 165596304, 249836082, 83571649}))
  stage_3_butterfly_10 (
    .x_in(stage_2_per_out[20]),
    .y_in(stage_2_per_out[21]),
    .x_out(stage_3_per_in[20]),
    .y_out(stage_3_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({221840088, 183300662, 234642902, 62061822, 148889498, 165596304, 249836082, 83571649}))
  stage_3_butterfly_11 (
    .x_in(stage_2_per_out[22]),
    .y_in(stage_2_per_out[23]),
    .x_out(stage_3_per_in[22]),
    .y_out(stage_3_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({221840088, 183300662, 234642902, 62061822, 148889498, 165596304, 249836082, 83571649}))
  stage_3_butterfly_12 (
    .x_in(stage_2_per_out[24]),
    .y_in(stage_2_per_out[25]),
    .x_out(stage_3_per_in[24]),
    .y_out(stage_3_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({221840088, 183300662, 234642902, 62061822, 148889498, 165596304, 249836082, 83571649}))
  stage_3_butterfly_13 (
    .x_in(stage_2_per_out[26]),
    .y_in(stage_2_per_out[27]),
    .x_out(stage_3_per_in[26]),
    .y_out(stage_3_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({221840088, 183300662, 234642902, 62061822, 148889498, 165596304, 249836082, 83571649}))
  stage_3_butterfly_14 (
    .x_in(stage_2_per_out[28]),
    .y_in(stage_2_per_out[29]),
    .x_out(stage_3_per_in[28]),
    .y_out(stage_3_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({221840088, 183300662, 234642902, 62061822, 148889498, 165596304, 249836082, 83571649}))
  stage_3_butterfly_15 (
    .x_in(stage_2_per_out[30]),
    .y_in(stage_2_per_out[31]),
    .x_out(stage_3_per_in[30]),
    .y_out(stage_3_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({36955649, 47713731, 11699091, 233080466, 129001811, 84893967, 73825164, 92744225}))
  stage_3_butterfly_16 (
    .x_in(stage_2_per_out[32]),
    .y_in(stage_2_per_out[33]),
    .x_out(stage_3_per_in[32]),
    .y_out(stage_3_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({36955649, 47713731, 11699091, 233080466, 129001811, 84893967, 73825164, 92744225}))
  stage_3_butterfly_17 (
    .x_in(stage_2_per_out[34]),
    .y_in(stage_2_per_out[35]),
    .x_out(stage_3_per_in[34]),
    .y_out(stage_3_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({36955649, 47713731, 11699091, 233080466, 129001811, 84893967, 73825164, 92744225}))
  stage_3_butterfly_18 (
    .x_in(stage_2_per_out[36]),
    .y_in(stage_2_per_out[37]),
    .x_out(stage_3_per_in[36]),
    .y_out(stage_3_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({36955649, 47713731, 11699091, 233080466, 129001811, 84893967, 73825164, 92744225}))
  stage_3_butterfly_19 (
    .x_in(stage_2_per_out[38]),
    .y_in(stage_2_per_out[39]),
    .x_out(stage_3_per_in[38]),
    .y_out(stage_3_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({36955649, 47713731, 11699091, 233080466, 129001811, 84893967, 73825164, 92744225}))
  stage_3_butterfly_20 (
    .x_in(stage_2_per_out[40]),
    .y_in(stage_2_per_out[41]),
    .x_out(stage_3_per_in[40]),
    .y_out(stage_3_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({36955649, 47713731, 11699091, 233080466, 129001811, 84893967, 73825164, 92744225}))
  stage_3_butterfly_21 (
    .x_in(stage_2_per_out[42]),
    .y_in(stage_2_per_out[43]),
    .x_out(stage_3_per_in[42]),
    .y_out(stage_3_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({36955649, 47713731, 11699091, 233080466, 129001811, 84893967, 73825164, 92744225}))
  stage_3_butterfly_22 (
    .x_in(stage_2_per_out[44]),
    .y_in(stage_2_per_out[45]),
    .x_out(stage_3_per_in[44]),
    .y_out(stage_3_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({36955649, 47713731, 11699091, 233080466, 129001811, 84893967, 73825164, 92744225}))
  stage_3_butterfly_23 (
    .x_in(stage_2_per_out[46]),
    .y_in(stage_2_per_out[47]),
    .x_out(stage_3_per_in[46]),
    .y_out(stage_3_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({94135184, 178374402, 143639106, 191796824, 196308904, 210831626, 72052889, 5258704}))
  stage_3_butterfly_24 (
    .x_in(stage_2_per_out[48]),
    .y_in(stage_2_per_out[49]),
    .x_out(stage_3_per_in[48]),
    .y_out(stage_3_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({94135184, 178374402, 143639106, 191796824, 196308904, 210831626, 72052889, 5258704}))
  stage_3_butterfly_25 (
    .x_in(stage_2_per_out[50]),
    .y_in(stage_2_per_out[51]),
    .x_out(stage_3_per_in[50]),
    .y_out(stage_3_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({94135184, 178374402, 143639106, 191796824, 196308904, 210831626, 72052889, 5258704}))
  stage_3_butterfly_26 (
    .x_in(stage_2_per_out[52]),
    .y_in(stage_2_per_out[53]),
    .x_out(stage_3_per_in[52]),
    .y_out(stage_3_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({94135184, 178374402, 143639106, 191796824, 196308904, 210831626, 72052889, 5258704}))
  stage_3_butterfly_27 (
    .x_in(stage_2_per_out[54]),
    .y_in(stage_2_per_out[55]),
    .x_out(stage_3_per_in[54]),
    .y_out(stage_3_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({94135184, 178374402, 143639106, 191796824, 196308904, 210831626, 72052889, 5258704}))
  stage_3_butterfly_28 (
    .x_in(stage_2_per_out[56]),
    .y_in(stage_2_per_out[57]),
    .x_out(stage_3_per_in[56]),
    .y_out(stage_3_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({94135184, 178374402, 143639106, 191796824, 196308904, 210831626, 72052889, 5258704}))
  stage_3_butterfly_29 (
    .x_in(stage_2_per_out[58]),
    .y_in(stage_2_per_out[59]),
    .x_out(stage_3_per_in[58]),
    .y_out(stage_3_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({94135184, 178374402, 143639106, 191796824, 196308904, 210831626, 72052889, 5258704}))
  stage_3_butterfly_30 (
    .x_in(stage_2_per_out[60]),
    .y_in(stage_2_per_out[61]),
    .x_out(stage_3_per_in[60]),
    .y_out(stage_3_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({94135184, 178374402, 143639106, 191796824, 196308904, 210831626, 72052889, 5258704}))
  stage_3_butterfly_31 (
    .x_in(stage_2_per_out[62]),
    .y_in(stage_2_per_out[63]),
    .x_out(stage_3_per_in[62]),
    .y_out(stage_3_per_in[63]),
    .clk(clk),
    .rst(rst)
  );




  // TODO(Yang): stage 3 -> stage 4 permutation
  // FIXME: ignore butterfly units for now.
  stage_3_permutation #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_3_4_per (
    .inData_0(stage_3_per_in[0]),
    .inData_1(stage_3_per_in[1]),
    .inData_2(stage_3_per_in[2]),
    .inData_3(stage_3_per_in[3]),
    .inData_4(stage_3_per_in[4]),
    .inData_5(stage_3_per_in[5]),
    .inData_6(stage_3_per_in[6]),
    .inData_7(stage_3_per_in[7]),
    .inData_8(stage_3_per_in[8]),
    .inData_9(stage_3_per_in[9]),
    .inData_10(stage_3_per_in[10]),
    .inData_11(stage_3_per_in[11]),
    .inData_12(stage_3_per_in[12]),
    .inData_13(stage_3_per_in[13]),
    .inData_14(stage_3_per_in[14]),
    .inData_15(stage_3_per_in[15]),
    .inData_16(stage_3_per_in[16]),
    .inData_17(stage_3_per_in[17]),
    .inData_18(stage_3_per_in[18]),
    .inData_19(stage_3_per_in[19]),
    .inData_20(stage_3_per_in[20]),
    .inData_21(stage_3_per_in[21]),
    .inData_22(stage_3_per_in[22]),
    .inData_23(stage_3_per_in[23]),
    .inData_24(stage_3_per_in[24]),
    .inData_25(stage_3_per_in[25]),
    .inData_26(stage_3_per_in[26]),
    .inData_27(stage_3_per_in[27]),
    .inData_28(stage_3_per_in[28]),
    .inData_29(stage_3_per_in[29]),
    .inData_30(stage_3_per_in[30]),
    .inData_31(stage_3_per_in[31]),
    .inData_32(stage_3_per_in[32]),
    .inData_33(stage_3_per_in[33]),
    .inData_34(stage_3_per_in[34]),
    .inData_35(stage_3_per_in[35]),
    .inData_36(stage_3_per_in[36]),
    .inData_37(stage_3_per_in[37]),
    .inData_38(stage_3_per_in[38]),
    .inData_39(stage_3_per_in[39]),
    .inData_40(stage_3_per_in[40]),
    .inData_41(stage_3_per_in[41]),
    .inData_42(stage_3_per_in[42]),
    .inData_43(stage_3_per_in[43]),
    .inData_44(stage_3_per_in[44]),
    .inData_45(stage_3_per_in[45]),
    .inData_46(stage_3_per_in[46]),
    .inData_47(stage_3_per_in[47]),
    .inData_48(stage_3_per_in[48]),
    .inData_49(stage_3_per_in[49]),
    .inData_50(stage_3_per_in[50]),
    .inData_51(stage_3_per_in[51]),
    .inData_52(stage_3_per_in[52]),
    .inData_53(stage_3_per_in[53]),
    .inData_54(stage_3_per_in[54]),
    .inData_55(stage_3_per_in[55]),
    .inData_56(stage_3_per_in[56]),
    .inData_57(stage_3_per_in[57]),
    .inData_58(stage_3_per_in[58]),
    .inData_59(stage_3_per_in[59]),
    .inData_60(stage_3_per_in[60]),
    .inData_61(stage_3_per_in[61]),
    .inData_62(stage_3_per_in[62]),
    .inData_63(stage_3_per_in[63]),
    .outData_0(stage_3_per_out[0]),
    .outData_1(stage_3_per_out[1]),
    .outData_2(stage_3_per_out[2]),
    .outData_3(stage_3_per_out[3]),
    .outData_4(stage_3_per_out[4]),
    .outData_5(stage_3_per_out[5]),
    .outData_6(stage_3_per_out[6]),
    .outData_7(stage_3_per_out[7]),
    .outData_8(stage_3_per_out[8]),
    .outData_9(stage_3_per_out[9]),
    .outData_10(stage_3_per_out[10]),
    .outData_11(stage_3_per_out[11]),
    .outData_12(stage_3_per_out[12]),
    .outData_13(stage_3_per_out[13]),
    .outData_14(stage_3_per_out[14]),
    .outData_15(stage_3_per_out[15]),
    .outData_16(stage_3_per_out[16]),
    .outData_17(stage_3_per_out[17]),
    .outData_18(stage_3_per_out[18]),
    .outData_19(stage_3_per_out[19]),
    .outData_20(stage_3_per_out[20]),
    .outData_21(stage_3_per_out[21]),
    .outData_22(stage_3_per_out[22]),
    .outData_23(stage_3_per_out[23]),
    .outData_24(stage_3_per_out[24]),
    .outData_25(stage_3_per_out[25]),
    .outData_26(stage_3_per_out[26]),
    .outData_27(stage_3_per_out[27]),
    .outData_28(stage_3_per_out[28]),
    .outData_29(stage_3_per_out[29]),
    .outData_30(stage_3_per_out[30]),
    .outData_31(stage_3_per_out[31]),
    .outData_32(stage_3_per_out[32]),
    .outData_33(stage_3_per_out[33]),
    .outData_34(stage_3_per_out[34]),
    .outData_35(stage_3_per_out[35]),
    .outData_36(stage_3_per_out[36]),
    .outData_37(stage_3_per_out[37]),
    .outData_38(stage_3_per_out[38]),
    .outData_39(stage_3_per_out[39]),
    .outData_40(stage_3_per_out[40]),
    .outData_41(stage_3_per_out[41]),
    .outData_42(stage_3_per_out[42]),
    .outData_43(stage_3_per_out[43]),
    .outData_44(stage_3_per_out[44]),
    .outData_45(stage_3_per_out[45]),
    .outData_46(stage_3_per_out[46]),
    .outData_47(stage_3_per_out[47]),
    .outData_48(stage_3_per_out[48]),
    .outData_49(stage_3_per_out[49]),
    .outData_50(stage_3_per_out[50]),
    .outData_51(stage_3_per_out[51]),
    .outData_52(stage_3_per_out[52]),
    .outData_53(stage_3_per_out[53]),
    .outData_54(stage_3_per_out[54]),
    .outData_55(stage_3_per_out[55]),
    .outData_56(stage_3_per_out[56]),
    .outData_57(stage_3_per_out[57]),
    .outData_58(stage_3_per_out[58]),
    .outData_59(stage_3_per_out[59]),
    .outData_60(stage_3_per_out[60]),
    .outData_61(stage_3_per_out[61]),
    .outData_62(stage_3_per_out[62]),
    .outData_63(stage_3_per_out[63]),
    .in_start(in_start[3]),
    .out_start(out_start[3]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 4 32 butterfly units
  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_0 (
    .x_in(stage_3_per_out[0]),
    .y_in(stage_3_per_out[1]),
    .x_out(stage_4_per_in[0]),
    .y_out(stage_4_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_1 (
    .x_in(stage_3_per_out[2]),
    .y_in(stage_3_per_out[3]),
    .x_out(stage_4_per_in[2]),
    .y_out(stage_4_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_2 (
    .x_in(stage_3_per_out[4]),
    .y_in(stage_3_per_out[5]),
    .x_out(stage_4_per_in[4]),
    .y_out(stage_4_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_3 (
    .x_in(stage_3_per_out[6]),
    .y_in(stage_3_per_out[7]),
    .x_out(stage_4_per_in[6]),
    .y_out(stage_4_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_4 (
    .x_in(stage_3_per_out[8]),
    .y_in(stage_3_per_out[9]),
    .x_out(stage_4_per_in[8]),
    .y_out(stage_4_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_5 (
    .x_in(stage_3_per_out[10]),
    .y_in(stage_3_per_out[11]),
    .x_out(stage_4_per_in[10]),
    .y_out(stage_4_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_6 (
    .x_in(stage_3_per_out[12]),
    .y_in(stage_3_per_out[13]),
    .x_out(stage_4_per_in[12]),
    .y_out(stage_4_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_7 (
    .x_in(stage_3_per_out[14]),
    .y_in(stage_3_per_out[15]),
    .x_out(stage_4_per_in[14]),
    .y_out(stage_4_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_8 (
    .x_in(stage_3_per_out[16]),
    .y_in(stage_3_per_out[17]),
    .x_out(stage_4_per_in[16]),
    .y_out(stage_4_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_9 (
    .x_in(stage_3_per_out[18]),
    .y_in(stage_3_per_out[19]),
    .x_out(stage_4_per_in[18]),
    .y_out(stage_4_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_10 (
    .x_in(stage_3_per_out[20]),
    .y_in(stage_3_per_out[21]),
    .x_out(stage_4_per_in[20]),
    .y_out(stage_4_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_11 (
    .x_in(stage_3_per_out[22]),
    .y_in(stage_3_per_out[23]),
    .x_out(stage_4_per_in[22]),
    .y_out(stage_4_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_12 (
    .x_in(stage_3_per_out[24]),
    .y_in(stage_3_per_out[25]),
    .x_out(stage_4_per_in[24]),
    .y_out(stage_4_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_13 (
    .x_in(stage_3_per_out[26]),
    .y_in(stage_3_per_out[27]),
    .x_out(stage_4_per_in[26]),
    .y_out(stage_4_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_14 (
    .x_in(stage_3_per_out[28]),
    .y_in(stage_3_per_out[29]),
    .x_out(stage_4_per_in[28]),
    .y_out(stage_4_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 194721725, 131414476, 46265048, 142393906, 47600907, 112745081, 134587162}))
  stage_4_butterfly_15 (
    .x_in(stage_3_per_out[30]),
    .y_in(stage_3_per_out[31]),
    .x_out(stage_4_per_in[30]),
    .y_out(stage_4_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_16 (
    .x_in(stage_3_per_out[32]),
    .y_in(stage_3_per_out[33]),
    .x_out(stage_4_per_in[32]),
    .y_out(stage_4_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_17 (
    .x_in(stage_3_per_out[34]),
    .y_in(stage_3_per_out[35]),
    .x_out(stage_4_per_in[34]),
    .y_out(stage_4_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_18 (
    .x_in(stage_3_per_out[36]),
    .y_in(stage_3_per_out[37]),
    .x_out(stage_4_per_in[36]),
    .y_out(stage_4_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_19 (
    .x_in(stage_3_per_out[38]),
    .y_in(stage_3_per_out[39]),
    .x_out(stage_4_per_in[38]),
    .y_out(stage_4_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_20 (
    .x_in(stage_3_per_out[40]),
    .y_in(stage_3_per_out[41]),
    .x_out(stage_4_per_in[40]),
    .y_out(stage_4_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_21 (
    .x_in(stage_3_per_out[42]),
    .y_in(stage_3_per_out[43]),
    .x_out(stage_4_per_in[42]),
    .y_out(stage_4_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_22 (
    .x_in(stage_3_per_out[44]),
    .y_in(stage_3_per_out[45]),
    .x_out(stage_4_per_in[44]),
    .y_out(stage_4_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_23 (
    .x_in(stage_3_per_out[46]),
    .y_in(stage_3_per_out[47]),
    .x_out(stage_4_per_in[46]),
    .y_out(stage_4_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_24 (
    .x_in(stage_3_per_out[48]),
    .y_in(stage_3_per_out[49]),
    .x_out(stage_4_per_in[48]),
    .y_out(stage_4_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_25 (
    .x_in(stage_3_per_out[50]),
    .y_in(stage_3_per_out[51]),
    .x_out(stage_4_per_in[50]),
    .y_out(stage_4_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_26 (
    .x_in(stage_3_per_out[52]),
    .y_in(stage_3_per_out[53]),
    .x_out(stage_4_per_in[52]),
    .y_out(stage_4_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_27 (
    .x_in(stage_3_per_out[54]),
    .y_in(stage_3_per_out[55]),
    .x_out(stage_4_per_in[54]),
    .y_out(stage_4_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_28 (
    .x_in(stage_3_per_out[56]),
    .y_in(stage_3_per_out[57]),
    .x_out(stage_4_per_in[56]),
    .y_out(stage_4_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_29 (
    .x_in(stage_3_per_out[58]),
    .y_in(stage_3_per_out[59]),
    .x_out(stage_4_per_in[58]),
    .y_out(stage_4_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_30 (
    .x_in(stage_3_per_out[60]),
    .y_in(stage_3_per_out[61]),
    .x_out(stage_4_per_in[60]),
    .y_out(stage_4_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({225387856, 105312654, 70516281, 242569099, 69075086, 234985940, 260567810, 210749829}))
  stage_4_butterfly_31 (
    .x_in(stage_3_per_out[62]),
    .y_in(stage_3_per_out[63]),
    .x_out(stage_4_per_in[62]),
    .y_out(stage_4_per_in[63]),
    .clk(clk),
    .rst(rst)
  );




  // TODO(Yang): stage 4 -> stage 5 permutation
  // FIXME: ignore butterfly units for now.
  stage_4_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_4_5_per (
    .inData_0(stage_4_per_in[0]),
    .inData_1(stage_4_per_in[1]),
    .inData_2(stage_4_per_in[2]),
    .inData_3(stage_4_per_in[3]),
    .inData_4(stage_4_per_in[4]),
    .inData_5(stage_4_per_in[5]),
    .inData_6(stage_4_per_in[6]),
    .inData_7(stage_4_per_in[7]),
    .inData_8(stage_4_per_in[8]),
    .inData_9(stage_4_per_in[9]),
    .inData_10(stage_4_per_in[10]),
    .inData_11(stage_4_per_in[11]),
    .inData_12(stage_4_per_in[12]),
    .inData_13(stage_4_per_in[13]),
    .inData_14(stage_4_per_in[14]),
    .inData_15(stage_4_per_in[15]),
    .inData_16(stage_4_per_in[16]),
    .inData_17(stage_4_per_in[17]),
    .inData_18(stage_4_per_in[18]),
    .inData_19(stage_4_per_in[19]),
    .inData_20(stage_4_per_in[20]),
    .inData_21(stage_4_per_in[21]),
    .inData_22(stage_4_per_in[22]),
    .inData_23(stage_4_per_in[23]),
    .inData_24(stage_4_per_in[24]),
    .inData_25(stage_4_per_in[25]),
    .inData_26(stage_4_per_in[26]),
    .inData_27(stage_4_per_in[27]),
    .inData_28(stage_4_per_in[28]),
    .inData_29(stage_4_per_in[29]),
    .inData_30(stage_4_per_in[30]),
    .inData_31(stage_4_per_in[31]),
    .inData_32(stage_4_per_in[32]),
    .inData_33(stage_4_per_in[33]),
    .inData_34(stage_4_per_in[34]),
    .inData_35(stage_4_per_in[35]),
    .inData_36(stage_4_per_in[36]),
    .inData_37(stage_4_per_in[37]),
    .inData_38(stage_4_per_in[38]),
    .inData_39(stage_4_per_in[39]),
    .inData_40(stage_4_per_in[40]),
    .inData_41(stage_4_per_in[41]),
    .inData_42(stage_4_per_in[42]),
    .inData_43(stage_4_per_in[43]),
    .inData_44(stage_4_per_in[44]),
    .inData_45(stage_4_per_in[45]),
    .inData_46(stage_4_per_in[46]),
    .inData_47(stage_4_per_in[47]),
    .inData_48(stage_4_per_in[48]),
    .inData_49(stage_4_per_in[49]),
    .inData_50(stage_4_per_in[50]),
    .inData_51(stage_4_per_in[51]),
    .inData_52(stage_4_per_in[52]),
    .inData_53(stage_4_per_in[53]),
    .inData_54(stage_4_per_in[54]),
    .inData_55(stage_4_per_in[55]),
    .inData_56(stage_4_per_in[56]),
    .inData_57(stage_4_per_in[57]),
    .inData_58(stage_4_per_in[58]),
    .inData_59(stage_4_per_in[59]),
    .inData_60(stage_4_per_in[60]),
    .inData_61(stage_4_per_in[61]),
    .inData_62(stage_4_per_in[62]),
    .inData_63(stage_4_per_in[63]),
    .outData_0(stage_4_per_out[0]),
    .outData_1(stage_4_per_out[1]),
    .outData_2(stage_4_per_out[2]),
    .outData_3(stage_4_per_out[3]),
    .outData_4(stage_4_per_out[4]),
    .outData_5(stage_4_per_out[5]),
    .outData_6(stage_4_per_out[6]),
    .outData_7(stage_4_per_out[7]),
    .outData_8(stage_4_per_out[8]),
    .outData_9(stage_4_per_out[9]),
    .outData_10(stage_4_per_out[10]),
    .outData_11(stage_4_per_out[11]),
    .outData_12(stage_4_per_out[12]),
    .outData_13(stage_4_per_out[13]),
    .outData_14(stage_4_per_out[14]),
    .outData_15(stage_4_per_out[15]),
    .outData_16(stage_4_per_out[16]),
    .outData_17(stage_4_per_out[17]),
    .outData_18(stage_4_per_out[18]),
    .outData_19(stage_4_per_out[19]),
    .outData_20(stage_4_per_out[20]),
    .outData_21(stage_4_per_out[21]),
    .outData_22(stage_4_per_out[22]),
    .outData_23(stage_4_per_out[23]),
    .outData_24(stage_4_per_out[24]),
    .outData_25(stage_4_per_out[25]),
    .outData_26(stage_4_per_out[26]),
    .outData_27(stage_4_per_out[27]),
    .outData_28(stage_4_per_out[28]),
    .outData_29(stage_4_per_out[29]),
    .outData_30(stage_4_per_out[30]),
    .outData_31(stage_4_per_out[31]),
    .outData_32(stage_4_per_out[32]),
    .outData_33(stage_4_per_out[33]),
    .outData_34(stage_4_per_out[34]),
    .outData_35(stage_4_per_out[35]),
    .outData_36(stage_4_per_out[36]),
    .outData_37(stage_4_per_out[37]),
    .outData_38(stage_4_per_out[38]),
    .outData_39(stage_4_per_out[39]),
    .outData_40(stage_4_per_out[40]),
    .outData_41(stage_4_per_out[41]),
    .outData_42(stage_4_per_out[42]),
    .outData_43(stage_4_per_out[43]),
    .outData_44(stage_4_per_out[44]),
    .outData_45(stage_4_per_out[45]),
    .outData_46(stage_4_per_out[46]),
    .outData_47(stage_4_per_out[47]),
    .outData_48(stage_4_per_out[48]),
    .outData_49(stage_4_per_out[49]),
    .outData_50(stage_4_per_out[50]),
    .outData_51(stage_4_per_out[51]),
    .outData_52(stage_4_per_out[52]),
    .outData_53(stage_4_per_out[53]),
    .outData_54(stage_4_per_out[54]),
    .outData_55(stage_4_per_out[55]),
    .outData_56(stage_4_per_out[56]),
    .outData_57(stage_4_per_out[57]),
    .outData_58(stage_4_per_out[58]),
    .outData_59(stage_4_per_out[59]),
    .outData_60(stage_4_per_out[60]),
    .outData_61(stage_4_per_out[61]),
    .outData_62(stage_4_per_out[62]),
    .outData_63(stage_4_per_out[63]),
    .in_start(in_start[4]),
    .out_start(out_start[4]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 5 32 butterfly units
  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_0 (
    .x_in(stage_4_per_out[0]),
    .y_in(stage_4_per_out[1]),
    .x_out(stage_5_per_in[0]),
    .y_out(stage_5_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_1 (
    .x_in(stage_4_per_out[2]),
    .y_in(stage_4_per_out[3]),
    .x_out(stage_5_per_in[2]),
    .y_out(stage_5_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_2 (
    .x_in(stage_4_per_out[4]),
    .y_in(stage_4_per_out[5]),
    .x_out(stage_5_per_in[4]),
    .y_out(stage_5_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_3 (
    .x_in(stage_4_per_out[6]),
    .y_in(stage_4_per_out[7]),
    .x_out(stage_5_per_in[6]),
    .y_out(stage_5_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_4 (
    .x_in(stage_4_per_out[8]),
    .y_in(stage_4_per_out[9]),
    .x_out(stage_5_per_in[8]),
    .y_out(stage_5_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_5 (
    .x_in(stage_4_per_out[10]),
    .y_in(stage_4_per_out[11]),
    .x_out(stage_5_per_in[10]),
    .y_out(stage_5_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_6 (
    .x_in(stage_4_per_out[12]),
    .y_in(stage_4_per_out[13]),
    .x_out(stage_5_per_in[12]),
    .y_out(stage_5_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_7 (
    .x_in(stage_4_per_out[14]),
    .y_in(stage_4_per_out[15]),
    .x_out(stage_5_per_in[14]),
    .y_out(stage_5_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_8 (
    .x_in(stage_4_per_out[16]),
    .y_in(stage_4_per_out[17]),
    .x_out(stage_5_per_in[16]),
    .y_out(stage_5_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_9 (
    .x_in(stage_4_per_out[18]),
    .y_in(stage_4_per_out[19]),
    .x_out(stage_5_per_in[18]),
    .y_out(stage_5_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_10 (
    .x_in(stage_4_per_out[20]),
    .y_in(stage_4_per_out[21]),
    .x_out(stage_5_per_in[20]),
    .y_out(stage_5_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_11 (
    .x_in(stage_4_per_out[22]),
    .y_in(stage_4_per_out[23]),
    .x_out(stage_5_per_in[22]),
    .y_out(stage_5_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_12 (
    .x_in(stage_4_per_out[24]),
    .y_in(stage_4_per_out[25]),
    .x_out(stage_5_per_in[24]),
    .y_out(stage_5_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_13 (
    .x_in(stage_4_per_out[26]),
    .y_in(stage_4_per_out[27]),
    .x_out(stage_5_per_in[26]),
    .y_out(stage_5_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_14 (
    .x_in(stage_4_per_out[28]),
    .y_in(stage_4_per_out[29]),
    .x_out(stage_5_per_in[28]),
    .y_out(stage_5_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_15 (
    .x_in(stage_4_per_out[30]),
    .y_in(stage_4_per_out[31]),
    .x_out(stage_5_per_in[30]),
    .y_out(stage_5_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_16 (
    .x_in(stage_4_per_out[32]),
    .y_in(stage_4_per_out[33]),
    .x_out(stage_5_per_in[32]),
    .y_out(stage_5_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_17 (
    .x_in(stage_4_per_out[34]),
    .y_in(stage_4_per_out[35]),
    .x_out(stage_5_per_in[34]),
    .y_out(stage_5_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_18 (
    .x_in(stage_4_per_out[36]),
    .y_in(stage_4_per_out[37]),
    .x_out(stage_5_per_in[36]),
    .y_out(stage_5_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_19 (
    .x_in(stage_4_per_out[38]),
    .y_in(stage_4_per_out[39]),
    .x_out(stage_5_per_in[38]),
    .y_out(stage_5_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_20 (
    .x_in(stage_4_per_out[40]),
    .y_in(stage_4_per_out[41]),
    .x_out(stage_5_per_in[40]),
    .y_out(stage_5_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_21 (
    .x_in(stage_4_per_out[42]),
    .y_in(stage_4_per_out[43]),
    .x_out(stage_5_per_in[42]),
    .y_out(stage_5_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_22 (
    .x_in(stage_4_per_out[44]),
    .y_in(stage_4_per_out[45]),
    .x_out(stage_5_per_in[44]),
    .y_out(stage_5_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_23 (
    .x_in(stage_4_per_out[46]),
    .y_in(stage_4_per_out[47]),
    .x_out(stage_5_per_in[46]),
    .y_out(stage_5_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_24 (
    .x_in(stage_4_per_out[48]),
    .y_in(stage_4_per_out[49]),
    .x_out(stage_5_per_in[48]),
    .y_out(stage_5_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_25 (
    .x_in(stage_4_per_out[50]),
    .y_in(stage_4_per_out[51]),
    .x_out(stage_5_per_in[50]),
    .y_out(stage_5_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_26 (
    .x_in(stage_4_per_out[52]),
    .y_in(stage_4_per_out[53]),
    .x_out(stage_5_per_in[52]),
    .y_out(stage_5_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_27 (
    .x_in(stage_4_per_out[54]),
    .y_in(stage_4_per_out[55]),
    .x_out(stage_5_per_in[54]),
    .y_out(stage_5_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_28 (
    .x_in(stage_4_per_out[56]),
    .y_in(stage_4_per_out[57]),
    .x_out(stage_5_per_in[56]),
    .y_out(stage_5_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_29 (
    .x_in(stage_4_per_out[58]),
    .y_in(stage_4_per_out[59]),
    .x_out(stage_5_per_in[58]),
    .y_out(stage_5_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_30 (
    .x_in(stage_4_per_out[60]),
    .y_in(stage_4_per_out[61]),
    .x_out(stage_5_per_in[60]),
    .y_out(stage_5_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 96332896, 137531660, 48587502, 105446074, 177699333, 71274504, 140261680}))
  stage_5_butterfly_31 (
    .x_in(stage_4_per_out[62]),
    .y_in(stage_4_per_out[63]),
    .x_out(stage_5_per_in[62]),
    .y_out(stage_5_per_in[63]),
    .clk(clk),
    .rst(rst)
  );



  // TODO(Yang): stage 5 -> stage 6 permutation
  // FIXME: ignore butterfly units for now.
  stage_5_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_5_6_per (
    .inData_0(stage_5_per_in[0]),
    .inData_1(stage_5_per_in[1]),
    .inData_2(stage_5_per_in[2]),
    .inData_3(stage_5_per_in[3]),
    .inData_4(stage_5_per_in[4]),
    .inData_5(stage_5_per_in[5]),
    .inData_6(stage_5_per_in[6]),
    .inData_7(stage_5_per_in[7]),
    .inData_8(stage_5_per_in[8]),
    .inData_9(stage_5_per_in[9]),
    .inData_10(stage_5_per_in[10]),
    .inData_11(stage_5_per_in[11]),
    .inData_12(stage_5_per_in[12]),
    .inData_13(stage_5_per_in[13]),
    .inData_14(stage_5_per_in[14]),
    .inData_15(stage_5_per_in[15]),
    .inData_16(stage_5_per_in[16]),
    .inData_17(stage_5_per_in[17]),
    .inData_18(stage_5_per_in[18]),
    .inData_19(stage_5_per_in[19]),
    .inData_20(stage_5_per_in[20]),
    .inData_21(stage_5_per_in[21]),
    .inData_22(stage_5_per_in[22]),
    .inData_23(stage_5_per_in[23]),
    .inData_24(stage_5_per_in[24]),
    .inData_25(stage_5_per_in[25]),
    .inData_26(stage_5_per_in[26]),
    .inData_27(stage_5_per_in[27]),
    .inData_28(stage_5_per_in[28]),
    .inData_29(stage_5_per_in[29]),
    .inData_30(stage_5_per_in[30]),
    .inData_31(stage_5_per_in[31]),
    .inData_32(stage_5_per_in[32]),
    .inData_33(stage_5_per_in[33]),
    .inData_34(stage_5_per_in[34]),
    .inData_35(stage_5_per_in[35]),
    .inData_36(stage_5_per_in[36]),
    .inData_37(stage_5_per_in[37]),
    .inData_38(stage_5_per_in[38]),
    .inData_39(stage_5_per_in[39]),
    .inData_40(stage_5_per_in[40]),
    .inData_41(stage_5_per_in[41]),
    .inData_42(stage_5_per_in[42]),
    .inData_43(stage_5_per_in[43]),
    .inData_44(stage_5_per_in[44]),
    .inData_45(stage_5_per_in[45]),
    .inData_46(stage_5_per_in[46]),
    .inData_47(stage_5_per_in[47]),
    .inData_48(stage_5_per_in[48]),
    .inData_49(stage_5_per_in[49]),
    .inData_50(stage_5_per_in[50]),
    .inData_51(stage_5_per_in[51]),
    .inData_52(stage_5_per_in[52]),
    .inData_53(stage_5_per_in[53]),
    .inData_54(stage_5_per_in[54]),
    .inData_55(stage_5_per_in[55]),
    .inData_56(stage_5_per_in[56]),
    .inData_57(stage_5_per_in[57]),
    .inData_58(stage_5_per_in[58]),
    .inData_59(stage_5_per_in[59]),
    .inData_60(stage_5_per_in[60]),
    .inData_61(stage_5_per_in[61]),
    .inData_62(stage_5_per_in[62]),
    .inData_63(stage_5_per_in[63]),
    .outData_0(stage_5_per_out[0]),
    .outData_1(stage_5_per_out[1]),
    .outData_2(stage_5_per_out[2]),
    .outData_3(stage_5_per_out[3]),
    .outData_4(stage_5_per_out[4]),
    .outData_5(stage_5_per_out[5]),
    .outData_6(stage_5_per_out[6]),
    .outData_7(stage_5_per_out[7]),
    .outData_8(stage_5_per_out[8]),
    .outData_9(stage_5_per_out[9]),
    .outData_10(stage_5_per_out[10]),
    .outData_11(stage_5_per_out[11]),
    .outData_12(stage_5_per_out[12]),
    .outData_13(stage_5_per_out[13]),
    .outData_14(stage_5_per_out[14]),
    .outData_15(stage_5_per_out[15]),
    .outData_16(stage_5_per_out[16]),
    .outData_17(stage_5_per_out[17]),
    .outData_18(stage_5_per_out[18]),
    .outData_19(stage_5_per_out[19]),
    .outData_20(stage_5_per_out[20]),
    .outData_21(stage_5_per_out[21]),
    .outData_22(stage_5_per_out[22]),
    .outData_23(stage_5_per_out[23]),
    .outData_24(stage_5_per_out[24]),
    .outData_25(stage_5_per_out[25]),
    .outData_26(stage_5_per_out[26]),
    .outData_27(stage_5_per_out[27]),
    .outData_28(stage_5_per_out[28]),
    .outData_29(stage_5_per_out[29]),
    .outData_30(stage_5_per_out[30]),
    .outData_31(stage_5_per_out[31]),
    .outData_32(stage_5_per_out[32]),
    .outData_33(stage_5_per_out[33]),
    .outData_34(stage_5_per_out[34]),
    .outData_35(stage_5_per_out[35]),
    .outData_36(stage_5_per_out[36]),
    .outData_37(stage_5_per_out[37]),
    .outData_38(stage_5_per_out[38]),
    .outData_39(stage_5_per_out[39]),
    .outData_40(stage_5_per_out[40]),
    .outData_41(stage_5_per_out[41]),
    .outData_42(stage_5_per_out[42]),
    .outData_43(stage_5_per_out[43]),
    .outData_44(stage_5_per_out[44]),
    .outData_45(stage_5_per_out[45]),
    .outData_46(stage_5_per_out[46]),
    .outData_47(stage_5_per_out[47]),
    .outData_48(stage_5_per_out[48]),
    .outData_49(stage_5_per_out[49]),
    .outData_50(stage_5_per_out[50]),
    .outData_51(stage_5_per_out[51]),
    .outData_52(stage_5_per_out[52]),
    .outData_53(stage_5_per_out[53]),
    .outData_54(stage_5_per_out[54]),
    .outData_55(stage_5_per_out[55]),
    .outData_56(stage_5_per_out[56]),
    .outData_57(stage_5_per_out[57]),
    .outData_58(stage_5_per_out[58]),
    .outData_59(stage_5_per_out[59]),
    .outData_60(stage_5_per_out[60]),
    .outData_61(stage_5_per_out[61]),
    .outData_62(stage_5_per_out[62]),
    .outData_63(stage_5_per_out[63]),
    .in_start(in_start[5]),
    .out_start(out_start[5]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 6 32 butterfly units
  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_0 (
    .x_in(stage_5_per_out[0]),
    .y_in(stage_5_per_out[1]),
    .x_out(stage_6_per_in[0]),
    .y_out(stage_6_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_1 (
    .x_in(stage_5_per_out[2]),
    .y_in(stage_5_per_out[3]),
    .x_out(stage_6_per_in[2]),
    .y_out(stage_6_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_2 (
    .x_in(stage_5_per_out[4]),
    .y_in(stage_5_per_out[5]),
    .x_out(stage_6_per_in[4]),
    .y_out(stage_6_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_3 (
    .x_in(stage_5_per_out[6]),
    .y_in(stage_5_per_out[7]),
    .x_out(stage_6_per_in[6]),
    .y_out(stage_6_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_4 (
    .x_in(stage_5_per_out[8]),
    .y_in(stage_5_per_out[9]),
    .x_out(stage_6_per_in[8]),
    .y_out(stage_6_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_5 (
    .x_in(stage_5_per_out[10]),
    .y_in(stage_5_per_out[11]),
    .x_out(stage_6_per_in[10]),
    .y_out(stage_6_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_6 (
    .x_in(stage_5_per_out[12]),
    .y_in(stage_5_per_out[13]),
    .x_out(stage_6_per_in[12]),
    .y_out(stage_6_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_7 (
    .x_in(stage_5_per_out[14]),
    .y_in(stage_5_per_out[15]),
    .x_out(stage_6_per_in[14]),
    .y_out(stage_6_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_8 (
    .x_in(stage_5_per_out[16]),
    .y_in(stage_5_per_out[17]),
    .x_out(stage_6_per_in[16]),
    .y_out(stage_6_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_9 (
    .x_in(stage_5_per_out[18]),
    .y_in(stage_5_per_out[19]),
    .x_out(stage_6_per_in[18]),
    .y_out(stage_6_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_10 (
    .x_in(stage_5_per_out[20]),
    .y_in(stage_5_per_out[21]),
    .x_out(stage_6_per_in[20]),
    .y_out(stage_6_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_11 (
    .x_in(stage_5_per_out[22]),
    .y_in(stage_5_per_out[23]),
    .x_out(stage_6_per_in[22]),
    .y_out(stage_6_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_12 (
    .x_in(stage_5_per_out[24]),
    .y_in(stage_5_per_out[25]),
    .x_out(stage_6_per_in[24]),
    .y_out(stage_6_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_13 (
    .x_in(stage_5_per_out[26]),
    .y_in(stage_5_per_out[27]),
    .x_out(stage_6_per_in[26]),
    .y_out(stage_6_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_14 (
    .x_in(stage_5_per_out[28]),
    .y_in(stage_5_per_out[29]),
    .x_out(stage_6_per_in[28]),
    .y_out(stage_6_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_15 (
    .x_in(stage_5_per_out[30]),
    .y_in(stage_5_per_out[31]),
    .x_out(stage_6_per_in[30]),
    .y_out(stage_6_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_16 (
    .x_in(stage_5_per_out[32]),
    .y_in(stage_5_per_out[33]),
    .x_out(stage_6_per_in[32]),
    .y_out(stage_6_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_17 (
    .x_in(stage_5_per_out[34]),
    .y_in(stage_5_per_out[35]),
    .x_out(stage_6_per_in[34]),
    .y_out(stage_6_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_18 (
    .x_in(stage_5_per_out[36]),
    .y_in(stage_5_per_out[37]),
    .x_out(stage_6_per_in[36]),
    .y_out(stage_6_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_19 (
    .x_in(stage_5_per_out[38]),
    .y_in(stage_5_per_out[39]),
    .x_out(stage_6_per_in[38]),
    .y_out(stage_6_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_20 (
    .x_in(stage_5_per_out[40]),
    .y_in(stage_5_per_out[41]),
    .x_out(stage_6_per_in[40]),
    .y_out(stage_6_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_21 (
    .x_in(stage_5_per_out[42]),
    .y_in(stage_5_per_out[43]),
    .x_out(stage_6_per_in[42]),
    .y_out(stage_6_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_22 (
    .x_in(stage_5_per_out[44]),
    .y_in(stage_5_per_out[45]),
    .x_out(stage_6_per_in[44]),
    .y_out(stage_6_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_23 (
    .x_in(stage_5_per_out[46]),
    .y_in(stage_5_per_out[47]),
    .x_out(stage_6_per_in[46]),
    .y_out(stage_6_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_24 (
    .x_in(stage_5_per_out[48]),
    .y_in(stage_5_per_out[49]),
    .x_out(stage_6_per_in[48]),
    .y_out(stage_6_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_25 (
    .x_in(stage_5_per_out[50]),
    .y_in(stage_5_per_out[51]),
    .x_out(stage_6_per_in[50]),
    .y_out(stage_6_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_26 (
    .x_in(stage_5_per_out[52]),
    .y_in(stage_5_per_out[53]),
    .x_out(stage_6_per_in[52]),
    .y_out(stage_6_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_27 (
    .x_in(stage_5_per_out[54]),
    .y_in(stage_5_per_out[55]),
    .x_out(stage_6_per_in[54]),
    .y_out(stage_6_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_28 (
    .x_in(stage_5_per_out[56]),
    .y_in(stage_5_per_out[57]),
    .x_out(stage_6_per_in[56]),
    .y_out(stage_6_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_29 (
    .x_in(stage_5_per_out[58]),
    .y_in(stage_5_per_out[59]),
    .x_out(stage_6_per_in[58]),
    .y_out(stage_6_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_30 (
    .x_in(stage_5_per_out[60]),
    .y_in(stage_5_per_out[61]),
    .x_out(stage_6_per_in[60]),
    .y_out(stage_6_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 250183461, 180167806, 180167806, 69574326, 69574326, 174860716, 174860716}))
  stage_6_butterfly_31 (
    .x_in(stage_5_per_out[62]),
    .y_in(stage_5_per_out[63]),
    .x_out(stage_6_per_in[62]),
    .y_out(stage_6_per_in[63]),
    .clk(clk),
    .rst(rst)
  );



  // TODO(Yang): stage 6 -> stage 7 permutation
  // FIXME: ignore butterfly units for now.
  stage_6_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_6_7_per (
    .inData_0(stage_6_per_in[0]),
    .inData_1(stage_6_per_in[1]),
    .inData_2(stage_6_per_in[2]),
    .inData_3(stage_6_per_in[3]),
    .inData_4(stage_6_per_in[4]),
    .inData_5(stage_6_per_in[5]),
    .inData_6(stage_6_per_in[6]),
    .inData_7(stage_6_per_in[7]),
    .inData_8(stage_6_per_in[8]),
    .inData_9(stage_6_per_in[9]),
    .inData_10(stage_6_per_in[10]),
    .inData_11(stage_6_per_in[11]),
    .inData_12(stage_6_per_in[12]),
    .inData_13(stage_6_per_in[13]),
    .inData_14(stage_6_per_in[14]),
    .inData_15(stage_6_per_in[15]),
    .inData_16(stage_6_per_in[16]),
    .inData_17(stage_6_per_in[17]),
    .inData_18(stage_6_per_in[18]),
    .inData_19(stage_6_per_in[19]),
    .inData_20(stage_6_per_in[20]),
    .inData_21(stage_6_per_in[21]),
    .inData_22(stage_6_per_in[22]),
    .inData_23(stage_6_per_in[23]),
    .inData_24(stage_6_per_in[24]),
    .inData_25(stage_6_per_in[25]),
    .inData_26(stage_6_per_in[26]),
    .inData_27(stage_6_per_in[27]),
    .inData_28(stage_6_per_in[28]),
    .inData_29(stage_6_per_in[29]),
    .inData_30(stage_6_per_in[30]),
    .inData_31(stage_6_per_in[31]),
    .inData_32(stage_6_per_in[32]),
    .inData_33(stage_6_per_in[33]),
    .inData_34(stage_6_per_in[34]),
    .inData_35(stage_6_per_in[35]),
    .inData_36(stage_6_per_in[36]),
    .inData_37(stage_6_per_in[37]),
    .inData_38(stage_6_per_in[38]),
    .inData_39(stage_6_per_in[39]),
    .inData_40(stage_6_per_in[40]),
    .inData_41(stage_6_per_in[41]),
    .inData_42(stage_6_per_in[42]),
    .inData_43(stage_6_per_in[43]),
    .inData_44(stage_6_per_in[44]),
    .inData_45(stage_6_per_in[45]),
    .inData_46(stage_6_per_in[46]),
    .inData_47(stage_6_per_in[47]),
    .inData_48(stage_6_per_in[48]),
    .inData_49(stage_6_per_in[49]),
    .inData_50(stage_6_per_in[50]),
    .inData_51(stage_6_per_in[51]),
    .inData_52(stage_6_per_in[52]),
    .inData_53(stage_6_per_in[53]),
    .inData_54(stage_6_per_in[54]),
    .inData_55(stage_6_per_in[55]),
    .inData_56(stage_6_per_in[56]),
    .inData_57(stage_6_per_in[57]),
    .inData_58(stage_6_per_in[58]),
    .inData_59(stage_6_per_in[59]),
    .inData_60(stage_6_per_in[60]),
    .inData_61(stage_6_per_in[61]),
    .inData_62(stage_6_per_in[62]),
    .inData_63(stage_6_per_in[63]),
    .outData_0(stage_6_per_out[0]),
    .outData_1(stage_6_per_out[1]),
    .outData_2(stage_6_per_out[2]),
    .outData_3(stage_6_per_out[3]),
    .outData_4(stage_6_per_out[4]),
    .outData_5(stage_6_per_out[5]),
    .outData_6(stage_6_per_out[6]),
    .outData_7(stage_6_per_out[7]),
    .outData_8(stage_6_per_out[8]),
    .outData_9(stage_6_per_out[9]),
    .outData_10(stage_6_per_out[10]),
    .outData_11(stage_6_per_out[11]),
    .outData_12(stage_6_per_out[12]),
    .outData_13(stage_6_per_out[13]),
    .outData_14(stage_6_per_out[14]),
    .outData_15(stage_6_per_out[15]),
    .outData_16(stage_6_per_out[16]),
    .outData_17(stage_6_per_out[17]),
    .outData_18(stage_6_per_out[18]),
    .outData_19(stage_6_per_out[19]),
    .outData_20(stage_6_per_out[20]),
    .outData_21(stage_6_per_out[21]),
    .outData_22(stage_6_per_out[22]),
    .outData_23(stage_6_per_out[23]),
    .outData_24(stage_6_per_out[24]),
    .outData_25(stage_6_per_out[25]),
    .outData_26(stage_6_per_out[26]),
    .outData_27(stage_6_per_out[27]),
    .outData_28(stage_6_per_out[28]),
    .outData_29(stage_6_per_out[29]),
    .outData_30(stage_6_per_out[30]),
    .outData_31(stage_6_per_out[31]),
    .outData_32(stage_6_per_out[32]),
    .outData_33(stage_6_per_out[33]),
    .outData_34(stage_6_per_out[34]),
    .outData_35(stage_6_per_out[35]),
    .outData_36(stage_6_per_out[36]),
    .outData_37(stage_6_per_out[37]),
    .outData_38(stage_6_per_out[38]),
    .outData_39(stage_6_per_out[39]),
    .outData_40(stage_6_per_out[40]),
    .outData_41(stage_6_per_out[41]),
    .outData_42(stage_6_per_out[42]),
    .outData_43(stage_6_per_out[43]),
    .outData_44(stage_6_per_out[44]),
    .outData_45(stage_6_per_out[45]),
    .outData_46(stage_6_per_out[46]),
    .outData_47(stage_6_per_out[47]),
    .outData_48(stage_6_per_out[48]),
    .outData_49(stage_6_per_out[49]),
    .outData_50(stage_6_per_out[50]),
    .outData_51(stage_6_per_out[51]),
    .outData_52(stage_6_per_out[52]),
    .outData_53(stage_6_per_out[53]),
    .outData_54(stage_6_per_out[54]),
    .outData_55(stage_6_per_out[55]),
    .outData_56(stage_6_per_out[56]),
    .outData_57(stage_6_per_out[57]),
    .outData_58(stage_6_per_out[58]),
    .outData_59(stage_6_per_out[59]),
    .outData_60(stage_6_per_out[60]),
    .outData_61(stage_6_per_out[61]),
    .outData_62(stage_6_per_out[62]),
    .outData_63(stage_6_per_out[63]),
    .in_start(in_start[6]),
    .out_start(out_start[6]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 7 32 butterfly units
  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_0 (
    .x_in(stage_6_per_out[0]),
    .y_in(stage_6_per_out[1]),
    .x_out(stage_7_per_in[0]),
    .y_out(stage_7_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_1 (
    .x_in(stage_6_per_out[2]),
    .y_in(stage_6_per_out[3]),
    .x_out(stage_7_per_in[2]),
    .y_out(stage_7_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_2 (
    .x_in(stage_6_per_out[4]),
    .y_in(stage_6_per_out[5]),
    .x_out(stage_7_per_in[4]),
    .y_out(stage_7_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_3 (
    .x_in(stage_6_per_out[6]),
    .y_in(stage_6_per_out[7]),
    .x_out(stage_7_per_in[6]),
    .y_out(stage_7_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_4 (
    .x_in(stage_6_per_out[8]),
    .y_in(stage_6_per_out[9]),
    .x_out(stage_7_per_in[8]),
    .y_out(stage_7_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_5 (
    .x_in(stage_6_per_out[10]),
    .y_in(stage_6_per_out[11]),
    .x_out(stage_7_per_in[10]),
    .y_out(stage_7_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_6 (
    .x_in(stage_6_per_out[12]),
    .y_in(stage_6_per_out[13]),
    .x_out(stage_7_per_in[12]),
    .y_out(stage_7_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_7 (
    .x_in(stage_6_per_out[14]),
    .y_in(stage_6_per_out[15]),
    .x_out(stage_7_per_in[14]),
    .y_out(stage_7_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_8 (
    .x_in(stage_6_per_out[16]),
    .y_in(stage_6_per_out[17]),
    .x_out(stage_7_per_in[16]),
    .y_out(stage_7_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_9 (
    .x_in(stage_6_per_out[18]),
    .y_in(stage_6_per_out[19]),
    .x_out(stage_7_per_in[18]),
    .y_out(stage_7_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_10 (
    .x_in(stage_6_per_out[20]),
    .y_in(stage_6_per_out[21]),
    .x_out(stage_7_per_in[20]),
    .y_out(stage_7_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_11 (
    .x_in(stage_6_per_out[22]),
    .y_in(stage_6_per_out[23]),
    .x_out(stage_7_per_in[22]),
    .y_out(stage_7_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_12 (
    .x_in(stage_6_per_out[24]),
    .y_in(stage_6_per_out[25]),
    .x_out(stage_7_per_in[24]),
    .y_out(stage_7_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_13 (
    .x_in(stage_6_per_out[26]),
    .y_in(stage_6_per_out[27]),
    .x_out(stage_7_per_in[26]),
    .y_out(stage_7_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_14 (
    .x_in(stage_6_per_out[28]),
    .y_in(stage_6_per_out[29]),
    .x_out(stage_7_per_in[28]),
    .y_out(stage_7_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_15 (
    .x_in(stage_6_per_out[30]),
    .y_in(stage_6_per_out[31]),
    .x_out(stage_7_per_in[30]),
    .y_out(stage_7_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_16 (
    .x_in(stage_6_per_out[32]),
    .y_in(stage_6_per_out[33]),
    .x_out(stage_7_per_in[32]),
    .y_out(stage_7_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_17 (
    .x_in(stage_6_per_out[34]),
    .y_in(stage_6_per_out[35]),
    .x_out(stage_7_per_in[34]),
    .y_out(stage_7_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_18 (
    .x_in(stage_6_per_out[36]),
    .y_in(stage_6_per_out[37]),
    .x_out(stage_7_per_in[36]),
    .y_out(stage_7_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_19 (
    .x_in(stage_6_per_out[38]),
    .y_in(stage_6_per_out[39]),
    .x_out(stage_7_per_in[38]),
    .y_out(stage_7_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_20 (
    .x_in(stage_6_per_out[40]),
    .y_in(stage_6_per_out[41]),
    .x_out(stage_7_per_in[40]),
    .y_out(stage_7_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_21 (
    .x_in(stage_6_per_out[42]),
    .y_in(stage_6_per_out[43]),
    .x_out(stage_7_per_in[42]),
    .y_out(stage_7_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_22 (
    .x_in(stage_6_per_out[44]),
    .y_in(stage_6_per_out[45]),
    .x_out(stage_7_per_in[44]),
    .y_out(stage_7_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_23 (
    .x_in(stage_6_per_out[46]),
    .y_in(stage_6_per_out[47]),
    .x_out(stage_7_per_in[46]),
    .y_out(stage_7_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_24 (
    .x_in(stage_6_per_out[48]),
    .y_in(stage_6_per_out[49]),
    .x_out(stage_7_per_in[48]),
    .y_out(stage_7_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_25 (
    .x_in(stage_6_per_out[50]),
    .y_in(stage_6_per_out[51]),
    .x_out(stage_7_per_in[50]),
    .y_out(stage_7_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_26 (
    .x_in(stage_6_per_out[52]),
    .y_in(stage_6_per_out[53]),
    .x_out(stage_7_per_in[52]),
    .y_out(stage_7_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_27 (
    .x_in(stage_6_per_out[54]),
    .y_in(stage_6_per_out[55]),
    .x_out(stage_7_per_in[54]),
    .y_out(stage_7_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_28 (
    .x_in(stage_6_per_out[56]),
    .y_in(stage_6_per_out[57]),
    .x_out(stage_7_per_in[56]),
    .y_out(stage_7_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_29 (
    .x_in(stage_6_per_out[58]),
    .y_in(stage_6_per_out[59]),
    .x_out(stage_7_per_in[58]),
    .y_out(stage_7_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_30 (
    .x_in(stage_6_per_out[60]),
    .y_in(stage_6_per_out[61]),
    .x_out(stage_7_per_in[60]),
    .y_out(stage_7_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 185593570, 185593570, 183496802, 183496802, 183496802, 183496802}))
  stage_7_butterfly_31 (
    .x_in(stage_6_per_out[62]),
    .y_in(stage_6_per_out[63]),
    .x_out(stage_7_per_in[62]),
    .y_out(stage_7_per_in[63]),
    .clk(clk),
    .rst(rst)
  );



  // TODO(Yang): stage 7 -> stage 8 permutation
  // FIXME: ignore butterfly units for now.
  stage_7_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_7_8_per (
    .inData_0(stage_7_per_in[0]),
    .inData_1(stage_7_per_in[1]),
    .inData_2(stage_7_per_in[2]),
    .inData_3(stage_7_per_in[3]),
    .inData_4(stage_7_per_in[4]),
    .inData_5(stage_7_per_in[5]),
    .inData_6(stage_7_per_in[6]),
    .inData_7(stage_7_per_in[7]),
    .inData_8(stage_7_per_in[8]),
    .inData_9(stage_7_per_in[9]),
    .inData_10(stage_7_per_in[10]),
    .inData_11(stage_7_per_in[11]),
    .inData_12(stage_7_per_in[12]),
    .inData_13(stage_7_per_in[13]),
    .inData_14(stage_7_per_in[14]),
    .inData_15(stage_7_per_in[15]),
    .inData_16(stage_7_per_in[16]),
    .inData_17(stage_7_per_in[17]),
    .inData_18(stage_7_per_in[18]),
    .inData_19(stage_7_per_in[19]),
    .inData_20(stage_7_per_in[20]),
    .inData_21(stage_7_per_in[21]),
    .inData_22(stage_7_per_in[22]),
    .inData_23(stage_7_per_in[23]),
    .inData_24(stage_7_per_in[24]),
    .inData_25(stage_7_per_in[25]),
    .inData_26(stage_7_per_in[26]),
    .inData_27(stage_7_per_in[27]),
    .inData_28(stage_7_per_in[28]),
    .inData_29(stage_7_per_in[29]),
    .inData_30(stage_7_per_in[30]),
    .inData_31(stage_7_per_in[31]),
    .inData_32(stage_7_per_in[32]),
    .inData_33(stage_7_per_in[33]),
    .inData_34(stage_7_per_in[34]),
    .inData_35(stage_7_per_in[35]),
    .inData_36(stage_7_per_in[36]),
    .inData_37(stage_7_per_in[37]),
    .inData_38(stage_7_per_in[38]),
    .inData_39(stage_7_per_in[39]),
    .inData_40(stage_7_per_in[40]),
    .inData_41(stage_7_per_in[41]),
    .inData_42(stage_7_per_in[42]),
    .inData_43(stage_7_per_in[43]),
    .inData_44(stage_7_per_in[44]),
    .inData_45(stage_7_per_in[45]),
    .inData_46(stage_7_per_in[46]),
    .inData_47(stage_7_per_in[47]),
    .inData_48(stage_7_per_in[48]),
    .inData_49(stage_7_per_in[49]),
    .inData_50(stage_7_per_in[50]),
    .inData_51(stage_7_per_in[51]),
    .inData_52(stage_7_per_in[52]),
    .inData_53(stage_7_per_in[53]),
    .inData_54(stage_7_per_in[54]),
    .inData_55(stage_7_per_in[55]),
    .inData_56(stage_7_per_in[56]),
    .inData_57(stage_7_per_in[57]),
    .inData_58(stage_7_per_in[58]),
    .inData_59(stage_7_per_in[59]),
    .inData_60(stage_7_per_in[60]),
    .inData_61(stage_7_per_in[61]),
    .inData_62(stage_7_per_in[62]),
    .inData_63(stage_7_per_in[63]),
    .outData_0(stage_7_per_out[0]),
    .outData_1(stage_7_per_out[1]),
    .outData_2(stage_7_per_out[2]),
    .outData_3(stage_7_per_out[3]),
    .outData_4(stage_7_per_out[4]),
    .outData_5(stage_7_per_out[5]),
    .outData_6(stage_7_per_out[6]),
    .outData_7(stage_7_per_out[7]),
    .outData_8(stage_7_per_out[8]),
    .outData_9(stage_7_per_out[9]),
    .outData_10(stage_7_per_out[10]),
    .outData_11(stage_7_per_out[11]),
    .outData_12(stage_7_per_out[12]),
    .outData_13(stage_7_per_out[13]),
    .outData_14(stage_7_per_out[14]),
    .outData_15(stage_7_per_out[15]),
    .outData_16(stage_7_per_out[16]),
    .outData_17(stage_7_per_out[17]),
    .outData_18(stage_7_per_out[18]),
    .outData_19(stage_7_per_out[19]),
    .outData_20(stage_7_per_out[20]),
    .outData_21(stage_7_per_out[21]),
    .outData_22(stage_7_per_out[22]),
    .outData_23(stage_7_per_out[23]),
    .outData_24(stage_7_per_out[24]),
    .outData_25(stage_7_per_out[25]),
    .outData_26(stage_7_per_out[26]),
    .outData_27(stage_7_per_out[27]),
    .outData_28(stage_7_per_out[28]),
    .outData_29(stage_7_per_out[29]),
    .outData_30(stage_7_per_out[30]),
    .outData_31(stage_7_per_out[31]),
    .outData_32(stage_7_per_out[32]),
    .outData_33(stage_7_per_out[33]),
    .outData_34(stage_7_per_out[34]),
    .outData_35(stage_7_per_out[35]),
    .outData_36(stage_7_per_out[36]),
    .outData_37(stage_7_per_out[37]),
    .outData_38(stage_7_per_out[38]),
    .outData_39(stage_7_per_out[39]),
    .outData_40(stage_7_per_out[40]),
    .outData_41(stage_7_per_out[41]),
    .outData_42(stage_7_per_out[42]),
    .outData_43(stage_7_per_out[43]),
    .outData_44(stage_7_per_out[44]),
    .outData_45(stage_7_per_out[45]),
    .outData_46(stage_7_per_out[46]),
    .outData_47(stage_7_per_out[47]),
    .outData_48(stage_7_per_out[48]),
    .outData_49(stage_7_per_out[49]),
    .outData_50(stage_7_per_out[50]),
    .outData_51(stage_7_per_out[51]),
    .outData_52(stage_7_per_out[52]),
    .outData_53(stage_7_per_out[53]),
    .outData_54(stage_7_per_out[54]),
    .outData_55(stage_7_per_out[55]),
    .outData_56(stage_7_per_out[56]),
    .outData_57(stage_7_per_out[57]),
    .outData_58(stage_7_per_out[58]),
    .outData_59(stage_7_per_out[59]),
    .outData_60(stage_7_per_out[60]),
    .outData_61(stage_7_per_out[61]),
    .outData_62(stage_7_per_out[62]),
    .outData_63(stage_7_per_out[63]),
    .in_start(in_start[7]),
    .out_start(out_start[7]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 8 32 butterfly units
  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_0 (
    .x_in(stage_7_per_out[0]),
    .y_in(stage_7_per_out[1]),
    .x_out(outData[0]),
    .y_out(outData[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_1 (
    .x_in(stage_7_per_out[2]),
    .y_in(stage_7_per_out[3]),
    .x_out(outData[2]),
    .y_out(outData[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_2 (
    .x_in(stage_7_per_out[4]),
    .y_in(stage_7_per_out[5]),
    .x_out(outData[4]),
    .y_out(outData[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_3 (
    .x_in(stage_7_per_out[6]),
    .y_in(stage_7_per_out[7]),
    .x_out(outData[6]),
    .y_out(outData[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_4 (
    .x_in(stage_7_per_out[8]),
    .y_in(stage_7_per_out[9]),
    .x_out(outData[8]),
    .y_out(outData[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_5 (
    .x_in(stage_7_per_out[10]),
    .y_in(stage_7_per_out[11]),
    .x_out(outData[10]),
    .y_out(outData[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_6 (
    .x_in(stage_7_per_out[12]),
    .y_in(stage_7_per_out[13]),
    .x_out(outData[12]),
    .y_out(outData[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_7 (
    .x_in(stage_7_per_out[14]),
    .y_in(stage_7_per_out[15]),
    .x_out(outData[14]),
    .y_out(outData[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_8 (
    .x_in(stage_7_per_out[16]),
    .y_in(stage_7_per_out[17]),
    .x_out(outData[16]),
    .y_out(outData[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_9 (
    .x_in(stage_7_per_out[18]),
    .y_in(stage_7_per_out[19]),
    .x_out(outData[18]),
    .y_out(outData[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_10 (
    .x_in(stage_7_per_out[20]),
    .y_in(stage_7_per_out[21]),
    .x_out(outData[20]),
    .y_out(outData[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_11 (
    .x_in(stage_7_per_out[22]),
    .y_in(stage_7_per_out[23]),
    .x_out(outData[22]),
    .y_out(outData[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_12 (
    .x_in(stage_7_per_out[24]),
    .y_in(stage_7_per_out[25]),
    .x_out(outData[24]),
    .y_out(outData[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_13 (
    .x_in(stage_7_per_out[26]),
    .y_in(stage_7_per_out[27]),
    .x_out(outData[26]),
    .y_out(outData[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_14 (
    .x_in(stage_7_per_out[28]),
    .y_in(stage_7_per_out[29]),
    .x_out(outData[28]),
    .y_out(outData[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_15 (
    .x_in(stage_7_per_out[30]),
    .y_in(stage_7_per_out[31]),
    .x_out(outData[30]),
    .y_out(outData[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_16 (
    .x_in(stage_7_per_out[32]),
    .y_in(stage_7_per_out[33]),
    .x_out(outData[32]),
    .y_out(outData[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_17 (
    .x_in(stage_7_per_out[34]),
    .y_in(stage_7_per_out[35]),
    .x_out(outData[34]),
    .y_out(outData[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_18 (
    .x_in(stage_7_per_out[36]),
    .y_in(stage_7_per_out[37]),
    .x_out(outData[36]),
    .y_out(outData[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_19 (
    .x_in(stage_7_per_out[38]),
    .y_in(stage_7_per_out[39]),
    .x_out(outData[38]),
    .y_out(outData[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_20 (
    .x_in(stage_7_per_out[40]),
    .y_in(stage_7_per_out[41]),
    .x_out(outData[40]),
    .y_out(outData[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_21 (
    .x_in(stage_7_per_out[42]),
    .y_in(stage_7_per_out[43]),
    .x_out(outData[42]),
    .y_out(outData[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_22 (
    .x_in(stage_7_per_out[44]),
    .y_in(stage_7_per_out[45]),
    .x_out(outData[44]),
    .y_out(outData[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_23 (
    .x_in(stage_7_per_out[46]),
    .y_in(stage_7_per_out[47]),
    .x_out(outData[46]),
    .y_out(outData[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_24 (
    .x_in(stage_7_per_out[48]),
    .y_in(stage_7_per_out[49]),
    .x_out(outData[48]),
    .y_out(outData[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_25 (
    .x_in(stage_7_per_out[50]),
    .y_in(stage_7_per_out[51]),
    .x_out(outData[50]),
    .y_out(outData[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_26 (
    .x_in(stage_7_per_out[52]),
    .y_in(stage_7_per_out[53]),
    .x_out(outData[52]),
    .y_out(outData[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_27 (
    .x_in(stage_7_per_out[54]),
    .y_in(stage_7_per_out[55]),
    .x_out(outData[54]),
    .y_out(outData[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_28 (
    .x_in(stage_7_per_out[56]),
    .y_in(stage_7_per_out[57]),
    .x_out(outData[56]),
    .y_out(outData[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_29 (
    .x_in(stage_7_per_out[58]),
    .y_in(stage_7_per_out[59]),
    .x_out(outData[58]),
    .y_out(outData[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_30 (
    .x_in(stage_7_per_out[60]),
    .y_in(stage_7_per_out[61]),
    .x_out(outData[60]),
    .y_out(outData[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_31 (
    .x_in(stage_7_per_out[62]),
    .y_in(stage_7_per_out[63]),
    .x_out(outData[62]),
    .y_out(outData[63]),
    .clk(clk),
    .rst(rst)
  );


endmodule
