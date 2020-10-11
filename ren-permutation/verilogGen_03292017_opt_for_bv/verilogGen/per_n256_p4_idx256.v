

module switch_2_2(
inData_0,
inData_1,
outData_0,
outData_1,
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
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
  parameter DATA_WIDTH = 16;                                
  parameter ADDR_WIDTH = 6;                                
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
  parameter DATA_WIDTH = 16;                                
  parameter ADDR_WIDTH = 6;                                
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
  parameter DATA_WIDTH = 16;                                
  parameter ADDR_WIDTH = 6;                                
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
  parameter DATA_WIDTH = 16;                                
  parameter ADDR_WIDTH = 6;                                
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


module switches_stage_st0_256_L(
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
  parameter DATA_WIDTH = 16;                                
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


module ctrl_rom_dp4_st0_per256L(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [5:0] addr;                        
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
          6'b000000: data <= 2'b00; 
          6'b000001: data <= 2'b00; 
          6'b000010: data <= 2'b00; 
          6'b000011: data <= 2'b00; 
          6'b000100: data <= 2'b11; 
          6'b000101: data <= 2'b11; 
          6'b000110: data <= 2'b11; 
          6'b000111: data <= 2'b11; 
          6'b001000: data <= 2'b00; 
          6'b001001: data <= 2'b00; 
          6'b001010: data <= 2'b00; 
          6'b001011: data <= 2'b00; 
          6'b001100: data <= 2'b11; 
          6'b001101: data <= 2'b11; 
          6'b001110: data <= 2'b11; 
          6'b001111: data <= 2'b11; 
          6'b010000: data <= 2'b00; 
          6'b010001: data <= 2'b00; 
          6'b010010: data <= 2'b00; 
          6'b010011: data <= 2'b00; 
          6'b010100: data <= 2'b11; 
          6'b010101: data <= 2'b11; 
          6'b010110: data <= 2'b11; 
          6'b010111: data <= 2'b11; 
          6'b011000: data <= 2'b00; 
          6'b011001: data <= 2'b00; 
          6'b011010: data <= 2'b00; 
          6'b011011: data <= 2'b00; 
          6'b011100: data <= 2'b11; 
          6'b011101: data <= 2'b11; 
          6'b011110: data <= 2'b11; 
          6'b011111: data <= 2'b11; 
          6'b100000: data <= 2'b00; 
          6'b100001: data <= 2'b00; 
          6'b100010: data <= 2'b00; 
          6'b100011: data <= 2'b00; 
          6'b100100: data <= 2'b11; 
          6'b100101: data <= 2'b11; 
          6'b100110: data <= 2'b11; 
          6'b100111: data <= 2'b11; 
          6'b101000: data <= 2'b00; 
          6'b101001: data <= 2'b00; 
          6'b101010: data <= 2'b00; 
          6'b101011: data <= 2'b00; 
          6'b101100: data <= 2'b11; 
          6'b101101: data <= 2'b11; 
          6'b101110: data <= 2'b11; 
          6'b101111: data <= 2'b11; 
          6'b110000: data <= 2'b00; 
          6'b110001: data <= 2'b00; 
          6'b110010: data <= 2'b00; 
          6'b110011: data <= 2'b00; 
          6'b110100: data <= 2'b11; 
          6'b110101: data <= 2'b11; 
          6'b110110: data <= 2'b11; 
          6'b110111: data <= 2'b11; 
          6'b111000: data <= 2'b00; 
          6'b111001: data <= 2'b00; 
          6'b111010: data <= 2'b00; 
          6'b111011: data <= 2'b00; 
          6'b111100: data <= 2'b11; 
          6'b111101: data <= 2'b11; 
          6'b111110: data <= 2'b11; 
          6'b111111: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st0_per256L(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [5:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st0_per256L ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 6'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 6'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {6{1'b1}}) begin         
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
  parameter DATA_WIDTH = 16;                                
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


module switches_stage_st1_256_L_r(
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
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [2-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  output reg [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output reg out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      outData_0 <= 0;    
      outData_1 <= 0;    
      outData_2 <= 0;    
      outData_3 <= 0;    
      out_start <= 1'b0;              
      end
    else begin                        
      outData_0 <= wireOut[0];    
      outData_1 <= wireOut[1];    
      outData_2 <= wireOut[2];    
      outData_3 <= wireOut[3];    
      out_start <= in_start;    
      end
  end                              

endmodule                        


module ctrl_rom_dp4_st1_per256L(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [5:0] addr;                        
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
          6'b000000: data <= 2'b00; 
          6'b000001: data <= 2'b00; 
          6'b000010: data <= 2'b00; 
          6'b000011: data <= 2'b00; 
          6'b000100: data <= 2'b00; 
          6'b000101: data <= 2'b00; 
          6'b000110: data <= 2'b00; 
          6'b000111: data <= 2'b00; 
          6'b001000: data <= 2'b11; 
          6'b001001: data <= 2'b11; 
          6'b001010: data <= 2'b11; 
          6'b001011: data <= 2'b11; 
          6'b001100: data <= 2'b11; 
          6'b001101: data <= 2'b11; 
          6'b001110: data <= 2'b11; 
          6'b001111: data <= 2'b11; 
          6'b010000: data <= 2'b00; 
          6'b010001: data <= 2'b00; 
          6'b010010: data <= 2'b00; 
          6'b010011: data <= 2'b00; 
          6'b010100: data <= 2'b00; 
          6'b010101: data <= 2'b00; 
          6'b010110: data <= 2'b00; 
          6'b010111: data <= 2'b00; 
          6'b011000: data <= 2'b11; 
          6'b011001: data <= 2'b11; 
          6'b011010: data <= 2'b11; 
          6'b011011: data <= 2'b11; 
          6'b011100: data <= 2'b11; 
          6'b011101: data <= 2'b11; 
          6'b011110: data <= 2'b11; 
          6'b011111: data <= 2'b11; 
          6'b100000: data <= 2'b00; 
          6'b100001: data <= 2'b00; 
          6'b100010: data <= 2'b00; 
          6'b100011: data <= 2'b00; 
          6'b100100: data <= 2'b00; 
          6'b100101: data <= 2'b00; 
          6'b100110: data <= 2'b00; 
          6'b100111: data <= 2'b00; 
          6'b101000: data <= 2'b11; 
          6'b101001: data <= 2'b11; 
          6'b101010: data <= 2'b11; 
          6'b101011: data <= 2'b11; 
          6'b101100: data <= 2'b11; 
          6'b101101: data <= 2'b11; 
          6'b101110: data <= 2'b11; 
          6'b101111: data <= 2'b11; 
          6'b110000: data <= 2'b00; 
          6'b110001: data <= 2'b00; 
          6'b110010: data <= 2'b00; 
          6'b110011: data <= 2'b00; 
          6'b110100: data <= 2'b00; 
          6'b110101: data <= 2'b00; 
          6'b110110: data <= 2'b00; 
          6'b110111: data <= 2'b00; 
          6'b111000: data <= 2'b11; 
          6'b111001: data <= 2'b11; 
          6'b111010: data <= 2'b11; 
          6'b111011: data <= 2'b11; 
          6'b111100: data <= 2'b11; 
          6'b111101: data <= 2'b11; 
          6'b111110: data <= 2'b11; 
          6'b111111: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st1_per256L(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [5:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st1_per256L ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 6'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 6'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {6{1'b1}}) begin         
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
  parameter DATA_WIDTH = 16;                                
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
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
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
  switches_stage_st0_256_L switch_stage_0(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), 
        .outData_0(wire_con_in_stage0[0]), .outData_1(wire_con_in_stage0[1]), .outData_2(wire_con_in_stage0[2]), .outData_3(wire_con_in_stage0[3]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp4_st0_L wire_stage_0(
        .inData_0(wire_con_in_stage0[0]), .inData_1(wire_con_in_stage0[1]), .inData_2(wire_con_in_stage0[2]), .inData_3(wire_con_in_stage0[3]), 
        .outData_0(wire_con_out_stage0[0]), .outData_1(wire_con_out_stage0[1]), .outData_2(wire_con_out_stage0[2]), .outData_3(wire_con_out_stage0[3]), 
        .in_start(con_in_start_stage0), .out_start(in_start_stage1), .clk(clk), .rst(rst)); 

  
  switch_ctrl_dp4_st0_per256L switch_ctrl_stage_0(.in_start(in_start_stage0),.ctrl_out(wire_ctrl_stage0),.clk(clk), .rst(rst));

  wire [DATA_WIDTH-1:0] wire_con_in_stage1[3:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage1[3:0];
  wire [1:0] wire_ctrl_stage1;
  switches_stage_st1_256_L_r switch_stage_1(
        .inData_0(wire_con_out_stage0[0]), .inData_1(wire_con_out_stage0[1]), .inData_2(wire_con_out_stage0[2]), .inData_3(wire_con_out_stage0[3]), 
        .outData_0(wire_con_in_stage1[0]), .outData_1(wire_con_in_stage1[1]), .outData_2(wire_con_in_stage1[2]), .outData_3(wire_con_in_stage1[3]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp4_st1_L wire_stage_1(
        .inData_0(wire_con_in_stage1[0]), .inData_1(wire_con_in_stage1[1]), .inData_2(wire_con_in_stage1[2]), .inData_3(wire_con_in_stage1[3]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), 
        .in_start(con_in_start_stage1), .out_start(out_start_w), .clk(clk), .rst(rst)); 

  
  switch_ctrl_dp4_st1_per256L switch_ctrl_stage_1(.in_start(in_start_stage1),.ctrl_out(wire_ctrl_stage1),.clk(clk), .rst(rst));

  
  assign in_start_stage0 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_w;    
  
endmodule                        


module switches_stage_st0_256_R(
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
  parameter DATA_WIDTH = 16;                                
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


module ctrl_rom_dp4_st0_per256R(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [5:0] addr;                        
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
          6'b000000: data <= 2'b00; 
          6'b000001: data <= 2'b00; 
          6'b000010: data <= 2'b00; 
          6'b000011: data <= 2'b00; 
          6'b000100: data <= 2'b11; 
          6'b000101: data <= 2'b11; 
          6'b000110: data <= 2'b11; 
          6'b000111: data <= 2'b11; 
          6'b001000: data <= 2'b00; 
          6'b001001: data <= 2'b00; 
          6'b001010: data <= 2'b00; 
          6'b001011: data <= 2'b00; 
          6'b001100: data <= 2'b11; 
          6'b001101: data <= 2'b11; 
          6'b001110: data <= 2'b11; 
          6'b001111: data <= 2'b11; 
          6'b010000: data <= 2'b00; 
          6'b010001: data <= 2'b00; 
          6'b010010: data <= 2'b00; 
          6'b010011: data <= 2'b00; 
          6'b010100: data <= 2'b11; 
          6'b010101: data <= 2'b11; 
          6'b010110: data <= 2'b11; 
          6'b010111: data <= 2'b11; 
          6'b011000: data <= 2'b00; 
          6'b011001: data <= 2'b00; 
          6'b011010: data <= 2'b00; 
          6'b011011: data <= 2'b00; 
          6'b011100: data <= 2'b11; 
          6'b011101: data <= 2'b11; 
          6'b011110: data <= 2'b11; 
          6'b011111: data <= 2'b11; 
          6'b100000: data <= 2'b00; 
          6'b100001: data <= 2'b00; 
          6'b100010: data <= 2'b00; 
          6'b100011: data <= 2'b00; 
          6'b100100: data <= 2'b11; 
          6'b100101: data <= 2'b11; 
          6'b100110: data <= 2'b11; 
          6'b100111: data <= 2'b11; 
          6'b101000: data <= 2'b00; 
          6'b101001: data <= 2'b00; 
          6'b101010: data <= 2'b00; 
          6'b101011: data <= 2'b00; 
          6'b101100: data <= 2'b11; 
          6'b101101: data <= 2'b11; 
          6'b101110: data <= 2'b11; 
          6'b101111: data <= 2'b11; 
          6'b110000: data <= 2'b00; 
          6'b110001: data <= 2'b00; 
          6'b110010: data <= 2'b00; 
          6'b110011: data <= 2'b00; 
          6'b110100: data <= 2'b11; 
          6'b110101: data <= 2'b11; 
          6'b110110: data <= 2'b11; 
          6'b110111: data <= 2'b11; 
          6'b111000: data <= 2'b00; 
          6'b111001: data <= 2'b00; 
          6'b111010: data <= 2'b00; 
          6'b111011: data <= 2'b00; 
          6'b111100: data <= 2'b11; 
          6'b111101: data <= 2'b11; 
          6'b111110: data <= 2'b11; 
          6'b111111: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st0_per256R(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [5:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st0_per256R ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 6'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 6'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {6{1'b1}}) begin         
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
  parameter DATA_WIDTH = 16;                                
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


module switches_stage_st1_256_R_r(
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
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [2-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  output reg [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output reg out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];              
  wire [DATA_WIDTH-1:0] wireOut [3:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  switch_2_2 switch_inst_1(.inData_0(wireIn[2]), .inData_1(wireIn[3]), .outData_0(wireOut[2]), .outData_1(wireOut[3]), .ctrl(ctrl[1]), .clk(clk), .rst(rst));
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      outData_0 <= 0;    
      outData_1 <= 0;    
      outData_2 <= 0;    
      outData_3 <= 0;    
      out_start <= 1'b0;              
      end
    else begin                        
      outData_0 <= wireOut[0];    
      outData_1 <= wireOut[1];    
      outData_2 <= wireOut[2];    
      outData_3 <= wireOut[3];    
      out_start <= in_start;    
      end
  end                              

endmodule                        


module ctrl_rom_dp4_st1_per256R(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [5:0] addr;                        
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
          6'b000000: data <= 2'b00; 
          6'b000001: data <= 2'b00; 
          6'b000010: data <= 2'b00; 
          6'b000011: data <= 2'b00; 
          6'b000100: data <= 2'b00; 
          6'b000101: data <= 2'b00; 
          6'b000110: data <= 2'b00; 
          6'b000111: data <= 2'b00; 
          6'b001000: data <= 2'b11; 
          6'b001001: data <= 2'b11; 
          6'b001010: data <= 2'b11; 
          6'b001011: data <= 2'b11; 
          6'b001100: data <= 2'b11; 
          6'b001101: data <= 2'b11; 
          6'b001110: data <= 2'b11; 
          6'b001111: data <= 2'b11; 
          6'b010000: data <= 2'b00; 
          6'b010001: data <= 2'b00; 
          6'b010010: data <= 2'b00; 
          6'b010011: data <= 2'b00; 
          6'b010100: data <= 2'b00; 
          6'b010101: data <= 2'b00; 
          6'b010110: data <= 2'b00; 
          6'b010111: data <= 2'b00; 
          6'b011000: data <= 2'b11; 
          6'b011001: data <= 2'b11; 
          6'b011010: data <= 2'b11; 
          6'b011011: data <= 2'b11; 
          6'b011100: data <= 2'b11; 
          6'b011101: data <= 2'b11; 
          6'b011110: data <= 2'b11; 
          6'b011111: data <= 2'b11; 
          6'b100000: data <= 2'b00; 
          6'b100001: data <= 2'b00; 
          6'b100010: data <= 2'b00; 
          6'b100011: data <= 2'b00; 
          6'b100100: data <= 2'b00; 
          6'b100101: data <= 2'b00; 
          6'b100110: data <= 2'b00; 
          6'b100111: data <= 2'b00; 
          6'b101000: data <= 2'b11; 
          6'b101001: data <= 2'b11; 
          6'b101010: data <= 2'b11; 
          6'b101011: data <= 2'b11; 
          6'b101100: data <= 2'b11; 
          6'b101101: data <= 2'b11; 
          6'b101110: data <= 2'b11; 
          6'b101111: data <= 2'b11; 
          6'b110000: data <= 2'b00; 
          6'b110001: data <= 2'b00; 
          6'b110010: data <= 2'b00; 
          6'b110011: data <= 2'b00; 
          6'b110100: data <= 2'b00; 
          6'b110101: data <= 2'b00; 
          6'b110110: data <= 2'b00; 
          6'b110111: data <= 2'b00; 
          6'b111000: data <= 2'b11; 
          6'b111001: data <= 2'b11; 
          6'b111010: data <= 2'b11; 
          6'b111011: data <= 2'b11; 
          6'b111100: data <= 2'b11; 
          6'b111101: data <= 2'b11; 
          6'b111110: data <= 2'b11; 
          6'b111111: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st1_per256R(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [5:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st1_per256R ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 6'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 6'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {6{1'b1}}) begin         
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
  parameter DATA_WIDTH = 16;                                
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
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
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
  wire [1:0] wire_ctrl_stage1;
  switches_stage_st1_256_R_r switch_stage_1(
        .inData_0(wire_switch_in_stage1[0]), .inData_1(wire_switch_in_stage1[1]), .inData_2(wire_switch_in_stage1[2]), .inData_3(wire_switch_in_stage1[3]), 
        .outData_0(wire_switch_out_stage1[0]), .outData_1(wire_switch_out_stage1[1]), .outData_2(wire_switch_out_stage1[2]), .outData_3(wire_switch_out_stage1[3]), 
        .in_start(con_in_start_stage1), .out_start(in_start_stage0), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp4_st1_R wire_stage_1(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), 
        .outData_0(wire_switch_in_stage1[0]), .outData_1(wire_switch_in_stage1[1]), .outData_2(wire_switch_in_stage1[2]), .outData_3(wire_switch_in_stage1[3]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .clk(clk), .rst(rst)); 

  
  switch_ctrl_dp4_st1_per256R switch_ctrl_stage_1(.in_start(con_in_start_stage1),.ctrl_out(wire_ctrl_stage1),.clk(clk), .rst(rst));

  wire [DATA_WIDTH-1:0] wire_switch_in_stage0[3:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage0[3:0];
  wire [1:0] wire_ctrl_stage0;
  switches_stage_st0_256_R switch_stage_0(
        .inData_0(wire_switch_in_stage0[0]), .inData_1(wire_switch_in_stage0[1]), .inData_2(wire_switch_in_stage0[2]), .inData_3(wire_switch_in_stage0[3]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), 
        .in_start(con_in_start_stage0), .out_start(out_start_w), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp4_st0_R wire_stage_0(
        .inData_0(wire_switch_out_stage1[0]), .inData_1(wire_switch_out_stage1[1]), .inData_2(wire_switch_out_stage1[2]), .inData_3(wire_switch_out_stage1[3]), 
        .outData_0(wire_switch_in_stage0[0]), .outData_1(wire_switch_in_stage0[1]), .outData_2(wire_switch_in_stage0[2]), .outData_3(wire_switch_in_stage0[3]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .clk(clk), .rst(rst)); 

  
  switch_ctrl_dp4_st0_per256R switch_ctrl_stage_0(.in_start(con_in_start_stage0),.ctrl_out(wire_ctrl_stage0),.clk(clk), .rst(rst));

  
  assign in_start_stage1 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_w;    
  
endmodule                        


module  counter_64(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [5:0] counter_out;            
  
  reg [5:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 6'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[5:0] == 63) begin  
        status_couting <= 1'b0;                 
        counter_r <= 6'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp4_mem0(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [6:0] addr;                        
  output reg [6:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 7'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          7'b0000000: data <= 7'b0000000; 
          7'b0000001: data <= 7'b0010000; 
          7'b0000010: data <= 7'b0100000; 
          7'b0000011: data <= 7'b0110000; 
          7'b0000100: data <= 7'b0000100; 
          7'b0000101: data <= 7'b0010100; 
          7'b0000110: data <= 7'b0100100; 
          7'b0000111: data <= 7'b0110100; 
          7'b0001000: data <= 7'b0001000; 
          7'b0001001: data <= 7'b0011000; 
          7'b0001010: data <= 7'b0101000; 
          7'b0001011: data <= 7'b0111000; 
          7'b0001100: data <= 7'b0001100; 
          7'b0001101: data <= 7'b0011100; 
          7'b0001110: data <= 7'b0101100; 
          7'b0001111: data <= 7'b0111100; 
          7'b0010000: data <= 7'b0000001; 
          7'b0010001: data <= 7'b0010001; 
          7'b0010010: data <= 7'b0100001; 
          7'b0010011: data <= 7'b0110001; 
          7'b0010100: data <= 7'b0000101; 
          7'b0010101: data <= 7'b0010101; 
          7'b0010110: data <= 7'b0100101; 
          7'b0010111: data <= 7'b0110101; 
          7'b0011000: data <= 7'b0001001; 
          7'b0011001: data <= 7'b0011001; 
          7'b0011010: data <= 7'b0101001; 
          7'b0011011: data <= 7'b0111001; 
          7'b0011100: data <= 7'b0001101; 
          7'b0011101: data <= 7'b0011101; 
          7'b0011110: data <= 7'b0101101; 
          7'b0011111: data <= 7'b0111101; 
          7'b0100000: data <= 7'b0000010; 
          7'b0100001: data <= 7'b0010010; 
          7'b0100010: data <= 7'b0100010; 
          7'b0100011: data <= 7'b0110010; 
          7'b0100100: data <= 7'b0000110; 
          7'b0100101: data <= 7'b0010110; 
          7'b0100110: data <= 7'b0100110; 
          7'b0100111: data <= 7'b0110110; 
          7'b0101000: data <= 7'b0001010; 
          7'b0101001: data <= 7'b0011010; 
          7'b0101010: data <= 7'b0101010; 
          7'b0101011: data <= 7'b0111010; 
          7'b0101100: data <= 7'b0001110; 
          7'b0101101: data <= 7'b0011110; 
          7'b0101110: data <= 7'b0101110; 
          7'b0101111: data <= 7'b0111110; 
          7'b0110000: data <= 7'b0000011; 
          7'b0110001: data <= 7'b0010011; 
          7'b0110010: data <= 7'b0100011; 
          7'b0110011: data <= 7'b0110011; 
          7'b0110100: data <= 7'b0000111; 
          7'b0110101: data <= 7'b0010111; 
          7'b0110110: data <= 7'b0100111; 
          7'b0110111: data <= 7'b0110111; 
          7'b0111000: data <= 7'b0001011; 
          7'b0111001: data <= 7'b0011011; 
          7'b0111010: data <= 7'b0101011; 
          7'b0111011: data <= 7'b0111011; 
          7'b0111100: data <= 7'b0001111; 
          7'b0111101: data <= 7'b0011111; 
          7'b0111110: data <= 7'b0101111; 
          7'b0111111: data <= 7'b0111111; 
          7'b1000000: data <= 7'b0000000; 
          7'b1000001: data <= 7'b0000001; 
          7'b1000010: data <= 7'b0000010; 
          7'b1000011: data <= 7'b0000011; 
          7'b1000100: data <= 7'b0000100; 
          7'b1000101: data <= 7'b0000101; 
          7'b1000110: data <= 7'b0000110; 
          7'b1000111: data <= 7'b0000111; 
          7'b1001000: data <= 7'b0001000; 
          7'b1001001: data <= 7'b0001001; 
          7'b1001010: data <= 7'b0001010; 
          7'b1001011: data <= 7'b0001011; 
          7'b1001100: data <= 7'b0001100; 
          7'b1001101: data <= 7'b0001101; 
          7'b1001110: data <= 7'b0001110; 
          7'b1001111: data <= 7'b0001111; 
          7'b1010000: data <= 7'b0010000; 
          7'b1010001: data <= 7'b0010001; 
          7'b1010010: data <= 7'b0010010; 
          7'b1010011: data <= 7'b0010011; 
          7'b1010100: data <= 7'b0010100; 
          7'b1010101: data <= 7'b0010101; 
          7'b1010110: data <= 7'b0010110; 
          7'b1010111: data <= 7'b0010111; 
          7'b1011000: data <= 7'b0011000; 
          7'b1011001: data <= 7'b0011001; 
          7'b1011010: data <= 7'b0011010; 
          7'b1011011: data <= 7'b0011011; 
          7'b1011100: data <= 7'b0011100; 
          7'b1011101: data <= 7'b0011101; 
          7'b1011110: data <= 7'b0011110; 
          7'b1011111: data <= 7'b0011111; 
          7'b1100000: data <= 7'b0100000; 
          7'b1100001: data <= 7'b0100001; 
          7'b1100010: data <= 7'b0100010; 
          7'b1100011: data <= 7'b0100011; 
          7'b1100100: data <= 7'b0100100; 
          7'b1100101: data <= 7'b0100101; 
          7'b1100110: data <= 7'b0100110; 
          7'b1100111: data <= 7'b0100111; 
          7'b1101000: data <= 7'b0101000; 
          7'b1101001: data <= 7'b0101001; 
          7'b1101010: data <= 7'b0101010; 
          7'b1101011: data <= 7'b0101011; 
          7'b1101100: data <= 7'b0101100; 
          7'b1101101: data <= 7'b0101101; 
          7'b1101110: data <= 7'b0101110; 
          7'b1101111: data <= 7'b0101111; 
          7'b1110000: data <= 7'b0110000; 
          7'b1110001: data <= 7'b0110001; 
          7'b1110010: data <= 7'b0110010; 
          7'b1110011: data <= 7'b0110011; 
          7'b1110100: data <= 7'b0110100; 
          7'b1110101: data <= 7'b0110101; 
          7'b1110110: data <= 7'b0110110; 
          7'b1110111: data <= 7'b0110111; 
          7'b1111000: data <= 7'b0111000; 
          7'b1111001: data <= 7'b0111001; 
          7'b1111010: data <= 7'b0111010; 
          7'b1111011: data <= 7'b0111011; 
          7'b1111100: data <= 7'b0111100; 
          7'b1111101: data <= 7'b0111101; 
          7'b1111110: data <= 7'b0111110; 
          7'b1111111: data <= 7'b0111111; 
          default: data <= 7'b0; 
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
  input [6:0] addr;                        
  output reg [6:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 7'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          7'b0000000: data <= 7'b0001000; 
          7'b0000001: data <= 7'b0011000; 
          7'b0000010: data <= 7'b0101000; 
          7'b0000011: data <= 7'b0111000; 
          7'b0000100: data <= 7'b0001100; 
          7'b0000101: data <= 7'b0011100; 
          7'b0000110: data <= 7'b0101100; 
          7'b0000111: data <= 7'b0111100; 
          7'b0001000: data <= 7'b0000000; 
          7'b0001001: data <= 7'b0010000; 
          7'b0001010: data <= 7'b0100000; 
          7'b0001011: data <= 7'b0110000; 
          7'b0001100: data <= 7'b0000100; 
          7'b0001101: data <= 7'b0010100; 
          7'b0001110: data <= 7'b0100100; 
          7'b0001111: data <= 7'b0110100; 
          7'b0010000: data <= 7'b0001001; 
          7'b0010001: data <= 7'b0011001; 
          7'b0010010: data <= 7'b0101001; 
          7'b0010011: data <= 7'b0111001; 
          7'b0010100: data <= 7'b0001101; 
          7'b0010101: data <= 7'b0011101; 
          7'b0010110: data <= 7'b0101101; 
          7'b0010111: data <= 7'b0111101; 
          7'b0011000: data <= 7'b0000001; 
          7'b0011001: data <= 7'b0010001; 
          7'b0011010: data <= 7'b0100001; 
          7'b0011011: data <= 7'b0110001; 
          7'b0011100: data <= 7'b0000101; 
          7'b0011101: data <= 7'b0010101; 
          7'b0011110: data <= 7'b0100101; 
          7'b0011111: data <= 7'b0110101; 
          7'b0100000: data <= 7'b0001010; 
          7'b0100001: data <= 7'b0011010; 
          7'b0100010: data <= 7'b0101010; 
          7'b0100011: data <= 7'b0111010; 
          7'b0100100: data <= 7'b0001110; 
          7'b0100101: data <= 7'b0011110; 
          7'b0100110: data <= 7'b0101110; 
          7'b0100111: data <= 7'b0111110; 
          7'b0101000: data <= 7'b0000010; 
          7'b0101001: data <= 7'b0010010; 
          7'b0101010: data <= 7'b0100010; 
          7'b0101011: data <= 7'b0110010; 
          7'b0101100: data <= 7'b0000110; 
          7'b0101101: data <= 7'b0010110; 
          7'b0101110: data <= 7'b0100110; 
          7'b0101111: data <= 7'b0110110; 
          7'b0110000: data <= 7'b0001011; 
          7'b0110001: data <= 7'b0011011; 
          7'b0110010: data <= 7'b0101011; 
          7'b0110011: data <= 7'b0111011; 
          7'b0110100: data <= 7'b0001111; 
          7'b0110101: data <= 7'b0011111; 
          7'b0110110: data <= 7'b0101111; 
          7'b0110111: data <= 7'b0111111; 
          7'b0111000: data <= 7'b0000011; 
          7'b0111001: data <= 7'b0010011; 
          7'b0111010: data <= 7'b0100011; 
          7'b0111011: data <= 7'b0110011; 
          7'b0111100: data <= 7'b0000111; 
          7'b0111101: data <= 7'b0010111; 
          7'b0111110: data <= 7'b0100111; 
          7'b0111111: data <= 7'b0110111; 
          7'b1000000: data <= 7'b0000000; 
          7'b1000001: data <= 7'b0000001; 
          7'b1000010: data <= 7'b0000010; 
          7'b1000011: data <= 7'b0000011; 
          7'b1000100: data <= 7'b0000100; 
          7'b1000101: data <= 7'b0000101; 
          7'b1000110: data <= 7'b0000110; 
          7'b1000111: data <= 7'b0000111; 
          7'b1001000: data <= 7'b0001000; 
          7'b1001001: data <= 7'b0001001; 
          7'b1001010: data <= 7'b0001010; 
          7'b1001011: data <= 7'b0001011; 
          7'b1001100: data <= 7'b0001100; 
          7'b1001101: data <= 7'b0001101; 
          7'b1001110: data <= 7'b0001110; 
          7'b1001111: data <= 7'b0001111; 
          7'b1010000: data <= 7'b0010000; 
          7'b1010001: data <= 7'b0010001; 
          7'b1010010: data <= 7'b0010010; 
          7'b1010011: data <= 7'b0010011; 
          7'b1010100: data <= 7'b0010100; 
          7'b1010101: data <= 7'b0010101; 
          7'b1010110: data <= 7'b0010110; 
          7'b1010111: data <= 7'b0010111; 
          7'b1011000: data <= 7'b0011000; 
          7'b1011001: data <= 7'b0011001; 
          7'b1011010: data <= 7'b0011010; 
          7'b1011011: data <= 7'b0011011; 
          7'b1011100: data <= 7'b0011100; 
          7'b1011101: data <= 7'b0011101; 
          7'b1011110: data <= 7'b0011110; 
          7'b1011111: data <= 7'b0011111; 
          7'b1100000: data <= 7'b0100000; 
          7'b1100001: data <= 7'b0100001; 
          7'b1100010: data <= 7'b0100010; 
          7'b1100011: data <= 7'b0100011; 
          7'b1100100: data <= 7'b0100100; 
          7'b1100101: data <= 7'b0100101; 
          7'b1100110: data <= 7'b0100110; 
          7'b1100111: data <= 7'b0100111; 
          7'b1101000: data <= 7'b0101000; 
          7'b1101001: data <= 7'b0101001; 
          7'b1101010: data <= 7'b0101010; 
          7'b1101011: data <= 7'b0101011; 
          7'b1101100: data <= 7'b0101100; 
          7'b1101101: data <= 7'b0101101; 
          7'b1101110: data <= 7'b0101110; 
          7'b1101111: data <= 7'b0101111; 
          7'b1110000: data <= 7'b0110000; 
          7'b1110001: data <= 7'b0110001; 
          7'b1110010: data <= 7'b0110010; 
          7'b1110011: data <= 7'b0110011; 
          7'b1110100: data <= 7'b0110100; 
          7'b1110101: data <= 7'b0110101; 
          7'b1110110: data <= 7'b0110110; 
          7'b1110111: data <= 7'b0110111; 
          7'b1111000: data <= 7'b0111000; 
          7'b1111001: data <= 7'b0111001; 
          7'b1111010: data <= 7'b0111010; 
          7'b1111011: data <= 7'b0111011; 
          7'b1111100: data <= 7'b0111100; 
          7'b1111101: data <= 7'b0111101; 
          7'b1111110: data <= 7'b0111110; 
          7'b1111111: data <= 7'b0111111; 
          default: data <= 7'b0; 
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
  input [6:0] addr;                        
  output reg [6:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 7'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          7'b0000000: data <= 7'b0000100; 
          7'b0000001: data <= 7'b0010100; 
          7'b0000010: data <= 7'b0100100; 
          7'b0000011: data <= 7'b0110100; 
          7'b0000100: data <= 7'b0000000; 
          7'b0000101: data <= 7'b0010000; 
          7'b0000110: data <= 7'b0100000; 
          7'b0000111: data <= 7'b0110000; 
          7'b0001000: data <= 7'b0001100; 
          7'b0001001: data <= 7'b0011100; 
          7'b0001010: data <= 7'b0101100; 
          7'b0001011: data <= 7'b0111100; 
          7'b0001100: data <= 7'b0001000; 
          7'b0001101: data <= 7'b0011000; 
          7'b0001110: data <= 7'b0101000; 
          7'b0001111: data <= 7'b0111000; 
          7'b0010000: data <= 7'b0000101; 
          7'b0010001: data <= 7'b0010101; 
          7'b0010010: data <= 7'b0100101; 
          7'b0010011: data <= 7'b0110101; 
          7'b0010100: data <= 7'b0000001; 
          7'b0010101: data <= 7'b0010001; 
          7'b0010110: data <= 7'b0100001; 
          7'b0010111: data <= 7'b0110001; 
          7'b0011000: data <= 7'b0001101; 
          7'b0011001: data <= 7'b0011101; 
          7'b0011010: data <= 7'b0101101; 
          7'b0011011: data <= 7'b0111101; 
          7'b0011100: data <= 7'b0001001; 
          7'b0011101: data <= 7'b0011001; 
          7'b0011110: data <= 7'b0101001; 
          7'b0011111: data <= 7'b0111001; 
          7'b0100000: data <= 7'b0000110; 
          7'b0100001: data <= 7'b0010110; 
          7'b0100010: data <= 7'b0100110; 
          7'b0100011: data <= 7'b0110110; 
          7'b0100100: data <= 7'b0000010; 
          7'b0100101: data <= 7'b0010010; 
          7'b0100110: data <= 7'b0100010; 
          7'b0100111: data <= 7'b0110010; 
          7'b0101000: data <= 7'b0001110; 
          7'b0101001: data <= 7'b0011110; 
          7'b0101010: data <= 7'b0101110; 
          7'b0101011: data <= 7'b0111110; 
          7'b0101100: data <= 7'b0001010; 
          7'b0101101: data <= 7'b0011010; 
          7'b0101110: data <= 7'b0101010; 
          7'b0101111: data <= 7'b0111010; 
          7'b0110000: data <= 7'b0000111; 
          7'b0110001: data <= 7'b0010111; 
          7'b0110010: data <= 7'b0100111; 
          7'b0110011: data <= 7'b0110111; 
          7'b0110100: data <= 7'b0000011; 
          7'b0110101: data <= 7'b0010011; 
          7'b0110110: data <= 7'b0100011; 
          7'b0110111: data <= 7'b0110011; 
          7'b0111000: data <= 7'b0001111; 
          7'b0111001: data <= 7'b0011111; 
          7'b0111010: data <= 7'b0101111; 
          7'b0111011: data <= 7'b0111111; 
          7'b0111100: data <= 7'b0001011; 
          7'b0111101: data <= 7'b0011011; 
          7'b0111110: data <= 7'b0101011; 
          7'b0111111: data <= 7'b0111011; 
          7'b1000000: data <= 7'b0000000; 
          7'b1000001: data <= 7'b0000001; 
          7'b1000010: data <= 7'b0000010; 
          7'b1000011: data <= 7'b0000011; 
          7'b1000100: data <= 7'b0000100; 
          7'b1000101: data <= 7'b0000101; 
          7'b1000110: data <= 7'b0000110; 
          7'b1000111: data <= 7'b0000111; 
          7'b1001000: data <= 7'b0001000; 
          7'b1001001: data <= 7'b0001001; 
          7'b1001010: data <= 7'b0001010; 
          7'b1001011: data <= 7'b0001011; 
          7'b1001100: data <= 7'b0001100; 
          7'b1001101: data <= 7'b0001101; 
          7'b1001110: data <= 7'b0001110; 
          7'b1001111: data <= 7'b0001111; 
          7'b1010000: data <= 7'b0010000; 
          7'b1010001: data <= 7'b0010001; 
          7'b1010010: data <= 7'b0010010; 
          7'b1010011: data <= 7'b0010011; 
          7'b1010100: data <= 7'b0010100; 
          7'b1010101: data <= 7'b0010101; 
          7'b1010110: data <= 7'b0010110; 
          7'b1010111: data <= 7'b0010111; 
          7'b1011000: data <= 7'b0011000; 
          7'b1011001: data <= 7'b0011001; 
          7'b1011010: data <= 7'b0011010; 
          7'b1011011: data <= 7'b0011011; 
          7'b1011100: data <= 7'b0011100; 
          7'b1011101: data <= 7'b0011101; 
          7'b1011110: data <= 7'b0011110; 
          7'b1011111: data <= 7'b0011111; 
          7'b1100000: data <= 7'b0100000; 
          7'b1100001: data <= 7'b0100001; 
          7'b1100010: data <= 7'b0100010; 
          7'b1100011: data <= 7'b0100011; 
          7'b1100100: data <= 7'b0100100; 
          7'b1100101: data <= 7'b0100101; 
          7'b1100110: data <= 7'b0100110; 
          7'b1100111: data <= 7'b0100111; 
          7'b1101000: data <= 7'b0101000; 
          7'b1101001: data <= 7'b0101001; 
          7'b1101010: data <= 7'b0101010; 
          7'b1101011: data <= 7'b0101011; 
          7'b1101100: data <= 7'b0101100; 
          7'b1101101: data <= 7'b0101101; 
          7'b1101110: data <= 7'b0101110; 
          7'b1101111: data <= 7'b0101111; 
          7'b1110000: data <= 7'b0110000; 
          7'b1110001: data <= 7'b0110001; 
          7'b1110010: data <= 7'b0110010; 
          7'b1110011: data <= 7'b0110011; 
          7'b1110100: data <= 7'b0110100; 
          7'b1110101: data <= 7'b0110101; 
          7'b1110110: data <= 7'b0110110; 
          7'b1110111: data <= 7'b0110111; 
          7'b1111000: data <= 7'b0111000; 
          7'b1111001: data <= 7'b0111001; 
          7'b1111010: data <= 7'b0111010; 
          7'b1111011: data <= 7'b0111011; 
          7'b1111100: data <= 7'b0111100; 
          7'b1111101: data <= 7'b0111101; 
          7'b1111110: data <= 7'b0111110; 
          7'b1111111: data <= 7'b0111111; 
          default: data <= 7'b0; 
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
  input [6:0] addr;                        
  output reg [6:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 7'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          7'b0000000: data <= 7'b0001100; 
          7'b0000001: data <= 7'b0011100; 
          7'b0000010: data <= 7'b0101100; 
          7'b0000011: data <= 7'b0111100; 
          7'b0000100: data <= 7'b0001000; 
          7'b0000101: data <= 7'b0011000; 
          7'b0000110: data <= 7'b0101000; 
          7'b0000111: data <= 7'b0111000; 
          7'b0001000: data <= 7'b0000100; 
          7'b0001001: data <= 7'b0010100; 
          7'b0001010: data <= 7'b0100100; 
          7'b0001011: data <= 7'b0110100; 
          7'b0001100: data <= 7'b0000000; 
          7'b0001101: data <= 7'b0010000; 
          7'b0001110: data <= 7'b0100000; 
          7'b0001111: data <= 7'b0110000; 
          7'b0010000: data <= 7'b0001101; 
          7'b0010001: data <= 7'b0011101; 
          7'b0010010: data <= 7'b0101101; 
          7'b0010011: data <= 7'b0111101; 
          7'b0010100: data <= 7'b0001001; 
          7'b0010101: data <= 7'b0011001; 
          7'b0010110: data <= 7'b0101001; 
          7'b0010111: data <= 7'b0111001; 
          7'b0011000: data <= 7'b0000101; 
          7'b0011001: data <= 7'b0010101; 
          7'b0011010: data <= 7'b0100101; 
          7'b0011011: data <= 7'b0110101; 
          7'b0011100: data <= 7'b0000001; 
          7'b0011101: data <= 7'b0010001; 
          7'b0011110: data <= 7'b0100001; 
          7'b0011111: data <= 7'b0110001; 
          7'b0100000: data <= 7'b0001110; 
          7'b0100001: data <= 7'b0011110; 
          7'b0100010: data <= 7'b0101110; 
          7'b0100011: data <= 7'b0111110; 
          7'b0100100: data <= 7'b0001010; 
          7'b0100101: data <= 7'b0011010; 
          7'b0100110: data <= 7'b0101010; 
          7'b0100111: data <= 7'b0111010; 
          7'b0101000: data <= 7'b0000110; 
          7'b0101001: data <= 7'b0010110; 
          7'b0101010: data <= 7'b0100110; 
          7'b0101011: data <= 7'b0110110; 
          7'b0101100: data <= 7'b0000010; 
          7'b0101101: data <= 7'b0010010; 
          7'b0101110: data <= 7'b0100010; 
          7'b0101111: data <= 7'b0110010; 
          7'b0110000: data <= 7'b0001111; 
          7'b0110001: data <= 7'b0011111; 
          7'b0110010: data <= 7'b0101111; 
          7'b0110011: data <= 7'b0111111; 
          7'b0110100: data <= 7'b0001011; 
          7'b0110101: data <= 7'b0011011; 
          7'b0110110: data <= 7'b0101011; 
          7'b0110111: data <= 7'b0111011; 
          7'b0111000: data <= 7'b0000111; 
          7'b0111001: data <= 7'b0010111; 
          7'b0111010: data <= 7'b0100111; 
          7'b0111011: data <= 7'b0110111; 
          7'b0111100: data <= 7'b0000011; 
          7'b0111101: data <= 7'b0010011; 
          7'b0111110: data <= 7'b0100011; 
          7'b0111111: data <= 7'b0110011; 
          7'b1000000: data <= 7'b0000000; 
          7'b1000001: data <= 7'b0000001; 
          7'b1000010: data <= 7'b0000010; 
          7'b1000011: data <= 7'b0000011; 
          7'b1000100: data <= 7'b0000100; 
          7'b1000101: data <= 7'b0000101; 
          7'b1000110: data <= 7'b0000110; 
          7'b1000111: data <= 7'b0000111; 
          7'b1001000: data <= 7'b0001000; 
          7'b1001001: data <= 7'b0001001; 
          7'b1001010: data <= 7'b0001010; 
          7'b1001011: data <= 7'b0001011; 
          7'b1001100: data <= 7'b0001100; 
          7'b1001101: data <= 7'b0001101; 
          7'b1001110: data <= 7'b0001110; 
          7'b1001111: data <= 7'b0001111; 
          7'b1010000: data <= 7'b0010000; 
          7'b1010001: data <= 7'b0010001; 
          7'b1010010: data <= 7'b0010010; 
          7'b1010011: data <= 7'b0010011; 
          7'b1010100: data <= 7'b0010100; 
          7'b1010101: data <= 7'b0010101; 
          7'b1010110: data <= 7'b0010110; 
          7'b1010111: data <= 7'b0010111; 
          7'b1011000: data <= 7'b0011000; 
          7'b1011001: data <= 7'b0011001; 
          7'b1011010: data <= 7'b0011010; 
          7'b1011011: data <= 7'b0011011; 
          7'b1011100: data <= 7'b0011100; 
          7'b1011101: data <= 7'b0011101; 
          7'b1011110: data <= 7'b0011110; 
          7'b1011111: data <= 7'b0011111; 
          7'b1100000: data <= 7'b0100000; 
          7'b1100001: data <= 7'b0100001; 
          7'b1100010: data <= 7'b0100010; 
          7'b1100011: data <= 7'b0100011; 
          7'b1100100: data <= 7'b0100100; 
          7'b1100101: data <= 7'b0100101; 
          7'b1100110: data <= 7'b0100110; 
          7'b1100111: data <= 7'b0100111; 
          7'b1101000: data <= 7'b0101000; 
          7'b1101001: data <= 7'b0101001; 
          7'b1101010: data <= 7'b0101010; 
          7'b1101011: data <= 7'b0101011; 
          7'b1101100: data <= 7'b0101100; 
          7'b1101101: data <= 7'b0101101; 
          7'b1101110: data <= 7'b0101110; 
          7'b1101111: data <= 7'b0101111; 
          7'b1110000: data <= 7'b0110000; 
          7'b1110001: data <= 7'b0110001; 
          7'b1110010: data <= 7'b0110010; 
          7'b1110011: data <= 7'b0110011; 
          7'b1110100: data <= 7'b0110100; 
          7'b1110101: data <= 7'b0110101; 
          7'b1110110: data <= 7'b0110110; 
          7'b1110111: data <= 7'b0110111; 
          7'b1111000: data <= 7'b0111000; 
          7'b1111001: data <= 7'b0111001; 
          7'b1111010: data <= 7'b0111010; 
          7'b1111011: data <= 7'b0111011; 
          7'b1111100: data <= 7'b0111100; 
          7'b1111101: data <= 7'b0111101; 
          7'b1111110: data <= 7'b0111110; 
          7'b1111111: data <= 7'b0111111; 
          default: data <= 7'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp4_per256(
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
  output [6:0] rom_out_0;            
  output [6:0] rom_out_1;            
  output [6:0] rom_out_2;            
  output [6:0] rom_out_3;            
  output wen_out;
  output out_start;
  
  reg [6:0] rom_addr_0;        
  reg [1:0] state;        
  
  addr_rom_dp4_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp4_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_1)); 
  addr_rom_dp4_mem2 addr_rom_inst_2(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_2)); 
  addr_rom_dp4_mem3 addr_rom_inst_3(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_3)); 
  
  assign wen_out = state[0];        
  assign out_start = (state == 2'b01) && (rom_addr_0[5:0] == {6{1'b0}}); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 7'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case (state)              
        2'b00: begin              
          rom_addr_0 <= 7'b0;   
          if (in_start)  begin              
            state <= 2'b01;              
            rom_addr_0 <= rom_addr_0 + 1;    
          end
        end
        2'b01: begin              
          rom_addr_0 <= rom_addr_0 + 1;    
          if (rom_addr_0 == {6{1'b0}})  begin 
            state <= 2'b11;              
          end
        end
        2'b11: begin              
          rom_addr_0 <= rom_addr_0 + 1;    
          if (in_start)  begin              
            state <= 2'b01;              
          end
          else if (rom_addr_0 == {6{1'b0}})  begin 
            state <= 2'b00;              
          end
        end
        default: state <= 2'b00;       
      endcase
    end
  end                              

endmodule                        


module mem_stage_dp4_r(
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
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  output reg [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3;
  output reg out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [3:0];              
  wire [DATA_WIDTH-1:0] wire_out [3:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  assign wire_in[2] = inData_2;    
  assign wire_in[3] = inData_3;    
  
  wire [5:0] addr_wire_0;        
  wire [5:0] addr_wire_1;        
  wire [5:0] addr_wire_2;        
  wire [5:0] addr_wire_3;        
  addr_rom_ctrl_dp4_per256 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .rom_out_2(addr_wire_2), .rom_out_3(addr_wire_3), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(6)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(6)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(6)) 
         ram_inst_2(.wen(wen_wire), .addr(addr_wire_2), .din(wire_in[2]), .dout(wire_out[2]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(6)) 
         ram_inst_3(.wen(wen_wire), .addr(addr_wire_3), .din(wire_in[3]), .dout(wire_out[3]), .clk(clk) );

  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      outData_0 <= 0;    
      outData_1 <= 0;    
      outData_2 <= 0;    
      outData_3 <= 0;    
      out_start <= 1'b0;              
      end
    else begin                        
      outData_0 <= wire_out[0];    
      outData_1 <= wire_out[1];    
      outData_2 <= wire_out[2];    
      outData_3 <= wire_out[3];    
      out_start <= out_start_wire;    
      end
  end                              

endmodule                        


module per_dp4_256_r(
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
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1,
      inData_2,
      inData_3;
  output reg [DATA_WIDTH-1:0] outData_0,
      outData_1,
      outData_2,
      outData_3; 
  output reg out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [3:0];                  
  wire [DATA_WIDTH-1:0] wireOut [3:0];                 
  wire [DATA_WIDTH-1:0] wireOut_LB [3:0];              
  wire [DATA_WIDTH-1:0] wireIn_RB [3:0];               
  wire out_start_LB;               
  wire out_start_MemStage;               
  wire out_start_RB;               

  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  ingressStage_p4 ingressStage_p4_inst(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), .outData_0(wireOut_LB[0]), .outData_1(wireOut_LB[1]), .outData_2(wireOut_LB[2]), .outData_3(wireOut_LB[3]), .in_start(in_start), .out_start(out_start_LB), .clk(clk), .rst(rst));
  
  mem_stage_dp4_r mem_stage_dp4_r_inst(.inData_0(wireOut_LB[0]), .inData_1(wireOut_LB[1]), .inData_2(wireOut_LB[2]), .inData_3(wireOut_LB[3]), .outData_0(wireIn_RB[0]), .outData_1(wireIn_RB[1]), .outData_2(wireIn_RB[2]), .outData_3(wireIn_RB[3]), .in_start(out_start_LB), .out_start(out_start_MemStage), .clk(clk), .rst(rst));
  
  egressStage_p4 egressStage_p4_inst(.inData_0(wireIn_RB[0]), .inData_1(wireIn_RB[1]), .inData_2(wireIn_RB[2]), .inData_3(wireIn_RB[3]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), .in_start(out_start_MemStage), .out_start(out_start_RB), .clk(clk), .rst(rst));
  
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      outData_0 <= 0;    
      outData_1 <= 0;    
      outData_2 <= 0;    
      outData_3 <= 0;    
      out_start <= 1'b0;    
      end
    else begin                        
      outData_0 <= wireOut[0];    
      outData_1 <= wireOut[1];    
      outData_2 <= wireOut[2];    
      outData_3 <= wireOut[3];    
      out_start <= out_start_RB;    
      end
  end                              

endmodule                        

