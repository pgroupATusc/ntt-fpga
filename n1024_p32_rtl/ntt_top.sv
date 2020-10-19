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

  input in_start[8:0];
  output logic out_start[8:0];

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

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_8_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_8_per_out[INPUT_PER_CYCLE-1:0];

  // TODO(Tian): stage 0 32 butterfly units
  butterfly #(
    .start(0),
    .factors({326097, 244423105, 131309632, 5445105,
              168342750, 12817079, 67241659, 244593894,
              201160126, 245041907, 107830842, 132467399,
              3021514, 257426331, 265882354, 207530748}))
  stage_0_butterfly_0 (
    .x_in(inData[0]),
    .y_in(inData[1]),
    .x_out(stage_0_per_in[0]),
    .y_out(stage_0_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({145034434, 25030552, 222056927, 36620312,
              169924108, 132747224, 12551837, 58671364,
              188526794, 262112169, 50162577, 189601976,
              34052825, 4047489, 30998914, 73217275}))
  stage_0_butterfly_1 (
    .x_in(inData[2]),
    .y_in(inData[3]),
    .x_out(stage_0_per_in[2]),
    .y_out(stage_0_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({63661975, 161607031, 103503994, 17758040,
              155100837, 72509307, 99695712, 62094530,
              122609533, 146657273, 125713617, 79834640,
              128159746, 123720956, 66582189, 244927134}))
  stage_0_butterfly_2 (
    .x_in(inData[4]),
    .y_in(inData[5]),
    .x_out(stage_0_per_in[4]),
    .y_out(stage_0_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({120466187, 140358303, 70017017, 157386503,
              149423455, 195297575, 225794318, 209780385,
              9205704, 209744644, 157839041, 151855973,
              123018041, 128052734, 148051010, 259621463}))
  stage_0_butterfly_3 (
    .x_in(inData[6]),
    .y_in(inData[7]),
    .x_out(stage_0_per_in[6]),
    .y_out(stage_0_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({156837559, 55581691, 167645260, 243091016,
              2204580, 230992788, 186531585, 121730405,
              267506256, 62027985, 107513427, 251672258,
              244783678, 149788353, 115050087, 257402730}))
  stage_0_butterfly_4 (
    .x_in(inData[8]),
    .y_in(inData[9]),
    .x_out(stage_0_per_in[8]),
    .y_out(stage_0_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({101188020, 246741831, 77119896, 202565947,
              24036023, 55944760, 94686133, 167758747,
              71304140, 65889055, 102034957, 17682401,
              19637177, 78612624, 157991445, 211201491}))
  stage_0_butterfly_5 (
    .x_in(inData[10]),
    .y_in(inData[11]),
    .x_out(stage_0_per_in[10]),
    .y_out(stage_0_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({254234203, 94079265, 69205492, 210423079,
              164473684, 59214954, 206844979, 8650362,
              242301146, 118320134, 92420698, 232847226,
              5161923, 209708523, 159538295, 263725948}))
  stage_0_butterfly_6 (
    .x_in(inData[12]),
    .y_in(inData[13]),
    .x_out(stage_0_per_in[12]),
    .y_out(stage_0_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({192680819, 236528116, 190540901, 76624935,
              75195548, 241071152, 215085706, 50174239,
              187208958, 60492437, 112756762, 86776671,
              212422509, 224322272, 246787643, 105443909}))
  stage_0_butterfly_7 (
    .x_in(inData[14]),
    .y_in(inData[15]),
    .x_out(stage_0_per_in[14]),
    .y_out(stage_0_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({180764097, 199352295, 195298807, 115053845,
              124558832, 101579460, 174028560, 228243008,
              126413069, 172655984, 212287973, 29779638,
              133273987, 266514716, 248946430, 161626887}))
  stage_0_butterfly_8 (
    .x_in(inData[16]),
    .y_in(inData[17]),
    .x_out(stage_0_per_in[16]),
    .y_out(stage_0_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({172715743, 160050812, 100343421, 232156312,
              242717180, 64518939, 119890469, 247452694,
              212237706, 34932582, 107138937, 102698816,
              138692846, 86359417, 53025186, 29901564}))
  stage_0_butterfly_9 (
    .x_in(inData[18]),
    .y_in(inData[19]),
    .x_out(stage_0_per_in[18]),
    .y_out(stage_0_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({245986816, 24365404, 255658390, 126749676,
              135080569, 128627235, 79336225, 207021189,
              92659465, 90701762, 144502563, 148152811,
              79230237, 195692414, 170100736, 183571221}))
  stage_0_butterfly_10 (
    .x_in(inData[20]),
    .y_in(inData[21]),
    .x_out(stage_0_per_in[20]),
    .y_out(stage_0_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({53126225, 56387579, 236209279, 117072589,
              59894768, 134804553, 46197346, 111835742,
              256083096, 31964447, 135271820, 248922055,
              190586128, 108164959, 247116469, 146399832}))
  stage_0_butterfly_11 (
    .x_in(inData[22]),
    .y_in(inData[23]),
    .x_out(stage_0_per_in[22]),
    .y_out(stage_0_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({52844710, 46282885, 110055875, 156195364,
              255463943, 261458154, 55222727, 248669125,
              2486257, 193911793, 1991289, 139101859,
              102785717, 145056180, 218286321, 209643171}))
  stage_0_butterfly_12 (
    .x_in(inData[24]),
    .y_in(inData[25]),
    .x_out(stage_0_per_in[24]),
    .y_out(stage_0_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({19058782, 185175266, 233967292, 121355275,
              156009907, 159148996, 12591284, 243047656,
              112825183, 32097135, 81263879, 70325928,
              237616434, 81197166, 190565686, 9067201}))
  stage_0_butterfly_13 (
    .x_in(inData[26]),
    .y_in(inData[27]),
    .x_out(stage_0_per_in[26]),
    .y_out(stage_0_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({43447238, 160048836, 142941966, 99012968,
              227454343, 262630184, 174856430, 250031819,
              217359458, 72351531, 94792077, 62688241,
              20236367, 22997488, 173933513, 146205579}))
  stage_0_butterfly_14 (
    .x_in(inData[28]),
    .y_in(inData[29]),
    .x_out(stage_0_per_in[28]),
    .y_out(stage_0_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(0),
    .factors({177682833, 129856203, 139780710, 159491687,
              256519333, 122025398, 203905228, 213678985,
              198957507, 243009216, 122969043, 166139329,
              171841734, 133808889, 176911171, 77127228}))
  stage_0_butterfly_15 (
    .x_in(inData[30]),
    .y_in(inData[31]),
    .x_out(stage_0_per_in[30]),
    .y_out(stage_0_per_in[31]),
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
    .in_start(in_start[0]),
    .out_start(out_start[0]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Tian): stage 1 32 butterfly units
  butterfly #(
    .start(7),
    .factors({64764693, 101414187, 43104106, 196328787,
              182691070, 234350511, 97007849, 227651751,
              193296437, 5299132, 17861009, 28242170,
              138879618, 206252403, 184310992, 56155754}))
  stage_1_butterfly_0 (
    .x_in(stage_0_per_out[0]),
    .y_in(stage_0_per_out[1]),
    .x_out(stage_1_per_in[0]),
    .y_out(stage_1_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({64764693, 101414187, 43104106, 196328787,
              182691070, 234350511, 97007849, 227651751,
              193296437, 5299132, 17861009, 28242170,
              138879618, 206252403, 184310992, 56155754}))
  stage_1_butterfly_1 (
    .x_in(stage_0_per_out[2]),
    .y_in(stage_0_per_out[3]),
    .x_out(stage_1_per_in[2]),
    .y_out(stage_1_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({194276347, 48471700, 185138250, 177340471,
              257269778, 172508742, 117507527, 154421517,
              62408001, 34256894, 134877507, 157966005,
              206725018, 126945619, 195748297, 95282463}))
  stage_1_butterfly_2 (
    .x_in(stage_0_per_out[4]),
    .y_in(stage_0_per_out[5]),
    .x_out(stage_1_per_in[4]),
    .y_out(stage_1_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({194276347, 48471700, 185138250, 177340471,
              257269778, 172508742, 117507527, 154421517,
              62408001, 34256894, 134877507, 157966005,
              206725018, 126945619, 195748297, 95282463}))
  stage_1_butterfly_3 (
    .x_in(stage_0_per_out[6]),
    .y_in(stage_0_per_out[7]),
    .x_out(stage_1_per_in[6]),
    .y_out(stage_1_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({223822620, 131023241, 34971158, 173118058,
              262077011, 262358962, 225784463, 218231468,
              117221766, 42719459, 67225153, 23405380,
              140366124, 61345534, 61040039, 173757017}))
  stage_1_butterfly_4 (
    .x_in(stage_0_per_out[8]),
    .y_in(stage_0_per_out[9]),
    .x_out(stage_1_per_in[8]),
    .y_out(stage_1_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({223822620, 131023241, 34971158, 173118058,
              262077011, 262358962, 225784463, 218231468,
              117221766, 42719459, 67225153, 23405380,
              140366124, 61345534, 61040039, 173757017}))
  stage_1_butterfly_5 (
    .x_in(stage_0_per_out[10]),
    .y_in(stage_0_per_out[11]),
    .x_out(stage_1_per_in[10]),
    .y_out(stage_1_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({209886001, 210770212, 199876762, 97318594,
              231423732, 226213489, 202776751, 251138298,
              224068691, 43783325, 160841949, 178386996,
              73081523, 258527796, 187864761, 10003248}))
  stage_1_butterfly_6 (
    .x_in(stage_0_per_out[12]),
    .y_in(stage_0_per_out[13]),
    .x_out(stage_1_per_in[12]),
    .y_out(stage_1_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({209886001, 210770212, 199876762, 97318594,
              231423732, 226213489, 202776751, 251138298,
              224068691, 43783325, 160841949, 178386996,
              73081523, 258527796, 187864761, 10003248}))
  stage_1_butterfly_7 (
    .x_in(stage_0_per_out[14]),
    .y_in(stage_0_per_out[15]),
    .x_out(stage_1_per_in[14]),
    .y_out(stage_1_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({196522490, 249146534, 123335450, 103731033,
              53222994, 137672988, 143779572, 74454717,
              212275822, 259958064, 254132077, 45686070,
              5829490, 209725121, 251384491, 114486793}))
  stage_1_butterfly_8 (
    .x_in(stage_0_per_out[16]),
    .y_in(stage_0_per_out[17]),
    .x_out(stage_1_per_in[16]),
    .y_out(stage_1_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({196522490, 249146534, 123335450, 103731033,
              53222994, 137672988, 143779572, 74454717,
              212275822, 259958064, 254132077, 45686070,
              5829490, 209725121, 251384491, 114486793}))
  stage_1_butterfly_9 (
    .x_in(stage_0_per_out[18]),
    .y_in(stage_0_per_out[19]),
    .x_out(stage_1_per_in[18]),
    .y_out(stage_1_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({222861227, 1562592, 174629071, 258257144,
              158168844, 209583375, 112003761, 181167649,
              63079505, 14568946, 167911982, 141849606,
              99392088, 5292226, 25944135, 190980049}))
  stage_1_butterfly_10 (
    .x_in(stage_0_per_out[20]),
    .y_in(stage_0_per_out[21]),
    .x_out(stage_1_per_in[20]),
    .y_out(stage_1_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({222861227, 1562592, 174629071, 258257144,
              158168844, 209583375, 112003761, 181167649,
              63079505, 14568946, 167911982, 141849606,
              99392088, 5292226, 25944135, 190980049}))
  stage_1_butterfly_11 (
    .x_in(stage_0_per_out[22]),
    .y_in(stage_0_per_out[23]),
    .x_out(stage_1_per_in[22]),
    .y_out(stage_1_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({174900371, 82684352, 258559590, 170930026,
              208297913, 261795000, 171541778, 220994759,
              109479656, 160254284, 66298746, 256173379,
              236282586, 210734246, 20857483, 186214186}))
  stage_1_butterfly_12 (
    .x_in(stage_0_per_out[24]),
    .y_in(stage_0_per_out[25]),
    .x_out(stage_1_per_in[24]),
    .y_out(stage_1_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({174900371, 82684352, 258559590, 170930026,
              208297913, 261795000, 171541778, 220994759,
              109479656, 160254284, 66298746, 256173379,
              236282586, 210734246, 20857483, 186214186}))
  stage_1_butterfly_13 (
    .x_in(stage_0_per_out[26]),
    .y_in(stage_0_per_out[27]),
    .x_out(stage_1_per_in[26]),
    .y_out(stage_1_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({260909397, 50222736, 251898247, 126063290,
              201863951, 26067051, 43194148, 224794776,
              82934386, 64884498, 51974898, 199633043,
              56246211, 68267735, 228211497, 5905084}))
  stage_1_butterfly_14 (
    .x_in(stage_0_per_out[28]),
    .y_in(stage_0_per_out[29]),
    .x_out(stage_1_per_in[28]),
    .y_out(stage_1_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(7),
    .factors({260909397, 50222736, 251898247, 126063290,
              201863951, 26067051, 43194148, 224794776,
              82934386, 64884498, 51974898, 199633043,
              56246211, 68267735, 228211497, 5905084}))
  stage_1_butterfly_15 (
    .x_in(stage_0_per_out[30]),
    .y_in(stage_0_per_out[31]),
    .x_out(stage_1_per_in[30]),
    .y_out(stage_1_per_in[31]),
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
    .in_start(in_start[1]),
    .out_start(out_start[1]),
    .clk(clk),
    .rst(rst)
  );


  // TODO(Tian): stage 2 32 butterfly units
  butterfly #(
    .start(14),
    .factors({53818192, 229216409, 77337691, 133503098,
              18399308, 199208174, 254850432, 123954975,
              145184649, 181639510, 23486645, 71064168,
              130557622, 85021501, 214085592, 27244461}))
  stage_2_butterfly_0 (
    .x_in(stage_1_per_out[0]),
    .y_in(stage_1_per_out[1]),
    .x_out(stage_2_per_in[0]),
    .y_out(stage_2_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({53818192, 229216409, 77337691, 133503098,
              18399308, 199208174, 254850432, 123954975,
              145184649, 181639510, 23486645, 71064168,
              130557622, 85021501, 214085592, 27244461}))
  stage_2_butterfly_1 (
    .x_in(stage_1_per_out[2]),
    .y_in(stage_1_per_out[3]),
    .x_out(stage_2_per_in[2]),
    .y_out(stage_2_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({53818192, 229216409, 77337691, 133503098,
              18399308, 199208174, 254850432, 123954975,
              145184649, 181639510, 23486645, 71064168,
              130557622, 85021501, 214085592, 27244461}))
  stage_2_butterfly_2 (
    .x_in(stage_1_per_out[4]),
    .y_in(stage_1_per_out[5]),
    .x_out(stage_2_per_in[4]),
    .y_out(stage_2_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({53818192, 229216409, 77337691, 133503098,
              18399308, 199208174, 254850432, 123954975,
              145184649, 181639510, 23486645, 71064168,
              130557622, 85021501, 214085592, 27244461}))
  stage_2_butterfly_3 (
    .x_in(stage_1_per_out[6]),
    .y_in(stage_1_per_out[7]),
    .x_out(stage_2_per_in[6]),
    .y_out(stage_2_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({108810259, 160286792, 34119889, 227283585,
              50725340, 180525688, 220375582, 211668928,
              182447177, 216143425, 7055647, 101483624,
              231318087, 161729483, 205019884, 243304319}))
  stage_2_butterfly_4 (
    .x_in(stage_1_per_out[8]),
    .y_in(stage_1_per_out[9]),
    .x_out(stage_2_per_in[8]),
    .y_out(stage_2_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({108810259, 160286792, 34119889, 227283585,
              50725340, 180525688, 220375582, 211668928,
              182447177, 216143425, 7055647, 101483624,
              231318087, 161729483, 205019884, 243304319}))
  stage_2_butterfly_5 (
    .x_in(stage_1_per_out[10]),
    .y_in(stage_1_per_out[11]),
    .x_out(stage_2_per_in[10]),
    .y_out(stage_2_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({108810259, 160286792, 34119889, 227283585,
              50725340, 180525688, 220375582, 211668928,
              182447177, 216143425, 7055647, 101483624,
              231318087, 161729483, 205019884, 243304319}))
  stage_2_butterfly_6 (
    .x_in(stage_1_per_out[12]),
    .y_in(stage_1_per_out[13]),
    .x_out(stage_2_per_in[12]),
    .y_out(stage_2_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({108810259, 160286792, 34119889, 227283585,
              50725340, 180525688, 220375582, 211668928,
              182447177, 216143425, 7055647, 101483624,
              231318087, 161729483, 205019884, 243304319}))
  stage_2_butterfly_7 (
    .x_in(stage_1_per_out[14]),
    .y_in(stage_1_per_out[15]),
    .x_out(stage_2_per_in[14]),
    .y_out(stage_2_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({44942358, 204152715, 201357873, 3883583,
              171721518, 255119583, 252442032, 242800442,
              254450415, 119707826, 29871855, 257268473,
              75673633, 234030247, 189591954, 184516225}))
  stage_2_butterfly_8 (
    .x_in(stage_1_per_out[16]),
    .y_in(stage_1_per_out[17]),
    .x_out(stage_2_per_in[16]),
    .y_out(stage_2_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({44942358, 204152715, 201357873, 3883583,
              171721518, 255119583, 252442032, 242800442,
              254450415, 119707826, 29871855, 257268473,
              75673633, 234030247, 189591954, 184516225}))
  stage_2_butterfly_9 (
    .x_in(stage_1_per_out[18]),
    .y_in(stage_1_per_out[19]),
    .x_out(stage_2_per_in[18]),
    .y_out(stage_2_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({44942358, 204152715, 201357873, 3883583,
              171721518, 255119583, 252442032, 242800442,
              254450415, 119707826, 29871855, 257268473,
              75673633, 234030247, 189591954, 184516225}))
  stage_2_butterfly_10 (
    .x_in(stage_1_per_out[20]),
    .y_in(stage_1_per_out[21]),
    .x_out(stage_2_per_in[20]),
    .y_out(stage_2_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({44942358, 204152715, 201357873, 3883583,
              171721518, 255119583, 252442032, 242800442,
              254450415, 119707826, 29871855, 257268473,
              75673633, 234030247, 189591954, 184516225}))
  stage_2_butterfly_11 (
    .x_in(stage_1_per_out[22]),
    .y_in(stage_1_per_out[23]),
    .x_out(stage_2_per_in[22]),
    .y_out(stage_2_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({234890903, 66148505, 41630462, 104784816,
              72738487, 22541719, 106338196, 146361539,
              170604387, 39141691, 133081916, 68136911,
              159404461, 227214070, 245906264, 91898237}))
  stage_2_butterfly_12 (
    .x_in(stage_1_per_out[24]),
    .y_in(stage_1_per_out[25]),
    .x_out(stage_2_per_in[24]),
    .y_out(stage_2_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({234890903, 66148505, 41630462, 104784816,
              72738487, 22541719, 106338196, 146361539,
              170604387, 39141691, 133081916, 68136911,
              159404461, 227214070, 245906264, 91898237}))
  stage_2_butterfly_13 (
    .x_in(stage_1_per_out[26]),
    .y_in(stage_1_per_out[27]),
    .x_out(stage_2_per_in[26]),
    .y_out(stage_2_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({234890903, 66148505, 41630462, 104784816,
              72738487, 22541719, 106338196, 146361539,
              170604387, 39141691, 133081916, 68136911,
              159404461, 227214070, 245906264, 91898237}))
  stage_2_butterfly_14 (
    .x_in(stage_1_per_out[28]),
    .y_in(stage_1_per_out[29]),
    .x_out(stage_2_per_in[28]),
    .y_out(stage_2_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(14),
    .factors({234890903, 66148505, 41630462, 104784816,
              72738487, 22541719, 106338196, 146361539,
              170604387, 39141691, 133081916, 68136911,
              159404461, 227214070, 245906264, 91898237}))
  stage_2_butterfly_15 (
    .x_in(stage_1_per_out[30]),
    .y_in(stage_1_per_out[31]),
    .x_out(stage_2_per_in[30]),
    .y_out(stage_2_per_in[31]),
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
    .in_start(in_start[2]),
    .out_start(out_start[2]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Tian): stage 3 32 butterfly units
  butterfly #(
    .start(21),
    .factors({120670867, 78852289, 153962078, 52673254,
              103143177, 140204941, 27685019, 75324254,
              111341228, 59966873, 197386970, 39593842,
              145384235, 168270865, 227285679, 175609590}))
  stage_3_butterfly_0 (
    .x_in(stage_2_per_out[0]),
    .y_in(stage_2_per_out[1]),
    .x_out(stage_3_per_in[0]),
    .y_out(stage_3_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({120670867, 78852289, 153962078, 52673254,
              103143177, 140204941, 27685019, 75324254,
              111341228, 59966873, 197386970, 39593842,
              145384235, 168270865, 227285679, 175609590}))
  stage_3_butterfly_1 (
    .x_in(stage_2_per_out[2]),
    .y_in(stage_2_per_out[3]),
    .x_out(stage_3_per_in[2]),
    .y_out(stage_3_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({120670867, 78852289, 153962078, 52673254,
              103143177, 140204941, 27685019, 75324254,
              111341228, 59966873, 197386970, 39593842,
              145384235, 168270865, 227285679, 175609590}))
  stage_3_butterfly_2 (
    .x_in(stage_2_per_out[4]),
    .y_in(stage_2_per_out[5]),
    .x_out(stage_3_per_in[4]),
    .y_out(stage_3_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({120670867, 78852289, 153962078, 52673254,
              103143177, 140204941, 27685019, 75324254,
              111341228, 59966873, 197386970, 39593842,
              145384235, 168270865, 227285679, 175609590}))
  stage_3_butterfly_3 (
    .x_in(stage_2_per_out[6]),
    .y_in(stage_2_per_out[7]),
    .x_out(stage_3_per_in[6]),
    .y_out(stage_3_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({120670867, 78852289, 153962078, 52673254,
              103143177, 140204941, 27685019, 75324254,
              111341228, 59966873, 197386970, 39593842,
              145384235, 168270865, 227285679, 175609590}))
  stage_3_butterfly_4 (
    .x_in(stage_2_per_out[8]),
    .y_in(stage_2_per_out[9]),
    .x_out(stage_3_per_in[8]),
    .y_out(stage_3_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({120670867, 78852289, 153962078, 52673254,
              103143177, 140204941, 27685019, 75324254,
              111341228, 59966873, 197386970, 39593842,
              145384235, 168270865, 227285679, 175609590}))
  stage_3_butterfly_5 (
    .x_in(stage_2_per_out[10]),
    .y_in(stage_2_per_out[11]),
    .x_out(stage_3_per_in[10]),
    .y_out(stage_3_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({120670867, 78852289, 153962078, 52673254,
              103143177, 140204941, 27685019, 75324254,
              111341228, 59966873, 197386970, 39593842,
              145384235, 168270865, 227285679, 175609590}))
  stage_3_butterfly_6 (
    .x_in(stage_2_per_out[12]),
    .y_in(stage_2_per_out[13]),
    .x_out(stage_3_per_in[12]),
    .y_out(stage_3_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({120670867, 78852289, 153962078, 52673254,
              103143177, 140204941, 27685019, 75324254,
              111341228, 59966873, 197386970, 39593842,
              145384235, 168270865, 227285679, 175609590}))
  stage_3_butterfly_7 (
    .x_in(stage_2_per_out[14]),
    .y_in(stage_2_per_out[15]),
    .x_out(stage_3_per_in[14]),
    .y_out(stage_3_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({181852808, 49823188, 11695616, 95727610,
              6323336, 97617150, 47317233, 17079898,
              30748955, 109254766, 149145314, 239095400,
              155896930, 71471012, 76642651, 115504656}))
  stage_3_butterfly_8 (
    .x_in(stage_2_per_out[16]),
    .y_in(stage_2_per_out[17]),
    .x_out(stage_3_per_in[16]),
    .y_out(stage_3_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({181852808, 49823188, 11695616, 95727610,
              6323336, 97617150, 47317233, 17079898,
              30748955, 109254766, 149145314, 239095400,
              155896930, 71471012, 76642651, 115504656}))
  stage_3_butterfly_9 (
    .x_in(stage_2_per_out[18]),
    .y_in(stage_2_per_out[19]),
    .x_out(stage_3_per_in[18]),
    .y_out(stage_3_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({181852808, 49823188, 11695616, 95727610,
              6323336, 97617150, 47317233, 17079898,
              30748955, 109254766, 149145314, 239095400,
              155896930, 71471012, 76642651, 115504656}))
  stage_3_butterfly_10 (
    .x_in(stage_2_per_out[20]),
    .y_in(stage_2_per_out[21]),
    .x_out(stage_3_per_in[20]),
    .y_out(stage_3_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({181852808, 49823188, 11695616, 95727610,
              6323336, 97617150, 47317233, 17079898,
              30748955, 109254766, 149145314, 239095400,
              155896930, 71471012, 76642651, 115504656}))
  stage_3_butterfly_11 (
    .x_in(stage_2_per_out[22]),
    .y_in(stage_2_per_out[23]),
    .x_out(stage_3_per_in[22]),
    .y_out(stage_3_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({181852808, 49823188, 11695616, 95727610,
              6323336, 97617150, 47317233, 17079898,
              30748955, 109254766, 149145314, 239095400,
              155896930, 71471012, 76642651, 115504656}))
  stage_3_butterfly_12 (
    .x_in(stage_2_per_out[24]),
    .y_in(stage_2_per_out[25]),
    .x_out(stage_3_per_in[24]),
    .y_out(stage_3_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({181852808, 49823188, 11695616, 95727610,
              6323336, 97617150, 47317233, 17079898,
              30748955, 109254766, 149145314, 239095400,
              155896930, 71471012, 76642651, 115504656}))
  stage_3_butterfly_13 (
    .x_in(stage_2_per_out[26]),
    .y_in(stage_2_per_out[27]),
    .x_out(stage_3_per_in[26]),
    .y_out(stage_3_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({181852808, 49823188, 11695616, 95727610,
              6323336, 97617150, 47317233, 17079898,
              30748955, 109254766, 149145314, 239095400,
              155896930, 71471012, 76642651, 115504656}))
  stage_3_butterfly_14 (
    .x_in(stage_2_per_out[28]),
    .y_in(stage_2_per_out[29]),
    .x_out(stage_3_per_in[28]),
    .y_out(stage_3_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(21),
    .factors({181852808, 49823188, 11695616, 95727610,
              6323336, 97617150, 47317233, 17079898,
              30748955, 109254766, 149145314, 239095400,
              155896930, 71471012, 76642651, 115504656}))
  stage_3_butterfly_15 (
    .x_in(stage_2_per_out[30]),
    .y_in(stage_2_per_out[31]),
    .x_out(stage_3_per_in[30]),
    .y_out(stage_3_per_in[31]),
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
    .in_start(in_start[3]),
    .out_start(out_start[3]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 4 32 butterfly units
  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_0 (
    .x_in(stage_3_per_out[0]),
    .y_in(stage_3_per_out[1]),
    .x_out(stage_4_per_in[0]),
    .y_out(stage_4_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_1 (
    .x_in(stage_3_per_out[2]),
    .y_in(stage_3_per_out[3]),
    .x_out(stage_4_per_in[2]),
    .y_out(stage_4_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_2 (
    .x_in(stage_3_per_out[4]),
    .y_in(stage_3_per_out[5]),
    .x_out(stage_4_per_in[4]),
    .y_out(stage_4_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_3 (
    .x_in(stage_3_per_out[6]),
    .y_in(stage_3_per_out[7]),
    .x_out(stage_4_per_in[6]),
    .y_out(stage_4_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_4 (
    .x_in(stage_3_per_out[8]),
    .y_in(stage_3_per_out[9]),
    .x_out(stage_4_per_in[8]),
    .y_out(stage_4_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_5 (
    .x_in(stage_3_per_out[10]),
    .y_in(stage_3_per_out[11]),
    .x_out(stage_4_per_in[10]),
    .y_out(stage_4_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_6 (
    .x_in(stage_3_per_out[12]),
    .y_in(stage_3_per_out[13]),
    .x_out(stage_4_per_in[12]),
    .y_out(stage_4_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_7 (
    .x_in(stage_3_per_out[14]),
    .y_in(stage_3_per_out[15]),
    .x_out(stage_4_per_in[14]),
    .y_out(stage_4_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_8 (
    .x_in(stage_3_per_out[16]),
    .y_in(stage_3_per_out[17]),
    .x_out(stage_4_per_in[16]),
    .y_out(stage_4_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_9 (
    .x_in(stage_3_per_out[18]),
    .y_in(stage_3_per_out[19]),
    .x_out(stage_4_per_in[18]),
    .y_out(stage_4_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_10 (
    .x_in(stage_3_per_out[20]),
    .y_in(stage_3_per_out[21]),
    .x_out(stage_4_per_in[20]),
    .y_out(stage_4_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_11 (
    .x_in(stage_3_per_out[22]),
    .y_in(stage_3_per_out[23]),
    .x_out(stage_4_per_in[22]),
    .y_out(stage_4_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_12 (
    .x_in(stage_3_per_out[24]),
    .y_in(stage_3_per_out[25]),
    .x_out(stage_4_per_in[24]),
    .y_out(stage_4_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_13 (
    .x_in(stage_3_per_out[26]),
    .y_in(stage_3_per_out[27]),
    .x_out(stage_4_per_in[26]),
    .y_out(stage_4_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_14 (
    .x_in(stage_3_per_out[28]),
    .y_in(stage_3_per_out[29]),
    .x_out(stage_4_per_in[28]),
    .y_out(stage_4_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(28),
    .factors({94135184, 51997749, 178374402, 108349160,
              124730815, 229105823, 76573097, 19095174,
              129001811, 148889498, 84893967, 165596304,
              194544757, 18533839, 175625696, 184798272}))
  stage_4_butterfly_15 (
    .x_in(stage_3_per_out[30]),
    .y_in(stage_3_per_out[31]),
    .x_out(stage_4_per_in[30]),
    .y_out(stage_4_per_in[31]),
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
    .in_start(in_start[4]),
    .out_start(out_start[4]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 5 32 butterfly units
  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_0 (
    .x_in(stage_4_per_out[0]),
    .y_in(stage_4_per_out[1]),
    .x_out(stage_5_per_in[0]),
    .y_out(stage_5_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_1 (
    .x_in(stage_4_per_out[2]),
    .y_in(stage_4_per_out[3]),
    .x_out(stage_5_per_in[2]),
    .y_out(stage_5_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_2 (
    .x_in(stage_4_per_out[4]),
    .y_in(stage_4_per_out[5]),
    .x_out(stage_5_per_in[4]),
    .y_out(stage_5_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_3 (
    .x_in(stage_4_per_out[6]),
    .y_in(stage_4_per_out[7]),
    .x_out(stage_5_per_in[6]),
    .y_out(stage_5_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_4 (
    .x_in(stage_4_per_out[8]),
    .y_in(stage_4_per_out[9]),
    .x_out(stage_5_per_in[8]),
    .y_out(stage_5_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_5 (
    .x_in(stage_4_per_out[10]),
    .y_in(stage_4_per_out[11]),
    .x_out(stage_5_per_in[10]),
    .y_out(stage_5_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_6 (
    .x_in(stage_4_per_out[12]),
    .y_in(stage_4_per_out[13]),
    .x_out(stage_5_per_in[12]),
    .y_out(stage_5_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_7 (
    .x_in(stage_4_per_out[14]),
    .y_in(stage_4_per_out[15]),
    .x_out(stage_5_per_in[14]),
    .y_out(stage_5_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_8 (
    .x_in(stage_4_per_out[16]),
    .y_in(stage_4_per_out[17]),
    .x_out(stage_5_per_in[16]),
    .y_out(stage_5_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_9 (
    .x_in(stage_4_per_out[18]),
    .y_in(stage_4_per_out[19]),
    .x_out(stage_5_per_in[18]),
    .y_out(stage_5_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_10 (
    .x_in(stage_4_per_out[20]),
    .y_in(stage_4_per_out[21]),
    .x_out(stage_5_per_in[20]),
    .y_out(stage_5_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_11 (
    .x_in(stage_4_per_out[22]),
    .y_in(stage_4_per_out[23]),
    .x_out(stage_5_per_in[22]),
    .y_out(stage_5_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_12 (
    .x_in(stage_4_per_out[24]),
    .y_in(stage_4_per_out[25]),
    .x_out(stage_5_per_in[24]),
    .y_out(stage_5_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_13 (
    .x_in(stage_4_per_out[26]),
    .y_in(stage_4_per_out[27]),
    .x_out(stage_5_per_in[26]),
    .y_out(stage_5_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_14 (
    .x_in(stage_4_per_out[28]),
    .y_in(stage_4_per_out[29]),
    .x_out(stage_5_per_in[28]),
    .y_out(stage_5_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(46),
    .factors({42982065, 135333989, 163057267, 194721725,
              197853640, 131414476, 25800822, 46265048,
              69075086, 125976015, 234985940, 220769014,
              260567810, 155624840, 210749829, 133782759}))
  stage_5_butterfly_15 (
    .x_in(stage_4_per_out[30]),
    .y_in(stage_4_per_out[31]),
    .x_out(stage_5_per_in[30]),
    .y_out(stage_5_per_in[31]),
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
    .in_start(in_start[5]),
    .out_start(out_start[5]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 6 32 butterfly units
  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_0 (
    .x_in(stage_5_per_out[0]),
    .y_in(stage_5_per_out[1]),
    .x_out(stage_6_per_in[0]),
    .y_out(stage_6_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_1 (
    .x_in(stage_5_per_out[2]),
    .y_in(stage_5_per_out[3]),
    .x_out(stage_6_per_in[2]),
    .y_out(stage_6_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_2 (
    .x_in(stage_5_per_out[4]),
    .y_in(stage_5_per_out[5]),
    .x_out(stage_6_per_in[4]),
    .y_out(stage_6_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_3 (
    .x_in(stage_5_per_out[6]),
    .y_in(stage_5_per_out[7]),
    .x_out(stage_6_per_in[6]),
    .y_out(stage_6_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_4 (
    .x_in(stage_5_per_out[8]),
    .y_in(stage_5_per_out[9]),
    .x_out(stage_6_per_in[8]),
    .y_out(stage_6_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_5 (
    .x_in(stage_5_per_out[10]),
    .y_in(stage_5_per_out[11]),
    .x_out(stage_6_per_in[10]),
    .y_out(stage_6_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_6 (
    .x_in(stage_5_per_out[12]),
    .y_in(stage_5_per_out[13]),
    .x_out(stage_6_per_in[12]),
    .y_out(stage_6_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_7 (
    .x_in(stage_5_per_out[14]),
    .y_in(stage_5_per_out[15]),
    .x_out(stage_6_per_in[14]),
    .y_out(stage_6_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_8 (
    .x_in(stage_5_per_out[16]),
    .y_in(stage_5_per_out[17]),
    .x_out(stage_6_per_in[16]),
    .y_out(stage_6_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_9 (
    .x_in(stage_5_per_out[18]),
    .y_in(stage_5_per_out[19]),
    .x_out(stage_6_per_in[18]),
    .y_out(stage_6_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_10 (
    .x_in(stage_5_per_out[20]),
    .y_in(stage_5_per_out[21]),
    .x_out(stage_6_per_in[20]),
    .y_out(stage_6_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_11 (
    .x_in(stage_5_per_out[22]),
    .y_in(stage_5_per_out[23]),
    .x_out(stage_6_per_in[22]),
    .y_out(stage_6_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_12 (
    .x_in(stage_5_per_out[24]),
    .y_in(stage_5_per_out[25]),
    .x_out(stage_6_per_in[24]),
    .y_out(stage_6_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_13 (
    .x_in(stage_5_per_out[26]),
    .y_in(stage_5_per_out[27]),
    .x_out(stage_6_per_in[26]),
    .y_out(stage_6_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_14 (
    .x_in(stage_5_per_out[28]),
    .y_in(stage_5_per_out[29]),
    .x_out(stage_6_per_in[28]),
    .y_out(stage_6_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(65),
    .factors({180609988, 180609988, 172037025, 172037025,
              130838261, 130838261, 219782419, 219782419,
              162923847, 162923847, 90670588, 90670588,
              197095417, 197095417, 128108241, 128108241}))
  stage_6_butterfly_15 (
    .x_in(stage_5_per_out[30]),
    .y_in(stage_5_per_out[31]),
    .x_out(stage_6_per_in[30]),
    .y_out(stage_6_per_in[31]),
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
    .in_start(in_start[6]),
    .out_start(out_start[6]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 7 32 butterfly units
  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_0 (
    .x_in(stage_6_per_out[0]),
    .y_in(stage_6_per_out[1]),
    .x_out(stage_7_per_in[0]),
    .y_out(stage_7_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_1 (
    .x_in(stage_6_per_out[2]),
    .y_in(stage_6_per_out[3]),
    .x_out(stage_7_per_in[2]),
    .y_out(stage_7_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_2 (
    .x_in(stage_6_per_out[4]),
    .y_in(stage_6_per_out[5]),
    .x_out(stage_7_per_in[4]),
    .y_out(stage_7_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_3 (
    .x_in(stage_6_per_out[6]),
    .y_in(stage_6_per_out[7]),
    .x_out(stage_7_per_in[6]),
    .y_out(stage_7_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_4 (
    .x_in(stage_6_per_out[8]),
    .y_in(stage_6_per_out[9]),
    .x_out(stage_7_per_in[8]),
    .y_out(stage_7_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_5 (
    .x_in(stage_6_per_out[10]),
    .y_in(stage_6_per_out[11]),
    .x_out(stage_7_per_in[10]),
    .y_out(stage_7_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_6 (
    .x_in(stage_6_per_out[12]),
    .y_in(stage_6_per_out[13]),
    .x_out(stage_7_per_in[12]),
    .y_out(stage_7_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_7 (
    .x_in(stage_6_per_out[14]),
    .y_in(stage_6_per_out[15]),
    .x_out(stage_7_per_in[14]),
    .y_out(stage_7_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_8 (
    .x_in(stage_6_per_out[16]),
    .y_in(stage_6_per_out[17]),
    .x_out(stage_7_per_in[16]),
    .y_out(stage_7_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_9 (
    .x_in(stage_6_per_out[18]),
    .y_in(stage_6_per_out[19]),
    .x_out(stage_7_per_in[18]),
    .y_out(stage_7_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_10 (
    .x_in(stage_6_per_out[20]),
    .y_in(stage_6_per_out[21]),
    .x_out(stage_7_per_in[20]),
    .y_out(stage_7_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_11 (
    .x_in(stage_6_per_out[22]),
    .y_in(stage_6_per_out[23]),
    .x_out(stage_7_per_in[22]),
    .y_out(stage_7_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_12 (
    .x_in(stage_6_per_out[24]),
    .y_in(stage_6_per_out[25]),
    .x_out(stage_7_per_in[24]),
    .y_out(stage_7_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_13 (
    .x_in(stage_6_per_out[26]),
    .y_in(stage_6_per_out[27]),
    .x_out(stage_7_per_in[26]),
    .y_out(stage_7_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_14 (
    .x_in(stage_6_per_out[28]),
    .y_in(stage_6_per_out[29]),
    .x_out(stage_7_per_in[28]),
    .y_out(stage_7_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(86),
    .factors({250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716}))
  stage_7_butterfly_15 (
    .x_in(stage_6_per_out[30]),
    .y_in(stage_6_per_out[31]),
    .x_out(stage_7_per_in[30]),
    .y_out(stage_7_per_in[31]),
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
    .in_start(in_start[7]),
    .out_start(out_start[7]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 8 32 butterfly units
  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_0 (
    .x_in(stage_7_per_out[0]),
    .y_in(stage_7_per_out[1]),
    .x_out(stage_8_per_in[0]),
    .y_out(stage_8_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_1 (
    .x_in(stage_7_per_out[2]),
    .y_in(stage_7_per_out[3]),
    .x_out(stage_8_per_in[2]),
    .y_out(stage_8_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_2 (
    .x_in(stage_7_per_out[4]),
    .y_in(stage_7_per_out[5]),
    .x_out(stage_8_per_in[4]),
    .y_out(stage_8_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_3 (
    .x_in(stage_7_per_out[6]),
    .y_in(stage_7_per_out[7]),
    .x_out(stage_8_per_in[6]),
    .y_out(stage_8_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_4 (
    .x_in(stage_7_per_out[8]),
    .y_in(stage_7_per_out[9]),
    .x_out(stage_8_per_in[8]),
    .y_out(stage_8_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_5 (
    .x_in(stage_7_per_out[10]),
    .y_in(stage_7_per_out[11]),
    .x_out(stage_8_per_in[10]),
    .y_out(stage_8_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_6 (
    .x_in(stage_7_per_out[12]),
    .y_in(stage_7_per_out[13]),
    .x_out(stage_8_per_in[12]),
    .y_out(stage_8_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_7 (
    .x_in(stage_7_per_out[14]),
    .y_in(stage_7_per_out[15]),
    .x_out(stage_8_per_in[14]),
    .y_out(stage_8_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_8 (
    .x_in(stage_7_per_out[16]),
    .y_in(stage_7_per_out[17]),
    .x_out(stage_8_per_in[16]),
    .y_out(stage_8_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_9 (
    .x_in(stage_7_per_out[18]),
    .y_in(stage_7_per_out[19]),
    .x_out(stage_8_per_in[18]),
    .y_out(stage_8_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_10 (
    .x_in(stage_7_per_out[20]),
    .y_in(stage_7_per_out[21]),
    .x_out(stage_8_per_in[20]),
    .y_out(stage_8_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_11 (
    .x_in(stage_7_per_out[22]),
    .y_in(stage_7_per_out[23]),
    .x_out(stage_8_per_in[22]),
    .y_out(stage_8_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_12 (
    .x_in(stage_7_per_out[24]),
    .y_in(stage_7_per_out[25]),
    .x_out(stage_8_per_in[24]),
    .y_out(stage_8_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_13 (
    .x_in(stage_7_per_out[26]),
    .y_in(stage_7_per_out[27]),
    .x_out(stage_8_per_in[26]),
    .y_out(stage_8_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_14 (
    .x_in(stage_7_per_out[28]),
    .y_in(stage_7_per_out[29]),
    .x_out(stage_8_per_in[28]),
    .y_out(stage_8_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(111),
    .factors({185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_15 (
    .x_in(stage_7_per_out[30]),
    .y_in(stage_7_per_out[31]),
    .x_out(stage_8_per_in[30]),
    .y_out(stage_8_per_in[31]),
    .clk(clk),
    .rst(rst)
  );


  // TODO(Yang): stage 8 -> stage 9 permutation
  // FIXME: ignore butterfly units for now.
  stage_8_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_8_9_per (
    .inData_0(stage_8_per_in[0]),
    .inData_1(stage_8_per_in[1]),
    .inData_2(stage_8_per_in[2]),
    .inData_3(stage_8_per_in[3]),
    .inData_4(stage_8_per_in[4]),
    .inData_5(stage_8_per_in[5]),
    .inData_6(stage_8_per_in[6]),
    .inData_7(stage_8_per_in[7]),
    .inData_8(stage_8_per_in[8]),
    .inData_9(stage_8_per_in[9]),
    .inData_10(stage_8_per_in[10]),
    .inData_11(stage_8_per_in[11]),
    .inData_12(stage_8_per_in[12]),
    .inData_13(stage_8_per_in[13]),
    .inData_14(stage_8_per_in[14]),
    .inData_15(stage_8_per_in[15]),
    .inData_16(stage_8_per_in[16]),
    .inData_17(stage_8_per_in[17]),
    .inData_18(stage_8_per_in[18]),
    .inData_19(stage_8_per_in[19]),
    .inData_20(stage_8_per_in[20]),
    .inData_21(stage_8_per_in[21]),
    .inData_22(stage_8_per_in[22]),
    .inData_23(stage_8_per_in[23]),
    .inData_24(stage_8_per_in[24]),
    .inData_25(stage_8_per_in[25]),
    .inData_26(stage_8_per_in[26]),
    .inData_27(stage_8_per_in[27]),
    .inData_28(stage_8_per_in[28]),
    .inData_29(stage_8_per_in[29]),
    .inData_30(stage_8_per_in[30]),
    .inData_31(stage_8_per_in[31]),
    .outData_0(stage_8_per_out[0]),
    .outData_1(stage_8_per_out[1]),
    .outData_2(stage_8_per_out[2]),
    .outData_3(stage_8_per_out[3]),
    .outData_4(stage_8_per_out[4]),
    .outData_5(stage_8_per_out[5]),
    .outData_6(stage_8_per_out[6]),
    .outData_7(stage_8_per_out[7]),
    .outData_8(stage_8_per_out[8]),
    .outData_9(stage_8_per_out[9]),
    .outData_10(stage_8_per_out[10]),
    .outData_11(stage_8_per_out[11]),
    .outData_12(stage_8_per_out[12]),
    .outData_13(stage_8_per_out[13]),
    .outData_14(stage_8_per_out[14]),
    .outData_15(stage_8_per_out[15]),
    .outData_16(stage_8_per_out[16]),
    .outData_17(stage_8_per_out[17]),
    .outData_18(stage_8_per_out[18]),
    .outData_19(stage_8_per_out[19]),
    .outData_20(stage_8_per_out[20]),
    .outData_21(stage_8_per_out[21]),
    .outData_22(stage_8_per_out[22]),
    .outData_23(stage_8_per_out[23]),
    .outData_24(stage_8_per_out[24]),
    .outData_25(stage_8_per_out[25]),
    .outData_26(stage_8_per_out[26]),
    .outData_27(stage_8_per_out[27]),
    .outData_28(stage_8_per_out[28]),
    .outData_29(stage_8_per_out[29]),
    .outData_30(stage_8_per_out[30]),
    .outData_31(stage_8_per_out[31]),
    .in_start(in_start[8]),
    .out_start(out_start[8]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 9 32 butterfly units
  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_0 (
    .x_in(stage_8_per_out[0]),
    .y_in(stage_8_per_out[1]),
    .x_out(outData[0]),
    .y_out(outData[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_1 (
    .x_in(stage_8_per_out[2]),
    .y_in(stage_8_per_out[3]),
    .x_out(outData[2]),
    .y_out(outData[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_2 (
    .x_in(stage_8_per_out[4]),
    .y_in(stage_8_per_out[5]),
    .x_out(outData[4]),
    .y_out(outData[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_3 (
    .x_in(stage_8_per_out[6]),
    .y_in(stage_8_per_out[7]),
    .x_out(outData[6]),
    .y_out(outData[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_4 (
    .x_in(stage_8_per_out[8]),
    .y_in(stage_8_per_out[9]),
    .x_out(outData[8]),
    .y_out(outData[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_5 (
    .x_in(stage_8_per_out[10]),
    .y_in(stage_8_per_out[11]),
    .x_out(outData[10]),
    .y_out(outData[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_6 (
    .x_in(stage_8_per_out[12]),
    .y_in(stage_8_per_out[13]),
    .x_out(outData[12]),
    .y_out(outData[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_7 (
    .x_in(stage_8_per_out[14]),
    .y_in(stage_8_per_out[15]),
    .x_out(outData[14]),
    .y_out(outData[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_8 (
    .x_in(stage_8_per_out[16]),
    .y_in(stage_8_per_out[17]),
    .x_out(outData[16]),
    .y_out(outData[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_9 (
    .x_in(stage_8_per_out[18]),
    .y_in(stage_8_per_out[19]),
    .x_out(outData[18]),
    .y_out(outData[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_10 (
    .x_in(stage_8_per_out[20]),
    .y_in(stage_8_per_out[21]),
    .x_out(outData[20]),
    .y_out(outData[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_11 (
    .x_in(stage_8_per_out[22]),
    .y_in(stage_8_per_out[23]),
    .x_out(outData[22]),
    .y_out(outData[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_12 (
    .x_in(stage_8_per_out[24]),
    .y_in(stage_8_per_out[25]),
    .x_out(outData[24]),
    .y_out(outData[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_13 (
    .x_in(stage_8_per_out[26]),
    .y_in(stage_8_per_out[27]),
    .x_out(outData[26]),
    .y_out(outData[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_14 (
    .x_in(stage_8_per_out[28]),
    .y_in(stage_8_per_out[29]),
    .x_out(outData[28]),
    .y_out(outData[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(144),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_15 (
    .x_in(stage_8_per_out[30]),
    .y_in(stage_8_per_out[31]),
    .x_out(outData[30]),
    .y_out(outData[31]),
    .clk(clk),
    .rst(rst)
  );


endmodule
