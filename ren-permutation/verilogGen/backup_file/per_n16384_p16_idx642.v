

module switch_2_2(
inData_0,
inData_1,
outData_0,
outData_1,
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input ctrl, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  
  wire [DATA_WIDTH-1:0] wireIn [1:0];              
  wire [DATA_WIDTH-1:0] wireOut [1:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  
  assign wireOut[0] = (!ctrl) ? wireIn[0] : wireIn[1];    
  assign wireOut[1] = (!ctrl) ? wireIn[1] : wireIn[0];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  
endmodule                        


module  block_ram_sp(
wen,                              
en,                              
clk,                             
addr,                            
din,                            
dout                             
);                               
  parameter DATA_WIDTH = 32;                                
  parameter ADDR_WIDTH = 10;                                
  parameter RAM_SIZE = 1 << ADDR_WIDTH;                                
  input wen, clk;                   
  input en;                              
  input [ADDR_WIDTH-1:0] addr;                        
  input [DATA_WIDTH-1:0] din;                        
  output reg [DATA_WIDTH-1:0] dout;        
  
  reg [DATA_WIDTH-1:0] ram[RAM_SIZE-1:0];        
  
  always@(posedge clk)             
  begin                            
    // synthesis attribute ram_style of ram is "block" 
  if(en) begin                    
      if(wen)                         
        ram[addr] <= din ;              
      dout <= ram[addr];              
  end
  end                             
  
endmodule                        


module  dist_ram_sp(
wen,                              
clk,                             
addr,                            
din,                            
dout                             
);                               
  parameter DATA_WIDTH = 32;                                
  parameter ADDR_WIDTH = 10;                                
  parameter RAM_SIZE = 1 << ADDR_WIDTH;                                
  input wen, clk;                   
  input [ADDR_WIDTH-1:0] addr;                        
  input [DATA_WIDTH-1:0] din;                        
  output [DATA_WIDTH-1:0] dout;        
  
  reg [DATA_WIDTH-1:0] ram[RAM_SIZE-1:0];        
  
  always@(posedge clk)             
  begin                            
    // synthesis attribute ram_style of ram is "distributed" 
  if(wen)                         
      ram[addr] <= din ;              
  end                             
 
  assign dout = ram[addr];         
  
endmodule                        


module  block_ram_dp(
wen,                              
en,                              
clk,                             
addr_r,                            
addr_w,                            
din,                            
dout                             
);                               
  parameter DATA_WIDTH = 32;                                
  parameter ADDR_WIDTH = 10;                                
  parameter RAM_SIZE = 1 << ADDR_WIDTH;                                
  input wen, clk;                   
  input en;                              
  input [ADDR_WIDTH-1:0] addr_r;                        
  input [ADDR_WIDTH-1:0] addr_w;                        
  input [DATA_WIDTH-1:0] din;                        
  output reg [DATA_WIDTH-1:0] dout;        
  
  reg [DATA_WIDTH-1:0] ram[RAM_SIZE-1:0];        
  
  always@(posedge clk)             
  begin                            
    // synthesis attribute ram_style of ram is "block" 
  if(en) begin                    
      if(wen)                         
        ram[addr_w] <= din ;              
      dout <= ram[addr_r];              
  end
  end                             
  
endmodule                        


module  dist_ram_dp(
wen,                              
clk,                             
addr_r,                            
addr_w,                            
din,                            
dout                             
);                               
  parameter DATA_WIDTH = 32;                                
  parameter ADDR_WIDTH = 10;                                
  parameter RAM_SIZE = 1 << ADDR_WIDTH;                                
  input wen, clk;                   
  input [ADDR_WIDTH-1:0] addr_r;                        
  input [ADDR_WIDTH-1:0] addr_w;                        
  input [DATA_WIDTH-1:0] din;                        
  output [DATA_WIDTH-1:0] dout;        
  
  reg [DATA_WIDTH-1:0] ram[RAM_SIZE-1:0];        
  
  always@(posedge clk)             
  begin                            
    // synthesis attribute ram_style of ram is "distributed" 
  if(wen)                         
      ram[addr_w] <= din ;              
  end                             
 
  assign dout = ram[addr_r];         
  
endmodule                        


module switches_stage_st0_642_L(
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
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [8-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_2(.inData_0(wireIn[4]), .inData_1(wireIn[5]), .outData_0(wireOut[4]), .outData_1(wireOut[5]), .ctrl(ctrl[2]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_3(.inData_0(wireIn[6]), .inData_1(wireIn[7]), .outData_0(wireOut[6]), .outData_1(wireOut[7]), .ctrl(ctrl[3]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_4(.inData_0(wireIn[8]), .inData_1(wireIn[9]), .outData_0(wireOut[8]), .outData_1(wireOut[9]), .ctrl(ctrl[4]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_5(.inData_0(wireIn[10]), .inData_1(wireIn[11]), .outData_0(wireOut[10]), .outData_1(wireOut[11]), .ctrl(ctrl[5]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_6(.inData_0(wireIn[12]), .inData_1(wireIn[13]), .outData_0(wireOut[12]), .outData_1(wireOut[13]), .ctrl(ctrl[6]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_7(.inData_0(wireIn[14]), .inData_1(wireIn[15]), .outData_0(wireOut[14]), .outData_1(wireOut[15]), .ctrl(ctrl[7]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp16_st0_L(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[8];    
  assign wireOut[2] = wireIn[1];    
  assign wireOut[3] = wireIn[9];    
  assign wireOut[4] = wireIn[2];    
  assign wireOut[5] = wireIn[10];    
  assign wireOut[6] = wireIn[3];    
  assign wireOut[7] = wireIn[11];    
  assign wireOut[8] = wireIn[4];    
  assign wireOut[9] = wireIn[12];    
  assign wireOut[10] = wireIn[5];    
  assign wireOut[11] = wireIn[13];    
  assign wireOut[12] = wireIn[6];    
  assign wireOut[13] = wireIn[14];    
  assign wireOut[14] = wireIn[7];    
  assign wireOut[15] = wireIn[15];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module switches_stage_st1_642_L(
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
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [8-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_2(.inData_0(wireIn[4]), .inData_1(wireIn[5]), .outData_0(wireOut[4]), .outData_1(wireOut[5]), .ctrl(ctrl[2]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_3(.inData_0(wireIn[6]), .inData_1(wireIn[7]), .outData_0(wireOut[6]), .outData_1(wireOut[7]), .ctrl(ctrl[3]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_4(.inData_0(wireIn[8]), .inData_1(wireIn[9]), .outData_0(wireOut[8]), .outData_1(wireOut[9]), .ctrl(ctrl[4]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_5(.inData_0(wireIn[10]), .inData_1(wireIn[11]), .outData_0(wireOut[10]), .outData_1(wireOut[11]), .ctrl(ctrl[5]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_6(.inData_0(wireIn[12]), .inData_1(wireIn[13]), .outData_0(wireOut[12]), .outData_1(wireOut[13]), .ctrl(ctrl[6]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_7(.inData_0(wireIn[14]), .inData_1(wireIn[15]), .outData_0(wireOut[14]), .outData_1(wireOut[15]), .ctrl(ctrl[7]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp16_st1_L(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[4];    
  assign wireOut[2] = wireIn[1];    
  assign wireOut[3] = wireIn[5];    
  assign wireOut[4] = wireIn[2];    
  assign wireOut[5] = wireIn[6];    
  assign wireOut[6] = wireIn[3];    
  assign wireOut[7] = wireIn[7];    
  assign wireOut[8] = wireIn[8];    
  assign wireOut[9] = wireIn[12];    
  assign wireOut[10] = wireIn[9];    
  assign wireOut[11] = wireIn[13];    
  assign wireOut[12] = wireIn[10];    
  assign wireOut[13] = wireIn[14];    
  assign wireOut[14] = wireIn[11];    
  assign wireOut[15] = wireIn[15];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module switches_stage_st2_642_L(
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
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [8-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_2(.inData_0(wireIn[4]), .inData_1(wireIn[5]), .outData_0(wireOut[4]), .outData_1(wireOut[5]), .ctrl(ctrl[2]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_3(.inData_0(wireIn[6]), .inData_1(wireIn[7]), .outData_0(wireOut[6]), .outData_1(wireOut[7]), .ctrl(ctrl[3]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_4(.inData_0(wireIn[8]), .inData_1(wireIn[9]), .outData_0(wireOut[8]), .outData_1(wireOut[9]), .ctrl(ctrl[4]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_5(.inData_0(wireIn[10]), .inData_1(wireIn[11]), .outData_0(wireOut[10]), .outData_1(wireOut[11]), .ctrl(ctrl[5]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_6(.inData_0(wireIn[12]), .inData_1(wireIn[13]), .outData_0(wireOut[12]), .outData_1(wireOut[13]), .ctrl(ctrl[6]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_7(.inData_0(wireIn[14]), .inData_1(wireIn[15]), .outData_0(wireOut[14]), .outData_1(wireOut[15]), .ctrl(ctrl[7]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp16_st2_L(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[2];    
  assign wireOut[2] = wireIn[1];    
  assign wireOut[3] = wireIn[3];    
  assign wireOut[4] = wireIn[4];    
  assign wireOut[5] = wireIn[6];    
  assign wireOut[6] = wireIn[5];    
  assign wireOut[7] = wireIn[7];    
  assign wireOut[8] = wireIn[8];    
  assign wireOut[9] = wireIn[10];    
  assign wireOut[10] = wireIn[9];    
  assign wireOut[11] = wireIn[11];    
  assign wireOut[12] = wireIn[12];    
  assign wireOut[13] = wireIn[14];    
  assign wireOut[14] = wireIn[13];    
  assign wireOut[15] = wireIn[15];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module switches_stage_st3_642_L(
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
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [8-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_2(.inData_0(wireIn[4]), .inData_1(wireIn[5]), .outData_0(wireOut[4]), .outData_1(wireOut[5]), .ctrl(ctrl[2]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_3(.inData_0(wireIn[6]), .inData_1(wireIn[7]), .outData_0(wireOut[6]), .outData_1(wireOut[7]), .ctrl(ctrl[3]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_4(.inData_0(wireIn[8]), .inData_1(wireIn[9]), .outData_0(wireOut[8]), .outData_1(wireOut[9]), .ctrl(ctrl[4]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_5(.inData_0(wireIn[10]), .inData_1(wireIn[11]), .outData_0(wireOut[10]), .outData_1(wireOut[11]), .ctrl(ctrl[5]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_6(.inData_0(wireIn[12]), .inData_1(wireIn[13]), .outData_0(wireOut[12]), .outData_1(wireOut[13]), .ctrl(ctrl[6]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_7(.inData_0(wireIn[14]), .inData_1(wireIn[15]), .outData_0(wireOut[14]), .outData_1(wireOut[15]), .ctrl(ctrl[7]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp16_st3_L(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[1];    
  assign wireOut[2] = wireIn[2];    
  assign wireOut[3] = wireIn[3];    
  assign wireOut[4] = wireIn[4];    
  assign wireOut[5] = wireIn[5];    
  assign wireOut[6] = wireIn[6];    
  assign wireOut[7] = wireIn[7];    
  assign wireOut[8] = wireIn[8];    
  assign wireOut[9] = wireIn[9];    
  assign wireOut[10] = wireIn[10];    
  assign wireOut[11] = wireIn[11];    
  assign wireOut[12] = wireIn[12];    
  assign wireOut[13] = wireIn[13];    
  assign wireOut[14] = wireIn[14];    
  assign wireOut[15] = wireIn[15];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module ingressStage_p16(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15;
  output out_start; 
  
  
  wire out_start_w; 
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  wire in_start_stage0;
  wire con_in_start_stage0;

  wire in_start_stage1;
  wire con_in_start_stage1;

  wire in_start_stage2;
  wire con_in_start_stage2;

  wire in_start_stage3;
  wire con_in_start_stage3;

  wire [DATA_WIDTH-1:0] wire_con_in_stage0[15:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage0[15:0];
  wire [7:0] wire_ctrl_stage0;

  switches_stage_st0_642_L switch_stage_0(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), .inData_4(wireIn[4]), .inData_5(wireIn[5]), .inData_6(wireIn[6]), .inData_7(wireIn[7]), .inData_8(wireIn[8]), .inData_9(wireIn[9]), .inData_10(wireIn[10]), .inData_11(wireIn[11]), .inData_12(wireIn[12]), .inData_13(wireIn[13]), .inData_14(wireIn[14]), .inData_15(wireIn[15]), 
        .outData_0(wire_con_in_stage0[0]), .outData_1(wire_con_in_stage0[1]), .outData_2(wire_con_in_stage0[2]), .outData_3(wire_con_in_stage0[3]), .outData_4(wire_con_in_stage0[4]), .outData_5(wire_con_in_stage0[5]), .outData_6(wire_con_in_stage0[6]), .outData_7(wire_con_in_stage0[7]), .outData_8(wire_con_in_stage0[8]), .outData_9(wire_con_in_stage0[9]), .outData_10(wire_con_in_stage0[10]), .outData_11(wire_con_in_stage0[11]), .outData_12(wire_con_in_stage0[12]), .outData_13(wire_con_in_stage0[13]), .outData_14(wire_con_in_stage0[14]), .outData_15(wire_con_in_stage0[15]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp16_st0_L wire_stage_0(
        .inData_0(wire_con_in_stage0[0]), .inData_1(wire_con_in_stage0[1]), .inData_2(wire_con_in_stage0[2]), .inData_3(wire_con_in_stage0[3]), .inData_4(wire_con_in_stage0[4]), .inData_5(wire_con_in_stage0[5]), .inData_6(wire_con_in_stage0[6]), .inData_7(wire_con_in_stage0[7]), .inData_8(wire_con_in_stage0[8]), .inData_9(wire_con_in_stage0[9]), .inData_10(wire_con_in_stage0[10]), .inData_11(wire_con_in_stage0[11]), .inData_12(wire_con_in_stage0[12]), .inData_13(wire_con_in_stage0[13]), .inData_14(wire_con_in_stage0[14]), .inData_15(wire_con_in_stage0[15]), 
        .outData_0(wire_con_out_stage0[0]), .outData_1(wire_con_out_stage0[1]), .outData_2(wire_con_out_stage0[2]), .outData_3(wire_con_out_stage0[3]), .outData_4(wire_con_out_stage0[4]), .outData_5(wire_con_out_stage0[5]), .outData_6(wire_con_out_stage0[6]), .outData_7(wire_con_out_stage0[7]), .outData_8(wire_con_out_stage0[8]), .outData_9(wire_con_out_stage0[9]), .outData_10(wire_con_out_stage0[10]), .outData_11(wire_con_out_stage0[11]), .outData_12(wire_con_out_stage0[12]), .outData_13(wire_con_out_stage0[13]), .outData_14(wire_con_out_stage0[14]), .outData_15(wire_con_out_stage0[15]), 
        .in_start(con_in_start_stage0), .out_start(in_start_stage1), .clk(clk), .rst(rst)); 

  
  wire [9:0] counter_out_w;
  counter_1024 switch_ctrl(.in_start(in_start_stage0), .counter_out(counter_out_w), .clk(clk), .rst(rst));

  assign wire_ctrl_stage0[0] = counter_out_w[9]; 
  assign wire_ctrl_stage0[1] = counter_out_w[9]; 
  assign wire_ctrl_stage0[2] = counter_out_w[9]; 
  assign wire_ctrl_stage0[3] = counter_out_w[9]; 
  assign wire_ctrl_stage0[4] = counter_out_w[9]; 
  assign wire_ctrl_stage0[5] = counter_out_w[9]; 
  assign wire_ctrl_stage0[6] = counter_out_w[9]; 
  assign wire_ctrl_stage0[7] = counter_out_w[9]; 
  wire [DATA_WIDTH-1:0] wire_con_in_stage1[15:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage1[15:0];
  wire [7:0] wire_ctrl_stage1;

  switches_stage_st1_642_L switch_stage_1(
        .inData_0(wire_con_out_stage0[0]), .inData_1(wire_con_out_stage0[1]), .inData_2(wire_con_out_stage0[2]), .inData_3(wire_con_out_stage0[3]), .inData_4(wire_con_out_stage0[4]), .inData_5(wire_con_out_stage0[5]), .inData_6(wire_con_out_stage0[6]), .inData_7(wire_con_out_stage0[7]), .inData_8(wire_con_out_stage0[8]), .inData_9(wire_con_out_stage0[9]), .inData_10(wire_con_out_stage0[10]), .inData_11(wire_con_out_stage0[11]), .inData_12(wire_con_out_stage0[12]), .inData_13(wire_con_out_stage0[13]), .inData_14(wire_con_out_stage0[14]), .inData_15(wire_con_out_stage0[15]), 
        .outData_0(wire_con_in_stage1[0]), .outData_1(wire_con_in_stage1[1]), .outData_2(wire_con_in_stage1[2]), .outData_3(wire_con_in_stage1[3]), .outData_4(wire_con_in_stage1[4]), .outData_5(wire_con_in_stage1[5]), .outData_6(wire_con_in_stage1[6]), .outData_7(wire_con_in_stage1[7]), .outData_8(wire_con_in_stage1[8]), .outData_9(wire_con_in_stage1[9]), .outData_10(wire_con_in_stage1[10]), .outData_11(wire_con_in_stage1[11]), .outData_12(wire_con_in_stage1[12]), .outData_13(wire_con_in_stage1[13]), .outData_14(wire_con_in_stage1[14]), .outData_15(wire_con_in_stage1[15]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp16_st1_L wire_stage_1(
        .inData_0(wire_con_in_stage1[0]), .inData_1(wire_con_in_stage1[1]), .inData_2(wire_con_in_stage1[2]), .inData_3(wire_con_in_stage1[3]), .inData_4(wire_con_in_stage1[4]), .inData_5(wire_con_in_stage1[5]), .inData_6(wire_con_in_stage1[6]), .inData_7(wire_con_in_stage1[7]), .inData_8(wire_con_in_stage1[8]), .inData_9(wire_con_in_stage1[9]), .inData_10(wire_con_in_stage1[10]), .inData_11(wire_con_in_stage1[11]), .inData_12(wire_con_in_stage1[12]), .inData_13(wire_con_in_stage1[13]), .inData_14(wire_con_in_stage1[14]), .inData_15(wire_con_in_stage1[15]), 
        .outData_0(wire_con_out_stage1[0]), .outData_1(wire_con_out_stage1[1]), .outData_2(wire_con_out_stage1[2]), .outData_3(wire_con_out_stage1[3]), .outData_4(wire_con_out_stage1[4]), .outData_5(wire_con_out_stage1[5]), .outData_6(wire_con_out_stage1[6]), .outData_7(wire_con_out_stage1[7]), .outData_8(wire_con_out_stage1[8]), .outData_9(wire_con_out_stage1[9]), .outData_10(wire_con_out_stage1[10]), .outData_11(wire_con_out_stage1[11]), .outData_12(wire_con_out_stage1[12]), .outData_13(wire_con_out_stage1[13]), .outData_14(wire_con_out_stage1[14]), .outData_15(wire_con_out_stage1[15]), 
        .in_start(con_in_start_stage1), .out_start(in_start_stage2), .clk(clk), .rst(rst)); 

  
  assign wire_ctrl_stage1[0] = counter_out_w[8]; 
  assign wire_ctrl_stage1[1] = counter_out_w[8]; 
  assign wire_ctrl_stage1[2] = counter_out_w[8]; 
  assign wire_ctrl_stage1[3] = counter_out_w[8]; 
  assign wire_ctrl_stage1[4] = counter_out_w[8]; 
  assign wire_ctrl_stage1[5] = counter_out_w[8]; 
  assign wire_ctrl_stage1[6] = counter_out_w[8]; 
  assign wire_ctrl_stage1[7] = counter_out_w[8]; 
  wire [DATA_WIDTH-1:0] wire_con_in_stage2[15:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage2[15:0];
  wire [7:0] wire_ctrl_stage2;

  switches_stage_st2_642_L switch_stage_2(
        .inData_0(wire_con_out_stage1[0]), .inData_1(wire_con_out_stage1[1]), .inData_2(wire_con_out_stage1[2]), .inData_3(wire_con_out_stage1[3]), .inData_4(wire_con_out_stage1[4]), .inData_5(wire_con_out_stage1[5]), .inData_6(wire_con_out_stage1[6]), .inData_7(wire_con_out_stage1[7]), .inData_8(wire_con_out_stage1[8]), .inData_9(wire_con_out_stage1[9]), .inData_10(wire_con_out_stage1[10]), .inData_11(wire_con_out_stage1[11]), .inData_12(wire_con_out_stage1[12]), .inData_13(wire_con_out_stage1[13]), .inData_14(wire_con_out_stage1[14]), .inData_15(wire_con_out_stage1[15]), 
        .outData_0(wire_con_in_stage2[0]), .outData_1(wire_con_in_stage2[1]), .outData_2(wire_con_in_stage2[2]), .outData_3(wire_con_in_stage2[3]), .outData_4(wire_con_in_stage2[4]), .outData_5(wire_con_in_stage2[5]), .outData_6(wire_con_in_stage2[6]), .outData_7(wire_con_in_stage2[7]), .outData_8(wire_con_in_stage2[8]), .outData_9(wire_con_in_stage2[9]), .outData_10(wire_con_in_stage2[10]), .outData_11(wire_con_in_stage2[11]), .outData_12(wire_con_in_stage2[12]), .outData_13(wire_con_in_stage2[13]), .outData_14(wire_con_in_stage2[14]), .outData_15(wire_con_in_stage2[15]), 
        .in_start(in_start_stage2), .out_start(con_in_start_stage2), .ctrl(wire_ctrl_stage2), .clk(clk), .rst(rst));
  
  wireCon_dp16_st2_L wire_stage_2(
        .inData_0(wire_con_in_stage2[0]), .inData_1(wire_con_in_stage2[1]), .inData_2(wire_con_in_stage2[2]), .inData_3(wire_con_in_stage2[3]), .inData_4(wire_con_in_stage2[4]), .inData_5(wire_con_in_stage2[5]), .inData_6(wire_con_in_stage2[6]), .inData_7(wire_con_in_stage2[7]), .inData_8(wire_con_in_stage2[8]), .inData_9(wire_con_in_stage2[9]), .inData_10(wire_con_in_stage2[10]), .inData_11(wire_con_in_stage2[11]), .inData_12(wire_con_in_stage2[12]), .inData_13(wire_con_in_stage2[13]), .inData_14(wire_con_in_stage2[14]), .inData_15(wire_con_in_stage2[15]), 
        .outData_0(wire_con_out_stage2[0]), .outData_1(wire_con_out_stage2[1]), .outData_2(wire_con_out_stage2[2]), .outData_3(wire_con_out_stage2[3]), .outData_4(wire_con_out_stage2[4]), .outData_5(wire_con_out_stage2[5]), .outData_6(wire_con_out_stage2[6]), .outData_7(wire_con_out_stage2[7]), .outData_8(wire_con_out_stage2[8]), .outData_9(wire_con_out_stage2[9]), .outData_10(wire_con_out_stage2[10]), .outData_11(wire_con_out_stage2[11]), .outData_12(wire_con_out_stage2[12]), .outData_13(wire_con_out_stage2[13]), .outData_14(wire_con_out_stage2[14]), .outData_15(wire_con_out_stage2[15]), 
        .in_start(con_in_start_stage2), .out_start(in_start_stage3), .clk(clk), .rst(rst)); 

  
  assign wire_ctrl_stage2[0] = counter_out_w[7]; 
  assign wire_ctrl_stage2[1] = counter_out_w[7]; 
  assign wire_ctrl_stage2[2] = counter_out_w[7]; 
  assign wire_ctrl_stage2[3] = counter_out_w[7]; 
  assign wire_ctrl_stage2[4] = counter_out_w[7]; 
  assign wire_ctrl_stage2[5] = counter_out_w[7]; 
  assign wire_ctrl_stage2[6] = counter_out_w[7]; 
  assign wire_ctrl_stage2[7] = counter_out_w[7]; 
  wire [DATA_WIDTH-1:0] wire_con_in_stage3[15:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage3[15:0];
  wire [7:0] wire_ctrl_stage3;

  switches_stage_st3_642_L switch_stage_3(
        .inData_0(wire_con_out_stage2[0]), .inData_1(wire_con_out_stage2[1]), .inData_2(wire_con_out_stage2[2]), .inData_3(wire_con_out_stage2[3]), .inData_4(wire_con_out_stage2[4]), .inData_5(wire_con_out_stage2[5]), .inData_6(wire_con_out_stage2[6]), .inData_7(wire_con_out_stage2[7]), .inData_8(wire_con_out_stage2[8]), .inData_9(wire_con_out_stage2[9]), .inData_10(wire_con_out_stage2[10]), .inData_11(wire_con_out_stage2[11]), .inData_12(wire_con_out_stage2[12]), .inData_13(wire_con_out_stage2[13]), .inData_14(wire_con_out_stage2[14]), .inData_15(wire_con_out_stage2[15]), 
        .outData_0(wire_con_in_stage3[0]), .outData_1(wire_con_in_stage3[1]), .outData_2(wire_con_in_stage3[2]), .outData_3(wire_con_in_stage3[3]), .outData_4(wire_con_in_stage3[4]), .outData_5(wire_con_in_stage3[5]), .outData_6(wire_con_in_stage3[6]), .outData_7(wire_con_in_stage3[7]), .outData_8(wire_con_in_stage3[8]), .outData_9(wire_con_in_stage3[9]), .outData_10(wire_con_in_stage3[10]), .outData_11(wire_con_in_stage3[11]), .outData_12(wire_con_in_stage3[12]), .outData_13(wire_con_in_stage3[13]), .outData_14(wire_con_in_stage3[14]), .outData_15(wire_con_in_stage3[15]), 
        .in_start(in_start_stage3), .out_start(con_in_start_stage3), .ctrl(wire_ctrl_stage3), .clk(clk), .rst(rst));
  
  wireCon_dp16_st3_L wire_stage_3(
        .inData_0(wire_con_in_stage3[0]), .inData_1(wire_con_in_stage3[1]), .inData_2(wire_con_in_stage3[2]), .inData_3(wire_con_in_stage3[3]), .inData_4(wire_con_in_stage3[4]), .inData_5(wire_con_in_stage3[5]), .inData_6(wire_con_in_stage3[6]), .inData_7(wire_con_in_stage3[7]), .inData_8(wire_con_in_stage3[8]), .inData_9(wire_con_in_stage3[9]), .inData_10(wire_con_in_stage3[10]), .inData_11(wire_con_in_stage3[11]), .inData_12(wire_con_in_stage3[12]), .inData_13(wire_con_in_stage3[13]), .inData_14(wire_con_in_stage3[14]), .inData_15(wire_con_in_stage3[15]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), .outData_4(wireOut[4]), .outData_5(wireOut[5]), .outData_6(wireOut[6]), .outData_7(wireOut[7]), .outData_8(wireOut[8]), .outData_9(wireOut[9]), .outData_10(wireOut[10]), .outData_11(wireOut[11]), .outData_12(wireOut[12]), .outData_13(wireOut[13]), .outData_14(wireOut[14]), .outData_15(wireOut[15]), 
        .in_start(con_in_start_stage3), .out_start(out_start_w), .clk(clk), .rst(rst)); 

  
  assign wire_ctrl_stage3[0] = counter_out_w[6]; 
  assign wire_ctrl_stage3[1] = counter_out_w[6]; 
  assign wire_ctrl_stage3[2] = counter_out_w[6]; 
  assign wire_ctrl_stage3[3] = counter_out_w[6]; 
  assign wire_ctrl_stage3[4] = counter_out_w[6]; 
  assign wire_ctrl_stage3[5] = counter_out_w[6]; 
  assign wire_ctrl_stage3[6] = counter_out_w[6]; 
  assign wire_ctrl_stage3[7] = counter_out_w[6]; 
  
  assign in_start_stage0 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = out_start_w;    
  
endmodule                        


module switches_stage_st0_642_R(
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
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [8-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_2(.inData_0(wireIn[4]), .inData_1(wireIn[5]), .outData_0(wireOut[4]), .outData_1(wireOut[5]), .ctrl(ctrl[2]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_3(.inData_0(wireIn[6]), .inData_1(wireIn[7]), .outData_0(wireOut[6]), .outData_1(wireOut[7]), .ctrl(ctrl[3]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_4(.inData_0(wireIn[8]), .inData_1(wireIn[9]), .outData_0(wireOut[8]), .outData_1(wireOut[9]), .ctrl(ctrl[4]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_5(.inData_0(wireIn[10]), .inData_1(wireIn[11]), .outData_0(wireOut[10]), .outData_1(wireOut[11]), .ctrl(ctrl[5]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_6(.inData_0(wireIn[12]), .inData_1(wireIn[13]), .outData_0(wireOut[12]), .outData_1(wireOut[13]), .ctrl(ctrl[6]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_7(.inData_0(wireIn[14]), .inData_1(wireIn[15]), .outData_0(wireOut[14]), .outData_1(wireOut[15]), .ctrl(ctrl[7]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp16_st0_R(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[2];    
  assign wireOut[2] = wireIn[4];    
  assign wireOut[3] = wireIn[6];    
  assign wireOut[4] = wireIn[8];    
  assign wireOut[5] = wireIn[10];    
  assign wireOut[6] = wireIn[12];    
  assign wireOut[7] = wireIn[14];    
  assign wireOut[8] = wireIn[1];    
  assign wireOut[9] = wireIn[3];    
  assign wireOut[10] = wireIn[5];    
  assign wireOut[11] = wireIn[7];    
  assign wireOut[12] = wireIn[9];    
  assign wireOut[13] = wireIn[11];    
  assign wireOut[14] = wireIn[13];    
  assign wireOut[15] = wireIn[15];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module switches_stage_st1_642_R(
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
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [8-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_2(.inData_0(wireIn[4]), .inData_1(wireIn[5]), .outData_0(wireOut[4]), .outData_1(wireOut[5]), .ctrl(ctrl[2]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_3(.inData_0(wireIn[6]), .inData_1(wireIn[7]), .outData_0(wireOut[6]), .outData_1(wireOut[7]), .ctrl(ctrl[3]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_4(.inData_0(wireIn[8]), .inData_1(wireIn[9]), .outData_0(wireOut[8]), .outData_1(wireOut[9]), .ctrl(ctrl[4]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_5(.inData_0(wireIn[10]), .inData_1(wireIn[11]), .outData_0(wireOut[10]), .outData_1(wireOut[11]), .ctrl(ctrl[5]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_6(.inData_0(wireIn[12]), .inData_1(wireIn[13]), .outData_0(wireOut[12]), .outData_1(wireOut[13]), .ctrl(ctrl[6]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_7(.inData_0(wireIn[14]), .inData_1(wireIn[15]), .outData_0(wireOut[14]), .outData_1(wireOut[15]), .ctrl(ctrl[7]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp16_st1_R(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[2];    
  assign wireOut[2] = wireIn[4];    
  assign wireOut[3] = wireIn[6];    
  assign wireOut[4] = wireIn[1];    
  assign wireOut[5] = wireIn[3];    
  assign wireOut[6] = wireIn[5];    
  assign wireOut[7] = wireIn[7];    
  assign wireOut[8] = wireIn[8];    
  assign wireOut[9] = wireIn[10];    
  assign wireOut[10] = wireIn[12];    
  assign wireOut[11] = wireIn[14];    
  assign wireOut[12] = wireIn[9];    
  assign wireOut[13] = wireIn[11];    
  assign wireOut[14] = wireIn[13];    
  assign wireOut[15] = wireIn[15];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module switches_stage_st2_642_R(
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
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [8-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_2(.inData_0(wireIn[4]), .inData_1(wireIn[5]), .outData_0(wireOut[4]), .outData_1(wireOut[5]), .ctrl(ctrl[2]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_3(.inData_0(wireIn[6]), .inData_1(wireIn[7]), .outData_0(wireOut[6]), .outData_1(wireOut[7]), .ctrl(ctrl[3]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_4(.inData_0(wireIn[8]), .inData_1(wireIn[9]), .outData_0(wireOut[8]), .outData_1(wireOut[9]), .ctrl(ctrl[4]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_5(.inData_0(wireIn[10]), .inData_1(wireIn[11]), .outData_0(wireOut[10]), .outData_1(wireOut[11]), .ctrl(ctrl[5]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_6(.inData_0(wireIn[12]), .inData_1(wireIn[13]), .outData_0(wireOut[12]), .outData_1(wireOut[13]), .ctrl(ctrl[6]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_7(.inData_0(wireIn[14]), .inData_1(wireIn[15]), .outData_0(wireOut[14]), .outData_1(wireOut[15]), .ctrl(ctrl[7]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp16_st2_R(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[2];    
  assign wireOut[2] = wireIn[1];    
  assign wireOut[3] = wireIn[3];    
  assign wireOut[4] = wireIn[4];    
  assign wireOut[5] = wireIn[6];    
  assign wireOut[6] = wireIn[5];    
  assign wireOut[7] = wireIn[7];    
  assign wireOut[8] = wireIn[8];    
  assign wireOut[9] = wireIn[10];    
  assign wireOut[10] = wireIn[9];    
  assign wireOut[11] = wireIn[11];    
  assign wireOut[12] = wireIn[12];    
  assign wireOut[13] = wireIn[14];    
  assign wireOut[14] = wireIn[13];    
  assign wireOut[15] = wireIn[15];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module switches_stage_st3_642_R(
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
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [8-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_2(.inData_0(wireIn[4]), .inData_1(wireIn[5]), .outData_0(wireOut[4]), .outData_1(wireOut[5]), .ctrl(ctrl[2]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_3(.inData_0(wireIn[6]), .inData_1(wireIn[7]), .outData_0(wireOut[6]), .outData_1(wireOut[7]), .ctrl(ctrl[3]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_4(.inData_0(wireIn[8]), .inData_1(wireIn[9]), .outData_0(wireOut[8]), .outData_1(wireOut[9]), .ctrl(ctrl[4]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_5(.inData_0(wireIn[10]), .inData_1(wireIn[11]), .outData_0(wireOut[10]), .outData_1(wireOut[11]), .ctrl(ctrl[5]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_6(.inData_0(wireIn[12]), .inData_1(wireIn[13]), .outData_0(wireOut[12]), .outData_1(wireOut[13]), .ctrl(ctrl[6]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_7(.inData_0(wireIn[14]), .inData_1(wireIn[15]), .outData_0(wireOut[14]), .outData_1(wireOut[15]), .ctrl(ctrl[7]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp16_st3_R(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[1];    
  assign wireOut[2] = wireIn[2];    
  assign wireOut[3] = wireIn[3];    
  assign wireOut[4] = wireIn[4];    
  assign wireOut[5] = wireIn[5];    
  assign wireOut[6] = wireIn[6];    
  assign wireOut[7] = wireIn[7];    
  assign wireOut[8] = wireIn[8];    
  assign wireOut[9] = wireIn[9];    
  assign wireOut[10] = wireIn[10];    
  assign wireOut[11] = wireIn[11];    
  assign wireOut[12] = wireIn[12];    
  assign wireOut[13] = wireIn[13];    
  assign wireOut[14] = wireIn[14];    
  assign wireOut[15] = wireIn[15];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = in_start;    
  
endmodule                        


module egressStage_p16(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15;
  output out_start; 
  
  
  wire out_start_w; 
  wire [DATA_WIDTH-1:0] wireIn [15:0];              
  wire [DATA_WIDTH-1:0] wireOut [15:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  wire in_start_stage3;
  wire con_in_start_stage3;

  wire in_start_stage2;
  wire con_in_start_stage2;

  wire in_start_stage1;
  wire con_in_start_stage1;

  wire in_start_stage0;
  wire con_in_start_stage0;

  wire [DATA_WIDTH-1:0] wire_switch_in_stage3[15:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage3[15:0];
  wire [7:0] wire_ctrl_stage3;

  switches_stage_st3_642_R switch_stage_3(
        .inData_0(wire_switch_in_stage3[0]), .inData_1(wire_switch_in_stage3[1]), .inData_2(wire_switch_in_stage3[2]), .inData_3(wire_switch_in_stage3[3]), .inData_4(wire_switch_in_stage3[4]), .inData_5(wire_switch_in_stage3[5]), .inData_6(wire_switch_in_stage3[6]), .inData_7(wire_switch_in_stage3[7]), .inData_8(wire_switch_in_stage3[8]), .inData_9(wire_switch_in_stage3[9]), .inData_10(wire_switch_in_stage3[10]), .inData_11(wire_switch_in_stage3[11]), .inData_12(wire_switch_in_stage3[12]), .inData_13(wire_switch_in_stage3[13]), .inData_14(wire_switch_in_stage3[14]), .inData_15(wire_switch_in_stage3[15]), 
        .outData_0(wire_switch_out_stage3[0]), .outData_1(wire_switch_out_stage3[1]), .outData_2(wire_switch_out_stage3[2]), .outData_3(wire_switch_out_stage3[3]), .outData_4(wire_switch_out_stage3[4]), .outData_5(wire_switch_out_stage3[5]), .outData_6(wire_switch_out_stage3[6]), .outData_7(wire_switch_out_stage3[7]), .outData_8(wire_switch_out_stage3[8]), .outData_9(wire_switch_out_stage3[9]), .outData_10(wire_switch_out_stage3[10]), .outData_11(wire_switch_out_stage3[11]), .outData_12(wire_switch_out_stage3[12]), .outData_13(wire_switch_out_stage3[13]), .outData_14(wire_switch_out_stage3[14]), .outData_15(wire_switch_out_stage3[15]), 
        .in_start(con_in_start_stage3), .out_start(in_start_stage2), .ctrl(wire_ctrl_stage3), .clk(clk), .rst(rst));
  
  wireCon_dp16_st3_R wire_stage_3(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), .inData_4(wireIn[4]), .inData_5(wireIn[5]), .inData_6(wireIn[6]), .inData_7(wireIn[7]), .inData_8(wireIn[8]), .inData_9(wireIn[9]), .inData_10(wireIn[10]), .inData_11(wireIn[11]), .inData_12(wireIn[12]), .inData_13(wireIn[13]), .inData_14(wireIn[14]), .inData_15(wireIn[15]), 
        .outData_0(wire_switch_in_stage3[0]), .outData_1(wire_switch_in_stage3[1]), .outData_2(wire_switch_in_stage3[2]), .outData_3(wire_switch_in_stage3[3]), .outData_4(wire_switch_in_stage3[4]), .outData_5(wire_switch_in_stage3[5]), .outData_6(wire_switch_in_stage3[6]), .outData_7(wire_switch_in_stage3[7]), .outData_8(wire_switch_in_stage3[8]), .outData_9(wire_switch_in_stage3[9]), .outData_10(wire_switch_in_stage3[10]), .outData_11(wire_switch_in_stage3[11]), .outData_12(wire_switch_in_stage3[12]), .outData_13(wire_switch_in_stage3[13]), .outData_14(wire_switch_in_stage3[14]), .outData_15(wire_switch_in_stage3[15]), 
        .in_start(in_start_stage3), .out_start(con_in_start_stage3), .clk(clk), .rst(rst)); 

  
  wire [9:0] counter_out_w;
  counter_1024 switch_ctrl(.in_start(in_start_stage3), .counter_out(counter_out_w), .clk(clk), .rst(rst));

  assign wire_ctrl_stage3[0] = counter_out_w[6]; 
  assign wire_ctrl_stage3[1] = counter_out_w[6]; 
  assign wire_ctrl_stage3[2] = counter_out_w[6]; 
  assign wire_ctrl_stage3[3] = counter_out_w[6]; 
  assign wire_ctrl_stage3[4] = counter_out_w[6]; 
  assign wire_ctrl_stage3[5] = counter_out_w[6]; 
  assign wire_ctrl_stage3[6] = counter_out_w[6]; 
  assign wire_ctrl_stage3[7] = counter_out_w[6]; 
  wire [DATA_WIDTH-1:0] wire_switch_in_stage2[15:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage2[15:0];
  wire [7:0] wire_ctrl_stage2;

  switches_stage_st2_642_R switch_stage_2(
        .inData_0(wire_switch_in_stage2[0]), .inData_1(wire_switch_in_stage2[1]), .inData_2(wire_switch_in_stage2[2]), .inData_3(wire_switch_in_stage2[3]), .inData_4(wire_switch_in_stage2[4]), .inData_5(wire_switch_in_stage2[5]), .inData_6(wire_switch_in_stage2[6]), .inData_7(wire_switch_in_stage2[7]), .inData_8(wire_switch_in_stage2[8]), .inData_9(wire_switch_in_stage2[9]), .inData_10(wire_switch_in_stage2[10]), .inData_11(wire_switch_in_stage2[11]), .inData_12(wire_switch_in_stage2[12]), .inData_13(wire_switch_in_stage2[13]), .inData_14(wire_switch_in_stage2[14]), .inData_15(wire_switch_in_stage2[15]), 
        .outData_0(wire_switch_out_stage2[0]), .outData_1(wire_switch_out_stage2[1]), .outData_2(wire_switch_out_stage2[2]), .outData_3(wire_switch_out_stage2[3]), .outData_4(wire_switch_out_stage2[4]), .outData_5(wire_switch_out_stage2[5]), .outData_6(wire_switch_out_stage2[6]), .outData_7(wire_switch_out_stage2[7]), .outData_8(wire_switch_out_stage2[8]), .outData_9(wire_switch_out_stage2[9]), .outData_10(wire_switch_out_stage2[10]), .outData_11(wire_switch_out_stage2[11]), .outData_12(wire_switch_out_stage2[12]), .outData_13(wire_switch_out_stage2[13]), .outData_14(wire_switch_out_stage2[14]), .outData_15(wire_switch_out_stage2[15]), 
        .in_start(con_in_start_stage2), .out_start(in_start_stage1), .ctrl(wire_ctrl_stage2), .clk(clk), .rst(rst));
  
  wireCon_dp16_st2_R wire_stage_2(
        .inData_0(wire_switch_out_stage3[0]), .inData_1(wire_switch_out_stage3[1]), .inData_2(wire_switch_out_stage3[2]), .inData_3(wire_switch_out_stage3[3]), .inData_4(wire_switch_out_stage3[4]), .inData_5(wire_switch_out_stage3[5]), .inData_6(wire_switch_out_stage3[6]), .inData_7(wire_switch_out_stage3[7]), .inData_8(wire_switch_out_stage3[8]), .inData_9(wire_switch_out_stage3[9]), .inData_10(wire_switch_out_stage3[10]), .inData_11(wire_switch_out_stage3[11]), .inData_12(wire_switch_out_stage3[12]), .inData_13(wire_switch_out_stage3[13]), .inData_14(wire_switch_out_stage3[14]), .inData_15(wire_switch_out_stage3[15]), 
        .outData_0(wire_switch_in_stage2[0]), .outData_1(wire_switch_in_stage2[1]), .outData_2(wire_switch_in_stage2[2]), .outData_3(wire_switch_in_stage2[3]), .outData_4(wire_switch_in_stage2[4]), .outData_5(wire_switch_in_stage2[5]), .outData_6(wire_switch_in_stage2[6]), .outData_7(wire_switch_in_stage2[7]), .outData_8(wire_switch_in_stage2[8]), .outData_9(wire_switch_in_stage2[9]), .outData_10(wire_switch_in_stage2[10]), .outData_11(wire_switch_in_stage2[11]), .outData_12(wire_switch_in_stage2[12]), .outData_13(wire_switch_in_stage2[13]), .outData_14(wire_switch_in_stage2[14]), .outData_15(wire_switch_in_stage2[15]), 
        .in_start(in_start_stage2), .out_start(con_in_start_stage2), .clk(clk), .rst(rst)); 

  
  assign wire_ctrl_stage2[0] = counter_out_w[7]; 
  assign wire_ctrl_stage2[1] = counter_out_w[7]; 
  assign wire_ctrl_stage2[2] = counter_out_w[7]; 
  assign wire_ctrl_stage2[3] = counter_out_w[7]; 
  assign wire_ctrl_stage2[4] = counter_out_w[7]; 
  assign wire_ctrl_stage2[5] = counter_out_w[7]; 
  assign wire_ctrl_stage2[6] = counter_out_w[7]; 
  assign wire_ctrl_stage2[7] = counter_out_w[7]; 
  wire [DATA_WIDTH-1:0] wire_switch_in_stage1[15:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage1[15:0];
  wire [7:0] wire_ctrl_stage1;

  switches_stage_st1_642_R switch_stage_1(
        .inData_0(wire_switch_in_stage1[0]), .inData_1(wire_switch_in_stage1[1]), .inData_2(wire_switch_in_stage1[2]), .inData_3(wire_switch_in_stage1[3]), .inData_4(wire_switch_in_stage1[4]), .inData_5(wire_switch_in_stage1[5]), .inData_6(wire_switch_in_stage1[6]), .inData_7(wire_switch_in_stage1[7]), .inData_8(wire_switch_in_stage1[8]), .inData_9(wire_switch_in_stage1[9]), .inData_10(wire_switch_in_stage1[10]), .inData_11(wire_switch_in_stage1[11]), .inData_12(wire_switch_in_stage1[12]), .inData_13(wire_switch_in_stage1[13]), .inData_14(wire_switch_in_stage1[14]), .inData_15(wire_switch_in_stage1[15]), 
        .outData_0(wire_switch_out_stage1[0]), .outData_1(wire_switch_out_stage1[1]), .outData_2(wire_switch_out_stage1[2]), .outData_3(wire_switch_out_stage1[3]), .outData_4(wire_switch_out_stage1[4]), .outData_5(wire_switch_out_stage1[5]), .outData_6(wire_switch_out_stage1[6]), .outData_7(wire_switch_out_stage1[7]), .outData_8(wire_switch_out_stage1[8]), .outData_9(wire_switch_out_stage1[9]), .outData_10(wire_switch_out_stage1[10]), .outData_11(wire_switch_out_stage1[11]), .outData_12(wire_switch_out_stage1[12]), .outData_13(wire_switch_out_stage1[13]), .outData_14(wire_switch_out_stage1[14]), .outData_15(wire_switch_out_stage1[15]), 
        .in_start(con_in_start_stage1), .out_start(in_start_stage0), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp16_st1_R wire_stage_1(
        .inData_0(wire_switch_out_stage2[0]), .inData_1(wire_switch_out_stage2[1]), .inData_2(wire_switch_out_stage2[2]), .inData_3(wire_switch_out_stage2[3]), .inData_4(wire_switch_out_stage2[4]), .inData_5(wire_switch_out_stage2[5]), .inData_6(wire_switch_out_stage2[6]), .inData_7(wire_switch_out_stage2[7]), .inData_8(wire_switch_out_stage2[8]), .inData_9(wire_switch_out_stage2[9]), .inData_10(wire_switch_out_stage2[10]), .inData_11(wire_switch_out_stage2[11]), .inData_12(wire_switch_out_stage2[12]), .inData_13(wire_switch_out_stage2[13]), .inData_14(wire_switch_out_stage2[14]), .inData_15(wire_switch_out_stage2[15]), 
        .outData_0(wire_switch_in_stage1[0]), .outData_1(wire_switch_in_stage1[1]), .outData_2(wire_switch_in_stage1[2]), .outData_3(wire_switch_in_stage1[3]), .outData_4(wire_switch_in_stage1[4]), .outData_5(wire_switch_in_stage1[5]), .outData_6(wire_switch_in_stage1[6]), .outData_7(wire_switch_in_stage1[7]), .outData_8(wire_switch_in_stage1[8]), .outData_9(wire_switch_in_stage1[9]), .outData_10(wire_switch_in_stage1[10]), .outData_11(wire_switch_in_stage1[11]), .outData_12(wire_switch_in_stage1[12]), .outData_13(wire_switch_in_stage1[13]), .outData_14(wire_switch_in_stage1[14]), .outData_15(wire_switch_in_stage1[15]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .clk(clk), .rst(rst)); 

  
  assign wire_ctrl_stage1[0] = counter_out_w[8]; 
  assign wire_ctrl_stage1[1] = counter_out_w[8]; 
  assign wire_ctrl_stage1[2] = counter_out_w[8]; 
  assign wire_ctrl_stage1[3] = counter_out_w[8]; 
  assign wire_ctrl_stage1[4] = counter_out_w[8]; 
  assign wire_ctrl_stage1[5] = counter_out_w[8]; 
  assign wire_ctrl_stage1[6] = counter_out_w[8]; 
  assign wire_ctrl_stage1[7] = counter_out_w[8]; 
  wire [DATA_WIDTH-1:0] wire_switch_in_stage0[15:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage0[15:0];
  wire [7:0] wire_ctrl_stage0;

  switches_stage_st0_642_R switch_stage_0(
        .inData_0(wire_switch_in_stage0[0]), .inData_1(wire_switch_in_stage0[1]), .inData_2(wire_switch_in_stage0[2]), .inData_3(wire_switch_in_stage0[3]), .inData_4(wire_switch_in_stage0[4]), .inData_5(wire_switch_in_stage0[5]), .inData_6(wire_switch_in_stage0[6]), .inData_7(wire_switch_in_stage0[7]), .inData_8(wire_switch_in_stage0[8]), .inData_9(wire_switch_in_stage0[9]), .inData_10(wire_switch_in_stage0[10]), .inData_11(wire_switch_in_stage0[11]), .inData_12(wire_switch_in_stage0[12]), .inData_13(wire_switch_in_stage0[13]), .inData_14(wire_switch_in_stage0[14]), .inData_15(wire_switch_in_stage0[15]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), .outData_4(wireOut[4]), .outData_5(wireOut[5]), .outData_6(wireOut[6]), .outData_7(wireOut[7]), .outData_8(wireOut[8]), .outData_9(wireOut[9]), .outData_10(wireOut[10]), .outData_11(wireOut[11]), .outData_12(wireOut[12]), .outData_13(wireOut[13]), .outData_14(wireOut[14]), .outData_15(wireOut[15]), 
        .in_start(con_in_start_stage0), .out_start(out_start_w), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp16_st0_R wire_stage_0(
        .inData_0(wire_switch_out_stage1[0]), .inData_1(wire_switch_out_stage1[1]), .inData_2(wire_switch_out_stage1[2]), .inData_3(wire_switch_out_stage1[3]), .inData_4(wire_switch_out_stage1[4]), .inData_5(wire_switch_out_stage1[5]), .inData_6(wire_switch_out_stage1[6]), .inData_7(wire_switch_out_stage1[7]), .inData_8(wire_switch_out_stage1[8]), .inData_9(wire_switch_out_stage1[9]), .inData_10(wire_switch_out_stage1[10]), .inData_11(wire_switch_out_stage1[11]), .inData_12(wire_switch_out_stage1[12]), .inData_13(wire_switch_out_stage1[13]), .inData_14(wire_switch_out_stage1[14]), .inData_15(wire_switch_out_stage1[15]), 
        .outData_0(wire_switch_in_stage0[0]), .outData_1(wire_switch_in_stage0[1]), .outData_2(wire_switch_in_stage0[2]), .outData_3(wire_switch_in_stage0[3]), .outData_4(wire_switch_in_stage0[4]), .outData_5(wire_switch_in_stage0[5]), .outData_6(wire_switch_in_stage0[6]), .outData_7(wire_switch_in_stage0[7]), .outData_8(wire_switch_in_stage0[8]), .outData_9(wire_switch_in_stage0[9]), .outData_10(wire_switch_in_stage0[10]), .outData_11(wire_switch_in_stage0[11]), .outData_12(wire_switch_in_stage0[12]), .outData_13(wire_switch_in_stage0[13]), .outData_14(wire_switch_in_stage0[14]), .outData_15(wire_switch_in_stage0[15]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .clk(clk), .rst(rst)); 

  
  assign wire_ctrl_stage0[0] = counter_out_w[9]; 
  assign wire_ctrl_stage0[1] = counter_out_w[9]; 
  assign wire_ctrl_stage0[2] = counter_out_w[9]; 
  assign wire_ctrl_stage0[3] = counter_out_w[9]; 
  assign wire_ctrl_stage0[4] = counter_out_w[9]; 
  assign wire_ctrl_stage0[5] = counter_out_w[9]; 
  assign wire_ctrl_stage0[6] = counter_out_w[9]; 
  assign wire_ctrl_stage0[7] = counter_out_w[9]; 
  
  assign in_start_stage3 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = out_start_w;    
  
endmodule                        


module  counter_1024(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [9:0] counter_out;            
  
  reg [9:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 10'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[9:0] == 1023) begin  
        status_couting <= 1'b0;                 
        counter_r <= 10'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  mem_addr_gen_dp16_mem0_per642(
counter_in,                              
clk,                             
rst,                             
addr_out                            
);                               
  input clk, rst;                           
  input [9:0] counter_in;      
  output [9:0] addr_out;      

  wire [3:0] word_counter_w [1:0];      
  wire [1:0] ms_word_low_w;      
  assign addr_out[3:0] = {word_counter_w[0][0],word_counter_w[0][1]};    
  assign addr_out[7:4] = {word_counter_w[1][0],word_counter_w[1][1]};    
  assign addr_out[9:8] = ms_word_low_w[1:0];   
  
  assign word_counter_w[0] = counter_in[9:6];  
  assign word_counter_w[1] = counter_in[3:0];  
  assign ms_word_low_w = counter_in[5:4]; 
  assign ms_word_high_w = counter_in[5:4]; 
    
endmodule                        


module  mem_addr_ctrl_dp16_per642(
in_start,                          
wen_out,                         
out_start,                         
mem_addr_out_0,                         
mem_addr_out_1,                         
mem_addr_out_2,                         
mem_addr_out_3,                         
mem_addr_out_4,                         
mem_addr_out_5,                         
mem_addr_out_6,                         
mem_addr_out_7,                         
mem_addr_out_8,                         
mem_addr_out_9,                         
mem_addr_out_10,                         
mem_addr_out_11,                         
mem_addr_out_12,                         
mem_addr_out_13,                         
mem_addr_out_14,                         
mem_addr_out_15,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [9:0] mem_addr_out_0;            
  output [9:0] mem_addr_out_1;            
  output [9:0] mem_addr_out_2;            
  output [9:0] mem_addr_out_3;            
  output [9:0] mem_addr_out_4;            
  output [9:0] mem_addr_out_5;            
  output [9:0] mem_addr_out_6;            
  output [9:0] mem_addr_out_7;            
  output [9:0] mem_addr_out_8;            
  output [9:0] mem_addr_out_9;            
  output [9:0] mem_addr_out_10;            
  output [9:0] mem_addr_out_11;            
  output [9:0] mem_addr_out_12;            
  output [9:0] mem_addr_out_13;            
  output [9:0] mem_addr_out_14;            
  output [9:0] mem_addr_out_15;            
  output wen_out;
  output out_start;
  
  reg [9:0] counter;        
  reg [1:0] state;        

  reg flag;        

  wire [9:0] mem_addr_out_tmp_0;   
  wire [9:0] mem_addr_out_tmp_1;   
  wire [9:0] mem_addr_out_tmp_2;   
  wire [9:0] mem_addr_out_tmp_3;   
  wire [9:0] mem_addr_out_tmp_4;   
  wire [9:0] mem_addr_out_tmp_5;   
  wire [9:0] mem_addr_out_tmp_6;   
  wire [9:0] mem_addr_out_tmp_7;   
  wire [9:0] mem_addr_out_tmp_8;   
  wire [9:0] mem_addr_out_tmp_9;   
  wire [9:0] mem_addr_out_tmp_10;   
  wire [9:0] mem_addr_out_tmp_11;   
  wire [9:0] mem_addr_out_tmp_12;   
  wire [9:0] mem_addr_out_tmp_13;   
  wire [9:0] mem_addr_out_tmp_14;   
  wire [9:0] mem_addr_out_tmp_15;   
  wire [9:0] mem_addr_out_w;        
  wire [3:0] mem_addr_out_w_h;        
  wire [5:0] mem_addr_out_w_l;        
  
  mem_addr_gen_dp16_mem0_per642 top_mem_addr_gen_inst (.clk(clk),.rst(rst),.addr_out(mem_addr_out_w), .counter_in(counter)); 

  assign mem_addr_out_w_h = mem_addr_out_w[9:6];        
  assign mem_addr_out_w_l = mem_addr_out_w[5:0];   
  assign mem_addr_out_tmp_0 = {mem_addr_out_w_h[3],mem_addr_out_w_h[2],mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_1 = {mem_addr_out_w_h[3],mem_addr_out_w_h[2],mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_2 = {mem_addr_out_w_h[3],mem_addr_out_w_h[2],~mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_3 = {mem_addr_out_w_h[3],mem_addr_out_w_h[2],~mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_4 = {mem_addr_out_w_h[3],~mem_addr_out_w_h[2],mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_5 = {mem_addr_out_w_h[3],~mem_addr_out_w_h[2],mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_6 = {mem_addr_out_w_h[3],~mem_addr_out_w_h[2],~mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_7 = {mem_addr_out_w_h[3],~mem_addr_out_w_h[2],~mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_8 = {~mem_addr_out_w_h[3],mem_addr_out_w_h[2],mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_9 = {~mem_addr_out_w_h[3],mem_addr_out_w_h[2],mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_10 = {~mem_addr_out_w_h[3],mem_addr_out_w_h[2],~mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_11 = {~mem_addr_out_w_h[3],mem_addr_out_w_h[2],~mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_12 = {~mem_addr_out_w_h[3],~mem_addr_out_w_h[2],mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_13 = {~mem_addr_out_w_h[3],~mem_addr_out_w_h[2],mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_14 = {~mem_addr_out_w_h[3],~mem_addr_out_w_h[2],~mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_15 = {~mem_addr_out_w_h[3],~mem_addr_out_w_h[2],~mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_0 = ((flag == 1'b0) ? mem_addr_out_tmp_0 : counter); 
  assign mem_addr_out_1 = ((flag == 1'b0) ? mem_addr_out_tmp_1 : counter); 
  assign mem_addr_out_2 = ((flag == 1'b0) ? mem_addr_out_tmp_2 : counter); 
  assign mem_addr_out_3 = ((flag == 1'b0) ? mem_addr_out_tmp_3 : counter); 
  assign mem_addr_out_4 = ((flag == 1'b0) ? mem_addr_out_tmp_4 : counter); 
  assign mem_addr_out_5 = ((flag == 1'b0) ? mem_addr_out_tmp_5 : counter); 
  assign mem_addr_out_6 = ((flag == 1'b0) ? mem_addr_out_tmp_6 : counter); 
  assign mem_addr_out_7 = ((flag == 1'b0) ? mem_addr_out_tmp_7 : counter); 
  assign mem_addr_out_8 = ((flag == 1'b0) ? mem_addr_out_tmp_8 : counter); 
  assign mem_addr_out_9 = ((flag == 1'b0) ? mem_addr_out_tmp_9 : counter); 
  assign mem_addr_out_10 = ((flag == 1'b0) ? mem_addr_out_tmp_10 : counter); 
  assign mem_addr_out_11 = ((flag == 1'b0) ? mem_addr_out_tmp_11 : counter); 
  assign mem_addr_out_12 = ((flag == 1'b0) ? mem_addr_out_tmp_12 : counter); 
  assign mem_addr_out_13 = ((flag == 1'b0) ? mem_addr_out_tmp_13 : counter); 
  assign mem_addr_out_14 = ((flag == 1'b0) ? mem_addr_out_tmp_14 : counter); 
  assign mem_addr_out_15 = ((flag == 1'b0) ? mem_addr_out_tmp_15 : counter); 
  
  assign wen_out = state[0];        
  assign out_start = (state == 2'b01) && (counter[9:0] == {10{1'b1}}); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter <= 10'b0;      
      state <= 2'b0;            
      flag <= 1'b0;            
      end
    else begin                        
      case (state)              
        2'b00: begin              
          counter <= 10'b0;      
          if (in_start)  begin              
            state <= 2'b01;              
            end
        end
        2'b01: begin              
          counter <= counter + 1'b1;       
          if (!in_start && counter == {10{1'b1}})  begin 
            state <= 2'b11;              
          end
          if (counter == {10{1'b1}})  begin 
            flag <= !flag;              
          end
        end
        2'b11: begin              
          counter <= counter + 1'b1;       
          if (counter == {10{1'b1}})  begin 
            state <= 2'b00;              
          end
        end
        default: state <= 2'b00;       
      endcase
    end
  end                              

endmodule                        


module mem_stage_dp16(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [15:0];              
  wire [DATA_WIDTH-1:0] wire_out [15:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  assign wire_in[2] = inData_2;    
  assign wire_in[3] = inData_3;    
  assign wire_in[4] = inData_4;    
  assign wire_in[5] = inData_5;    
  assign wire_in[6] = inData_6;    
  assign wire_in[7] = inData_7;    
  assign wire_in[8] = inData_8;    
  assign wire_in[9] = inData_9;    
  assign wire_in[10] = inData_10;    
  assign wire_in[11] = inData_11;    
  assign wire_in[12] = inData_12;    
  assign wire_in[13] = inData_13;    
  assign wire_in[14] = inData_14;    
  assign wire_in[15] = inData_15;    
  
  wire [9:0] addr_w_wire_0;        

  wire [9:0] addr_w_wire_1;        

  wire [9:0] addr_w_wire_2;        

  wire [9:0] addr_w_wire_3;        

  wire [9:0] addr_w_wire_4;        

  wire [9:0] addr_w_wire_5;        

  wire [9:0] addr_w_wire_6;        

  wire [9:0] addr_w_wire_7;        

  wire [9:0] addr_w_wire_8;        

  wire [9:0] addr_w_wire_9;        

  wire [9:0] addr_w_wire_10;        

  wire [9:0] addr_w_wire_11;        

  wire [9:0] addr_w_wire_12;        

  wire [9:0] addr_w_wire_13;        

  wire [9:0] addr_w_wire_14;        

  wire [9:0] addr_w_wire_15;        

  wire [9:0] addr_r_wire_0;        

  counter_1024 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  mem_addr_ctrl_dp16_per642 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .mem_addr_out_0(addr_wire_0), .mem_addr_out_1(addr_wire_1), .mem_addr_out_2(addr_wire_2), .mem_addr_out_3(addr_wire_3), .mem_addr_out_4(addr_wire_4), .mem_addr_out_5(addr_wire_5), .mem_addr_out_6(addr_wire_6), .mem_addr_out_7(addr_wire_7), .mem_addr_out_8(addr_wire_8), .mem_addr_out_9(addr_wire_9), .mem_addr_out_10(addr_wire_10), .mem_addr_out_11(addr_wire_11), .mem_addr_out_12(addr_wire_12), .mem_addr_out_13(addr_wire_13), .mem_addr_out_14(addr_wire_14), .mem_addr_out_15(addr_wire_15), .clk(clk), .rst(rst));

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_0(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_1(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_2(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_2), .din(wire_in[2]), .dout(wire_out[2]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_3(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_3), .din(wire_in[3]), .dout(wire_out[3]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_4(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_4), .din(wire_in[4]), .dout(wire_out[4]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_5(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_5), .din(wire_in[5]), .dout(wire_out[5]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_6(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_6), .din(wire_in[6]), .dout(wire_out[6]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_7(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_7), .din(wire_in[7]), .dout(wire_out[7]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_8(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_8), .din(wire_in[8]), .dout(wire_out[8]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_9(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_9), .din(wire_in[9]), .dout(wire_out[9]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_10(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_10), .din(wire_in[10]), .dout(wire_out[10]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_11(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_11), .din(wire_in[11]), .dout(wire_out[11]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_12(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_12), .din(wire_in[12]), .dout(wire_out[12]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_13(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_13), .din(wire_in[13]), .dout(wire_out[13]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_14(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_14), .din(wire_in[14]), .dout(wire_out[14]), .clk(clk) );

  block_ram_dp #(.DATA_WIDTH(32), .ADDR_WIDTH(10)) 
         ram_inst_15(.wen(wen_wire), .en(1'b1), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_15), .din(wire_in[15]), .dout(wire_out[15]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign outData_2 = wire_out[2];    
  assign outData_3 = wire_out[3];    
  assign outData_4 = wire_out[4];    
  assign outData_5 = wire_out[5];    
  assign outData_6 = wire_out[6];    
  assign outData_7 = wire_out[7];    
  assign outData_8 = wire_out[8];    
  assign outData_9 = wire_out[9];    
  assign outData_10 = wire_out[10];    
  assign outData_11 = wire_out[11];    
  assign outData_12 = wire_out[12];    
  assign outData_13 = wire_out[13];    
  assign outData_14 = wire_out[14];    
  assign outData_15 = wire_out[15];    
  assign out_start = out_start_wire;    
  
endmodule                        


module per_dp16_642(
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
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
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
      inData_15;
  output [DATA_WIDTH-1:0] outData_0,
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
      outData_15; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [15:0];                  
  wire [DATA_WIDTH-1:0] wireOut [15:0];                 
  wire [DATA_WIDTH-1:0] wireOut_LB [15:0];              
  wire [DATA_WIDTH-1:0] wireIn_RB [15:0];               
  wire out_start_LB;               
  wire out_start_MemStage;               
  wire out_start_RB;               

  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  assign wireIn[4] = inData_4;    
  assign wireIn[5] = inData_5;    
  assign wireIn[6] = inData_6;    
  assign wireIn[7] = inData_7;    
  assign wireIn[8] = inData_8;    
  assign wireIn[9] = inData_9;    
  assign wireIn[10] = inData_10;    
  assign wireIn[11] = inData_11;    
  assign wireIn[12] = inData_12;    
  assign wireIn[13] = inData_13;    
  assign wireIn[14] = inData_14;    
  assign wireIn[15] = inData_15;    
  
  ingressStage_p16 ingressStage_p16_inst(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), .inData_4(wireIn[4]), .inData_5(wireIn[5]), .inData_6(wireIn[6]), .inData_7(wireIn[7]), .inData_8(wireIn[8]), .inData_9(wireIn[9]), .inData_10(wireIn[10]), .inData_11(wireIn[11]), .inData_12(wireIn[12]), .inData_13(wireIn[13]), .inData_14(wireIn[14]), .inData_15(wireIn[15]), .outData_0(wireOut_LB[0]), .outData_1(wireOut_LB[1]), .outData_2(wireOut_LB[2]), .outData_3(wireOut_LB[3]), .outData_4(wireOut_LB[4]), .outData_5(wireOut_LB[5]), .outData_6(wireOut_LB[6]), .outData_7(wireOut_LB[7]), .outData_8(wireOut_LB[8]), .outData_9(wireOut_LB[9]), .outData_10(wireOut_LB[10]), .outData_11(wireOut_LB[11]), .outData_12(wireOut_LB[12]), .outData_13(wireOut_LB[13]), .outData_14(wireOut_LB[14]), .outData_15(wireOut_LB[15]), .in_start(in_start), .out_start(out_start_LB), .clk(clk), .rst(rst));
  
  mem_stage_dp16 mem_stage_dp16_inst(.inData_0(wireOut_LB[0]), .inData_1(wireOut_LB[1]), .inData_2(wireOut_LB[2]), .inData_3(wireOut_LB[3]), .inData_4(wireOut_LB[4]), .inData_5(wireOut_LB[5]), .inData_6(wireOut_LB[6]), .inData_7(wireOut_LB[7]), .inData_8(wireOut_LB[8]), .inData_9(wireOut_LB[9]), .inData_10(wireOut_LB[10]), .inData_11(wireOut_LB[11]), .inData_12(wireOut_LB[12]), .inData_13(wireOut_LB[13]), .inData_14(wireOut_LB[14]), .inData_15(wireOut_LB[15]), .outData_0(wireIn_RB[0]), .outData_1(wireIn_RB[1]), .outData_2(wireIn_RB[2]), .outData_3(wireIn_RB[3]), .outData_4(wireIn_RB[4]), .outData_5(wireIn_RB[5]), .outData_6(wireIn_RB[6]), .outData_7(wireIn_RB[7]), .outData_8(wireIn_RB[8]), .outData_9(wireIn_RB[9]), .outData_10(wireIn_RB[10]), .outData_11(wireIn_RB[11]), .outData_12(wireIn_RB[12]), .outData_13(wireIn_RB[13]), .outData_14(wireIn_RB[14]), .outData_15(wireIn_RB[15]), .in_start(out_start_LB), .out_start(out_start_MemStage), .clk(clk), .rst(rst));
  
  egressStage_p16 egressStage_p16_inst(.inData_0(wireIn_RB[0]), .inData_1(wireIn_RB[1]), .inData_2(wireIn_RB[2]), .inData_3(wireIn_RB[3]), .inData_4(wireIn_RB[4]), .inData_5(wireIn_RB[5]), .inData_6(wireIn_RB[6]), .inData_7(wireIn_RB[7]), .inData_8(wireIn_RB[8]), .inData_9(wireIn_RB[9]), .inData_10(wireIn_RB[10]), .inData_11(wireIn_RB[11]), .inData_12(wireIn_RB[12]), .inData_13(wireIn_RB[13]), .inData_14(wireIn_RB[14]), .inData_15(wireIn_RB[15]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), .outData_4(wireOut[4]), .outData_5(wireOut[5]), .outData_6(wireOut[6]), .outData_7(wireOut[7]), .outData_8(wireOut[8]), .outData_9(wireOut[9]), .outData_10(wireOut[10]), .outData_11(wireOut[11]), .outData_12(wireOut[12]), .outData_13(wireOut[13]), .outData_14(wireOut[14]), .outData_15(wireOut[15]), .in_start(out_start_MemStage), .out_start(out_start_RB), .clk(clk), .rst(rst));
  
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign outData_4 = wireOut[4];    
  assign outData_5 = wireOut[5];    
  assign outData_6 = wireOut[6];    
  assign outData_7 = wireOut[7];    
  assign outData_8 = wireOut[8];    
  assign outData_9 = wireOut[9];    
  assign outData_10 = wireOut[10];    
  assign outData_11 = wireOut[11];    
  assign outData_12 = wireOut[12];    
  assign outData_13 = wireOut[13];    
  assign outData_14 = wireOut[14];    
  assign outData_15 = wireOut[15];    
  assign out_start = out_start_RB;    
  
endmodule                        

