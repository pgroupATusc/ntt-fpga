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

  input in_start[9:0];
  output logic out_start[9:0];

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

  logic [DATA_WIDTH_PER_INPUT-1:0] stage_9_per_in[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0] stage_9_per_out[INPUT_PER_CYCLE-1:0];

  parameter [7:0] START_CYCLE[11] = {0, 7, 14, 21, 28, 35, 42, 67, 93, 121, 153};

  // TODO(Tian): stage 0 32 butterfly units
  butterfly #(
    .start(START_CYCLE[0]),
    .factors({66687, 153619107, 189026714, 197498270, 54194127, 218565763, 66993197, 44349942,
              209875154, 243595082, 188637512, 80900544, 74661667, 117448591, 67400723, 190155959}))
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
    .factors({69710552, 29541109, 176646986, 4184358, 216344829, 218464636, 107013281, 82066131,
              211324969, 262853884, 241404981, 96861137, 163120146, 180135303, 47960804, 185458452}))
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
    .factors({262755833, 72606471, 24152300, 230614882, 83248807, 56718282, 80152118, 249749550,
              112928859, 11377467, 9977836, 256522921, 243952581, 13005428, 127264350, 97371131}))
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
    .factors({256317058, 196552678, 197359850, 116252651, 227177249, 254559948, 267404879, 230038199,
              183986337, 77239454, 136554761, 234127283, 7407334, 246139244, 48499686, 65241583}))
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
    .factors({36785021, 241027889, 135965343, 67459976, 53251080, 37830528, 250343614, 92664685,
              259190760, 178626802, 186026798, 159848863, 118263349, 188624074, 133533317, 96783518}))
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
    .factors({70884448, 62553766, 17337072, 221333762, 125436993, 34758721, 119165597, 57880935,
              185327331, 26950622, 116219557, 86425411, 264754058, 189299702, 112174110, 75689991}))
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
    .factors({144486207, 62424622, 30978406, 108814743, 240329350, 17095567, 125990181, 195258296,
              213018760, 224076531, 241147279, 163686509, 21814275, 233629950, 61366355, 207436891}))
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
    .factors({4869479, 240913336, 7525756, 45529198, 117082039, 5742112, 158362238, 183015243,
              98446051, 202037642, 219647998, 35399020, 70993112, 89363633, 135336752, 102019874}))
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
    .factors({181036575, 118216948, 153827860, 95356163, 104721465, 195777196, 192617727, 185375251,
              171269635, 236173805, 86222094, 86412198, 67895486, 220487343, 126869459, 115863951}))
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
    .factors({164585197, 162343477, 112847505, 239438610, 255042189, 167135704, 126420356, 92935276,
              242966976, 113735821, 209335538, 40931981, 254651521, 126673466, 257856584, 218254116}))
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
    .factors({124689641, 16967674, 63479516, 246348641, 151222684, 15203085, 158406994, 231508432,
              145325214, 246040827, 128639456, 151896708, 43308742, 186490797, 227605745, 100306740}))
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
    .factors({236609676, 208367077, 192156570, 111861272, 46680870, 91771920, 196972136, 81641436,
              224193580, 114906207, 66698835, 15304900, 79432680, 46133075, 185850221, 267892175}))
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
    .factors({175181826, 129053745, 89839882, 180106398, 94844905, 76258087, 129973973, 13646129,
              111161696, 143397255, 218411001, 127510598, 214331009, 181264550, 239446376, 100616259}))
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
    .factors({53666796, 250734390, 195126393, 154135831, 201750613, 226796218, 215876710, 242906033,
              51299486, 186023395, 37292607, 127868408, 159083887, 41512397, 35769351, 254862428}))
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
    .factors({134572374, 259641163, 124903743, 110349263, 260055946, 39159482, 188610091, 16321430,
              196727396, 259902883, 52172809, 37689469, 263768524, 153805373, 16680201, 104486975}))
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
    .factors({251547338, 9599856, 145040924, 75051406, 245518247, 126638229, 13677670, 45577615,
              259597052, 140652682, 22419281, 209499403, 202709135, 221869909, 13905102, 236043136}))
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
    .factors({207692352, 45213202, 184120139, 20654843, 241662912, 29126603, 242981970, 215932651,
              123744505, 204305824, 213462715, 13136617, 22903087, 34884345, 110850189, 7804022}))
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
    .factors({255875272, 199654780, 222469354, 164354184, 224632066, 10057303, 224618046, 174707320,
              42559975, 135644103, 248367053, 52859373, 114169496, 98181554, 29380441, 2705617}))
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
    .factors({154212375, 254000355, 43817935, 168908433, 255369977, 127930513, 18101390, 144813234,
              142863934, 125480758, 177181340, 153907308, 124518160, 107122996, 90748831, 210266721}))
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
    .factors({5651134, 65092548, 205553550, 219432305, 52761187, 268253695, 145663803, 193252183,
              153035867, 209091203, 105651679, 130965208, 46629005, 219164507, 99140149, 37489037}))
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
    .factors({96644160, 95745785, 173093264, 24122396, 130184658, 176845896, 75240990, 175360485,
              13214022, 158913333, 3731063, 20163279, 124384681, 8903594, 224762304, 101221270}))
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
    .factors({208516738, 38429557, 107466416, 76096071, 155494097, 24169593, 132749847, 243480557,
              200835165, 218922070, 241656403, 199114532, 75455626, 56848151, 92098334, 238700391}))
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
    .factors({141475285, 114175494, 41031357, 76495986, 204045920, 184775632, 216035935, 187345691,
              182322028, 172413463, 81774581, 64059298, 229077055, 116261862, 114456140, 12549924}))
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
    .factors({250979164, 219155874, 127603059, 150750886, 8437385, 210367757, 184194991, 73886338,
              222855093, 117740425, 159837268, 1381761, 56672741, 230462114, 196403691, 161018204}))
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
    .factors({149046252, 197016099, 219408463, 88694916, 152028008, 91129770, 233855133, 89556414,
              172630653, 64197737, 236960516, 194834330, 50484120, 77305748, 60951044, 185120175}))
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
    .factors({82259521, 208392312, 194382796, 226909804, 104225870, 162889363, 222836343, 100770703,
              253791818, 114289273, 206932975, 246263559, 50021352, 74643322, 247062782, 127281316}))
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
    .factors({89494679, 75161941, 209076586, 52952054, 219476260, 217984510, 263485445, 184266218,
              124256170, 119485143, 214979600, 218479673, 125264465, 77506253, 122774092, 220111512}))
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
    .factors({108936038, 12030631, 139714595, 232215778, 134032627, 5933624, 60114085, 131659808,
              41504705, 1996702, 203299319, 185097589, 54250256, 70728737, 95857789, 44186331}))
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
    .factors({9453674, 71023991, 234963902, 7289546, 232700332, 76831465, 136763023, 170218646,
              184394225, 189966412, 25932042, 177566022, 114664154, 69161829, 14128368, 126629575}))
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
    .factors({149565630, 32353046, 223749061, 175735543, 179997990, 176150397, 246670007, 130341794,
              168090046, 36426289, 33343400, 190924029, 83665434, 71466452, 44753328, 255807486}))
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
    .factors({20490089, 54291647, 240846316, 106939991, 62605527, 194584338, 189935724, 239135625,
              197999089, 127312784, 222818810, 35608242, 66352780, 203207502, 178750844, 259334239}))
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
    .factors({198469359, 107222748, 94741987, 92263376, 243959994, 70296940, 97932506, 144316291,
              244981517, 75414331, 103192680, 241593066, 230254857, 263850390, 14195884, 5071752}))
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
    .factors({58085086, 41046131, 70631961, 125081754, 186938437, 176985668, 149817301, 106663692,
              265093046, 40001367, 130849588, 41376169, 9521161, 216779302, 241368847, 121954140}))
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
    .factors({157049837, 109238580, 66294444, 261365258, 157159811, 109752985, 83173794, 127177690,
              73580010, 104968162, 127320617, 111883252, 164222678, 222243486, 11479903, 14425613}))
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
    .factors({25367770, 131386739, 113066699, 212990958, 224274217, 64307891, 6554463, 177333030,
              103520242, 212660495, 248813222, 42903438, 81165688, 122372515, 194452250, 250007587}))
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
    .factors({176574100, 4087463, 144888817, 251186267, 37869546, 80396852, 243900215, 186920055,
              143442800, 9418848, 30998042, 28513237, 185511309, 207114911, 132216843, 13394971}))
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
    .factors({116176624, 2568552, 220939348, 156421542, 139206238, 85925921, 64508043, 16229147,
              5284602, 34279912, 229577517, 132170867, 183471966, 35688570, 204610446, 129161289}))
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
    .factors({20380320, 246330337, 259358426, 79007221, 165481068, 76840577, 143713813, 159288788,
              121708429, 31628247, 64402402, 210629837, 160223263, 38129962, 148301509, 181758089}))
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
    .factors({33861678, 171258656, 191233099, 200295213, 119553807, 119820987, 74620568, 211474022,
              217483488, 124175107, 43396787, 267034870, 119858575, 65363597, 128923754, 258398710}))
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
    .factors({226423252, 161193348, 183816509, 227631635, 85943438, 55952036, 114499544, 224620084,
              90415400, 80852279, 85610695, 16387901, 56349189, 72373951, 211284483, 212643172}))
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
    .factors({15406607, 28990836, 152434516, 190584784, 207179347, 62694765, 199997052, 141917139,
              66106013, 48487396, 64123411, 29149935, 111028502, 129596600, 74346844, 9083394}))
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
    .factors({84197948, 24580196, 104494180, 195751196, 27101256, 178774268, 60187882, 201970932,
              100723721, 128081279, 55000619, 3906588, 6839312, 35544064, 240580313, 28589493}))
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
    .factors({12048336, 165964934, 264758616, 12994463, 126817458, 266062977, 118812967, 209775390,
              115675578, 131952477, 174110644, 248430418, 68558047, 26451456, 81924749, 187430880}))
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
    .factors({155632772, 237702991, 169217935, 141932586, 4080689, 64186729, 24281843, 120623833,
              181657279, 157158700, 246446391, 41918325, 35256934, 228992312, 34535827, 94113816}))
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
    .factors({25921170, 59004276, 119598304, 75588758, 232035425, 194631063, 182519003, 215427609,
              182035415, 175887545, 242432529, 210485515, 124878920, 103427147, 6261383, 213513532}))
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
    .factors({201841490, 21867329, 18807047, 96098889, 56301526, 75267274, 86146205, 106441080,
              183906538, 149121135, 66456987, 95362545, 124980045, 216420108, 177659362, 175699854}))
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
    .factors({54591848, 266184237, 243356346, 217947353, 260941520, 198451374, 143647295, 85861280,
              4628244, 176734838, 88659311, 246253529, 44002169, 164064761, 72006316, 161494327}))
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
    .factors({187954050, 253615348, 31515852, 158367942, 147907047, 197375798, 208399648, 102496219,
              139662643, 88068083, 154457559, 119681087, 11713205, 187446019, 61031492, 81363847}))
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
    .factors({171518128, 231691713, 79909455, 22483780, 53018448, 166849602, 134488788, 230537579,
              13110486, 124635721, 188476710, 134518349, 79252444, 94872102, 200589425, 138643341}))
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
    .factors({60493834, 264692686, 156023579, 264722248, 42984958, 19948338, 78067214, 111544693,
              58402192, 29014999, 153843002, 212200386, 261854403, 251666562, 205236983, 214088558}))
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
    .factors({14131216, 248921617, 181198907, 9304145, 53103748, 267667077, 152808181, 120419308,
              121172029, 205274966, 1429580, 198035948, 258225039, 78535147, 48447796, 25148713}))
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
    .factors({235215540, 246972075, 254205318, 209423491, 77043356, 243436973, 207221115, 178131021,
              141410653, 202016934, 219873665, 263341785, 119697484, 200991325, 169530517, 233412603}))
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
    .factors({238066757, 94477870, 20028125, 145706676, 182490652, 200245646, 78372181, 230913482,
              72907110, 144340508, 193915015, 143364478, 218119669, 162610901, 176649880, 91136142}))
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
    .factors({156384032, 18485653, 74839506, 101664410, 83440545, 214277734, 15448747, 232016200,
              150529015, 176876579, 121678256, 144387747, 237212534, 189248627, 234435452, 35697312}))
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
    .factors({122417419, 187658742, 82105625, 78726832, 41015351, 215044990, 100034642, 123869779,
              172927150, 226568978, 126650083, 200458300, 267701123, 50041017, 28569588, 113970703}))
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
    .factors({101235253, 75430495, 7373784, 106279827, 241484731, 50956256, 88850354, 202657965,
              20476611, 210930243, 250769297, 104273059, 15252454, 260125445, 179888950, 228180092}))
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
    .factors({249303130, 127667482, 90833651, 154780521, 210835738, 54694187, 159375180, 153057061,
              229787934, 174554842, 144089543, 182882105, 143928593, 221852517, 232958416, 218263368}))
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
    .factors({196076822, 205950205, 58882681, 57420105, 265484036, 101451720, 146642358, 94729012,
              11727916, 122009767, 218155940, 207289252, 22696094, 33986901, 3059556, 202839194}))
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
    .factors({172777377, 173116375, 33161823, 79746145, 188253439, 49412866, 263389379, 116815899,
              236561162, 59945410, 214652925, 242718809, 111988251, 197145719, 130025327, 80477336}))
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
    .factors({11247416, 148728622, 242696977, 176645554, 253775510, 204816575, 101380813, 40136402,
              14923017, 72665107, 140980229, 63912782, 172134458, 37207751, 202868018, 172355039}))
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
    .factors({122635188, 7487276, 99687432, 195650024, 73305984, 122925753, 45684920, 19111856,
              34093582, 6456449, 207587513, 148535761, 207578860, 157107117, 63900610, 248049881}))
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
    .factors({229646063, 94417879, 151510274, 19569387, 268223107, 146917464, 220989018, 245173438,
              133543242, 32769539, 246049881, 195750117, 79351768, 132980811, 15241225, 100791881}))
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
    .factors({172426762, 83798709, 252329804, 39161232, 121709085, 111058309, 177655074, 121236629,
              85557225, 233358957, 65939487, 217412044, 50385541, 38583127, 178548754, 85449542}))
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
    .factors({200880844, 106713399, 89730483, 6208689, 132063071, 91839141, 117068649, 258128862,
              254780782, 209997049, 213843220, 90431622, 92468150, 231864746, 180859208, 86422302}))
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
    .factors({153237233, 137060289, 180764097, 138513718, 20917227, 73099736, 44888494, 121414397,
              174391063, 43977927, 56257750, 2486257, 21253452, 259302720, 128052734, 205242220}))
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
    .factors({153237233, 137060289, 180764097, 138513718, 20917227, 73099736, 44888494, 121414397,
              174391063, 43977927, 56257750, 2486257, 21253452, 259302720, 128052734, 205242220}))
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
    .factors({83809662, 46312994, 172715743, 160048836, 228243008, 119878395, 205934027, 112070980,
              89028484, 134161265, 21649526, 112825183, 170100736, 209643171, 144648965, 72369588}))
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
    .factors({83809662, 46312994, 172715743, 160048836, 228243008, 119878395, 205934027, 112070980,
              89028484, 134161265, 21649526, 112825183, 170100736, 209643171, 144648965, 72369588}))
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
    .factors({257723260, 164865927, 245986816, 46282885, 156534179, 226025718, 76313029, 249947221,
              113006603, 187381670, 234775081, 217359458, 248946430, 191242693, 10943590, 87202745}))
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
    .factors({257723260, 164865927, 245986816, 46282885, 156534179, 226025718, 76313029, 249947221,
              113006603, 187381670, 234775081, 217359458, 248946430, 191242693, 10943590, 87202745}))
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
    .factors({267008435, 198352904, 53126225, 185175266, 207021189, 78273516, 138629310, 13228372,
              18793692, 45457492, 99899421, 198957507, 53025186, 146205579, 264322432, 159987098}))
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
    .factors({267008435, 198352904, 53126225, 185175266, 207021189, 78273516, 138629310, 13228372,
              18793692, 45457492, 99899421, 198957507, 53025186, 146205579, 264322432, 159987098}))
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
    .factors({181617487, 167645260, 215525211, 69017626, 243047656, 5267255, 18433789, 12912005,
              83977288, 62456195, 127163336, 175710456, 176911171, 146399832, 44047649, 205604517}))
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
    .factors({181617487, 167645260, 215525211, 69017626, 243047656, 5267255, 18433789, 12912005,
              83977288, 62456195, 127163336, 175710456, 176911171, 146399832, 44047649, 205604517}))
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
    .factors({3395282, 77119896, 249311139, 108319109, 19700796, 199055975, 7301415, 116257755,
              194684542, 64830196, 43819650, 12286825, 94436408, 84798700, 209708523, 141562255}))
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
    .factors({3395282, 77119896, 249311139, 108319109, 19700796, 199055975, 7301415, 116257755,
              194684542, 64830196, 43819650, 12286825, 94436408, 84798700, 209708523, 141562255}))
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
    .factors({66412546, 69205492, 224922683, 244004517, 213678985, 91397014, 74472522, 47531240,
              60051251, 219484262, 16652121, 56132215, 50083600, 106743034, 149788353, 265496406}))
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
    .factors({66412546, 69205492, 224922683, 244004517, 213678985, 91397014, 74472522, 47531240,
              60051251, 219484262, 16652121, 56132215, 50083600, 106743034, 149788353, 265496406}))
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
    .factors({3341663, 190540901, 90687088, 211982342, 18338102, 107024087, 136710753, 263001722,
              163823140, 2017030, 228715598, 126413069, 77804235, 238468357, 78612624, 172401093}))
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
    .factors({3341663, 190540901, 90687088, 211982342, 18338102, 107024087, 136710753, 263001722,
              163823140, 2017030, 228715598, 126413069, 77804235, 238468357, 78612624, 172401093}))
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
    .factors({165180840, 100343421, 167181901, 243339369, 146639516, 84700854, 259533807, 64771890,
              38252193, 217210388, 133952844, 259164217, 108831626, 23442787, 195692414, 231354349}))
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
    .factors({165180840, 100343421, 167181901, 243339369, 146639516, 84700854, 259533807, 64771890,
              38252193, 217210388, 133952844, 259164217, 108831626, 23442787, 195692414, 231354349}))
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
    .factors({168373202, 73071114, 156837559, 244423105, 100611174, 178382895, 237395333, 10310370,
              54714468, 98410858, 107503597, 122609533, 21582278, 8748458, 108164959, 154317057}))
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
    .factors({168373202, 73071114, 156837559, 244423105, 100611174, 178382895, 237395333, 10310370,
              54714468, 98410858, 107503597, 122609533, 21582278, 8748458, 108164959, 154317057}))
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
    .factors({4457103, 236209279, 75689102, 128011618, 259719559, 169092523, 255478273, 263649093,
              50606491, 202871094, 214937778, 201160126, 110378476, 195152646, 86359417, 240930884}))
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
    .factors({4457103, 236209279, 75689102, 128011618, 259719559, 169092523, 255478273, 263649093,
              50606491, 202871094, 214937778, 201160126, 110378476, 195152646, 86359417, 240930884}))
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
    .factors({248328138, 12711531, 254234203, 161607031, 218195682, 217993137, 82321748, 187988754,
              184464011, 1807449, 86350556, 188526794, 115050087, 207530748, 1855205, 189909138}))
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
    .factors({248328138, 12711531, 254234203, 161607031, 218195682, 217993137, 82321748, 187988754,
              184464011, 1807449, 86350556, 188526794, 115050087, 207530748, 1855205, 189909138}))
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
    .factors({207769332, 34402629, 120466187, 246741831, 62094530, 234786570, 127918992, 263648524,
              248251528, 73481957, 81414740, 187208958, 30998914, 263725948, 245372433, 110720332}))
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
    .factors({207769332, 34402629, 120466187, 246741831, 62094530, 234786570, 127918992, 263648524,
              248251528, 73481957, 81414740, 187208958, 30998914, 263725948, 245372433, 110720332}))
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
    .factors({164728317, 110055875, 204707946, 212788230, 209780385, 92902456, 19817676, 141267184,
              222249559, 84669572, 104121890, 26068775, 2487567, 105443909, 134561032, 120261431}))
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
    .factors({164728317, 110055875, 204707946, 212788230, 209780385, 92902456, 19817676, 141267184,
              222249559, 84669572, 104121890, 26068775, 2487567, 105443909, 134561032, 120261431}))
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
    .factors({206116619, 128589211, 268043824, 236528116, 58671364, 107152911, 158067861, 145317914,
              18205961, 33096679, 189044804, 863665, 148051010, 211201491, 187172755, 158914825}))
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
    .factors({206116619, 128589211, 268043824, 236528116, 58671364, 107152911, 158067861, 145317914,
              18205961, 33096679, 189044804, 863665, 148051010, 211201491, 187172755, 158914825}))
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
    .factors({207047180, 142941966, 123335487, 174290656, 23776027, 92770973, 122455193, 189816962,
              163197321, 77536776, 58903295, 197065781, 201787732, 10967191, 145056180, 51838504}))
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
    .factors({207047180, 142941966, 123335487, 174290656, 23776027, 92770973, 122455193, 189816962,
              163197321, 77536776, 58903295, 197065781, 201787732, 10967191, 145056180, 51838504}))
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
    .factors({76624935, 103368916, 265109260, 232173019, 227453822, 168674209, 135080569, 261458154,
              160856494, 135902522, 172655984, 82483914, 99543252, 267785378, 244216061, 20236367}))
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
    .factors({76624935, 103368916, 265109260, 232173019, 227453822, 168674209, 135080569, 261458154,
              160856494, 135902522, 172655984, 82483914, 99543252, 267785378, 244216061, 20236367}))
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
    .factors({57946842, 15655486, 9793208, 66337349, 56207397, 42575603, 59894768, 159148996,
              166334964, 78767945, 34932582, 253487730, 36492987, 228572460, 232038388, 171841734}))
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
    .factors({57946842, 15655486, 9793208, 66337349, 56207397, 42575603, 59894768, 159148996,
              166334964, 78767945, 34932582, 253487730, 36492987, 228572460, 232038388, 171841734}))
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
    .factors({25278905, 121608761, 85740049, 82779345, 74931497, 255818084, 242717180, 262630184,
              175949223, 188535281, 90701762, 94178347, 267860193, 44896056, 136898494, 237616434}))
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
    .factors({25278905, 121608761, 85740049, 82779345, 74931497, 255818084, 242717180, 262630184,
              175949223, 188535281, 90701762, 94178347, 267860193, 44896056, 136898494, 237616434}))
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
    .factors({65803974, 133573372, 211646222, 233083676, 219133933, 67241659, 143811089, 122025398,
              155613159, 116513948, 31964447, 116527240, 232740066, 50523873, 16351380, 165584204}))
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
    .factors({65803974, 133573372, 211646222, 233083676, 219133933, 67241659, 143811089, 122025398,
              155613159, 116513948, 31964447, 116527240, 232740066, 50523873, 16351380, 165584204}))
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
    .factors({5445105, 266777383, 210373784, 193451294, 211824237, 206844979, 40915578, 139742686,
              125713617, 251672258, 74458128, 230865684, 151857114, 169792793, 45355620, 129677075}))
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
    .factors({5445105, 266777383, 210373784, 193451294, 211824237, 206844979, 40915578, 139742686,
              125713617, 251672258, 74458128, 230865684, 151857114, 169792793, 45355620, 129677075}))
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
    .factors({36620312, 195181845, 87492030, 129694458, 62513408, 215085706, 11850588, 133565368,
              157839041, 17682401, 236272786, 182803613, 238832783, 226834391, 70944317, 133273987}))
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
    .factors({36620312, 195181845, 87492030, 129694458, 62513408, 215085706, 11850588, 133565368,
              157839041, 17682401, 236272786, 182803613, 238832783, 226834391, 70944317, 133273987}))
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
    .factors({17758040, 105793954, 98139687, 40741603, 226759664, 94686133, 112360014, 203850982,
              50162577, 232847226, 196018390, 90149574, 154298223, 139044757, 97163404, 77783793}))
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
    .factors({17758040, 105793954, 98139687, 40741603, 226759664, 94686133, 112360014, 203850982,
              50162577, 232847226, 196018390, 90149574, 154298223, 139044757, 97163404, 77783793}))
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
    .factors({157386503, 229954056, 226981541, 175990762, 260110386, 81838336, 255463943, 101579460,
              160539079, 86776671, 25360705, 19904170, 120080647, 92441360, 254842567, 79230237}))
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
    .factors({157386503, 229954056, 226981541, 175990762, 260110386, 81838336, 255463943, 101579460,
              160539079, 86776671, 25360705, 19904170, 120080647, 92441360, 254842567, 79230237}))
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
    .factors({99012968, 29594281, 94741537, 262368251, 164079161, 46197346, 193174373, 73072346,
              81263879, 102698816, 202480866, 244022079, 121145061, 267017218, 212728405, 3021514}))
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
    .factors({99012968, 29594281, 94741537, 262368251, 164079161, 46197346, 193174373, 73072346,
              81263879, 102698816, 202480866, 244022079, 121145061, 267017218, 212728405, 3021514}))
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
    .factors({159491687, 255737752, 58491201, 102243739, 1592710, 189033696, 164473684, 72509307,
              266378632, 238590283, 62027985, 173513151, 107940029, 7376627, 113049121, 34052825}))
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
    .factors({159491687, 255737752, 58491201, 102243739, 1592710, 189033696, 164473684, 72509307,
              266378632, 238590283, 62027985, 173513151, 107940029, 7376627, 113049121, 34052825}))
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
    .factors({121355275, 79121706, 247714871, 142807968, 67784869, 94341361, 2204580, 12817079,
              122969043, 248922055, 207877484, 149904904, 70033082, 104557844, 39337018, 128159746}))
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
    .factors({121355275, 79121706, 247714871, 142807968, 67784869, 94341361, 2204580, 12817079,
              122969043, 248922055, 207877484, 149904904, 70033082, 104557844, 39337018, 128159746}))
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
    .factors({112174557, 230871518, 128995628, 118444917, 148649408, 148479452, 24036023, 132747224,
              173577844, 120217110, 118320134, 184177651, 186476418, 7226699, 7280660, 123018041}))
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
    .factors({112174557, 230871518, 128995628, 118444917, 148649408, 148479452, 24036023, 132747224,
              173577844, 120217110, 118320134, 184177651, 186476418, 7226699, 7280660, 123018041}))
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
    .factors({36213609, 136179523, 184522009, 135921552, 259895089, 64464693, 100027171, 241071152,
              133098101, 198043993, 209744644, 190453366, 32319537, 54916848, 128297265, 23586243}))
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
    .factors({36213609, 136179523, 184522009, 135921552, 259895089, 64464693, 100027171, 241071152,
              133098101, 198043993, 209744644, 190453366, 32319537, 54916848, 128297265, 23586243}))
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
    .factors({115053845, 145831337, 101783683, 218380292, 54393228, 174856430, 98445813, 209154967,
              144502563, 139101859, 121712648, 104215821, 216819035, 97171493, 138215130, 248732744}))
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
    .factors({115053845, 145831337, 101783683, 218380292, 54393228, 174856430, 98445813, 209154967,
              144502563, 139101859, 121712648, 104215821, 216819035, 97171493, 138215130, 248732744}))
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
    .factors({151297332, 45842328, 236829199, 17642100, 183613005, 55222727, 113269084, 37377133,
              212287973, 102230592, 23328014, 209112367, 256834872, 93757293, 159978713, 263207998}))
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
    .factors({151297332, 45842328, 236829199, 17642100, 183613005, 55222727, 113269084, 37377133,
              212287973, 102230592, 23328014, 209112367, 256834872, 93757293, 159978713, 263207998}))
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
    .factors({126749676, 187867192, 183590673, 31243956, 94206887, 12591284, 118946466, 212425161,
              107138937, 62688241, 6257752, 6828726, 43000087, 75993973, 6760936, 55947412}))
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
    .factors({126749676, 187867192, 183590673, 31243956, 94206887, 12591284, 118946466, 212425161,
              107138937, 62688241, 6257752, 6828726, 43000087, 75993973, 6760936, 55947412}))
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
    .factors({184644727, 43104106, 196522490, 218147185, 193915204, 206705681, 242516310, 165872957,
              98085790, 42355602, 186863562, 109479656, 242425786, 82155735, 141424302, 92160417}))
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
    .factors({184644727, 43104106, 196522490, 218147185, 193915204, 206705681, 242516310, 165872957,
              98085790, 42355602, 186863562, 109479656, 242425786, 82155735, 141424302, 92160417}))
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
    .factors({184644727, 43104106, 196522490, 218147185, 193915204, 206705681, 242516310, 165872957,
              98085790, 42355602, 186863562, 109479656, 242425786, 82155735, 141424302, 92160417}))
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
    .factors({184644727, 43104106, 196522490, 218147185, 193915204, 206705681, 242516310, 165872957,
              98085790, 42355602, 186863562, 109479656, 242425786, 82155735, 141424302, 92160417}))
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
    .factors({255286072, 185138250, 222861227, 82684352, 87202272, 21739535, 119169851, 244477824,
              135886841, 135618975, 210795202, 82934386, 251384491, 262464837, 206252403, 129576773}))
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
    .factors({255286072, 185138250, 222861227, 82684352, 87202272, 21739535, 119169851, 244477824,
              135886841, 135618975, 210795202, 82934386, 251384491, 262464837, 206252403, 129576773}))
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
    .factors({255286072, 185138250, 222861227, 82684352, 87202272, 21739535, 119169851, 244477824,
              135886841, 135618975, 210795202, 82934386, 251384491, 262464837, 206252403, 129576773}))
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
    .factors({255286072, 185138250, 222861227, 82684352, 87202272, 21739535, 119169851, 244477824,
              135886841, 135618975, 210795202, 82934386, 251384491, 262464837, 206252403, 129576773}))
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
    .factors({158466952, 34971158, 174900371, 249146534, 47375162, 161171966, 218694662, 158727274,
              102915173, 169508713, 100229847, 63079505, 40158424, 77389872, 9842125, 207821787}))
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
    .factors({158466952, 34971158, 174900371, 249146534, 47375162, 161171966, 218694662, 158727274,
              102915173, 169508713, 100229847, 63079505, 40158424, 77389872, 9842125, 207821787}))
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
    .factors({158466952, 34971158, 174900371, 249146534, 47375162, 161171966, 218694662, 158727274,
              102915173, 169508713, 100229847, 63079505, 40158424, 77389872, 9842125, 207821787}))
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
    .factors({158466952, 34971158, 174900371, 249146534, 47375162, 161171966, 218694662, 158727274,
              102915173, 169508713, 100229847, 63079505, 40158424, 77389872, 9842125, 207821787}))
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
    .factors({160807241, 199876762, 260909397, 1562592, 43575145, 237438985, 129101436, 1613379,
              99187435, 77981460, 181295312, 56094099, 20857483, 114486793, 61345534, 151095818}))
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
    .factors({160807241, 199876762, 260909397, 1562592, 43575145, 237438985, 129101436, 1613379,
              99187435, 77981460, 181295312, 56094099, 20857483, 114486793, 61345534, 151095818}))
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
    .factors({160807241, 199876762, 260909397, 1562592, 43575145, 237438985, 129101436, 1613379,
              99187435, 77981460, 181295312, 56094099, 20857483, 114486793, 61345534, 151095818}))
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
    .factors({160807241, 199876762, 260909397, 1562592, 43575145, 237438985, 129101436, 1613379,
              99187435, 77981460, 181295312, 56094099, 20857483, 114486793, 61345534, 151095818}))
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
    .factors({21080194, 145034471, 44547301, 166955734, 218231468, 61997323, 49504466, 11500489,
              169480001, 34481514, 136992892, 205961920, 187864761, 95282463, 5292226, 136878682}))
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
    .factors({21080194, 145034471, 44547301, 166955734, 218231468, 61997323, 49504466, 11500489,
              169480001, 34481514, 136992892, 205961920, 187864761, 95282463, 5292226, 136878682}))
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
    .factors({21080194, 145034471, 44547301, 166955734, 218231468, 61997323, 49504466, 11500489,
              169480001, 34481514, 136992892, 205961920, 187864761, 95282463, 5292226, 136878682}))
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
    .factors({21080194, 145034471, 44547301, 166955734, 218231468, 61997323, 49504466, 11500489,
              169480001, 34481514, 136992892, 205961920, 187864761, 95282463, 5292226, 136878682}))
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
    .factors({220490426, 93740850, 58483920, 219898221, 251138298, 200749611, 73698550, 242025902,
              78649100, 263530653, 79136411, 193296437, 207329882, 212214167, 58644800, 209658551}))
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
    .factors({220490426, 93740850, 58483920, 219898221, 251138298, 200749611, 73698550, 242025902,
              78649100, 263530653, 79136411, 193296437, 207329882, 212214167, 58644800, 209658551}))
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
    .factors({220490426, 93740850, 58483920, 219898221, 251138298, 200749611, 73698550, 242025902,
              78649100, 263530653, 79136411, 193296437, 207329882, 212214167, 58644800, 209658551}))
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
    .factors({220490426, 93740850, 58483920, 219898221, 251138298, 200749611, 73698550, 242025902,
              78649100, 263530653, 79136411, 193296437, 207329882, 212214167, 58644800, 209658551}))
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
    .factors({225389748, 9810331, 74093574, 137346680, 154421517, 232451599, 43078133, 247253507,
              126188511, 24688427, 168676526, 44301230, 84058929, 10003248, 68267735, 188517169}))
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
    .factors({225389748, 9810331, 74093574, 137346680, 154421517, 232451599, 43078133, 247253507,
              126188511, 24688427, 168676526, 44301230, 84058929, 10003248, 68267735, 188517169}))
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
    .factors({225389748, 9810331, 74093574, 137346680, 154421517, 232451599, 43078133, 247253507,
              126188511, 24688427, 168676526, 44301230, 84058929, 10003248, 68267735, 188517169}))
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
    .factors({225389748, 9810331, 74093574, 137346680, 154421517, 232451599, 43078133, 247253507,
              126188511, 24688427, 168676526, 44301230, 84058929, 10003248, 68267735, 188517169}))
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
    .factors({206795535, 16471674, 64764693, 57599709, 40718170, 56943278, 244216783, 232445568,
              35754446, 219738759, 87088032, 117221766, 72621624, 94612904, 57635675, 192832423}))
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
    .factors({206795535, 16471674, 64764693, 57599709, 40718170, 56943278, 244216783, 232445568,
              35754446, 219738759, 87088032, 117221766, 72621624, 94612904, 57635675, 192832423}))
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
    .factors({206795535, 16471674, 64764693, 57599709, 40718170, 56943278, 244216783, 232445568,
              35754446, 219738759, 87088032, 117221766, 72621624, 94612904, 57635675, 192832423}))
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
    .factors({206795535, 16471674, 64764693, 57599709, 40718170, 56943278, 244216783, 232445568,
              35754446, 219738759, 87088032, 117221766, 72621624, 94612904, 57635675, 192832423}))
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
    .factors({171051327, 224225395, 167366585, 213835479, 165350229, 117507527, 158168844, 261795000,
              67225153, 28242170, 259958064, 182702557, 131304314, 55609416, 118377542, 56246211}))
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
    .factors({171051327, 224225395, 167366585, 213835479, 165350229, 117507527, 158168844, 261795000,
              67225153, 28242170, 259958064, 182702557, 131304314, 55609416, 118377542, 56246211}))
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
    .factors({171051327, 224225395, 167366585, 213835479, 165350229, 117507527, 158168844, 261795000,
              67225153, 28242170, 259958064, 182702557, 131304314, 55609416, 118377542, 56246211}))
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
    .factors({171051327, 224225395, 167366585, 213835479, 165350229, 117507527, 158168844, 261795000,
              67225153, 28242170, 259958064, 182702557, 131304314, 55609416, 118377542, 56246211}))
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
    .factors({173118058, 134269022, 200399539, 69584498, 29987725, 171362072, 215146927, 26067051,
              160841949, 157966005, 14568946, 100123291, 40550456, 217383280, 199810586, 32087335}))
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
    .factors({173118058, 134269022, 200399539, 69584498, 29987725, 171362072, 215146927, 26067051,
              160841949, 157966005, 14568946, 100123291, 40550456, 217383280, 199810586, 32087335}))
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
    .factors({173118058, 134269022, 200399539, 69584498, 29987725, 171362072, 215146927, 26067051,
              160841949, 157966005, 14568946, 100123291, 40550456, 217383280, 199810586, 32087335}))
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
    .factors({173118058, 134269022, 200399539, 69584498, 29987725, 171362072, 215146927, 26067051,
              160841949, 157966005, 14568946, 100123291, 40550456, 217383280, 199810586, 32087335}))
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
    .factors({196328787, 81527994, 32260862, 233514072, 124400051, 202776751, 201863951, 209583375,
              134877507, 23405380, 160254284, 244763177, 181468172, 219312182, 67321994, 262540431}))
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
    .factors({196328787, 81527994, 32260862, 233514072, 124400051, 202776751, 201863951, 209583375,
              134877507, 23405380, 160254284, 244763177, 181468172, 219312182, 67321994, 262540431}))
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
    .factors({196328787, 81527994, 32260862, 233514072, 124400051, 202776751, 201863951, 209583375,
              134877507, 23405380, 160254284, 244763177, 181468172, 219312182, 67321994, 262540431}))
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
    .factors({196328787, 81527994, 32260862, 233514072, 124400051, 202776751, 201863951, 209583375,
              134877507, 23405380, 160254284, 244763177, 181468172, 219312182, 67321994, 262540431}))
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
    .factors({177340471, 125267062, 229100654, 55567611, 252241817, 42585458, 60072008, 130696933,
              250508912, 178386996, 64884498, 13458851, 27056737, 196771169, 66242139, 168977833}))
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
    .factors({177340471, 125267062, 229100654, 55567611, 252241817, 42585458, 60072008, 130696933,
              250508912, 178386996, 64884498, 13458851, 27056737, 196771169, 66242139, 168977833}))
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
    .factors({177340471, 125267062, 229100654, 55567611, 252241817, 42585458, 60072008, 130696933,
              250508912, 178386996, 64884498, 13458851, 27056737, 196771169, 66242139, 168977833}))
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
    .factors({177340471, 125267062, 229100654, 55567611, 252241817, 42585458, 60072008, 130696933,
              250508912, 178386996, 64884498, 13458851, 27056737, 196771169, 66242139, 168977833}))
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
    .factors({126063290, 256272276, 219083512, 237102043, 175719113, 156366160, 36946189, 95861179,
              202071175, 222683851, 225650462, 62844488, 266671862, 59284831, 95560742, 138879618}))
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
    .factors({126063290, 256272276, 219083512, 237102043, 175719113, 156366160, 36946189, 95861179,
              202071175, 222683851, 225650462, 62844488, 266671862, 59284831, 95560742, 138879618}))
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
    .factors({126063290, 256272276, 219083512, 237102043, 175719113, 156366160, 36946189, 95861179,
              202071175, 222683851, 225650462, 62844488, 266671862, 59284831, 95560742, 138879618}))
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
    .factors({126063290, 256272276, 219083512, 237102043, 175719113, 156366160, 36946189, 95861179,
              202071175, 222683851, 225650462, 62844488, 266671862, 59284831, 95560742, 138879618}))
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
    .factors({97439895, 146037274, 206649748, 10720790, 210914061, 143779572, 262077011, 234350511,
              216395023, 126520315, 224586596, 191444307, 243024363, 144929841, 148390399, 206725018}))
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
    .factors({97439895, 146037274, 206649748, 10720790, 210914061, 143779572, 262077011, 234350511,
              216395023, 126520315, 224586596, 191444307, 243024363, 144929841, 148390399, 206725018}))
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
    .factors({97439895, 146037274, 206649748, 10720790, 210914061, 143779572, 262077011, 234350511,
              216395023, 126520315, 224586596, 191444307, 243024363, 144929841, 148390399, 206725018}))
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
    .factors({97439895, 146037274, 206649748, 10720790, 210914061, 143779572, 262077011, 234350511,
              216395023, 126520315, 224586596, 191444307, 243024363, 144929841, 148390399, 206725018}))
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
    .factors({164638888, 165134943, 18298478, 10143115, 8950678, 225175773, 182691070, 42156432,
              100457939, 12196542, 234113027, 65413984, 113309038, 69773246, 85252512, 140366124}))
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
    .factors({164638888, 165134943, 18298478, 10143115, 8950678, 225175773, 182691070, 42156432,
              100457939, 12196542, 234113027, 65413984, 113309038, 69773246, 85252512, 140366124}))
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
    .factors({164638888, 165134943, 18298478, 10143115, 8950678, 225175773, 182691070, 42156432,
              100457939, 12196542, 234113027, 65413984, 113309038, 69773246, 85252512, 140366124}))
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
    .factors({164638888, 165134943, 18298478, 10143115, 8950678, 225175773, 182691070, 42156432,
              100457939, 12196542, 234113027, 65413984, 113309038, 69773246, 85252512, 140366124}))
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
    .factors({10112777, 63483304, 172935357, 66310724, 176665584, 171541778, 257269778, 262358962,
              254132077, 68736878, 5299132, 190319963, 85340443, 65324949, 119568150, 73081523}))
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
    .factors({10112777, 63483304, 172935357, 66310724, 176665584, 171541778, 257269778, 262358962,
              254132077, 68736878, 5299132, 190319963, 85340443, 65324949, 119568150, 73081523}))
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
    .factors({10112777, 63483304, 172935357, 66310724, 176665584, 171541778, 257269778, 262358962,
              254132077, 68736878, 5299132, 190319963, 85340443, 65324949, 119568150, 73081523}))
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
    .factors({10112777, 63483304, 172935357, 66310724, 176665584, 171541778, 257269778, 262358962,
              254132077, 68736878, 5299132, 190319963, 85340443, 65324949, 119568150, 73081523}))
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
    .factors({163812837, 77337691, 44942358, 202221416, 242800442, 99962405, 98878775, 184226747,
              186413553, 188210893, 101839787, 170604387, 78777967, 91898237, 183348420, 250166212}))
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
    .factors({163812837, 77337691, 44942358, 202221416, 242800442, 99962405, 98878775, 184226747,
              186413553, 188210893, 101839787, 170604387, 78777967, 91898237, 183348420, 250166212}))
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
    .factors({163812837, 77337691, 44942358, 202221416, 242800442, 99962405, 98878775, 184226747,
              186413553, 188210893, 101839787, 170604387, 78777967, 91898237, 183348420, 250166212}))
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
    .factors({163812837, 77337691, 44942358, 202221416, 242800442, 99962405, 98878775, 184226747,
              186413553, 188210893, 101839787, 170604387, 78777967, 91898237, 183348420, 250166212}))
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
    .factors({163812837, 77337691, 44942358, 202221416, 242800442, 99962405, 98878775, 184226747,
              186413553, 188210893, 101839787, 170604387, 78777967, 91898237, 183348420, 250166212}))
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
    .factors({163812837, 77337691, 44942358, 202221416, 242800442, 99962405, 98878775, 184226747,
              186413553, 188210893, 101839787, 170604387, 78777967, 91898237, 183348420, 250166212}))
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
    .factors({163812837, 77337691, 44942358, 202221416, 242800442, 99962405, 98878775, 184226747,
              186413553, 188210893, 101839787, 170604387, 78777967, 91898237, 183348420, 250166212}))
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
    .factors({163812837, 77337691, 44942358, 202221416, 242800442, 99962405, 98878775, 184226747,
              186413553, 188210893, 101839787, 170604387, 78777967, 91898237, 183348420, 250166212}))
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
    .factors({155168409, 34119889, 234890903, 204152715, 146361539, 132703565, 258923154, 196436059,
              176917280, 261793746, 12328961, 13919506, 22463657, 83853696, 106640438, 100484142}))
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
    .factors({155168409, 34119889, 234890903, 204152715, 146361539, 132703565, 258923154, 196436059,
              176917280, 261793746, 12328961, 13919506, 22463657, 83853696, 106640438, 100484142}))
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
    .factors({155168409, 34119889, 234890903, 204152715, 146361539, 132703565, 258923154, 196436059,
              176917280, 261793746, 12328961, 13919506, 22463657, 83853696, 106640438, 100484142}))
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
    .factors({155168409, 34119889, 234890903, 204152715, 146361539, 132703565, 258923154, 196436059,
              176917280, 261793746, 12328961, 13919506, 22463657, 83853696, 106640438, 100484142}))
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
    .factors({155168409, 34119889, 234890903, 204152715, 146361539, 132703565, 258923154, 196436059,
              176917280, 261793746, 12328961, 13919506, 22463657, 83853696, 106640438, 100484142}))
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
    .factors({155168409, 34119889, 234890903, 204152715, 146361539, 132703565, 258923154, 196436059,
              176917280, 261793746, 12328961, 13919506, 22463657, 83853696, 106640438, 100484142}))
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
    .factors({155168409, 34119889, 234890903, 204152715, 146361539, 132703565, 258923154, 196436059,
              176917280, 261793746, 12328961, 13919506, 22463657, 83853696, 106640438, 100484142}))
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
    .factors({155168409, 34119889, 234890903, 204152715, 146361539, 132703565, 258923154, 196436059,
              176917280, 261793746, 12328961, 13919506, 22463657, 83853696, 106640438, 100484142}))
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
    .factors({149528048, 201357873, 108810259, 229216409, 211668928, 248876054, 28824907, 230702770,
              189762285, 249640399, 240677074, 123185272, 63350037, 241125460, 34339674, 150873005}))
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
    .factors({149528048, 201357873, 108810259, 229216409, 211668928, 248876054, 28824907, 230702770,
              189762285, 249640399, 240677074, 123185272, 63350037, 241125460, 34339674, 150873005}))
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
    .factors({149528048, 201357873, 108810259, 229216409, 211668928, 248876054, 28824907, 230702770,
              189762285, 249640399, 240677074, 123185272, 63350037, 241125460, 34339674, 150873005}))
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
    .factors({149528048, 201357873, 108810259, 229216409, 211668928, 248876054, 28824907, 230702770,
              189762285, 249640399, 240677074, 123185272, 63350037, 241125460, 34339674, 150873005}))
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
    .factors({149528048, 201357873, 108810259, 229216409, 211668928, 248876054, 28824907, 230702770,
              189762285, 249640399, 240677074, 123185272, 63350037, 241125460, 34339674, 150873005}))
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
    .factors({149528048, 201357873, 108810259, 229216409, 211668928, 248876054, 28824907, 230702770,
              189762285, 249640399, 240677074, 123185272, 63350037, 241125460, 34339674, 150873005}))
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
    .factors({149528048, 201357873, 108810259, 229216409, 211668928, 248876054, 28824907, 230702770,
              189762285, 249640399, 240677074, 123185272, 63350037, 241125460, 34339674, 150873005}))
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
    .factors({149528048, 201357873, 108810259, 229216409, 211668928, 248876054, 28824907, 230702770,
              189762285, 249640399, 240677074, 123185272, 63350037, 241125460, 34339674, 150873005}))
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
    .factors({172227818, 41630462, 214551729, 160286792, 144414946, 258649698, 139555205, 143969713,
              246656426, 151968102, 265950570, 85922744, 214085592, 25065602, 41155851, 193371292}))
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
    .factors({172227818, 41630462, 214551729, 160286792, 144414946, 258649698, 139555205, 143969713,
              246656426, 151968102, 265950570, 85922744, 214085592, 25065602, 41155851, 193371292}))
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
    .factors({172227818, 41630462, 214551729, 160286792, 144414946, 258649698, 139555205, 143969713,
              246656426, 151968102, 265950570, 85922744, 214085592, 25065602, 41155851, 193371292}))
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
    .factors({172227818, 41630462, 214551729, 160286792, 144414946, 258649698, 139555205, 143969713,
              246656426, 151968102, 265950570, 85922744, 214085592, 25065602, 41155851, 193371292}))
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
    .factors({172227818, 41630462, 214551729, 160286792, 144414946, 258649698, 139555205, 143969713,
              246656426, 151968102, 265950570, 85922744, 214085592, 25065602, 41155851, 193371292}))
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
    .factors({172227818, 41630462, 214551729, 160286792, 144414946, 258649698, 139555205, 143969713,
              246656426, 151968102, 265950570, 85922744, 214085592, 25065602, 41155851, 193371292}))
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
    .factors({172227818, 41630462, 214551729, 160286792, 144414946, 258649698, 139555205, 143969713,
              246656426, 151968102, 265950570, 85922744, 214085592, 25065602, 41155851, 193371292}))
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
    .factors({172227818, 41630462, 214551729, 160286792, 144414946, 258649698, 139555205, 143969713,
              246656426, 151968102, 265950570, 85922744, 214085592, 25065602, 41155851, 193371292}))
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
    .factors({41086336, 246744565, 63703579, 212648666, 210298252, 13519489, 96648403, 22541719,
              7055647, 71064168, 119707826, 257798138, 59208162, 139182289, 9757140, 108965460}))
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
    .factors({41086336, 246744565, 63703579, 212648666, 210298252, 13519489, 96648403, 22541719,
              7055647, 71064168, 119707826, 257798138, 59208162, 139182289, 9757140, 108965460}))
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
    .factors({41086336, 246744565, 63703579, 212648666, 210298252, 13519489, 96648403, 22541719,
              7055647, 71064168, 119707826, 257798138, 59208162, 139182289, 9757140, 108965460}))
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
    .factors({41086336, 246744565, 63703579, 212648666, 210298252, 13519489, 96648403, 22541719,
              7055647, 71064168, 119707826, 257798138, 59208162, 139182289, 9757140, 108965460}))
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
    .factors({41086336, 246744565, 63703579, 212648666, 210298252, 13519489, 96648403, 22541719,
              7055647, 71064168, 119707826, 257798138, 59208162, 139182289, 9757140, 108965460}))
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
    .factors({41086336, 246744565, 63703579, 212648666, 210298252, 13519489, 96648403, 22541719,
              7055647, 71064168, 119707826, 257798138, 59208162, 139182289, 9757140, 108965460}))
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
    .factors({41086336, 246744565, 63703579, 212648666, 210298252, 13519489, 96648403, 22541719,
              7055647, 71064168, 119707826, 257798138, 59208162, 139182289, 9757140, 108965460}))
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
    .factors({41086336, 246744565, 63703579, 212648666, 210298252, 13519489, 96648403, 22541719,
              7055647, 71064168, 119707826, 257798138, 59208162, 139182289, 9757140, 108965460}))
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
    .factors({133503098, 164195239, 241682233, 254509489, 197074908, 47994339, 195631434, 13250338,
              244883276, 101483624, 39141691, 170227406, 236144340, 10130658, 59283803, 75673633}))
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
    .factors({133503098, 164195239, 241682233, 254509489, 197074908, 47994339, 195631434, 13250338,
              244883276, 101483624, 39141691, 170227406, 236144340, 10130658, 59283803, 75673633}))
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
    .factors({133503098, 164195239, 241682233, 254509489, 197074908, 47994339, 195631434, 13250338,
              244883276, 101483624, 39141691, 170227406, 236144340, 10130658, 59283803, 75673633}))
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
    .factors({133503098, 164195239, 241682233, 254509489, 197074908, 47994339, 195631434, 13250338,
              244883276, 101483624, 39141691, 170227406, 236144340, 10130658, 59283803, 75673633}))
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
    .factors({133503098, 164195239, 241682233, 254509489, 197074908, 47994339, 195631434, 13250338,
              244883276, 101483624, 39141691, 170227406, 236144340, 10130658, 59283803, 75673633}))
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
    .factors({133503098, 164195239, 241682233, 254509489, 197074908, 47994339, 195631434, 13250338,
              244883276, 101483624, 39141691, 170227406, 236144340, 10130658, 59283803, 75673633}))
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
    .factors({133503098, 164195239, 241682233, 254509489, 197074908, 47994339, 195631434, 13250338,
              244883276, 101483624, 39141691, 170227406, 236144340, 10130658, 59283803, 75673633}))
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
    .factors({133503098, 164195239, 241682233, 254509489, 197074908, 47994339, 195631434, 13250338,
              244883276, 101483624, 39141691, 170227406, 236144340, 10130658, 59283803, 75673633}))
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
    .factors({163585105, 161827885, 40553702, 252952333, 147433882, 15927889, 217644581, 69161747,
              133081916, 257268473, 216143425, 227894900, 37936257, 81777479, 173702965, 130557622}))
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
    .factors({163585105, 161827885, 40553702, 252952333, 147433882, 15927889, 217644581, 69161747,
              133081916, 257268473, 216143425, 227894900, 37936257, 81777479, 173702965, 130557622}))
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
    .factors({163585105, 161827885, 40553702, 252952333, 147433882, 15927889, 217644581, 69161747,
              133081916, 257268473, 216143425, 227894900, 37936257, 81777479, 173702965, 130557622}))
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
    .factors({163585105, 161827885, 40553702, 252952333, 147433882, 15927889, 217644581, 69161747,
              133081916, 257268473, 216143425, 227894900, 37936257, 81777479, 173702965, 130557622}))
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
    .factors({163585105, 161827885, 40553702, 252952333, 147433882, 15927889, 217644581, 69161747,
              133081916, 257268473, 216143425, 227894900, 37936257, 81777479, 173702965, 130557622}))
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
    .factors({163585105, 161827885, 40553702, 252952333, 147433882, 15927889, 217644581, 69161747,
              133081916, 257268473, 216143425, 227894900, 37936257, 81777479, 173702965, 130557622}))
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
    .factors({163585105, 161827885, 40553702, 252952333, 147433882, 15927889, 217644581, 69161747,
              133081916, 257268473, 216143425, 227894900, 37936257, 81777479, 173702965, 130557622}))
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
    .factors({163585105, 161827885, 40553702, 252952333, 147433882, 15927889, 217644581, 69161747,
              133081916, 257268473, 216143425, 227894900, 37936257, 81777479, 173702965, 130557622}))
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
    .factors({3883583, 2795054, 149851545, 220618744, 42733001, 162031725, 18399308, 87844233,
              238498066, 68136911, 86730411, 253827407, 37011073, 78488715, 90597117, 231318087}))
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
    .factors({3883583, 2795054, 149851545, 220618744, 42733001, 162031725, 18399308, 87844233,
              238498066, 68136911, 86730411, 253827407, 37011073, 78488715, 90597117, 231318087}))
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
    .factors({3883583, 2795054, 149851545, 220618744, 42733001, 162031725, 18399308, 87844233,
              238498066, 68136911, 86730411, 253827407, 37011073, 78488715, 90597117, 231318087}))
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
    .factors({3883583, 2795054, 149851545, 220618744, 42733001, 162031725, 18399308, 87844233,
              238498066, 68136911, 86730411, 253827407, 37011073, 78488715, 90597117, 231318087}))
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
    .factors({3883583, 2795054, 149851545, 220618744, 42733001, 162031725, 18399308, 87844233,
              238498066, 68136911, 86730411, 253827407, 37011073, 78488715, 90597117, 231318087}))
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
    .factors({3883583, 2795054, 149851545, 220618744, 42733001, 162031725, 18399308, 87844233,
              238498066, 68136911, 86730411, 253827407, 37011073, 78488715, 90597117, 231318087}))
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
    .factors({3883583, 2795054, 149851545, 220618744, 42733001, 162031725, 18399308, 87844233,
              238498066, 68136911, 86730411, 253827407, 37011073, 78488715, 90597117, 231318087}))
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
    .factors({3883583, 2795054, 149851545, 220618744, 42733001, 162031725, 18399308, 87844233,
              238498066, 68136911, 86730411, 253827407, 37011073, 78488715, 90597117, 231318087}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({92577793, 153962078, 181852808, 218546733, 17079898, 263678998, 179817683, 200054106,
              141548072, 124918999, 102065274, 237620966, 76642651, 152865265, 168270865, 162373432}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({197787791, 11695616, 147699054, 78852289, 193045667, 115957373, 109553202, 191662816,
              169276669, 82771912, 157085730, 111341228, 41084242, 175609590, 71471012, 74680748}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({215696667, 233560477, 146694818, 227611463, 25574347, 27685019, 6323336, 170752771,
              70982951, 39593842, 109254766, 210568560, 201062854, 62045777, 235204060, 112472991}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({172642311, 189907315, 202366126, 71460019, 66112528, 47317233, 165226744, 140204941,
              119224607, 239095400, 208403048, 177255039, 130295133, 118939950, 131798756, 145384235}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({183300662, 178374402, 174234737, 216372172, 249274747, 35289455, 11699091, 234642902,
              57538295, 265190919, 102579498, 139368110, 92744225, 83571649, 18533839, 196317032}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({108349160, 220656190, 36955649, 221840088, 206308099, 76573097, 143639106, 39264098,
              84893967, 165596304, 119480423, 72061017, 5258704, 220492738, 99790517, 73825164}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({73648196, 163057267, 42982065, 135333989, 46265048, 242569099, 70516281, 136955445,
              33383981, 47600907, 142393906, 69075086, 210749829, 133782759, 155624840, 7802111}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({96332896, 96332896, 180609988, 180609988, 48587502, 48587502, 130838261, 130838261,
              90670588, 90670588, 105446074, 105446074, 128108241, 128108241, 71274504, 71274504}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({18186460, 18186460, 18186460, 18186460, 88202115, 88202115, 88202115, 88202115,
              198795595, 198795595, 198795595, 198795595, 93509205, 93509205, 93509205, 93509205}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .factors({185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570, 185593570,
              183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802, 183496802}))
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
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_0 (
    .x_in(stage_9_per_out[0]),
    .y_in(stage_9_per_out[1]),
    .x_out(outData[0]),
    .y_out(outData[1]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_1 (
    .x_in(stage_9_per_out[2]),
    .y_in(stage_9_per_out[3]),
    .x_out(outData[2]),
    .y_out(outData[3]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_2 (
    .x_in(stage_9_per_out[4]),
    .y_in(stage_9_per_out[5]),
    .x_out(outData[4]),
    .y_out(outData[5]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_3 (
    .x_in(stage_9_per_out[6]),
    .y_in(stage_9_per_out[7]),
    .x_out(outData[6]),
    .y_out(outData[7]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_4 (
    .x_in(stage_9_per_out[8]),
    .y_in(stage_9_per_out[9]),
    .x_out(outData[8]),
    .y_out(outData[9]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_5 (
    .x_in(stage_9_per_out[10]),
    .y_in(stage_9_per_out[11]),
    .x_out(outData[10]),
    .y_out(outData[11]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_6 (
    .x_in(stage_9_per_out[12]),
    .y_in(stage_9_per_out[13]),
    .x_out(outData[12]),
    .y_out(outData[13]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_7 (
    .x_in(stage_9_per_out[14]),
    .y_in(stage_9_per_out[15]),
    .x_out(outData[14]),
    .y_out(outData[15]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_8 (
    .x_in(stage_9_per_out[16]),
    .y_in(stage_9_per_out[17]),
    .x_out(outData[16]),
    .y_out(outData[17]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_9 (
    .x_in(stage_9_per_out[18]),
    .y_in(stage_9_per_out[19]),
    .x_out(outData[18]),
    .y_out(outData[19]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_10 (
    .x_in(stage_9_per_out[20]),
    .y_in(stage_9_per_out[21]),
    .x_out(outData[20]),
    .y_out(outData[21]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_11 (
    .x_in(stage_9_per_out[22]),
    .y_in(stage_9_per_out[23]),
    .x_out(outData[22]),
    .y_out(outData[23]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_12 (
    .x_in(stage_9_per_out[24]),
    .y_in(stage_9_per_out[25]),
    .x_out(outData[24]),
    .y_out(outData[25]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_13 (
    .x_in(stage_9_per_out[26]),
    .y_in(stage_9_per_out[27]),
    .x_out(outData[26]),
    .y_out(outData[27]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_14 (
    .x_in(stage_9_per_out[28]),
    .y_in(stage_9_per_out[29]),
    .x_out(outData[28]),
    .y_out(outData[29]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_15 (
    .x_in(stage_9_per_out[30]),
    .y_in(stage_9_per_out[31]),
    .x_out(outData[30]),
    .y_out(outData[31]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_16 (
    .x_in(stage_9_per_out[32]),
    .y_in(stage_9_per_out[33]),
    .x_out(outData[32]),
    .y_out(outData[33]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_17 (
    .x_in(stage_9_per_out[34]),
    .y_in(stage_9_per_out[35]),
    .x_out(outData[34]),
    .y_out(outData[35]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_18 (
    .x_in(stage_9_per_out[36]),
    .y_in(stage_9_per_out[37]),
    .x_out(outData[36]),
    .y_out(outData[37]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_19 (
    .x_in(stage_9_per_out[38]),
    .y_in(stage_9_per_out[39]),
    .x_out(outData[38]),
    .y_out(outData[39]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_20 (
    .x_in(stage_9_per_out[40]),
    .y_in(stage_9_per_out[41]),
    .x_out(outData[40]),
    .y_out(outData[41]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_21 (
    .x_in(stage_9_per_out[42]),
    .y_in(stage_9_per_out[43]),
    .x_out(outData[42]),
    .y_out(outData[43]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_22 (
    .x_in(stage_9_per_out[44]),
    .y_in(stage_9_per_out[45]),
    .x_out(outData[44]),
    .y_out(outData[45]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_23 (
    .x_in(stage_9_per_out[46]),
    .y_in(stage_9_per_out[47]),
    .x_out(outData[46]),
    .y_out(outData[47]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_24 (
    .x_in(stage_9_per_out[48]),
    .y_in(stage_9_per_out[49]),
    .x_out(outData[48]),
    .y_out(outData[49]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_25 (
    .x_in(stage_9_per_out[50]),
    .y_in(stage_9_per_out[51]),
    .x_out(outData[50]),
    .y_out(outData[51]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_26 (
    .x_in(stage_9_per_out[52]),
    .y_in(stage_9_per_out[53]),
    .x_out(outData[52]),
    .y_out(outData[53]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_27 (
    .x_in(stage_9_per_out[54]),
    .y_in(stage_9_per_out[55]),
    .x_out(outData[54]),
    .y_out(outData[55]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_28 (
    .x_in(stage_9_per_out[56]),
    .y_in(stage_9_per_out[57]),
    .x_out(outData[56]),
    .y_out(outData[57]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_29 (
    .x_in(stage_9_per_out[58]),
    .y_in(stage_9_per_out[59]),
    .x_out(outData[58]),
    .y_out(outData[59]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_30 (
    .x_in(stage_9_per_out[60]),
    .y_in(stage_9_per_out[61]),
    .x_out(outData[60]),
    .y_out(outData[61]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_31 (
    .x_in(stage_9_per_out[62]),
    .y_in(stage_9_per_out[63]),
    .x_out(outData[62]),
    .y_out(outData[63]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_32 (
    .x_in(stage_9_per_out[64]),
    .y_in(stage_9_per_out[65]),
    .x_out(outData[64]),
    .y_out(outData[65]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_33 (
    .x_in(stage_9_per_out[66]),
    .y_in(stage_9_per_out[67]),
    .x_out(outData[66]),
    .y_out(outData[67]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_34 (
    .x_in(stage_9_per_out[68]),
    .y_in(stage_9_per_out[69]),
    .x_out(outData[68]),
    .y_out(outData[69]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_35 (
    .x_in(stage_9_per_out[70]),
    .y_in(stage_9_per_out[71]),
    .x_out(outData[70]),
    .y_out(outData[71]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_36 (
    .x_in(stage_9_per_out[72]),
    .y_in(stage_9_per_out[73]),
    .x_out(outData[72]),
    .y_out(outData[73]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_37 (
    .x_in(stage_9_per_out[74]),
    .y_in(stage_9_per_out[75]),
    .x_out(outData[74]),
    .y_out(outData[75]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_38 (
    .x_in(stage_9_per_out[76]),
    .y_in(stage_9_per_out[77]),
    .x_out(outData[76]),
    .y_out(outData[77]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_39 (
    .x_in(stage_9_per_out[78]),
    .y_in(stage_9_per_out[79]),
    .x_out(outData[78]),
    .y_out(outData[79]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_40 (
    .x_in(stage_9_per_out[80]),
    .y_in(stage_9_per_out[81]),
    .x_out(outData[80]),
    .y_out(outData[81]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_41 (
    .x_in(stage_9_per_out[82]),
    .y_in(stage_9_per_out[83]),
    .x_out(outData[82]),
    .y_out(outData[83]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_42 (
    .x_in(stage_9_per_out[84]),
    .y_in(stage_9_per_out[85]),
    .x_out(outData[84]),
    .y_out(outData[85]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_43 (
    .x_in(stage_9_per_out[86]),
    .y_in(stage_9_per_out[87]),
    .x_out(outData[86]),
    .y_out(outData[87]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_44 (
    .x_in(stage_9_per_out[88]),
    .y_in(stage_9_per_out[89]),
    .x_out(outData[88]),
    .y_out(outData[89]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_45 (
    .x_in(stage_9_per_out[90]),
    .y_in(stage_9_per_out[91]),
    .x_out(outData[90]),
    .y_out(outData[91]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_46 (
    .x_in(stage_9_per_out[92]),
    .y_in(stage_9_per_out[93]),
    .x_out(outData[92]),
    .y_out(outData[93]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_47 (
    .x_in(stage_9_per_out[94]),
    .y_in(stage_9_per_out[95]),
    .x_out(outData[94]),
    .y_out(outData[95]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_48 (
    .x_in(stage_9_per_out[96]),
    .y_in(stage_9_per_out[97]),
    .x_out(outData[96]),
    .y_out(outData[97]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_49 (
    .x_in(stage_9_per_out[98]),
    .y_in(stage_9_per_out[99]),
    .x_out(outData[98]),
    .y_out(outData[99]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_50 (
    .x_in(stage_9_per_out[100]),
    .y_in(stage_9_per_out[101]),
    .x_out(outData[100]),
    .y_out(outData[101]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_51 (
    .x_in(stage_9_per_out[102]),
    .y_in(stage_9_per_out[103]),
    .x_out(outData[102]),
    .y_out(outData[103]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_52 (
    .x_in(stage_9_per_out[104]),
    .y_in(stage_9_per_out[105]),
    .x_out(outData[104]),
    .y_out(outData[105]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_53 (
    .x_in(stage_9_per_out[106]),
    .y_in(stage_9_per_out[107]),
    .x_out(outData[106]),
    .y_out(outData[107]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_54 (
    .x_in(stage_9_per_out[108]),
    .y_in(stage_9_per_out[109]),
    .x_out(outData[108]),
    .y_out(outData[109]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_55 (
    .x_in(stage_9_per_out[110]),
    .y_in(stage_9_per_out[111]),
    .x_out(outData[110]),
    .y_out(outData[111]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_56 (
    .x_in(stage_9_per_out[112]),
    .y_in(stage_9_per_out[113]),
    .x_out(outData[112]),
    .y_out(outData[113]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_57 (
    .x_in(stage_9_per_out[114]),
    .y_in(stage_9_per_out[115]),
    .x_out(outData[114]),
    .y_out(outData[115]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_58 (
    .x_in(stage_9_per_out[116]),
    .y_in(stage_9_per_out[117]),
    .x_out(outData[116]),
    .y_out(outData[117]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_59 (
    .x_in(stage_9_per_out[118]),
    .y_in(stage_9_per_out[119]),
    .x_out(outData[118]),
    .y_out(outData[119]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_60 (
    .x_in(stage_9_per_out[120]),
    .y_in(stage_9_per_out[121]),
    .x_out(outData[120]),
    .y_out(outData[121]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_61 (
    .x_in(stage_9_per_out[122]),
    .y_in(stage_9_per_out[123]),
    .x_out(outData[122]),
    .y_out(outData[123]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_62 (
    .x_in(stage_9_per_out[124]),
    .y_in(stage_9_per_out[125]),
    .x_out(outData[124]),
    .y_out(outData[125]),
    .clk(clk),
    .rst(rst)
  );

  butterfly #(
    .start(START_CYCLE[10]),
    .factors({75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761,
              75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761, 75074761}))
  stage_10_butterfly_63 (
    .x_in(stage_9_per_out[126]),
    .y_in(stage_9_per_out[127]),
    .x_out(outData[126]),
    .y_out(outData[127]),
    .clk(clk),
    .rst(rst)
  );


endmodule
