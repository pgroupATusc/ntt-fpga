

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


module  counter_4(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] counter_out;            
  
  reg [1:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 2'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[1:0] == 3) begin  
        status_couting <= 1'b0;                 
        counter_r <= 2'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      counter_r <= 2'b0;                
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
  parameter ADDR_WIDTH = 1;                                
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
  parameter ADDR_WIDTH = 1;                                
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
  parameter ADDR_WIDTH = 1;                                
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
  parameter ADDR_WIDTH = 1;                                
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


module switches_stage_st0_888_L(
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


module ctrl_rom_dp4_st0_per888L(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [0:0] addr;                        
  output reg [1:0] data;        
  
  // synthesis attribute rom_style of data is "distributed"  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 2'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          1'b0: data <= 2'b00; 
          1'b1: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st0_per888L(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [0:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st0_per888L ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 1'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 1'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {1{1'b1}}) begin         
            state <= 1'b0;                 
          end
        end                              
      endcase                              
    end
  end                              

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


module switches_stage_st1_888_L(
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


module ctrl_rom_dp4_st1_per888L(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [0:0] addr;                        
  output reg [1:0] data;        
  
  // synthesis attribute rom_style of data is "distributed"  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 2'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          1'b0: data <= 2'b00; 
          1'b1: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st1_per888L(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [0:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st1_per888L ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 1'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 1'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {1{1'b1}}) begin         
            state <= 1'b0;                 
          end
        end                              
      endcase                              
    end
  end                              

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
  input [0:0] counter_in; 
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

  switches_stage_st0_888_L switch_stage_0(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), 
        .outData_0(wire_con_in_stage0[0]), .outData_1(wire_con_in_stage0[1]), .outData_2(wire_con_in_stage0[2]), .outData_3(wire_con_in_stage0[3]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp4_st0_L wire_stage_0(
        .inData_0(wire_con_in_stage0[0]), .inData_1(wire_con_in_stage0[1]), .inData_2(wire_con_in_stage0[2]), .inData_3(wire_con_in_stage0[3]), 
        .outData_0(wire_con_out_stage0[0]), .outData_1(wire_con_out_stage0[1]), .outData_2(wire_con_out_stage0[2]), .outData_3(wire_con_out_stage0[3]), 
        .in_start(con_in_start_stage0), .out_start(in_start_stage1), .clk(clk), .rst(rst)); 

  
  switch_ctrl_dp4_st0_per888L switch_ctrl_stage_0(.in_start(in_start_stage0),.ctrl_out(wire_ctrl_stage0),.clk(clk), .rst(rst));

  wire [DATA_WIDTH-1:0] wire_con_in_stage1[3:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage1[3:0];
  wire [1:0] wire_ctrl_stage1;

  switches_stage_st1_888_L switch_stage_1(
        .inData_0(wire_con_out_stage0[0]), .inData_1(wire_con_out_stage0[1]), .inData_2(wire_con_out_stage0[2]), .inData_3(wire_con_out_stage0[3]), 
        .outData_0(wire_con_in_stage1[0]), .outData_1(wire_con_in_stage1[1]), .outData_2(wire_con_in_stage1[2]), .outData_3(wire_con_in_stage1[3]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp4_st1_L wire_stage_1(
        .inData_0(wire_con_in_stage1[0]), .inData_1(wire_con_in_stage1[1]), .inData_2(wire_con_in_stage1[2]), .inData_3(wire_con_in_stage1[3]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), 
        .in_start(con_in_start_stage1), .out_start(out_start_w), .clk(clk), .rst(rst)); 

  
  switch_ctrl_dp4_st1_per888L switch_ctrl_stage_1(.in_start(in_start_stage1),.ctrl_out(wire_ctrl_stage1),.clk(clk), .rst(rst));

  
  assign in_start_stage0 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_w;    
  
endmodule                        


module switches_stage_st0_888_R(
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


module ctrl_rom_dp4_st0_per888R(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [0:0] addr;                        
  output reg [1:0] data;        
  
  // synthesis attribute rom_style of data is "distributed"  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 2'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          1'b0: data <= 2'b00; 
          1'b1: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st0_per888R(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [0:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st0_per888R ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 1'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 1'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {1{1'b1}}) begin         
            state <= 1'b0;                 
          end
        end                              
      endcase                              
    end
  end                              

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


module switches_stage_st1_888_R(
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


module ctrl_rom_dp4_st1_per888R(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [0:0] addr;                        
  output reg [1:0] data;        
  
  // synthesis attribute rom_style of data is "distributed"  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 2'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          1'b0: data <= 2'b00; 
          1'b1: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st1_per888R(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [0:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st1_per888R ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 1'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 1'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {1{1'b1}}) begin         
            state <= 1'b0;                 
          end
        end                              
      endcase                              
    end
  end                              

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
  input [0:0] counter_in; 
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

  switches_stage_st1_888_R switch_stage_1(
        .inData_0(wire_switch_in_stage1[0]), .inData_1(wire_switch_in_stage1[1]), .inData_2(wire_switch_in_stage1[2]), .inData_3(wire_switch_in_stage1[3]), 
        .outData_0(wire_switch_out_stage1[0]), .outData_1(wire_switch_out_stage1[1]), .outData_2(wire_switch_out_stage1[2]), .outData_3(wire_switch_out_stage1[3]), 
        .in_start(con_in_start_stage1), .out_start(in_start_stage0), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp4_st1_R wire_stage_1(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), 
        .outData_0(wire_switch_in_stage1[0]), .outData_1(wire_switch_in_stage1[1]), .outData_2(wire_switch_in_stage1[2]), .outData_3(wire_switch_in_stage1[3]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .clk(clk), .rst(rst)); 

  
  switch_ctrl_dp4_st1_per888R switch_ctrl_stage_1(.in_start(con_in_start_stage1),.ctrl_out(wire_ctrl_stage1),.clk(clk), .rst(rst));

  wire [DATA_WIDTH-1:0] wire_switch_in_stage0[3:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage0[3:0];
  reg [1:0] wire_ctrl_stage0;

  switches_stage_st0_888_R switch_stage_0(
        .inData_0(wire_switch_in_stage0[0]), .inData_1(wire_switch_in_stage0[1]), .inData_2(wire_switch_in_stage0[2]), .inData_3(wire_switch_in_stage0[3]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), 
        .in_start(con_in_start_stage0), .out_start(out_start_w), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp4_st0_R wire_stage_0(
        .inData_0(wire_switch_out_stage1[0]), .inData_1(wire_switch_out_stage1[1]), .inData_2(wire_switch_out_stage1[2]), .inData_3(wire_switch_out_stage1[3]), 
        .outData_0(wire_switch_in_stage0[0]), .outData_1(wire_switch_in_stage0[1]), .outData_2(wire_switch_in_stage0[2]), .outData_3(wire_switch_in_stage0[3]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .clk(clk), .rst(rst)); 

  
  switch_ctrl_dp4_st0_per888R switch_ctrl_stage_0(.in_start(con_in_start_stage0),.ctrl_out(wire_ctrl_stage0),.clk(clk), .rst(rst));

  
  assign in_start_stage1 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_w;    
  
endmodule                        


module  addr_rom_dp4_mem0(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [0:0] addr;                        
  output reg [0:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 1'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          1'b0: data <= 1'b0; 
          1'b1: data <= 1'b1; 
          default: data <= 1'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp4_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [1:0] addr;                        
  output reg [1:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 2'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          2'b00: data <= 2'b01; 
          2'b01: data <= 2'b00; 
          2'b10: data <= 2'b00; 
          2'b11: data <= 2'b01; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp4_mem2(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [0:0] addr;                        
  output reg [0:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 1'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          1'b0: data <= 1'b0; 
          1'b1: data <= 1'b1; 
          default: data <= 1'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp4_mem3(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [1:0] addr;                        
  output reg [1:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 2'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          2'b00: data <= 2'b01; 
          2'b01: data <= 2'b00; 
          2'b10: data <= 2'b00; 
          2'b11: data <= 2'b01; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp4_per888(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
rom_out_2,                         
rom_out_3,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [0:0] rom_out_0;            
  output [1:0] rom_out_1;            
  output [0:0] rom_out_2;            
  output [1:0] rom_out_3;            
  output wen_out;
  output out_start;
  
  reg [0:0] rom_addr_0;        
  reg [1:0] rom_addr_1;        
  reg [1:0] state;        
  
  addr_rom_dp4_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp4_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  addr_rom_dp4_mem2 addr_rom_inst_2(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_2)); 
  addr_rom_dp4_mem3 addr_rom_inst_3(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_3)); 
  
  assign wen_out = state[0];        
  assign out_start = (state == 2'b01) && (rom_addr_0[0:0] == {1{1'b0}}); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 1'b0;    
      rom_addr_1 <= 2'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case (state)              
        2'b00: begin              
          rom_addr_0 <= 1'b0;   
          rom_addr_1 <= 2'b0;   
          if (in_start)  begin              
            state <= 2'b01;              
            rom_addr_0 <= rom_addr_0 + 1;    
          rom_addr_1 <= rom_addr_1 + 1;    
          end
        end
        2'b01: begin              
          rom_addr_0 <= rom_addr_0 + 1;    
          rom_addr_1 <= rom_addr_1 + 1;    
          if (rom_addr_0 == {1{1'b0}})  begin 
            state <= 2'b11;              
          end
        end
        2'b11: begin              
          rom_addr_0 <= rom_addr_0 + 1;    
          rom_addr_1 <= rom_addr_1 + 1;    
          if (in_start)  begin              
            state <= 2'b01;              
          end
          else if (rom_addr_0 == {1{1'b0}})  begin 
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
  input [1-1:0] counter_in;        
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
  
  wire [0:0] addr_wire_0;        

  wire [0:0] addr_wire_1;        

  wire [0:0] addr_wire_2;        

  wire [0:0] addr_wire_3;        

  addr_rom_ctrl_dp4_per888 addr_gen_inst(.in_start(in_start), .counter_in(counter_in), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .rom_out_2(addr_wire_2), .rom_out_3(addr_wire_3), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(1)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(1)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(1)) 
         ram_inst_2(.wen(wen_wire), .addr(addr_wire_2), .din(wire_in[2]), .dout(wire_out[2]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(1)) 
         ram_inst_3(.wen(wen_wire), .addr(addr_wire_3), .din(wire_in[3]), .dout(wire_out[3]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign outData_2 = wire_out[2];    
  assign outData_3 = wire_out[3];    
  assign out_start = out_start_wire;    
  
endmodule                        


module per_dp4_888(
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

  wire [0:0] counter_out_w;               
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  counter_4 ctrl_unit(.in_start(in_start), .counter_out(counter_out_w), .clk(clk), .rst(rst));

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

