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

  parameter [7:0] START_CYCLE[10] = {0, 7, 14, 21, 28, 49, 71, 95, 123, 159};

  // TODO(Tian): stage 0 32 butterfly units
  butterfly #(
    .start(START_CYCLE[0]),
    .factors({326097, 166586238, 244423105, 118444917, 131309632, 146761160, 5445105, 206116619,
              168342750, 62435894, 12817079, 116257755, 67241659, 183669067, 244593894, 259895089,
              201160126, 173513151, 245041907, 168470500, 107830842, 248251528, 132467399, 65498827,
              3021514, 265496406, 257426331, 36331533, 265882354, 225369834, 207530748, 1352703}))
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
    .factors({145034434, 184522009, 25030552, 125561953, 222056927, 134796549, 36620312, 207047180,
              169924108, 44888494, 132747224, 255457916, 12551837, 89987026, 58671364, 54393228,
              188526794, 24347842, 262112169, 234775081, 50162577, 222249559, 189601976, 266562472,
              34052825, 172401093, 4047489, 244216061, 30998914, 256834872, 73217275, 260993294}))
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
    .factors({63661975, 84779248, 161607031, 6001670, 103503994, 252714435, 17758040, 164728317,
              155100837, 129740611, 72509307, 263001722, 99695712, 99277398, 62094530, 183613005,
              122609533, 184177651, 146657273, 56257750, 125713617, 18205961, 79834640, 169959063,
              128159746, 141562255, 123720956, 252018541, 66582189, 32319537, 244927134, 163812077}))
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
    .factors({120466187, 236829199, 140358303, 166126182, 70017017, 103368916, 157386503, 60600589,
              149423455, 76313029, 195297575, 220838681, 225794318, 50376784, 209780385, 94206887,
              9205704, 118465017, 209744644, 21649526, 157839041, 163197321, 151855973, 217210388,
              123018041, 62765404, 128052734, 136898494, 148051010, 216819035, 259621463, 261143222}))
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
    .factors({156837559, 128995628, 55581691, 237125965, 167645260, 105793954, 243091016, 99996719,
              2204580, 7301415, 230992788, 255141549, 186531585, 234786570, 121730405, 200585052,
              267506256, 164154100, 62027985, 228715598, 107513427, 217763430, 251672258, 33096679,
              244783678, 196000333, 149788353, 70944317, 115050087, 147224860, 257402730, 54916848}))
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
    .factors({101188020, 20655050, 246741831, 17642100, 77119896, 229954056, 202565947, 165180840,
              24036023, 249936132, 55944760, 249947221, 94686133, 92902456, 167758747, 119720513,
              71304140, 190453366, 65889055, 251717800, 102034957, 83905910, 17682401, 77536776,
              19637177, 205242220, 78612624, 223014301, 157991445, 160429892, 211201491, 97171493}))
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
    .factors({254234203, 173628384, 94079265, 135921552, 69205492, 195181845, 210423079, 20041783,
              164473684, 136710753, 59214954, 121414397, 206844979, 107152911, 8650362, 266777211,
              242301146, 261541195, 118320134, 141206585, 92420698, 213655453, 232847226, 84669572,
              5161923, 108382823, 209708523, 254842567, 159538295, 198336839, 263725948, 93757293}))
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
    .factors({192680819, 209878720, 236528116, 218380292, 190540901, 1592538, 76624935, 4457103,
              75195548, 193897399, 241071152, 112070980, 215085706, 92770973, 50174239, 164079161,
              187208958, 209112367, 60492437, 224550271, 112756762, 38252193, 86776671, 194887964,
              212422509, 87202745, 224322272, 171206517, 246787643, 81893503, 105443909, 75993973}))
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
    .factors({180764097, 85740049, 199352295, 227628318, 195298807, 37498403, 115053845, 115132688,
              124558832, 259533807, 101579460, 4721397, 174028560, 69313946, 228243008, 219133933,
              126413069, 37504237, 172655984, 214937778, 212287973, 18793692, 29779638, 266352891,
              133273987, 51838504, 266514716, 212728405, 248946430, 36492987, 161626887, 41535530}))
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
    .factors({172715743, 211646222, 160050812, 92379159, 100343421, 79121706, 232156312, 184560259,
              242717180, 237395333, 64518939, 127102737, 119890469, 5267255, 247452694, 193438424,
              212237706, 85566308, 34932582, 86350556, 107138937, 155363318, 102698816, 219484262,
              138692846, 109455096, 86359417, 113049121, 53025186, 168826669, 29901564, 169792793}))
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
    .factors({245986816, 9793208, 24365404, 138675463, 255658390, 29594281, 126749676, 10646661,
              135080569, 255478273, 128627235, 123052007, 79336225, 161345834, 207021189, 40916099,
              92659465, 178220347, 90701762, 107503597, 144502563, 93978858, 148152811, 62456195,
              79230237, 157649589, 195692414, 39337018, 170100736, 232740066, 183571221, 175928561}))
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
    .factors({53126225, 3260661, 56387579, 193451294, 236209279, 255737752, 117072589, 1361486,
              59894768, 82321748, 134804553, 78552959, 46197346, 91397014, 111835742, 212162524,
              256083096, 248465751, 31964447, 134417077, 135271820, 179341437, 248922055, 64830196,
              190586128, 148108490, 108164959, 7280660, 247116469, 509728, 146399832, 139044757}))
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
    .factors({52844710, 170230234, 46282885, 66337349, 110055875, 187867192, 156195364, 181617487,
              255463943, 140450929, 261458154, 263649093, 55222727, 78273516, 248669125, 8259535,
              2486257, 94178347, 193911793, 79325117, 1991289, 104546781, 139101859, 224391994,
              102785717, 231354349, 145056180, 140072656, 218286321, 29537138, 209643171, 50523873}))
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
    .factors({19058782, 41388380, 185175266, 36196902, 233967292, 222527593, 121355275, 3395282,
              156009907, 248552245, 159148996, 187988754, 12591284, 42344203, 243047656, 226759664,
              112825183, 116527240, 32097135, 209466626, 81263879, 60051251, 70325928, 134208656,
              237616434, 154317057, 81197166, 130154791, 190565686, 151857114, 9067201, 223473865}))
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
    .factors({43447238, 180877891, 160048836, 233083676, 142941966, 132190398, 99012968, 66412546,
              227454343, 110302060, 262630184, 10310370, 174856430, 195270185, 250031819, 211824237,
              217359458, 253487730, 72351531, 164248031, 94792077, 83977288, 62688241, 80988251,
              20236367, 240930884, 22997488, 108391208, 173933513, 148289274, 146205579, 584543}))
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
    .factors({177682833, 210373784, 129856203, 185590576, 139780710, 122538584, 159491687, 3341663,
              256519333, 145914728, 122025398, 203598031, 203905228, 148491526, 213678985, 62513408,
              198957507, 185886007, 243009216, 81414740, 122969043, 194684542, 166139329, 222912429,
              171841734, 189909138, 133808889, 261608985, 176911171, 154298223, 77127228, 39797461}))
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
    .start(START_CYCLE[1]),
    .factors({64764693, 250071443, 101414187, 257649131, 43104106, 134269022, 196328787, 206795535,
              182691070, 25853611, 234350511, 109642647, 97007849, 61997323, 227651751, 8950678,
              193296437, 205525433, 5299132, 57574719, 17861009, 126188511, 28242170, 263530653,
              138879618, 151095818, 206252403, 149992379, 184310992, 183029478, 56155754, 59284831}))
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
    .factors({64764693, 250071443, 101414187, 257649131, 43104106, 134269022, 196328787, 206795535,
              182691070, 25853611, 234350511, 109642647, 97007849, 61997323, 227651751, 8950678,
              193296437, 205525433, 5299132, 57574719, 17861009, 126188511, 28242170, 263530653,
              138879618, 151095818, 206252403, 149992379, 184310992, 183029478, 56155754, 59284831}))
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
    .factors({194276347, 95434564, 48471700, 237102043, 185138250, 44144526, 177340471, 42980173,
              257269778, 149200070, 172508742, 266756542, 117507527, 200749611, 154421517, 176665584,
              62408001, 76925614, 34256894, 186863562, 134877507, 35754446, 157966005, 233888407,
              206725018, 60548134, 126945619, 68559335, 195748297, 113309038, 95282463, 144929841}))
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
    .factors({194276347, 95434564, 48471700, 237102043, 185138250, 44144526, 177340471, 42980173,
              257269778, 149200070, 172508742, 266756542, 117507527, 200749611, 154421517, 176665584,
              62408001, 76925614, 34256894, 186863562, 134877507, 35754446, 157966005, 233888407,
              206725018, 60548134, 126945619, 68559335, 195748297, 113309038, 95282463, 144929841}))
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
    .factors({223822620, 61720173, 131023241, 202059197, 34971158, 125267062, 173118058, 247289727,
              262077011, 49675259, 262358962, 23892097, 225784463, 232451599, 218231468, 210914061,
              117221766, 202955937, 42719459, 87074609, 67225153, 78649100, 23405380, 219738759,
              140366124, 176209504, 61345534, 201047927, 61040039, 266671862, 173757017, 69773246}))
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
    .factors({223822620, 61720173, 131023241, 202059197, 34971158, 125267062, 173118058, 247289727,
              262077011, 49675259, 262358962, 23892097, 225784463, 232451599, 218231468, 210914061,
              117221766, 202955937, 42719459, 87074609, 67225153, 78649100, 23405380, 219738759,
              140366124, 176209504, 61345534, 201047927, 61040039, 266671862, 173757017, 69773246}))
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
    .factors({209886001, 219083512, 210770212, 10143115, 199876762, 186841927, 97318594, 47879495,
              231423732, 139268485, 226213489, 165872957, 202776751, 56943278, 251138298, 92650808,
              224068691, 78049958, 43783325, 100229847, 160841949, 98889920, 178386996, 243681494,
              73081523, 138793148, 258527796, 202127782, 187864761, 243024363, 10003248, 65324949}))
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
    .factors({209886001, 219083512, 210770212, 10143115, 199876762, 186841927, 97318594, 47879495,
              231423732, 139268485, 226213489, 165872957, 202776751, 56943278, 251138298, 92650808,
              224068691, 78049958, 43783325, 100229847, 160841949, 98889920, 178386996, 243681494,
              73081523, 138793148, 258527796, 202127782, 187864761, 243024363, 10003248, 65324949}))
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
    .factors({196522490, 200399539, 249146534, 55567611, 123335450, 122332647, 103731033, 184644727,
              53222994, 49504466, 137672988, 247253507, 143779572, 107197955, 74454717, 238382196,
              212275822, 244763177, 259958064, 79136411, 254132077, 132483080, 45686070, 190388461,
              5829490, 75537498, 209725121, 95560742, 251384491, 137065607, 114486793, 49057739}))
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
    .factors({196522490, 200399539, 249146534, 55567611, 123335450, 122332647, 103731033, 184644727,
              53222994, 49504466, 137672988, 247253507, 143779572, 107197955, 74454717, 238382196,
              212275822, 244763177, 259958064, 79136411, 254132077, 132483080, 45686070, 190388461,
              5829490, 75537498, 209725121, 95560742, 251384491, 137065607, 114486793, 49057739}))
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
    .factors({222861227, 101003336, 1562592, 34855849, 174629071, 256272276, 258257144, 255286072,
              158168844, 73698550, 209583375, 232445568, 112003761, 30930936, 181167649, 165350229,
              63079505, 13458851, 14568946, 131377029, 167911982, 98085790, 141849606, 169508713,
              99392088, 188517169, 5292226, 148390399, 25944135, 227819465, 190980049, 71598752}))
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
    .factors({222861227, 101003336, 1562592, 34855849, 174629071, 256272276, 258257144, 255286072,
              158168844, 73698550, 209583375, 232445568, 112003761, 30930936, 181167649, 165350229,
              63079505, 13458851, 14568946, 131377029, 167911982, 98085790, 141849606, 169508713,
              99392088, 188517169, 5292226, 148390399, 25944135, 227819465, 190980049, 71598752}))
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
    .factors({174900371, 229100654, 82684352, 54534442, 258559590, 204886617, 170930026, 158466952,
              208297913, 43078133, 261795000, 242025902, 171541778, 246630386, 220994759, 16128104,
              109479656, 100123291, 160254284, 87088032, 66298746, 169182486, 256173379, 42355602,
              236282586, 136878682, 210734246, 85252512, 20857483, 86901749, 186214186, 50986641}))
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
    .factors({174900371, 229100654, 82684352, 54534442, 258559590, 204886617, 170930026, 158466952,
              208297913, 43078133, 261795000, 242025902, 171541778, 246630386, 220994759, 16128104,
              109479656, 100123291, 160254284, 87088032, 66298746, 169182486, 256173379, 42355602,
              236282586, 136878682, 210734246, 85252512, 20857483, 86901749, 186214186, 50986641}))
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
    .factors({260909397, 236109059, 50222736, 198785423, 251898247, 165134943, 126063290, 160807241,
              201863951, 244216783, 26067051, 256869432, 43194148, 206705681, 224794776, 124400051,
              82934386, 85667364, 64884498, 99693395, 51974898, 102915173, 199633043, 135618975,
              56246211, 209658551, 68267735, 119568150, 228211497, 241313184, 5905084, 55609416}))
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
    .factors({260909397, 236109059, 50222736, 198785423, 251898247, 165134943, 126063290, 160807241,
              201863951, 244216783, 26067051, 256869432, 43194148, 206705681, 224794776, 124400051,
              82934386, 85667364, 64884498, 99693395, 51974898, 102915173, 199633043, 135618975,
              56246211, 209658551, 68267735, 119568150, 228211497, 241313184, 5905084, 55609416}))
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
    .start(START_CYCLE[2]),
    .factors({53818192, 149851545, 229216409, 15417588, 77337691, 21625356, 133503098, 96142103,
              18399308, 98878775, 199208174, 196436059, 254850432, 248876054, 123954975, 42733001,
              145184649, 227894900, 181639510, 166530134, 23486645, 246656426, 71064168, 18729522,
              130557622, 167885779, 85021501, 9757140, 214085592, 231358848, 27244461, 81777479}))
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
    .factors({53818192, 149851545, 229216409, 15417588, 77337691, 21625356, 133503098, 96142103,
              18399308, 98878775, 199208174, 196436059, 254850432, 248876054, 123954975, 42733001,
              145184649, 227894900, 181639510, 166530134, 23486645, 246656426, 71064168, 18729522,
              130557622, 167885779, 85021501, 9757140, 214085592, 231358848, 27244461, 81777479}))
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
    .factors({53818192, 149851545, 229216409, 15417588, 77337691, 21625356, 133503098, 96142103,
              18399308, 98878775, 199208174, 196436059, 254850432, 248876054, 123954975, 42733001,
              145184649, 227894900, 181639510, 166530134, 23486645, 246656426, 71064168, 18729522,
              130557622, 167885779, 85021501, 9757140, 214085592, 231358848, 27244461, 81777479}))
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
    .factors({53818192, 149851545, 229216409, 15417588, 77337691, 21625356, 133503098, 96142103,
              18399308, 98878775, 199208174, 196436059, 254850432, 248876054, 123954975, 42733001,
              145184649, 227894900, 181639510, 166530134, 23486645, 246656426, 71064168, 18729522,
              130557622, 167885779, 85021501, 9757140, 214085592, 231358848, 27244461, 81777479}))
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
    .factors({108810259, 227816219, 160286792, 47751177, 34119889, 104174682, 227283585, 149528048,
              50725340, 258923154, 180525688, 84143174, 220375582, 258649698, 211668928, 120936039,
              182447177, 253827407, 216143425, 256040960, 7055647, 78607636, 101483624, 116401819,
              231318087, 250166212, 161729483, 59283803, 205019884, 37936257, 243304319, 78488715}))
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
    .factors({108810259, 227816219, 160286792, 47751177, 34119889, 104174682, 227283585, 149528048,
              50725340, 258923154, 180525688, 84143174, 220375582, 258649698, 211668928, 120936039,
              182447177, 253827407, 216143425, 256040960, 7055647, 78607636, 101483624, 116401819,
              231318087, 250166212, 161729483, 59283803, 205019884, 37936257, 243304319, 78488715}))
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
    .factors({108810259, 227816219, 160286792, 47751177, 34119889, 104174682, 227283585, 149528048,
              50725340, 258923154, 180525688, 84143174, 220375582, 258649698, 211668928, 120936039,
              182447177, 253827407, 216143425, 256040960, 7055647, 78607636, 101483624, 116401819,
              231318087, 250166212, 161729483, 59283803, 205019884, 37936257, 243304319, 78488715}))
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
    .factors({108810259, 227816219, 160286792, 47751177, 34119889, 104174682, 227283585, 149528048,
              50725340, 258923154, 180525688, 84143174, 220375582, 258649698, 211668928, 120936039,
              182447177, 253827407, 216143425, 256040960, 7055647, 78607636, 101483624, 116401819,
              231318087, 250166212, 161729483, 59283803, 205019884, 37936257, 243304319, 78488715}))
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
    .factors({44942358, 204666342, 204152715, 13860432, 201357873, 106542036, 3883583, 163812837,
              171721518, 28824907, 255119583, 143969713, 252442032, 132703565, 242800442, 58071669,
              254450415, 170227406, 119707826, 27692847, 29871855, 81956368, 257268473, 6576175,
              75673633, 74998629, 234030247, 173702965, 189591954, 59208162, 184516225, 10130658}))
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
    .factors({44942358, 204666342, 204152715, 13860432, 201357873, 106542036, 3883583, 163812837,
              171721518, 28824907, 255119583, 143969713, 252442032, 132703565, 242800442, 58071669,
              254450415, 170227406, 119707826, 27692847, 29871855, 81956368, 257268473, 6576175,
              75673633, 74998629, 234030247, 173702965, 189591954, 59208162, 184516225, 10130658}))
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
    .factors({44942358, 204666342, 204152715, 13860432, 201357873, 106542036, 3883583, 163812837,
              171721518, 28824907, 255119583, 143969713, 252442032, 132703565, 242800442, 58071669,
              254450415, 170227406, 119707826, 27692847, 29871855, 81956368, 257268473, 6576175,
              75673633, 74998629, 234030247, 173702965, 189591954, 59208162, 184516225, 10130658}))
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
    .factors({44942358, 204666342, 204152715, 13860432, 201357873, 106542036, 3883583, 163812837,
              171721518, 28824907, 255119583, 143969713, 252442032, 132703565, 242800442, 58071669,
              254450415, 170227406, 119707826, 27692847, 29871855, 81956368, 257268473, 6576175,
              75673633, 74998629, 234030247, 173702965, 189591954, 59208162, 184516225, 10130658}))
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
    .factors({234890903, 26687688, 66148505, 212648666, 41630462, 265574867, 104784816, 155168409,
              72738487, 139555205, 22541719, 37667151, 106338196, 168407516, 146361539, 71295013,
              170604387, 10571783, 39141691, 2419351, 133081916, 91452641, 68136911, 188210893,
              159404461, 150873005, 227214070, 90597117, 245906264, 236144340, 91898237, 129187632}))
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
    .factors({234890903, 26687688, 66148505, 212648666, 41630462, 265574867, 104784816, 155168409,
              72738487, 139555205, 22541719, 37667151, 106338196, 168407516, 146361539, 71295013,
              170604387, 10571783, 39141691, 2419351, 133081916, 91452641, 68136911, 188210893,
              159404461, 150873005, 227214070, 90597117, 245906264, 236144340, 91898237, 129187632}))
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
    .factors({234890903, 26687688, 66148505, 212648666, 41630462, 265574867, 104784816, 155168409,
              72738487, 139555205, 22541719, 37667151, 106338196, 168407516, 146361539, 71295013,
              170604387, 10571783, 39141691, 2419351, 133081916, 91452641, 68136911, 188210893,
              159404461, 150873005, 227214070, 90597117, 245906264, 236144340, 91898237, 129187632}))
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
    .factors({234890903, 26687688, 66148505, 212648666, 41630462, 265574867, 104784816, 155168409,
              72738487, 139555205, 22541719, 37667151, 106338196, 168407516, 146361539, 71295013,
              170604387, 10571783, 39141691, 2419351, 133081916, 91452641, 68136911, 188210893,
              159404461, 150873005, 227214070, 90597117, 245906264, 236144340, 91898237, 129187632}))
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
    .start(START_CYCLE[3]),
    .factors({120670867, 66003795, 78852289, 71460019, 153962078, 233560477, 52673254, 70582130,
              103143177, 179817683, 140204941, 68315815, 27685019, 115957373, 75324254, 202257393,
              111341228, 177255039, 59966873, 102065274, 197386970, 99093252, 39593842, 82771912,
              145384235, 105996489, 168270865, 235204060, 227285679, 138074788, 175609590, 118939950}))
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
    .factors({120670867, 66003795, 78852289, 71460019, 153962078, 233560477, 52673254, 70582130,
              103143177, 179817683, 140204941, 68315815, 27685019, 115957373, 75324254, 202257393,
              111341228, 177255039, 59966873, 102065274, 197386970, 99093252, 39593842, 82771912,
              145384235, 105996489, 168270865, 235204060, 227285679, 138074788, 175609590, 118939950}))
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
    .factors({120670867, 66003795, 78852289, 71460019, 153962078, 233560477, 52673254, 70582130,
              103143177, 179817683, 140204941, 68315815, 27685019, 115957373, 75324254, 202257393,
              111341228, 177255039, 59966873, 102065274, 197386970, 99093252, 39593842, 82771912,
              145384235, 105996489, 168270865, 235204060, 227285679, 138074788, 175609590, 118939950}))
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
    .factors({120670867, 66003795, 78852289, 71460019, 153962078, 233560477, 52673254, 70582130,
              103143177, 179817683, 140204941, 68315815, 27685019, 115957373, 75324254, 202257393,
              111341228, 177255039, 59966873, 102065274, 197386970, 99093252, 39593842, 82771912,
              145384235, 105996489, 168270865, 235204060, 227285679, 138074788, 175609590, 118939950}))
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
    .factors({120670867, 66003795, 78852289, 71460019, 153962078, 233560477, 52673254, 70582130,
              103143177, 179817683, 140204941, 68315815, 27685019, 115957373, 75324254, 202257393,
              111341228, 177255039, 59966873, 102065274, 197386970, 99093252, 39593842, 82771912,
              145384235, 105996489, 168270865, 235204060, 227285679, 138074788, 175609590, 118939950}))
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
    .factors({120670867, 66003795, 78852289, 71460019, 153962078, 233560477, 52673254, 70582130,
              103143177, 179817683, 140204941, 68315815, 27685019, 115957373, 75324254, 202257393,
              111341228, 177255039, 59966873, 102065274, 197386970, 99093252, 39593842, 82771912,
              145384235, 105996489, 168270865, 235204060, 227285679, 138074788, 175609590, 118939950}))
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
    .factors({120670867, 66003795, 78852289, 71460019, 153962078, 233560477, 52673254, 70582130,
              103143177, 179817683, 140204941, 68315815, 27685019, 115957373, 75324254, 202257393,
              111341228, 177255039, 59966873, 102065274, 197386970, 99093252, 39593842, 82771912,
              145384235, 105996489, 168270865, 235204060, 227285679, 138074788, 175609590, 118939950}))
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
    .factors({120670867, 66003795, 78852289, 71460019, 153962078, 233560477, 52673254, 70582130,
              103143177, 179817683, 140204941, 68315815, 27685019, 115957373, 75324254, 202257393,
              111341228, 177255039, 59966873, 102065274, 197386970, 99093252, 39593842, 82771912,
              145384235, 105996489, 168270865, 235204060, 227285679, 138074788, 175609590, 118939950}))
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
    .factors({181852808, 146694818, 49823188, 40758458, 11695616, 189907315, 95727610, 92577793,
              6323336, 109553202, 97617150, 76707105, 47317233, 4690923, 17079898, 25574347,
              30748955, 57801361, 109254766, 157085730, 149145314, 141548072, 239095400, 143450922,
              155896930, 193689173, 71471012, 131798756, 76642651, 201062854, 115504656, 206324144}))
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
    .factors({181852808, 146694818, 49823188, 40758458, 11695616, 189907315, 95727610, 92577793,
              6323336, 109553202, 97617150, 76707105, 47317233, 4690923, 17079898, 25574347,
              30748955, 57801361, 109254766, 157085730, 149145314, 141548072, 239095400, 143450922,
              155896930, 193689173, 71471012, 131798756, 76642651, 201062854, 115504656, 206324144}))
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
    .factors({181852808, 146694818, 49823188, 40758458, 11695616, 189907315, 95727610, 92577793,
              6323336, 109553202, 97617150, 76707105, 47317233, 4690923, 17079898, 25574347,
              30748955, 57801361, 109254766, 157085730, 149145314, 141548072, 239095400, 143450922,
              155896930, 193689173, 71471012, 131798756, 76642651, 201062854, 115504656, 206324144}))
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
    .factors({181852808, 146694818, 49823188, 40758458, 11695616, 189907315, 95727610, 92577793,
              6323336, 109553202, 97617150, 76707105, 47317233, 4690923, 17079898, 25574347,
              30748955, 57801361, 109254766, 157085730, 149145314, 141548072, 239095400, 143450922,
              155896930, 193689173, 71471012, 131798756, 76642651, 201062854, 115504656, 206324144}))
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
    .factors({181852808, 146694818, 49823188, 40758458, 11695616, 189907315, 95727610, 92577793,
              6323336, 109553202, 97617150, 76707105, 47317233, 4690923, 17079898, 25574347,
              30748955, 57801361, 109254766, 157085730, 149145314, 141548072, 239095400, 143450922,
              155896930, 193689173, 71471012, 131798756, 76642651, 201062854, 115504656, 206324144}))
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
    .factors({181852808, 146694818, 49823188, 40758458, 11695616, 189907315, 95727610, 92577793,
              6323336, 109553202, 97617150, 76707105, 47317233, 4690923, 17079898, 25574347,
              30748955, 57801361, 109254766, 157085730, 149145314, 141548072, 239095400, 143450922,
              155896930, 193689173, 71471012, 131798756, 76642651, 201062854, 115504656, 206324144}))
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
    .factors({181852808, 146694818, 49823188, 40758458, 11695616, 189907315, 95727610, 92577793,
              6323336, 109553202, 97617150, 76707105, 47317233, 4690923, 17079898, 25574347,
              30748955, 57801361, 109254766, 157085730, 149145314, 141548072, 239095400, 143450922,
              155896930, 193689173, 71471012, 131798756, 76642651, 201062854, 115504656, 206324144}))
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
    .factors({181852808, 146694818, 49823188, 40758458, 11695616, 189907315, 95727610, 92577793,
              6323336, 109553202, 97617150, 76707105, 47317233, 4690923, 17079898, 25574347,
              30748955, 57801361, 109254766, 157085730, 149145314, 141548072, 239095400, 143450922,
              155896930, 193689173, 71471012, 131798756, 76642651, 201062854, 115504656, 206324144}))
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
    .start(START_CYCLE[4]),
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .factors({94135184, 231414272, 51997749, 46529833, 178374402, 220656190, 108349160, 85069259,
              124730815, 11699091, 229105823, 234642902, 76573097, 233080466, 19095174, 62061822,
              129001811, 196308904, 148889498, 102579498, 84893967, 210831626, 165596304, 3179002,
              194544757, 196317032, 18533839, 99790517, 175625696, 263111217, 184798272, 47877183}))
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
    .start(START_CYCLE[5]),
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .factors({42982065, 42982065, 135333989, 135333989, 163057267, 163057267, 194721725, 194721725,
              197853640, 197853640, 131414476, 131414476, 25800822, 25800822, 46265048, 46265048,
              69075086, 69075086, 125976015, 125976015, 234985940, 234985940, 220769014, 220769014,
              260567810, 260567810, 155624840, 155624840, 210749829, 210749829, 133782759, 133782759}))
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
    .start(START_CYCLE[6]),
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .factors({180609988, 180609988, 180609988, 180609988, 172037025, 172037025, 172037025, 172037025,
              130838261, 130838261, 130838261, 130838261, 219782419, 219782419, 219782419, 219782419,
              162923847, 162923847, 162923847, 162923847, 90670588, 90670588, 90670588, 90670588,
              197095417, 197095417, 197095417, 197095417, 128108241, 128108241, 128108241, 128108241}))
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
    .start(START_CYCLE[7]),
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461, 250183461,
              180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806, 180167806,
              69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326, 69574326,
              174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716, 174860716}))
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_0 (
    .x_in(stage_7_per_out[0]),
    .y_in(stage_7_per_out[1]),
    .x_out(stage_8_per_in[0]),
    .y_out(stage_8_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_1 (
    .x_in(stage_7_per_out[2]),
    .y_in(stage_7_per_out[3]),
    .x_out(stage_8_per_in[2]),
    .y_out(stage_8_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_2 (
    .x_in(stage_7_per_out[4]),
    .y_in(stage_7_per_out[5]),
    .x_out(stage_8_per_in[4]),
    .y_out(stage_8_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_3 (
    .x_in(stage_7_per_out[6]),
    .y_in(stage_7_per_out[7]),
    .x_out(stage_8_per_in[6]),
    .y_out(stage_8_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_4 (
    .x_in(stage_7_per_out[8]),
    .y_in(stage_7_per_out[9]),
    .x_out(stage_8_per_in[8]),
    .y_out(stage_8_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_5 (
    .x_in(stage_7_per_out[10]),
    .y_in(stage_7_per_out[11]),
    .x_out(stage_8_per_in[10]),
    .y_out(stage_8_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_6 (
    .x_in(stage_7_per_out[12]),
    .y_in(stage_7_per_out[13]),
    .x_out(stage_8_per_in[12]),
    .y_out(stage_8_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_7 (
    .x_in(stage_7_per_out[14]),
    .y_in(stage_7_per_out[15]),
    .x_out(stage_8_per_in[14]),
    .y_out(stage_8_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_8 (
    .x_in(stage_7_per_out[16]),
    .y_in(stage_7_per_out[17]),
    .x_out(stage_8_per_in[16]),
    .y_out(stage_8_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_9 (
    .x_in(stage_7_per_out[18]),
    .y_in(stage_7_per_out[19]),
    .x_out(stage_8_per_in[18]),
    .y_out(stage_8_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_10 (
    .x_in(stage_7_per_out[20]),
    .y_in(stage_7_per_out[21]),
    .x_out(stage_8_per_in[20]),
    .y_out(stage_8_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_11 (
    .x_in(stage_7_per_out[22]),
    .y_in(stage_7_per_out[23]),
    .x_out(stage_8_per_in[22]),
    .y_out(stage_8_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_12 (
    .x_in(stage_7_per_out[24]),
    .y_in(stage_7_per_out[25]),
    .x_out(stage_8_per_in[24]),
    .y_out(stage_8_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_13 (
    .x_in(stage_7_per_out[26]),
    .y_in(stage_7_per_out[27]),
    .x_out(stage_8_per_in[26]),
    .y_out(stage_8_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_14 (
    .x_in(stage_7_per_out[28]),
    .y_in(stage_7_per_out[29]),
    .x_out(stage_8_per_in[28]),
    .y_out(stage_8_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_0 (
    .x_in(stage_8_per_out[0]),
    .y_in(stage_8_per_out[1]),
    .x_out(outData[0]),
    .y_out(outData[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_1 (
    .x_in(stage_8_per_out[2]),
    .y_in(stage_8_per_out[3]),
    .x_out(outData[2]),
    .y_out(outData[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_2 (
    .x_in(stage_8_per_out[4]),
    .y_in(stage_8_per_out[5]),
    .x_out(outData[4]),
    .y_out(outData[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_3 (
    .x_in(stage_8_per_out[6]),
    .y_in(stage_8_per_out[7]),
    .x_out(outData[6]),
    .y_out(outData[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_4 (
    .x_in(stage_8_per_out[8]),
    .y_in(stage_8_per_out[9]),
    .x_out(outData[8]),
    .y_out(outData[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_5 (
    .x_in(stage_8_per_out[10]),
    .y_in(stage_8_per_out[11]),
    .x_out(outData[10]),
    .y_out(outData[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_6 (
    .x_in(stage_8_per_out[12]),
    .y_in(stage_8_per_out[13]),
    .x_out(outData[12]),
    .y_out(outData[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_7 (
    .x_in(stage_8_per_out[14]),
    .y_in(stage_8_per_out[15]),
    .x_out(outData[14]),
    .y_out(outData[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_8 (
    .x_in(stage_8_per_out[16]),
    .y_in(stage_8_per_out[17]),
    .x_out(outData[16]),
    .y_out(outData[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_9 (
    .x_in(stage_8_per_out[18]),
    .y_in(stage_8_per_out[19]),
    .x_out(outData[18]),
    .y_out(outData[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_10 (
    .x_in(stage_8_per_out[20]),
    .y_in(stage_8_per_out[21]),
    .x_out(outData[20]),
    .y_out(outData[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_11 (
    .x_in(stage_8_per_out[22]),
    .y_in(stage_8_per_out[23]),
    .x_out(outData[22]),
    .y_out(outData[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_12 (
    .x_in(stage_8_per_out[24]),
    .y_in(stage_8_per_out[25]),
    .x_out(outData[24]),
    .y_out(outData[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_13 (
    .x_in(stage_8_per_out[26]),
    .y_in(stage_8_per_out[27]),
    .x_out(outData[26]),
    .y_out(outData[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_14 (
    .x_in(stage_8_per_out[28]),
    .y_in(stage_8_per_out[29]),
    .x_out(outData[28]),
    .y_out(outData[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_15 (
    .x_in(stage_8_per_out[30]),
    .y_in(stage_8_per_out[31]),
    .x_out(outData[30]),
    .y_out(outData[31]),
    .clk(clk),
    .rst(rst)
  );



endmodule
