module stage_0_permutation #(
    parameter DATA_WIDTH_PER_INPUT = 28,
    parameter INPUT_PER_CYCLE = 64 
  ) (
    inData_0,
    inData_1,
    inData_2,
    inData_3,
    inData_4,
    inData_5,
    inData_6,
    inData_7,
    inData_8,
    inData_9,
    inData_10,
    inData_11,
    inData_12,
    inData_13,
    inData_14,
    inData_15,
    inData_16,
    inData_17,
    inData_18,
    inData_19,
    inData_20,
    inData_21,
    inData_22,
    inData_23,
    inData_24,
    inData_25,
    inData_26,
    inData_27,
    inData_28,
    inData_29,
    inData_30,
    inData_31,
    inData_32,
    inData_33,
    inData_34,
    inData_35,
    inData_36,
    inData_37,
    inData_38,
    inData_39,
    inData_40,
    inData_41,
    inData_42,
    inData_43,
    inData_44,
    inData_45,
    inData_46,
    inData_47,
    inData_48,
    inData_49,
    inData_50,
    inData_51,
    inData_52,
    inData_53,
    inData_54,
    inData_55,
    inData_56,
    inData_57,
    inData_58,
    inData_59,
    inData_60,
    inData_61,
    inData_62,
    inData_63,
    outData_0,
    outData_1,
    outData_2,
    outData_3,
    outData_4,
    outData_5,
    outData_6,
    outData_7,
    outData_8,
    outData_9,
    outData_10,
    outData_11,
    outData_12,
    outData_13,
    outData_14,
    outData_15,
    outData_16,
    outData_17,
    outData_18,
    outData_19,
    outData_20,
    outData_21,
    outData_22,
    outData_23,
    outData_24,
    outData_25,
    outData_26,
    outData_27,
    outData_28,
    outData_29,
    outData_30,
    outData_31,
    outData_32,
    outData_33,
    outData_34,
    outData_35,
    outData_36,
    outData_37,
    outData_38,
    outData_39,
    outData_40,
    outData_41,
    outData_42,
    outData_43,
    outData_44,
    outData_45,
    outData_46,
    outData_47,
    outData_48,
    outData_49,
    outData_50,
    outData_51,
    outData_52,
    outData_53,
    outData_54,
    outData_55,
    outData_56,
    outData_57,
    outData_58,
    outData_59,
    outData_60,
    outData_61,
    outData_62,
    outData_63,
    in_start,
    out_start,
    clk,
    rst
  );

  input clk, rst;
  input in_start;
  output logic out_start;

  input [DATA_WIDTH_PER_INPUT-1:0] inData_0;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_1;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_2;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_3;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_4;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_5;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_6;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_7;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_8;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_9;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_10;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_11;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_12;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_13;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_14;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_15;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_16;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_17;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_18;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_19;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_20;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_21;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_22;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_23;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_24;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_25;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_26;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_27;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_28;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_29;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_30;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_31;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_32;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_33;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_34;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_35;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_36;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_37;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_38;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_39;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_40;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_41;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_42;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_43;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_44;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_45;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_46;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_47;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_48;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_49;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_50;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_51;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_52;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_53;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_54;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_55;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_56;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_57;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_58;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_59;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_60;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_61;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_62;
  input [DATA_WIDTH_PER_INPUT-1:0] inData_63;

  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_0;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_1;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_2;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_3;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_4;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_5;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_6;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_7;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_8;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_9;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_10;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_11;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_12;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_13;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_14;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_15;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_16;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_17;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_18;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_19;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_20;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_21;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_22;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_23;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_24;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_25;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_26;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_27;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_28;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_29;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_30;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_31;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_32;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_33;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_34;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_35;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_36;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_37;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_38;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_39;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_40;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_41;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_42;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_43;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_44;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_45;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_46;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_47;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_48;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_49;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_50;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_51;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_52;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_53;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_54;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_55;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_56;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_57;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_58;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_59;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_60;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_61;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_62;
  output logic [DATA_WIDTH_PER_INPUT-1:0] outData_63;


  always_ff @ (posedge clk) begin
    if (rst) begin
      outData_0 <= 0;
      outData_1 <= 0;
      outData_2 <= 0;
      outData_3 <= 0;
      outData_4 <= 0;
      outData_5 <= 0;
      outData_6 <= 0;
      outData_7 <= 0;
      outData_8 <= 0;
      outData_9 <= 0;
      outData_10 <= 0;
      outData_11 <= 0;
      outData_12 <= 0;
      outData_13 <= 0;
      outData_14 <= 0;
      outData_15 <= 0;
      outData_16 <= 0;
      outData_17 <= 0;
      outData_18 <= 0;
      outData_19 <= 0;
      outData_20 <= 0;
      outData_21 <= 0;
      outData_22 <= 0;
      outData_23 <= 0;
      outData_24 <= 0;
      outData_25 <= 0;
      outData_26 <= 0;
      outData_27 <= 0;
      outData_28 <= 0;
      outData_29 <= 0;
      outData_30 <= 0;
      outData_31 <= 0;
      outData_32 <= 0;
      outData_33 <= 0;
      outData_34 <= 0;
      outData_35 <= 0;
      outData_36 <= 0;
      outData_37 <= 0;
      outData_38 <= 0;
      outData_39 <= 0;
      outData_40 <= 0;
      outData_41 <= 0;
      outData_42 <= 0;
      outData_43 <= 0;
      outData_44 <= 0;
      outData_45 <= 0;
      outData_46 <= 0;
      outData_47 <= 0;
      outData_48 <= 0;
      outData_49 <= 0;
      outData_50 <= 0;
      outData_51 <= 0;
      outData_52 <= 0;
      outData_53 <= 0;
      outData_54 <= 0;
      outData_55 <= 0;
      outData_56 <= 0;
      outData_57 <= 0;
      outData_58 <= 0;
      outData_59 <= 0;
      outData_60 <= 0;
      outData_61 <= 0;
      outData_62 <= 0;
      outData_63 <= 0;
    end else begin
      outData_0 <= inData_0;
      outData_1 <= inData_2;
      outData_2 <= inData_1;
      outData_3 <= inData_3;
      outData_4 <= inData_4;
      outData_5 <= inData_6;
      outData_6 <= inData_5;
      outData_7 <= inData_7;
      outData_8 <= inData_8;
      outData_9 <= inData_10;
      outData_10 <= inData_9;
      outData_11 <= inData_11;
      outData_12 <= inData_12;
      outData_13 <= inData_14;
      outData_14 <= inData_13;
      outData_15 <= inData_15;
      outData_16 <= inData_16;
      outData_17 <= inData_18;
      outData_18 <= inData_17;
      outData_19 <= inData_19;
      outData_20 <= inData_20;
      outData_21 <= inData_22;
      outData_22 <= inData_21;
      outData_23 <= inData_23;
      outData_24 <= inData_24;
      outData_25 <= inData_26;
      outData_26 <= inData_25;
      outData_27 <= inData_27;
      outData_28 <= inData_28;
      outData_29 <= inData_30;
      outData_30 <= inData_29;
      outData_31 <= inData_31;
      outData_32 <= inData_32;
      outData_33 <= inData_34;
      outData_34 <= inData_33;
      outData_35 <= inData_35;
      outData_36 <= inData_36;
      outData_37 <= inData_38;
      outData_38 <= inData_37;
      outData_39 <= inData_39;
      outData_40 <= inData_40;
      outData_41 <= inData_42;
      outData_42 <= inData_41;
      outData_43 <= inData_43;
      outData_44 <= inData_44;
      outData_45 <= inData_46;
      outData_46 <= inData_45;
      outData_47 <= inData_47;
      outData_48 <= inData_48;
      outData_49 <= inData_50;
      outData_50 <= inData_49;
      outData_51 <= inData_51;
      outData_52 <= inData_52;
      outData_53 <= inData_54;
      outData_54 <= inData_53;
      outData_55 <= inData_55;
      outData_56 <= inData_56;
      outData_57 <= inData_58;
      outData_58 <= inData_57;
      outData_59 <= inData_59;
      outData_60 <= inData_60;
      outData_61 <= inData_62;
      outData_62 <= inData_61;
      outData_63 <= inData_63;
    end
  end

endmodule
