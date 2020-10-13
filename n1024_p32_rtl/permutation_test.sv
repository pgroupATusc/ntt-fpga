`timescale 1 ns / 1 ps

module permutation_tb;

  localparam DATA_WIDTH_PER_INPUT = 28;
  localparam INPUT_PER_CYCLE = 32;

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
      offset += 32;

    end

  end
  
  //stage_0_permutation #(
  //stage_1_permutation #(
  //stage_2_permutation #(
  //stage_3_permutation #(
  stage_4_permutation #(
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
    .in_start(input_valid),
    .out_start(output_valid),
    .clk(clock),
    .rst(reset)
  );

endmodule
