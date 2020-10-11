

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


module  counter_4096(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [11:0] counter_out;            
  
  reg [11:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 12'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[11:0] == 4095) begin  
        status_couting <= 1'b0;                 
        counter_r <= 12'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      counter_r <= 12'b0;                
      end                                    
    end
  end                              

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
  parameter ADDR_WIDTH = 11;                                
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
  parameter ADDR_WIDTH = 11;                                
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
  parameter ADDR_WIDTH = 11;                                
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
  parameter ADDR_WIDTH = 11;                                
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


module switches_stage_st0_11_L(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [2-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp4_st0_L(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
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
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[2];    
  assign wireOut[2] = wireIn[1];    
  assign wireOut[3] = wireIn[3];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = in_start;    
  
endmodule                        


module switches_stage_st1_11_L(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [2-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp4_st1_L(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
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
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[1];    
  assign wireOut[2] = wireIn[2];    
  assign wireOut[3] = wireIn[3];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = in_start;    
  
endmodule                        


module ingressStage_p4(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
in_start,                        
out_start,                       
counter_in,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  input [10:0] counter_in; 
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3;
  output out_start; 
  
  
  wire out_start_w; 
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  wire in_start_stage0;
  wire con_in_start_stage0;

  wire in_start_stage1;
  wire con_in_start_stage1;

  wire [DATA_WIDTH-1:0] wire_con_in_stage0[3:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage0[3:0];
  wire [1:0] wire_ctrl_stage0;

  switches_stage_st0_11_L switch_stage_0(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), 
        .outData_0(wire_con_in_stage0[0]), .outData_1(wire_con_in_stage0[1]), .outData_2(wire_con_in_stage0[2]), .outData_3(wire_con_in_stage0[3]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp4_st0_L wire_stage_0(
        .inData_0(wire_con_in_stage0[0]), .inData_1(wire_con_in_stage0[1]), .inData_2(wire_con_in_stage0[2]), .inData_3(wire_con_in_stage0[3]), 
        .outData_0(wire_con_out_stage0[0]), .outData_1(wire_con_out_stage0[1]), .outData_2(wire_con_out_stage0[2]), .outData_3(wire_con_out_stage0[3]), 
        .in_start(con_in_start_stage0), .out_start(in_start_stage1), .clk(clk), .rst(rst)); 

  
  wire [10:0] counter_w;
  assign counter_w = counter_in; 
  assign wire_ctrl_stage0[0] = counter_w[10]; 
  assign wire_ctrl_stage0[1] = counter_w[10]; 
  wire [DATA_WIDTH-1:0] wire_con_in_stage1[3:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage1[3:0];
  wire [1:0] wire_ctrl_stage1;

  switches_stage_st1_11_L switch_stage_1(
        .inData_0(wire_con_out_stage0[0]), .inData_1(wire_con_out_stage0[1]), .inData_2(wire_con_out_stage0[2]), .inData_3(wire_con_out_stage0[3]), 
        .outData_0(wire_con_in_stage1[0]), .outData_1(wire_con_in_stage1[1]), .outData_2(wire_con_in_stage1[2]), .outData_3(wire_con_in_stage1[3]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp4_st1_L wire_stage_1(
        .inData_0(wire_con_in_stage1[0]), .inData_1(wire_con_in_stage1[1]), .inData_2(wire_con_in_stage1[2]), .inData_3(wire_con_in_stage1[3]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), 
        .in_start(con_in_start_stage1), .out_start(out_start_w), .clk(clk), .rst(rst)); 

  
  assign wire_ctrl_stage1[0] = counter_w[9]; 
  assign wire_ctrl_stage1[1] = counter_w[9]; 
  
  assign in_start_stage0 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_w;    
  
endmodule                        


module switches_stage_st0_11_R(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [2-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp4_st0_R(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
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
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[2];    
  assign wireOut[2] = wireIn[1];    
  assign wireOut[3] = wireIn[3];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = in_start;    
  
endmodule                        


module switches_stage_st1_11_R(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [2-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = in_start;    
  
endmodule                        


module wireCon_dp4_st1_R(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
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
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[1];    
  assign wireOut[2] = wireIn[2];    
  assign wireOut[3] = wireIn[3];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = in_start;    
  
endmodule                        


module egressStage_p4(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
in_start,                        
out_start,                       
counter_in,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  input [10:0] counter_in; 
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3;
  output out_start; 
  
  
  wire out_start_w; 
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  wire in_start_stage1;
  wire con_in_start_stage1;

  wire in_start_stage0;
  wire con_in_start_stage0;

  wire [DATA_WIDTH-1:0] wire_switch_in_stage1[3:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage1[3:0];
  reg [1:0] wire_ctrl_stage1;

  switches_stage_st1_11_R switch_stage_1(
        .inData_0(wire_switch_in_stage1[0]), .inData_1(wire_switch_in_stage1[1]), .inData_2(wire_switch_in_stage1[2]), .inData_3(wire_switch_in_stage1[3]), 
        .outData_0(wire_switch_out_stage1[0]), .outData_1(wire_switch_out_stage1[1]), .outData_2(wire_switch_out_stage1[2]), .outData_3(wire_switch_out_stage1[3]), 
        .in_start(con_in_start_stage1), .out_start(in_start_stage0), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp4_st1_R wire_stage_1(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), 
        .outData_0(wire_switch_in_stage1[0]), .outData_1(wire_switch_in_stage1[1]), .outData_2(wire_switch_in_stage1[2]), .outData_3(wire_switch_in_stage1[3]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .clk(clk), .rst(rst)); 

  
  wire [10:0] counter_w;
  assign counter_w = counter_in; 
  always@(posedge clk)             
  begin                            
    wire_ctrl_stage1[0] <= counter_w[9]; 
  end                            

  always@(posedge clk)             
  begin                            
    wire_ctrl_stage1[1] <= counter_w[9]; 
  end                            

  wire [DATA_WIDTH-1:0] wire_switch_in_stage0[3:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage0[3:0];
  reg [1:0] wire_ctrl_stage0;

  switches_stage_st0_11_R switch_stage_0(
        .inData_0(wire_switch_in_stage0[0]), .inData_1(wire_switch_in_stage0[1]), .inData_2(wire_switch_in_stage0[2]), .inData_3(wire_switch_in_stage0[3]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), 
        .in_start(con_in_start_stage0), .out_start(out_start_w), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp4_st0_R wire_stage_0(
        .inData_0(wire_switch_out_stage1[0]), .inData_1(wire_switch_out_stage1[1]), .inData_2(wire_switch_out_stage1[2]), .inData_3(wire_switch_out_stage1[3]), 
        .outData_0(wire_switch_in_stage0[0]), .outData_1(wire_switch_in_stage0[1]), .outData_2(wire_switch_in_stage0[2]), .outData_3(wire_switch_in_stage0[3]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .clk(clk), .rst(rst)); 

  
  always@(posedge clk)             
  begin                            
    wire_ctrl_stage0[0] <= counter_w[10]; 
  end                            

  always@(posedge clk)             
  begin                            
    wire_ctrl_stage0[1] <= counter_w[10]; 
  end                            

  
  assign in_start_stage1 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_w;    
  
endmodule                        


module  mem_addr_gen_dp4_mem0_per11(
counter_in,                              
clk,                             
rst,                             
addr_out                            
);                               
  input clk, rst;                           
  input [10:0] counter_in;      
  output [10:0] addr_out;      

  wire [3:0] word_counter_w [1:0];      
  wire [0:0] addr_a1;      
  wire [1:0] addr_a0;      
  assign addr_out[3:0] = {word_counter_w[1][0],word_counter_w[1][1],word_counter_w[1][2],word_counter_w[1][3]};    
  assign addr_out[7:4] = {word_counter_w[0][0],word_counter_w[0][1],word_counter_w[0][2],word_counter_w[0][3]};    
  assign addr_out[8:8] = {addr_a1[0]};   
  assign addr_out[10:9] = addr_a0[1:0];   
  
  assign word_counter_w[0] = counter_in[4:1];  
  assign word_counter_w[1] = counter_in[8:5];  
  assign addr_a0 = counter_in[10:9]; 
  assign addr_a1 = counter_in[0:0]; 
    
endmodule                        


module  mem_addr_ctrl_dp4_per11(
in_start,                          
counter_in,                         
wen_out,                         
out_start,                         
mem_addr_out_0,                         
mem_addr_out_1,                         
mem_addr_out_2,                         
mem_addr_out_3,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  input [10:0] counter_in; 
  output [10:0] mem_addr_out_0;            
  output [10:0] mem_addr_out_1;            
  output [10:0] mem_addr_out_2;            
  output [10:0] mem_addr_out_3;            
  output wen_out;
  output reg out_start;
  
  reg [1:0] state;        
  reg flag;        

  wire [10:0] mem_addr_out_tmp_0;   
  wire [10:0] mem_addr_out_tmp_1;   
  wire [10:0] mem_addr_out_tmp_2;   
  wire [10:0] mem_addr_out_tmp_3;   
  wire [10:0] mem_addr_out_w;        
  wire [1:0] mem_addr_out_w_h;        
  wire [8:0] mem_addr_out_w_l;        
  
  mem_addr_gen_dp4_mem0_per11 top_mem_addr_gen_inst (.clk(clk),.rst(rst),.addr_out(mem_addr_out_w), .counter_in(counter_in)); 

  assign mem_addr_out_w_h = mem_addr_out_w[10:9];        
  assign mem_addr_out_w_l = mem_addr_out_w[8:0];   
  assign mem_addr_out_tmp_0 = {mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_1 = {mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_2 = {~mem_addr_out_w_h[1],mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_tmp_3 = {~mem_addr_out_w_h[1],~mem_addr_out_w_h[0],mem_addr_out_w_l}; 
  assign mem_addr_out_0 = ((flag == 1'b0) ? mem_addr_out_tmp_0 : counter_in); 
  assign mem_addr_out_1 = ((flag == 1'b0) ? mem_addr_out_tmp_1 : counter_in); 
  assign mem_addr_out_2 = ((flag == 1'b0) ? mem_addr_out_tmp_2 : counter_in); 
  assign mem_addr_out_3 = ((flag == 1'b0) ? mem_addr_out_tmp_3 : counter_in); 
  
  assign wen_out = state[0];        
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      out_start <= 1'b0; 
end
    else begin                        
      out_start <= (state == 2'b01) && (counter_in[10:0] == {11{1'b1}}); 
end                              
end                              

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      state <= 2'b0;            
      flag <= 1'b0;            
      end
    else begin                        
      case (state)              
        2'b00: begin              
          if (in_start)  begin              
            state <= 2'b01;              
            end
        end
        2'b01: begin              
          if (!in_start && counter_in == {11{1'b1}})  begin 
            state <= 2'b11;              
          end
          if (counter_in == {11{1'b1}})  begin 
            flag <= !flag;              
          end
        end
        2'b11: begin              
          if (counter_in == {11{1'b1}})  begin 
            state <= 2'b00;              
          end
        end
        default: state <= 2'b00;       
      endcase
    end
  end                              

endmodule                        


module mem_stage_dp4(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
in_start,                        
out_start,                       
clk,                             
counter_in,                             
rst                              
);                               
  parameter DATA_WIDTH = 32;                                
  input in_start, clk, rst;                   
  input [11-1:0] counter_in;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [3:0];              
  wire [DATA_WIDTH-1:0] wire_out [3:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  assign wire_in[2] = inData_2;    
  assign wire_in[3] = inData_3;    
  
  wire [10:0] addr_wire_0;        

  wire [10:0] addr_wire_1;        

  wire [10:0] addr_wire_2;        

  wire [10:0] addr_wire_3;        

  mem_addr_ctrl_dp4_per11 addr_gen_inst(.in_start(in_start), .counter_in(counter_in), .wen_out(wen_wire), .out_start(out_start_wire), .mem_addr_out_0(addr_wire_0), .mem_addr_out_1(addr_wire_1), .mem_addr_out_2(addr_wire_2), .mem_addr_out_3(addr_wire_3), .clk(clk), .rst(rst));

  block_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(11)) 
         ram_inst_0(.wen(wen_wire), .en(1'b1), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  block_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(11)) 
         ram_inst_1(.wen(wen_wire), .en(1'b1), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  block_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(11)) 
         ram_inst_2(.wen(wen_wire), .en(1'b1), .addr(addr_wire_2), .din(wire_in[2]), .dout(wire_out[2]), .clk(clk) );

  block_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(11)) 
         ram_inst_3(.wen(wen_wire), .en(1'b1), .addr(addr_wire_3), .din(wire_in[3]), .dout(wire_out[3]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign outData_2 = wire_out[2];    
  assign outData_3 = wire_out[3];    
  assign out_start = out_start_wire;    
  
endmodule                        


module per_dp4_11(
inData_0,
inData_1,
inData_2,
inData_3,
outData_0,
outData_1,
outData_2,
outData_3,
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
      inData_3;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];                  
  wire [DATA_WIDTH-1:0] wireOut [3:0];                 
  wire [DATA_WIDTH-1:0] wireOut_LB [3:0];              
  wire [DATA_WIDTH-1:0] wireIn_RB [3:0];               
  wire out_start_LB;               
  wire out_start_MemStage;               
  wire out_start_RB;               

  wire [10:0] counter_out_w;               
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  counter_4096 ctrl_unit(.in_start(in_start), .counter_out(counter_out_w), .clk(clk), .rst(rst));

  ingressStage_p4 ingressStage_p4_inst(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), .outData_0(wireOut_LB[0]), .outData_1(wireOut_LB[1]), .outData_2(wireOut_LB[2]), .outData_3(wireOut_LB[3]), .in_start(in_start), .out_start(out_start_LB), .counter_in(counter_out_w), .clk(clk), .rst(rst));
  
  mem_stage_dp4 mem_stage_dp4_inst(.inData_0(wireOut_LB[0]), .inData_1(wireOut_LB[1]), .inData_2(wireOut_LB[2]), .inData_3(wireOut_LB[3]), .outData_0(wireIn_RB[0]), .outData_1(wireIn_RB[1]), .outData_2(wireIn_RB[2]), .outData_3(wireIn_RB[3]), .in_start(out_start_LB), .out_start(out_start_MemStage), .clk(clk), 
 .counter_in(counter_out_w), .rst(rst));
  
  egressStage_p4 egressStage_p4_inst(.inData_0(wireIn_RB[0]), .inData_1(wireIn_RB[1]), .inData_2(wireIn_RB[2]), .inData_3(wireIn_RB[3]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), .in_start(out_start_MemStage), .out_start(out_start_RB), .counter_in(counter_out_w), .clk(clk), .rst(rst));
  
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_RB;    
  
endmodule                        

