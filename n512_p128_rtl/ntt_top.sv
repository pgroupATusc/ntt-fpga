// NTT Accelerator

module NTT_Top #(
    parameter DATA_WIDTH_PER_INPUT = 28,
    parameter INPUT_PER_CYCLE = 128
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

  parameter [6:0] START_CYCLE[8] = {0, 7, 14, 21, 28, 35, 42, 67};

  // TODO(Tian): stage 0 32 butterfly units
  butterfly #(
    .start(START_CYCLE[0]),
    .factors({1562592, 6010959, 168676526, 68559335}))
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
    .factors({19223387, 42156432, 87088032, 118377542}))
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
    .factors({50222736, 95861179, 79136411, 202127782}))
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
    .factors({185685569, 234350511, 131377029, 67321994}))
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
    .factors({210770212, 6574921, 57574719, 148390399}))
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
    .factors({137346680, 242302870, 186863562, 172809179}))
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
    .factors({166955734, 58786546, 87074609, 119568150}))
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
    .factors({219898221, 137672988, 100229847, 183117409}))
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
    .factors({233514072, 23892097, 263070789, 263077695}))
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
    .factors({55567611, 165872957, 234113027, 209725121}))
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
    .factors({69584498, 266756542, 225650462, 200102186}))
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
    .factors({54534442, 158727274, 224586596, 210734246}))
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
    .factors({258226806, 242025902, 8411857, 9842125}))
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
    .factors({202059197, 256869432, 253800975, 61345534}))
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
    .factors({257649131, 232445568, 108115637, 206252403}))
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
    .factors({237102043, 21116414, 203485423, 126945619}))
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
    .factors({67970382, 129101436, 62408001, 262540431}))
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
    .factors({167366585, 49675259, 75073484, 168977833}))
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
    .factors({39269267, 25853611, 224068691, 32087335}))
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
    .factors({32260862, 149200070, 151148155, 212123710}))
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
    .factors({206649748, 24153138, 63079505, 128003797}))
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
    .factors({49286409, 43078133, 56094099, 195288398}))
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
    .factors({172935357, 49504466, 82934386, 61644903}))
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
    .factors({250071443, 73698550, 158890265, 138879618}))
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
    .factors({223822620, 201863951, 191444307, 75537498}))
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
    .factors({209886001, 60072008, 205525433, 188517169}))
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
    .factors({194276347, 215146927, 190319963, 136878682}))
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
    .factors({203605228, 110201077, 202955937, 209658551}))
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
    .factors({174900371, 85678851, 254911070, 176209504}))
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
    .factors({260909397, 11100143, 244763177, 138793148}))
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
    .factors({222861227, 6292910, 182702557, 60548134}))
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
    .factors({71847431, 36946189, 100123291, 117274103}))
  stage_0_butterfly_31 (
    .x_in(inData[62]),
    .y_in(inData[63]),
    .x_out(stage_0_per_in[62]),
    .y_out(stage_0_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({142306631, 154421517, 77981460, 203044972}))
  stage_0_butterfly_32 (
    .x_in(inData[64]),
    .y_in(inData[65]),
    .x_out(stage_0_per_in[64]),
    .y_out(stage_0_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({170930026, 40718170, 98861208, 69773246}))
  stage_0_butterfly_33 (
    .x_in(inData[66]),
    .y_in(inData[67]),
    .x_out(stage_0_per_in[66]),
    .y_out(stage_0_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({103731033, 251138298, 226014319, 59284831}))
  stage_0_butterfly_34 (
    .x_in(inData[68]),
    .y_in(inData[69]),
    .x_out(stage_0_per_in[68]),
    .y_out(stage_0_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({258257144, 50138453, 132750946, 144929841}))
  stage_0_butterfly_35 (
    .x_in(inData[70]),
    .y_in(inData[71]),
    .x_out(stage_0_per_in[70]),
    .y_out(stage_0_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({196328787, 181167649, 48631162, 212760505}))
  stage_0_butterfly_36 (
    .x_in(inData[72]),
    .y_in(inData[73]),
    .x_out(stage_0_per_in[72]),
    .y_out(stage_0_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({177340471, 193915204, 24688427, 50986641}))
  stage_0_butterfly_37 (
    .x_in(inData[74]),
    .y_in(inData[75]),
    .x_out(stage_0_per_in[74]),
    .y_out(stage_0_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({173118058, 224794776, 34481514, 49057739}))
  stage_0_butterfly_38 (
    .x_in(inData[76]),
    .y_in(inData[77]),
    .x_out(stage_0_per_in[76]),
    .y_out(stage_0_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({97318594, 47375162, 263530653, 71598752}))
  stage_0_butterfly_39 (
    .x_in(inData[78]),
    .y_in(inData[79]),
    .x_out(stage_0_per_in[78]),
    .y_out(stage_0_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({160807241, 91704337, 23405380, 5905084}))
  stage_0_butterfly_40 (
    .x_in(inData[80]),
    .y_in(inData[81]),
    .x_out(stage_0_per_in[80]),
    .y_out(stage_0_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({109902969, 8950678, 178386996, 82155735}))
  stage_0_butterfly_41 (
    .x_in(inData[82]),
    .y_in(inData[83]),
    .x_out(stage_0_per_in[82]),
    .y_out(stage_0_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({83725194, 175719113, 157966005, 153883128}))
  stage_0_butterfly_42 (
    .x_in(inData[84]),
    .y_in(inData[85]),
    .x_out(stage_0_per_in[84]),
    .y_out(stage_0_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({13083849, 210914061, 240127751, 77389872}))
  stage_0_butterfly_43 (
    .x_in(inData[86]),
    .y_in(inData[87]),
    .x_out(stage_0_per_in[86]),
    .y_out(stage_0_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({61574386, 103019692, 256173379, 212214167}))
  stage_0_butterfly_44 (
    .x_in(inData[88]),
    .y_in(inData[89]),
    .x_out(stage_0_per_in[88]),
    .y_out(stage_0_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({225389748, 238382196, 199633043, 173087458}))
  stage_0_butterfly_45 (
    .x_in(inData[90]),
    .y_in(inData[91]),
    .x_out(stage_0_per_in[90]),
    .y_out(stage_0_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({21080194, 143969870, 141849606, 94612904}))
  stage_0_butterfly_46 (
    .x_in(inData[92]),
    .y_in(inData[93]),
    .x_out(stage_0_per_in[92]),
    .y_out(stage_0_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({220490426, 16128104, 222683851, 258366673}))
  stage_0_butterfly_47 (
    .x_in(inData[94]),
    .y_in(inData[95]),
    .x_out(stage_0_per_in[94]),
    .y_out(stage_0_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({204886617, 206372598, 107527972, 20857483}))
  stage_0_butterfly_48 (
    .x_in(inData[96]),
    .y_in(inData[97]),
    .x_out(stage_0_per_in[96]),
    .y_out(stage_0_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({165134943, 67620310, 67225153, 228211497}))
  stage_0_butterfly_49 (
    .x_in(inData[98]),
    .y_in(inData[99]),
    .x_out(stage_0_per_in[98]),
    .y_out(stage_0_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({256272276, 35918322, 17861009, 25944135}))
  stage_0_butterfly_50 (
    .x_in(inData[100]),
    .y_in(inData[101]),
    .x_out(stage_0_per_in[100]),
    .y_out(stage_0_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({146037274, 211426643, 134877507, 16985430}))
  stage_0_butterfly_51 (
    .x_in(inData[102]),
    .y_in(inData[103]),
    .x_out(stage_0_per_in[102]),
    .y_out(stage_0_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({44144526, 161171966, 216395023, 195748297}))
  stage_0_butterfly_52 (
    .x_in(inData[104]),
    .y_in(inData[105]),
    .x_out(stage_0_per_in[104]),
    .y_out(stage_0_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({134100899, 237438985, 66298746, 84058929}))
  stage_0_butterfly_53 (
    .x_in(inData[106]),
    .y_in(inData[107]),
    .x_out(stage_0_per_in[106]),
    .y_out(stage_0_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({186841927, 21739535, 254132077, 187864761}))
  stage_0_butterfly_54 (
    .x_in(inData[108]),
    .y_in(inData[109]),
    .x_out(stage_0_per_in[108]),
    .y_out(stage_0_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({143102859, 61664240, 167911982, 207329882}))
  stage_0_butterfly_55 (
    .x_in(inData[110]),
    .y_in(inData[111]),
    .x_out(stage_0_per_in[110]),
    .y_out(stage_0_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({83231671, 143779572, 98889920, 181468172}))
  stage_0_butterfly_56 (
    .x_in(inData[112]),
    .y_in(inData[113]),
    .x_out(stage_0_per_in[112]),
    .y_out(stage_0_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({43104106, 112003761, 189720821, 27056737}))
  stage_0_butterfly_57 (
    .x_in(inData[114]),
    .y_in(inData[115]),
    .x_out(stage_0_per_in[114]),
    .y_out(stage_0_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({68493159, 171541778, 142181410, 40550456}))
  stage_0_butterfly_58 (
    .x_in(inData[116]),
    .y_in(inData[117]),
    .x_out(stage_0_per_in[116]),
    .y_out(stage_0_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({34971158, 43194148, 232615475, 137065607}))
  stage_0_butterfly_59 (
    .x_in(inData[118]),
    .y_in(inData[119]),
    .x_out(stage_0_per_in[118]),
    .y_out(stage_0_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({93740850, 225784463, 102915173, 155060883}))
  stage_0_butterfly_60 (
    .x_in(inData[120]),
    .y_in(inData[121]),
    .x_out(stage_0_per_in[120]),
    .y_out(stage_0_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({123335450, 202776751, 99187435, 183029478}))
  stage_0_butterfly_61 (
    .x_in(inData[122]),
    .y_in(inData[123]),
    .x_out(stage_0_per_in[122]),
    .y_out(stage_0_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({16471674, 117507527, 135886841, 25345558}))
  stage_0_butterfly_62 (
    .x_in(inData[124]),
    .y_in(inData[125]),
    .x_out(stage_0_per_in[124]),
    .y_out(stage_0_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[0]),
    .factors({258559590, 171362072, 170284131, 266671862}))
  stage_0_butterfly_63 (
    .x_in(inData[126]),
    .y_in(inData[127]),
    .x_out(stage_0_per_in[126]),
    .y_out(stage_0_per_in[127]),
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
    .inData_64(stage_0_per_in[64]),
    .inData_65(stage_0_per_in[65]),
    .inData_66(stage_0_per_in[66]),
    .inData_67(stage_0_per_in[67]),
    .inData_68(stage_0_per_in[68]),
    .inData_69(stage_0_per_in[69]),
    .inData_70(stage_0_per_in[70]),
    .inData_71(stage_0_per_in[71]),
    .inData_72(stage_0_per_in[72]),
    .inData_73(stage_0_per_in[73]),
    .inData_74(stage_0_per_in[74]),
    .inData_75(stage_0_per_in[75]),
    .inData_76(stage_0_per_in[76]),
    .inData_77(stage_0_per_in[77]),
    .inData_78(stage_0_per_in[78]),
    .inData_79(stage_0_per_in[79]),
    .inData_80(stage_0_per_in[80]),
    .inData_81(stage_0_per_in[81]),
    .inData_82(stage_0_per_in[82]),
    .inData_83(stage_0_per_in[83]),
    .inData_84(stage_0_per_in[84]),
    .inData_85(stage_0_per_in[85]),
    .inData_86(stage_0_per_in[86]),
    .inData_87(stage_0_per_in[87]),
    .inData_88(stage_0_per_in[88]),
    .inData_89(stage_0_per_in[89]),
    .inData_90(stage_0_per_in[90]),
    .inData_91(stage_0_per_in[91]),
    .inData_92(stage_0_per_in[92]),
    .inData_93(stage_0_per_in[93]),
    .inData_94(stage_0_per_in[94]),
    .inData_95(stage_0_per_in[95]),
    .inData_96(stage_0_per_in[96]),
    .inData_97(stage_0_per_in[97]),
    .inData_98(stage_0_per_in[98]),
    .inData_99(stage_0_per_in[99]),
    .inData_100(stage_0_per_in[100]),
    .inData_101(stage_0_per_in[101]),
    .inData_102(stage_0_per_in[102]),
    .inData_103(stage_0_per_in[103]),
    .inData_104(stage_0_per_in[104]),
    .inData_105(stage_0_per_in[105]),
    .inData_106(stage_0_per_in[106]),
    .inData_107(stage_0_per_in[107]),
    .inData_108(stage_0_per_in[108]),
    .inData_109(stage_0_per_in[109]),
    .inData_110(stage_0_per_in[110]),
    .inData_111(stage_0_per_in[111]),
    .inData_112(stage_0_per_in[112]),
    .inData_113(stage_0_per_in[113]),
    .inData_114(stage_0_per_in[114]),
    .inData_115(stage_0_per_in[115]),
    .inData_116(stage_0_per_in[116]),
    .inData_117(stage_0_per_in[117]),
    .inData_118(stage_0_per_in[118]),
    .inData_119(stage_0_per_in[119]),
    .inData_120(stage_0_per_in[120]),
    .inData_121(stage_0_per_in[121]),
    .inData_122(stage_0_per_in[122]),
    .inData_123(stage_0_per_in[123]),
    .inData_124(stage_0_per_in[124]),
    .inData_125(stage_0_per_in[125]),
    .inData_126(stage_0_per_in[126]),
    .inData_127(stage_0_per_in[127]),
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
    .outData_64(stage_0_per_out[64]),
    .outData_65(stage_0_per_out[65]),
    .outData_66(stage_0_per_out[66]),
    .outData_67(stage_0_per_out[67]),
    .outData_68(stage_0_per_out[68]),
    .outData_69(stage_0_per_out[69]),
    .outData_70(stage_0_per_out[70]),
    .outData_71(stage_0_per_out[71]),
    .outData_72(stage_0_per_out[72]),
    .outData_73(stage_0_per_out[73]),
    .outData_74(stage_0_per_out[74]),
    .outData_75(stage_0_per_out[75]),
    .outData_76(stage_0_per_out[76]),
    .outData_77(stage_0_per_out[77]),
    .outData_78(stage_0_per_out[78]),
    .outData_79(stage_0_per_out[79]),
    .outData_80(stage_0_per_out[80]),
    .outData_81(stage_0_per_out[81]),
    .outData_82(stage_0_per_out[82]),
    .outData_83(stage_0_per_out[83]),
    .outData_84(stage_0_per_out[84]),
    .outData_85(stage_0_per_out[85]),
    .outData_86(stage_0_per_out[86]),
    .outData_87(stage_0_per_out[87]),
    .outData_88(stage_0_per_out[88]),
    .outData_89(stage_0_per_out[89]),
    .outData_90(stage_0_per_out[90]),
    .outData_91(stage_0_per_out[91]),
    .outData_92(stage_0_per_out[92]),
    .outData_93(stage_0_per_out[93]),
    .outData_94(stage_0_per_out[94]),
    .outData_95(stage_0_per_out[95]),
    .outData_96(stage_0_per_out[96]),
    .outData_97(stage_0_per_out[97]),
    .outData_98(stage_0_per_out[98]),
    .outData_99(stage_0_per_out[99]),
    .outData_100(stage_0_per_out[100]),
    .outData_101(stage_0_per_out[101]),
    .outData_102(stage_0_per_out[102]),
    .outData_103(stage_0_per_out[103]),
    .outData_104(stage_0_per_out[104]),
    .outData_105(stage_0_per_out[105]),
    .outData_106(stage_0_per_out[106]),
    .outData_107(stage_0_per_out[107]),
    .outData_108(stage_0_per_out[108]),
    .outData_109(stage_0_per_out[109]),
    .outData_110(stage_0_per_out[110]),
    .outData_111(stage_0_per_out[111]),
    .outData_112(stage_0_per_out[112]),
    .outData_113(stage_0_per_out[113]),
    .outData_114(stage_0_per_out[114]),
    .outData_115(stage_0_per_out[115]),
    .outData_116(stage_0_per_out[116]),
    .outData_117(stage_0_per_out[117]),
    .outData_118(stage_0_per_out[118]),
    .outData_119(stage_0_per_out[119]),
    .outData_120(stage_0_per_out[120]),
    .outData_121(stage_0_per_out[121]),
    .outData_122(stage_0_per_out[122]),
    .outData_123(stage_0_per_out[123]),
    .outData_124(stage_0_per_out[124]),
    .outData_125(stage_0_per_out[125]),
    .outData_126(stage_0_per_out[126]),
    .outData_127(stage_0_per_out[127]),
    .in_start(in_start[0]),
    .out_start(out_start[0]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Tian): stage 1 32 butterfly units
  butterfly #(
    .start(START_CYCLE[1]),
    .factors({64217206, 180525688, 265950570, 258612781}))
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
    .factors({64217206, 180525688, 265950570, 258612781}))
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
    .factors({202221416, 69161747, 27692847, 209086118}))
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
    .factors({202221416, 69161747, 27692847, 209086118}))
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
    .factors({108083129, 22541719, 166530134, 94666956}))
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
    .factors({108083129, 22541719, 166530134, 94666956}))
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
    .factors({229216409, 13250338, 256040960, 177772804}))
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
    .factors({229216409, 13250338, 256040960, 177772804}))
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
    .factors({254509489, 84143174, 181639510, 34339674}))
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
    .factors({254509489, 84143174, 181639510, 34339674}))
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
    .factors({55721255, 71933862, 216143425, 41155851}))
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
    .factors({55721255, 71933862, 216143425, 41155851}))
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
    .factors({220618744, 37667151, 119707826, 106640438}))
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
    .factors({220618744, 37667151, 119707826, 106640438}))
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
    .factors({15417588, 124400208, 39141691, 85021501}))
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
    .factors({15417588, 124400208, 39141691, 85021501}))
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
    .factors({204666342, 9446767, 123185272, 75673633}))
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
    .factors({204666342, 9446767, 123185272, 75673633}))
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
    .factors({26687688, 98878775, 85922744, 159404461}))
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
    .factors({26687688, 98878775, 85922744, 159404461}))
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
    .factors({227816219, 128814716, 13919506, 231318087}))
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
    .factors({227816219, 128814716, 13919506, 231318087}))
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
    .factors({118518376, 28824907, 97765534, 137812299}))
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
    .factors({118518376, 28824907, 97765534, 137812299}))
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
    .factors({108810259, 195631434, 40475021, 74998629}))
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
    .factors({108810259, 195631434, 40475021, 74998629}))
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
    .factors({214551729, 171721518, 14542514, 150873005}))
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
    .factors({214551729, 171721518, 14542514, 150873005}))
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
    .factors({234890903, 18399308, 98142515, 250166212}))
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
    .factors({234890903, 18399308, 98142515, 250166212}))
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
    .factors({223427563, 50725340, 257798138, 100484142}))
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
    .factors({223427563, 50725340, 257798138, 100484142}))
  stage_1_butterfly_31 (
    .x_in(stage_0_per_out[62]),
    .y_in(stage_0_per_out[63]),
    .x_out(stage_1_per_in[62]),
    .y_out(stage_1_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({163585105, 144414946, 6576175, 189881206}))
  stage_1_butterfly_32 (
    .x_in(stage_0_per_out[64]),
    .y_in(stage_0_per_out[65]),
    .x_out(stage_1_per_in[64]),
    .y_out(stage_1_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({163585105, 144414946, 6576175, 189881206}))
  stage_1_butterfly_33 (
    .x_in(stage_0_per_out[66]),
    .y_in(stage_0_per_out[67]),
    .x_out(stage_1_per_in[66]),
    .y_out(stage_1_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({3883583, 56700993, 188210893, 81777479}))
  stage_1_butterfly_34 (
    .x_in(stage_0_per_out[68]),
    .y_in(stage_0_per_out[69]),
    .x_out(stage_1_per_in[68]),
    .y_out(stage_1_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({3883583, 56700993, 188210893, 81777479}))
  stage_1_butterfly_35 (
    .x_in(stage_0_per_out[70]),
    .y_in(stage_0_per_out[71]),
    .x_out(stage_1_per_in[70]),
    .y_out(stage_1_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({133503098, 25569479, 116401819, 139182289}))
  stage_1_butterfly_36 (
    .x_in(stage_0_per_out[72]),
    .y_in(stage_0_per_out[73]),
    .x_out(stage_1_per_in[72]),
    .y_out(stage_1_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({133503098, 25569479, 116401819, 139182289}))
  stage_1_butterfly_37 (
    .x_in(stage_0_per_out[74]),
    .y_in(stage_0_per_out[75]),
    .x_out(stage_1_per_in[74]),
    .y_out(stage_1_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({227283585, 122008382, 249640399, 10130658}))
  stage_1_butterfly_38 (
    .x_in(stage_0_per_out[76]),
    .y_in(stage_0_per_out[77]),
    .x_out(stage_1_per_in[76]),
    .y_out(stage_1_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({227283585, 122008382, 249640399, 10130658}))
  stage_1_butterfly_39 (
    .x_in(stage_0_per_out[78]),
    .y_in(stage_0_per_out[79]),
    .x_out(stage_1_per_in[78]),
    .y_out(stage_1_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({113201512, 225636920, 101483624, 176471684}))
  stage_1_butterfly_40 (
    .x_in(stage_0_per_out[80]),
    .y_in(stage_0_per_out[81]),
    .x_out(stage_1_per_in[80]),
    .y_out(stage_1_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({113201512, 225636920, 101483624, 176471684}))
  stage_1_butterfly_41 (
    .x_in(stage_0_per_out[82]),
    .y_in(stage_0_per_out[83]),
    .x_out(stage_1_per_in[82]),
    .y_out(stage_1_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({163812837, 147433882, 197305753, 184516225}))
  stage_1_butterfly_42 (
    .x_in(stage_0_per_out[84]),
    .y_in(stage_0_per_out[85]),
    .x_out(stage_1_per_in[84]),
    .y_out(stage_1_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({163812837, 147433882, 197305753, 184516225}))
  stage_1_butterfly_43 (
    .x_in(stage_0_per_out[86]),
    .y_in(stage_0_per_out[87]),
    .x_out(stage_1_per_in[86]),
    .y_out(stage_1_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({96142103, 210298252, 68136911, 27244461}))
  stage_1_butterfly_44 (
    .x_in(stage_0_per_out[88]),
    .y_in(stage_0_per_out[89]),
    .x_out(stage_1_per_in[88]),
    .y_out(stage_1_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({96142103, 210298252, 68136911, 27244461}))
  stage_1_butterfly_45 (
    .x_in(stage_0_per_out[90]),
    .y_in(stage_0_per_out[91]),
    .x_out(stage_1_per_in[90]),
    .y_out(stage_1_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({149528048, 197074908, 11101448, 243304319}))
  stage_1_butterfly_46 (
    .x_in(stage_0_per_out[92]),
    .y_in(stage_0_per_out[93]),
    .x_out(stage_1_per_in[92]),
    .y_out(stage_1_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({149528048, 197074908, 11101448, 243304319}))
  stage_1_butterfly_47 (
    .x_in(stage_0_per_out[94]),
    .y_in(stage_0_per_out[95]),
    .x_out(stage_1_per_in[94]),
    .y_out(stage_1_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({265574867, 248876054, 261314274, 245906264}))
  stage_1_butterfly_48 (
    .x_in(stage_0_per_out[96]),
    .y_in(stage_0_per_out[97]),
    .x_out(stage_1_per_in[96]),
    .y_out(stage_1_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({265574867, 248876054, 261314274, 245906264}))
  stage_1_butterfly_49 (
    .x_in(stage_0_per_out[98]),
    .y_in(stage_0_per_out[99]),
    .x_out(stage_1_per_in[98]),
    .y_out(stage_1_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({161827885, 258649698, 23486645, 78777967}))
  stage_1_butterfly_50 (
    .x_in(stage_0_per_out[100]),
    .y_in(stage_0_per_out[101]),
    .x_out(stage_1_per_in[100]),
    .y_out(stage_1_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({161827885, 258649698, 23486645, 78777967}))
  stage_1_butterfly_51 (
    .x_in(stage_0_per_out[102]),
    .y_in(stage_0_per_out[103]),
    .x_out(stage_1_per_in[102]),
    .y_out(stage_1_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({246744565, 132703565, 135288005, 54284329}))
  stage_1_butterfly_52 (
    .x_in(stage_0_per_out[104]),
    .y_in(stage_0_per_out[105]),
    .x_out(stage_1_per_in[104]),
    .y_out(stage_1_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({246744565, 132703565, 135288005, 54284329}))
  stage_1_butterfly_53 (
    .x_in(stage_0_per_out[106]),
    .y_in(stage_0_per_out[107]),
    .x_out(stage_1_per_in[106]),
    .y_out(stage_1_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({164195239, 168407516, 29871855, 63350037}))
  stage_1_butterfly_54 (
    .x_in(stage_0_per_out[108]),
    .y_in(stage_0_per_out[109]),
    .x_out(stage_1_per_in[108]),
    .y_out(stage_1_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({164195239, 168407516, 29871855, 63350037}))
  stage_1_butterfly_55 (
    .x_in(stage_0_per_out[110]),
    .y_in(stage_0_per_out[111]),
    .x_out(stage_1_per_in[110]),
    .y_out(stage_1_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({191032230, 252442032, 189762285, 236144340}))
  stage_1_butterfly_56 (
    .x_in(stage_0_per_out[112]),
    .y_in(stage_0_per_out[113]),
    .x_out(stage_1_per_in[112]),
    .y_out(stage_1_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({191032230, 252442032, 189762285, 236144340}))
  stage_1_butterfly_57 (
    .x_in(stage_0_per_out[114]),
    .y_in(stage_0_per_out[115]),
    .x_out(stage_1_per_in[114]),
    .y_out(stage_1_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({234250032, 106338196, 246656426, 209161759}))
  stage_1_butterfly_58 (
    .x_in(stage_0_per_out[116]),
    .y_in(stage_0_per_out[117]),
    .x_out(stage_1_per_in[116]),
    .y_out(stage_1_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({234250032, 106338196, 246656426, 209161759}))
  stage_1_butterfly_59 (
    .x_in(stage_0_per_out[118]),
    .y_in(stage_0_per_out[119]),
    .x_out(stage_1_per_in[118]),
    .y_out(stage_1_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({67012048, 220375582, 176917280, 37011073}))
  stage_1_butterfly_60 (
    .x_in(stage_0_per_out[120]),
    .y_in(stage_0_per_out[121]),
    .x_out(stage_1_per_in[120]),
    .y_out(stage_1_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({67012048, 220375582, 176917280, 37011073}))
  stage_1_butterfly_61 (
    .x_in(stage_0_per_out[122]),
    .y_in(stage_0_per_out[123]),
    .x_out(stage_1_per_in[122]),
    .y_out(stage_1_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({226739459, 13519489, 81956368, 230433664}))
  stage_1_butterfly_62 (
    .x_in(stage_0_per_out[124]),
    .y_in(stage_0_per_out[125]),
    .x_out(stage_1_per_in[124]),
    .y_out(stage_1_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[1]),
    .factors({226739459, 13519489, 81956368, 230433664}))
  stage_1_butterfly_63 (
    .x_in(stage_0_per_out[126]),
    .y_in(stage_0_per_out[127]),
    .x_out(stage_1_per_in[126]),
    .y_out(stage_1_per_in[127]),
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
    .inData_64(stage_1_per_in[64]),
    .inData_65(stage_1_per_in[65]),
    .inData_66(stage_1_per_in[66]),
    .inData_67(stage_1_per_in[67]),
    .inData_68(stage_1_per_in[68]),
    .inData_69(stage_1_per_in[69]),
    .inData_70(stage_1_per_in[70]),
    .inData_71(stage_1_per_in[71]),
    .inData_72(stage_1_per_in[72]),
    .inData_73(stage_1_per_in[73]),
    .inData_74(stage_1_per_in[74]),
    .inData_75(stage_1_per_in[75]),
    .inData_76(stage_1_per_in[76]),
    .inData_77(stage_1_per_in[77]),
    .inData_78(stage_1_per_in[78]),
    .inData_79(stage_1_per_in[79]),
    .inData_80(stage_1_per_in[80]),
    .inData_81(stage_1_per_in[81]),
    .inData_82(stage_1_per_in[82]),
    .inData_83(stage_1_per_in[83]),
    .inData_84(stage_1_per_in[84]),
    .inData_85(stage_1_per_in[85]),
    .inData_86(stage_1_per_in[86]),
    .inData_87(stage_1_per_in[87]),
    .inData_88(stage_1_per_in[88]),
    .inData_89(stage_1_per_in[89]),
    .inData_90(stage_1_per_in[90]),
    .inData_91(stage_1_per_in[91]),
    .inData_92(stage_1_per_in[92]),
    .inData_93(stage_1_per_in[93]),
    .inData_94(stage_1_per_in[94]),
    .inData_95(stage_1_per_in[95]),
    .inData_96(stage_1_per_in[96]),
    .inData_97(stage_1_per_in[97]),
    .inData_98(stage_1_per_in[98]),
    .inData_99(stage_1_per_in[99]),
    .inData_100(stage_1_per_in[100]),
    .inData_101(stage_1_per_in[101]),
    .inData_102(stage_1_per_in[102]),
    .inData_103(stage_1_per_in[103]),
    .inData_104(stage_1_per_in[104]),
    .inData_105(stage_1_per_in[105]),
    .inData_106(stage_1_per_in[106]),
    .inData_107(stage_1_per_in[107]),
    .inData_108(stage_1_per_in[108]),
    .inData_109(stage_1_per_in[109]),
    .inData_110(stage_1_per_in[110]),
    .inData_111(stage_1_per_in[111]),
    .inData_112(stage_1_per_in[112]),
    .inData_113(stage_1_per_in[113]),
    .inData_114(stage_1_per_in[114]),
    .inData_115(stage_1_per_in[115]),
    .inData_116(stage_1_per_in[116]),
    .inData_117(stage_1_per_in[117]),
    .inData_118(stage_1_per_in[118]),
    .inData_119(stage_1_per_in[119]),
    .inData_120(stage_1_per_in[120]),
    .inData_121(stage_1_per_in[121]),
    .inData_122(stage_1_per_in[122]),
    .inData_123(stage_1_per_in[123]),
    .inData_124(stage_1_per_in[124]),
    .inData_125(stage_1_per_in[125]),
    .inData_126(stage_1_per_in[126]),
    .inData_127(stage_1_per_in[127]),
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
    .outData_64(stage_1_per_out[64]),
    .outData_65(stage_1_per_out[65]),
    .outData_66(stage_1_per_out[66]),
    .outData_67(stage_1_per_out[67]),
    .outData_68(stage_1_per_out[68]),
    .outData_69(stage_1_per_out[69]),
    .outData_70(stage_1_per_out[70]),
    .outData_71(stage_1_per_out[71]),
    .outData_72(stage_1_per_out[72]),
    .outData_73(stage_1_per_out[73]),
    .outData_74(stage_1_per_out[74]),
    .outData_75(stage_1_per_out[75]),
    .outData_76(stage_1_per_out[76]),
    .outData_77(stage_1_per_out[77]),
    .outData_78(stage_1_per_out[78]),
    .outData_79(stage_1_per_out[79]),
    .outData_80(stage_1_per_out[80]),
    .outData_81(stage_1_per_out[81]),
    .outData_82(stage_1_per_out[82]),
    .outData_83(stage_1_per_out[83]),
    .outData_84(stage_1_per_out[84]),
    .outData_85(stage_1_per_out[85]),
    .outData_86(stage_1_per_out[86]),
    .outData_87(stage_1_per_out[87]),
    .outData_88(stage_1_per_out[88]),
    .outData_89(stage_1_per_out[89]),
    .outData_90(stage_1_per_out[90]),
    .outData_91(stage_1_per_out[91]),
    .outData_92(stage_1_per_out[92]),
    .outData_93(stage_1_per_out[93]),
    .outData_94(stage_1_per_out[94]),
    .outData_95(stage_1_per_out[95]),
    .outData_96(stage_1_per_out[96]),
    .outData_97(stage_1_per_out[97]),
    .outData_98(stage_1_per_out[98]),
    .outData_99(stage_1_per_out[99]),
    .outData_100(stage_1_per_out[100]),
    .outData_101(stage_1_per_out[101]),
    .outData_102(stage_1_per_out[102]),
    .outData_103(stage_1_per_out[103]),
    .outData_104(stage_1_per_out[104]),
    .outData_105(stage_1_per_out[105]),
    .outData_106(stage_1_per_out[106]),
    .outData_107(stage_1_per_out[107]),
    .outData_108(stage_1_per_out[108]),
    .outData_109(stage_1_per_out[109]),
    .outData_110(stage_1_per_out[110]),
    .outData_111(stage_1_per_out[111]),
    .outData_112(stage_1_per_out[112]),
    .outData_113(stage_1_per_out[113]),
    .outData_114(stage_1_per_out[114]),
    .outData_115(stage_1_per_out[115]),
    .outData_116(stage_1_per_out[116]),
    .outData_117(stage_1_per_out[117]),
    .outData_118(stage_1_per_out[118]),
    .outData_119(stage_1_per_out[119]),
    .outData_120(stage_1_per_out[120]),
    .outData_121(stage_1_per_out[121]),
    .outData_122(stage_1_per_out[122]),
    .outData_123(stage_1_per_out[123]),
    .outData_124(stage_1_per_out[124]),
    .outData_125(stage_1_per_out[125]),
    .outData_126(stage_1_per_out[126]),
    .outData_127(stage_1_per_out[127]),
    .in_start(in_start[1]),
    .out_start(out_start[1]),
    .clk(clk),
    .rst(rst)
  );


  // TODO(Tian): stage 2 32 butterfly units
  butterfly #(
    .start(START_CYCLE[2]),
    .factors({49823188, 128164980, 111284191, 235204060}))
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
    .factors({49823188, 128164980, 111284191, 235204060}))
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
    .factors({49823188, 128164980, 111284191, 235204060}))
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
    .factors({49823188, 128164980, 111284191, 235204060}))
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
    .factors({189517632, 170752771, 102065274, 131798756}))
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
    .factors({189517632, 170752771, 102065274, 131798756}))
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
    .factors({189517632, 170752771, 102065274, 131798756}))
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
    .factors({189517632, 170752771, 102065274, 131798756}))
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
    .factors({40758458, 200054106, 59966873, 71471012}))
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
    .factors({40758458, 200054106, 59966873, 71471012}))
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
    .factors({40758458, 200054106, 59966873, 71471012}))
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
    .factors({40758458, 200054106, 59966873, 71471012}))
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
    .factors({196909902, 191662816, 109254766, 100099056}))
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
    .factors({196909902, 191662816, 109254766, 100099056}))
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
    .factors({196909902, 191662816, 109254766, 100099056}))
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
    .factors({196909902, 191662816, 109254766, 100099056}))
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
    .factors({146694818, 88552238, 111341228, 155896930}))
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
    .factors({146694818, 88552238, 111341228, 155896930}))
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
    .factors({146694818, 88552238, 111341228, 155896930}))
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
    .factors({146694818, 88552238, 111341228, 155896930}))
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
    .factors({202366126, 158816719, 30748955, 122985686}))
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
    .factors({202366126, 158816719, 30748955, 122985686}))
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
    .factors({202366126, 158816719, 30748955, 122985686}))
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
    .factors({202366126, 158816719, 30748955, 122985686}))
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
    .factors({147699054, 262046585, 177255039, 193689173}))
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
    .factors({147699054, 262046585, 177255039, 193689173}))
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
    .factors({147699054, 262046585, 177255039, 193689173}))
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
    .factors({147699054, 262046585, 177255039, 193689173}))
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
    .factors({86517113, 103143177, 57801361, 162373432}))
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
    .factors({86517113, 103143177, 57801361, 162373432}))
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
    .factors({86517113, 103143177, 57801361, 162373432}))
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
    .factors({86517113, 103143177, 57801361, 162373432}))
  stage_2_butterfly_31 (
    .x_in(stage_1_per_out[62]),
    .y_in(stage_1_per_out[63]),
    .x_out(stage_2_per_in[62]),
    .y_out(stage_2_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({172642311, 75324254, 143450922, 149429971}))
  stage_2_butterfly_32 (
    .x_in(stage_1_per_out[64]),
    .y_in(stage_1_per_out[65]),
    .x_out(stage_2_per_in[64]),
    .y_out(stage_2_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({172642311, 75324254, 143450922, 149429971}))
  stage_2_butterfly_33 (
    .x_in(stage_1_per_out[66]),
    .y_in(stage_1_per_out[67]),
    .x_out(stage_2_per_in[66]),
    .y_out(stage_2_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({172642311, 75324254, 143450922, 149429971}))
  stage_2_butterfly_34 (
    .x_in(stage_1_per_out[68]),
    .y_in(stage_1_per_out[69]),
    .x_out(stage_2_per_in[68]),
    .y_out(stage_2_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({172642311, 75324254, 143450922, 149429971}))
  stage_2_butterfly_35 (
    .x_in(stage_1_per_out[70]),
    .y_in(stage_1_per_out[71]),
    .x_out(stage_2_per_in[70]),
    .y_out(stage_2_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({52673254, 17079898, 185598009, 62045777}))
  stage_2_butterfly_36 (
    .x_in(stage_1_per_out[72]),
    .y_in(stage_1_per_out[73]),
    .x_out(stage_2_per_in[72]),
    .y_out(stage_2_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({52673254, 17079898, 185598009, 62045777}))
  stage_2_butterfly_37 (
    .x_in(stage_1_per_out[74]),
    .y_in(stage_1_per_out[75]),
    .x_out(stage_2_per_in[74]),
    .y_out(stage_2_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({52673254, 17079898, 185598009, 62045777}))
  stage_2_butterfly_38 (
    .x_in(stage_1_per_out[76]),
    .y_in(stage_1_per_out[77]),
    .x_out(stage_2_per_in[76]),
    .y_out(stage_2_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({52673254, 17079898, 185598009, 62045777}))
  stage_2_butterfly_39 (
    .x_in(stage_1_per_out[78]),
    .y_in(stage_1_per_out[79]),
    .x_out(stage_2_per_in[78]),
    .y_out(stage_2_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({175792128, 202257393, 228776079, 152865265}))
  stage_2_butterfly_40 (
    .x_in(stage_1_per_out[80]),
    .y_in(stage_1_per_out[81]),
    .x_out(stage_2_per_in[80]),
    .y_out(stage_2_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({175792128, 202257393, 228776079, 152865265}))
  stage_2_butterfly_41 (
    .x_in(stage_1_per_out[82]),
    .y_in(stage_1_per_out[83]),
    .x_out(stage_2_per_in[82]),
    .y_out(stage_2_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({175792128, 202257393, 228776079, 152865265}))
  stage_2_butterfly_42 (
    .x_in(stage_1_per_out[84]),
    .y_in(stage_1_per_out[85]),
    .x_out(stage_2_per_in[84]),
    .y_out(stage_2_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({175792128, 202257393, 228776079, 152865265}))
  stage_2_butterfly_43 (
    .x_in(stage_1_per_out[86]),
    .y_in(stage_1_per_out[87]),
    .x_out(stage_2_per_in[86]),
    .y_out(stage_2_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({70582130, 25574347, 29274521, 175609590}))
  stage_2_butterfly_44 (
    .x_in(stage_1_per_out[88]),
    .y_in(stage_1_per_out[89]),
    .x_out(stage_2_per_in[88]),
    .y_out(stage_2_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({70582130, 25574347, 29274521, 175609590}))
  stage_2_butterfly_45 (
    .x_in(stage_1_per_out[90]),
    .y_in(stage_1_per_out[91]),
    .x_out(stage_2_per_in[90]),
    .y_out(stage_2_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({70582130, 25574347, 29274521, 175609590}))
  stage_2_butterfly_46 (
    .x_in(stage_1_per_out[92]),
    .y_in(stage_1_per_out[93]),
    .x_out(stage_2_per_in[92]),
    .y_out(stage_2_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({70582130, 25574347, 29274521, 175609590}))
  stage_2_butterfly_47 (
    .x_in(stage_1_per_out[94]),
    .y_in(stage_1_per_out[95]),
    .x_out(stage_2_per_in[94]),
    .y_out(stage_2_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({78462606, 115957373, 70982951, 191727270}))
  stage_2_butterfly_48 (
    .x_in(stage_1_per_out[96]),
    .y_in(stage_1_per_out[97]),
    .x_out(stage_2_per_in[96]),
    .y_out(stage_2_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({78462606, 115957373, 70982951, 191727270}))
  stage_2_butterfly_49 (
    .x_in(stage_1_per_out[98]),
    .y_in(stage_1_per_out[99]),
    .x_out(stage_2_per_in[98]),
    .y_out(stage_2_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({78462606, 115957373, 70982951, 191727270}))
  stage_2_butterfly_50 (
    .x_in(stage_1_per_out[100]),
    .y_in(stage_1_per_out[101]),
    .x_out(stage_2_per_in[100]),
    .y_out(stage_2_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({78462606, 115957373, 70982951, 191727270}))
  stage_2_butterfly_51 (
    .x_in(stage_1_per_out[102]),
    .y_in(stage_1_per_out[103]),
    .x_out(stage_2_per_in[102]),
    .y_out(stage_2_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({233560477, 4690923, 119224607, 227285679}))
  stage_2_butterfly_52 (
    .x_in(stage_1_per_out[104]),
    .y_in(stage_1_per_out[105]),
    .x_out(stage_2_per_in[104]),
    .y_out(stage_2_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({233560477, 4690923, 119224607, 227285679}))
  stage_2_butterfly_53 (
    .x_in(stage_1_per_out[106]),
    .y_in(stage_1_per_out[107]),
    .x_out(stage_2_per_in[106]),
    .y_out(stage_2_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({233560477, 4690923, 119224607, 227285679}))
  stage_2_butterfly_54 (
    .x_in(stage_1_per_out[108]),
    .y_in(stage_1_per_out[109]),
    .x_out(stage_2_per_in[108]),
    .y_out(stage_2_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({233560477, 4690923, 119224607, 227285679}))
  stage_2_butterfly_55 (
    .x_in(stage_1_per_out[110]),
    .y_in(stage_1_per_out[111]),
    .x_out(stage_2_per_in[110]),
    .y_out(stage_2_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({153962078, 47317233, 169276669, 67307067}))
  stage_2_butterfly_56 (
    .x_in(stage_1_per_out[112]),
    .y_in(stage_1_per_out[113]),
    .x_out(stage_2_per_in[112]),
    .y_out(stage_2_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({153962078, 47317233, 169276669, 67307067}))
  stage_2_butterfly_57 (
    .x_in(stage_1_per_out[114]),
    .y_in(stage_1_per_out[115]),
    .x_out(stage_2_per_in[114]),
    .y_out(stage_2_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({153962078, 47317233, 169276669, 67307067}))
  stage_2_butterfly_58 (
    .x_in(stage_1_per_out[116]),
    .y_in(stage_1_per_out[117]),
    .x_out(stage_2_per_in[116]),
    .y_out(stage_2_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({153962078, 47317233, 169276669, 67307067}))
  stage_2_butterfly_59 (
    .x_in(stage_1_per_out[118]),
    .y_in(stage_1_per_out[119]),
    .x_out(stage_2_per_in[118]),
    .y_out(stage_2_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({11695616, 240684902, 126821849, 138074788}))
  stage_2_butterfly_60 (
    .x_in(stage_1_per_out[120]),
    .y_in(stage_1_per_out[121]),
    .x_out(stage_2_per_in[120]),
    .y_out(stage_2_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({11695616, 240684902, 126821849, 138074788}))
  stage_2_butterfly_61 (
    .x_in(stage_1_per_out[122]),
    .y_in(stage_1_per_out[123]),
    .x_out(stage_2_per_in[122]),
    .y_out(stage_2_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({11695616, 240684902, 126821849, 138074788}))
  stage_2_butterfly_62 (
    .x_in(stage_1_per_out[124]),
    .y_in(stage_1_per_out[125]),
    .x_out(stage_2_per_in[124]),
    .y_out(stage_2_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[2]),
    .factors({11695616, 240684902, 126821849, 138074788}))
  stage_2_butterfly_63 (
    .x_in(stage_1_per_out[126]),
    .y_in(stage_1_per_out[127]),
    .x_out(stage_2_per_in[126]),
    .y_out(stage_2_per_in[127]),
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
    .inData_64(stage_2_per_in[64]),
    .inData_65(stage_2_per_in[65]),
    .inData_66(stage_2_per_in[66]),
    .inData_67(stage_2_per_in[67]),
    .inData_68(stage_2_per_in[68]),
    .inData_69(stage_2_per_in[69]),
    .inData_70(stage_2_per_in[70]),
    .inData_71(stage_2_per_in[71]),
    .inData_72(stage_2_per_in[72]),
    .inData_73(stage_2_per_in[73]),
    .inData_74(stage_2_per_in[74]),
    .inData_75(stage_2_per_in[75]),
    .inData_76(stage_2_per_in[76]),
    .inData_77(stage_2_per_in[77]),
    .inData_78(stage_2_per_in[78]),
    .inData_79(stage_2_per_in[79]),
    .inData_80(stage_2_per_in[80]),
    .inData_81(stage_2_per_in[81]),
    .inData_82(stage_2_per_in[82]),
    .inData_83(stage_2_per_in[83]),
    .inData_84(stage_2_per_in[84]),
    .inData_85(stage_2_per_in[85]),
    .inData_86(stage_2_per_in[86]),
    .inData_87(stage_2_per_in[87]),
    .inData_88(stage_2_per_in[88]),
    .inData_89(stage_2_per_in[89]),
    .inData_90(stage_2_per_in[90]),
    .inData_91(stage_2_per_in[91]),
    .inData_92(stage_2_per_in[92]),
    .inData_93(stage_2_per_in[93]),
    .inData_94(stage_2_per_in[94]),
    .inData_95(stage_2_per_in[95]),
    .inData_96(stage_2_per_in[96]),
    .inData_97(stage_2_per_in[97]),
    .inData_98(stage_2_per_in[98]),
    .inData_99(stage_2_per_in[99]),
    .inData_100(stage_2_per_in[100]),
    .inData_101(stage_2_per_in[101]),
    .inData_102(stage_2_per_in[102]),
    .inData_103(stage_2_per_in[103]),
    .inData_104(stage_2_per_in[104]),
    .inData_105(stage_2_per_in[105]),
    .inData_106(stage_2_per_in[106]),
    .inData_107(stage_2_per_in[107]),
    .inData_108(stage_2_per_in[108]),
    .inData_109(stage_2_per_in[109]),
    .inData_110(stage_2_per_in[110]),
    .inData_111(stage_2_per_in[111]),
    .inData_112(stage_2_per_in[112]),
    .inData_113(stage_2_per_in[113]),
    .inData_114(stage_2_per_in[114]),
    .inData_115(stage_2_per_in[115]),
    .inData_116(stage_2_per_in[116]),
    .inData_117(stage_2_per_in[117]),
    .inData_118(stage_2_per_in[118]),
    .inData_119(stage_2_per_in[119]),
    .inData_120(stage_2_per_in[120]),
    .inData_121(stage_2_per_in[121]),
    .inData_122(stage_2_per_in[122]),
    .inData_123(stage_2_per_in[123]),
    .inData_124(stage_2_per_in[124]),
    .inData_125(stage_2_per_in[125]),
    .inData_126(stage_2_per_in[126]),
    .inData_127(stage_2_per_in[127]),
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
    .outData_64(stage_2_per_out[64]),
    .outData_65(stage_2_per_out[65]),
    .outData_66(stage_2_per_out[66]),
    .outData_67(stage_2_per_out[67]),
    .outData_68(stage_2_per_out[68]),
    .outData_69(stage_2_per_out[69]),
    .outData_70(stage_2_per_out[70]),
    .outData_71(stage_2_per_out[71]),
    .outData_72(stage_2_per_out[72]),
    .outData_73(stage_2_per_out[73]),
    .outData_74(stage_2_per_out[74]),
    .outData_75(stage_2_per_out[75]),
    .outData_76(stage_2_per_out[76]),
    .outData_77(stage_2_per_out[77]),
    .outData_78(stage_2_per_out[78]),
    .outData_79(stage_2_per_out[79]),
    .outData_80(stage_2_per_out[80]),
    .outData_81(stage_2_per_out[81]),
    .outData_82(stage_2_per_out[82]),
    .outData_83(stage_2_per_out[83]),
    .outData_84(stage_2_per_out[84]),
    .outData_85(stage_2_per_out[85]),
    .outData_86(stage_2_per_out[86]),
    .outData_87(stage_2_per_out[87]),
    .outData_88(stage_2_per_out[88]),
    .outData_89(stage_2_per_out[89]),
    .outData_90(stage_2_per_out[90]),
    .outData_91(stage_2_per_out[91]),
    .outData_92(stage_2_per_out[92]),
    .outData_93(stage_2_per_out[93]),
    .outData_94(stage_2_per_out[94]),
    .outData_95(stage_2_per_out[95]),
    .outData_96(stage_2_per_out[96]),
    .outData_97(stage_2_per_out[97]),
    .outData_98(stage_2_per_out[98]),
    .outData_99(stage_2_per_out[99]),
    .outData_100(stage_2_per_out[100]),
    .outData_101(stage_2_per_out[101]),
    .outData_102(stage_2_per_out[102]),
    .outData_103(stage_2_per_out[103]),
    .outData_104(stage_2_per_out[104]),
    .outData_105(stage_2_per_out[105]),
    .outData_106(stage_2_per_out[106]),
    .outData_107(stage_2_per_out[107]),
    .outData_108(stage_2_per_out[108]),
    .outData_109(stage_2_per_out[109]),
    .outData_110(stage_2_per_out[110]),
    .outData_111(stage_2_per_out[111]),
    .outData_112(stage_2_per_out[112]),
    .outData_113(stage_2_per_out[113]),
    .outData_114(stage_2_per_out[114]),
    .outData_115(stage_2_per_out[115]),
    .outData_116(stage_2_per_out[116]),
    .outData_117(stage_2_per_out[117]),
    .outData_118(stage_2_per_out[118]),
    .outData_119(stage_2_per_out[119]),
    .outData_120(stage_2_per_out[120]),
    .outData_121(stage_2_per_out[121]),
    .outData_122(stage_2_per_out[122]),
    .outData_123(stage_2_per_out[123]),
    .outData_124(stage_2_per_out[124]),
    .outData_125(stage_2_per_out[125]),
    .outData_126(stage_2_per_out[126]),
    .outData_127(stage_2_per_out[127]),
    .in_start(in_start[2]),
    .out_start(out_start[2]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Tian): stage 3 32 butterfly units
  butterfly #(
    .start(START_CYCLE[3]),
    .factors({216372172, 229105823, 165790423, 99790517}))
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
    .factors({216372172, 229105823, 165790423, 99790517}))
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
    .factors({216372172, 229105823, 165790423, 99790517}))
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
    .factors({216372172, 229105823, 165790423, 99790517}))
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
    .factors({216372172, 229105823, 165790423, 99790517}))
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
    .factors({216372172, 229105823, 165790423, 99790517}))
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
    .factors({216372172, 229105823, 165790423, 99790517}))
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
    .factors({216372172, 229105823, 165790423, 99790517}))
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
    .factors({221840088, 234642902, 148889498, 249836082}))
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
    .factors({221840088, 234642902, 148889498, 249836082}))
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
    .factors({221840088, 234642902, 148889498, 249836082}))
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
    .factors({221840088, 234642902, 148889498, 249836082}))
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
    .factors({221840088, 234642902, 148889498, 249836082}))
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
    .factors({221840088, 234642902, 148889498, 249836082}))
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
    .factors({221840088, 234642902, 148889498, 249836082}))
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
    .factors({221840088, 234642902, 148889498, 249836082}))
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
    .factors({36955649, 11699091, 129001811, 73825164}))
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
    .factors({36955649, 11699091, 129001811, 73825164}))
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
    .factors({36955649, 11699091, 129001811, 73825164}))
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
    .factors({36955649, 11699091, 129001811, 73825164}))
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
    .factors({36955649, 11699091, 129001811, 73825164}))
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
    .factors({36955649, 11699091, 129001811, 73825164}))
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
    .factors({36955649, 11699091, 129001811, 73825164}))
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
    .factors({36955649, 11699091, 129001811, 73825164}))
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
    .factors({94135184, 143639106, 196308904, 72052889}))
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
    .factors({94135184, 143639106, 196308904, 72052889}))
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
    .factors({94135184, 143639106, 196308904, 72052889}))
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
    .factors({94135184, 143639106, 196308904, 72052889}))
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
    .factors({94135184, 143639106, 196308904, 72052889}))
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
    .factors({94135184, 143639106, 196308904, 72052889}))
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
    .factors({94135184, 143639106, 196308904, 72052889}))
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
    .factors({94135184, 143639106, 196308904, 72052889}))
  stage_3_butterfly_31 (
    .x_in(stage_2_per_out[62]),
    .y_in(stage_2_per_out[63]),
    .x_out(stage_3_per_in[62]),
    .y_out(stage_3_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({160020761, 19095174, 265190919, 47877183}))
  stage_3_butterfly_32 (
    .x_in(stage_2_per_out[64]),
    .y_in(stage_2_per_out[65]),
    .x_out(stage_3_per_in[64]),
    .y_out(stage_3_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({160020761, 19095174, 265190919, 47877183}))
  stage_3_butterfly_33 (
    .x_in(stage_2_per_out[66]),
    .y_in(stage_2_per_out[67]),
    .x_out(stage_3_per_in[66]),
    .y_out(stage_3_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({160020761, 19095174, 265190919, 47877183}))
  stage_3_butterfly_34 (
    .x_in(stage_2_per_out[68]),
    .y_in(stage_2_per_out[69]),
    .x_out(stage_3_per_in[68]),
    .y_out(stage_3_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({160020761, 19095174, 265190919, 47877183}))
  stage_3_butterfly_35 (
    .x_in(stage_2_per_out[70]),
    .y_in(stage_2_per_out[71]),
    .x_out(stage_3_per_in[70]),
    .y_out(stage_3_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({160020761, 19095174, 265190919, 47877183}))
  stage_3_butterfly_36 (
    .x_in(stage_2_per_out[72]),
    .y_in(stage_2_per_out[73]),
    .x_out(stage_3_per_in[72]),
    .y_out(stage_3_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({160020761, 19095174, 265190919, 47877183}))
  stage_3_butterfly_37 (
    .x_in(stage_2_per_out[74]),
    .y_in(stage_2_per_out[75]),
    .x_out(stage_3_per_in[74]),
    .y_out(stage_3_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({160020761, 19095174, 265190919, 47877183}))
  stage_3_butterfly_38 (
    .x_in(stage_2_per_out[76]),
    .y_in(stage_2_per_out[77]),
    .x_out(stage_3_per_in[76]),
    .y_out(stage_3_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({160020761, 19095174, 265190919, 47877183}))
  stage_3_butterfly_39 (
    .x_in(stage_2_per_out[78]),
    .y_in(stage_2_per_out[79]),
    .x_out(stage_3_per_in[78]),
    .y_out(stage_3_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({183300662, 62061822, 165596304, 83571649}))
  stage_3_butterfly_40 (
    .x_in(stage_2_per_out[80]),
    .y_in(stage_2_per_out[81]),
    .x_out(stage_3_per_in[80]),
    .y_out(stage_3_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({183300662, 62061822, 165596304, 83571649}))
  stage_3_butterfly_41 (
    .x_in(stage_2_per_out[82]),
    .y_in(stage_2_per_out[83]),
    .x_out(stage_3_per_in[82]),
    .y_out(stage_3_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({183300662, 62061822, 165596304, 83571649}))
  stage_3_butterfly_42 (
    .x_in(stage_2_per_out[84]),
    .y_in(stage_2_per_out[85]),
    .x_out(stage_3_per_in[84]),
    .y_out(stage_3_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({183300662, 62061822, 165596304, 83571649}))
  stage_3_butterfly_43 (
    .x_in(stage_2_per_out[86]),
    .y_in(stage_2_per_out[87]),
    .x_out(stage_3_per_in[86]),
    .y_out(stage_3_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({183300662, 62061822, 165596304, 83571649}))
  stage_3_butterfly_44 (
    .x_in(stage_2_per_out[88]),
    .y_in(stage_2_per_out[89]),
    .x_out(stage_3_per_in[88]),
    .y_out(stage_3_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({183300662, 62061822, 165596304, 83571649}))
  stage_3_butterfly_45 (
    .x_in(stage_2_per_out[90]),
    .y_in(stage_2_per_out[91]),
    .x_out(stage_3_per_in[90]),
    .y_out(stage_3_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({183300662, 62061822, 165596304, 83571649}))
  stage_3_butterfly_46 (
    .x_in(stage_2_per_out[92]),
    .y_in(stage_2_per_out[93]),
    .x_out(stage_3_per_in[92]),
    .y_out(stage_3_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({183300662, 62061822, 165596304, 83571649}))
  stage_3_butterfly_47 (
    .x_in(stage_2_per_out[94]),
    .y_in(stage_2_per_out[95]),
    .x_out(stage_3_per_in[94]),
    .y_out(stage_3_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({47713731, 233080466, 84893967, 92744225}))
  stage_3_butterfly_48 (
    .x_in(stage_2_per_out[96]),
    .y_in(stage_2_per_out[97]),
    .x_out(stage_3_per_in[96]),
    .y_out(stage_3_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({47713731, 233080466, 84893967, 92744225}))
  stage_3_butterfly_49 (
    .x_in(stage_2_per_out[98]),
    .y_in(stage_2_per_out[99]),
    .x_out(stage_3_per_in[98]),
    .y_out(stage_3_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({47713731, 233080466, 84893967, 92744225}))
  stage_3_butterfly_50 (
    .x_in(stage_2_per_out[100]),
    .y_in(stage_2_per_out[101]),
    .x_out(stage_3_per_in[100]),
    .y_out(stage_3_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({47713731, 233080466, 84893967, 92744225}))
  stage_3_butterfly_51 (
    .x_in(stage_2_per_out[102]),
    .y_in(stage_2_per_out[103]),
    .x_out(stage_3_per_in[102]),
    .y_out(stage_3_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({47713731, 233080466, 84893967, 92744225}))
  stage_3_butterfly_52 (
    .x_in(stage_2_per_out[104]),
    .y_in(stage_2_per_out[105]),
    .x_out(stage_3_per_in[104]),
    .y_out(stage_3_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({47713731, 233080466, 84893967, 92744225}))
  stage_3_butterfly_53 (
    .x_in(stage_2_per_out[106]),
    .y_in(stage_2_per_out[107]),
    .x_out(stage_3_per_in[106]),
    .y_out(stage_3_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({47713731, 233080466, 84893967, 92744225}))
  stage_3_butterfly_54 (
    .x_in(stage_2_per_out[108]),
    .y_in(stage_2_per_out[109]),
    .x_out(stage_3_per_in[108]),
    .y_out(stage_3_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({47713731, 233080466, 84893967, 92744225}))
  stage_3_butterfly_55 (
    .x_in(stage_2_per_out[110]),
    .y_in(stage_2_per_out[111]),
    .x_out(stage_3_per_in[110]),
    .y_out(stage_3_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({178374402, 191796824, 210831626, 5258704}))
  stage_3_butterfly_56 (
    .x_in(stage_2_per_out[112]),
    .y_in(stage_2_per_out[113]),
    .x_out(stage_3_per_in[112]),
    .y_out(stage_3_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({178374402, 191796824, 210831626, 5258704}))
  stage_3_butterfly_57 (
    .x_in(stage_2_per_out[114]),
    .y_in(stage_2_per_out[115]),
    .x_out(stage_3_per_in[114]),
    .y_out(stage_3_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({178374402, 191796824, 210831626, 5258704}))
  stage_3_butterfly_58 (
    .x_in(stage_2_per_out[116]),
    .y_in(stage_2_per_out[117]),
    .x_out(stage_3_per_in[116]),
    .y_out(stage_3_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({178374402, 191796824, 210831626, 5258704}))
  stage_3_butterfly_59 (
    .x_in(stage_2_per_out[118]),
    .y_in(stage_2_per_out[119]),
    .x_out(stage_3_per_in[118]),
    .y_out(stage_3_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({178374402, 191796824, 210831626, 5258704}))
  stage_3_butterfly_60 (
    .x_in(stage_2_per_out[120]),
    .y_in(stage_2_per_out[121]),
    .x_out(stage_3_per_in[120]),
    .y_out(stage_3_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({178374402, 191796824, 210831626, 5258704}))
  stage_3_butterfly_61 (
    .x_in(stage_2_per_out[122]),
    .y_in(stage_2_per_out[123]),
    .x_out(stage_3_per_in[122]),
    .y_out(stage_3_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({178374402, 191796824, 210831626, 5258704}))
  stage_3_butterfly_62 (
    .x_in(stage_2_per_out[124]),
    .y_in(stage_2_per_out[125]),
    .x_out(stage_3_per_in[124]),
    .y_out(stage_3_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[3]),
    .factors({178374402, 191796824, 210831626, 5258704}))
  stage_3_butterfly_63 (
    .x_in(stage_2_per_out[126]),
    .y_in(stage_2_per_out[127]),
    .x_out(stage_3_per_in[126]),
    .y_out(stage_3_per_in[127]),
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
    .inData_64(stage_3_per_in[64]),
    .inData_65(stage_3_per_in[65]),
    .inData_66(stage_3_per_in[66]),
    .inData_67(stage_3_per_in[67]),
    .inData_68(stage_3_per_in[68]),
    .inData_69(stage_3_per_in[69]),
    .inData_70(stage_3_per_in[70]),
    .inData_71(stage_3_per_in[71]),
    .inData_72(stage_3_per_in[72]),
    .inData_73(stage_3_per_in[73]),
    .inData_74(stage_3_per_in[74]),
    .inData_75(stage_3_per_in[75]),
    .inData_76(stage_3_per_in[76]),
    .inData_77(stage_3_per_in[77]),
    .inData_78(stage_3_per_in[78]),
    .inData_79(stage_3_per_in[79]),
    .inData_80(stage_3_per_in[80]),
    .inData_81(stage_3_per_in[81]),
    .inData_82(stage_3_per_in[82]),
    .inData_83(stage_3_per_in[83]),
    .inData_84(stage_3_per_in[84]),
    .inData_85(stage_3_per_in[85]),
    .inData_86(stage_3_per_in[86]),
    .inData_87(stage_3_per_in[87]),
    .inData_88(stage_3_per_in[88]),
    .inData_89(stage_3_per_in[89]),
    .inData_90(stage_3_per_in[90]),
    .inData_91(stage_3_per_in[91]),
    .inData_92(stage_3_per_in[92]),
    .inData_93(stage_3_per_in[93]),
    .inData_94(stage_3_per_in[94]),
    .inData_95(stage_3_per_in[95]),
    .inData_96(stage_3_per_in[96]),
    .inData_97(stage_3_per_in[97]),
    .inData_98(stage_3_per_in[98]),
    .inData_99(stage_3_per_in[99]),
    .inData_100(stage_3_per_in[100]),
    .inData_101(stage_3_per_in[101]),
    .inData_102(stage_3_per_in[102]),
    .inData_103(stage_3_per_in[103]),
    .inData_104(stage_3_per_in[104]),
    .inData_105(stage_3_per_in[105]),
    .inData_106(stage_3_per_in[106]),
    .inData_107(stage_3_per_in[107]),
    .inData_108(stage_3_per_in[108]),
    .inData_109(stage_3_per_in[109]),
    .inData_110(stage_3_per_in[110]),
    .inData_111(stage_3_per_in[111]),
    .inData_112(stage_3_per_in[112]),
    .inData_113(stage_3_per_in[113]),
    .inData_114(stage_3_per_in[114]),
    .inData_115(stage_3_per_in[115]),
    .inData_116(stage_3_per_in[116]),
    .inData_117(stage_3_per_in[117]),
    .inData_118(stage_3_per_in[118]),
    .inData_119(stage_3_per_in[119]),
    .inData_120(stage_3_per_in[120]),
    .inData_121(stage_3_per_in[121]),
    .inData_122(stage_3_per_in[122]),
    .inData_123(stage_3_per_in[123]),
    .inData_124(stage_3_per_in[124]),
    .inData_125(stage_3_per_in[125]),
    .inData_126(stage_3_per_in[126]),
    .inData_127(stage_3_per_in[127]),
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
    .outData_64(stage_3_per_out[64]),
    .outData_65(stage_3_per_out[65]),
    .outData_66(stage_3_per_out[66]),
    .outData_67(stage_3_per_out[67]),
    .outData_68(stage_3_per_out[68]),
    .outData_69(stage_3_per_out[69]),
    .outData_70(stage_3_per_out[70]),
    .outData_71(stage_3_per_out[71]),
    .outData_72(stage_3_per_out[72]),
    .outData_73(stage_3_per_out[73]),
    .outData_74(stage_3_per_out[74]),
    .outData_75(stage_3_per_out[75]),
    .outData_76(stage_3_per_out[76]),
    .outData_77(stage_3_per_out[77]),
    .outData_78(stage_3_per_out[78]),
    .outData_79(stage_3_per_out[79]),
    .outData_80(stage_3_per_out[80]),
    .outData_81(stage_3_per_out[81]),
    .outData_82(stage_3_per_out[82]),
    .outData_83(stage_3_per_out[83]),
    .outData_84(stage_3_per_out[84]),
    .outData_85(stage_3_per_out[85]),
    .outData_86(stage_3_per_out[86]),
    .outData_87(stage_3_per_out[87]),
    .outData_88(stage_3_per_out[88]),
    .outData_89(stage_3_per_out[89]),
    .outData_90(stage_3_per_out[90]),
    .outData_91(stage_3_per_out[91]),
    .outData_92(stage_3_per_out[92]),
    .outData_93(stage_3_per_out[93]),
    .outData_94(stage_3_per_out[94]),
    .outData_95(stage_3_per_out[95]),
    .outData_96(stage_3_per_out[96]),
    .outData_97(stage_3_per_out[97]),
    .outData_98(stage_3_per_out[98]),
    .outData_99(stage_3_per_out[99]),
    .outData_100(stage_3_per_out[100]),
    .outData_101(stage_3_per_out[101]),
    .outData_102(stage_3_per_out[102]),
    .outData_103(stage_3_per_out[103]),
    .outData_104(stage_3_per_out[104]),
    .outData_105(stage_3_per_out[105]),
    .outData_106(stage_3_per_out[106]),
    .outData_107(stage_3_per_out[107]),
    .outData_108(stage_3_per_out[108]),
    .outData_109(stage_3_per_out[109]),
    .outData_110(stage_3_per_out[110]),
    .outData_111(stage_3_per_out[111]),
    .outData_112(stage_3_per_out[112]),
    .outData_113(stage_3_per_out[113]),
    .outData_114(stage_3_per_out[114]),
    .outData_115(stage_3_per_out[115]),
    .outData_116(stage_3_per_out[116]),
    .outData_117(stage_3_per_out[117]),
    .outData_118(stage_3_per_out[118]),
    .outData_119(stage_3_per_out[119]),
    .outData_120(stage_3_per_out[120]),
    .outData_121(stage_3_per_out[121]),
    .outData_122(stage_3_per_out[122]),
    .outData_123(stage_3_per_out[123]),
    .outData_124(stage_3_per_out[124]),
    .outData_125(stage_3_per_out[125]),
    .outData_126(stage_3_per_out[126]),
    .outData_127(stage_3_per_out[127]),
    .in_start(in_start[3]),
    .out_start(out_start[3]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 4 32 butterfly units
  butterfly #(
    .start(START_CYCLE[4]),
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({135333989, 131414476, 142393906, 112745081}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
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
    .factors({225387856, 70516281, 69075086, 260567810}))
  stage_4_butterfly_31 (
    .x_in(stage_3_per_out[62]),
    .y_in(stage_3_per_out[63]),
    .x_out(stage_4_per_in[62]),
    .y_out(stage_4_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_32 (
    .x_in(stage_3_per_out[64]),
    .y_in(stage_3_per_out[65]),
    .x_out(stage_4_per_in[64]),
    .y_out(stage_4_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_33 (
    .x_in(stage_3_per_out[66]),
    .y_in(stage_3_per_out[67]),
    .x_out(stage_4_per_in[66]),
    .y_out(stage_4_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_34 (
    .x_in(stage_3_per_out[68]),
    .y_in(stage_3_per_out[69]),
    .x_out(stage_4_per_in[68]),
    .y_out(stage_4_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_35 (
    .x_in(stage_3_per_out[70]),
    .y_in(stage_3_per_out[71]),
    .x_out(stage_4_per_in[70]),
    .y_out(stage_4_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_36 (
    .x_in(stage_3_per_out[72]),
    .y_in(stage_3_per_out[73]),
    .x_out(stage_4_per_in[72]),
    .y_out(stage_4_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_37 (
    .x_in(stage_3_per_out[74]),
    .y_in(stage_3_per_out[75]),
    .x_out(stage_4_per_in[74]),
    .y_out(stage_4_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_38 (
    .x_in(stage_3_per_out[76]),
    .y_in(stage_3_per_out[77]),
    .x_out(stage_4_per_in[76]),
    .y_out(stage_4_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_39 (
    .x_in(stage_3_per_out[78]),
    .y_in(stage_3_per_out[79]),
    .x_out(stage_4_per_in[78]),
    .y_out(stage_4_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_40 (
    .x_in(stage_3_per_out[80]),
    .y_in(stage_3_per_out[81]),
    .x_out(stage_4_per_in[80]),
    .y_out(stage_4_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_41 (
    .x_in(stage_3_per_out[82]),
    .y_in(stage_3_per_out[83]),
    .x_out(stage_4_per_in[82]),
    .y_out(stage_4_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_42 (
    .x_in(stage_3_per_out[84]),
    .y_in(stage_3_per_out[85]),
    .x_out(stage_4_per_in[84]),
    .y_out(stage_4_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_43 (
    .x_in(stage_3_per_out[86]),
    .y_in(stage_3_per_out[87]),
    .x_out(stage_4_per_in[86]),
    .y_out(stage_4_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_44 (
    .x_in(stage_3_per_out[88]),
    .y_in(stage_3_per_out[89]),
    .x_out(stage_4_per_in[88]),
    .y_out(stage_4_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_45 (
    .x_in(stage_3_per_out[90]),
    .y_in(stage_3_per_out[91]),
    .x_out(stage_4_per_in[90]),
    .y_out(stage_4_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_46 (
    .x_in(stage_3_per_out[92]),
    .y_in(stage_3_per_out[93]),
    .x_out(stage_4_per_in[92]),
    .y_out(stage_4_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({194721725, 46265048, 47600907, 134587162}))
  stage_4_butterfly_47 (
    .x_in(stage_3_per_out[94]),
    .y_in(stage_3_per_out[95]),
    .x_out(stage_4_per_in[94]),
    .y_out(stage_4_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_48 (
    .x_in(stage_3_per_out[96]),
    .y_in(stage_3_per_out[97]),
    .x_out(stage_4_per_in[96]),
    .y_out(stage_4_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_49 (
    .x_in(stage_3_per_out[98]),
    .y_in(stage_3_per_out[99]),
    .x_out(stage_4_per_in[98]),
    .y_out(stage_4_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_50 (
    .x_in(stage_3_per_out[100]),
    .y_in(stage_3_per_out[101]),
    .x_out(stage_4_per_in[100]),
    .y_out(stage_4_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_51 (
    .x_in(stage_3_per_out[102]),
    .y_in(stage_3_per_out[103]),
    .x_out(stage_4_per_in[102]),
    .y_out(stage_4_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_52 (
    .x_in(stage_3_per_out[104]),
    .y_in(stage_3_per_out[105]),
    .x_out(stage_4_per_in[104]),
    .y_out(stage_4_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_53 (
    .x_in(stage_3_per_out[106]),
    .y_in(stage_3_per_out[107]),
    .x_out(stage_4_per_in[106]),
    .y_out(stage_4_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_54 (
    .x_in(stage_3_per_out[108]),
    .y_in(stage_3_per_out[109]),
    .x_out(stage_4_per_in[108]),
    .y_out(stage_4_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_55 (
    .x_in(stage_3_per_out[110]),
    .y_in(stage_3_per_out[111]),
    .x_out(stage_4_per_in[110]),
    .y_out(stage_4_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_56 (
    .x_in(stage_3_per_out[112]),
    .y_in(stage_3_per_out[113]),
    .x_out(stage_4_per_in[112]),
    .y_out(stage_4_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_57 (
    .x_in(stage_3_per_out[114]),
    .y_in(stage_3_per_out[115]),
    .x_out(stage_4_per_in[114]),
    .y_out(stage_4_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_58 (
    .x_in(stage_3_per_out[116]),
    .y_in(stage_3_per_out[117]),
    .x_out(stage_4_per_in[116]),
    .y_out(stage_4_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_59 (
    .x_in(stage_3_per_out[118]),
    .y_in(stage_3_per_out[119]),
    .x_out(stage_4_per_in[118]),
    .y_out(stage_4_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_60 (
    .x_in(stage_3_per_out[120]),
    .y_in(stage_3_per_out[121]),
    .x_out(stage_4_per_in[120]),
    .y_out(stage_4_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_61 (
    .x_in(stage_3_per_out[122]),
    .y_in(stage_3_per_out[123]),
    .x_out(stage_4_per_in[122]),
    .y_out(stage_4_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_62 (
    .x_in(stage_3_per_out[124]),
    .y_in(stage_3_per_out[125]),
    .x_out(stage_4_per_in[124]),
    .y_out(stage_4_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[4]),
    .factors({105312654, 242569099, 234985940, 210749829}))
  stage_4_butterfly_63 (
    .x_in(stage_3_per_out[126]),
    .y_in(stage_3_per_out[127]),
    .x_out(stage_4_per_in[126]),
    .y_out(stage_4_per_in[127]),
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
    .inData_64(stage_4_per_in[64]),
    .inData_65(stage_4_per_in[65]),
    .inData_66(stage_4_per_in[66]),
    .inData_67(stage_4_per_in[67]),
    .inData_68(stage_4_per_in[68]),
    .inData_69(stage_4_per_in[69]),
    .inData_70(stage_4_per_in[70]),
    .inData_71(stage_4_per_in[71]),
    .inData_72(stage_4_per_in[72]),
    .inData_73(stage_4_per_in[73]),
    .inData_74(stage_4_per_in[74]),
    .inData_75(stage_4_per_in[75]),
    .inData_76(stage_4_per_in[76]),
    .inData_77(stage_4_per_in[77]),
    .inData_78(stage_4_per_in[78]),
    .inData_79(stage_4_per_in[79]),
    .inData_80(stage_4_per_in[80]),
    .inData_81(stage_4_per_in[81]),
    .inData_82(stage_4_per_in[82]),
    .inData_83(stage_4_per_in[83]),
    .inData_84(stage_4_per_in[84]),
    .inData_85(stage_4_per_in[85]),
    .inData_86(stage_4_per_in[86]),
    .inData_87(stage_4_per_in[87]),
    .inData_88(stage_4_per_in[88]),
    .inData_89(stage_4_per_in[89]),
    .inData_90(stage_4_per_in[90]),
    .inData_91(stage_4_per_in[91]),
    .inData_92(stage_4_per_in[92]),
    .inData_93(stage_4_per_in[93]),
    .inData_94(stage_4_per_in[94]),
    .inData_95(stage_4_per_in[95]),
    .inData_96(stage_4_per_in[96]),
    .inData_97(stage_4_per_in[97]),
    .inData_98(stage_4_per_in[98]),
    .inData_99(stage_4_per_in[99]),
    .inData_100(stage_4_per_in[100]),
    .inData_101(stage_4_per_in[101]),
    .inData_102(stage_4_per_in[102]),
    .inData_103(stage_4_per_in[103]),
    .inData_104(stage_4_per_in[104]),
    .inData_105(stage_4_per_in[105]),
    .inData_106(stage_4_per_in[106]),
    .inData_107(stage_4_per_in[107]),
    .inData_108(stage_4_per_in[108]),
    .inData_109(stage_4_per_in[109]),
    .inData_110(stage_4_per_in[110]),
    .inData_111(stage_4_per_in[111]),
    .inData_112(stage_4_per_in[112]),
    .inData_113(stage_4_per_in[113]),
    .inData_114(stage_4_per_in[114]),
    .inData_115(stage_4_per_in[115]),
    .inData_116(stage_4_per_in[116]),
    .inData_117(stage_4_per_in[117]),
    .inData_118(stage_4_per_in[118]),
    .inData_119(stage_4_per_in[119]),
    .inData_120(stage_4_per_in[120]),
    .inData_121(stage_4_per_in[121]),
    .inData_122(stage_4_per_in[122]),
    .inData_123(stage_4_per_in[123]),
    .inData_124(stage_4_per_in[124]),
    .inData_125(stage_4_per_in[125]),
    .inData_126(stage_4_per_in[126]),
    .inData_127(stage_4_per_in[127]),
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
    .outData_64(stage_4_per_out[64]),
    .outData_65(stage_4_per_out[65]),
    .outData_66(stage_4_per_out[66]),
    .outData_67(stage_4_per_out[67]),
    .outData_68(stage_4_per_out[68]),
    .outData_69(stage_4_per_out[69]),
    .outData_70(stage_4_per_out[70]),
    .outData_71(stage_4_per_out[71]),
    .outData_72(stage_4_per_out[72]),
    .outData_73(stage_4_per_out[73]),
    .outData_74(stage_4_per_out[74]),
    .outData_75(stage_4_per_out[75]),
    .outData_76(stage_4_per_out[76]),
    .outData_77(stage_4_per_out[77]),
    .outData_78(stage_4_per_out[78]),
    .outData_79(stage_4_per_out[79]),
    .outData_80(stage_4_per_out[80]),
    .outData_81(stage_4_per_out[81]),
    .outData_82(stage_4_per_out[82]),
    .outData_83(stage_4_per_out[83]),
    .outData_84(stage_4_per_out[84]),
    .outData_85(stage_4_per_out[85]),
    .outData_86(stage_4_per_out[86]),
    .outData_87(stage_4_per_out[87]),
    .outData_88(stage_4_per_out[88]),
    .outData_89(stage_4_per_out[89]),
    .outData_90(stage_4_per_out[90]),
    .outData_91(stage_4_per_out[91]),
    .outData_92(stage_4_per_out[92]),
    .outData_93(stage_4_per_out[93]),
    .outData_94(stage_4_per_out[94]),
    .outData_95(stage_4_per_out[95]),
    .outData_96(stage_4_per_out[96]),
    .outData_97(stage_4_per_out[97]),
    .outData_98(stage_4_per_out[98]),
    .outData_99(stage_4_per_out[99]),
    .outData_100(stage_4_per_out[100]),
    .outData_101(stage_4_per_out[101]),
    .outData_102(stage_4_per_out[102]),
    .outData_103(stage_4_per_out[103]),
    .outData_104(stage_4_per_out[104]),
    .outData_105(stage_4_per_out[105]),
    .outData_106(stage_4_per_out[106]),
    .outData_107(stage_4_per_out[107]),
    .outData_108(stage_4_per_out[108]),
    .outData_109(stage_4_per_out[109]),
    .outData_110(stage_4_per_out[110]),
    .outData_111(stage_4_per_out[111]),
    .outData_112(stage_4_per_out[112]),
    .outData_113(stage_4_per_out[113]),
    .outData_114(stage_4_per_out[114]),
    .outData_115(stage_4_per_out[115]),
    .outData_116(stage_4_per_out[116]),
    .outData_117(stage_4_per_out[117]),
    .outData_118(stage_4_per_out[118]),
    .outData_119(stage_4_per_out[119]),
    .outData_120(stage_4_per_out[120]),
    .outData_121(stage_4_per_out[121]),
    .outData_122(stage_4_per_out[122]),
    .outData_123(stage_4_per_out[123]),
    .outData_124(stage_4_per_out[124]),
    .outData_125(stage_4_per_out[125]),
    .outData_126(stage_4_per_out[126]),
    .outData_127(stage_4_per_out[127]),
    .in_start(in_start[4]),
    .out_start(out_start[4]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 5 32 butterfly units
  butterfly #(
    .start(START_CYCLE[5]),
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
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
    .factors({87759933, 137531660, 105446074, 71274504}))
  stage_5_butterfly_31 (
    .x_in(stage_4_per_out[62]),
    .y_in(stage_4_per_out[63]),
    .x_out(stage_5_per_in[62]),
    .y_out(stage_5_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_32 (
    .x_in(stage_4_per_out[64]),
    .y_in(stage_4_per_out[65]),
    .x_out(stage_5_per_in[64]),
    .y_out(stage_5_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_33 (
    .x_in(stage_4_per_out[66]),
    .y_in(stage_4_per_out[67]),
    .x_out(stage_5_per_in[66]),
    .y_out(stage_5_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_34 (
    .x_in(stage_4_per_out[68]),
    .y_in(stage_4_per_out[69]),
    .x_out(stage_5_per_in[68]),
    .y_out(stage_5_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_35 (
    .x_in(stage_4_per_out[70]),
    .y_in(stage_4_per_out[71]),
    .x_out(stage_5_per_in[70]),
    .y_out(stage_5_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_36 (
    .x_in(stage_4_per_out[72]),
    .y_in(stage_4_per_out[73]),
    .x_out(stage_5_per_in[72]),
    .y_out(stage_5_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_37 (
    .x_in(stage_4_per_out[74]),
    .y_in(stage_4_per_out[75]),
    .x_out(stage_5_per_in[74]),
    .y_out(stage_5_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_38 (
    .x_in(stage_4_per_out[76]),
    .y_in(stage_4_per_out[77]),
    .x_out(stage_5_per_in[76]),
    .y_out(stage_5_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_39 (
    .x_in(stage_4_per_out[78]),
    .y_in(stage_4_per_out[79]),
    .x_out(stage_5_per_in[78]),
    .y_out(stage_5_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_40 (
    .x_in(stage_4_per_out[80]),
    .y_in(stage_4_per_out[81]),
    .x_out(stage_5_per_in[80]),
    .y_out(stage_5_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_41 (
    .x_in(stage_4_per_out[82]),
    .y_in(stage_4_per_out[83]),
    .x_out(stage_5_per_in[82]),
    .y_out(stage_5_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_42 (
    .x_in(stage_4_per_out[84]),
    .y_in(stage_4_per_out[85]),
    .x_out(stage_5_per_in[84]),
    .y_out(stage_5_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_43 (
    .x_in(stage_4_per_out[86]),
    .y_in(stage_4_per_out[87]),
    .x_out(stage_5_per_in[86]),
    .y_out(stage_5_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_44 (
    .x_in(stage_4_per_out[88]),
    .y_in(stage_4_per_out[89]),
    .x_out(stage_5_per_in[88]),
    .y_out(stage_5_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_45 (
    .x_in(stage_4_per_out[90]),
    .y_in(stage_4_per_out[91]),
    .x_out(stage_5_per_in[90]),
    .y_out(stage_5_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_46 (
    .x_in(stage_4_per_out[92]),
    .y_in(stage_4_per_out[93]),
    .x_out(stage_5_per_in[92]),
    .y_out(stage_5_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_47 (
    .x_in(stage_4_per_out[94]),
    .y_in(stage_4_per_out[95]),
    .x_out(stage_5_per_in[94]),
    .y_out(stage_5_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_48 (
    .x_in(stage_4_per_out[96]),
    .y_in(stage_4_per_out[97]),
    .x_out(stage_5_per_in[96]),
    .y_out(stage_5_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_49 (
    .x_in(stage_4_per_out[98]),
    .y_in(stage_4_per_out[99]),
    .x_out(stage_5_per_in[98]),
    .y_out(stage_5_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_50 (
    .x_in(stage_4_per_out[100]),
    .y_in(stage_4_per_out[101]),
    .x_out(stage_5_per_in[100]),
    .y_out(stage_5_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_51 (
    .x_in(stage_4_per_out[102]),
    .y_in(stage_4_per_out[103]),
    .x_out(stage_5_per_in[102]),
    .y_out(stage_5_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_52 (
    .x_in(stage_4_per_out[104]),
    .y_in(stage_4_per_out[105]),
    .x_out(stage_5_per_in[104]),
    .y_out(stage_5_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_53 (
    .x_in(stage_4_per_out[106]),
    .y_in(stage_4_per_out[107]),
    .x_out(stage_5_per_in[106]),
    .y_out(stage_5_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_54 (
    .x_in(stage_4_per_out[108]),
    .y_in(stage_4_per_out[109]),
    .x_out(stage_5_per_in[108]),
    .y_out(stage_5_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_55 (
    .x_in(stage_4_per_out[110]),
    .y_in(stage_4_per_out[111]),
    .x_out(stage_5_per_in[110]),
    .y_out(stage_5_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_56 (
    .x_in(stage_4_per_out[112]),
    .y_in(stage_4_per_out[113]),
    .x_out(stage_5_per_in[112]),
    .y_out(stage_5_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_57 (
    .x_in(stage_4_per_out[114]),
    .y_in(stage_4_per_out[115]),
    .x_out(stage_5_per_in[114]),
    .y_out(stage_5_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_58 (
    .x_in(stage_4_per_out[116]),
    .y_in(stage_4_per_out[117]),
    .x_out(stage_5_per_in[116]),
    .y_out(stage_5_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_59 (
    .x_in(stage_4_per_out[118]),
    .y_in(stage_4_per_out[119]),
    .x_out(stage_5_per_in[118]),
    .y_out(stage_5_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_60 (
    .x_in(stage_4_per_out[120]),
    .y_in(stage_4_per_out[121]),
    .x_out(stage_5_per_in[120]),
    .y_out(stage_5_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_61 (
    .x_in(stage_4_per_out[122]),
    .y_in(stage_4_per_out[123]),
    .x_out(stage_5_per_in[122]),
    .y_out(stage_5_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_62 (
    .x_in(stage_4_per_out[124]),
    .y_in(stage_4_per_out[125]),
    .x_out(stage_5_per_in[124]),
    .y_out(stage_5_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[5]),
    .factors({96332896, 48587502, 177699333, 140261680}))
  stage_5_butterfly_63 (
    .x_in(stage_4_per_out[126]),
    .y_in(stage_4_per_out[127]),
    .x_out(stage_5_per_in[126]),
    .y_out(stage_5_per_in[127]),
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
    .inData_64(stage_5_per_in[64]),
    .inData_65(stage_5_per_in[65]),
    .inData_66(stage_5_per_in[66]),
    .inData_67(stage_5_per_in[67]),
    .inData_68(stage_5_per_in[68]),
    .inData_69(stage_5_per_in[69]),
    .inData_70(stage_5_per_in[70]),
    .inData_71(stage_5_per_in[71]),
    .inData_72(stage_5_per_in[72]),
    .inData_73(stage_5_per_in[73]),
    .inData_74(stage_5_per_in[74]),
    .inData_75(stage_5_per_in[75]),
    .inData_76(stage_5_per_in[76]),
    .inData_77(stage_5_per_in[77]),
    .inData_78(stage_5_per_in[78]),
    .inData_79(stage_5_per_in[79]),
    .inData_80(stage_5_per_in[80]),
    .inData_81(stage_5_per_in[81]),
    .inData_82(stage_5_per_in[82]),
    .inData_83(stage_5_per_in[83]),
    .inData_84(stage_5_per_in[84]),
    .inData_85(stage_5_per_in[85]),
    .inData_86(stage_5_per_in[86]),
    .inData_87(stage_5_per_in[87]),
    .inData_88(stage_5_per_in[88]),
    .inData_89(stage_5_per_in[89]),
    .inData_90(stage_5_per_in[90]),
    .inData_91(stage_5_per_in[91]),
    .inData_92(stage_5_per_in[92]),
    .inData_93(stage_5_per_in[93]),
    .inData_94(stage_5_per_in[94]),
    .inData_95(stage_5_per_in[95]),
    .inData_96(stage_5_per_in[96]),
    .inData_97(stage_5_per_in[97]),
    .inData_98(stage_5_per_in[98]),
    .inData_99(stage_5_per_in[99]),
    .inData_100(stage_5_per_in[100]),
    .inData_101(stage_5_per_in[101]),
    .inData_102(stage_5_per_in[102]),
    .inData_103(stage_5_per_in[103]),
    .inData_104(stage_5_per_in[104]),
    .inData_105(stage_5_per_in[105]),
    .inData_106(stage_5_per_in[106]),
    .inData_107(stage_5_per_in[107]),
    .inData_108(stage_5_per_in[108]),
    .inData_109(stage_5_per_in[109]),
    .inData_110(stage_5_per_in[110]),
    .inData_111(stage_5_per_in[111]),
    .inData_112(stage_5_per_in[112]),
    .inData_113(stage_5_per_in[113]),
    .inData_114(stage_5_per_in[114]),
    .inData_115(stage_5_per_in[115]),
    .inData_116(stage_5_per_in[116]),
    .inData_117(stage_5_per_in[117]),
    .inData_118(stage_5_per_in[118]),
    .inData_119(stage_5_per_in[119]),
    .inData_120(stage_5_per_in[120]),
    .inData_121(stage_5_per_in[121]),
    .inData_122(stage_5_per_in[122]),
    .inData_123(stage_5_per_in[123]),
    .inData_124(stage_5_per_in[124]),
    .inData_125(stage_5_per_in[125]),
    .inData_126(stage_5_per_in[126]),
    .inData_127(stage_5_per_in[127]),
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
    .outData_64(stage_5_per_out[64]),
    .outData_65(stage_5_per_out[65]),
    .outData_66(stage_5_per_out[66]),
    .outData_67(stage_5_per_out[67]),
    .outData_68(stage_5_per_out[68]),
    .outData_69(stage_5_per_out[69]),
    .outData_70(stage_5_per_out[70]),
    .outData_71(stage_5_per_out[71]),
    .outData_72(stage_5_per_out[72]),
    .outData_73(stage_5_per_out[73]),
    .outData_74(stage_5_per_out[74]),
    .outData_75(stage_5_per_out[75]),
    .outData_76(stage_5_per_out[76]),
    .outData_77(stage_5_per_out[77]),
    .outData_78(stage_5_per_out[78]),
    .outData_79(stage_5_per_out[79]),
    .outData_80(stage_5_per_out[80]),
    .outData_81(stage_5_per_out[81]),
    .outData_82(stage_5_per_out[82]),
    .outData_83(stage_5_per_out[83]),
    .outData_84(stage_5_per_out[84]),
    .outData_85(stage_5_per_out[85]),
    .outData_86(stage_5_per_out[86]),
    .outData_87(stage_5_per_out[87]),
    .outData_88(stage_5_per_out[88]),
    .outData_89(stage_5_per_out[89]),
    .outData_90(stage_5_per_out[90]),
    .outData_91(stage_5_per_out[91]),
    .outData_92(stage_5_per_out[92]),
    .outData_93(stage_5_per_out[93]),
    .outData_94(stage_5_per_out[94]),
    .outData_95(stage_5_per_out[95]),
    .outData_96(stage_5_per_out[96]),
    .outData_97(stage_5_per_out[97]),
    .outData_98(stage_5_per_out[98]),
    .outData_99(stage_5_per_out[99]),
    .outData_100(stage_5_per_out[100]),
    .outData_101(stage_5_per_out[101]),
    .outData_102(stage_5_per_out[102]),
    .outData_103(stage_5_per_out[103]),
    .outData_104(stage_5_per_out[104]),
    .outData_105(stage_5_per_out[105]),
    .outData_106(stage_5_per_out[106]),
    .outData_107(stage_5_per_out[107]),
    .outData_108(stage_5_per_out[108]),
    .outData_109(stage_5_per_out[109]),
    .outData_110(stage_5_per_out[110]),
    .outData_111(stage_5_per_out[111]),
    .outData_112(stage_5_per_out[112]),
    .outData_113(stage_5_per_out[113]),
    .outData_114(stage_5_per_out[114]),
    .outData_115(stage_5_per_out[115]),
    .outData_116(stage_5_per_out[116]),
    .outData_117(stage_5_per_out[117]),
    .outData_118(stage_5_per_out[118]),
    .outData_119(stage_5_per_out[119]),
    .outData_120(stage_5_per_out[120]),
    .outData_121(stage_5_per_out[121]),
    .outData_122(stage_5_per_out[122]),
    .outData_123(stage_5_per_out[123]),
    .outData_124(stage_5_per_out[124]),
    .outData_125(stage_5_per_out[125]),
    .outData_126(stage_5_per_out[126]),
    .outData_127(stage_5_per_out[127]),
    .in_start(in_start[5]),
    .out_start(out_start[5]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 6 32 butterfly units
  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
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
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_31 (
    .x_in(stage_5_per_out[62]),
    .y_in(stage_5_per_out[63]),
    .x_out(stage_6_per_in[62]),
    .y_out(stage_6_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_32 (
    .x_in(stage_5_per_out[64]),
    .y_in(stage_5_per_out[65]),
    .x_out(stage_6_per_in[64]),
    .y_out(stage_6_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_33 (
    .x_in(stage_5_per_out[66]),
    .y_in(stage_5_per_out[67]),
    .x_out(stage_6_per_in[66]),
    .y_out(stage_6_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_34 (
    .x_in(stage_5_per_out[68]),
    .y_in(stage_5_per_out[69]),
    .x_out(stage_6_per_in[68]),
    .y_out(stage_6_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_35 (
    .x_in(stage_5_per_out[70]),
    .y_in(stage_5_per_out[71]),
    .x_out(stage_6_per_in[70]),
    .y_out(stage_6_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_36 (
    .x_in(stage_5_per_out[72]),
    .y_in(stage_5_per_out[73]),
    .x_out(stage_6_per_in[72]),
    .y_out(stage_6_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_37 (
    .x_in(stage_5_per_out[74]),
    .y_in(stage_5_per_out[75]),
    .x_out(stage_6_per_in[74]),
    .y_out(stage_6_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_38 (
    .x_in(stage_5_per_out[76]),
    .y_in(stage_5_per_out[77]),
    .x_out(stage_6_per_in[76]),
    .y_out(stage_6_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_39 (
    .x_in(stage_5_per_out[78]),
    .y_in(stage_5_per_out[79]),
    .x_out(stage_6_per_in[78]),
    .y_out(stage_6_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_40 (
    .x_in(stage_5_per_out[80]),
    .y_in(stage_5_per_out[81]),
    .x_out(stage_6_per_in[80]),
    .y_out(stage_6_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_41 (
    .x_in(stage_5_per_out[82]),
    .y_in(stage_5_per_out[83]),
    .x_out(stage_6_per_in[82]),
    .y_out(stage_6_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_42 (
    .x_in(stage_5_per_out[84]),
    .y_in(stage_5_per_out[85]),
    .x_out(stage_6_per_in[84]),
    .y_out(stage_6_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_43 (
    .x_in(stage_5_per_out[86]),
    .y_in(stage_5_per_out[87]),
    .x_out(stage_6_per_in[86]),
    .y_out(stage_6_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_44 (
    .x_in(stage_5_per_out[88]),
    .y_in(stage_5_per_out[89]),
    .x_out(stage_6_per_in[88]),
    .y_out(stage_6_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_45 (
    .x_in(stage_5_per_out[90]),
    .y_in(stage_5_per_out[91]),
    .x_out(stage_6_per_in[90]),
    .y_out(stage_6_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_46 (
    .x_in(stage_5_per_out[92]),
    .y_in(stage_5_per_out[93]),
    .x_out(stage_6_per_in[92]),
    .y_out(stage_6_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_47 (
    .x_in(stage_5_per_out[94]),
    .y_in(stage_5_per_out[95]),
    .x_out(stage_6_per_in[94]),
    .y_out(stage_6_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_48 (
    .x_in(stage_5_per_out[96]),
    .y_in(stage_5_per_out[97]),
    .x_out(stage_6_per_in[96]),
    .y_out(stage_6_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_49 (
    .x_in(stage_5_per_out[98]),
    .y_in(stage_5_per_out[99]),
    .x_out(stage_6_per_in[98]),
    .y_out(stage_6_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_50 (
    .x_in(stage_5_per_out[100]),
    .y_in(stage_5_per_out[101]),
    .x_out(stage_6_per_in[100]),
    .y_out(stage_6_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_51 (
    .x_in(stage_5_per_out[102]),
    .y_in(stage_5_per_out[103]),
    .x_out(stage_6_per_in[102]),
    .y_out(stage_6_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_52 (
    .x_in(stage_5_per_out[104]),
    .y_in(stage_5_per_out[105]),
    .x_out(stage_6_per_in[104]),
    .y_out(stage_6_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_53 (
    .x_in(stage_5_per_out[106]),
    .y_in(stage_5_per_out[107]),
    .x_out(stage_6_per_in[106]),
    .y_out(stage_6_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_54 (
    .x_in(stage_5_per_out[108]),
    .y_in(stage_5_per_out[109]),
    .x_out(stage_6_per_in[108]),
    .y_out(stage_6_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_55 (
    .x_in(stage_5_per_out[110]),
    .y_in(stage_5_per_out[111]),
    .x_out(stage_6_per_in[110]),
    .y_out(stage_6_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_56 (
    .x_in(stage_5_per_out[112]),
    .y_in(stage_5_per_out[113]),
    .x_out(stage_6_per_in[112]),
    .y_out(stage_6_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_57 (
    .x_in(stage_5_per_out[114]),
    .y_in(stage_5_per_out[115]),
    .x_out(stage_6_per_in[114]),
    .y_out(stage_6_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_58 (
    .x_in(stage_5_per_out[116]),
    .y_in(stage_5_per_out[117]),
    .x_out(stage_6_per_in[116]),
    .y_out(stage_6_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_59 (
    .x_in(stage_5_per_out[118]),
    .y_in(stage_5_per_out[119]),
    .x_out(stage_6_per_in[118]),
    .y_out(stage_6_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_60 (
    .x_in(stage_5_per_out[120]),
    .y_in(stage_5_per_out[121]),
    .x_out(stage_6_per_in[120]),
    .y_out(stage_6_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_61 (
    .x_in(stage_5_per_out[122]),
    .y_in(stage_5_per_out[123]),
    .x_out(stage_6_per_in[122]),
    .y_out(stage_6_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_62 (
    .x_in(stage_5_per_out[124]),
    .y_in(stage_5_per_out[125]),
    .x_out(stage_6_per_in[124]),
    .y_out(stage_6_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[6]),
    .factors({250183461, 180167806, 69574326, 174860716}))
  stage_6_butterfly_63 (
    .x_in(stage_5_per_out[126]),
    .y_in(stage_5_per_out[127]),
    .x_out(stage_6_per_in[126]),
    .y_out(stage_6_per_in[127]),
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
    .inData_64(stage_6_per_in[64]),
    .inData_65(stage_6_per_in[65]),
    .inData_66(stage_6_per_in[66]),
    .inData_67(stage_6_per_in[67]),
    .inData_68(stage_6_per_in[68]),
    .inData_69(stage_6_per_in[69]),
    .inData_70(stage_6_per_in[70]),
    .inData_71(stage_6_per_in[71]),
    .inData_72(stage_6_per_in[72]),
    .inData_73(stage_6_per_in[73]),
    .inData_74(stage_6_per_in[74]),
    .inData_75(stage_6_per_in[75]),
    .inData_76(stage_6_per_in[76]),
    .inData_77(stage_6_per_in[77]),
    .inData_78(stage_6_per_in[78]),
    .inData_79(stage_6_per_in[79]),
    .inData_80(stage_6_per_in[80]),
    .inData_81(stage_6_per_in[81]),
    .inData_82(stage_6_per_in[82]),
    .inData_83(stage_6_per_in[83]),
    .inData_84(stage_6_per_in[84]),
    .inData_85(stage_6_per_in[85]),
    .inData_86(stage_6_per_in[86]),
    .inData_87(stage_6_per_in[87]),
    .inData_88(stage_6_per_in[88]),
    .inData_89(stage_6_per_in[89]),
    .inData_90(stage_6_per_in[90]),
    .inData_91(stage_6_per_in[91]),
    .inData_92(stage_6_per_in[92]),
    .inData_93(stage_6_per_in[93]),
    .inData_94(stage_6_per_in[94]),
    .inData_95(stage_6_per_in[95]),
    .inData_96(stage_6_per_in[96]),
    .inData_97(stage_6_per_in[97]),
    .inData_98(stage_6_per_in[98]),
    .inData_99(stage_6_per_in[99]),
    .inData_100(stage_6_per_in[100]),
    .inData_101(stage_6_per_in[101]),
    .inData_102(stage_6_per_in[102]),
    .inData_103(stage_6_per_in[103]),
    .inData_104(stage_6_per_in[104]),
    .inData_105(stage_6_per_in[105]),
    .inData_106(stage_6_per_in[106]),
    .inData_107(stage_6_per_in[107]),
    .inData_108(stage_6_per_in[108]),
    .inData_109(stage_6_per_in[109]),
    .inData_110(stage_6_per_in[110]),
    .inData_111(stage_6_per_in[111]),
    .inData_112(stage_6_per_in[112]),
    .inData_113(stage_6_per_in[113]),
    .inData_114(stage_6_per_in[114]),
    .inData_115(stage_6_per_in[115]),
    .inData_116(stage_6_per_in[116]),
    .inData_117(stage_6_per_in[117]),
    .inData_118(stage_6_per_in[118]),
    .inData_119(stage_6_per_in[119]),
    .inData_120(stage_6_per_in[120]),
    .inData_121(stage_6_per_in[121]),
    .inData_122(stage_6_per_in[122]),
    .inData_123(stage_6_per_in[123]),
    .inData_124(stage_6_per_in[124]),
    .inData_125(stage_6_per_in[125]),
    .inData_126(stage_6_per_in[126]),
    .inData_127(stage_6_per_in[127]),
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
    .outData_64(stage_6_per_out[64]),
    .outData_65(stage_6_per_out[65]),
    .outData_66(stage_6_per_out[66]),
    .outData_67(stage_6_per_out[67]),
    .outData_68(stage_6_per_out[68]),
    .outData_69(stage_6_per_out[69]),
    .outData_70(stage_6_per_out[70]),
    .outData_71(stage_6_per_out[71]),
    .outData_72(stage_6_per_out[72]),
    .outData_73(stage_6_per_out[73]),
    .outData_74(stage_6_per_out[74]),
    .outData_75(stage_6_per_out[75]),
    .outData_76(stage_6_per_out[76]),
    .outData_77(stage_6_per_out[77]),
    .outData_78(stage_6_per_out[78]),
    .outData_79(stage_6_per_out[79]),
    .outData_80(stage_6_per_out[80]),
    .outData_81(stage_6_per_out[81]),
    .outData_82(stage_6_per_out[82]),
    .outData_83(stage_6_per_out[83]),
    .outData_84(stage_6_per_out[84]),
    .outData_85(stage_6_per_out[85]),
    .outData_86(stage_6_per_out[86]),
    .outData_87(stage_6_per_out[87]),
    .outData_88(stage_6_per_out[88]),
    .outData_89(stage_6_per_out[89]),
    .outData_90(stage_6_per_out[90]),
    .outData_91(stage_6_per_out[91]),
    .outData_92(stage_6_per_out[92]),
    .outData_93(stage_6_per_out[93]),
    .outData_94(stage_6_per_out[94]),
    .outData_95(stage_6_per_out[95]),
    .outData_96(stage_6_per_out[96]),
    .outData_97(stage_6_per_out[97]),
    .outData_98(stage_6_per_out[98]),
    .outData_99(stage_6_per_out[99]),
    .outData_100(stage_6_per_out[100]),
    .outData_101(stage_6_per_out[101]),
    .outData_102(stage_6_per_out[102]),
    .outData_103(stage_6_per_out[103]),
    .outData_104(stage_6_per_out[104]),
    .outData_105(stage_6_per_out[105]),
    .outData_106(stage_6_per_out[106]),
    .outData_107(stage_6_per_out[107]),
    .outData_108(stage_6_per_out[108]),
    .outData_109(stage_6_per_out[109]),
    .outData_110(stage_6_per_out[110]),
    .outData_111(stage_6_per_out[111]),
    .outData_112(stage_6_per_out[112]),
    .outData_113(stage_6_per_out[113]),
    .outData_114(stage_6_per_out[114]),
    .outData_115(stage_6_per_out[115]),
    .outData_116(stage_6_per_out[116]),
    .outData_117(stage_6_per_out[117]),
    .outData_118(stage_6_per_out[118]),
    .outData_119(stage_6_per_out[119]),
    .outData_120(stage_6_per_out[120]),
    .outData_121(stage_6_per_out[121]),
    .outData_122(stage_6_per_out[122]),
    .outData_123(stage_6_per_out[123]),
    .outData_124(stage_6_per_out[124]),
    .outData_125(stage_6_per_out[125]),
    .outData_126(stage_6_per_out[126]),
    .outData_127(stage_6_per_out[127]),
    .in_start(in_start[6]),
    .out_start(out_start[6]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 7 32 butterfly units
  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_31 (
    .x_in(stage_6_per_out[62]),
    .y_in(stage_6_per_out[63]),
    .x_out(stage_7_per_in[62]),
    .y_out(stage_7_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_32 (
    .x_in(stage_6_per_out[64]),
    .y_in(stage_6_per_out[65]),
    .x_out(stage_7_per_in[64]),
    .y_out(stage_7_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_33 (
    .x_in(stage_6_per_out[66]),
    .y_in(stage_6_per_out[67]),
    .x_out(stage_7_per_in[66]),
    .y_out(stage_7_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_34 (
    .x_in(stage_6_per_out[68]),
    .y_in(stage_6_per_out[69]),
    .x_out(stage_7_per_in[68]),
    .y_out(stage_7_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_35 (
    .x_in(stage_6_per_out[70]),
    .y_in(stage_6_per_out[71]),
    .x_out(stage_7_per_in[70]),
    .y_out(stage_7_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_36 (
    .x_in(stage_6_per_out[72]),
    .y_in(stage_6_per_out[73]),
    .x_out(stage_7_per_in[72]),
    .y_out(stage_7_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_37 (
    .x_in(stage_6_per_out[74]),
    .y_in(stage_6_per_out[75]),
    .x_out(stage_7_per_in[74]),
    .y_out(stage_7_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_38 (
    .x_in(stage_6_per_out[76]),
    .y_in(stage_6_per_out[77]),
    .x_out(stage_7_per_in[76]),
    .y_out(stage_7_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_39 (
    .x_in(stage_6_per_out[78]),
    .y_in(stage_6_per_out[79]),
    .x_out(stage_7_per_in[78]),
    .y_out(stage_7_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_40 (
    .x_in(stage_6_per_out[80]),
    .y_in(stage_6_per_out[81]),
    .x_out(stage_7_per_in[80]),
    .y_out(stage_7_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_41 (
    .x_in(stage_6_per_out[82]),
    .y_in(stage_6_per_out[83]),
    .x_out(stage_7_per_in[82]),
    .y_out(stage_7_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_42 (
    .x_in(stage_6_per_out[84]),
    .y_in(stage_6_per_out[85]),
    .x_out(stage_7_per_in[84]),
    .y_out(stage_7_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_43 (
    .x_in(stage_6_per_out[86]),
    .y_in(stage_6_per_out[87]),
    .x_out(stage_7_per_in[86]),
    .y_out(stage_7_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_44 (
    .x_in(stage_6_per_out[88]),
    .y_in(stage_6_per_out[89]),
    .x_out(stage_7_per_in[88]),
    .y_out(stage_7_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_45 (
    .x_in(stage_6_per_out[90]),
    .y_in(stage_6_per_out[91]),
    .x_out(stage_7_per_in[90]),
    .y_out(stage_7_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_46 (
    .x_in(stage_6_per_out[92]),
    .y_in(stage_6_per_out[93]),
    .x_out(stage_7_per_in[92]),
    .y_out(stage_7_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_47 (
    .x_in(stage_6_per_out[94]),
    .y_in(stage_6_per_out[95]),
    .x_out(stage_7_per_in[94]),
    .y_out(stage_7_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_48 (
    .x_in(stage_6_per_out[96]),
    .y_in(stage_6_per_out[97]),
    .x_out(stage_7_per_in[96]),
    .y_out(stage_7_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_49 (
    .x_in(stage_6_per_out[98]),
    .y_in(stage_6_per_out[99]),
    .x_out(stage_7_per_in[98]),
    .y_out(stage_7_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_50 (
    .x_in(stage_6_per_out[100]),
    .y_in(stage_6_per_out[101]),
    .x_out(stage_7_per_in[100]),
    .y_out(stage_7_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_51 (
    .x_in(stage_6_per_out[102]),
    .y_in(stage_6_per_out[103]),
    .x_out(stage_7_per_in[102]),
    .y_out(stage_7_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_52 (
    .x_in(stage_6_per_out[104]),
    .y_in(stage_6_per_out[105]),
    .x_out(stage_7_per_in[104]),
    .y_out(stage_7_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_53 (
    .x_in(stage_6_per_out[106]),
    .y_in(stage_6_per_out[107]),
    .x_out(stage_7_per_in[106]),
    .y_out(stage_7_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_54 (
    .x_in(stage_6_per_out[108]),
    .y_in(stage_6_per_out[109]),
    .x_out(stage_7_per_in[108]),
    .y_out(stage_7_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_55 (
    .x_in(stage_6_per_out[110]),
    .y_in(stage_6_per_out[111]),
    .x_out(stage_7_per_in[110]),
    .y_out(stage_7_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_56 (
    .x_in(stage_6_per_out[112]),
    .y_in(stage_6_per_out[113]),
    .x_out(stage_7_per_in[112]),
    .y_out(stage_7_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_57 (
    .x_in(stage_6_per_out[114]),
    .y_in(stage_6_per_out[115]),
    .x_out(stage_7_per_in[114]),
    .y_out(stage_7_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_58 (
    .x_in(stage_6_per_out[116]),
    .y_in(stage_6_per_out[117]),
    .x_out(stage_7_per_in[116]),
    .y_out(stage_7_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_59 (
    .x_in(stage_6_per_out[118]),
    .y_in(stage_6_per_out[119]),
    .x_out(stage_7_per_in[118]),
    .y_out(stage_7_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_60 (
    .x_in(stage_6_per_out[120]),
    .y_in(stage_6_per_out[121]),
    .x_out(stage_7_per_in[120]),
    .y_out(stage_7_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_61 (
    .x_in(stage_6_per_out[122]),
    .y_in(stage_6_per_out[123]),
    .x_out(stage_7_per_in[122]),
    .y_out(stage_7_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_62 (
    .x_in(stage_6_per_out[124]),
    .y_in(stage_6_per_out[125]),
    .x_out(stage_7_per_in[124]),
    .y_out(stage_7_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[7]),
    .factors({185593570, 185593570, 183496802, 183496802}))
  stage_7_butterfly_63 (
    .x_in(stage_6_per_out[126]),
    .y_in(stage_6_per_out[127]),
    .x_out(stage_7_per_in[126]),
    .y_out(stage_7_per_in[127]),
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
    .inData_64(stage_7_per_in[64]),
    .inData_65(stage_7_per_in[65]),
    .inData_66(stage_7_per_in[66]),
    .inData_67(stage_7_per_in[67]),
    .inData_68(stage_7_per_in[68]),
    .inData_69(stage_7_per_in[69]),
    .inData_70(stage_7_per_in[70]),
    .inData_71(stage_7_per_in[71]),
    .inData_72(stage_7_per_in[72]),
    .inData_73(stage_7_per_in[73]),
    .inData_74(stage_7_per_in[74]),
    .inData_75(stage_7_per_in[75]),
    .inData_76(stage_7_per_in[76]),
    .inData_77(stage_7_per_in[77]),
    .inData_78(stage_7_per_in[78]),
    .inData_79(stage_7_per_in[79]),
    .inData_80(stage_7_per_in[80]),
    .inData_81(stage_7_per_in[81]),
    .inData_82(stage_7_per_in[82]),
    .inData_83(stage_7_per_in[83]),
    .inData_84(stage_7_per_in[84]),
    .inData_85(stage_7_per_in[85]),
    .inData_86(stage_7_per_in[86]),
    .inData_87(stage_7_per_in[87]),
    .inData_88(stage_7_per_in[88]),
    .inData_89(stage_7_per_in[89]),
    .inData_90(stage_7_per_in[90]),
    .inData_91(stage_7_per_in[91]),
    .inData_92(stage_7_per_in[92]),
    .inData_93(stage_7_per_in[93]),
    .inData_94(stage_7_per_in[94]),
    .inData_95(stage_7_per_in[95]),
    .inData_96(stage_7_per_in[96]),
    .inData_97(stage_7_per_in[97]),
    .inData_98(stage_7_per_in[98]),
    .inData_99(stage_7_per_in[99]),
    .inData_100(stage_7_per_in[100]),
    .inData_101(stage_7_per_in[101]),
    .inData_102(stage_7_per_in[102]),
    .inData_103(stage_7_per_in[103]),
    .inData_104(stage_7_per_in[104]),
    .inData_105(stage_7_per_in[105]),
    .inData_106(stage_7_per_in[106]),
    .inData_107(stage_7_per_in[107]),
    .inData_108(stage_7_per_in[108]),
    .inData_109(stage_7_per_in[109]),
    .inData_110(stage_7_per_in[110]),
    .inData_111(stage_7_per_in[111]),
    .inData_112(stage_7_per_in[112]),
    .inData_113(stage_7_per_in[113]),
    .inData_114(stage_7_per_in[114]),
    .inData_115(stage_7_per_in[115]),
    .inData_116(stage_7_per_in[116]),
    .inData_117(stage_7_per_in[117]),
    .inData_118(stage_7_per_in[118]),
    .inData_119(stage_7_per_in[119]),
    .inData_120(stage_7_per_in[120]),
    .inData_121(stage_7_per_in[121]),
    .inData_122(stage_7_per_in[122]),
    .inData_123(stage_7_per_in[123]),
    .inData_124(stage_7_per_in[124]),
    .inData_125(stage_7_per_in[125]),
    .inData_126(stage_7_per_in[126]),
    .inData_127(stage_7_per_in[127]),
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
    .outData_64(stage_7_per_out[64]),
    .outData_65(stage_7_per_out[65]),
    .outData_66(stage_7_per_out[66]),
    .outData_67(stage_7_per_out[67]),
    .outData_68(stage_7_per_out[68]),
    .outData_69(stage_7_per_out[69]),
    .outData_70(stage_7_per_out[70]),
    .outData_71(stage_7_per_out[71]),
    .outData_72(stage_7_per_out[72]),
    .outData_73(stage_7_per_out[73]),
    .outData_74(stage_7_per_out[74]),
    .outData_75(stage_7_per_out[75]),
    .outData_76(stage_7_per_out[76]),
    .outData_77(stage_7_per_out[77]),
    .outData_78(stage_7_per_out[78]),
    .outData_79(stage_7_per_out[79]),
    .outData_80(stage_7_per_out[80]),
    .outData_81(stage_7_per_out[81]),
    .outData_82(stage_7_per_out[82]),
    .outData_83(stage_7_per_out[83]),
    .outData_84(stage_7_per_out[84]),
    .outData_85(stage_7_per_out[85]),
    .outData_86(stage_7_per_out[86]),
    .outData_87(stage_7_per_out[87]),
    .outData_88(stage_7_per_out[88]),
    .outData_89(stage_7_per_out[89]),
    .outData_90(stage_7_per_out[90]),
    .outData_91(stage_7_per_out[91]),
    .outData_92(stage_7_per_out[92]),
    .outData_93(stage_7_per_out[93]),
    .outData_94(stage_7_per_out[94]),
    .outData_95(stage_7_per_out[95]),
    .outData_96(stage_7_per_out[96]),
    .outData_97(stage_7_per_out[97]),
    .outData_98(stage_7_per_out[98]),
    .outData_99(stage_7_per_out[99]),
    .outData_100(stage_7_per_out[100]),
    .outData_101(stage_7_per_out[101]),
    .outData_102(stage_7_per_out[102]),
    .outData_103(stage_7_per_out[103]),
    .outData_104(stage_7_per_out[104]),
    .outData_105(stage_7_per_out[105]),
    .outData_106(stage_7_per_out[106]),
    .outData_107(stage_7_per_out[107]),
    .outData_108(stage_7_per_out[108]),
    .outData_109(stage_7_per_out[109]),
    .outData_110(stage_7_per_out[110]),
    .outData_111(stage_7_per_out[111]),
    .outData_112(stage_7_per_out[112]),
    .outData_113(stage_7_per_out[113]),
    .outData_114(stage_7_per_out[114]),
    .outData_115(stage_7_per_out[115]),
    .outData_116(stage_7_per_out[116]),
    .outData_117(stage_7_per_out[117]),
    .outData_118(stage_7_per_out[118]),
    .outData_119(stage_7_per_out[119]),
    .outData_120(stage_7_per_out[120]),
    .outData_121(stage_7_per_out[121]),
    .outData_122(stage_7_per_out[122]),
    .outData_123(stage_7_per_out[123]),
    .outData_124(stage_7_per_out[124]),
    .outData_125(stage_7_per_out[125]),
    .outData_126(stage_7_per_out[126]),
    .outData_127(stage_7_per_out[127]),
    .in_start(in_start[7]),
    .out_start(out_start[7]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 8 32 butterfly units
  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
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
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_31 (
    .x_in(stage_7_per_out[62]),
    .y_in(stage_7_per_out[63]),
    .x_out(outData[62]),
    .y_out(outData[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_32 (
    .x_in(stage_7_per_out[64]),
    .y_in(stage_7_per_out[65]),
    .x_out(outData[64]),
    .y_out(outData[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_33 (
    .x_in(stage_7_per_out[66]),
    .y_in(stage_7_per_out[67]),
    .x_out(outData[66]),
    .y_out(outData[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_34 (
    .x_in(stage_7_per_out[68]),
    .y_in(stage_7_per_out[69]),
    .x_out(outData[68]),
    .y_out(outData[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_35 (
    .x_in(stage_7_per_out[70]),
    .y_in(stage_7_per_out[71]),
    .x_out(outData[70]),
    .y_out(outData[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_36 (
    .x_in(stage_7_per_out[72]),
    .y_in(stage_7_per_out[73]),
    .x_out(outData[72]),
    .y_out(outData[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_37 (
    .x_in(stage_7_per_out[74]),
    .y_in(stage_7_per_out[75]),
    .x_out(outData[74]),
    .y_out(outData[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_38 (
    .x_in(stage_7_per_out[76]),
    .y_in(stage_7_per_out[77]),
    .x_out(outData[76]),
    .y_out(outData[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_39 (
    .x_in(stage_7_per_out[78]),
    .y_in(stage_7_per_out[79]),
    .x_out(outData[78]),
    .y_out(outData[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_40 (
    .x_in(stage_7_per_out[80]),
    .y_in(stage_7_per_out[81]),
    .x_out(outData[80]),
    .y_out(outData[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_41 (
    .x_in(stage_7_per_out[82]),
    .y_in(stage_7_per_out[83]),
    .x_out(outData[82]),
    .y_out(outData[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_42 (
    .x_in(stage_7_per_out[84]),
    .y_in(stage_7_per_out[85]),
    .x_out(outData[84]),
    .y_out(outData[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_43 (
    .x_in(stage_7_per_out[86]),
    .y_in(stage_7_per_out[87]),
    .x_out(outData[86]),
    .y_out(outData[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_44 (
    .x_in(stage_7_per_out[88]),
    .y_in(stage_7_per_out[89]),
    .x_out(outData[88]),
    .y_out(outData[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_45 (
    .x_in(stage_7_per_out[90]),
    .y_in(stage_7_per_out[91]),
    .x_out(outData[90]),
    .y_out(outData[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_46 (
    .x_in(stage_7_per_out[92]),
    .y_in(stage_7_per_out[93]),
    .x_out(outData[92]),
    .y_out(outData[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_47 (
    .x_in(stage_7_per_out[94]),
    .y_in(stage_7_per_out[95]),
    .x_out(outData[94]),
    .y_out(outData[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_48 (
    .x_in(stage_7_per_out[96]),
    .y_in(stage_7_per_out[97]),
    .x_out(outData[96]),
    .y_out(outData[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_49 (
    .x_in(stage_7_per_out[98]),
    .y_in(stage_7_per_out[99]),
    .x_out(outData[98]),
    .y_out(outData[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_50 (
    .x_in(stage_7_per_out[100]),
    .y_in(stage_7_per_out[101]),
    .x_out(outData[100]),
    .y_out(outData[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_51 (
    .x_in(stage_7_per_out[102]),
    .y_in(stage_7_per_out[103]),
    .x_out(outData[102]),
    .y_out(outData[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_52 (
    .x_in(stage_7_per_out[104]),
    .y_in(stage_7_per_out[105]),
    .x_out(outData[104]),
    .y_out(outData[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_53 (
    .x_in(stage_7_per_out[106]),
    .y_in(stage_7_per_out[107]),
    .x_out(outData[106]),
    .y_out(outData[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_54 (
    .x_in(stage_7_per_out[108]),
    .y_in(stage_7_per_out[109]),
    .x_out(outData[108]),
    .y_out(outData[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_55 (
    .x_in(stage_7_per_out[110]),
    .y_in(stage_7_per_out[111]),
    .x_out(outData[110]),
    .y_out(outData[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_56 (
    .x_in(stage_7_per_out[112]),
    .y_in(stage_7_per_out[113]),
    .x_out(outData[112]),
    .y_out(outData[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_57 (
    .x_in(stage_7_per_out[114]),
    .y_in(stage_7_per_out[115]),
    .x_out(outData[114]),
    .y_out(outData[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_58 (
    .x_in(stage_7_per_out[116]),
    .y_in(stage_7_per_out[117]),
    .x_out(outData[116]),
    .y_out(outData[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_59 (
    .x_in(stage_7_per_out[118]),
    .y_in(stage_7_per_out[119]),
    .x_out(outData[118]),
    .y_out(outData[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_60 (
    .x_in(stage_7_per_out[120]),
    .y_in(stage_7_per_out[121]),
    .x_out(outData[120]),
    .y_out(outData[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_61 (
    .x_in(stage_7_per_out[122]),
    .y_in(stage_7_per_out[123]),
    .x_out(outData[122]),
    .y_out(outData[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_62 (
    .x_in(stage_7_per_out[124]),
    .y_in(stage_7_per_out[125]),
    .x_out(outData[124]),
    .y_out(outData[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({75074761, 75074761, 75074761, 75074761}))
  stage_8_butterfly_63 (
    .x_in(stage_7_per_out[126]),
    .y_in(stage_7_per_out[127]),
    .x_out(outData[126]),
    .y_out(outData[127]),
    .clk(clk),
    .rst(rst)
  );


endmodule
