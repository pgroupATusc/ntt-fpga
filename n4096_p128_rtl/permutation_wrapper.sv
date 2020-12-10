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
    .inData_32(input_data[32]),
    .inData_33(input_data[33]),
    .inData_34(input_data[34]),
    .inData_35(input_data[35]),
    .inData_36(input_data[36]),
    .inData_37(input_data[37]),
    .inData_38(input_data[38]),
    .inData_39(input_data[39]),
    .inData_40(input_data[40]),
    .inData_41(input_data[41]),
    .inData_42(input_data[42]),
    .inData_43(input_data[43]),
    .inData_44(input_data[44]),
    .inData_45(input_data[45]),
    .inData_46(input_data[46]),
    .inData_47(input_data[47]),
    .inData_48(input_data[48]),
    .inData_49(input_data[49]),
    .inData_50(input_data[50]),
    .inData_51(input_data[51]),
    .inData_52(input_data[52]),
    .inData_53(input_data[53]),
    .inData_54(input_data[54]),
    .inData_55(input_data[55]),
    .inData_56(input_data[56]),
    .inData_57(input_data[57]),
    .inData_58(input_data[58]),
    .inData_59(input_data[59]),
    .inData_60(input_data[60]),
    .inData_61(input_data[61]),
    .inData_62(input_data[62]),
    .inData_63(input_data[63]),
    .inData_64(input_data[64]),
    .inData_65(input_data[65]),
    .inData_66(input_data[66]),
    .inData_67(input_data[67]),
    .inData_68(input_data[68]),
    .inData_69(input_data[69]),
    .inData_70(input_data[70]),
    .inData_71(input_data[71]),
    .inData_72(input_data[72]),
    .inData_73(input_data[73]),
    .inData_74(input_data[74]),
    .inData_75(input_data[75]),
    .inData_76(input_data[76]),
    .inData_77(input_data[77]),
    .inData_78(input_data[78]),
    .inData_79(input_data[79]),
    .inData_80(input_data[80]),
    .inData_81(input_data[81]),
    .inData_82(input_data[82]),
    .inData_83(input_data[83]),
    .inData_84(input_data[84]),
    .inData_85(input_data[85]),
    .inData_86(input_data[86]),
    .inData_87(input_data[87]),
    .inData_88(input_data[88]),
    .inData_89(input_data[89]),
    .inData_90(input_data[90]),
    .inData_91(input_data[91]),
    .inData_92(input_data[92]),
    .inData_93(input_data[93]),
    .inData_94(input_data[94]),
    .inData_95(input_data[95]),
    .inData_96(input_data[96]),
    .inData_97(input_data[97]),
    .inData_98(input_data[98]),
    .inData_99(input_data[99]),
    .inData_100(input_data[100]),
    .inData_101(input_data[101]),
    .inData_102(input_data[102]),
    .inData_103(input_data[103]),
    .inData_104(input_data[104]),
    .inData_105(input_data[105]),
    .inData_106(input_data[106]),
    .inData_107(input_data[107]),
    .inData_108(input_data[108]),
    .inData_109(input_data[109]),
    .inData_110(input_data[110]),
    .inData_111(input_data[111]),
    .inData_112(input_data[112]),
    .inData_113(input_data[113]),
    .inData_114(input_data[114]),
    .inData_115(input_data[115]),
    .inData_116(input_data[116]),
    .inData_117(input_data[117]),
    .inData_118(input_data[118]),
    .inData_119(input_data[119]),
    .inData_120(input_data[120]),
    .inData_121(input_data[121]),
    .inData_122(input_data[122]),
    .inData_123(input_data[123]),
    .inData_124(input_data[124]),
    .inData_125(input_data[125]),
    .inData_126(input_data[126]),
    .inData_127(input_data[127]),
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
    .outData_32(output_data[32]),
    .outData_33(output_data[33]),
    .outData_34(output_data[34]),
    .outData_35(output_data[35]),
    .outData_36(output_data[36]),
    .outData_37(output_data[37]),
    .outData_38(output_data[38]),
    .outData_39(output_data[39]),
    .outData_40(output_data[40]),
    .outData_41(output_data[41]),
    .outData_42(output_data[42]),
    .outData_43(output_data[43]),
    .outData_44(output_data[44]),
    .outData_45(output_data[45]),
    .outData_46(output_data[46]),
    .outData_47(output_data[47]),
    .outData_48(output_data[48]),
    .outData_49(output_data[49]),
    .outData_50(output_data[50]),
    .outData_51(output_data[51]),
    .outData_52(output_data[52]),
    .outData_53(output_data[53]),
    .outData_54(output_data[54]),
    .outData_55(output_data[55]),
    .outData_56(output_data[56]),
    .outData_57(output_data[57]),
    .outData_58(output_data[58]),
    .outData_59(output_data[59]),
    .outData_60(output_data[60]),
    .outData_61(output_data[61]),
    .outData_62(output_data[62]),
    .outData_63(output_data[63]),
    .outData_64(output_data[64]),
    .outData_65(output_data[65]),
    .outData_66(output_data[66]),
    .outData_67(output_data[67]),
    .outData_68(output_data[68]),
    .outData_69(output_data[69]),
    .outData_70(output_data[70]),
    .outData_71(output_data[71]),
    .outData_72(output_data[72]),
    .outData_73(output_data[73]),
    .outData_74(output_data[74]),
    .outData_75(output_data[75]),
    .outData_76(output_data[76]),
    .outData_77(output_data[77]),
    .outData_78(output_data[78]),
    .outData_79(output_data[79]),
    .outData_80(output_data[80]),
    .outData_81(output_data[81]),
    .outData_82(output_data[82]),
    .outData_83(output_data[83]),
    .outData_84(output_data[84]),
    .outData_85(output_data[85]),
    .outData_86(output_data[86]),
    .outData_87(output_data[87]),
    .outData_88(output_data[88]),
    .outData_89(output_data[89]),
    .outData_90(output_data[90]),
    .outData_91(output_data[91]),
    .outData_92(output_data[92]),
    .outData_93(output_data[93]),
    .outData_94(output_data[94]),
    .outData_95(output_data[95]),
    .outData_96(output_data[96]),
    .outData_97(output_data[97]),
    .outData_98(output_data[98]),
    .outData_99(output_data[99]),
    .outData_100(output_data[100]),
    .outData_101(output_data[101]),
    .outData_102(output_data[102]),
    .outData_103(output_data[103]),
    .outData_104(output_data[104]),
    .outData_105(output_data[105]),
    .outData_106(output_data[106]),
    .outData_107(output_data[107]),
    .outData_108(output_data[108]),
    .outData_109(output_data[109]),
    .outData_110(output_data[110]),
    .outData_111(output_data[111]),
    .outData_112(output_data[112]),
    .outData_113(output_data[113]),
    .outData_114(output_data[114]),
    .outData_115(output_data[115]),
    .outData_116(output_data[116]),
    .outData_117(output_data[117]),
    .outData_118(output_data[118]),
    .outData_119(output_data[119]),
    .outData_120(output_data[120]),
    .outData_121(output_data[121]),
    .outData_122(output_data[122]),
    .outData_123(output_data[123]),
    .outData_124(output_data[124]),
    .outData_125(output_data[125]),
    .outData_126(output_data[126]),
    .outData_127(output_data[127]),
    .in_start(in_start[0]),
    .out_start(out_start[0]),
    .clk(clk),
    .rst(rst)
  );

endmodule