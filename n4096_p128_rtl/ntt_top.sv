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

  input in_start[10:0];
  output logic out_start[10:0];

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

  parameter [7:0] START_CYCLE[10] = {0, 7, 14, 21, 28, 35, 42, 67, 93, 121};

  // TODO(Tian): stage 0 32 butterfly units
  butterfly #(
    .start(START_CYCLE[0]),
    .factors({326097, 131309632, 168342750, 67241659,
              201160126, 107830842, 3021514, 265882354}))
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
    .factors({145034434, 222056927, 169924108, 12551837,
              188526794, 50162577, 34052825, 30998914}))
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
    .factors({63661975, 103503994, 155100837, 99695712,
              122609533, 125713617, 128159746, 66582189}))
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
    .factors({120466187, 70017017, 149423455, 225794318,
              9205704, 157839041, 123018041, 148051010}))
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
    .factors({156837559, 167645260, 2204580, 186531585,
              267506256, 107513427, 244783678, 115050087}))
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
    .factors({101188020, 77119896, 24036023, 94686133,
              71304140, 102034957, 19637177, 157991445}))
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
    .factors({254234203, 69205492, 164473684, 206844979,
              242301146, 92420698, 5161923, 159538295}))
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
    .factors({192680819, 190540901, 75195548, 215085706,
              187208958, 112756762, 212422509, 246787643}))
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
    .factors({180764097, 195298807, 124558832, 174028560,
              126413069, 212287973, 133273987, 248946430}))
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
    .factors({172715743, 100343421, 242717180, 119890469,
              212237706, 107138937, 138692846, 53025186}))
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
    .factors({245986816, 255658390, 135080569, 79336225,
              92659465, 144502563, 79230237, 170100736}))
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
    .factors({53126225, 236209279, 59894768, 46197346,
              256083096, 135271820, 190586128, 247116469}))
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
    .factors({52844710, 110055875, 255463943, 55222727,
              2486257, 1991289, 102785717, 218286321}))
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
    .factors({19058782, 233967292, 156009907, 12591284,
              112825183, 81263879, 237616434, 190565686}))
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
    .factors({43447238, 142941966, 227454343, 174856430,
              217359458, 94792077, 20236367, 173933513}))
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
    .factors({177682833, 139780710, 256519333, 203905228,
              198957507, 122969043, 171841734, 176911171}))
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
    .factors({166586238, 146761160, 62435894, 183669067,
              173513151, 248251528, 265496406, 225369834}))
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
    .factors({184522009, 134796549, 44888494, 89987026,
              24347842, 222249559, 172401093, 256834872}))
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
    .factors({84779248, 252714435, 129740611, 99277398,
              184177651, 18205961, 141562255, 32319537}))
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
    .factors({236829199, 103368916, 76313029, 50376784,
              118465017, 163197321, 62765404, 216819035}))
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
    .factors({128995628, 105793954, 7301415, 234786570,
              164154100, 217763430, 196000333, 147224860}))
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
    .factors({20655050, 229954056, 249936132, 92902456,
              190453366, 83905910, 205242220, 160429892}))
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
    .factors({173628384, 195181845, 136710753, 107152911,
              261541195, 213655453, 108382823, 198336839}))
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
    .factors({209878720, 1592538, 193897399, 92770973,
              209112367, 38252193, 87202745, 81893503}))
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
    .factors({85740049, 37498403, 259533807, 69313946,
              37504237, 18793692, 51838504, 36492987}))
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
    .factors({211646222, 79121706, 237395333, 5267255,
              85566308, 155363318, 109455096, 168826669}))
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
    .factors({9793208, 29594281, 255478273, 161345834,
              178220347, 93978858, 157649589, 232740066}))
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
    .factors({3260661, 255737752, 82321748, 91397014,
              248465751, 179341437, 148108490, 509728}))
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
    .factors({170230234, 187867192, 140450929, 78273516,
              94178347, 104546781, 231354349, 29537138}))
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
    .factors({41388380, 222527593, 248552245, 42344203,
              116527240, 60051251, 154317057, 151857114}))
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
    .factors({180877891, 132190398, 110302060, 195270185,
              253487730, 83977288, 240930884, 148289274}))
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
    .factors({210373784, 122538584, 145914728, 148491526,
              185886007, 194684542, 189909138, 154298223}))
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
    .factors({244423105, 5445105, 12817079, 244593894,
              245041907, 132467399, 257426331, 207530748}))
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
    .factors({25030552, 36620312, 132747224, 58671364,
              262112169, 189601976, 4047489, 73217275}))
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
    .factors({161607031, 17758040, 72509307, 62094530,
              146657273, 79834640, 123720956, 244927134}))
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
    .factors({140358303, 157386503, 195297575, 209780385,
              209744644, 151855973, 128052734, 259621463}))
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
    .factors({55581691, 243091016, 230992788, 121730405,
              62027985, 251672258, 149788353, 257402730}))
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
    .factors({246741831, 202565947, 55944760, 167758747,
              65889055, 17682401, 78612624, 211201491}))
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
    .factors({94079265, 210423079, 59214954, 8650362,
              118320134, 232847226, 209708523, 263725948}))
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
    .factors({236528116, 76624935, 241071152, 50174239,
              60492437, 86776671, 224322272, 105443909}))
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
    .factors({199352295, 115053845, 101579460, 228243008,
              172655984, 29779638, 266514716, 161626887}))
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
    .factors({160050812, 232156312, 64518939, 247452694,
              34932582, 102698816, 86359417, 29901564}))
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
    .factors({24365404, 126749676, 128627235, 207021189,
              90701762, 148152811, 195692414, 183571221}))
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
    .factors({56387579, 117072589, 134804553, 111835742,
              31964447, 248922055, 108164959, 146399832}))
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
    .factors({46282885, 156195364, 261458154, 248669125,
              193911793, 139101859, 145056180, 209643171}))
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
    .factors({185175266, 121355275, 159148996, 243047656,
              32097135, 70325928, 81197166, 9067201}))
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
    .factors({160048836, 99012968, 262630184, 250031819,
              72351531, 62688241, 22997488, 146205579}))
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
    .factors({129856203, 159491687, 122025398, 213678985,
              243009216, 166139329, 133808889, 77127228}))
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
    .factors({118444917, 206116619, 116257755, 259895089,
              168470500, 65498827, 36331533, 1352703}))
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
    .factors({125561953, 207047180, 255457916, 54393228,
              234775081, 266562472, 244216061, 260993294}))
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
    .factors({6001670, 164728317, 263001722, 183613005,
              56257750, 169959063, 252018541, 163812077}))
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
    .factors({166126182, 60600589, 220838681, 94206887,
              21649526, 217210388, 136898494, 261143222}))
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
    .factors({237125965, 99996719, 255141549, 200585052,
              228715598, 33096679, 70944317, 54916848}))
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
    .factors({17642100, 165180840, 249947221, 119720513,
              251717800, 77536776, 223014301, 97171493}))
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
    .factors({135921552, 20041783, 121414397, 266777211,
              141206585, 84669572, 254842567, 93757293}))
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
    .factors({218380292, 4457103, 112070980, 164079161,
              224550271, 194887964, 171206517, 75993973}))
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
    .factors({227628318, 115132688, 4721397, 219133933,
              214937778, 266352891, 212728405, 41535530}))
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
    .factors({92379159, 184560259, 127102737, 193438424,
              86350556, 219484262, 113049121, 169792793}))
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
    .factors({138675463, 10646661, 123052007, 40916099,
              107503597, 62456195, 39337018, 175928561}))
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
    .factors({193451294, 1361486, 78552959, 212162524,
              134417077, 64830196, 7280660, 139044757}))
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
    .factors({66337349, 181617487, 263649093, 8259535,
              79325117, 224391994, 140072656, 50523873}))
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
    .factors({36196902, 3395282, 187988754, 226759664,
              209466626, 134208656, 130154791, 223473865}))
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
    .factors({233083676, 66412546, 10310370, 211824237,
              164248031, 80988251, 108391208, 584543}))
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
    .factors({185590576, 3341663, 203598031, 62513408,
              81414740, 222912429, 261608985, 39797461}))
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
    .factors({64764693, 43104106, 182691070, 97007849,
              193296437, 17861009, 138879618, 184310992}))
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
    .factors({64764693, 43104106, 182691070, 97007849,
              193296437, 17861009, 138879618, 184310992}))
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
    .factors({194276347, 185138250, 257269778, 117507527,
              62408001, 134877507, 206725018, 195748297}))
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
    .factors({194276347, 185138250, 257269778, 117507527,
              62408001, 134877507, 206725018, 195748297}))
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
    .factors({223822620, 34971158, 262077011, 225784463,
              117221766, 67225153, 140366124, 61040039}))
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
    .factors({223822620, 34971158, 262077011, 225784463,
              117221766, 67225153, 140366124, 61040039}))
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
    .factors({209886001, 199876762, 231423732, 202776751,
              224068691, 160841949, 73081523, 187864761}))
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
    .factors({209886001, 199876762, 231423732, 202776751,
              224068691, 160841949, 73081523, 187864761}))
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
    .factors({196522490, 123335450, 53222994, 143779572,
              212275822, 254132077, 5829490, 251384491}))
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
    .factors({196522490, 123335450, 53222994, 143779572,
              212275822, 254132077, 5829490, 251384491}))
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
    .factors({222861227, 174629071, 158168844, 112003761,
              63079505, 167911982, 99392088, 25944135}))
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
    .factors({222861227, 174629071, 158168844, 112003761,
              63079505, 167911982, 99392088, 25944135}))
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
    .factors({174900371, 258559590, 208297913, 171541778,
              109479656, 66298746, 236282586, 20857483}))
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
    .factors({174900371, 258559590, 208297913, 171541778,
              109479656, 66298746, 236282586, 20857483}))
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
    .factors({260909397, 251898247, 201863951, 43194148,
              82934386, 51974898, 56246211, 228211497}))
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
    .factors({260909397, 251898247, 201863951, 43194148,
              82934386, 51974898, 56246211, 228211497}))
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
    .factors({250071443, 134269022, 25853611, 61997323,
              205525433, 126188511, 151095818, 183029478}))
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
    .factors({250071443, 134269022, 25853611, 61997323,
              205525433, 126188511, 151095818, 183029478}))
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
    .factors({95434564, 44144526, 149200070, 200749611,
              76925614, 35754446, 60548134, 113309038}))
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
    .factors({95434564, 44144526, 149200070, 200749611,
              76925614, 35754446, 60548134, 113309038}))
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
    .factors({61720173, 125267062, 49675259, 232451599,
              202955937, 78649100, 176209504, 266671862}))
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
    .factors({61720173, 125267062, 49675259, 232451599,
              202955937, 78649100, 176209504, 266671862}))
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
    .factors({219083512, 186841927, 139268485, 56943278,
              78049958, 98889920, 138793148, 243024363}))
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
    .factors({219083512, 186841927, 139268485, 56943278,
              78049958, 98889920, 138793148, 243024363}))
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
    .factors({200399539, 122332647, 49504466, 107197955,
              244763177, 132483080, 75537498, 137065607}))
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
    .factors({200399539, 122332647, 49504466, 107197955,
              244763177, 132483080, 75537498, 137065607}))
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
    .factors({101003336, 256272276, 73698550, 30930936,
              13458851, 98085790, 188517169, 227819465}))
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
    .factors({101003336, 256272276, 73698550, 30930936,
              13458851, 98085790, 188517169, 227819465}))
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
    .factors({229100654, 204886617, 43078133, 246630386,
              100123291, 169182486, 136878682, 86901749}))
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
    .factors({229100654, 204886617, 43078133, 246630386,
              100123291, 169182486, 136878682, 86901749}))
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
    .factors({236109059, 165134943, 244216783, 206705681,
              85667364, 102915173, 209658551, 241313184}))
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
    .factors({236109059, 165134943, 244216783, 206705681,
              85667364, 102915173, 209658551, 241313184}))
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
    .factors({101414187, 196328787, 234350511, 227651751,
              5299132, 28242170, 206252403, 56155754}))
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
    .factors({101414187, 196328787, 234350511, 227651751,
              5299132, 28242170, 206252403, 56155754}))
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
    .factors({48471700, 177340471, 172508742, 154421517,
              34256894, 157966005, 126945619, 95282463}))
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
    .factors({48471700, 177340471, 172508742, 154421517,
              34256894, 157966005, 126945619, 95282463}))
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
    .factors({131023241, 173118058, 262358962, 218231468,
              42719459, 23405380, 61345534, 173757017}))
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
    .factors({131023241, 173118058, 262358962, 218231468,
              42719459, 23405380, 61345534, 173757017}))
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
    .factors({210770212, 97318594, 226213489, 251138298,
              43783325, 178386996, 258527796, 10003248}))
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
    .factors({210770212, 97318594, 226213489, 251138298,
              43783325, 178386996, 258527796, 10003248}))
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
    .factors({249146534, 103731033, 137672988, 74454717,
              259958064, 45686070, 209725121, 114486793}))
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
    .factors({249146534, 103731033, 137672988, 74454717,
              259958064, 45686070, 209725121, 114486793}))
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
    .factors({1562592, 258257144, 209583375, 181167649,
              14568946, 141849606, 5292226, 190980049}))
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
    .factors({1562592, 258257144, 209583375, 181167649,
              14568946, 141849606, 5292226, 190980049}))
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
    .factors({82684352, 170930026, 261795000, 220994759,
              160254284, 256173379, 210734246, 186214186}))
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
    .factors({82684352, 170930026, 261795000, 220994759,
              160254284, 256173379, 210734246, 186214186}))
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
    .factors({50222736, 126063290, 26067051, 224794776,
              64884498, 199633043, 68267735, 5905084}))
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
    .factors({50222736, 126063290, 26067051, 224794776,
              64884498, 199633043, 68267735, 5905084}))
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
    .factors({257649131, 206795535, 109642647, 8950678,
              57574719, 263530653, 149992379, 59284831}))
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
    .factors({257649131, 206795535, 109642647, 8950678,
              57574719, 263530653, 149992379, 59284831}))
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
    .factors({237102043, 42980173, 266756542, 176665584,
              186863562, 233888407, 68559335, 144929841}))
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
    .factors({237102043, 42980173, 266756542, 176665584,
              186863562, 233888407, 68559335, 144929841}))
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
    .factors({202059197, 247289727, 23892097, 210914061,
              87074609, 219738759, 201047927, 69773246}))
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
    .factors({202059197, 247289727, 23892097, 210914061,
              87074609, 219738759, 201047927, 69773246}))
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
    .factors({10143115, 47879495, 165872957, 92650808,
              100229847, 243681494, 202127782, 65324949}))
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
    .factors({10143115, 47879495, 165872957, 92650808,
              100229847, 243681494, 202127782, 65324949}))
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
    .factors({55567611, 184644727, 247253507, 238382196,
              79136411, 190388461, 95560742, 49057739}))
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
    .factors({55567611, 184644727, 247253507, 238382196,
              79136411, 190388461, 95560742, 49057739}))
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
    .factors({34855849, 255286072, 232445568, 165350229,
              131377029, 169508713, 148390399, 71598752}))
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
    .factors({34855849, 255286072, 232445568, 165350229,
              131377029, 169508713, 148390399, 71598752}))
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
    .factors({54534442, 158466952, 242025902, 16128104,
              87088032, 42355602, 85252512, 50986641}))
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
    .factors({54534442, 158466952, 242025902, 16128104,
              87088032, 42355602, 85252512, 50986641}))
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
    .factors({198785423, 160807241, 256869432, 124400051,
              99693395, 135618975, 119568150, 55609416}))
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
    .factors({198785423, 160807241, 256869432, 124400051,
              99693395, 135618975, 119568150, 55609416}))
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
    .factors({53818192, 77337691, 18399308, 254850432,
              145184649, 23486645, 130557622, 214085592}))
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
    .factors({53818192, 77337691, 18399308, 254850432,
              145184649, 23486645, 130557622, 214085592}))
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
    .factors({53818192, 77337691, 18399308, 254850432,
              145184649, 23486645, 130557622, 214085592}))
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
    .factors({53818192, 77337691, 18399308, 254850432,
              145184649, 23486645, 130557622, 214085592}))
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
    .factors({108810259, 34119889, 50725340, 220375582,
              182447177, 7055647, 231318087, 205019884}))
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
    .factors({108810259, 34119889, 50725340, 220375582,
              182447177, 7055647, 231318087, 205019884}))
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
    .factors({108810259, 34119889, 50725340, 220375582,
              182447177, 7055647, 231318087, 205019884}))
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
    .factors({108810259, 34119889, 50725340, 220375582,
              182447177, 7055647, 231318087, 205019884}))
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
    .factors({44942358, 201357873, 171721518, 252442032,
              254450415, 29871855, 75673633, 189591954}))
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
    .factors({44942358, 201357873, 171721518, 252442032,
              254450415, 29871855, 75673633, 189591954}))
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
    .factors({44942358, 201357873, 171721518, 252442032,
              254450415, 29871855, 75673633, 189591954}))
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
    .factors({44942358, 201357873, 171721518, 252442032,
              254450415, 29871855, 75673633, 189591954}))
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
    .factors({234890903, 41630462, 72738487, 106338196,
              170604387, 133081916, 159404461, 245906264}))
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
    .factors({234890903, 41630462, 72738487, 106338196,
              170604387, 133081916, 159404461, 245906264}))
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
    .factors({234890903, 41630462, 72738487, 106338196,
              170604387, 133081916, 159404461, 245906264}))
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
    .factors({234890903, 41630462, 72738487, 106338196,
              170604387, 133081916, 159404461, 245906264}))
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
    .factors({149851545, 21625356, 98878775, 248876054,
              227894900, 246656426, 167885779, 231358848}))
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
    .factors({149851545, 21625356, 98878775, 248876054,
              227894900, 246656426, 167885779, 231358848}))
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
    .factors({149851545, 21625356, 98878775, 248876054,
              227894900, 246656426, 167885779, 231358848}))
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
    .factors({149851545, 21625356, 98878775, 248876054,
              227894900, 246656426, 167885779, 231358848}))
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
    .factors({227816219, 104174682, 258923154, 258649698,
              253827407, 78607636, 250166212, 37936257}))
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
    .factors({227816219, 104174682, 258923154, 258649698,
              253827407, 78607636, 250166212, 37936257}))
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
    .factors({227816219, 104174682, 258923154, 258649698,
              253827407, 78607636, 250166212, 37936257}))
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
    .factors({227816219, 104174682, 258923154, 258649698,
              253827407, 78607636, 250166212, 37936257}))
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
    .factors({204666342, 106542036, 28824907, 132703565,
              170227406, 81956368, 74998629, 59208162}))
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
    .factors({204666342, 106542036, 28824907, 132703565,
              170227406, 81956368, 74998629, 59208162}))
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
    .factors({204666342, 106542036, 28824907, 132703565,
              170227406, 81956368, 74998629, 59208162}))
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
    .factors({204666342, 106542036, 28824907, 132703565,
              170227406, 81956368, 74998629, 59208162}))
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
    .factors({26687688, 265574867, 139555205, 168407516,
              10571783, 91452641, 150873005, 236144340}))
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
    .factors({26687688, 265574867, 139555205, 168407516,
              10571783, 91452641, 150873005, 236144340}))
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
    .factors({26687688, 265574867, 139555205, 168407516,
              10571783, 91452641, 150873005, 236144340}))
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
    .factors({26687688, 265574867, 139555205, 168407516,
              10571783, 91452641, 150873005, 236144340}))
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
    .factors({229216409, 133503098, 199208174, 123954975,
              181639510, 71064168, 85021501, 27244461}))
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
    .factors({229216409, 133503098, 199208174, 123954975,
              181639510, 71064168, 85021501, 27244461}))
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
    .factors({229216409, 133503098, 199208174, 123954975,
              181639510, 71064168, 85021501, 27244461}))
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
    .factors({229216409, 133503098, 199208174, 123954975,
              181639510, 71064168, 85021501, 27244461}))
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
    .factors({160286792, 227283585, 180525688, 211668928,
              216143425, 101483624, 161729483, 243304319}))
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
    .factors({160286792, 227283585, 180525688, 211668928,
              216143425, 101483624, 161729483, 243304319}))
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
    .factors({160286792, 227283585, 180525688, 211668928,
              216143425, 101483624, 161729483, 243304319}))
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
    .factors({160286792, 227283585, 180525688, 211668928,
              216143425, 101483624, 161729483, 243304319}))
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
    .factors({204152715, 3883583, 255119583, 242800442,
              119707826, 257268473, 234030247, 184516225}))
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
    .factors({204152715, 3883583, 255119583, 242800442,
              119707826, 257268473, 234030247, 184516225}))
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
    .factors({204152715, 3883583, 255119583, 242800442,
              119707826, 257268473, 234030247, 184516225}))
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
    .factors({204152715, 3883583, 255119583, 242800442,
              119707826, 257268473, 234030247, 184516225}))
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
    .factors({66148505, 104784816, 22541719, 146361539,
              39141691, 68136911, 227214070, 91898237}))
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
    .factors({66148505, 104784816, 22541719, 146361539,
              39141691, 68136911, 227214070, 91898237}))
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
    .factors({66148505, 104784816, 22541719, 146361539,
              39141691, 68136911, 227214070, 91898237}))
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
    .factors({66148505, 104784816, 22541719, 146361539,
              39141691, 68136911, 227214070, 91898237}))
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
    .factors({15417588, 96142103, 196436059, 42733001,
              166530134, 18729522, 9757140, 81777479}))
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
    .factors({15417588, 96142103, 196436059, 42733001,
              166530134, 18729522, 9757140, 81777479}))
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
    .factors({15417588, 96142103, 196436059, 42733001,
              166530134, 18729522, 9757140, 81777479}))
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
    .factors({15417588, 96142103, 196436059, 42733001,
              166530134, 18729522, 9757140, 81777479}))
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
    .factors({47751177, 149528048, 84143174, 120936039,
              256040960, 116401819, 59283803, 78488715}))
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
    .factors({47751177, 149528048, 84143174, 120936039,
              256040960, 116401819, 59283803, 78488715}))
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
    .factors({47751177, 149528048, 84143174, 120936039,
              256040960, 116401819, 59283803, 78488715}))
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
    .factors({47751177, 149528048, 84143174, 120936039,
              256040960, 116401819, 59283803, 78488715}))
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
    .factors({13860432, 163812837, 143969713, 58071669,
              27692847, 6576175, 173702965, 10130658}))
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
    .factors({13860432, 163812837, 143969713, 58071669,
              27692847, 6576175, 173702965, 10130658}))
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
    .factors({13860432, 163812837, 143969713, 58071669,
              27692847, 6576175, 173702965, 10130658}))
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
    .factors({13860432, 163812837, 143969713, 58071669,
              27692847, 6576175, 173702965, 10130658}))
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
    .factors({212648666, 155168409, 37667151, 71295013,
              2419351, 188210893, 90597117, 129187632}))
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
    .factors({212648666, 155168409, 37667151, 71295013,
              2419351, 188210893, 90597117, 129187632}))
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
    .factors({212648666, 155168409, 37667151, 71295013,
              2419351, 188210893, 90597117, 129187632}))
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
    .factors({212648666, 155168409, 37667151, 71295013,
              2419351, 188210893, 90597117, 129187632}))
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
    .factors({120670867, 153962078, 103143177, 27685019,
              111341228, 197386970, 145384235, 227285679}))
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
    .factors({120670867, 153962078, 103143177, 27685019,
              111341228, 197386970, 145384235, 227285679}))
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
    .factors({120670867, 153962078, 103143177, 27685019,
              111341228, 197386970, 145384235, 227285679}))
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
    .factors({120670867, 153962078, 103143177, 27685019,
              111341228, 197386970, 145384235, 227285679}))
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
    .factors({120670867, 153962078, 103143177, 27685019,
              111341228, 197386970, 145384235, 227285679}))
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
    .factors({120670867, 153962078, 103143177, 27685019,
              111341228, 197386970, 145384235, 227285679}))
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
    .factors({120670867, 153962078, 103143177, 27685019,
              111341228, 197386970, 145384235, 227285679}))
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
    .factors({120670867, 153962078, 103143177, 27685019,
              111341228, 197386970, 145384235, 227285679}))
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
    .factors({181852808, 11695616, 6323336, 47317233,
              30748955, 149145314, 155896930, 76642651}))
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
    .factors({181852808, 11695616, 6323336, 47317233,
              30748955, 149145314, 155896930, 76642651}))
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
    .factors({181852808, 11695616, 6323336, 47317233,
              30748955, 149145314, 155896930, 76642651}))
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
    .factors({181852808, 11695616, 6323336, 47317233,
              30748955, 149145314, 155896930, 76642651}))
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
    .factors({181852808, 11695616, 6323336, 47317233,
              30748955, 149145314, 155896930, 76642651}))
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
    .factors({181852808, 11695616, 6323336, 47317233,
              30748955, 149145314, 155896930, 76642651}))
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
    .factors({181852808, 11695616, 6323336, 47317233,
              30748955, 149145314, 155896930, 76642651}))
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
    .factors({181852808, 11695616, 6323336, 47317233,
              30748955, 149145314, 155896930, 76642651}))
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
    .factors({66003795, 233560477, 179817683, 115957373,
              177255039, 99093252, 105996489, 138074788}))
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
    .factors({66003795, 233560477, 179817683, 115957373,
              177255039, 99093252, 105996489, 138074788}))
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
    .factors({66003795, 233560477, 179817683, 115957373,
              177255039, 99093252, 105996489, 138074788}))
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
    .factors({66003795, 233560477, 179817683, 115957373,
              177255039, 99093252, 105996489, 138074788}))
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
    .factors({66003795, 233560477, 179817683, 115957373,
              177255039, 99093252, 105996489, 138074788}))
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
    .factors({66003795, 233560477, 179817683, 115957373,
              177255039, 99093252, 105996489, 138074788}))
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
    .factors({66003795, 233560477, 179817683, 115957373,
              177255039, 99093252, 105996489, 138074788}))
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
    .factors({66003795, 233560477, 179817683, 115957373,
              177255039, 99093252, 105996489, 138074788}))
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
    .factors({146694818, 189907315, 109553202, 4690923,
              57801361, 141548072, 193689173, 201062854}))
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
    .factors({146694818, 189907315, 109553202, 4690923,
              57801361, 141548072, 193689173, 201062854}))
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
    .factors({146694818, 189907315, 109553202, 4690923,
              57801361, 141548072, 193689173, 201062854}))
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
    .factors({146694818, 189907315, 109553202, 4690923,
              57801361, 141548072, 193689173, 201062854}))
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
    .factors({146694818, 189907315, 109553202, 4690923,
              57801361, 141548072, 193689173, 201062854}))
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
    .factors({146694818, 189907315, 109553202, 4690923,
              57801361, 141548072, 193689173, 201062854}))
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
    .factors({146694818, 189907315, 109553202, 4690923,
              57801361, 141548072, 193689173, 201062854}))
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
    .factors({146694818, 189907315, 109553202, 4690923,
              57801361, 141548072, 193689173, 201062854}))
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
    .factors({78852289, 52673254, 140204941, 75324254,
              59966873, 39593842, 168270865, 175609590}))
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
    .factors({78852289, 52673254, 140204941, 75324254,
              59966873, 39593842, 168270865, 175609590}))
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
    .factors({78852289, 52673254, 140204941, 75324254,
              59966873, 39593842, 168270865, 175609590}))
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
    .factors({78852289, 52673254, 140204941, 75324254,
              59966873, 39593842, 168270865, 175609590}))
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
    .factors({78852289, 52673254, 140204941, 75324254,
              59966873, 39593842, 168270865, 175609590}))
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
    .factors({78852289, 52673254, 140204941, 75324254,
              59966873, 39593842, 168270865, 175609590}))
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
    .factors({78852289, 52673254, 140204941, 75324254,
              59966873, 39593842, 168270865, 175609590}))
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
    .factors({78852289, 52673254, 140204941, 75324254,
              59966873, 39593842, 168270865, 175609590}))
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
    .factors({49823188, 95727610, 97617150, 17079898,
              109254766, 239095400, 71471012, 115504656}))
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
    .factors({49823188, 95727610, 97617150, 17079898,
              109254766, 239095400, 71471012, 115504656}))
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
    .factors({49823188, 95727610, 97617150, 17079898,
              109254766, 239095400, 71471012, 115504656}))
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
    .factors({49823188, 95727610, 97617150, 17079898,
              109254766, 239095400, 71471012, 115504656}))
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
    .factors({49823188, 95727610, 97617150, 17079898,
              109254766, 239095400, 71471012, 115504656}))
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
    .factors({49823188, 95727610, 97617150, 17079898,
              109254766, 239095400, 71471012, 115504656}))
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
    .factors({49823188, 95727610, 97617150, 17079898,
              109254766, 239095400, 71471012, 115504656}))
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
    .factors({49823188, 95727610, 97617150, 17079898,
              109254766, 239095400, 71471012, 115504656}))
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
    .factors({71460019, 70582130, 68315815, 202257393,
              102065274, 82771912, 235204060, 118939950}))
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
    .factors({71460019, 70582130, 68315815, 202257393,
              102065274, 82771912, 235204060, 118939950}))
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
    .factors({71460019, 70582130, 68315815, 202257393,
              102065274, 82771912, 235204060, 118939950}))
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
    .factors({71460019, 70582130, 68315815, 202257393,
              102065274, 82771912, 235204060, 118939950}))
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
    .factors({71460019, 70582130, 68315815, 202257393,
              102065274, 82771912, 235204060, 118939950}))
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
    .factors({71460019, 70582130, 68315815, 202257393,
              102065274, 82771912, 235204060, 118939950}))
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
    .factors({71460019, 70582130, 68315815, 202257393,
              102065274, 82771912, 235204060, 118939950}))
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
    .factors({71460019, 70582130, 68315815, 202257393,
              102065274, 82771912, 235204060, 118939950}))
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
    .factors({40758458, 92577793, 76707105, 25574347,
              157085730, 143450922, 131798756, 206324144}))
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
    .factors({40758458, 92577793, 76707105, 25574347,
              157085730, 143450922, 131798756, 206324144}))
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
    .factors({40758458, 92577793, 76707105, 25574347,
              157085730, 143450922, 131798756, 206324144}))
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
    .factors({40758458, 92577793, 76707105, 25574347,
              157085730, 143450922, 131798756, 206324144}))
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
    .factors({40758458, 92577793, 76707105, 25574347,
              157085730, 143450922, 131798756, 206324144}))
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
    .factors({40758458, 92577793, 76707105, 25574347,
              157085730, 143450922, 131798756, 206324144}))
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
    .factors({40758458, 92577793, 76707105, 25574347,
              157085730, 143450922, 131798756, 206324144}))
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
    .factors({40758458, 92577793, 76707105, 25574347,
              157085730, 143450922, 131798756, 206324144}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({94135184, 178374402, 124730815, 76573097,
              129001811, 84893967, 194544757, 175625696}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({231414272, 220656190, 11699091, 233080466,
              196308904, 210831626, 196317032, 263111217}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({51997749, 108349160, 229105823, 19095174,
              148889498, 165596304, 18533839, 184798272}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({46529833, 85069259, 234642902, 62061822,
              102579498, 3179002, 99790517, 47877183}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({42982065, 163057267, 197853640, 25800822,
              69075086, 234985940, 260567810, 210749829}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({135333989, 194721725, 131414476, 46265048,
              125976015, 220769014, 155624840, 133782759}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({180609988, 172037025, 130838261, 219782419,
              162923847, 90670588, 197095417, 128108241}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({250183461, 250183461, 180167806, 180167806,
              69574326, 69574326, 174860716, 174860716}))
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
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
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
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_15 (
    .x_in(stage_7_per_out[30]),
    .y_in(stage_7_per_out[31]),
    .x_out(stage_8_per_in[30]),
    .y_out(stage_8_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_16 (
    .x_in(stage_7_per_out[32]),
    .y_in(stage_7_per_out[33]),
    .x_out(stage_8_per_in[32]),
    .y_out(stage_8_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_17 (
    .x_in(stage_7_per_out[34]),
    .y_in(stage_7_per_out[35]),
    .x_out(stage_8_per_in[34]),
    .y_out(stage_8_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_18 (
    .x_in(stage_7_per_out[36]),
    .y_in(stage_7_per_out[37]),
    .x_out(stage_8_per_in[36]),
    .y_out(stage_8_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_19 (
    .x_in(stage_7_per_out[38]),
    .y_in(stage_7_per_out[39]),
    .x_out(stage_8_per_in[38]),
    .y_out(stage_8_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_20 (
    .x_in(stage_7_per_out[40]),
    .y_in(stage_7_per_out[41]),
    .x_out(stage_8_per_in[40]),
    .y_out(stage_8_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_21 (
    .x_in(stage_7_per_out[42]),
    .y_in(stage_7_per_out[43]),
    .x_out(stage_8_per_in[42]),
    .y_out(stage_8_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_22 (
    .x_in(stage_7_per_out[44]),
    .y_in(stage_7_per_out[45]),
    .x_out(stage_8_per_in[44]),
    .y_out(stage_8_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_23 (
    .x_in(stage_7_per_out[46]),
    .y_in(stage_7_per_out[47]),
    .x_out(stage_8_per_in[46]),
    .y_out(stage_8_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_24 (
    .x_in(stage_7_per_out[48]),
    .y_in(stage_7_per_out[49]),
    .x_out(stage_8_per_in[48]),
    .y_out(stage_8_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_25 (
    .x_in(stage_7_per_out[50]),
    .y_in(stage_7_per_out[51]),
    .x_out(stage_8_per_in[50]),
    .y_out(stage_8_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_26 (
    .x_in(stage_7_per_out[52]),
    .y_in(stage_7_per_out[53]),
    .x_out(stage_8_per_in[52]),
    .y_out(stage_8_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_27 (
    .x_in(stage_7_per_out[54]),
    .y_in(stage_7_per_out[55]),
    .x_out(stage_8_per_in[54]),
    .y_out(stage_8_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_28 (
    .x_in(stage_7_per_out[56]),
    .y_in(stage_7_per_out[57]),
    .x_out(stage_8_per_in[56]),
    .y_out(stage_8_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_29 (
    .x_in(stage_7_per_out[58]),
    .y_in(stage_7_per_out[59]),
    .x_out(stage_8_per_in[58]),
    .y_out(stage_8_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_30 (
    .x_in(stage_7_per_out[60]),
    .y_in(stage_7_per_out[61]),
    .x_out(stage_8_per_in[60]),
    .y_out(stage_8_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_31 (
    .x_in(stage_7_per_out[62]),
    .y_in(stage_7_per_out[63]),
    .x_out(stage_8_per_in[62]),
    .y_out(stage_8_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_32 (
    .x_in(stage_7_per_out[64]),
    .y_in(stage_7_per_out[65]),
    .x_out(stage_8_per_in[64]),
    .y_out(stage_8_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_33 (
    .x_in(stage_7_per_out[66]),
    .y_in(stage_7_per_out[67]),
    .x_out(stage_8_per_in[66]),
    .y_out(stage_8_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_34 (
    .x_in(stage_7_per_out[68]),
    .y_in(stage_7_per_out[69]),
    .x_out(stage_8_per_in[68]),
    .y_out(stage_8_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_35 (
    .x_in(stage_7_per_out[70]),
    .y_in(stage_7_per_out[71]),
    .x_out(stage_8_per_in[70]),
    .y_out(stage_8_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_36 (
    .x_in(stage_7_per_out[72]),
    .y_in(stage_7_per_out[73]),
    .x_out(stage_8_per_in[72]),
    .y_out(stage_8_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_37 (
    .x_in(stage_7_per_out[74]),
    .y_in(stage_7_per_out[75]),
    .x_out(stage_8_per_in[74]),
    .y_out(stage_8_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_38 (
    .x_in(stage_7_per_out[76]),
    .y_in(stage_7_per_out[77]),
    .x_out(stage_8_per_in[76]),
    .y_out(stage_8_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_39 (
    .x_in(stage_7_per_out[78]),
    .y_in(stage_7_per_out[79]),
    .x_out(stage_8_per_in[78]),
    .y_out(stage_8_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_40 (
    .x_in(stage_7_per_out[80]),
    .y_in(stage_7_per_out[81]),
    .x_out(stage_8_per_in[80]),
    .y_out(stage_8_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_41 (
    .x_in(stage_7_per_out[82]),
    .y_in(stage_7_per_out[83]),
    .x_out(stage_8_per_in[82]),
    .y_out(stage_8_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_42 (
    .x_in(stage_7_per_out[84]),
    .y_in(stage_7_per_out[85]),
    .x_out(stage_8_per_in[84]),
    .y_out(stage_8_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_43 (
    .x_in(stage_7_per_out[86]),
    .y_in(stage_7_per_out[87]),
    .x_out(stage_8_per_in[86]),
    .y_out(stage_8_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_44 (
    .x_in(stage_7_per_out[88]),
    .y_in(stage_7_per_out[89]),
    .x_out(stage_8_per_in[88]),
    .y_out(stage_8_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_45 (
    .x_in(stage_7_per_out[90]),
    .y_in(stage_7_per_out[91]),
    .x_out(stage_8_per_in[90]),
    .y_out(stage_8_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_46 (
    .x_in(stage_7_per_out[92]),
    .y_in(stage_7_per_out[93]),
    .x_out(stage_8_per_in[92]),
    .y_out(stage_8_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_47 (
    .x_in(stage_7_per_out[94]),
    .y_in(stage_7_per_out[95]),
    .x_out(stage_8_per_in[94]),
    .y_out(stage_8_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_48 (
    .x_in(stage_7_per_out[96]),
    .y_in(stage_7_per_out[97]),
    .x_out(stage_8_per_in[96]),
    .y_out(stage_8_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_49 (
    .x_in(stage_7_per_out[98]),
    .y_in(stage_7_per_out[99]),
    .x_out(stage_8_per_in[98]),
    .y_out(stage_8_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_50 (
    .x_in(stage_7_per_out[100]),
    .y_in(stage_7_per_out[101]),
    .x_out(stage_8_per_in[100]),
    .y_out(stage_8_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_51 (
    .x_in(stage_7_per_out[102]),
    .y_in(stage_7_per_out[103]),
    .x_out(stage_8_per_in[102]),
    .y_out(stage_8_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_52 (
    .x_in(stage_7_per_out[104]),
    .y_in(stage_7_per_out[105]),
    .x_out(stage_8_per_in[104]),
    .y_out(stage_8_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_53 (
    .x_in(stage_7_per_out[106]),
    .y_in(stage_7_per_out[107]),
    .x_out(stage_8_per_in[106]),
    .y_out(stage_8_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_54 (
    .x_in(stage_7_per_out[108]),
    .y_in(stage_7_per_out[109]),
    .x_out(stage_8_per_in[108]),
    .y_out(stage_8_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_55 (
    .x_in(stage_7_per_out[110]),
    .y_in(stage_7_per_out[111]),
    .x_out(stage_8_per_in[110]),
    .y_out(stage_8_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_56 (
    .x_in(stage_7_per_out[112]),
    .y_in(stage_7_per_out[113]),
    .x_out(stage_8_per_in[112]),
    .y_out(stage_8_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_57 (
    .x_in(stage_7_per_out[114]),
    .y_in(stage_7_per_out[115]),
    .x_out(stage_8_per_in[114]),
    .y_out(stage_8_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_58 (
    .x_in(stage_7_per_out[116]),
    .y_in(stage_7_per_out[117]),
    .x_out(stage_8_per_in[116]),
    .y_out(stage_8_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_59 (
    .x_in(stage_7_per_out[118]),
    .y_in(stage_7_per_out[119]),
    .x_out(stage_8_per_in[118]),
    .y_out(stage_8_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_60 (
    .x_in(stage_7_per_out[120]),
    .y_in(stage_7_per_out[121]),
    .x_out(stage_8_per_in[120]),
    .y_out(stage_8_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_61 (
    .x_in(stage_7_per_out[122]),
    .y_in(stage_7_per_out[123]),
    .x_out(stage_8_per_in[122]),
    .y_out(stage_8_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_62 (
    .x_in(stage_7_per_out[124]),
    .y_in(stage_7_per_out[125]),
    .x_out(stage_8_per_in[124]),
    .y_out(stage_8_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[8]),
    .factors({185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802}))
  stage_8_butterfly_63 (
    .x_in(stage_7_per_out[126]),
    .y_in(stage_7_per_out[127]),
    .x_out(stage_8_per_in[126]),
    .y_out(stage_8_per_in[127]),
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
    .inData_32(stage_8_per_in[32]),
    .inData_33(stage_8_per_in[33]),
    .inData_34(stage_8_per_in[34]),
    .inData_35(stage_8_per_in[35]),
    .inData_36(stage_8_per_in[36]),
    .inData_37(stage_8_per_in[37]),
    .inData_38(stage_8_per_in[38]),
    .inData_39(stage_8_per_in[39]),
    .inData_40(stage_8_per_in[40]),
    .inData_41(stage_8_per_in[41]),
    .inData_42(stage_8_per_in[42]),
    .inData_43(stage_8_per_in[43]),
    .inData_44(stage_8_per_in[44]),
    .inData_45(stage_8_per_in[45]),
    .inData_46(stage_8_per_in[46]),
    .inData_47(stage_8_per_in[47]),
    .inData_48(stage_8_per_in[48]),
    .inData_49(stage_8_per_in[49]),
    .inData_50(stage_8_per_in[50]),
    .inData_51(stage_8_per_in[51]),
    .inData_52(stage_8_per_in[52]),
    .inData_53(stage_8_per_in[53]),
    .inData_54(stage_8_per_in[54]),
    .inData_55(stage_8_per_in[55]),
    .inData_56(stage_8_per_in[56]),
    .inData_57(stage_8_per_in[57]),
    .inData_58(stage_8_per_in[58]),
    .inData_59(stage_8_per_in[59]),
    .inData_60(stage_8_per_in[60]),
    .inData_61(stage_8_per_in[61]),
    .inData_62(stage_8_per_in[62]),
    .inData_63(stage_8_per_in[63]),
    .inData_64(stage_8_per_in[64]),
    .inData_65(stage_8_per_in[65]),
    .inData_66(stage_8_per_in[66]),
    .inData_67(stage_8_per_in[67]),
    .inData_68(stage_8_per_in[68]),
    .inData_69(stage_8_per_in[69]),
    .inData_70(stage_8_per_in[70]),
    .inData_71(stage_8_per_in[71]),
    .inData_72(stage_8_per_in[72]),
    .inData_73(stage_8_per_in[73]),
    .inData_74(stage_8_per_in[74]),
    .inData_75(stage_8_per_in[75]),
    .inData_76(stage_8_per_in[76]),
    .inData_77(stage_8_per_in[77]),
    .inData_78(stage_8_per_in[78]),
    .inData_79(stage_8_per_in[79]),
    .inData_80(stage_8_per_in[80]),
    .inData_81(stage_8_per_in[81]),
    .inData_82(stage_8_per_in[82]),
    .inData_83(stage_8_per_in[83]),
    .inData_84(stage_8_per_in[84]),
    .inData_85(stage_8_per_in[85]),
    .inData_86(stage_8_per_in[86]),
    .inData_87(stage_8_per_in[87]),
    .inData_88(stage_8_per_in[88]),
    .inData_89(stage_8_per_in[89]),
    .inData_90(stage_8_per_in[90]),
    .inData_91(stage_8_per_in[91]),
    .inData_92(stage_8_per_in[92]),
    .inData_93(stage_8_per_in[93]),
    .inData_94(stage_8_per_in[94]),
    .inData_95(stage_8_per_in[95]),
    .inData_96(stage_8_per_in[96]),
    .inData_97(stage_8_per_in[97]),
    .inData_98(stage_8_per_in[98]),
    .inData_99(stage_8_per_in[99]),
    .inData_100(stage_8_per_in[100]),
    .inData_101(stage_8_per_in[101]),
    .inData_102(stage_8_per_in[102]),
    .inData_103(stage_8_per_in[103]),
    .inData_104(stage_8_per_in[104]),
    .inData_105(stage_8_per_in[105]),
    .inData_106(stage_8_per_in[106]),
    .inData_107(stage_8_per_in[107]),
    .inData_108(stage_8_per_in[108]),
    .inData_109(stage_8_per_in[109]),
    .inData_110(stage_8_per_in[110]),
    .inData_111(stage_8_per_in[111]),
    .inData_112(stage_8_per_in[112]),
    .inData_113(stage_8_per_in[113]),
    .inData_114(stage_8_per_in[114]),
    .inData_115(stage_8_per_in[115]),
    .inData_116(stage_8_per_in[116]),
    .inData_117(stage_8_per_in[117]),
    .inData_118(stage_8_per_in[118]),
    .inData_119(stage_8_per_in[119]),
    .inData_120(stage_8_per_in[120]),
    .inData_121(stage_8_per_in[121]),
    .inData_122(stage_8_per_in[122]),
    .inData_123(stage_8_per_in[123]),
    .inData_124(stage_8_per_in[124]),
    .inData_125(stage_8_per_in[125]),
    .inData_126(stage_8_per_in[126]),
    .inData_127(stage_8_per_in[127]),
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
    .outData_32(stage_8_per_out[32]),
    .outData_33(stage_8_per_out[33]),
    .outData_34(stage_8_per_out[34]),
    .outData_35(stage_8_per_out[35]),
    .outData_36(stage_8_per_out[36]),
    .outData_37(stage_8_per_out[37]),
    .outData_38(stage_8_per_out[38]),
    .outData_39(stage_8_per_out[39]),
    .outData_40(stage_8_per_out[40]),
    .outData_41(stage_8_per_out[41]),
    .outData_42(stage_8_per_out[42]),
    .outData_43(stage_8_per_out[43]),
    .outData_44(stage_8_per_out[44]),
    .outData_45(stage_8_per_out[45]),
    .outData_46(stage_8_per_out[46]),
    .outData_47(stage_8_per_out[47]),
    .outData_48(stage_8_per_out[48]),
    .outData_49(stage_8_per_out[49]),
    .outData_50(stage_8_per_out[50]),
    .outData_51(stage_8_per_out[51]),
    .outData_52(stage_8_per_out[52]),
    .outData_53(stage_8_per_out[53]),
    .outData_54(stage_8_per_out[54]),
    .outData_55(stage_8_per_out[55]),
    .outData_56(stage_8_per_out[56]),
    .outData_57(stage_8_per_out[57]),
    .outData_58(stage_8_per_out[58]),
    .outData_59(stage_8_per_out[59]),
    .outData_60(stage_8_per_out[60]),
    .outData_61(stage_8_per_out[61]),
    .outData_62(stage_8_per_out[62]),
    .outData_63(stage_8_per_out[63]),
    .outData_64(stage_8_per_out[64]),
    .outData_65(stage_8_per_out[65]),
    .outData_66(stage_8_per_out[66]),
    .outData_67(stage_8_per_out[67]),
    .outData_68(stage_8_per_out[68]),
    .outData_69(stage_8_per_out[69]),
    .outData_70(stage_8_per_out[70]),
    .outData_71(stage_8_per_out[71]),
    .outData_72(stage_8_per_out[72]),
    .outData_73(stage_8_per_out[73]),
    .outData_74(stage_8_per_out[74]),
    .outData_75(stage_8_per_out[75]),
    .outData_76(stage_8_per_out[76]),
    .outData_77(stage_8_per_out[77]),
    .outData_78(stage_8_per_out[78]),
    .outData_79(stage_8_per_out[79]),
    .outData_80(stage_8_per_out[80]),
    .outData_81(stage_8_per_out[81]),
    .outData_82(stage_8_per_out[82]),
    .outData_83(stage_8_per_out[83]),
    .outData_84(stage_8_per_out[84]),
    .outData_85(stage_8_per_out[85]),
    .outData_86(stage_8_per_out[86]),
    .outData_87(stage_8_per_out[87]),
    .outData_88(stage_8_per_out[88]),
    .outData_89(stage_8_per_out[89]),
    .outData_90(stage_8_per_out[90]),
    .outData_91(stage_8_per_out[91]),
    .outData_92(stage_8_per_out[92]),
    .outData_93(stage_8_per_out[93]),
    .outData_94(stage_8_per_out[94]),
    .outData_95(stage_8_per_out[95]),
    .outData_96(stage_8_per_out[96]),
    .outData_97(stage_8_per_out[97]),
    .outData_98(stage_8_per_out[98]),
    .outData_99(stage_8_per_out[99]),
    .outData_100(stage_8_per_out[100]),
    .outData_101(stage_8_per_out[101]),
    .outData_102(stage_8_per_out[102]),
    .outData_103(stage_8_per_out[103]),
    .outData_104(stage_8_per_out[104]),
    .outData_105(stage_8_per_out[105]),
    .outData_106(stage_8_per_out[106]),
    .outData_107(stage_8_per_out[107]),
    .outData_108(stage_8_per_out[108]),
    .outData_109(stage_8_per_out[109]),
    .outData_110(stage_8_per_out[110]),
    .outData_111(stage_8_per_out[111]),
    .outData_112(stage_8_per_out[112]),
    .outData_113(stage_8_per_out[113]),
    .outData_114(stage_8_per_out[114]),
    .outData_115(stage_8_per_out[115]),
    .outData_116(stage_8_per_out[116]),
    .outData_117(stage_8_per_out[117]),
    .outData_118(stage_8_per_out[118]),
    .outData_119(stage_8_per_out[119]),
    .outData_120(stage_8_per_out[120]),
    .outData_121(stage_8_per_out[121]),
    .outData_122(stage_8_per_out[122]),
    .outData_123(stage_8_per_out[123]),
    .outData_124(stage_8_per_out[124]),
    .outData_125(stage_8_per_out[125]),
    .outData_126(stage_8_per_out[126]),
    .outData_127(stage_8_per_out[127]),
    .in_start(in_start[8]),
    .out_start(out_start[8]),
    .clk(clk),
    .rst(rst)
  );
  // TODO(Tian): stage 9 32 butterfly units
  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_0 (
    .x_in(stage_8_per_out[0]),
    .y_in(stage_8_per_out[1]),
    .x_out(stage_9_per_in[0]),
    .y_out(stage_9_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_1 (
    .x_in(stage_8_per_out[2]),
    .y_in(stage_8_per_out[3]),
    .x_out(stage_9_per_in[2]),
    .y_out(stage_9_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_2 (
    .x_in(stage_8_per_out[4]),
    .y_in(stage_8_per_out[5]),
    .x_out(stage_9_per_in[4]),
    .y_out(stage_9_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_3 (
    .x_in(stage_8_per_out[6]),
    .y_in(stage_8_per_out[7]),
    .x_out(stage_9_per_in[6]),
    .y_out(stage_9_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_4 (
    .x_in(stage_8_per_out[8]),
    .y_in(stage_8_per_out[9]),
    .x_out(stage_9_per_in[8]),
    .y_out(stage_9_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_5 (
    .x_in(stage_8_per_out[10]),
    .y_in(stage_8_per_out[11]),
    .x_out(stage_9_per_in[10]),
    .y_out(stage_9_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_6 (
    .x_in(stage_8_per_out[12]),
    .y_in(stage_8_per_out[13]),
    .x_out(stage_9_per_in[12]),
    .y_out(stage_9_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_7 (
    .x_in(stage_8_per_out[14]),
    .y_in(stage_8_per_out[15]),
    .x_out(stage_9_per_in[14]),
    .y_out(stage_9_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_8 (
    .x_in(stage_8_per_out[16]),
    .y_in(stage_8_per_out[17]),
    .x_out(stage_9_per_in[16]),
    .y_out(stage_9_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_9 (
    .x_in(stage_8_per_out[18]),
    .y_in(stage_8_per_out[19]),
    .x_out(stage_9_per_in[18]),
    .y_out(stage_9_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_10 (
    .x_in(stage_8_per_out[20]),
    .y_in(stage_8_per_out[21]),
    .x_out(stage_9_per_in[20]),
    .y_out(stage_9_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_11 (
    .x_in(stage_8_per_out[22]),
    .y_in(stage_8_per_out[23]),
    .x_out(stage_9_per_in[22]),
    .y_out(stage_9_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_12 (
    .x_in(stage_8_per_out[24]),
    .y_in(stage_8_per_out[25]),
    .x_out(stage_9_per_in[24]),
    .y_out(stage_9_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_13 (
    .x_in(stage_8_per_out[26]),
    .y_in(stage_8_per_out[27]),
    .x_out(stage_9_per_in[26]),
    .y_out(stage_9_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_14 (
    .x_in(stage_8_per_out[28]),
    .y_in(stage_8_per_out[29]),
    .x_out(stage_9_per_in[28]),
    .y_out(stage_9_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_15 (
    .x_in(stage_8_per_out[30]),
    .y_in(stage_8_per_out[31]),
    .x_out(stage_9_per_in[30]),
    .y_out(stage_9_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_16 (
    .x_in(stage_8_per_out[32]),
    .y_in(stage_8_per_out[33]),
    .x_out(stage_9_per_in[32]),
    .y_out(stage_9_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_17 (
    .x_in(stage_8_per_out[34]),
    .y_in(stage_8_per_out[35]),
    .x_out(stage_9_per_in[34]),
    .y_out(stage_9_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_18 (
    .x_in(stage_8_per_out[36]),
    .y_in(stage_8_per_out[37]),
    .x_out(stage_9_per_in[36]),
    .y_out(stage_9_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_19 (
    .x_in(stage_8_per_out[38]),
    .y_in(stage_8_per_out[39]),
    .x_out(stage_9_per_in[38]),
    .y_out(stage_9_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_20 (
    .x_in(stage_8_per_out[40]),
    .y_in(stage_8_per_out[41]),
    .x_out(stage_9_per_in[40]),
    .y_out(stage_9_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_21 (
    .x_in(stage_8_per_out[42]),
    .y_in(stage_8_per_out[43]),
    .x_out(stage_9_per_in[42]),
    .y_out(stage_9_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_22 (
    .x_in(stage_8_per_out[44]),
    .y_in(stage_8_per_out[45]),
    .x_out(stage_9_per_in[44]),
    .y_out(stage_9_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_23 (
    .x_in(stage_8_per_out[46]),
    .y_in(stage_8_per_out[47]),
    .x_out(stage_9_per_in[46]),
    .y_out(stage_9_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_24 (
    .x_in(stage_8_per_out[48]),
    .y_in(stage_8_per_out[49]),
    .x_out(stage_9_per_in[48]),
    .y_out(stage_9_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_25 (
    .x_in(stage_8_per_out[50]),
    .y_in(stage_8_per_out[51]),
    .x_out(stage_9_per_in[50]),
    .y_out(stage_9_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_26 (
    .x_in(stage_8_per_out[52]),
    .y_in(stage_8_per_out[53]),
    .x_out(stage_9_per_in[52]),
    .y_out(stage_9_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_27 (
    .x_in(stage_8_per_out[54]),
    .y_in(stage_8_per_out[55]),
    .x_out(stage_9_per_in[54]),
    .y_out(stage_9_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_28 (
    .x_in(stage_8_per_out[56]),
    .y_in(stage_8_per_out[57]),
    .x_out(stage_9_per_in[56]),
    .y_out(stage_9_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_29 (
    .x_in(stage_8_per_out[58]),
    .y_in(stage_8_per_out[59]),
    .x_out(stage_9_per_in[58]),
    .y_out(stage_9_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_30 (
    .x_in(stage_8_per_out[60]),
    .y_in(stage_8_per_out[61]),
    .x_out(stage_9_per_in[60]),
    .y_out(stage_9_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_31 (
    .x_in(stage_8_per_out[62]),
    .y_in(stage_8_per_out[63]),
    .x_out(stage_9_per_in[62]),
    .y_out(stage_9_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_32 (
    .x_in(stage_8_per_out[64]),
    .y_in(stage_8_per_out[65]),
    .x_out(stage_9_per_in[64]),
    .y_out(stage_9_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_33 (
    .x_in(stage_8_per_out[66]),
    .y_in(stage_8_per_out[67]),
    .x_out(stage_9_per_in[66]),
    .y_out(stage_9_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_34 (
    .x_in(stage_8_per_out[68]),
    .y_in(stage_8_per_out[69]),
    .x_out(stage_9_per_in[68]),
    .y_out(stage_9_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_35 (
    .x_in(stage_8_per_out[70]),
    .y_in(stage_8_per_out[71]),
    .x_out(stage_9_per_in[70]),
    .y_out(stage_9_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_36 (
    .x_in(stage_8_per_out[72]),
    .y_in(stage_8_per_out[73]),
    .x_out(stage_9_per_in[72]),
    .y_out(stage_9_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_37 (
    .x_in(stage_8_per_out[74]),
    .y_in(stage_8_per_out[75]),
    .x_out(stage_9_per_in[74]),
    .y_out(stage_9_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_38 (
    .x_in(stage_8_per_out[76]),
    .y_in(stage_8_per_out[77]),
    .x_out(stage_9_per_in[76]),
    .y_out(stage_9_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_39 (
    .x_in(stage_8_per_out[78]),
    .y_in(stage_8_per_out[79]),
    .x_out(stage_9_per_in[78]),
    .y_out(stage_9_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_40 (
    .x_in(stage_8_per_out[80]),
    .y_in(stage_8_per_out[81]),
    .x_out(stage_9_per_in[80]),
    .y_out(stage_9_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_41 (
    .x_in(stage_8_per_out[82]),
    .y_in(stage_8_per_out[83]),
    .x_out(stage_9_per_in[82]),
    .y_out(stage_9_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_42 (
    .x_in(stage_8_per_out[84]),
    .y_in(stage_8_per_out[85]),
    .x_out(stage_9_per_in[84]),
    .y_out(stage_9_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_43 (
    .x_in(stage_8_per_out[86]),
    .y_in(stage_8_per_out[87]),
    .x_out(stage_9_per_in[86]),
    .y_out(stage_9_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_44 (
    .x_in(stage_8_per_out[88]),
    .y_in(stage_8_per_out[89]),
    .x_out(stage_9_per_in[88]),
    .y_out(stage_9_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_45 (
    .x_in(stage_8_per_out[90]),
    .y_in(stage_8_per_out[91]),
    .x_out(stage_9_per_in[90]),
    .y_out(stage_9_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_46 (
    .x_in(stage_8_per_out[92]),
    .y_in(stage_8_per_out[93]),
    .x_out(stage_9_per_in[92]),
    .y_out(stage_9_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_47 (
    .x_in(stage_8_per_out[94]),
    .y_in(stage_8_per_out[95]),
    .x_out(stage_9_per_in[94]),
    .y_out(stage_9_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_48 (
    .x_in(stage_8_per_out[96]),
    .y_in(stage_8_per_out[97]),
    .x_out(stage_9_per_in[96]),
    .y_out(stage_9_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_49 (
    .x_in(stage_8_per_out[98]),
    .y_in(stage_8_per_out[99]),
    .x_out(stage_9_per_in[98]),
    .y_out(stage_9_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_50 (
    .x_in(stage_8_per_out[100]),
    .y_in(stage_8_per_out[101]),
    .x_out(stage_9_per_in[100]),
    .y_out(stage_9_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_51 (
    .x_in(stage_8_per_out[102]),
    .y_in(stage_8_per_out[103]),
    .x_out(stage_9_per_in[102]),
    .y_out(stage_9_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_52 (
    .x_in(stage_8_per_out[104]),
    .y_in(stage_8_per_out[105]),
    .x_out(stage_9_per_in[104]),
    .y_out(stage_9_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_53 (
    .x_in(stage_8_per_out[106]),
    .y_in(stage_8_per_out[107]),
    .x_out(stage_9_per_in[106]),
    .y_out(stage_9_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_54 (
    .x_in(stage_8_per_out[108]),
    .y_in(stage_8_per_out[109]),
    .x_out(stage_9_per_in[108]),
    .y_out(stage_9_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_55 (
    .x_in(stage_8_per_out[110]),
    .y_in(stage_8_per_out[111]),
    .x_out(stage_9_per_in[110]),
    .y_out(stage_9_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_56 (
    .x_in(stage_8_per_out[112]),
    .y_in(stage_8_per_out[113]),
    .x_out(stage_9_per_in[112]),
    .y_out(stage_9_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_57 (
    .x_in(stage_8_per_out[114]),
    .y_in(stage_8_per_out[115]),
    .x_out(stage_9_per_in[114]),
    .y_out(stage_9_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_58 (
    .x_in(stage_8_per_out[116]),
    .y_in(stage_8_per_out[117]),
    .x_out(stage_9_per_in[116]),
    .y_out(stage_9_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_59 (
    .x_in(stage_8_per_out[118]),
    .y_in(stage_8_per_out[119]),
    .x_out(stage_9_per_in[118]),
    .y_out(stage_9_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_60 (
    .x_in(stage_8_per_out[120]),
    .y_in(stage_8_per_out[121]),
    .x_out(stage_9_per_in[120]),
    .y_out(stage_9_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_61 (
    .x_in(stage_8_per_out[122]),
    .y_in(stage_8_per_out[123]),
    .x_out(stage_9_per_in[122]),
    .y_out(stage_9_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_62 (
    .x_in(stage_8_per_out[124]),
    .y_in(stage_8_per_out[125]),
    .x_out(stage_9_per_in[124]),
    .y_out(stage_9_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_9_butterfly_63 (
    .x_in(stage_8_per_out[126]),
    .y_in(stage_8_per_out[127]),
    .x_out(stage_9_per_in[126]),
    .y_out(stage_9_per_in[127]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Yang): stage 8 -> stage 9 permutation
  // FIXME: ignore butterfly units for now.
  stage_9_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_9_10_per (
    .inData_0(stage_9_per_in[0]),
    .inData_1(stage_9_per_in[1]),
    .inData_2(stage_9_per_in[2]),
    .inData_3(stage_9_per_in[3]),
    .inData_4(stage_9_per_in[4]),
    .inData_5(stage_9_per_in[5]),
    .inData_6(stage_9_per_in[6]),
    .inData_7(stage_9_per_in[7]),
    .inData_8(stage_9_per_in[8]),
    .inData_9(stage_9_per_in[9]),
    .inData_10(stage_9_per_in[10]),
    .inData_11(stage_9_per_in[11]),
    .inData_12(stage_9_per_in[12]),
    .inData_13(stage_9_per_in[13]),
    .inData_14(stage_9_per_in[14]),
    .inData_15(stage_9_per_in[15]),
    .inData_16(stage_9_per_in[16]),
    .inData_17(stage_9_per_in[17]),
    .inData_18(stage_9_per_in[18]),
    .inData_19(stage_9_per_in[19]),
    .inData_20(stage_9_per_in[20]),
    .inData_21(stage_9_per_in[21]),
    .inData_22(stage_9_per_in[22]),
    .inData_23(stage_9_per_in[23]),
    .inData_24(stage_9_per_in[24]),
    .inData_25(stage_9_per_in[25]),
    .inData_26(stage_9_per_in[26]),
    .inData_27(stage_9_per_in[27]),
    .inData_28(stage_9_per_in[28]),
    .inData_29(stage_9_per_in[29]),
    .inData_30(stage_9_per_in[30]),
    .inData_31(stage_9_per_in[31]),
    .inData_32(stage_9_per_in[32]),
    .inData_33(stage_9_per_in[33]),
    .inData_34(stage_9_per_in[34]),
    .inData_35(stage_9_per_in[35]),
    .inData_36(stage_9_per_in[36]),
    .inData_37(stage_9_per_in[37]),
    .inData_38(stage_9_per_in[38]),
    .inData_39(stage_9_per_in[39]),
    .inData_40(stage_9_per_in[40]),
    .inData_41(stage_9_per_in[41]),
    .inData_42(stage_9_per_in[42]),
    .inData_43(stage_9_per_in[43]),
    .inData_44(stage_9_per_in[44]),
    .inData_45(stage_9_per_in[45]),
    .inData_46(stage_9_per_in[46]),
    .inData_47(stage_9_per_in[47]),
    .inData_48(stage_9_per_in[48]),
    .inData_49(stage_9_per_in[49]),
    .inData_50(stage_9_per_in[50]),
    .inData_51(stage_9_per_in[51]),
    .inData_52(stage_9_per_in[52]),
    .inData_53(stage_9_per_in[53]),
    .inData_54(stage_9_per_in[54]),
    .inData_55(stage_9_per_in[55]),
    .inData_56(stage_9_per_in[56]),
    .inData_57(stage_9_per_in[57]),
    .inData_58(stage_9_per_in[58]),
    .inData_59(stage_9_per_in[59]),
    .inData_60(stage_9_per_in[60]),
    .inData_61(stage_9_per_in[61]),
    .inData_62(stage_9_per_in[62]),
    .inData_63(stage_9_per_in[63]),
    .inData_64(stage_9_per_in[64]),
    .inData_65(stage_9_per_in[65]),
    .inData_66(stage_9_per_in[66]),
    .inData_67(stage_9_per_in[67]),
    .inData_68(stage_9_per_in[68]),
    .inData_69(stage_9_per_in[69]),
    .inData_70(stage_9_per_in[70]),
    .inData_71(stage_9_per_in[71]),
    .inData_72(stage_9_per_in[72]),
    .inData_73(stage_9_per_in[73]),
    .inData_74(stage_9_per_in[74]),
    .inData_75(stage_9_per_in[75]),
    .inData_76(stage_9_per_in[76]),
    .inData_77(stage_9_per_in[77]),
    .inData_78(stage_9_per_in[78]),
    .inData_79(stage_9_per_in[79]),
    .inData_80(stage_9_per_in[80]),
    .inData_81(stage_9_per_in[81]),
    .inData_82(stage_9_per_in[82]),
    .inData_83(stage_9_per_in[83]),
    .inData_84(stage_9_per_in[84]),
    .inData_85(stage_9_per_in[85]),
    .inData_86(stage_9_per_in[86]),
    .inData_87(stage_9_per_in[87]),
    .inData_88(stage_9_per_in[88]),
    .inData_89(stage_9_per_in[89]),
    .inData_90(stage_9_per_in[90]),
    .inData_91(stage_9_per_in[91]),
    .inData_92(stage_9_per_in[92]),
    .inData_93(stage_9_per_in[93]),
    .inData_94(stage_9_per_in[94]),
    .inData_95(stage_9_per_in[95]),
    .inData_96(stage_9_per_in[96]),
    .inData_97(stage_9_per_in[97]),
    .inData_98(stage_9_per_in[98]),
    .inData_99(stage_9_per_in[99]),
    .inData_100(stage_9_per_in[100]),
    .inData_101(stage_9_per_in[101]),
    .inData_102(stage_9_per_in[102]),
    .inData_103(stage_9_per_in[103]),
    .inData_104(stage_9_per_in[104]),
    .inData_105(stage_9_per_in[105]),
    .inData_106(stage_9_per_in[106]),
    .inData_107(stage_9_per_in[107]),
    .inData_108(stage_9_per_in[108]),
    .inData_109(stage_9_per_in[109]),
    .inData_110(stage_9_per_in[110]),
    .inData_111(stage_9_per_in[111]),
    .inData_112(stage_9_per_in[112]),
    .inData_113(stage_9_per_in[113]),
    .inData_114(stage_9_per_in[114]),
    .inData_115(stage_9_per_in[115]),
    .inData_116(stage_9_per_in[116]),
    .inData_117(stage_9_per_in[117]),
    .inData_118(stage_9_per_in[118]),
    .inData_119(stage_9_per_in[119]),
    .inData_120(stage_9_per_in[120]),
    .inData_121(stage_9_per_in[121]),
    .inData_122(stage_9_per_in[122]),
    .inData_123(stage_9_per_in[123]),
    .inData_124(stage_9_per_in[124]),
    .inData_125(stage_9_per_in[125]),
    .inData_126(stage_9_per_in[126]),
    .inData_127(stage_9_per_in[127]),
    .outData_0(stage_9_per_out[0]),
    .outData_1(stage_9_per_out[1]),
    .outData_2(stage_9_per_out[2]),
    .outData_3(stage_9_per_out[3]),
    .outData_4(stage_9_per_out[4]),
    .outData_5(stage_9_per_out[5]),
    .outData_6(stage_9_per_out[6]),
    .outData_7(stage_9_per_out[7]),
    .outData_8(stage_9_per_out[8]),
    .outData_9(stage_9_per_out[9]),
    .outData_10(stage_9_per_out[10]),
    .outData_11(stage_9_per_out[11]),
    .outData_12(stage_9_per_out[12]),
    .outData_13(stage_9_per_out[13]),
    .outData_14(stage_9_per_out[14]),
    .outData_15(stage_9_per_out[15]),
    .outData_16(stage_9_per_out[16]),
    .outData_17(stage_9_per_out[17]),
    .outData_18(stage_9_per_out[18]),
    .outData_19(stage_9_per_out[19]),
    .outData_20(stage_9_per_out[20]),
    .outData_21(stage_9_per_out[21]),
    .outData_22(stage_9_per_out[22]),
    .outData_23(stage_9_per_out[23]),
    .outData_24(stage_9_per_out[24]),
    .outData_25(stage_9_per_out[25]),
    .outData_26(stage_9_per_out[26]),
    .outData_27(stage_9_per_out[27]),
    .outData_28(stage_9_per_out[28]),
    .outData_29(stage_9_per_out[29]),
    .outData_30(stage_9_per_out[30]),
    .outData_31(stage_9_per_out[31]),
    .outData_32(stage_9_per_out[32]),
    .outData_33(stage_9_per_out[33]),
    .outData_34(stage_9_per_out[34]),
    .outData_35(stage_9_per_out[35]),
    .outData_36(stage_9_per_out[36]),
    .outData_37(stage_9_per_out[37]),
    .outData_38(stage_9_per_out[38]),
    .outData_39(stage_9_per_out[39]),
    .outData_40(stage_9_per_out[40]),
    .outData_41(stage_9_per_out[41]),
    .outData_42(stage_9_per_out[42]),
    .outData_43(stage_9_per_out[43]),
    .outData_44(stage_9_per_out[44]),
    .outData_45(stage_9_per_out[45]),
    .outData_46(stage_9_per_out[46]),
    .outData_47(stage_9_per_out[47]),
    .outData_48(stage_9_per_out[48]),
    .outData_49(stage_9_per_out[49]),
    .outData_50(stage_9_per_out[50]),
    .outData_51(stage_9_per_out[51]),
    .outData_52(stage_9_per_out[52]),
    .outData_53(stage_9_per_out[53]),
    .outData_54(stage_9_per_out[54]),
    .outData_55(stage_9_per_out[55]),
    .outData_56(stage_9_per_out[56]),
    .outData_57(stage_9_per_out[57]),
    .outData_58(stage_9_per_out[58]),
    .outData_59(stage_9_per_out[59]),
    .outData_60(stage_9_per_out[60]),
    .outData_61(stage_9_per_out[61]),
    .outData_62(stage_9_per_out[62]),
    .outData_63(stage_9_per_out[63]),
    .outData_64(stage_9_per_out[64]),
    .outData_65(stage_9_per_out[65]),
    .outData_66(stage_9_per_out[66]),
    .outData_67(stage_9_per_out[67]),
    .outData_68(stage_9_per_out[68]),
    .outData_69(stage_9_per_out[69]),
    .outData_70(stage_9_per_out[70]),
    .outData_71(stage_9_per_out[71]),
    .outData_72(stage_9_per_out[72]),
    .outData_73(stage_9_per_out[73]),
    .outData_74(stage_9_per_out[74]),
    .outData_75(stage_9_per_out[75]),
    .outData_76(stage_9_per_out[76]),
    .outData_77(stage_9_per_out[77]),
    .outData_78(stage_9_per_out[78]),
    .outData_79(stage_9_per_out[79]),
    .outData_80(stage_9_per_out[80]),
    .outData_81(stage_9_per_out[81]),
    .outData_82(stage_9_per_out[82]),
    .outData_83(stage_9_per_out[83]),
    .outData_84(stage_9_per_out[84]),
    .outData_85(stage_9_per_out[85]),
    .outData_86(stage_9_per_out[86]),
    .outData_87(stage_9_per_out[87]),
    .outData_88(stage_9_per_out[88]),
    .outData_89(stage_9_per_out[89]),
    .outData_90(stage_9_per_out[90]),
    .outData_91(stage_9_per_out[91]),
    .outData_92(stage_9_per_out[92]),
    .outData_93(stage_9_per_out[93]),
    .outData_94(stage_9_per_out[94]),
    .outData_95(stage_9_per_out[95]),
    .outData_96(stage_9_per_out[96]),
    .outData_97(stage_9_per_out[97]),
    .outData_98(stage_9_per_out[98]),
    .outData_99(stage_9_per_out[99]),
    .outData_100(stage_9_per_out[100]),
    .outData_101(stage_9_per_out[101]),
    .outData_102(stage_9_per_out[102]),
    .outData_103(stage_9_per_out[103]),
    .outData_104(stage_9_per_out[104]),
    .outData_105(stage_9_per_out[105]),
    .outData_106(stage_9_per_out[106]),
    .outData_107(stage_9_per_out[107]),
    .outData_108(stage_9_per_out[108]),
    .outData_109(stage_9_per_out[109]),
    .outData_110(stage_9_per_out[110]),
    .outData_111(stage_9_per_out[111]),
    .outData_112(stage_9_per_out[112]),
    .outData_113(stage_9_per_out[113]),
    .outData_114(stage_9_per_out[114]),
    .outData_115(stage_9_per_out[115]),
    .outData_116(stage_9_per_out[116]),
    .outData_117(stage_9_per_out[117]),
    .outData_118(stage_9_per_out[118]),
    .outData_119(stage_9_per_out[119]),
    .outData_120(stage_9_per_out[120]),
    .outData_121(stage_9_per_out[121]),
    .outData_122(stage_9_per_out[122]),
    .outData_123(stage_9_per_out[123]),
    .outData_124(stage_9_per_out[124]),
    .outData_125(stage_9_per_out[125]),
    .outData_126(stage_9_per_out[126]),
    .outData_127(stage_9_per_out[127]),
    .in_start(in_start[9]),
    .out_start(out_start[9]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Tian): stage 9 32 butterfly units
  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_0 (
    .x_in(stage_9_per_out[0]),
    .y_in(stage_9_per_out[1]),
    .x_out(stage_10_per_in[0]),
    .y_out(stage_10_per_in[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_1 (
    .x_in(stage_9_per_out[2]),
    .y_in(stage_9_per_out[3]),
    .x_out(stage_10_per_in[2]),
    .y_out(stage_10_per_in[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_2 (
    .x_in(stage_9_per_out[4]),
    .y_in(stage_9_per_out[5]),
    .x_out(stage_10_per_in[4]),
    .y_out(stage_10_per_in[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_3 (
    .x_in(stage_9_per_out[6]),
    .y_in(stage_9_per_out[7]),
    .x_out(stage_10_per_in[6]),
    .y_out(stage_10_per_in[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_4 (
    .x_in(stage_9_per_out[8]),
    .y_in(stage_9_per_out[9]),
    .x_out(stage_10_per_in[8]),
    .y_out(stage_10_per_in[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_5 (
    .x_in(stage_9_per_out[10]),
    .y_in(stage_9_per_out[11]),
    .x_out(stage_10_per_in[10]),
    .y_out(stage_10_per_in[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_6 (
    .x_in(stage_9_per_out[12]),
    .y_in(stage_9_per_out[13]),
    .x_out(stage_10_per_in[12]),
    .y_out(stage_10_per_in[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_7 (
    .x_in(stage_9_per_out[14]),
    .y_in(stage_9_per_out[15]),
    .x_out(stage_10_per_in[14]),
    .y_out(stage_10_per_in[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_8 (
    .x_in(stage_9_per_out[16]),
    .y_in(stage_9_per_out[17]),
    .x_out(stage_10_per_in[16]),
    .y_out(stage_10_per_in[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_9 (
    .x_in(stage_9_per_out[18]),
    .y_in(stage_9_per_out[19]),
    .x_out(stage_10_per_in[18]),
    .y_out(stage_10_per_in[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_10 (
    .x_in(stage_9_per_out[20]),
    .y_in(stage_9_per_out[21]),
    .x_out(stage_10_per_in[20]),
    .y_out(stage_10_per_in[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_11 (
    .x_in(stage_9_per_out[22]),
    .y_in(stage_9_per_out[23]),
    .x_out(stage_10_per_in[22]),
    .y_out(stage_10_per_in[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_12 (
    .x_in(stage_9_per_out[24]),
    .y_in(stage_9_per_out[25]),
    .x_out(stage_10_per_in[24]),
    .y_out(stage_10_per_in[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_13 (
    .x_in(stage_9_per_out[26]),
    .y_in(stage_9_per_out[27]),
    .x_out(stage_10_per_in[26]),
    .y_out(stage_10_per_in[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_14 (
    .x_in(stage_9_per_out[28]),
    .y_in(stage_9_per_out[29]),
    .x_out(stage_10_per_in[28]),
    .y_out(stage_10_per_in[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_15 (
    .x_in(stage_9_per_out[30]),
    .y_in(stage_9_per_out[31]),
    .x_out(stage_10_per_in[30]),
    .y_out(stage_10_per_in[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_16 (
    .x_in(stage_9_per_out[32]),
    .y_in(stage_9_per_out[33]),
    .x_out(stage_10_per_in[32]),
    .y_out(stage_10_per_in[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_17 (
    .x_in(stage_9_per_out[34]),
    .y_in(stage_9_per_out[35]),
    .x_out(stage_10_per_in[34]),
    .y_out(stage_10_per_in[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_18 (
    .x_in(stage_9_per_out[36]),
    .y_in(stage_9_per_out[37]),
    .x_out(stage_10_per_in[36]),
    .y_out(stage_10_per_in[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_19 (
    .x_in(stage_9_per_out[38]),
    .y_in(stage_9_per_out[39]),
    .x_out(stage_10_per_in[38]),
    .y_out(stage_10_per_in[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_20 (
    .x_in(stage_9_per_out[40]),
    .y_in(stage_9_per_out[41]),
    .x_out(stage_10_per_in[40]),
    .y_out(stage_10_per_in[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_21 (
    .x_in(stage_9_per_out[42]),
    .y_in(stage_9_per_out[43]),
    .x_out(stage_10_per_in[42]),
    .y_out(stage_10_per_in[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_22 (
    .x_in(stage_9_per_out[44]),
    .y_in(stage_9_per_out[45]),
    .x_out(stage_10_per_in[44]),
    .y_out(stage_10_per_in[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_23 (
    .x_in(stage_9_per_out[46]),
    .y_in(stage_9_per_out[47]),
    .x_out(stage_10_per_in[46]),
    .y_out(stage_10_per_in[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_24 (
    .x_in(stage_9_per_out[48]),
    .y_in(stage_9_per_out[49]),
    .x_out(stage_10_per_in[48]),
    .y_out(stage_10_per_in[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_25 (
    .x_in(stage_9_per_out[50]),
    .y_in(stage_9_per_out[51]),
    .x_out(stage_10_per_in[50]),
    .y_out(stage_10_per_in[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_26 (
    .x_in(stage_9_per_out[52]),
    .y_in(stage_9_per_out[53]),
    .x_out(stage_10_per_in[52]),
    .y_out(stage_10_per_in[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_27 (
    .x_in(stage_9_per_out[54]),
    .y_in(stage_9_per_out[55]),
    .x_out(stage_10_per_in[54]),
    .y_out(stage_10_per_in[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_28 (
    .x_in(stage_9_per_out[56]),
    .y_in(stage_9_per_out[57]),
    .x_out(stage_10_per_in[56]),
    .y_out(stage_10_per_in[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_29 (
    .x_in(stage_9_per_out[58]),
    .y_in(stage_9_per_out[59]),
    .x_out(stage_10_per_in[58]),
    .y_out(stage_10_per_in[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_30 (
    .x_in(stage_9_per_out[60]),
    .y_in(stage_9_per_out[61]),
    .x_out(stage_10_per_in[60]),
    .y_out(stage_10_per_in[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_31 (
    .x_in(stage_9_per_out[62]),
    .y_in(stage_9_per_out[63]),
    .x_out(stage_10_per_in[62]),
    .y_out(stage_10_per_in[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_32 (
    .x_in(stage_9_per_out[64]),
    .y_in(stage_9_per_out[65]),
    .x_out(stage_10_per_in[64]),
    .y_out(stage_10_per_in[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_33 (
    .x_in(stage_9_per_out[66]),
    .y_in(stage_9_per_out[67]),
    .x_out(stage_10_per_in[66]),
    .y_out(stage_10_per_in[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_34 (
    .x_in(stage_9_per_out[68]),
    .y_in(stage_9_per_out[69]),
    .x_out(stage_10_per_in[68]),
    .y_out(stage_10_per_in[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_35 (
    .x_in(stage_9_per_out[70]),
    .y_in(stage_9_per_out[71]),
    .x_out(stage_10_per_in[70]),
    .y_out(stage_10_per_in[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_36 (
    .x_in(stage_9_per_out[72]),
    .y_in(stage_9_per_out[73]),
    .x_out(stage_10_per_in[72]),
    .y_out(stage_10_per_in[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_37 (
    .x_in(stage_9_per_out[74]),
    .y_in(stage_9_per_out[75]),
    .x_out(stage_10_per_in[74]),
    .y_out(stage_10_per_in[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_38 (
    .x_in(stage_9_per_out[76]),
    .y_in(stage_9_per_out[77]),
    .x_out(stage_10_per_in[76]),
    .y_out(stage_10_per_in[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_39 (
    .x_in(stage_9_per_out[78]),
    .y_in(stage_9_per_out[79]),
    .x_out(stage_10_per_in[78]),
    .y_out(stage_10_per_in[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_40 (
    .x_in(stage_9_per_out[80]),
    .y_in(stage_9_per_out[81]),
    .x_out(stage_10_per_in[80]),
    .y_out(stage_10_per_in[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_41 (
    .x_in(stage_9_per_out[82]),
    .y_in(stage_9_per_out[83]),
    .x_out(stage_10_per_in[82]),
    .y_out(stage_10_per_in[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_42 (
    .x_in(stage_9_per_out[84]),
    .y_in(stage_9_per_out[85]),
    .x_out(stage_10_per_in[84]),
    .y_out(stage_10_per_in[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_43 (
    .x_in(stage_9_per_out[86]),
    .y_in(stage_9_per_out[87]),
    .x_out(stage_10_per_in[86]),
    .y_out(stage_10_per_in[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_44 (
    .x_in(stage_9_per_out[88]),
    .y_in(stage_9_per_out[89]),
    .x_out(stage_10_per_in[88]),
    .y_out(stage_10_per_in[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_45 (
    .x_in(stage_9_per_out[90]),
    .y_in(stage_9_per_out[91]),
    .x_out(stage_10_per_in[90]),
    .y_out(stage_10_per_in[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_46 (
    .x_in(stage_9_per_out[92]),
    .y_in(stage_9_per_out[93]),
    .x_out(stage_10_per_in[92]),
    .y_out(stage_10_per_in[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_47 (
    .x_in(stage_9_per_out[94]),
    .y_in(stage_9_per_out[95]),
    .x_out(stage_10_per_in[94]),
    .y_out(stage_10_per_in[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_48 (
    .x_in(stage_9_per_out[96]),
    .y_in(stage_9_per_out[97]),
    .x_out(stage_10_per_in[96]),
    .y_out(stage_10_per_in[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_49 (
    .x_in(stage_9_per_out[98]),
    .y_in(stage_9_per_out[99]),
    .x_out(stage_10_per_in[98]),
    .y_out(stage_10_per_in[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_50 (
    .x_in(stage_9_per_out[100]),
    .y_in(stage_9_per_out[101]),
    .x_out(stage_10_per_in[100]),
    .y_out(stage_10_per_in[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_51 (
    .x_in(stage_9_per_out[102]),
    .y_in(stage_9_per_out[103]),
    .x_out(stage_10_per_in[102]),
    .y_out(stage_10_per_in[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_52 (
    .x_in(stage_9_per_out[104]),
    .y_in(stage_9_per_out[105]),
    .x_out(stage_10_per_in[104]),
    .y_out(stage_10_per_in[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_53 (
    .x_in(stage_9_per_out[106]),
    .y_in(stage_9_per_out[107]),
    .x_out(stage_10_per_in[106]),
    .y_out(stage_10_per_in[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_54 (
    .x_in(stage_9_per_out[108]),
    .y_in(stage_9_per_out[109]),
    .x_out(stage_10_per_in[108]),
    .y_out(stage_10_per_in[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_55 (
    .x_in(stage_9_per_out[110]),
    .y_in(stage_9_per_out[111]),
    .x_out(stage_10_per_in[110]),
    .y_out(stage_10_per_in[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_56 (
    .x_in(stage_9_per_out[112]),
    .y_in(stage_9_per_out[113]),
    .x_out(stage_10_per_in[112]),
    .y_out(stage_10_per_in[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_57 (
    .x_in(stage_9_per_out[114]),
    .y_in(stage_9_per_out[115]),
    .x_out(stage_10_per_in[114]),
    .y_out(stage_10_per_in[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_58 (
    .x_in(stage_9_per_out[116]),
    .y_in(stage_9_per_out[117]),
    .x_out(stage_10_per_in[116]),
    .y_out(stage_10_per_in[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_59 (
    .x_in(stage_9_per_out[118]),
    .y_in(stage_9_per_out[119]),
    .x_out(stage_10_per_in[118]),
    .y_out(stage_10_per_in[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_60 (
    .x_in(stage_9_per_out[120]),
    .y_in(stage_9_per_out[121]),
    .x_out(stage_10_per_in[120]),
    .y_out(stage_10_per_in[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_61 (
    .x_in(stage_9_per_out[122]),
    .y_in(stage_9_per_out[123]),
    .x_out(stage_10_per_in[122]),
    .y_out(stage_10_per_in[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_62 (
    .x_in(stage_9_per_out[124]),
    .y_in(stage_9_per_out[125]),
    .x_out(stage_10_per_in[124]),
    .y_out(stage_10_per_in[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_63 (
    .x_in(stage_9_per_out[126]),
    .y_in(stage_9_per_out[127]),
    .x_out(stage_10_per_in[126]),
    .y_out(stage_10_per_in[127]),
    .clk(clk),
    .rst(rst)
  );



  // TODO(Yang): stage 8 -> stage 9 permutation
  // FIXME: ignore butterfly units for now.
  stage_10_permutation //#(
    //.DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    //.INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  stage_10_11_per (
    .inData_0(stage_10_per_in[0]),
    .inData_1(stage_10_per_in[1]),
    .inData_2(stage_10_per_in[2]),
    .inData_3(stage_10_per_in[3]),
    .inData_4(stage_10_per_in[4]),
    .inData_5(stage_10_per_in[5]),
    .inData_6(stage_10_per_in[6]),
    .inData_7(stage_10_per_in[7]),
    .inData_8(stage_10_per_in[8]),
    .inData_9(stage_10_per_in[9]),
    .inData_10(stage_10_per_in[10]),
    .inData_11(stage_10_per_in[11]),
    .inData_12(stage_10_per_in[12]),
    .inData_13(stage_10_per_in[13]),
    .inData_14(stage_10_per_in[14]),
    .inData_15(stage_10_per_in[15]),
    .inData_16(stage_10_per_in[16]),
    .inData_17(stage_10_per_in[17]),
    .inData_18(stage_10_per_in[18]),
    .inData_19(stage_10_per_in[19]),
    .inData_20(stage_10_per_in[20]),
    .inData_21(stage_10_per_in[21]),
    .inData_22(stage_10_per_in[22]),
    .inData_23(stage_10_per_in[23]),
    .inData_24(stage_10_per_in[24]),
    .inData_25(stage_10_per_in[25]),
    .inData_26(stage_10_per_in[26]),
    .inData_27(stage_10_per_in[27]),
    .inData_28(stage_10_per_in[28]),
    .inData_29(stage_10_per_in[29]),
    .inData_30(stage_10_per_in[30]),
    .inData_31(stage_10_per_in[31]),
    .inData_32(stage_10_per_in[32]),
    .inData_33(stage_10_per_in[33]),
    .inData_34(stage_10_per_in[34]),
    .inData_35(stage_10_per_in[35]),
    .inData_36(stage_10_per_in[36]),
    .inData_37(stage_10_per_in[37]),
    .inData_38(stage_10_per_in[38]),
    .inData_39(stage_10_per_in[39]),
    .inData_40(stage_10_per_in[40]),
    .inData_41(stage_10_per_in[41]),
    .inData_42(stage_10_per_in[42]),
    .inData_43(stage_10_per_in[43]),
    .inData_44(stage_10_per_in[44]),
    .inData_45(stage_10_per_in[45]),
    .inData_46(stage_10_per_in[46]),
    .inData_47(stage_10_per_in[47]),
    .inData_48(stage_10_per_in[48]),
    .inData_49(stage_10_per_in[49]),
    .inData_50(stage_10_per_in[50]),
    .inData_51(stage_10_per_in[51]),
    .inData_52(stage_10_per_in[52]),
    .inData_53(stage_10_per_in[53]),
    .inData_54(stage_10_per_in[54]),
    .inData_55(stage_10_per_in[55]),
    .inData_56(stage_10_per_in[56]),
    .inData_57(stage_10_per_in[57]),
    .inData_58(stage_10_per_in[58]),
    .inData_59(stage_10_per_in[59]),
    .inData_60(stage_10_per_in[60]),
    .inData_61(stage_10_per_in[61]),
    .inData_62(stage_10_per_in[62]),
    .inData_63(stage_10_per_in[63]),
    .inData_64(stage_10_per_in[64]),
    .inData_65(stage_10_per_in[65]),
    .inData_66(stage_10_per_in[66]),
    .inData_67(stage_10_per_in[67]),
    .inData_68(stage_10_per_in[68]),
    .inData_69(stage_10_per_in[69]),
    .inData_70(stage_10_per_in[70]),
    .inData_71(stage_10_per_in[71]),
    .inData_72(stage_10_per_in[72]),
    .inData_73(stage_10_per_in[73]),
    .inData_74(stage_10_per_in[74]),
    .inData_75(stage_10_per_in[75]),
    .inData_76(stage_10_per_in[76]),
    .inData_77(stage_10_per_in[77]),
    .inData_78(stage_10_per_in[78]),
    .inData_79(stage_10_per_in[79]),
    .inData_80(stage_10_per_in[80]),
    .inData_81(stage_10_per_in[81]),
    .inData_82(stage_10_per_in[82]),
    .inData_83(stage_10_per_in[83]),
    .inData_84(stage_10_per_in[84]),
    .inData_85(stage_10_per_in[85]),
    .inData_86(stage_10_per_in[86]),
    .inData_87(stage_10_per_in[87]),
    .inData_88(stage_10_per_in[88]),
    .inData_89(stage_10_per_in[89]),
    .inData_90(stage_10_per_in[90]),
    .inData_91(stage_10_per_in[91]),
    .inData_92(stage_10_per_in[92]),
    .inData_93(stage_10_per_in[93]),
    .inData_94(stage_10_per_in[94]),
    .inData_95(stage_10_per_in[95]),
    .inData_96(stage_10_per_in[96]),
    .inData_97(stage_10_per_in[97]),
    .inData_98(stage_10_per_in[98]),
    .inData_99(stage_10_per_in[99]),
    .inData_100(stage_10_per_in[100]),
    .inData_101(stage_10_per_in[101]),
    .inData_102(stage_10_per_in[102]),
    .inData_103(stage_10_per_in[103]),
    .inData_104(stage_10_per_in[104]),
    .inData_105(stage_10_per_in[105]),
    .inData_106(stage_10_per_in[106]),
    .inData_107(stage_10_per_in[107]),
    .inData_108(stage_10_per_in[108]),
    .inData_109(stage_10_per_in[109]),
    .inData_110(stage_10_per_in[110]),
    .inData_111(stage_10_per_in[111]),
    .inData_112(stage_10_per_in[112]),
    .inData_113(stage_10_per_in[113]),
    .inData_114(stage_10_per_in[114]),
    .inData_115(stage_10_per_in[115]),
    .inData_116(stage_10_per_in[116]),
    .inData_117(stage_10_per_in[117]),
    .inData_118(stage_10_per_in[118]),
    .inData_119(stage_10_per_in[119]),
    .inData_120(stage_10_per_in[120]),
    .inData_121(stage_10_per_in[121]),
    .inData_122(stage_10_per_in[122]),
    .inData_123(stage_10_per_in[123]),
    .inData_124(stage_10_per_in[124]),
    .inData_125(stage_10_per_in[125]),
    .inData_126(stage_10_per_in[126]),
    .inData_127(stage_10_per_in[127]),
    .outData_0(stage_10_per_out[0]),
    .outData_1(stage_10_per_out[1]),
    .outData_2(stage_10_per_out[2]),
    .outData_3(stage_10_per_out[3]),
    .outData_4(stage_10_per_out[4]),
    .outData_5(stage_10_per_out[5]),
    .outData_6(stage_10_per_out[6]),
    .outData_7(stage_10_per_out[7]),
    .outData_8(stage_10_per_out[8]),
    .outData_9(stage_10_per_out[9]),
    .outData_10(stage_10_per_out[10]),
    .outData_11(stage_10_per_out[11]),
    .outData_12(stage_10_per_out[12]),
    .outData_13(stage_10_per_out[13]),
    .outData_14(stage_10_per_out[14]),
    .outData_15(stage_10_per_out[15]),
    .outData_16(stage_10_per_out[16]),
    .outData_17(stage_10_per_out[17]),
    .outData_18(stage_10_per_out[18]),
    .outData_19(stage_10_per_out[19]),
    .outData_20(stage_10_per_out[20]),
    .outData_21(stage_10_per_out[21]),
    .outData_22(stage_10_per_out[22]),
    .outData_23(stage_10_per_out[23]),
    .outData_24(stage_10_per_out[24]),
    .outData_25(stage_10_per_out[25]),
    .outData_26(stage_10_per_out[26]),
    .outData_27(stage_10_per_out[27]),
    .outData_28(stage_10_per_out[28]),
    .outData_29(stage_10_per_out[29]),
    .outData_30(stage_10_per_out[30]),
    .outData_31(stage_10_per_out[31]),
    .outData_32(stage_10_per_out[32]),
    .outData_33(stage_10_per_out[33]),
    .outData_34(stage_10_per_out[34]),
    .outData_35(stage_10_per_out[35]),
    .outData_36(stage_10_per_out[36]),
    .outData_37(stage_10_per_out[37]),
    .outData_38(stage_10_per_out[38]),
    .outData_39(stage_10_per_out[39]),
    .outData_40(stage_10_per_out[40]),
    .outData_41(stage_10_per_out[41]),
    .outData_42(stage_10_per_out[42]),
    .outData_43(stage_10_per_out[43]),
    .outData_44(stage_10_per_out[44]),
    .outData_45(stage_10_per_out[45]),
    .outData_46(stage_10_per_out[46]),
    .outData_47(stage_10_per_out[47]),
    .outData_48(stage_10_per_out[48]),
    .outData_49(stage_10_per_out[49]),
    .outData_50(stage_10_per_out[50]),
    .outData_51(stage_10_per_out[51]),
    .outData_52(stage_10_per_out[52]),
    .outData_53(stage_10_per_out[53]),
    .outData_54(stage_10_per_out[54]),
    .outData_55(stage_10_per_out[55]),
    .outData_56(stage_10_per_out[56]),
    .outData_57(stage_10_per_out[57]),
    .outData_58(stage_10_per_out[58]),
    .outData_59(stage_10_per_out[59]),
    .outData_60(stage_10_per_out[60]),
    .outData_61(stage_10_per_out[61]),
    .outData_62(stage_10_per_out[62]),
    .outData_63(stage_10_per_out[63]),
    .outData_64(stage_10_per_out[64]),
    .outData_65(stage_10_per_out[65]),
    .outData_66(stage_10_per_out[66]),
    .outData_67(stage_10_per_out[67]),
    .outData_68(stage_10_per_out[68]),
    .outData_69(stage_10_per_out[69]),
    .outData_70(stage_10_per_out[70]),
    .outData_71(stage_10_per_out[71]),
    .outData_72(stage_10_per_out[72]),
    .outData_73(stage_10_per_out[73]),
    .outData_74(stage_10_per_out[74]),
    .outData_75(stage_10_per_out[75]),
    .outData_76(stage_10_per_out[76]),
    .outData_77(stage_10_per_out[77]),
    .outData_78(stage_10_per_out[78]),
    .outData_79(stage_10_per_out[79]),
    .outData_80(stage_10_per_out[80]),
    .outData_81(stage_10_per_out[81]),
    .outData_82(stage_10_per_out[82]),
    .outData_83(stage_10_per_out[83]),
    .outData_84(stage_10_per_out[84]),
    .outData_85(stage_10_per_out[85]),
    .outData_86(stage_10_per_out[86]),
    .outData_87(stage_10_per_out[87]),
    .outData_88(stage_10_per_out[88]),
    .outData_89(stage_10_per_out[89]),
    .outData_90(stage_10_per_out[90]),
    .outData_91(stage_10_per_out[91]),
    .outData_92(stage_10_per_out[92]),
    .outData_93(stage_10_per_out[93]),
    .outData_94(stage_10_per_out[94]),
    .outData_95(stage_10_per_out[95]),
    .outData_96(stage_10_per_out[96]),
    .outData_97(stage_10_per_out[97]),
    .outData_98(stage_10_per_out[98]),
    .outData_99(stage_10_per_out[99]),
    .outData_100(stage_10_per_out[100]),
    .outData_101(stage_10_per_out[101]),
    .outData_102(stage_10_per_out[102]),
    .outData_103(stage_10_per_out[103]),
    .outData_104(stage_10_per_out[104]),
    .outData_105(stage_10_per_out[105]),
    .outData_106(stage_10_per_out[106]),
    .outData_107(stage_10_per_out[107]),
    .outData_108(stage_10_per_out[108]),
    .outData_109(stage_10_per_out[109]),
    .outData_110(stage_10_per_out[110]),
    .outData_111(stage_10_per_out[111]),
    .outData_112(stage_10_per_out[112]),
    .outData_113(stage_10_per_out[113]),
    .outData_114(stage_10_per_out[114]),
    .outData_115(stage_10_per_out[115]),
    .outData_116(stage_10_per_out[116]),
    .outData_117(stage_10_per_out[117]),
    .outData_118(stage_10_per_out[118]),
    .outData_119(stage_10_per_out[119]),
    .outData_120(stage_10_per_out[120]),
    .outData_121(stage_10_per_out[121]),
    .outData_122(stage_10_per_out[122]),
    .outData_123(stage_10_per_out[123]),
    .outData_124(stage_10_per_out[124]),
    .outData_125(stage_10_per_out[125]),
    .outData_126(stage_10_per_out[126]),
    .outData_127(stage_10_per_out[127]),
    .in_start(in_start[8]),
    .out_start(out_start[8]),
    .clk(clk),
    .rst(rst)
  );

  // TODO(Tian): stage 9 32 butterfly units
  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_0 (
    .x_in(stage_10_per_out[0]),
    .y_in(stage_10_per_out[1]),
    .x_out(outData[0]),
    .y_out(outData[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_1 (
    .x_in(stage_10_per_out[2]),
    .y_in(stage_10_per_out[3]),
    .x_out(outData[2]),
    .y_out(outData[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_2 (
    .x_in(stage_10_per_out[4]),
    .y_in(stage_10_per_out[5]),
    .x_out(outData[4]),
    .y_out(outData[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_3 (
    .x_in(stage_10_per_out[6]),
    .y_in(stage_10_per_out[7]),
    .x_out(outData[6]),
    .y_out(outData[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_4 (
    .x_in(stage_10_per_out[8]),
    .y_in(stage_10_per_out[9]),
    .x_out(outData[8]),
    .y_out(outData[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_5 (
    .x_in(stage_10_per_out[10]),
    .y_in(stage_10_per_out[11]),
    .x_out(outData[10]),
    .y_out(outData[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_6 (
    .x_in(stage_10_per_out[12]),
    .y_in(stage_10_per_out[13]),
    .x_out(outData[12]),
    .y_out(outData[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_7 (
    .x_in(stage_10_per_out[14]),
    .y_in(stage_10_per_out[15]),
    .x_out(outData[14]),
    .y_out(outData[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_8 (
    .x_in(stage_10_per_out[16]),
    .y_in(stage_10_per_out[17]),
    .x_out(outData[16]),
    .y_out(outData[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_9 (
    .x_in(stage_10_per_out[18]),
    .y_in(stage_10_per_out[19]),
    .x_out(outData[18]),
    .y_out(outData[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_10 (
    .x_in(stage_10_per_out[20]),
    .y_in(stage_10_per_out[21]),
    .x_out(outData[20]),
    .y_out(outData[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_11 (
    .x_in(stage_10_per_out[22]),
    .y_in(stage_10_per_out[23]),
    .x_out(outData[22]),
    .y_out(outData[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_12 (
    .x_in(stage_10_per_out[24]),
    .y_in(stage_10_per_out[25]),
    .x_out(outData[24]),
    .y_out(outData[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_13 (
    .x_in(stage_10_per_out[26]),
    .y_in(stage_10_per_out[27]),
    .x_out(outData[26]),
    .y_out(outData[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_14 (
    .x_in(stage_10_per_out[28]),
    .y_in(stage_10_per_out[29]),
    .x_out(outData[28]),
    .y_out(outData[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_15 (
    .x_in(stage_10_per_out[30]),
    .y_in(stage_10_per_out[31]),
    .x_out(outData[30]),
    .y_out(outData[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_16 (
    .x_in(stage_10_per_out[32]),
    .y_in(stage_10_per_out[33]),
    .x_out(outData[32]),
    .y_out(outData[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_17 (
    .x_in(stage_10_per_out[34]),
    .y_in(stage_10_per_out[35]),
    .x_out(outData[34]),
    .y_out(outData[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_18 (
    .x_in(stage_10_per_out[36]),
    .y_in(stage_10_per_out[37]),
    .x_out(outData[36]),
    .y_out(outData[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_19 (
    .x_in(stage_10_per_out[38]),
    .y_in(stage_10_per_out[39]),
    .x_out(outData[38]),
    .y_out(outData[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_20 (
    .x_in(stage_10_per_out[40]),
    .y_in(stage_10_per_out[41]),
    .x_out(outData[40]),
    .y_out(outData[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_21 (
    .x_in(stage_10_per_out[42]),
    .y_in(stage_10_per_out[43]),
    .x_out(outData[42]),
    .y_out(outData[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_22 (
    .x_in(stage_10_per_out[44]),
    .y_in(stage_10_per_out[45]),
    .x_out(outData[44]),
    .y_out(outData[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_23 (
    .x_in(stage_10_per_out[46]),
    .y_in(stage_10_per_out[47]),
    .x_out(outData[46]),
    .y_out(outData[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_24 (
    .x_in(stage_10_per_out[48]),
    .y_in(stage_10_per_out[49]),
    .x_out(outData[48]),
    .y_out(outData[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_25 (
    .x_in(stage_10_per_out[50]),
    .y_in(stage_10_per_out[51]),
    .x_out(outData[50]),
    .y_out(outData[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_26 (
    .x_in(stage_10_per_out[52]),
    .y_in(stage_10_per_out[53]),
    .x_out(outData[52]),
    .y_out(outData[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_27 (
    .x_in(stage_10_per_out[54]),
    .y_in(stage_10_per_out[55]),
    .x_out(outData[54]),
    .y_out(outData[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_28 (
    .x_in(stage_10_per_out[56]),
    .y_in(stage_10_per_out[57]),
    .x_out(outData[56]),
    .y_out(outData[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_29 (
    .x_in(stage_10_per_out[58]),
    .y_in(stage_10_per_out[59]),
    .x_out(outData[58]),
    .y_out(outData[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_30 (
    .x_in(stage_10_per_out[60]),
    .y_in(stage_10_per_out[61]),
    .x_out(outData[60]),
    .y_out(outData[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_31 (
    .x_in(stage_10_per_out[62]),
    .y_in(stage_10_per_out[63]),
    .x_out(outData[62]),
    .y_out(outData[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_32 (
    .x_in(stage_10_per_out[64]),
    .y_in(stage_10_per_out[65]),
    .x_out(outData[64]),
    .y_out(outData[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_33 (
    .x_in(stage_10_per_out[66]),
    .y_in(stage_10_per_out[67]),
    .x_out(outData[66]),
    .y_out(outData[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_34 (
    .x_in(stage_10_per_out[68]),
    .y_in(stage_10_per_out[69]),
    .x_out(outData[68]),
    .y_out(outData[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_35 (
    .x_in(stage_10_per_out[70]),
    .y_in(stage_10_per_out[71]),
    .x_out(outData[70]),
    .y_out(outData[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_36 (
    .x_in(stage_10_per_out[72]),
    .y_in(stage_10_per_out[73]),
    .x_out(outData[72]),
    .y_out(outData[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_37 (
    .x_in(stage_10_per_out[74]),
    .y_in(stage_10_per_out[75]),
    .x_out(outData[74]),
    .y_out(outData[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_38 (
    .x_in(stage_10_per_out[76]),
    .y_in(stage_10_per_out[77]),
    .x_out(outData[76]),
    .y_out(outData[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_39 (
    .x_in(stage_10_per_out[78]),
    .y_in(stage_10_per_out[79]),
    .x_out(outData[78]),
    .y_out(outData[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_40 (
    .x_in(stage_10_per_out[80]),
    .y_in(stage_10_per_out[81]),
    .x_out(outData[80]),
    .y_out(outData[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_41 (
    .x_in(stage_10_per_out[82]),
    .y_in(stage_10_per_out[83]),
    .x_out(outData[82]),
    .y_out(outData[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_42 (
    .x_in(stage_10_per_out[84]),
    .y_in(stage_10_per_out[85]),
    .x_out(outData[84]),
    .y_out(outData[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_43 (
    .x_in(stage_10_per_out[86]),
    .y_in(stage_10_per_out[87]),
    .x_out(outData[86]),
    .y_out(outData[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_44 (
    .x_in(stage_10_per_out[88]),
    .y_in(stage_10_per_out[89]),
    .x_out(outData[88]),
    .y_out(outData[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_45 (
    .x_in(stage_10_per_out[90]),
    .y_in(stage_10_per_out[91]),
    .x_out(outData[90]),
    .y_out(outData[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_46 (
    .x_in(stage_10_per_out[92]),
    .y_in(stage_10_per_out[93]),
    .x_out(outData[92]),
    .y_out(outData[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_47 (
    .x_in(stage_10_per_out[94]),
    .y_in(stage_10_per_out[95]),
    .x_out(outData[94]),
    .y_out(outData[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_48 (
    .x_in(stage_10_per_out[96]),
    .y_in(stage_10_per_out[97]),
    .x_out(outData[96]),
    .y_out(outData[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_49 (
    .x_in(stage_10_per_out[98]),
    .y_in(stage_10_per_out[99]),
    .x_out(outData[98]),
    .y_out(outData[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_50 (
    .x_in(stage_10_per_out[100]),
    .y_in(stage_10_per_out[101]),
    .x_out(outData[100]),
    .y_out(outData[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_51 (
    .x_in(stage_10_per_out[102]),
    .y_in(stage_10_per_out[103]),
    .x_out(outData[102]),
    .y_out(outData[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_52 (
    .x_in(stage_10_per_out[104]),
    .y_in(stage_10_per_out[105]),
    .x_out(outData[104]),
    .y_out(outData[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_53 (
    .x_in(stage_10_per_out[106]),
    .y_in(stage_10_per_out[107]),
    .x_out(outData[106]),
    .y_out(outData[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_54 (
    .x_in(stage_10_per_out[108]),
    .y_in(stage_10_per_out[109]),
    .x_out(outData[108]),
    .y_out(outData[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_55 (
    .x_in(stage_10_per_out[110]),
    .y_in(stage_10_per_out[111]),
    .x_out(outData[110]),
    .y_out(outData[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_56 (
    .x_in(stage_10_per_out[112]),
    .y_in(stage_10_per_out[113]),
    .x_out(outData[112]),
    .y_out(outData[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_57 (
    .x_in(stage_10_per_out[114]),
    .y_in(stage_10_per_out[115]),
    .x_out(outData[114]),
    .y_out(outData[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_58 (
    .x_in(stage_10_per_out[116]),
    .y_in(stage_10_per_out[117]),
    .x_out(outData[116]),
    .y_out(outData[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_59 (
    .x_in(stage_10_per_out[118]),
    .y_in(stage_10_per_out[119]),
    .x_out(outData[118]),
    .y_out(outData[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_60 (
    .x_in(stage_10_per_out[120]),
    .y_in(stage_10_per_out[121]),
    .x_out(outData[120]),
    .y_out(outData[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_61 (
    .x_in(stage_10_per_out[122]),
    .y_in(stage_10_per_out[123]),
    .x_out(outData[122]),
    .y_out(outData[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_62 (
    .x_in(stage_10_per_out[124]),
    .y_in(stage_10_per_out[125]),
    .x_out(outData[124]),
    .y_out(outData[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[9]),
    .factors({75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761}))
  stage_11_butterfly_63 (
    .x_in(stage_10_per_out[126]),
    .y_in(stage_10_per_out[127]),
    .x_out(outData[126]),
    .y_out(outData[127]),
    .clk(clk),
    .rst(rst)
  );

endmodule
