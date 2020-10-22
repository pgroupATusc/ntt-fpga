`timescale 1 ns / 1 ps

module permutation_tb;

  localparam DATA_WIDTH_PER_INPUT = 28;
  localparam INPUT_PER_CYCLE = 128;

  localparam CLK_PERIOD = 10;

  bit clock;
  bit reset;
  bit input_valid;
  bit output_valid;

  logic [DATA_WIDTH_PER_INPUT-1:0]  inData[INPUT_PER_CYCLE-1:0];
  logic [DATA_WIDTH_PER_INPUT-1:0]  outData[INPUT_PER_CYCLE-1:0];

  // clock generation
  initial begin
    clock = 0;
    forever begin
      #(CLK_PERIOD/2) clock = ~clock;
    end 
  end

  // clock counter
  integer clock_counter;
  initial begin
    clock_counter = 0;
    # (0.6 * CLK_PERIOD); // wait until a little after the positive edge
    forever begin
      #(CLK_PERIOD) clock_counter <= clock_counter + 1;
    end 
  end
  
  // reset generation
  initial begin
    reset = 1;
    #(2 * CLK_PERIOD) reset = 0;
  end

  int offset = 0;
  initial begin

    for (int i = 0; i < INPUT_PER_CYCLE; ++i) begin
      inData[i] = 0;
    end

    wait (!reset);

    for (int i = 0; i < 1024 / INPUT_PER_CYCLE; ++i) begin

      #CLK_PERIOD
      for (int j = 0; j < INPUT_PER_CYCLE; ++j) begin
        inData[j] = offset + j;
      end
      offset += 128;

    end

  end

  initial begin

    input_valid = 1'b0;
    #(3 * CLK_PERIOD) input_valid = 1'b1;
    #CLK_PERIOD input_valid = 1'b0;

  end
  
  //stage_0_permutation #(
  //stage_1_permutation #(
  //stage_2_permutation #(
  //stage_3_permutation #(
  //stage_4_permutation #(
  //stage_5_permutation #(
  //stage_6_permutation #(
  stage_7_permutation #(
  //stage_8_permutation #(
    .DATA_WIDTH_PER_INPUT(DATA_WIDTH_PER_INPUT),
    .INPUT_PER_CYCLE(INPUT_PER_CYCLE))
  DUT (
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
    .inData_32(inData[32]),
    .inData_33(inData[33]),
    .inData_34(inData[34]),
    .inData_35(inData[35]),
    .inData_36(inData[36]),
    .inData_37(inData[37]),
    .inData_38(inData[38]),
    .inData_39(inData[39]),
    .inData_40(inData[40]),
    .inData_41(inData[41]),
    .inData_42(inData[42]),
    .inData_43(inData[43]),
    .inData_44(inData[44]),
    .inData_45(inData[45]),
    .inData_46(inData[46]),
    .inData_47(inData[47]),
    .inData_48(inData[48]),
    .inData_49(inData[49]),
    .inData_50(inData[50]),
    .inData_51(inData[51]),
    .inData_52(inData[52]),
    .inData_53(inData[53]),
    .inData_54(inData[54]),
    .inData_55(inData[55]),
    .inData_56(inData[56]),
    .inData_57(inData[57]),
    .inData_58(inData[58]),
    .inData_59(inData[59]),
    .inData_60(inData[60]),
    .inData_61(inData[61]),
    .inData_62(inData[62]),
    .inData_63(inData[63]),
    .inData_64(inData[64]),
    .inData_65(inData[65]),
    .inData_66(inData[66]),
    .inData_67(inData[67]),
    .inData_68(inData[68]),
    .inData_69(inData[69]),
    .inData_70(inData[70]),
    .inData_71(inData[71]),
    .inData_72(inData[72]),
    .inData_73(inData[73]),
    .inData_74(inData[74]),
    .inData_75(inData[75]),
    .inData_76(inData[76]),
    .inData_77(inData[77]),
    .inData_78(inData[78]),
    .inData_79(inData[79]),
    .inData_80(inData[80]),
    .inData_81(inData[81]),
    .inData_82(inData[82]),
    .inData_83(inData[83]),
    .inData_84(inData[84]),
    .inData_85(inData[85]),
    .inData_86(inData[86]),
    .inData_87(inData[87]),
    .inData_88(inData[88]),
    .inData_89(inData[89]),
    .inData_90(inData[90]),
    .inData_91(inData[91]),
    .inData_92(inData[92]),
    .inData_93(inData[93]),
    .inData_94(inData[94]),
    .inData_95(inData[95]),
    .inData_96(inData[96]),
    .inData_97(inData[97]),
    .inData_98(inData[98]),
    .inData_99(inData[99]),
    .inData_100(inData[100]),
    .inData_101(inData[101]),
    .inData_102(inData[102]),
    .inData_103(inData[103]),
    .inData_104(inData[104]),
    .inData_105(inData[105]),
    .inData_106(inData[106]),
    .inData_107(inData[107]),
    .inData_108(inData[108]),
    .inData_109(inData[109]),
    .inData_110(inData[110]),
    .inData_111(inData[111]),
    .inData_112(inData[112]),
    .inData_113(inData[113]),
    .inData_114(inData[114]),
    .inData_115(inData[115]),
    .inData_116(inData[116]),
    .inData_117(inData[117]),
    .inData_118(inData[118]),
    .inData_119(inData[119]),
    .inData_120(inData[120]),
    .inData_121(inData[121]),
    .inData_122(inData[122]),
    .inData_123(inData[123]),
    .inData_124(inData[124]),
    .inData_125(inData[125]),
    .inData_126(inData[126]),
    .inData_127(inData[127]),
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
    .outData_32(outData[32]),
    .outData_33(outData[33]),
    .outData_34(outData[34]),
    .outData_35(outData[35]),
    .outData_36(outData[36]),
    .outData_37(outData[37]),
    .outData_38(outData[38]),
    .outData_39(outData[39]),
    .outData_40(outData[40]),
    .outData_41(outData[41]),
    .outData_42(outData[42]),
    .outData_43(outData[43]),
    .outData_44(outData[44]),
    .outData_45(outData[45]),
    .outData_46(outData[46]),
    .outData_47(outData[47]),
    .outData_48(outData[48]),
    .outData_49(outData[49]),
    .outData_50(outData[50]),
    .outData_51(outData[51]),
    .outData_52(outData[52]),
    .outData_53(outData[53]),
    .outData_54(outData[54]),
    .outData_55(outData[55]),
    .outData_56(outData[56]),
    .outData_57(outData[57]),
    .outData_58(outData[58]),
    .outData_59(outData[59]),
    .outData_60(outData[60]),
    .outData_61(outData[61]),
    .outData_62(outData[62]),
    .outData_63(outData[63]),
    .outData_64(outData[64]),
    .outData_65(outData[65]),
    .outData_66(outData[66]),
    .outData_67(outData[67]),
    .outData_68(outData[68]),
    .outData_69(outData[69]),
    .outData_70(outData[70]),
    .outData_71(outData[71]),
    .outData_72(outData[72]),
    .outData_73(outData[73]),
    .outData_74(outData[74]),
    .outData_75(outData[75]),
    .outData_76(outData[76]),
    .outData_77(outData[77]),
    .outData_78(outData[78]),
    .outData_79(outData[79]),
    .outData_80(outData[80]),
    .outData_81(outData[81]),
    .outData_82(outData[82]),
    .outData_83(outData[83]),
    .outData_84(outData[84]),
    .outData_85(outData[85]),
    .outData_86(outData[86]),
    .outData_87(outData[87]),
    .outData_88(outData[88]),
    .outData_89(outData[89]),
    .outData_90(outData[90]),
    .outData_91(outData[91]),
    .outData_92(outData[92]),
    .outData_93(outData[93]),
    .outData_94(outData[94]),
    .outData_95(outData[95]),
    .outData_96(outData[96]),
    .outData_97(outData[97]),
    .outData_98(outData[98]),
    .outData_99(outData[99]),
    .outData_100(outData[100]),
    .outData_101(outData[101]),
    .outData_102(outData[102]),
    .outData_103(outData[103]),
    .outData_104(outData[104]),
    .outData_105(outData[105]),
    .outData_106(outData[106]),
    .outData_107(outData[107]),
    .outData_108(outData[108]),
    .outData_109(outData[109]),
    .outData_110(outData[110]),
    .outData_111(outData[111]),
    .outData_112(outData[112]),
    .outData_113(outData[113]),
    .outData_114(outData[114]),
    .outData_115(outData[115]),
    .outData_116(outData[116]),
    .outData_117(outData[117]),
    .outData_118(outData[118]),
    .outData_119(outData[119]),
    .outData_120(outData[120]),
    .outData_121(outData[121]),
    .outData_122(outData[122]),
    .outData_123(outData[123]),
    .outData_124(outData[124]),
    .outData_125(outData[125]),
    .outData_126(outData[126]),
    .outData_127(outData[127]),
    .in_start(input_valid),
    .out_start(output_valid),
    .clk(clock),
    .rst(reset)
  );

endmodule
