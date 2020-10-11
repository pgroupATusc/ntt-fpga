

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
  parameter ADDR_WIDTH = 8;                                
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
  parameter ADDR_WIDTH = 8;                                
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
  parameter ADDR_WIDTH = 8;                                
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
  parameter ADDR_WIDTH = 8;                                
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


module switches_stage_st0_5_L_r(
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


module ctrl_rom_dp4_st0_per5L(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [7:0] addr;                        
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
          8'b00000000: data <= 2'b00; 
          8'b00000001: data <= 2'b00; 
          8'b00000010: data <= 2'b00; 
          8'b00000011: data <= 2'b00; 
          8'b00000100: data <= 2'b00; 
          8'b00000101: data <= 2'b00; 
          8'b00000110: data <= 2'b00; 
          8'b00000111: data <= 2'b00; 
          8'b00001000: data <= 2'b00; 
          8'b00001001: data <= 2'b00; 
          8'b00001010: data <= 2'b00; 
          8'b00001011: data <= 2'b00; 
          8'b00001100: data <= 2'b00; 
          8'b00001101: data <= 2'b00; 
          8'b00001110: data <= 2'b00; 
          8'b00001111: data <= 2'b00; 
          8'b00010000: data <= 2'b00; 
          8'b00010001: data <= 2'b00; 
          8'b00010010: data <= 2'b00; 
          8'b00010011: data <= 2'b00; 
          8'b00010100: data <= 2'b00; 
          8'b00010101: data <= 2'b00; 
          8'b00010110: data <= 2'b00; 
          8'b00010111: data <= 2'b00; 
          8'b00011000: data <= 2'b00; 
          8'b00011001: data <= 2'b00; 
          8'b00011010: data <= 2'b00; 
          8'b00011011: data <= 2'b00; 
          8'b00011100: data <= 2'b00; 
          8'b00011101: data <= 2'b00; 
          8'b00011110: data <= 2'b00; 
          8'b00011111: data <= 2'b00; 
          8'b00100000: data <= 2'b00; 
          8'b00100001: data <= 2'b00; 
          8'b00100010: data <= 2'b00; 
          8'b00100011: data <= 2'b00; 
          8'b00100100: data <= 2'b00; 
          8'b00100101: data <= 2'b00; 
          8'b00100110: data <= 2'b00; 
          8'b00100111: data <= 2'b00; 
          8'b00101000: data <= 2'b00; 
          8'b00101001: data <= 2'b00; 
          8'b00101010: data <= 2'b00; 
          8'b00101011: data <= 2'b00; 
          8'b00101100: data <= 2'b00; 
          8'b00101101: data <= 2'b00; 
          8'b00101110: data <= 2'b00; 
          8'b00101111: data <= 2'b00; 
          8'b00110000: data <= 2'b00; 
          8'b00110001: data <= 2'b00; 
          8'b00110010: data <= 2'b00; 
          8'b00110011: data <= 2'b00; 
          8'b00110100: data <= 2'b00; 
          8'b00110101: data <= 2'b00; 
          8'b00110110: data <= 2'b00; 
          8'b00110111: data <= 2'b00; 
          8'b00111000: data <= 2'b00; 
          8'b00111001: data <= 2'b00; 
          8'b00111010: data <= 2'b00; 
          8'b00111011: data <= 2'b00; 
          8'b00111100: data <= 2'b00; 
          8'b00111101: data <= 2'b00; 
          8'b00111110: data <= 2'b00; 
          8'b00111111: data <= 2'b00; 
          8'b01000000: data <= 2'b00; 
          8'b01000001: data <= 2'b00; 
          8'b01000010: data <= 2'b00; 
          8'b01000011: data <= 2'b00; 
          8'b01000100: data <= 2'b00; 
          8'b01000101: data <= 2'b00; 
          8'b01000110: data <= 2'b00; 
          8'b01000111: data <= 2'b00; 
          8'b01001000: data <= 2'b00; 
          8'b01001001: data <= 2'b00; 
          8'b01001010: data <= 2'b00; 
          8'b01001011: data <= 2'b00; 
          8'b01001100: data <= 2'b00; 
          8'b01001101: data <= 2'b00; 
          8'b01001110: data <= 2'b00; 
          8'b01001111: data <= 2'b00; 
          8'b01010000: data <= 2'b00; 
          8'b01010001: data <= 2'b00; 
          8'b01010010: data <= 2'b00; 
          8'b01010011: data <= 2'b00; 
          8'b01010100: data <= 2'b00; 
          8'b01010101: data <= 2'b00; 
          8'b01010110: data <= 2'b00; 
          8'b01010111: data <= 2'b00; 
          8'b01011000: data <= 2'b00; 
          8'b01011001: data <= 2'b00; 
          8'b01011010: data <= 2'b00; 
          8'b01011011: data <= 2'b00; 
          8'b01011100: data <= 2'b00; 
          8'b01011101: data <= 2'b00; 
          8'b01011110: data <= 2'b00; 
          8'b01011111: data <= 2'b00; 
          8'b01100000: data <= 2'b00; 
          8'b01100001: data <= 2'b00; 
          8'b01100010: data <= 2'b00; 
          8'b01100011: data <= 2'b00; 
          8'b01100100: data <= 2'b00; 
          8'b01100101: data <= 2'b00; 
          8'b01100110: data <= 2'b00; 
          8'b01100111: data <= 2'b00; 
          8'b01101000: data <= 2'b00; 
          8'b01101001: data <= 2'b00; 
          8'b01101010: data <= 2'b00; 
          8'b01101011: data <= 2'b00; 
          8'b01101100: data <= 2'b00; 
          8'b01101101: data <= 2'b00; 
          8'b01101110: data <= 2'b00; 
          8'b01101111: data <= 2'b00; 
          8'b01110000: data <= 2'b00; 
          8'b01110001: data <= 2'b00; 
          8'b01110010: data <= 2'b00; 
          8'b01110011: data <= 2'b00; 
          8'b01110100: data <= 2'b00; 
          8'b01110101: data <= 2'b00; 
          8'b01110110: data <= 2'b00; 
          8'b01110111: data <= 2'b00; 
          8'b01111000: data <= 2'b00; 
          8'b01111001: data <= 2'b00; 
          8'b01111010: data <= 2'b00; 
          8'b01111011: data <= 2'b00; 
          8'b01111100: data <= 2'b00; 
          8'b01111101: data <= 2'b00; 
          8'b01111110: data <= 2'b00; 
          8'b01111111: data <= 2'b00; 
          8'b10000000: data <= 2'b11; 
          8'b10000001: data <= 2'b11; 
          8'b10000010: data <= 2'b11; 
          8'b10000011: data <= 2'b11; 
          8'b10000100: data <= 2'b11; 
          8'b10000101: data <= 2'b11; 
          8'b10000110: data <= 2'b11; 
          8'b10000111: data <= 2'b11; 
          8'b10001000: data <= 2'b11; 
          8'b10001001: data <= 2'b11; 
          8'b10001010: data <= 2'b11; 
          8'b10001011: data <= 2'b11; 
          8'b10001100: data <= 2'b11; 
          8'b10001101: data <= 2'b11; 
          8'b10001110: data <= 2'b11; 
          8'b10001111: data <= 2'b11; 
          8'b10010000: data <= 2'b11; 
          8'b10010001: data <= 2'b11; 
          8'b10010010: data <= 2'b11; 
          8'b10010011: data <= 2'b11; 
          8'b10010100: data <= 2'b11; 
          8'b10010101: data <= 2'b11; 
          8'b10010110: data <= 2'b11; 
          8'b10010111: data <= 2'b11; 
          8'b10011000: data <= 2'b11; 
          8'b10011001: data <= 2'b11; 
          8'b10011010: data <= 2'b11; 
          8'b10011011: data <= 2'b11; 
          8'b10011100: data <= 2'b11; 
          8'b10011101: data <= 2'b11; 
          8'b10011110: data <= 2'b11; 
          8'b10011111: data <= 2'b11; 
          8'b10100000: data <= 2'b11; 
          8'b10100001: data <= 2'b11; 
          8'b10100010: data <= 2'b11; 
          8'b10100011: data <= 2'b11; 
          8'b10100100: data <= 2'b11; 
          8'b10100101: data <= 2'b11; 
          8'b10100110: data <= 2'b11; 
          8'b10100111: data <= 2'b11; 
          8'b10101000: data <= 2'b11; 
          8'b10101001: data <= 2'b11; 
          8'b10101010: data <= 2'b11; 
          8'b10101011: data <= 2'b11; 
          8'b10101100: data <= 2'b11; 
          8'b10101101: data <= 2'b11; 
          8'b10101110: data <= 2'b11; 
          8'b10101111: data <= 2'b11; 
          8'b10110000: data <= 2'b11; 
          8'b10110001: data <= 2'b11; 
          8'b10110010: data <= 2'b11; 
          8'b10110011: data <= 2'b11; 
          8'b10110100: data <= 2'b11; 
          8'b10110101: data <= 2'b11; 
          8'b10110110: data <= 2'b11; 
          8'b10110111: data <= 2'b11; 
          8'b10111000: data <= 2'b11; 
          8'b10111001: data <= 2'b11; 
          8'b10111010: data <= 2'b11; 
          8'b10111011: data <= 2'b11; 
          8'b10111100: data <= 2'b11; 
          8'b10111101: data <= 2'b11; 
          8'b10111110: data <= 2'b11; 
          8'b10111111: data <= 2'b11; 
          8'b11000000: data <= 2'b11; 
          8'b11000001: data <= 2'b11; 
          8'b11000010: data <= 2'b11; 
          8'b11000011: data <= 2'b11; 
          8'b11000100: data <= 2'b11; 
          8'b11000101: data <= 2'b11; 
          8'b11000110: data <= 2'b11; 
          8'b11000111: data <= 2'b11; 
          8'b11001000: data <= 2'b11; 
          8'b11001001: data <= 2'b11; 
          8'b11001010: data <= 2'b11; 
          8'b11001011: data <= 2'b11; 
          8'b11001100: data <= 2'b11; 
          8'b11001101: data <= 2'b11; 
          8'b11001110: data <= 2'b11; 
          8'b11001111: data <= 2'b11; 
          8'b11010000: data <= 2'b11; 
          8'b11010001: data <= 2'b11; 
          8'b11010010: data <= 2'b11; 
          8'b11010011: data <= 2'b11; 
          8'b11010100: data <= 2'b11; 
          8'b11010101: data <= 2'b11; 
          8'b11010110: data <= 2'b11; 
          8'b11010111: data <= 2'b11; 
          8'b11011000: data <= 2'b11; 
          8'b11011001: data <= 2'b11; 
          8'b11011010: data <= 2'b11; 
          8'b11011011: data <= 2'b11; 
          8'b11011100: data <= 2'b11; 
          8'b11011101: data <= 2'b11; 
          8'b11011110: data <= 2'b11; 
          8'b11011111: data <= 2'b11; 
          8'b11100000: data <= 2'b11; 
          8'b11100001: data <= 2'b11; 
          8'b11100010: data <= 2'b11; 
          8'b11100011: data <= 2'b11; 
          8'b11100100: data <= 2'b11; 
          8'b11100101: data <= 2'b11; 
          8'b11100110: data <= 2'b11; 
          8'b11100111: data <= 2'b11; 
          8'b11101000: data <= 2'b11; 
          8'b11101001: data <= 2'b11; 
          8'b11101010: data <= 2'b11; 
          8'b11101011: data <= 2'b11; 
          8'b11101100: data <= 2'b11; 
          8'b11101101: data <= 2'b11; 
          8'b11101110: data <= 2'b11; 
          8'b11101111: data <= 2'b11; 
          8'b11110000: data <= 2'b11; 
          8'b11110001: data <= 2'b11; 
          8'b11110010: data <= 2'b11; 
          8'b11110011: data <= 2'b11; 
          8'b11110100: data <= 2'b11; 
          8'b11110101: data <= 2'b11; 
          8'b11110110: data <= 2'b11; 
          8'b11110111: data <= 2'b11; 
          8'b11111000: data <= 2'b11; 
          8'b11111001: data <= 2'b11; 
          8'b11111010: data <= 2'b11; 
          8'b11111011: data <= 2'b11; 
          8'b11111100: data <= 2'b11; 
          8'b11111101: data <= 2'b11; 
          8'b11111110: data <= 2'b11; 
          8'b11111111: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st0_per5L(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [7:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st0_per5L ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 8'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 8'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {8{1'b1}}) begin         
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


module switches_stage_st1_5_L(
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


module ctrl_rom_dp4_st1_per5L(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [7:0] addr;                        
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
          8'b00000000: data <= 2'b00; 
          8'b00000001: data <= 2'b00; 
          8'b00000010: data <= 2'b00; 
          8'b00000011: data <= 2'b00; 
          8'b00000100: data <= 2'b00; 
          8'b00000101: data <= 2'b00; 
          8'b00000110: data <= 2'b00; 
          8'b00000111: data <= 2'b00; 
          8'b00001000: data <= 2'b00; 
          8'b00001001: data <= 2'b00; 
          8'b00001010: data <= 2'b00; 
          8'b00001011: data <= 2'b00; 
          8'b00001100: data <= 2'b00; 
          8'b00001101: data <= 2'b00; 
          8'b00001110: data <= 2'b00; 
          8'b00001111: data <= 2'b00; 
          8'b00010000: data <= 2'b00; 
          8'b00010001: data <= 2'b00; 
          8'b00010010: data <= 2'b00; 
          8'b00010011: data <= 2'b00; 
          8'b00010100: data <= 2'b00; 
          8'b00010101: data <= 2'b00; 
          8'b00010110: data <= 2'b00; 
          8'b00010111: data <= 2'b00; 
          8'b00011000: data <= 2'b00; 
          8'b00011001: data <= 2'b00; 
          8'b00011010: data <= 2'b00; 
          8'b00011011: data <= 2'b00; 
          8'b00011100: data <= 2'b00; 
          8'b00011101: data <= 2'b00; 
          8'b00011110: data <= 2'b00; 
          8'b00011111: data <= 2'b00; 
          8'b00100000: data <= 2'b00; 
          8'b00100001: data <= 2'b00; 
          8'b00100010: data <= 2'b00; 
          8'b00100011: data <= 2'b00; 
          8'b00100100: data <= 2'b00; 
          8'b00100101: data <= 2'b00; 
          8'b00100110: data <= 2'b00; 
          8'b00100111: data <= 2'b00; 
          8'b00101000: data <= 2'b00; 
          8'b00101001: data <= 2'b00; 
          8'b00101010: data <= 2'b00; 
          8'b00101011: data <= 2'b00; 
          8'b00101100: data <= 2'b00; 
          8'b00101101: data <= 2'b00; 
          8'b00101110: data <= 2'b00; 
          8'b00101111: data <= 2'b00; 
          8'b00110000: data <= 2'b00; 
          8'b00110001: data <= 2'b00; 
          8'b00110010: data <= 2'b00; 
          8'b00110011: data <= 2'b00; 
          8'b00110100: data <= 2'b00; 
          8'b00110101: data <= 2'b00; 
          8'b00110110: data <= 2'b00; 
          8'b00110111: data <= 2'b00; 
          8'b00111000: data <= 2'b00; 
          8'b00111001: data <= 2'b00; 
          8'b00111010: data <= 2'b00; 
          8'b00111011: data <= 2'b00; 
          8'b00111100: data <= 2'b00; 
          8'b00111101: data <= 2'b00; 
          8'b00111110: data <= 2'b00; 
          8'b00111111: data <= 2'b00; 
          8'b01000000: data <= 2'b11; 
          8'b01000001: data <= 2'b11; 
          8'b01000010: data <= 2'b11; 
          8'b01000011: data <= 2'b11; 
          8'b01000100: data <= 2'b11; 
          8'b01000101: data <= 2'b11; 
          8'b01000110: data <= 2'b11; 
          8'b01000111: data <= 2'b11; 
          8'b01001000: data <= 2'b11; 
          8'b01001001: data <= 2'b11; 
          8'b01001010: data <= 2'b11; 
          8'b01001011: data <= 2'b11; 
          8'b01001100: data <= 2'b11; 
          8'b01001101: data <= 2'b11; 
          8'b01001110: data <= 2'b11; 
          8'b01001111: data <= 2'b11; 
          8'b01010000: data <= 2'b11; 
          8'b01010001: data <= 2'b11; 
          8'b01010010: data <= 2'b11; 
          8'b01010011: data <= 2'b11; 
          8'b01010100: data <= 2'b11; 
          8'b01010101: data <= 2'b11; 
          8'b01010110: data <= 2'b11; 
          8'b01010111: data <= 2'b11; 
          8'b01011000: data <= 2'b11; 
          8'b01011001: data <= 2'b11; 
          8'b01011010: data <= 2'b11; 
          8'b01011011: data <= 2'b11; 
          8'b01011100: data <= 2'b11; 
          8'b01011101: data <= 2'b11; 
          8'b01011110: data <= 2'b11; 
          8'b01011111: data <= 2'b11; 
          8'b01100000: data <= 2'b11; 
          8'b01100001: data <= 2'b11; 
          8'b01100010: data <= 2'b11; 
          8'b01100011: data <= 2'b11; 
          8'b01100100: data <= 2'b11; 
          8'b01100101: data <= 2'b11; 
          8'b01100110: data <= 2'b11; 
          8'b01100111: data <= 2'b11; 
          8'b01101000: data <= 2'b11; 
          8'b01101001: data <= 2'b11; 
          8'b01101010: data <= 2'b11; 
          8'b01101011: data <= 2'b11; 
          8'b01101100: data <= 2'b11; 
          8'b01101101: data <= 2'b11; 
          8'b01101110: data <= 2'b11; 
          8'b01101111: data <= 2'b11; 
          8'b01110000: data <= 2'b11; 
          8'b01110001: data <= 2'b11; 
          8'b01110010: data <= 2'b11; 
          8'b01110011: data <= 2'b11; 
          8'b01110100: data <= 2'b11; 
          8'b01110101: data <= 2'b11; 
          8'b01110110: data <= 2'b11; 
          8'b01110111: data <= 2'b11; 
          8'b01111000: data <= 2'b11; 
          8'b01111001: data <= 2'b11; 
          8'b01111010: data <= 2'b11; 
          8'b01111011: data <= 2'b11; 
          8'b01111100: data <= 2'b11; 
          8'b01111101: data <= 2'b11; 
          8'b01111110: data <= 2'b11; 
          8'b01111111: data <= 2'b11; 
          8'b10000000: data <= 2'b00; 
          8'b10000001: data <= 2'b00; 
          8'b10000010: data <= 2'b00; 
          8'b10000011: data <= 2'b00; 
          8'b10000100: data <= 2'b00; 
          8'b10000101: data <= 2'b00; 
          8'b10000110: data <= 2'b00; 
          8'b10000111: data <= 2'b00; 
          8'b10001000: data <= 2'b00; 
          8'b10001001: data <= 2'b00; 
          8'b10001010: data <= 2'b00; 
          8'b10001011: data <= 2'b00; 
          8'b10001100: data <= 2'b00; 
          8'b10001101: data <= 2'b00; 
          8'b10001110: data <= 2'b00; 
          8'b10001111: data <= 2'b00; 
          8'b10010000: data <= 2'b00; 
          8'b10010001: data <= 2'b00; 
          8'b10010010: data <= 2'b00; 
          8'b10010011: data <= 2'b00; 
          8'b10010100: data <= 2'b00; 
          8'b10010101: data <= 2'b00; 
          8'b10010110: data <= 2'b00; 
          8'b10010111: data <= 2'b00; 
          8'b10011000: data <= 2'b00; 
          8'b10011001: data <= 2'b00; 
          8'b10011010: data <= 2'b00; 
          8'b10011011: data <= 2'b00; 
          8'b10011100: data <= 2'b00; 
          8'b10011101: data <= 2'b00; 
          8'b10011110: data <= 2'b00; 
          8'b10011111: data <= 2'b00; 
          8'b10100000: data <= 2'b00; 
          8'b10100001: data <= 2'b00; 
          8'b10100010: data <= 2'b00; 
          8'b10100011: data <= 2'b00; 
          8'b10100100: data <= 2'b00; 
          8'b10100101: data <= 2'b00; 
          8'b10100110: data <= 2'b00; 
          8'b10100111: data <= 2'b00; 
          8'b10101000: data <= 2'b00; 
          8'b10101001: data <= 2'b00; 
          8'b10101010: data <= 2'b00; 
          8'b10101011: data <= 2'b00; 
          8'b10101100: data <= 2'b00; 
          8'b10101101: data <= 2'b00; 
          8'b10101110: data <= 2'b00; 
          8'b10101111: data <= 2'b00; 
          8'b10110000: data <= 2'b00; 
          8'b10110001: data <= 2'b00; 
          8'b10110010: data <= 2'b00; 
          8'b10110011: data <= 2'b00; 
          8'b10110100: data <= 2'b00; 
          8'b10110101: data <= 2'b00; 
          8'b10110110: data <= 2'b00; 
          8'b10110111: data <= 2'b00; 
          8'b10111000: data <= 2'b00; 
          8'b10111001: data <= 2'b00; 
          8'b10111010: data <= 2'b00; 
          8'b10111011: data <= 2'b00; 
          8'b10111100: data <= 2'b00; 
          8'b10111101: data <= 2'b00; 
          8'b10111110: data <= 2'b00; 
          8'b10111111: data <= 2'b00; 
          8'b11000000: data <= 2'b11; 
          8'b11000001: data <= 2'b11; 
          8'b11000010: data <= 2'b11; 
          8'b11000011: data <= 2'b11; 
          8'b11000100: data <= 2'b11; 
          8'b11000101: data <= 2'b11; 
          8'b11000110: data <= 2'b11; 
          8'b11000111: data <= 2'b11; 
          8'b11001000: data <= 2'b11; 
          8'b11001001: data <= 2'b11; 
          8'b11001010: data <= 2'b11; 
          8'b11001011: data <= 2'b11; 
          8'b11001100: data <= 2'b11; 
          8'b11001101: data <= 2'b11; 
          8'b11001110: data <= 2'b11; 
          8'b11001111: data <= 2'b11; 
          8'b11010000: data <= 2'b11; 
          8'b11010001: data <= 2'b11; 
          8'b11010010: data <= 2'b11; 
          8'b11010011: data <= 2'b11; 
          8'b11010100: data <= 2'b11; 
          8'b11010101: data <= 2'b11; 
          8'b11010110: data <= 2'b11; 
          8'b11010111: data <= 2'b11; 
          8'b11011000: data <= 2'b11; 
          8'b11011001: data <= 2'b11; 
          8'b11011010: data <= 2'b11; 
          8'b11011011: data <= 2'b11; 
          8'b11011100: data <= 2'b11; 
          8'b11011101: data <= 2'b11; 
          8'b11011110: data <= 2'b11; 
          8'b11011111: data <= 2'b11; 
          8'b11100000: data <= 2'b11; 
          8'b11100001: data <= 2'b11; 
          8'b11100010: data <= 2'b11; 
          8'b11100011: data <= 2'b11; 
          8'b11100100: data <= 2'b11; 
          8'b11100101: data <= 2'b11; 
          8'b11100110: data <= 2'b11; 
          8'b11100111: data <= 2'b11; 
          8'b11101000: data <= 2'b11; 
          8'b11101001: data <= 2'b11; 
          8'b11101010: data <= 2'b11; 
          8'b11101011: data <= 2'b11; 
          8'b11101100: data <= 2'b11; 
          8'b11101101: data <= 2'b11; 
          8'b11101110: data <= 2'b11; 
          8'b11101111: data <= 2'b11; 
          8'b11110000: data <= 2'b11; 
          8'b11110001: data <= 2'b11; 
          8'b11110010: data <= 2'b11; 
          8'b11110011: data <= 2'b11; 
          8'b11110100: data <= 2'b11; 
          8'b11110101: data <= 2'b11; 
          8'b11110110: data <= 2'b11; 
          8'b11110111: data <= 2'b11; 
          8'b11111000: data <= 2'b11; 
          8'b11111001: data <= 2'b11; 
          8'b11111010: data <= 2'b11; 
          8'b11111011: data <= 2'b11; 
          8'b11111100: data <= 2'b11; 
          8'b11111101: data <= 2'b11; 
          8'b11111110: data <= 2'b11; 
          8'b11111111: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st1_per5L(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [7:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st1_per5L ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 8'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 8'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {8{1'b1}}) begin         
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
  switches_stage_st0_5_L_r switch_stage_0(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), 
        .outData_0(wire_con_in_stage0[0]), .outData_1(wire_con_in_stage0[1]), .outData_2(wire_con_in_stage0[2]), .outData_3(wire_con_in_stage0[3]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp4_st0_L wire_stage_0(
        .inData_0(wire_con_in_stage0[0]), .inData_1(wire_con_in_stage0[1]), .inData_2(wire_con_in_stage0[2]), .inData_3(wire_con_in_stage0[3]), 
        .outData_0(wire_con_out_stage0[0]), .outData_1(wire_con_out_stage0[1]), .outData_2(wire_con_out_stage0[2]), .outData_3(wire_con_out_stage0[3]), 
        .in_start(con_in_start_stage0), .out_start(in_start_stage1), .clk(clk), .rst(rst));
  
  switch_ctrl_dp4_st0_per5L switch_ctrl_stage_0(.in_start(in_start_stage0),.ctrl_out(wire_ctrl_stage0),.clk(clk), .rst(rst));

  wire [DATA_WIDTH-1:0] wire_con_in_stage1[3:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage1[3:0];
  wire [1:0] wire_ctrl_stage1;
  switches_stage_st1_5_L switch_stage_1(
        .inData_0(wire_con_out_stage0[0]), .inData_1(wire_con_out_stage0[1]), .inData_2(wire_con_out_stage0[2]), .inData_3(wire_con_out_stage0[3]), 
        .outData_0(wire_con_in_stage1[0]), .outData_1(wire_con_in_stage1[1]), .outData_2(wire_con_in_stage1[2]), .outData_3(wire_con_in_stage1[3]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp4_st1_L wire_stage_1(
        .inData_0(wire_con_in_stage1[0]), .inData_1(wire_con_in_stage1[1]), .inData_2(wire_con_in_stage1[2]), .inData_3(wire_con_in_stage1[3]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), 
        .in_start(con_in_start_stage1), .out_start(out_start_w), .clk(clk), .rst(rst));
  
  switch_ctrl_dp4_st1_per5L switch_ctrl_stage_1(.in_start(in_start_stage1),.ctrl_out(wire_ctrl_stage1),.clk(clk), .rst(rst));

  
  assign in_start_stage0 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_w;    
  
endmodule                        


module switches_stage_st0_5_R_r(
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


module ctrl_rom_dp4_st0_per5R(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [7:0] addr;                        
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
          8'b00000000: data <= 2'b00; 
          8'b00000001: data <= 2'b00; 
          8'b00000010: data <= 2'b00; 
          8'b00000011: data <= 2'b00; 
          8'b00000100: data <= 2'b00; 
          8'b00000101: data <= 2'b00; 
          8'b00000110: data <= 2'b00; 
          8'b00000111: data <= 2'b00; 
          8'b00001000: data <= 2'b00; 
          8'b00001001: data <= 2'b00; 
          8'b00001010: data <= 2'b00; 
          8'b00001011: data <= 2'b00; 
          8'b00001100: data <= 2'b00; 
          8'b00001101: data <= 2'b00; 
          8'b00001110: data <= 2'b00; 
          8'b00001111: data <= 2'b00; 
          8'b00010000: data <= 2'b00; 
          8'b00010001: data <= 2'b00; 
          8'b00010010: data <= 2'b00; 
          8'b00010011: data <= 2'b00; 
          8'b00010100: data <= 2'b00; 
          8'b00010101: data <= 2'b00; 
          8'b00010110: data <= 2'b00; 
          8'b00010111: data <= 2'b00; 
          8'b00011000: data <= 2'b00; 
          8'b00011001: data <= 2'b00; 
          8'b00011010: data <= 2'b00; 
          8'b00011011: data <= 2'b00; 
          8'b00011100: data <= 2'b00; 
          8'b00011101: data <= 2'b00; 
          8'b00011110: data <= 2'b00; 
          8'b00011111: data <= 2'b00; 
          8'b00100000: data <= 2'b00; 
          8'b00100001: data <= 2'b00; 
          8'b00100010: data <= 2'b00; 
          8'b00100011: data <= 2'b00; 
          8'b00100100: data <= 2'b00; 
          8'b00100101: data <= 2'b00; 
          8'b00100110: data <= 2'b00; 
          8'b00100111: data <= 2'b00; 
          8'b00101000: data <= 2'b00; 
          8'b00101001: data <= 2'b00; 
          8'b00101010: data <= 2'b00; 
          8'b00101011: data <= 2'b00; 
          8'b00101100: data <= 2'b00; 
          8'b00101101: data <= 2'b00; 
          8'b00101110: data <= 2'b00; 
          8'b00101111: data <= 2'b00; 
          8'b00110000: data <= 2'b00; 
          8'b00110001: data <= 2'b00; 
          8'b00110010: data <= 2'b00; 
          8'b00110011: data <= 2'b00; 
          8'b00110100: data <= 2'b00; 
          8'b00110101: data <= 2'b00; 
          8'b00110110: data <= 2'b00; 
          8'b00110111: data <= 2'b00; 
          8'b00111000: data <= 2'b00; 
          8'b00111001: data <= 2'b00; 
          8'b00111010: data <= 2'b00; 
          8'b00111011: data <= 2'b00; 
          8'b00111100: data <= 2'b00; 
          8'b00111101: data <= 2'b00; 
          8'b00111110: data <= 2'b00; 
          8'b00111111: data <= 2'b00; 
          8'b01000000: data <= 2'b00; 
          8'b01000001: data <= 2'b00; 
          8'b01000010: data <= 2'b00; 
          8'b01000011: data <= 2'b00; 
          8'b01000100: data <= 2'b00; 
          8'b01000101: data <= 2'b00; 
          8'b01000110: data <= 2'b00; 
          8'b01000111: data <= 2'b00; 
          8'b01001000: data <= 2'b00; 
          8'b01001001: data <= 2'b00; 
          8'b01001010: data <= 2'b00; 
          8'b01001011: data <= 2'b00; 
          8'b01001100: data <= 2'b00; 
          8'b01001101: data <= 2'b00; 
          8'b01001110: data <= 2'b00; 
          8'b01001111: data <= 2'b00; 
          8'b01010000: data <= 2'b00; 
          8'b01010001: data <= 2'b00; 
          8'b01010010: data <= 2'b00; 
          8'b01010011: data <= 2'b00; 
          8'b01010100: data <= 2'b00; 
          8'b01010101: data <= 2'b00; 
          8'b01010110: data <= 2'b00; 
          8'b01010111: data <= 2'b00; 
          8'b01011000: data <= 2'b00; 
          8'b01011001: data <= 2'b00; 
          8'b01011010: data <= 2'b00; 
          8'b01011011: data <= 2'b00; 
          8'b01011100: data <= 2'b00; 
          8'b01011101: data <= 2'b00; 
          8'b01011110: data <= 2'b00; 
          8'b01011111: data <= 2'b00; 
          8'b01100000: data <= 2'b00; 
          8'b01100001: data <= 2'b00; 
          8'b01100010: data <= 2'b00; 
          8'b01100011: data <= 2'b00; 
          8'b01100100: data <= 2'b00; 
          8'b01100101: data <= 2'b00; 
          8'b01100110: data <= 2'b00; 
          8'b01100111: data <= 2'b00; 
          8'b01101000: data <= 2'b00; 
          8'b01101001: data <= 2'b00; 
          8'b01101010: data <= 2'b00; 
          8'b01101011: data <= 2'b00; 
          8'b01101100: data <= 2'b00; 
          8'b01101101: data <= 2'b00; 
          8'b01101110: data <= 2'b00; 
          8'b01101111: data <= 2'b00; 
          8'b01110000: data <= 2'b00; 
          8'b01110001: data <= 2'b00; 
          8'b01110010: data <= 2'b00; 
          8'b01110011: data <= 2'b00; 
          8'b01110100: data <= 2'b00; 
          8'b01110101: data <= 2'b00; 
          8'b01110110: data <= 2'b00; 
          8'b01110111: data <= 2'b00; 
          8'b01111000: data <= 2'b00; 
          8'b01111001: data <= 2'b00; 
          8'b01111010: data <= 2'b00; 
          8'b01111011: data <= 2'b00; 
          8'b01111100: data <= 2'b00; 
          8'b01111101: data <= 2'b00; 
          8'b01111110: data <= 2'b00; 
          8'b01111111: data <= 2'b00; 
          8'b10000000: data <= 2'b11; 
          8'b10000001: data <= 2'b11; 
          8'b10000010: data <= 2'b11; 
          8'b10000011: data <= 2'b11; 
          8'b10000100: data <= 2'b11; 
          8'b10000101: data <= 2'b11; 
          8'b10000110: data <= 2'b11; 
          8'b10000111: data <= 2'b11; 
          8'b10001000: data <= 2'b11; 
          8'b10001001: data <= 2'b11; 
          8'b10001010: data <= 2'b11; 
          8'b10001011: data <= 2'b11; 
          8'b10001100: data <= 2'b11; 
          8'b10001101: data <= 2'b11; 
          8'b10001110: data <= 2'b11; 
          8'b10001111: data <= 2'b11; 
          8'b10010000: data <= 2'b11; 
          8'b10010001: data <= 2'b11; 
          8'b10010010: data <= 2'b11; 
          8'b10010011: data <= 2'b11; 
          8'b10010100: data <= 2'b11; 
          8'b10010101: data <= 2'b11; 
          8'b10010110: data <= 2'b11; 
          8'b10010111: data <= 2'b11; 
          8'b10011000: data <= 2'b11; 
          8'b10011001: data <= 2'b11; 
          8'b10011010: data <= 2'b11; 
          8'b10011011: data <= 2'b11; 
          8'b10011100: data <= 2'b11; 
          8'b10011101: data <= 2'b11; 
          8'b10011110: data <= 2'b11; 
          8'b10011111: data <= 2'b11; 
          8'b10100000: data <= 2'b11; 
          8'b10100001: data <= 2'b11; 
          8'b10100010: data <= 2'b11; 
          8'b10100011: data <= 2'b11; 
          8'b10100100: data <= 2'b11; 
          8'b10100101: data <= 2'b11; 
          8'b10100110: data <= 2'b11; 
          8'b10100111: data <= 2'b11; 
          8'b10101000: data <= 2'b11; 
          8'b10101001: data <= 2'b11; 
          8'b10101010: data <= 2'b11; 
          8'b10101011: data <= 2'b11; 
          8'b10101100: data <= 2'b11; 
          8'b10101101: data <= 2'b11; 
          8'b10101110: data <= 2'b11; 
          8'b10101111: data <= 2'b11; 
          8'b10110000: data <= 2'b11; 
          8'b10110001: data <= 2'b11; 
          8'b10110010: data <= 2'b11; 
          8'b10110011: data <= 2'b11; 
          8'b10110100: data <= 2'b11; 
          8'b10110101: data <= 2'b11; 
          8'b10110110: data <= 2'b11; 
          8'b10110111: data <= 2'b11; 
          8'b10111000: data <= 2'b11; 
          8'b10111001: data <= 2'b11; 
          8'b10111010: data <= 2'b11; 
          8'b10111011: data <= 2'b11; 
          8'b10111100: data <= 2'b11; 
          8'b10111101: data <= 2'b11; 
          8'b10111110: data <= 2'b11; 
          8'b10111111: data <= 2'b11; 
          8'b11000000: data <= 2'b11; 
          8'b11000001: data <= 2'b11; 
          8'b11000010: data <= 2'b11; 
          8'b11000011: data <= 2'b11; 
          8'b11000100: data <= 2'b11; 
          8'b11000101: data <= 2'b11; 
          8'b11000110: data <= 2'b11; 
          8'b11000111: data <= 2'b11; 
          8'b11001000: data <= 2'b11; 
          8'b11001001: data <= 2'b11; 
          8'b11001010: data <= 2'b11; 
          8'b11001011: data <= 2'b11; 
          8'b11001100: data <= 2'b11; 
          8'b11001101: data <= 2'b11; 
          8'b11001110: data <= 2'b11; 
          8'b11001111: data <= 2'b11; 
          8'b11010000: data <= 2'b11; 
          8'b11010001: data <= 2'b11; 
          8'b11010010: data <= 2'b11; 
          8'b11010011: data <= 2'b11; 
          8'b11010100: data <= 2'b11; 
          8'b11010101: data <= 2'b11; 
          8'b11010110: data <= 2'b11; 
          8'b11010111: data <= 2'b11; 
          8'b11011000: data <= 2'b11; 
          8'b11011001: data <= 2'b11; 
          8'b11011010: data <= 2'b11; 
          8'b11011011: data <= 2'b11; 
          8'b11011100: data <= 2'b11; 
          8'b11011101: data <= 2'b11; 
          8'b11011110: data <= 2'b11; 
          8'b11011111: data <= 2'b11; 
          8'b11100000: data <= 2'b11; 
          8'b11100001: data <= 2'b11; 
          8'b11100010: data <= 2'b11; 
          8'b11100011: data <= 2'b11; 
          8'b11100100: data <= 2'b11; 
          8'b11100101: data <= 2'b11; 
          8'b11100110: data <= 2'b11; 
          8'b11100111: data <= 2'b11; 
          8'b11101000: data <= 2'b11; 
          8'b11101001: data <= 2'b11; 
          8'b11101010: data <= 2'b11; 
          8'b11101011: data <= 2'b11; 
          8'b11101100: data <= 2'b11; 
          8'b11101101: data <= 2'b11; 
          8'b11101110: data <= 2'b11; 
          8'b11101111: data <= 2'b11; 
          8'b11110000: data <= 2'b11; 
          8'b11110001: data <= 2'b11; 
          8'b11110010: data <= 2'b11; 
          8'b11110011: data <= 2'b11; 
          8'b11110100: data <= 2'b11; 
          8'b11110101: data <= 2'b11; 
          8'b11110110: data <= 2'b11; 
          8'b11110111: data <= 2'b11; 
          8'b11111000: data <= 2'b11; 
          8'b11111001: data <= 2'b11; 
          8'b11111010: data <= 2'b11; 
          8'b11111011: data <= 2'b11; 
          8'b11111100: data <= 2'b11; 
          8'b11111101: data <= 2'b11; 
          8'b11111110: data <= 2'b11; 
          8'b11111111: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st0_per5R(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [7:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st0_per5R ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 8'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 8'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {8{1'b1}}) begin         
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


module switches_stage_st1_5_R(
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


module ctrl_rom_dp4_st1_per5R(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [7:0] addr;                        
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
          8'b00000000: data <= 2'b00; 
          8'b00000001: data <= 2'b00; 
          8'b00000010: data <= 2'b00; 
          8'b00000011: data <= 2'b00; 
          8'b00000100: data <= 2'b00; 
          8'b00000101: data <= 2'b00; 
          8'b00000110: data <= 2'b00; 
          8'b00000111: data <= 2'b00; 
          8'b00001000: data <= 2'b00; 
          8'b00001001: data <= 2'b00; 
          8'b00001010: data <= 2'b00; 
          8'b00001011: data <= 2'b00; 
          8'b00001100: data <= 2'b00; 
          8'b00001101: data <= 2'b00; 
          8'b00001110: data <= 2'b00; 
          8'b00001111: data <= 2'b00; 
          8'b00010000: data <= 2'b00; 
          8'b00010001: data <= 2'b00; 
          8'b00010010: data <= 2'b00; 
          8'b00010011: data <= 2'b00; 
          8'b00010100: data <= 2'b00; 
          8'b00010101: data <= 2'b00; 
          8'b00010110: data <= 2'b00; 
          8'b00010111: data <= 2'b00; 
          8'b00011000: data <= 2'b00; 
          8'b00011001: data <= 2'b00; 
          8'b00011010: data <= 2'b00; 
          8'b00011011: data <= 2'b00; 
          8'b00011100: data <= 2'b00; 
          8'b00011101: data <= 2'b00; 
          8'b00011110: data <= 2'b00; 
          8'b00011111: data <= 2'b00; 
          8'b00100000: data <= 2'b00; 
          8'b00100001: data <= 2'b00; 
          8'b00100010: data <= 2'b00; 
          8'b00100011: data <= 2'b00; 
          8'b00100100: data <= 2'b00; 
          8'b00100101: data <= 2'b00; 
          8'b00100110: data <= 2'b00; 
          8'b00100111: data <= 2'b00; 
          8'b00101000: data <= 2'b00; 
          8'b00101001: data <= 2'b00; 
          8'b00101010: data <= 2'b00; 
          8'b00101011: data <= 2'b00; 
          8'b00101100: data <= 2'b00; 
          8'b00101101: data <= 2'b00; 
          8'b00101110: data <= 2'b00; 
          8'b00101111: data <= 2'b00; 
          8'b00110000: data <= 2'b00; 
          8'b00110001: data <= 2'b00; 
          8'b00110010: data <= 2'b00; 
          8'b00110011: data <= 2'b00; 
          8'b00110100: data <= 2'b00; 
          8'b00110101: data <= 2'b00; 
          8'b00110110: data <= 2'b00; 
          8'b00110111: data <= 2'b00; 
          8'b00111000: data <= 2'b00; 
          8'b00111001: data <= 2'b00; 
          8'b00111010: data <= 2'b00; 
          8'b00111011: data <= 2'b00; 
          8'b00111100: data <= 2'b00; 
          8'b00111101: data <= 2'b00; 
          8'b00111110: data <= 2'b00; 
          8'b00111111: data <= 2'b00; 
          8'b01000000: data <= 2'b11; 
          8'b01000001: data <= 2'b11; 
          8'b01000010: data <= 2'b11; 
          8'b01000011: data <= 2'b11; 
          8'b01000100: data <= 2'b11; 
          8'b01000101: data <= 2'b11; 
          8'b01000110: data <= 2'b11; 
          8'b01000111: data <= 2'b11; 
          8'b01001000: data <= 2'b11; 
          8'b01001001: data <= 2'b11; 
          8'b01001010: data <= 2'b11; 
          8'b01001011: data <= 2'b11; 
          8'b01001100: data <= 2'b11; 
          8'b01001101: data <= 2'b11; 
          8'b01001110: data <= 2'b11; 
          8'b01001111: data <= 2'b11; 
          8'b01010000: data <= 2'b11; 
          8'b01010001: data <= 2'b11; 
          8'b01010010: data <= 2'b11; 
          8'b01010011: data <= 2'b11; 
          8'b01010100: data <= 2'b11; 
          8'b01010101: data <= 2'b11; 
          8'b01010110: data <= 2'b11; 
          8'b01010111: data <= 2'b11; 
          8'b01011000: data <= 2'b11; 
          8'b01011001: data <= 2'b11; 
          8'b01011010: data <= 2'b11; 
          8'b01011011: data <= 2'b11; 
          8'b01011100: data <= 2'b11; 
          8'b01011101: data <= 2'b11; 
          8'b01011110: data <= 2'b11; 
          8'b01011111: data <= 2'b11; 
          8'b01100000: data <= 2'b11; 
          8'b01100001: data <= 2'b11; 
          8'b01100010: data <= 2'b11; 
          8'b01100011: data <= 2'b11; 
          8'b01100100: data <= 2'b11; 
          8'b01100101: data <= 2'b11; 
          8'b01100110: data <= 2'b11; 
          8'b01100111: data <= 2'b11; 
          8'b01101000: data <= 2'b11; 
          8'b01101001: data <= 2'b11; 
          8'b01101010: data <= 2'b11; 
          8'b01101011: data <= 2'b11; 
          8'b01101100: data <= 2'b11; 
          8'b01101101: data <= 2'b11; 
          8'b01101110: data <= 2'b11; 
          8'b01101111: data <= 2'b11; 
          8'b01110000: data <= 2'b11; 
          8'b01110001: data <= 2'b11; 
          8'b01110010: data <= 2'b11; 
          8'b01110011: data <= 2'b11; 
          8'b01110100: data <= 2'b11; 
          8'b01110101: data <= 2'b11; 
          8'b01110110: data <= 2'b11; 
          8'b01110111: data <= 2'b11; 
          8'b01111000: data <= 2'b11; 
          8'b01111001: data <= 2'b11; 
          8'b01111010: data <= 2'b11; 
          8'b01111011: data <= 2'b11; 
          8'b01111100: data <= 2'b11; 
          8'b01111101: data <= 2'b11; 
          8'b01111110: data <= 2'b11; 
          8'b01111111: data <= 2'b11; 
          8'b10000000: data <= 2'b00; 
          8'b10000001: data <= 2'b00; 
          8'b10000010: data <= 2'b00; 
          8'b10000011: data <= 2'b00; 
          8'b10000100: data <= 2'b00; 
          8'b10000101: data <= 2'b00; 
          8'b10000110: data <= 2'b00; 
          8'b10000111: data <= 2'b00; 
          8'b10001000: data <= 2'b00; 
          8'b10001001: data <= 2'b00; 
          8'b10001010: data <= 2'b00; 
          8'b10001011: data <= 2'b00; 
          8'b10001100: data <= 2'b00; 
          8'b10001101: data <= 2'b00; 
          8'b10001110: data <= 2'b00; 
          8'b10001111: data <= 2'b00; 
          8'b10010000: data <= 2'b00; 
          8'b10010001: data <= 2'b00; 
          8'b10010010: data <= 2'b00; 
          8'b10010011: data <= 2'b00; 
          8'b10010100: data <= 2'b00; 
          8'b10010101: data <= 2'b00; 
          8'b10010110: data <= 2'b00; 
          8'b10010111: data <= 2'b00; 
          8'b10011000: data <= 2'b00; 
          8'b10011001: data <= 2'b00; 
          8'b10011010: data <= 2'b00; 
          8'b10011011: data <= 2'b00; 
          8'b10011100: data <= 2'b00; 
          8'b10011101: data <= 2'b00; 
          8'b10011110: data <= 2'b00; 
          8'b10011111: data <= 2'b00; 
          8'b10100000: data <= 2'b00; 
          8'b10100001: data <= 2'b00; 
          8'b10100010: data <= 2'b00; 
          8'b10100011: data <= 2'b00; 
          8'b10100100: data <= 2'b00; 
          8'b10100101: data <= 2'b00; 
          8'b10100110: data <= 2'b00; 
          8'b10100111: data <= 2'b00; 
          8'b10101000: data <= 2'b00; 
          8'b10101001: data <= 2'b00; 
          8'b10101010: data <= 2'b00; 
          8'b10101011: data <= 2'b00; 
          8'b10101100: data <= 2'b00; 
          8'b10101101: data <= 2'b00; 
          8'b10101110: data <= 2'b00; 
          8'b10101111: data <= 2'b00; 
          8'b10110000: data <= 2'b00; 
          8'b10110001: data <= 2'b00; 
          8'b10110010: data <= 2'b00; 
          8'b10110011: data <= 2'b00; 
          8'b10110100: data <= 2'b00; 
          8'b10110101: data <= 2'b00; 
          8'b10110110: data <= 2'b00; 
          8'b10110111: data <= 2'b00; 
          8'b10111000: data <= 2'b00; 
          8'b10111001: data <= 2'b00; 
          8'b10111010: data <= 2'b00; 
          8'b10111011: data <= 2'b00; 
          8'b10111100: data <= 2'b00; 
          8'b10111101: data <= 2'b00; 
          8'b10111110: data <= 2'b00; 
          8'b10111111: data <= 2'b00; 
          8'b11000000: data <= 2'b11; 
          8'b11000001: data <= 2'b11; 
          8'b11000010: data <= 2'b11; 
          8'b11000011: data <= 2'b11; 
          8'b11000100: data <= 2'b11; 
          8'b11000101: data <= 2'b11; 
          8'b11000110: data <= 2'b11; 
          8'b11000111: data <= 2'b11; 
          8'b11001000: data <= 2'b11; 
          8'b11001001: data <= 2'b11; 
          8'b11001010: data <= 2'b11; 
          8'b11001011: data <= 2'b11; 
          8'b11001100: data <= 2'b11; 
          8'b11001101: data <= 2'b11; 
          8'b11001110: data <= 2'b11; 
          8'b11001111: data <= 2'b11; 
          8'b11010000: data <= 2'b11; 
          8'b11010001: data <= 2'b11; 
          8'b11010010: data <= 2'b11; 
          8'b11010011: data <= 2'b11; 
          8'b11010100: data <= 2'b11; 
          8'b11010101: data <= 2'b11; 
          8'b11010110: data <= 2'b11; 
          8'b11010111: data <= 2'b11; 
          8'b11011000: data <= 2'b11; 
          8'b11011001: data <= 2'b11; 
          8'b11011010: data <= 2'b11; 
          8'b11011011: data <= 2'b11; 
          8'b11011100: data <= 2'b11; 
          8'b11011101: data <= 2'b11; 
          8'b11011110: data <= 2'b11; 
          8'b11011111: data <= 2'b11; 
          8'b11100000: data <= 2'b11; 
          8'b11100001: data <= 2'b11; 
          8'b11100010: data <= 2'b11; 
          8'b11100011: data <= 2'b11; 
          8'b11100100: data <= 2'b11; 
          8'b11100101: data <= 2'b11; 
          8'b11100110: data <= 2'b11; 
          8'b11100111: data <= 2'b11; 
          8'b11101000: data <= 2'b11; 
          8'b11101001: data <= 2'b11; 
          8'b11101010: data <= 2'b11; 
          8'b11101011: data <= 2'b11; 
          8'b11101100: data <= 2'b11; 
          8'b11101101: data <= 2'b11; 
          8'b11101110: data <= 2'b11; 
          8'b11101111: data <= 2'b11; 
          8'b11110000: data <= 2'b11; 
          8'b11110001: data <= 2'b11; 
          8'b11110010: data <= 2'b11; 
          8'b11110011: data <= 2'b11; 
          8'b11110100: data <= 2'b11; 
          8'b11110101: data <= 2'b11; 
          8'b11110110: data <= 2'b11; 
          8'b11110111: data <= 2'b11; 
          8'b11111000: data <= 2'b11; 
          8'b11111001: data <= 2'b11; 
          8'b11111010: data <= 2'b11; 
          8'b11111011: data <= 2'b11; 
          8'b11111100: data <= 2'b11; 
          8'b11111101: data <= 2'b11; 
          8'b11111110: data <= 2'b11; 
          8'b11111111: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp4_st1_per5R(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] ctrl_out;        
  
  reg [7:0] addr;        
  reg state;        
  
  ctrl_rom_dp4_st1_per5R ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 8'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case(state)                
        1'b0: begin                
          addr <= 8'b0;         
          if (in_start) begin                     
            state <= 1'b1;                 
            addr <= addr + 1;         
          end                                    
        end                                    
        1'b1: begin               
          addr <= addr + 1;         
          if (addr == {8{1'b1}}) begin         
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
  switches_stage_st1_5_R switch_stage_1(
        .inData_0(wire_switch_in_stage1[0]), .inData_1(wire_switch_in_stage1[1]), .inData_2(wire_switch_in_stage1[2]), .inData_3(wire_switch_in_stage1[3]), 
        .outData_0(wire_switch_out_stage1[0]), .outData_1(wire_switch_out_stage1[1]), .outData_2(wire_switch_out_stage1[2]), .outData_3(wire_switch_out_stage1[3]), 
        .in_start(con_in_start_stage1), .out_start(in_start_stage0), .ctrl(wire_ctrl_stage1), .clk(clk), .rst(rst));
  
  wireCon_dp4_st1_R wire_stage_1(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), 
        .outData_0(wire_switch_in_stage1[0]), .outData_1(wire_switch_in_stage1[1]), .outData_2(wire_switch_in_stage1[2]), .outData_3(wire_switch_in_stage1[3]), 
        .in_start(in_start_stage1), .out_start(con_in_start_stage1), .clk(clk), .rst(rst));
  
  switch_ctrl_dp4_st1_per5R switch_ctrl_stage_1(.in_start(con_in_start_stage1),.ctrl_out(wire_ctrl_stage1),.clk(clk), .rst(rst));

  wire [DATA_WIDTH-1:0] wire_switch_in_stage0[3:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage0[3:0];
  wire [1:0] wire_ctrl_stage0;
  switches_stage_st0_5_R_r switch_stage_0(
        .inData_0(wire_switch_in_stage0[0]), .inData_1(wire_switch_in_stage0[1]), .inData_2(wire_switch_in_stage0[2]), .inData_3(wire_switch_in_stage0[3]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), 
        .in_start(con_in_start_stage0), .out_start(out_start_w), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp4_st0_R wire_stage_0(
        .inData_0(wire_switch_out_stage1[0]), .inData_1(wire_switch_out_stage1[1]), .inData_2(wire_switch_out_stage1[2]), .inData_3(wire_switch_out_stage1[3]), 
        .outData_0(wire_switch_in_stage0[0]), .outData_1(wire_switch_in_stage0[1]), .outData_2(wire_switch_in_stage0[2]), .outData_3(wire_switch_in_stage0[3]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .clk(clk), .rst(rst));
  
  switch_ctrl_dp4_st0_per5R switch_ctrl_stage_0(.in_start(con_in_start_stage0),.ctrl_out(wire_ctrl_stage0),.clk(clk), .rst(rst));

  
  assign in_start_stage0 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_w;    
  
endmodule                        


module  counter_512(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [8:0] counter_out;            
  
  reg [8:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 9'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[8:0] == 511) begin  
        status_couting <= 1'b0;                 
        counter_r <= 9'b0;         
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
  input [8:0] addr;                        
  output reg [8:0] data;        
  
  // synthesis attribute rom_style of data is "block" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 9'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          9'b000000000: data <= 9'b000000000; 
          9'b000000001: data <= 9'b000100000; 
          9'b000000010: data <= 9'b000010000; 
          9'b000000011: data <= 9'b000110000; 
          9'b000000100: data <= 9'b000001000; 
          9'b000000101: data <= 9'b000101000; 
          9'b000000110: data <= 9'b000011000; 
          9'b000000111: data <= 9'b000111000; 
          9'b000001000: data <= 9'b000000100; 
          9'b000001001: data <= 9'b000100100; 
          9'b000001010: data <= 9'b000010100; 
          9'b000001011: data <= 9'b000110100; 
          9'b000001100: data <= 9'b000001100; 
          9'b000001101: data <= 9'b000101100; 
          9'b000001110: data <= 9'b000011100; 
          9'b000001111: data <= 9'b000111100; 
          9'b000010000: data <= 9'b000000010; 
          9'b000010001: data <= 9'b000100010; 
          9'b000010010: data <= 9'b000010010; 
          9'b000010011: data <= 9'b000110010; 
          9'b000010100: data <= 9'b000001010; 
          9'b000010101: data <= 9'b000101010; 
          9'b000010110: data <= 9'b000011010; 
          9'b000010111: data <= 9'b000111010; 
          9'b000011000: data <= 9'b000000110; 
          9'b000011001: data <= 9'b000100110; 
          9'b000011010: data <= 9'b000010110; 
          9'b000011011: data <= 9'b000110110; 
          9'b000011100: data <= 9'b000001110; 
          9'b000011101: data <= 9'b000101110; 
          9'b000011110: data <= 9'b000011110; 
          9'b000011111: data <= 9'b000111110; 
          9'b000100000: data <= 9'b000000001; 
          9'b000100001: data <= 9'b000100001; 
          9'b000100010: data <= 9'b000010001; 
          9'b000100011: data <= 9'b000110001; 
          9'b000100100: data <= 9'b000001001; 
          9'b000100101: data <= 9'b000101001; 
          9'b000100110: data <= 9'b000011001; 
          9'b000100111: data <= 9'b000111001; 
          9'b000101000: data <= 9'b000000101; 
          9'b000101001: data <= 9'b000100101; 
          9'b000101010: data <= 9'b000010101; 
          9'b000101011: data <= 9'b000110101; 
          9'b000101100: data <= 9'b000001101; 
          9'b000101101: data <= 9'b000101101; 
          9'b000101110: data <= 9'b000011101; 
          9'b000101111: data <= 9'b000111101; 
          9'b000110000: data <= 9'b000000011; 
          9'b000110001: data <= 9'b000100011; 
          9'b000110010: data <= 9'b000010011; 
          9'b000110011: data <= 9'b000110011; 
          9'b000110100: data <= 9'b000001011; 
          9'b000110101: data <= 9'b000101011; 
          9'b000110110: data <= 9'b000011011; 
          9'b000110111: data <= 9'b000111011; 
          9'b000111000: data <= 9'b000000111; 
          9'b000111001: data <= 9'b000100111; 
          9'b000111010: data <= 9'b000010111; 
          9'b000111011: data <= 9'b000110111; 
          9'b000111100: data <= 9'b000001111; 
          9'b000111101: data <= 9'b000101111; 
          9'b000111110: data <= 9'b000011111; 
          9'b000111111: data <= 9'b000111111; 
          9'b001000000: data <= 9'b001000000; 
          9'b001000001: data <= 9'b001100000; 
          9'b001000010: data <= 9'b001010000; 
          9'b001000011: data <= 9'b001110000; 
          9'b001000100: data <= 9'b001001000; 
          9'b001000101: data <= 9'b001101000; 
          9'b001000110: data <= 9'b001011000; 
          9'b001000111: data <= 9'b001111000; 
          9'b001001000: data <= 9'b001000100; 
          9'b001001001: data <= 9'b001100100; 
          9'b001001010: data <= 9'b001010100; 
          9'b001001011: data <= 9'b001110100; 
          9'b001001100: data <= 9'b001001100; 
          9'b001001101: data <= 9'b001101100; 
          9'b001001110: data <= 9'b001011100; 
          9'b001001111: data <= 9'b001111100; 
          9'b001010000: data <= 9'b001000010; 
          9'b001010001: data <= 9'b001100010; 
          9'b001010010: data <= 9'b001010010; 
          9'b001010011: data <= 9'b001110010; 
          9'b001010100: data <= 9'b001001010; 
          9'b001010101: data <= 9'b001101010; 
          9'b001010110: data <= 9'b001011010; 
          9'b001010111: data <= 9'b001111010; 
          9'b001011000: data <= 9'b001000110; 
          9'b001011001: data <= 9'b001100110; 
          9'b001011010: data <= 9'b001010110; 
          9'b001011011: data <= 9'b001110110; 
          9'b001011100: data <= 9'b001001110; 
          9'b001011101: data <= 9'b001101110; 
          9'b001011110: data <= 9'b001011110; 
          9'b001011111: data <= 9'b001111110; 
          9'b001100000: data <= 9'b001000001; 
          9'b001100001: data <= 9'b001100001; 
          9'b001100010: data <= 9'b001010001; 
          9'b001100011: data <= 9'b001110001; 
          9'b001100100: data <= 9'b001001001; 
          9'b001100101: data <= 9'b001101001; 
          9'b001100110: data <= 9'b001011001; 
          9'b001100111: data <= 9'b001111001; 
          9'b001101000: data <= 9'b001000101; 
          9'b001101001: data <= 9'b001100101; 
          9'b001101010: data <= 9'b001010101; 
          9'b001101011: data <= 9'b001110101; 
          9'b001101100: data <= 9'b001001101; 
          9'b001101101: data <= 9'b001101101; 
          9'b001101110: data <= 9'b001011101; 
          9'b001101111: data <= 9'b001111101; 
          9'b001110000: data <= 9'b001000011; 
          9'b001110001: data <= 9'b001100011; 
          9'b001110010: data <= 9'b001010011; 
          9'b001110011: data <= 9'b001110011; 
          9'b001110100: data <= 9'b001001011; 
          9'b001110101: data <= 9'b001101011; 
          9'b001110110: data <= 9'b001011011; 
          9'b001110111: data <= 9'b001111011; 
          9'b001111000: data <= 9'b001000111; 
          9'b001111001: data <= 9'b001100111; 
          9'b001111010: data <= 9'b001010111; 
          9'b001111011: data <= 9'b001110111; 
          9'b001111100: data <= 9'b001001111; 
          9'b001111101: data <= 9'b001101111; 
          9'b001111110: data <= 9'b001011111; 
          9'b001111111: data <= 9'b001111111; 
          9'b010000000: data <= 9'b010000000; 
          9'b010000001: data <= 9'b010100000; 
          9'b010000010: data <= 9'b010010000; 
          9'b010000011: data <= 9'b010110000; 
          9'b010000100: data <= 9'b010001000; 
          9'b010000101: data <= 9'b010101000; 
          9'b010000110: data <= 9'b010011000; 
          9'b010000111: data <= 9'b010111000; 
          9'b010001000: data <= 9'b010000100; 
          9'b010001001: data <= 9'b010100100; 
          9'b010001010: data <= 9'b010010100; 
          9'b010001011: data <= 9'b010110100; 
          9'b010001100: data <= 9'b010001100; 
          9'b010001101: data <= 9'b010101100; 
          9'b010001110: data <= 9'b010011100; 
          9'b010001111: data <= 9'b010111100; 
          9'b010010000: data <= 9'b010000010; 
          9'b010010001: data <= 9'b010100010; 
          9'b010010010: data <= 9'b010010010; 
          9'b010010011: data <= 9'b010110010; 
          9'b010010100: data <= 9'b010001010; 
          9'b010010101: data <= 9'b010101010; 
          9'b010010110: data <= 9'b010011010; 
          9'b010010111: data <= 9'b010111010; 
          9'b010011000: data <= 9'b010000110; 
          9'b010011001: data <= 9'b010100110; 
          9'b010011010: data <= 9'b010010110; 
          9'b010011011: data <= 9'b010110110; 
          9'b010011100: data <= 9'b010001110; 
          9'b010011101: data <= 9'b010101110; 
          9'b010011110: data <= 9'b010011110; 
          9'b010011111: data <= 9'b010111110; 
          9'b010100000: data <= 9'b010000001; 
          9'b010100001: data <= 9'b010100001; 
          9'b010100010: data <= 9'b010010001; 
          9'b010100011: data <= 9'b010110001; 
          9'b010100100: data <= 9'b010001001; 
          9'b010100101: data <= 9'b010101001; 
          9'b010100110: data <= 9'b010011001; 
          9'b010100111: data <= 9'b010111001; 
          9'b010101000: data <= 9'b010000101; 
          9'b010101001: data <= 9'b010100101; 
          9'b010101010: data <= 9'b010010101; 
          9'b010101011: data <= 9'b010110101; 
          9'b010101100: data <= 9'b010001101; 
          9'b010101101: data <= 9'b010101101; 
          9'b010101110: data <= 9'b010011101; 
          9'b010101111: data <= 9'b010111101; 
          9'b010110000: data <= 9'b010000011; 
          9'b010110001: data <= 9'b010100011; 
          9'b010110010: data <= 9'b010010011; 
          9'b010110011: data <= 9'b010110011; 
          9'b010110100: data <= 9'b010001011; 
          9'b010110101: data <= 9'b010101011; 
          9'b010110110: data <= 9'b010011011; 
          9'b010110111: data <= 9'b010111011; 
          9'b010111000: data <= 9'b010000111; 
          9'b010111001: data <= 9'b010100111; 
          9'b010111010: data <= 9'b010010111; 
          9'b010111011: data <= 9'b010110111; 
          9'b010111100: data <= 9'b010001111; 
          9'b010111101: data <= 9'b010101111; 
          9'b010111110: data <= 9'b010011111; 
          9'b010111111: data <= 9'b010111111; 
          9'b011000000: data <= 9'b011000000; 
          9'b011000001: data <= 9'b011100000; 
          9'b011000010: data <= 9'b011010000; 
          9'b011000011: data <= 9'b011110000; 
          9'b011000100: data <= 9'b011001000; 
          9'b011000101: data <= 9'b011101000; 
          9'b011000110: data <= 9'b011011000; 
          9'b011000111: data <= 9'b011111000; 
          9'b011001000: data <= 9'b011000100; 
          9'b011001001: data <= 9'b011100100; 
          9'b011001010: data <= 9'b011010100; 
          9'b011001011: data <= 9'b011110100; 
          9'b011001100: data <= 9'b011001100; 
          9'b011001101: data <= 9'b011101100; 
          9'b011001110: data <= 9'b011011100; 
          9'b011001111: data <= 9'b011111100; 
          9'b011010000: data <= 9'b011000010; 
          9'b011010001: data <= 9'b011100010; 
          9'b011010010: data <= 9'b011010010; 
          9'b011010011: data <= 9'b011110010; 
          9'b011010100: data <= 9'b011001010; 
          9'b011010101: data <= 9'b011101010; 
          9'b011010110: data <= 9'b011011010; 
          9'b011010111: data <= 9'b011111010; 
          9'b011011000: data <= 9'b011000110; 
          9'b011011001: data <= 9'b011100110; 
          9'b011011010: data <= 9'b011010110; 
          9'b011011011: data <= 9'b011110110; 
          9'b011011100: data <= 9'b011001110; 
          9'b011011101: data <= 9'b011101110; 
          9'b011011110: data <= 9'b011011110; 
          9'b011011111: data <= 9'b011111110; 
          9'b011100000: data <= 9'b011000001; 
          9'b011100001: data <= 9'b011100001; 
          9'b011100010: data <= 9'b011010001; 
          9'b011100011: data <= 9'b011110001; 
          9'b011100100: data <= 9'b011001001; 
          9'b011100101: data <= 9'b011101001; 
          9'b011100110: data <= 9'b011011001; 
          9'b011100111: data <= 9'b011111001; 
          9'b011101000: data <= 9'b011000101; 
          9'b011101001: data <= 9'b011100101; 
          9'b011101010: data <= 9'b011010101; 
          9'b011101011: data <= 9'b011110101; 
          9'b011101100: data <= 9'b011001101; 
          9'b011101101: data <= 9'b011101101; 
          9'b011101110: data <= 9'b011011101; 
          9'b011101111: data <= 9'b011111101; 
          9'b011110000: data <= 9'b011000011; 
          9'b011110001: data <= 9'b011100011; 
          9'b011110010: data <= 9'b011010011; 
          9'b011110011: data <= 9'b011110011; 
          9'b011110100: data <= 9'b011001011; 
          9'b011110101: data <= 9'b011101011; 
          9'b011110110: data <= 9'b011011011; 
          9'b011110111: data <= 9'b011111011; 
          9'b011111000: data <= 9'b011000111; 
          9'b011111001: data <= 9'b011100111; 
          9'b011111010: data <= 9'b011010111; 
          9'b011111011: data <= 9'b011110111; 
          9'b011111100: data <= 9'b011001111; 
          9'b011111101: data <= 9'b011101111; 
          9'b011111110: data <= 9'b011011111; 
          9'b011111111: data <= 9'b011111111; 
          9'b100000000: data <= 9'b000000000; 
          9'b100000001: data <= 9'b000000001; 
          9'b100000010: data <= 9'b000000010; 
          9'b100000011: data <= 9'b000000011; 
          9'b100000100: data <= 9'b000000100; 
          9'b100000101: data <= 9'b000000101; 
          9'b100000110: data <= 9'b000000110; 
          9'b100000111: data <= 9'b000000111; 
          9'b100001000: data <= 9'b000001000; 
          9'b100001001: data <= 9'b000001001; 
          9'b100001010: data <= 9'b000001010; 
          9'b100001011: data <= 9'b000001011; 
          9'b100001100: data <= 9'b000001100; 
          9'b100001101: data <= 9'b000001101; 
          9'b100001110: data <= 9'b000001110; 
          9'b100001111: data <= 9'b000001111; 
          9'b100010000: data <= 9'b000010000; 
          9'b100010001: data <= 9'b000010001; 
          9'b100010010: data <= 9'b000010010; 
          9'b100010011: data <= 9'b000010011; 
          9'b100010100: data <= 9'b000010100; 
          9'b100010101: data <= 9'b000010101; 
          9'b100010110: data <= 9'b000010110; 
          9'b100010111: data <= 9'b000010111; 
          9'b100011000: data <= 9'b000011000; 
          9'b100011001: data <= 9'b000011001; 
          9'b100011010: data <= 9'b000011010; 
          9'b100011011: data <= 9'b000011011; 
          9'b100011100: data <= 9'b000011100; 
          9'b100011101: data <= 9'b000011101; 
          9'b100011110: data <= 9'b000011110; 
          9'b100011111: data <= 9'b000011111; 
          9'b100100000: data <= 9'b000100000; 
          9'b100100001: data <= 9'b000100001; 
          9'b100100010: data <= 9'b000100010; 
          9'b100100011: data <= 9'b000100011; 
          9'b100100100: data <= 9'b000100100; 
          9'b100100101: data <= 9'b000100101; 
          9'b100100110: data <= 9'b000100110; 
          9'b100100111: data <= 9'b000100111; 
          9'b100101000: data <= 9'b000101000; 
          9'b100101001: data <= 9'b000101001; 
          9'b100101010: data <= 9'b000101010; 
          9'b100101011: data <= 9'b000101011; 
          9'b100101100: data <= 9'b000101100; 
          9'b100101101: data <= 9'b000101101; 
          9'b100101110: data <= 9'b000101110; 
          9'b100101111: data <= 9'b000101111; 
          9'b100110000: data <= 9'b000110000; 
          9'b100110001: data <= 9'b000110001; 
          9'b100110010: data <= 9'b000110010; 
          9'b100110011: data <= 9'b000110011; 
          9'b100110100: data <= 9'b000110100; 
          9'b100110101: data <= 9'b000110101; 
          9'b100110110: data <= 9'b000110110; 
          9'b100110111: data <= 9'b000110111; 
          9'b100111000: data <= 9'b000111000; 
          9'b100111001: data <= 9'b000111001; 
          9'b100111010: data <= 9'b000111010; 
          9'b100111011: data <= 9'b000111011; 
          9'b100111100: data <= 9'b000111100; 
          9'b100111101: data <= 9'b000111101; 
          9'b100111110: data <= 9'b000111110; 
          9'b100111111: data <= 9'b000111111; 
          9'b101000000: data <= 9'b001000000; 
          9'b101000001: data <= 9'b001000001; 
          9'b101000010: data <= 9'b001000010; 
          9'b101000011: data <= 9'b001000011; 
          9'b101000100: data <= 9'b001000100; 
          9'b101000101: data <= 9'b001000101; 
          9'b101000110: data <= 9'b001000110; 
          9'b101000111: data <= 9'b001000111; 
          9'b101001000: data <= 9'b001001000; 
          9'b101001001: data <= 9'b001001001; 
          9'b101001010: data <= 9'b001001010; 
          9'b101001011: data <= 9'b001001011; 
          9'b101001100: data <= 9'b001001100; 
          9'b101001101: data <= 9'b001001101; 
          9'b101001110: data <= 9'b001001110; 
          9'b101001111: data <= 9'b001001111; 
          9'b101010000: data <= 9'b001010000; 
          9'b101010001: data <= 9'b001010001; 
          9'b101010010: data <= 9'b001010010; 
          9'b101010011: data <= 9'b001010011; 
          9'b101010100: data <= 9'b001010100; 
          9'b101010101: data <= 9'b001010101; 
          9'b101010110: data <= 9'b001010110; 
          9'b101010111: data <= 9'b001010111; 
          9'b101011000: data <= 9'b001011000; 
          9'b101011001: data <= 9'b001011001; 
          9'b101011010: data <= 9'b001011010; 
          9'b101011011: data <= 9'b001011011; 
          9'b101011100: data <= 9'b001011100; 
          9'b101011101: data <= 9'b001011101; 
          9'b101011110: data <= 9'b001011110; 
          9'b101011111: data <= 9'b001011111; 
          9'b101100000: data <= 9'b001100000; 
          9'b101100001: data <= 9'b001100001; 
          9'b101100010: data <= 9'b001100010; 
          9'b101100011: data <= 9'b001100011; 
          9'b101100100: data <= 9'b001100100; 
          9'b101100101: data <= 9'b001100101; 
          9'b101100110: data <= 9'b001100110; 
          9'b101100111: data <= 9'b001100111; 
          9'b101101000: data <= 9'b001101000; 
          9'b101101001: data <= 9'b001101001; 
          9'b101101010: data <= 9'b001101010; 
          9'b101101011: data <= 9'b001101011; 
          9'b101101100: data <= 9'b001101100; 
          9'b101101101: data <= 9'b001101101; 
          9'b101101110: data <= 9'b001101110; 
          9'b101101111: data <= 9'b001101111; 
          9'b101110000: data <= 9'b001110000; 
          9'b101110001: data <= 9'b001110001; 
          9'b101110010: data <= 9'b001110010; 
          9'b101110011: data <= 9'b001110011; 
          9'b101110100: data <= 9'b001110100; 
          9'b101110101: data <= 9'b001110101; 
          9'b101110110: data <= 9'b001110110; 
          9'b101110111: data <= 9'b001110111; 
          9'b101111000: data <= 9'b001111000; 
          9'b101111001: data <= 9'b001111001; 
          9'b101111010: data <= 9'b001111010; 
          9'b101111011: data <= 9'b001111011; 
          9'b101111100: data <= 9'b001111100; 
          9'b101111101: data <= 9'b001111101; 
          9'b101111110: data <= 9'b001111110; 
          9'b101111111: data <= 9'b001111111; 
          9'b110000000: data <= 9'b010000000; 
          9'b110000001: data <= 9'b010000001; 
          9'b110000010: data <= 9'b010000010; 
          9'b110000011: data <= 9'b010000011; 
          9'b110000100: data <= 9'b010000100; 
          9'b110000101: data <= 9'b010000101; 
          9'b110000110: data <= 9'b010000110; 
          9'b110000111: data <= 9'b010000111; 
          9'b110001000: data <= 9'b010001000; 
          9'b110001001: data <= 9'b010001001; 
          9'b110001010: data <= 9'b010001010; 
          9'b110001011: data <= 9'b010001011; 
          9'b110001100: data <= 9'b010001100; 
          9'b110001101: data <= 9'b010001101; 
          9'b110001110: data <= 9'b010001110; 
          9'b110001111: data <= 9'b010001111; 
          9'b110010000: data <= 9'b010010000; 
          9'b110010001: data <= 9'b010010001; 
          9'b110010010: data <= 9'b010010010; 
          9'b110010011: data <= 9'b010010011; 
          9'b110010100: data <= 9'b010010100; 
          9'b110010101: data <= 9'b010010101; 
          9'b110010110: data <= 9'b010010110; 
          9'b110010111: data <= 9'b010010111; 
          9'b110011000: data <= 9'b010011000; 
          9'b110011001: data <= 9'b010011001; 
          9'b110011010: data <= 9'b010011010; 
          9'b110011011: data <= 9'b010011011; 
          9'b110011100: data <= 9'b010011100; 
          9'b110011101: data <= 9'b010011101; 
          9'b110011110: data <= 9'b010011110; 
          9'b110011111: data <= 9'b010011111; 
          9'b110100000: data <= 9'b010100000; 
          9'b110100001: data <= 9'b010100001; 
          9'b110100010: data <= 9'b010100010; 
          9'b110100011: data <= 9'b010100011; 
          9'b110100100: data <= 9'b010100100; 
          9'b110100101: data <= 9'b010100101; 
          9'b110100110: data <= 9'b010100110; 
          9'b110100111: data <= 9'b010100111; 
          9'b110101000: data <= 9'b010101000; 
          9'b110101001: data <= 9'b010101001; 
          9'b110101010: data <= 9'b010101010; 
          9'b110101011: data <= 9'b010101011; 
          9'b110101100: data <= 9'b010101100; 
          9'b110101101: data <= 9'b010101101; 
          9'b110101110: data <= 9'b010101110; 
          9'b110101111: data <= 9'b010101111; 
          9'b110110000: data <= 9'b010110000; 
          9'b110110001: data <= 9'b010110001; 
          9'b110110010: data <= 9'b010110010; 
          9'b110110011: data <= 9'b010110011; 
          9'b110110100: data <= 9'b010110100; 
          9'b110110101: data <= 9'b010110101; 
          9'b110110110: data <= 9'b010110110; 
          9'b110110111: data <= 9'b010110111; 
          9'b110111000: data <= 9'b010111000; 
          9'b110111001: data <= 9'b010111001; 
          9'b110111010: data <= 9'b010111010; 
          9'b110111011: data <= 9'b010111011; 
          9'b110111100: data <= 9'b010111100; 
          9'b110111101: data <= 9'b010111101; 
          9'b110111110: data <= 9'b010111110; 
          9'b110111111: data <= 9'b010111111; 
          9'b111000000: data <= 9'b011000000; 
          9'b111000001: data <= 9'b011000001; 
          9'b111000010: data <= 9'b011000010; 
          9'b111000011: data <= 9'b011000011; 
          9'b111000100: data <= 9'b011000100; 
          9'b111000101: data <= 9'b011000101; 
          9'b111000110: data <= 9'b011000110; 
          9'b111000111: data <= 9'b011000111; 
          9'b111001000: data <= 9'b011001000; 
          9'b111001001: data <= 9'b011001001; 
          9'b111001010: data <= 9'b011001010; 
          9'b111001011: data <= 9'b011001011; 
          9'b111001100: data <= 9'b011001100; 
          9'b111001101: data <= 9'b011001101; 
          9'b111001110: data <= 9'b011001110; 
          9'b111001111: data <= 9'b011001111; 
          9'b111010000: data <= 9'b011010000; 
          9'b111010001: data <= 9'b011010001; 
          9'b111010010: data <= 9'b011010010; 
          9'b111010011: data <= 9'b011010011; 
          9'b111010100: data <= 9'b011010100; 
          9'b111010101: data <= 9'b011010101; 
          9'b111010110: data <= 9'b011010110; 
          9'b111010111: data <= 9'b011010111; 
          9'b111011000: data <= 9'b011011000; 
          9'b111011001: data <= 9'b011011001; 
          9'b111011010: data <= 9'b011011010; 
          9'b111011011: data <= 9'b011011011; 
          9'b111011100: data <= 9'b011011100; 
          9'b111011101: data <= 9'b011011101; 
          9'b111011110: data <= 9'b011011110; 
          9'b111011111: data <= 9'b011011111; 
          9'b111100000: data <= 9'b011100000; 
          9'b111100001: data <= 9'b011100001; 
          9'b111100010: data <= 9'b011100010; 
          9'b111100011: data <= 9'b011100011; 
          9'b111100100: data <= 9'b011100100; 
          9'b111100101: data <= 9'b011100101; 
          9'b111100110: data <= 9'b011100110; 
          9'b111100111: data <= 9'b011100111; 
          9'b111101000: data <= 9'b011101000; 
          9'b111101001: data <= 9'b011101001; 
          9'b111101010: data <= 9'b011101010; 
          9'b111101011: data <= 9'b011101011; 
          9'b111101100: data <= 9'b011101100; 
          9'b111101101: data <= 9'b011101101; 
          9'b111101110: data <= 9'b011101110; 
          9'b111101111: data <= 9'b011101111; 
          9'b111110000: data <= 9'b011110000; 
          9'b111110001: data <= 9'b011110001; 
          9'b111110010: data <= 9'b011110010; 
          9'b111110011: data <= 9'b011110011; 
          9'b111110100: data <= 9'b011110100; 
          9'b111110101: data <= 9'b011110101; 
          9'b111110110: data <= 9'b011110110; 
          9'b111110111: data <= 9'b011110111; 
          9'b111111000: data <= 9'b011111000; 
          9'b111111001: data <= 9'b011111001; 
          9'b111111010: data <= 9'b011111010; 
          9'b111111011: data <= 9'b011111011; 
          9'b111111100: data <= 9'b011111100; 
          9'b111111101: data <= 9'b011111101; 
          9'b111111110: data <= 9'b011111110; 
          9'b111111111: data <= 9'b011111111; 
          default: data <= 9'b0; 
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
  input [8:0] addr;                        
  output reg [8:0] data;        
  
  // synthesis attribute rom_style of data is "block" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 9'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          9'b000000000: data <= 9'b001000000; 
          9'b000000001: data <= 9'b001100000; 
          9'b000000010: data <= 9'b001010000; 
          9'b000000011: data <= 9'b001110000; 
          9'b000000100: data <= 9'b001001000; 
          9'b000000101: data <= 9'b001101000; 
          9'b000000110: data <= 9'b001011000; 
          9'b000000111: data <= 9'b001111000; 
          9'b000001000: data <= 9'b001000100; 
          9'b000001001: data <= 9'b001100100; 
          9'b000001010: data <= 9'b001010100; 
          9'b000001011: data <= 9'b001110100; 
          9'b000001100: data <= 9'b001001100; 
          9'b000001101: data <= 9'b001101100; 
          9'b000001110: data <= 9'b001011100; 
          9'b000001111: data <= 9'b001111100; 
          9'b000010000: data <= 9'b001000010; 
          9'b000010001: data <= 9'b001100010; 
          9'b000010010: data <= 9'b001010010; 
          9'b000010011: data <= 9'b001110010; 
          9'b000010100: data <= 9'b001001010; 
          9'b000010101: data <= 9'b001101010; 
          9'b000010110: data <= 9'b001011010; 
          9'b000010111: data <= 9'b001111010; 
          9'b000011000: data <= 9'b001000110; 
          9'b000011001: data <= 9'b001100110; 
          9'b000011010: data <= 9'b001010110; 
          9'b000011011: data <= 9'b001110110; 
          9'b000011100: data <= 9'b001001110; 
          9'b000011101: data <= 9'b001101110; 
          9'b000011110: data <= 9'b001011110; 
          9'b000011111: data <= 9'b001111110; 
          9'b000100000: data <= 9'b001000001; 
          9'b000100001: data <= 9'b001100001; 
          9'b000100010: data <= 9'b001010001; 
          9'b000100011: data <= 9'b001110001; 
          9'b000100100: data <= 9'b001001001; 
          9'b000100101: data <= 9'b001101001; 
          9'b000100110: data <= 9'b001011001; 
          9'b000100111: data <= 9'b001111001; 
          9'b000101000: data <= 9'b001000101; 
          9'b000101001: data <= 9'b001100101; 
          9'b000101010: data <= 9'b001010101; 
          9'b000101011: data <= 9'b001110101; 
          9'b000101100: data <= 9'b001001101; 
          9'b000101101: data <= 9'b001101101; 
          9'b000101110: data <= 9'b001011101; 
          9'b000101111: data <= 9'b001111101; 
          9'b000110000: data <= 9'b001000011; 
          9'b000110001: data <= 9'b001100011; 
          9'b000110010: data <= 9'b001010011; 
          9'b000110011: data <= 9'b001110011; 
          9'b000110100: data <= 9'b001001011; 
          9'b000110101: data <= 9'b001101011; 
          9'b000110110: data <= 9'b001011011; 
          9'b000110111: data <= 9'b001111011; 
          9'b000111000: data <= 9'b001000111; 
          9'b000111001: data <= 9'b001100111; 
          9'b000111010: data <= 9'b001010111; 
          9'b000111011: data <= 9'b001110111; 
          9'b000111100: data <= 9'b001001111; 
          9'b000111101: data <= 9'b001101111; 
          9'b000111110: data <= 9'b001011111; 
          9'b000111111: data <= 9'b001111111; 
          9'b001000000: data <= 9'b000000000; 
          9'b001000001: data <= 9'b000100000; 
          9'b001000010: data <= 9'b000010000; 
          9'b001000011: data <= 9'b000110000; 
          9'b001000100: data <= 9'b000001000; 
          9'b001000101: data <= 9'b000101000; 
          9'b001000110: data <= 9'b000011000; 
          9'b001000111: data <= 9'b000111000; 
          9'b001001000: data <= 9'b000000100; 
          9'b001001001: data <= 9'b000100100; 
          9'b001001010: data <= 9'b000010100; 
          9'b001001011: data <= 9'b000110100; 
          9'b001001100: data <= 9'b000001100; 
          9'b001001101: data <= 9'b000101100; 
          9'b001001110: data <= 9'b000011100; 
          9'b001001111: data <= 9'b000111100; 
          9'b001010000: data <= 9'b000000010; 
          9'b001010001: data <= 9'b000100010; 
          9'b001010010: data <= 9'b000010010; 
          9'b001010011: data <= 9'b000110010; 
          9'b001010100: data <= 9'b000001010; 
          9'b001010101: data <= 9'b000101010; 
          9'b001010110: data <= 9'b000011010; 
          9'b001010111: data <= 9'b000111010; 
          9'b001011000: data <= 9'b000000110; 
          9'b001011001: data <= 9'b000100110; 
          9'b001011010: data <= 9'b000010110; 
          9'b001011011: data <= 9'b000110110; 
          9'b001011100: data <= 9'b000001110; 
          9'b001011101: data <= 9'b000101110; 
          9'b001011110: data <= 9'b000011110; 
          9'b001011111: data <= 9'b000111110; 
          9'b001100000: data <= 9'b000000001; 
          9'b001100001: data <= 9'b000100001; 
          9'b001100010: data <= 9'b000010001; 
          9'b001100011: data <= 9'b000110001; 
          9'b001100100: data <= 9'b000001001; 
          9'b001100101: data <= 9'b000101001; 
          9'b001100110: data <= 9'b000011001; 
          9'b001100111: data <= 9'b000111001; 
          9'b001101000: data <= 9'b000000101; 
          9'b001101001: data <= 9'b000100101; 
          9'b001101010: data <= 9'b000010101; 
          9'b001101011: data <= 9'b000110101; 
          9'b001101100: data <= 9'b000001101; 
          9'b001101101: data <= 9'b000101101; 
          9'b001101110: data <= 9'b000011101; 
          9'b001101111: data <= 9'b000111101; 
          9'b001110000: data <= 9'b000000011; 
          9'b001110001: data <= 9'b000100011; 
          9'b001110010: data <= 9'b000010011; 
          9'b001110011: data <= 9'b000110011; 
          9'b001110100: data <= 9'b000001011; 
          9'b001110101: data <= 9'b000101011; 
          9'b001110110: data <= 9'b000011011; 
          9'b001110111: data <= 9'b000111011; 
          9'b001111000: data <= 9'b000000111; 
          9'b001111001: data <= 9'b000100111; 
          9'b001111010: data <= 9'b000010111; 
          9'b001111011: data <= 9'b000110111; 
          9'b001111100: data <= 9'b000001111; 
          9'b001111101: data <= 9'b000101111; 
          9'b001111110: data <= 9'b000011111; 
          9'b001111111: data <= 9'b000111111; 
          9'b010000000: data <= 9'b011000000; 
          9'b010000001: data <= 9'b011100000; 
          9'b010000010: data <= 9'b011010000; 
          9'b010000011: data <= 9'b011110000; 
          9'b010000100: data <= 9'b011001000; 
          9'b010000101: data <= 9'b011101000; 
          9'b010000110: data <= 9'b011011000; 
          9'b010000111: data <= 9'b011111000; 
          9'b010001000: data <= 9'b011000100; 
          9'b010001001: data <= 9'b011100100; 
          9'b010001010: data <= 9'b011010100; 
          9'b010001011: data <= 9'b011110100; 
          9'b010001100: data <= 9'b011001100; 
          9'b010001101: data <= 9'b011101100; 
          9'b010001110: data <= 9'b011011100; 
          9'b010001111: data <= 9'b011111100; 
          9'b010010000: data <= 9'b011000010; 
          9'b010010001: data <= 9'b011100010; 
          9'b010010010: data <= 9'b011010010; 
          9'b010010011: data <= 9'b011110010; 
          9'b010010100: data <= 9'b011001010; 
          9'b010010101: data <= 9'b011101010; 
          9'b010010110: data <= 9'b011011010; 
          9'b010010111: data <= 9'b011111010; 
          9'b010011000: data <= 9'b011000110; 
          9'b010011001: data <= 9'b011100110; 
          9'b010011010: data <= 9'b011010110; 
          9'b010011011: data <= 9'b011110110; 
          9'b010011100: data <= 9'b011001110; 
          9'b010011101: data <= 9'b011101110; 
          9'b010011110: data <= 9'b011011110; 
          9'b010011111: data <= 9'b011111110; 
          9'b010100000: data <= 9'b011000001; 
          9'b010100001: data <= 9'b011100001; 
          9'b010100010: data <= 9'b011010001; 
          9'b010100011: data <= 9'b011110001; 
          9'b010100100: data <= 9'b011001001; 
          9'b010100101: data <= 9'b011101001; 
          9'b010100110: data <= 9'b011011001; 
          9'b010100111: data <= 9'b011111001; 
          9'b010101000: data <= 9'b011000101; 
          9'b010101001: data <= 9'b011100101; 
          9'b010101010: data <= 9'b011010101; 
          9'b010101011: data <= 9'b011110101; 
          9'b010101100: data <= 9'b011001101; 
          9'b010101101: data <= 9'b011101101; 
          9'b010101110: data <= 9'b011011101; 
          9'b010101111: data <= 9'b011111101; 
          9'b010110000: data <= 9'b011000011; 
          9'b010110001: data <= 9'b011100011; 
          9'b010110010: data <= 9'b011010011; 
          9'b010110011: data <= 9'b011110011; 
          9'b010110100: data <= 9'b011001011; 
          9'b010110101: data <= 9'b011101011; 
          9'b010110110: data <= 9'b011011011; 
          9'b010110111: data <= 9'b011111011; 
          9'b010111000: data <= 9'b011000111; 
          9'b010111001: data <= 9'b011100111; 
          9'b010111010: data <= 9'b011010111; 
          9'b010111011: data <= 9'b011110111; 
          9'b010111100: data <= 9'b011001111; 
          9'b010111101: data <= 9'b011101111; 
          9'b010111110: data <= 9'b011011111; 
          9'b010111111: data <= 9'b011111111; 
          9'b011000000: data <= 9'b010000000; 
          9'b011000001: data <= 9'b010100000; 
          9'b011000010: data <= 9'b010010000; 
          9'b011000011: data <= 9'b010110000; 
          9'b011000100: data <= 9'b010001000; 
          9'b011000101: data <= 9'b010101000; 
          9'b011000110: data <= 9'b010011000; 
          9'b011000111: data <= 9'b010111000; 
          9'b011001000: data <= 9'b010000100; 
          9'b011001001: data <= 9'b010100100; 
          9'b011001010: data <= 9'b010010100; 
          9'b011001011: data <= 9'b010110100; 
          9'b011001100: data <= 9'b010001100; 
          9'b011001101: data <= 9'b010101100; 
          9'b011001110: data <= 9'b010011100; 
          9'b011001111: data <= 9'b010111100; 
          9'b011010000: data <= 9'b010000010; 
          9'b011010001: data <= 9'b010100010; 
          9'b011010010: data <= 9'b010010010; 
          9'b011010011: data <= 9'b010110010; 
          9'b011010100: data <= 9'b010001010; 
          9'b011010101: data <= 9'b010101010; 
          9'b011010110: data <= 9'b010011010; 
          9'b011010111: data <= 9'b010111010; 
          9'b011011000: data <= 9'b010000110; 
          9'b011011001: data <= 9'b010100110; 
          9'b011011010: data <= 9'b010010110; 
          9'b011011011: data <= 9'b010110110; 
          9'b011011100: data <= 9'b010001110; 
          9'b011011101: data <= 9'b010101110; 
          9'b011011110: data <= 9'b010011110; 
          9'b011011111: data <= 9'b010111110; 
          9'b011100000: data <= 9'b010000001; 
          9'b011100001: data <= 9'b010100001; 
          9'b011100010: data <= 9'b010010001; 
          9'b011100011: data <= 9'b010110001; 
          9'b011100100: data <= 9'b010001001; 
          9'b011100101: data <= 9'b010101001; 
          9'b011100110: data <= 9'b010011001; 
          9'b011100111: data <= 9'b010111001; 
          9'b011101000: data <= 9'b010000101; 
          9'b011101001: data <= 9'b010100101; 
          9'b011101010: data <= 9'b010010101; 
          9'b011101011: data <= 9'b010110101; 
          9'b011101100: data <= 9'b010001101; 
          9'b011101101: data <= 9'b010101101; 
          9'b011101110: data <= 9'b010011101; 
          9'b011101111: data <= 9'b010111101; 
          9'b011110000: data <= 9'b010000011; 
          9'b011110001: data <= 9'b010100011; 
          9'b011110010: data <= 9'b010010011; 
          9'b011110011: data <= 9'b010110011; 
          9'b011110100: data <= 9'b010001011; 
          9'b011110101: data <= 9'b010101011; 
          9'b011110110: data <= 9'b010011011; 
          9'b011110111: data <= 9'b010111011; 
          9'b011111000: data <= 9'b010000111; 
          9'b011111001: data <= 9'b010100111; 
          9'b011111010: data <= 9'b010010111; 
          9'b011111011: data <= 9'b010110111; 
          9'b011111100: data <= 9'b010001111; 
          9'b011111101: data <= 9'b010101111; 
          9'b011111110: data <= 9'b010011111; 
          9'b011111111: data <= 9'b010111111; 
          9'b100000000: data <= 9'b000000000; 
          9'b100000001: data <= 9'b000000001; 
          9'b100000010: data <= 9'b000000010; 
          9'b100000011: data <= 9'b000000011; 
          9'b100000100: data <= 9'b000000100; 
          9'b100000101: data <= 9'b000000101; 
          9'b100000110: data <= 9'b000000110; 
          9'b100000111: data <= 9'b000000111; 
          9'b100001000: data <= 9'b000001000; 
          9'b100001001: data <= 9'b000001001; 
          9'b100001010: data <= 9'b000001010; 
          9'b100001011: data <= 9'b000001011; 
          9'b100001100: data <= 9'b000001100; 
          9'b100001101: data <= 9'b000001101; 
          9'b100001110: data <= 9'b000001110; 
          9'b100001111: data <= 9'b000001111; 
          9'b100010000: data <= 9'b000010000; 
          9'b100010001: data <= 9'b000010001; 
          9'b100010010: data <= 9'b000010010; 
          9'b100010011: data <= 9'b000010011; 
          9'b100010100: data <= 9'b000010100; 
          9'b100010101: data <= 9'b000010101; 
          9'b100010110: data <= 9'b000010110; 
          9'b100010111: data <= 9'b000010111; 
          9'b100011000: data <= 9'b000011000; 
          9'b100011001: data <= 9'b000011001; 
          9'b100011010: data <= 9'b000011010; 
          9'b100011011: data <= 9'b000011011; 
          9'b100011100: data <= 9'b000011100; 
          9'b100011101: data <= 9'b000011101; 
          9'b100011110: data <= 9'b000011110; 
          9'b100011111: data <= 9'b000011111; 
          9'b100100000: data <= 9'b000100000; 
          9'b100100001: data <= 9'b000100001; 
          9'b100100010: data <= 9'b000100010; 
          9'b100100011: data <= 9'b000100011; 
          9'b100100100: data <= 9'b000100100; 
          9'b100100101: data <= 9'b000100101; 
          9'b100100110: data <= 9'b000100110; 
          9'b100100111: data <= 9'b000100111; 
          9'b100101000: data <= 9'b000101000; 
          9'b100101001: data <= 9'b000101001; 
          9'b100101010: data <= 9'b000101010; 
          9'b100101011: data <= 9'b000101011; 
          9'b100101100: data <= 9'b000101100; 
          9'b100101101: data <= 9'b000101101; 
          9'b100101110: data <= 9'b000101110; 
          9'b100101111: data <= 9'b000101111; 
          9'b100110000: data <= 9'b000110000; 
          9'b100110001: data <= 9'b000110001; 
          9'b100110010: data <= 9'b000110010; 
          9'b100110011: data <= 9'b000110011; 
          9'b100110100: data <= 9'b000110100; 
          9'b100110101: data <= 9'b000110101; 
          9'b100110110: data <= 9'b000110110; 
          9'b100110111: data <= 9'b000110111; 
          9'b100111000: data <= 9'b000111000; 
          9'b100111001: data <= 9'b000111001; 
          9'b100111010: data <= 9'b000111010; 
          9'b100111011: data <= 9'b000111011; 
          9'b100111100: data <= 9'b000111100; 
          9'b100111101: data <= 9'b000111101; 
          9'b100111110: data <= 9'b000111110; 
          9'b100111111: data <= 9'b000111111; 
          9'b101000000: data <= 9'b001000000; 
          9'b101000001: data <= 9'b001000001; 
          9'b101000010: data <= 9'b001000010; 
          9'b101000011: data <= 9'b001000011; 
          9'b101000100: data <= 9'b001000100; 
          9'b101000101: data <= 9'b001000101; 
          9'b101000110: data <= 9'b001000110; 
          9'b101000111: data <= 9'b001000111; 
          9'b101001000: data <= 9'b001001000; 
          9'b101001001: data <= 9'b001001001; 
          9'b101001010: data <= 9'b001001010; 
          9'b101001011: data <= 9'b001001011; 
          9'b101001100: data <= 9'b001001100; 
          9'b101001101: data <= 9'b001001101; 
          9'b101001110: data <= 9'b001001110; 
          9'b101001111: data <= 9'b001001111; 
          9'b101010000: data <= 9'b001010000; 
          9'b101010001: data <= 9'b001010001; 
          9'b101010010: data <= 9'b001010010; 
          9'b101010011: data <= 9'b001010011; 
          9'b101010100: data <= 9'b001010100; 
          9'b101010101: data <= 9'b001010101; 
          9'b101010110: data <= 9'b001010110; 
          9'b101010111: data <= 9'b001010111; 
          9'b101011000: data <= 9'b001011000; 
          9'b101011001: data <= 9'b001011001; 
          9'b101011010: data <= 9'b001011010; 
          9'b101011011: data <= 9'b001011011; 
          9'b101011100: data <= 9'b001011100; 
          9'b101011101: data <= 9'b001011101; 
          9'b101011110: data <= 9'b001011110; 
          9'b101011111: data <= 9'b001011111; 
          9'b101100000: data <= 9'b001100000; 
          9'b101100001: data <= 9'b001100001; 
          9'b101100010: data <= 9'b001100010; 
          9'b101100011: data <= 9'b001100011; 
          9'b101100100: data <= 9'b001100100; 
          9'b101100101: data <= 9'b001100101; 
          9'b101100110: data <= 9'b001100110; 
          9'b101100111: data <= 9'b001100111; 
          9'b101101000: data <= 9'b001101000; 
          9'b101101001: data <= 9'b001101001; 
          9'b101101010: data <= 9'b001101010; 
          9'b101101011: data <= 9'b001101011; 
          9'b101101100: data <= 9'b001101100; 
          9'b101101101: data <= 9'b001101101; 
          9'b101101110: data <= 9'b001101110; 
          9'b101101111: data <= 9'b001101111; 
          9'b101110000: data <= 9'b001110000; 
          9'b101110001: data <= 9'b001110001; 
          9'b101110010: data <= 9'b001110010; 
          9'b101110011: data <= 9'b001110011; 
          9'b101110100: data <= 9'b001110100; 
          9'b101110101: data <= 9'b001110101; 
          9'b101110110: data <= 9'b001110110; 
          9'b101110111: data <= 9'b001110111; 
          9'b101111000: data <= 9'b001111000; 
          9'b101111001: data <= 9'b001111001; 
          9'b101111010: data <= 9'b001111010; 
          9'b101111011: data <= 9'b001111011; 
          9'b101111100: data <= 9'b001111100; 
          9'b101111101: data <= 9'b001111101; 
          9'b101111110: data <= 9'b001111110; 
          9'b101111111: data <= 9'b001111111; 
          9'b110000000: data <= 9'b010000000; 
          9'b110000001: data <= 9'b010000001; 
          9'b110000010: data <= 9'b010000010; 
          9'b110000011: data <= 9'b010000011; 
          9'b110000100: data <= 9'b010000100; 
          9'b110000101: data <= 9'b010000101; 
          9'b110000110: data <= 9'b010000110; 
          9'b110000111: data <= 9'b010000111; 
          9'b110001000: data <= 9'b010001000; 
          9'b110001001: data <= 9'b010001001; 
          9'b110001010: data <= 9'b010001010; 
          9'b110001011: data <= 9'b010001011; 
          9'b110001100: data <= 9'b010001100; 
          9'b110001101: data <= 9'b010001101; 
          9'b110001110: data <= 9'b010001110; 
          9'b110001111: data <= 9'b010001111; 
          9'b110010000: data <= 9'b010010000; 
          9'b110010001: data <= 9'b010010001; 
          9'b110010010: data <= 9'b010010010; 
          9'b110010011: data <= 9'b010010011; 
          9'b110010100: data <= 9'b010010100; 
          9'b110010101: data <= 9'b010010101; 
          9'b110010110: data <= 9'b010010110; 
          9'b110010111: data <= 9'b010010111; 
          9'b110011000: data <= 9'b010011000; 
          9'b110011001: data <= 9'b010011001; 
          9'b110011010: data <= 9'b010011010; 
          9'b110011011: data <= 9'b010011011; 
          9'b110011100: data <= 9'b010011100; 
          9'b110011101: data <= 9'b010011101; 
          9'b110011110: data <= 9'b010011110; 
          9'b110011111: data <= 9'b010011111; 
          9'b110100000: data <= 9'b010100000; 
          9'b110100001: data <= 9'b010100001; 
          9'b110100010: data <= 9'b010100010; 
          9'b110100011: data <= 9'b010100011; 
          9'b110100100: data <= 9'b010100100; 
          9'b110100101: data <= 9'b010100101; 
          9'b110100110: data <= 9'b010100110; 
          9'b110100111: data <= 9'b010100111; 
          9'b110101000: data <= 9'b010101000; 
          9'b110101001: data <= 9'b010101001; 
          9'b110101010: data <= 9'b010101010; 
          9'b110101011: data <= 9'b010101011; 
          9'b110101100: data <= 9'b010101100; 
          9'b110101101: data <= 9'b010101101; 
          9'b110101110: data <= 9'b010101110; 
          9'b110101111: data <= 9'b010101111; 
          9'b110110000: data <= 9'b010110000; 
          9'b110110001: data <= 9'b010110001; 
          9'b110110010: data <= 9'b010110010; 
          9'b110110011: data <= 9'b010110011; 
          9'b110110100: data <= 9'b010110100; 
          9'b110110101: data <= 9'b010110101; 
          9'b110110110: data <= 9'b010110110; 
          9'b110110111: data <= 9'b010110111; 
          9'b110111000: data <= 9'b010111000; 
          9'b110111001: data <= 9'b010111001; 
          9'b110111010: data <= 9'b010111010; 
          9'b110111011: data <= 9'b010111011; 
          9'b110111100: data <= 9'b010111100; 
          9'b110111101: data <= 9'b010111101; 
          9'b110111110: data <= 9'b010111110; 
          9'b110111111: data <= 9'b010111111; 
          9'b111000000: data <= 9'b011000000; 
          9'b111000001: data <= 9'b011000001; 
          9'b111000010: data <= 9'b011000010; 
          9'b111000011: data <= 9'b011000011; 
          9'b111000100: data <= 9'b011000100; 
          9'b111000101: data <= 9'b011000101; 
          9'b111000110: data <= 9'b011000110; 
          9'b111000111: data <= 9'b011000111; 
          9'b111001000: data <= 9'b011001000; 
          9'b111001001: data <= 9'b011001001; 
          9'b111001010: data <= 9'b011001010; 
          9'b111001011: data <= 9'b011001011; 
          9'b111001100: data <= 9'b011001100; 
          9'b111001101: data <= 9'b011001101; 
          9'b111001110: data <= 9'b011001110; 
          9'b111001111: data <= 9'b011001111; 
          9'b111010000: data <= 9'b011010000; 
          9'b111010001: data <= 9'b011010001; 
          9'b111010010: data <= 9'b011010010; 
          9'b111010011: data <= 9'b011010011; 
          9'b111010100: data <= 9'b011010100; 
          9'b111010101: data <= 9'b011010101; 
          9'b111010110: data <= 9'b011010110; 
          9'b111010111: data <= 9'b011010111; 
          9'b111011000: data <= 9'b011011000; 
          9'b111011001: data <= 9'b011011001; 
          9'b111011010: data <= 9'b011011010; 
          9'b111011011: data <= 9'b011011011; 
          9'b111011100: data <= 9'b011011100; 
          9'b111011101: data <= 9'b011011101; 
          9'b111011110: data <= 9'b011011110; 
          9'b111011111: data <= 9'b011011111; 
          9'b111100000: data <= 9'b011100000; 
          9'b111100001: data <= 9'b011100001; 
          9'b111100010: data <= 9'b011100010; 
          9'b111100011: data <= 9'b011100011; 
          9'b111100100: data <= 9'b011100100; 
          9'b111100101: data <= 9'b011100101; 
          9'b111100110: data <= 9'b011100110; 
          9'b111100111: data <= 9'b011100111; 
          9'b111101000: data <= 9'b011101000; 
          9'b111101001: data <= 9'b011101001; 
          9'b111101010: data <= 9'b011101010; 
          9'b111101011: data <= 9'b011101011; 
          9'b111101100: data <= 9'b011101100; 
          9'b111101101: data <= 9'b011101101; 
          9'b111101110: data <= 9'b011101110; 
          9'b111101111: data <= 9'b011101111; 
          9'b111110000: data <= 9'b011110000; 
          9'b111110001: data <= 9'b011110001; 
          9'b111110010: data <= 9'b011110010; 
          9'b111110011: data <= 9'b011110011; 
          9'b111110100: data <= 9'b011110100; 
          9'b111110101: data <= 9'b011110101; 
          9'b111110110: data <= 9'b011110110; 
          9'b111110111: data <= 9'b011110111; 
          9'b111111000: data <= 9'b011111000; 
          9'b111111001: data <= 9'b011111001; 
          9'b111111010: data <= 9'b011111010; 
          9'b111111011: data <= 9'b011111011; 
          9'b111111100: data <= 9'b011111100; 
          9'b111111101: data <= 9'b011111101; 
          9'b111111110: data <= 9'b011111110; 
          9'b111111111: data <= 9'b011111111; 
          default: data <= 9'b0; 
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
  input [8:0] addr;                        
  output reg [8:0] data;        
  
  // synthesis attribute rom_style of data is "block" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 9'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          9'b000000000: data <= 9'b010000000; 
          9'b000000001: data <= 9'b010100000; 
          9'b000000010: data <= 9'b010010000; 
          9'b000000011: data <= 9'b010110000; 
          9'b000000100: data <= 9'b010001000; 
          9'b000000101: data <= 9'b010101000; 
          9'b000000110: data <= 9'b010011000; 
          9'b000000111: data <= 9'b010111000; 
          9'b000001000: data <= 9'b010000100; 
          9'b000001001: data <= 9'b010100100; 
          9'b000001010: data <= 9'b010010100; 
          9'b000001011: data <= 9'b010110100; 
          9'b000001100: data <= 9'b010001100; 
          9'b000001101: data <= 9'b010101100; 
          9'b000001110: data <= 9'b010011100; 
          9'b000001111: data <= 9'b010111100; 
          9'b000010000: data <= 9'b010000010; 
          9'b000010001: data <= 9'b010100010; 
          9'b000010010: data <= 9'b010010010; 
          9'b000010011: data <= 9'b010110010; 
          9'b000010100: data <= 9'b010001010; 
          9'b000010101: data <= 9'b010101010; 
          9'b000010110: data <= 9'b010011010; 
          9'b000010111: data <= 9'b010111010; 
          9'b000011000: data <= 9'b010000110; 
          9'b000011001: data <= 9'b010100110; 
          9'b000011010: data <= 9'b010010110; 
          9'b000011011: data <= 9'b010110110; 
          9'b000011100: data <= 9'b010001110; 
          9'b000011101: data <= 9'b010101110; 
          9'b000011110: data <= 9'b010011110; 
          9'b000011111: data <= 9'b010111110; 
          9'b000100000: data <= 9'b010000001; 
          9'b000100001: data <= 9'b010100001; 
          9'b000100010: data <= 9'b010010001; 
          9'b000100011: data <= 9'b010110001; 
          9'b000100100: data <= 9'b010001001; 
          9'b000100101: data <= 9'b010101001; 
          9'b000100110: data <= 9'b010011001; 
          9'b000100111: data <= 9'b010111001; 
          9'b000101000: data <= 9'b010000101; 
          9'b000101001: data <= 9'b010100101; 
          9'b000101010: data <= 9'b010010101; 
          9'b000101011: data <= 9'b010110101; 
          9'b000101100: data <= 9'b010001101; 
          9'b000101101: data <= 9'b010101101; 
          9'b000101110: data <= 9'b010011101; 
          9'b000101111: data <= 9'b010111101; 
          9'b000110000: data <= 9'b010000011; 
          9'b000110001: data <= 9'b010100011; 
          9'b000110010: data <= 9'b010010011; 
          9'b000110011: data <= 9'b010110011; 
          9'b000110100: data <= 9'b010001011; 
          9'b000110101: data <= 9'b010101011; 
          9'b000110110: data <= 9'b010011011; 
          9'b000110111: data <= 9'b010111011; 
          9'b000111000: data <= 9'b010000111; 
          9'b000111001: data <= 9'b010100111; 
          9'b000111010: data <= 9'b010010111; 
          9'b000111011: data <= 9'b010110111; 
          9'b000111100: data <= 9'b010001111; 
          9'b000111101: data <= 9'b010101111; 
          9'b000111110: data <= 9'b010011111; 
          9'b000111111: data <= 9'b010111111; 
          9'b001000000: data <= 9'b011000000; 
          9'b001000001: data <= 9'b011100000; 
          9'b001000010: data <= 9'b011010000; 
          9'b001000011: data <= 9'b011110000; 
          9'b001000100: data <= 9'b011001000; 
          9'b001000101: data <= 9'b011101000; 
          9'b001000110: data <= 9'b011011000; 
          9'b001000111: data <= 9'b011111000; 
          9'b001001000: data <= 9'b011000100; 
          9'b001001001: data <= 9'b011100100; 
          9'b001001010: data <= 9'b011010100; 
          9'b001001011: data <= 9'b011110100; 
          9'b001001100: data <= 9'b011001100; 
          9'b001001101: data <= 9'b011101100; 
          9'b001001110: data <= 9'b011011100; 
          9'b001001111: data <= 9'b011111100; 
          9'b001010000: data <= 9'b011000010; 
          9'b001010001: data <= 9'b011100010; 
          9'b001010010: data <= 9'b011010010; 
          9'b001010011: data <= 9'b011110010; 
          9'b001010100: data <= 9'b011001010; 
          9'b001010101: data <= 9'b011101010; 
          9'b001010110: data <= 9'b011011010; 
          9'b001010111: data <= 9'b011111010; 
          9'b001011000: data <= 9'b011000110; 
          9'b001011001: data <= 9'b011100110; 
          9'b001011010: data <= 9'b011010110; 
          9'b001011011: data <= 9'b011110110; 
          9'b001011100: data <= 9'b011001110; 
          9'b001011101: data <= 9'b011101110; 
          9'b001011110: data <= 9'b011011110; 
          9'b001011111: data <= 9'b011111110; 
          9'b001100000: data <= 9'b011000001; 
          9'b001100001: data <= 9'b011100001; 
          9'b001100010: data <= 9'b011010001; 
          9'b001100011: data <= 9'b011110001; 
          9'b001100100: data <= 9'b011001001; 
          9'b001100101: data <= 9'b011101001; 
          9'b001100110: data <= 9'b011011001; 
          9'b001100111: data <= 9'b011111001; 
          9'b001101000: data <= 9'b011000101; 
          9'b001101001: data <= 9'b011100101; 
          9'b001101010: data <= 9'b011010101; 
          9'b001101011: data <= 9'b011110101; 
          9'b001101100: data <= 9'b011001101; 
          9'b001101101: data <= 9'b011101101; 
          9'b001101110: data <= 9'b011011101; 
          9'b001101111: data <= 9'b011111101; 
          9'b001110000: data <= 9'b011000011; 
          9'b001110001: data <= 9'b011100011; 
          9'b001110010: data <= 9'b011010011; 
          9'b001110011: data <= 9'b011110011; 
          9'b001110100: data <= 9'b011001011; 
          9'b001110101: data <= 9'b011101011; 
          9'b001110110: data <= 9'b011011011; 
          9'b001110111: data <= 9'b011111011; 
          9'b001111000: data <= 9'b011000111; 
          9'b001111001: data <= 9'b011100111; 
          9'b001111010: data <= 9'b011010111; 
          9'b001111011: data <= 9'b011110111; 
          9'b001111100: data <= 9'b011001111; 
          9'b001111101: data <= 9'b011101111; 
          9'b001111110: data <= 9'b011011111; 
          9'b001111111: data <= 9'b011111111; 
          9'b010000000: data <= 9'b000000000; 
          9'b010000001: data <= 9'b000100000; 
          9'b010000010: data <= 9'b000010000; 
          9'b010000011: data <= 9'b000110000; 
          9'b010000100: data <= 9'b000001000; 
          9'b010000101: data <= 9'b000101000; 
          9'b010000110: data <= 9'b000011000; 
          9'b010000111: data <= 9'b000111000; 
          9'b010001000: data <= 9'b000000100; 
          9'b010001001: data <= 9'b000100100; 
          9'b010001010: data <= 9'b000010100; 
          9'b010001011: data <= 9'b000110100; 
          9'b010001100: data <= 9'b000001100; 
          9'b010001101: data <= 9'b000101100; 
          9'b010001110: data <= 9'b000011100; 
          9'b010001111: data <= 9'b000111100; 
          9'b010010000: data <= 9'b000000010; 
          9'b010010001: data <= 9'b000100010; 
          9'b010010010: data <= 9'b000010010; 
          9'b010010011: data <= 9'b000110010; 
          9'b010010100: data <= 9'b000001010; 
          9'b010010101: data <= 9'b000101010; 
          9'b010010110: data <= 9'b000011010; 
          9'b010010111: data <= 9'b000111010; 
          9'b010011000: data <= 9'b000000110; 
          9'b010011001: data <= 9'b000100110; 
          9'b010011010: data <= 9'b000010110; 
          9'b010011011: data <= 9'b000110110; 
          9'b010011100: data <= 9'b000001110; 
          9'b010011101: data <= 9'b000101110; 
          9'b010011110: data <= 9'b000011110; 
          9'b010011111: data <= 9'b000111110; 
          9'b010100000: data <= 9'b000000001; 
          9'b010100001: data <= 9'b000100001; 
          9'b010100010: data <= 9'b000010001; 
          9'b010100011: data <= 9'b000110001; 
          9'b010100100: data <= 9'b000001001; 
          9'b010100101: data <= 9'b000101001; 
          9'b010100110: data <= 9'b000011001; 
          9'b010100111: data <= 9'b000111001; 
          9'b010101000: data <= 9'b000000101; 
          9'b010101001: data <= 9'b000100101; 
          9'b010101010: data <= 9'b000010101; 
          9'b010101011: data <= 9'b000110101; 
          9'b010101100: data <= 9'b000001101; 
          9'b010101101: data <= 9'b000101101; 
          9'b010101110: data <= 9'b000011101; 
          9'b010101111: data <= 9'b000111101; 
          9'b010110000: data <= 9'b000000011; 
          9'b010110001: data <= 9'b000100011; 
          9'b010110010: data <= 9'b000010011; 
          9'b010110011: data <= 9'b000110011; 
          9'b010110100: data <= 9'b000001011; 
          9'b010110101: data <= 9'b000101011; 
          9'b010110110: data <= 9'b000011011; 
          9'b010110111: data <= 9'b000111011; 
          9'b010111000: data <= 9'b000000111; 
          9'b010111001: data <= 9'b000100111; 
          9'b010111010: data <= 9'b000010111; 
          9'b010111011: data <= 9'b000110111; 
          9'b010111100: data <= 9'b000001111; 
          9'b010111101: data <= 9'b000101111; 
          9'b010111110: data <= 9'b000011111; 
          9'b010111111: data <= 9'b000111111; 
          9'b011000000: data <= 9'b001000000; 
          9'b011000001: data <= 9'b001100000; 
          9'b011000010: data <= 9'b001010000; 
          9'b011000011: data <= 9'b001110000; 
          9'b011000100: data <= 9'b001001000; 
          9'b011000101: data <= 9'b001101000; 
          9'b011000110: data <= 9'b001011000; 
          9'b011000111: data <= 9'b001111000; 
          9'b011001000: data <= 9'b001000100; 
          9'b011001001: data <= 9'b001100100; 
          9'b011001010: data <= 9'b001010100; 
          9'b011001011: data <= 9'b001110100; 
          9'b011001100: data <= 9'b001001100; 
          9'b011001101: data <= 9'b001101100; 
          9'b011001110: data <= 9'b001011100; 
          9'b011001111: data <= 9'b001111100; 
          9'b011010000: data <= 9'b001000010; 
          9'b011010001: data <= 9'b001100010; 
          9'b011010010: data <= 9'b001010010; 
          9'b011010011: data <= 9'b001110010; 
          9'b011010100: data <= 9'b001001010; 
          9'b011010101: data <= 9'b001101010; 
          9'b011010110: data <= 9'b001011010; 
          9'b011010111: data <= 9'b001111010; 
          9'b011011000: data <= 9'b001000110; 
          9'b011011001: data <= 9'b001100110; 
          9'b011011010: data <= 9'b001010110; 
          9'b011011011: data <= 9'b001110110; 
          9'b011011100: data <= 9'b001001110; 
          9'b011011101: data <= 9'b001101110; 
          9'b011011110: data <= 9'b001011110; 
          9'b011011111: data <= 9'b001111110; 
          9'b011100000: data <= 9'b001000001; 
          9'b011100001: data <= 9'b001100001; 
          9'b011100010: data <= 9'b001010001; 
          9'b011100011: data <= 9'b001110001; 
          9'b011100100: data <= 9'b001001001; 
          9'b011100101: data <= 9'b001101001; 
          9'b011100110: data <= 9'b001011001; 
          9'b011100111: data <= 9'b001111001; 
          9'b011101000: data <= 9'b001000101; 
          9'b011101001: data <= 9'b001100101; 
          9'b011101010: data <= 9'b001010101; 
          9'b011101011: data <= 9'b001110101; 
          9'b011101100: data <= 9'b001001101; 
          9'b011101101: data <= 9'b001101101; 
          9'b011101110: data <= 9'b001011101; 
          9'b011101111: data <= 9'b001111101; 
          9'b011110000: data <= 9'b001000011; 
          9'b011110001: data <= 9'b001100011; 
          9'b011110010: data <= 9'b001010011; 
          9'b011110011: data <= 9'b001110011; 
          9'b011110100: data <= 9'b001001011; 
          9'b011110101: data <= 9'b001101011; 
          9'b011110110: data <= 9'b001011011; 
          9'b011110111: data <= 9'b001111011; 
          9'b011111000: data <= 9'b001000111; 
          9'b011111001: data <= 9'b001100111; 
          9'b011111010: data <= 9'b001010111; 
          9'b011111011: data <= 9'b001110111; 
          9'b011111100: data <= 9'b001001111; 
          9'b011111101: data <= 9'b001101111; 
          9'b011111110: data <= 9'b001011111; 
          9'b011111111: data <= 9'b001111111; 
          9'b100000000: data <= 9'b000000000; 
          9'b100000001: data <= 9'b000000001; 
          9'b100000010: data <= 9'b000000010; 
          9'b100000011: data <= 9'b000000011; 
          9'b100000100: data <= 9'b000000100; 
          9'b100000101: data <= 9'b000000101; 
          9'b100000110: data <= 9'b000000110; 
          9'b100000111: data <= 9'b000000111; 
          9'b100001000: data <= 9'b000001000; 
          9'b100001001: data <= 9'b000001001; 
          9'b100001010: data <= 9'b000001010; 
          9'b100001011: data <= 9'b000001011; 
          9'b100001100: data <= 9'b000001100; 
          9'b100001101: data <= 9'b000001101; 
          9'b100001110: data <= 9'b000001110; 
          9'b100001111: data <= 9'b000001111; 
          9'b100010000: data <= 9'b000010000; 
          9'b100010001: data <= 9'b000010001; 
          9'b100010010: data <= 9'b000010010; 
          9'b100010011: data <= 9'b000010011; 
          9'b100010100: data <= 9'b000010100; 
          9'b100010101: data <= 9'b000010101; 
          9'b100010110: data <= 9'b000010110; 
          9'b100010111: data <= 9'b000010111; 
          9'b100011000: data <= 9'b000011000; 
          9'b100011001: data <= 9'b000011001; 
          9'b100011010: data <= 9'b000011010; 
          9'b100011011: data <= 9'b000011011; 
          9'b100011100: data <= 9'b000011100; 
          9'b100011101: data <= 9'b000011101; 
          9'b100011110: data <= 9'b000011110; 
          9'b100011111: data <= 9'b000011111; 
          9'b100100000: data <= 9'b000100000; 
          9'b100100001: data <= 9'b000100001; 
          9'b100100010: data <= 9'b000100010; 
          9'b100100011: data <= 9'b000100011; 
          9'b100100100: data <= 9'b000100100; 
          9'b100100101: data <= 9'b000100101; 
          9'b100100110: data <= 9'b000100110; 
          9'b100100111: data <= 9'b000100111; 
          9'b100101000: data <= 9'b000101000; 
          9'b100101001: data <= 9'b000101001; 
          9'b100101010: data <= 9'b000101010; 
          9'b100101011: data <= 9'b000101011; 
          9'b100101100: data <= 9'b000101100; 
          9'b100101101: data <= 9'b000101101; 
          9'b100101110: data <= 9'b000101110; 
          9'b100101111: data <= 9'b000101111; 
          9'b100110000: data <= 9'b000110000; 
          9'b100110001: data <= 9'b000110001; 
          9'b100110010: data <= 9'b000110010; 
          9'b100110011: data <= 9'b000110011; 
          9'b100110100: data <= 9'b000110100; 
          9'b100110101: data <= 9'b000110101; 
          9'b100110110: data <= 9'b000110110; 
          9'b100110111: data <= 9'b000110111; 
          9'b100111000: data <= 9'b000111000; 
          9'b100111001: data <= 9'b000111001; 
          9'b100111010: data <= 9'b000111010; 
          9'b100111011: data <= 9'b000111011; 
          9'b100111100: data <= 9'b000111100; 
          9'b100111101: data <= 9'b000111101; 
          9'b100111110: data <= 9'b000111110; 
          9'b100111111: data <= 9'b000111111; 
          9'b101000000: data <= 9'b001000000; 
          9'b101000001: data <= 9'b001000001; 
          9'b101000010: data <= 9'b001000010; 
          9'b101000011: data <= 9'b001000011; 
          9'b101000100: data <= 9'b001000100; 
          9'b101000101: data <= 9'b001000101; 
          9'b101000110: data <= 9'b001000110; 
          9'b101000111: data <= 9'b001000111; 
          9'b101001000: data <= 9'b001001000; 
          9'b101001001: data <= 9'b001001001; 
          9'b101001010: data <= 9'b001001010; 
          9'b101001011: data <= 9'b001001011; 
          9'b101001100: data <= 9'b001001100; 
          9'b101001101: data <= 9'b001001101; 
          9'b101001110: data <= 9'b001001110; 
          9'b101001111: data <= 9'b001001111; 
          9'b101010000: data <= 9'b001010000; 
          9'b101010001: data <= 9'b001010001; 
          9'b101010010: data <= 9'b001010010; 
          9'b101010011: data <= 9'b001010011; 
          9'b101010100: data <= 9'b001010100; 
          9'b101010101: data <= 9'b001010101; 
          9'b101010110: data <= 9'b001010110; 
          9'b101010111: data <= 9'b001010111; 
          9'b101011000: data <= 9'b001011000; 
          9'b101011001: data <= 9'b001011001; 
          9'b101011010: data <= 9'b001011010; 
          9'b101011011: data <= 9'b001011011; 
          9'b101011100: data <= 9'b001011100; 
          9'b101011101: data <= 9'b001011101; 
          9'b101011110: data <= 9'b001011110; 
          9'b101011111: data <= 9'b001011111; 
          9'b101100000: data <= 9'b001100000; 
          9'b101100001: data <= 9'b001100001; 
          9'b101100010: data <= 9'b001100010; 
          9'b101100011: data <= 9'b001100011; 
          9'b101100100: data <= 9'b001100100; 
          9'b101100101: data <= 9'b001100101; 
          9'b101100110: data <= 9'b001100110; 
          9'b101100111: data <= 9'b001100111; 
          9'b101101000: data <= 9'b001101000; 
          9'b101101001: data <= 9'b001101001; 
          9'b101101010: data <= 9'b001101010; 
          9'b101101011: data <= 9'b001101011; 
          9'b101101100: data <= 9'b001101100; 
          9'b101101101: data <= 9'b001101101; 
          9'b101101110: data <= 9'b001101110; 
          9'b101101111: data <= 9'b001101111; 
          9'b101110000: data <= 9'b001110000; 
          9'b101110001: data <= 9'b001110001; 
          9'b101110010: data <= 9'b001110010; 
          9'b101110011: data <= 9'b001110011; 
          9'b101110100: data <= 9'b001110100; 
          9'b101110101: data <= 9'b001110101; 
          9'b101110110: data <= 9'b001110110; 
          9'b101110111: data <= 9'b001110111; 
          9'b101111000: data <= 9'b001111000; 
          9'b101111001: data <= 9'b001111001; 
          9'b101111010: data <= 9'b001111010; 
          9'b101111011: data <= 9'b001111011; 
          9'b101111100: data <= 9'b001111100; 
          9'b101111101: data <= 9'b001111101; 
          9'b101111110: data <= 9'b001111110; 
          9'b101111111: data <= 9'b001111111; 
          9'b110000000: data <= 9'b010000000; 
          9'b110000001: data <= 9'b010000001; 
          9'b110000010: data <= 9'b010000010; 
          9'b110000011: data <= 9'b010000011; 
          9'b110000100: data <= 9'b010000100; 
          9'b110000101: data <= 9'b010000101; 
          9'b110000110: data <= 9'b010000110; 
          9'b110000111: data <= 9'b010000111; 
          9'b110001000: data <= 9'b010001000; 
          9'b110001001: data <= 9'b010001001; 
          9'b110001010: data <= 9'b010001010; 
          9'b110001011: data <= 9'b010001011; 
          9'b110001100: data <= 9'b010001100; 
          9'b110001101: data <= 9'b010001101; 
          9'b110001110: data <= 9'b010001110; 
          9'b110001111: data <= 9'b010001111; 
          9'b110010000: data <= 9'b010010000; 
          9'b110010001: data <= 9'b010010001; 
          9'b110010010: data <= 9'b010010010; 
          9'b110010011: data <= 9'b010010011; 
          9'b110010100: data <= 9'b010010100; 
          9'b110010101: data <= 9'b010010101; 
          9'b110010110: data <= 9'b010010110; 
          9'b110010111: data <= 9'b010010111; 
          9'b110011000: data <= 9'b010011000; 
          9'b110011001: data <= 9'b010011001; 
          9'b110011010: data <= 9'b010011010; 
          9'b110011011: data <= 9'b010011011; 
          9'b110011100: data <= 9'b010011100; 
          9'b110011101: data <= 9'b010011101; 
          9'b110011110: data <= 9'b010011110; 
          9'b110011111: data <= 9'b010011111; 
          9'b110100000: data <= 9'b010100000; 
          9'b110100001: data <= 9'b010100001; 
          9'b110100010: data <= 9'b010100010; 
          9'b110100011: data <= 9'b010100011; 
          9'b110100100: data <= 9'b010100100; 
          9'b110100101: data <= 9'b010100101; 
          9'b110100110: data <= 9'b010100110; 
          9'b110100111: data <= 9'b010100111; 
          9'b110101000: data <= 9'b010101000; 
          9'b110101001: data <= 9'b010101001; 
          9'b110101010: data <= 9'b010101010; 
          9'b110101011: data <= 9'b010101011; 
          9'b110101100: data <= 9'b010101100; 
          9'b110101101: data <= 9'b010101101; 
          9'b110101110: data <= 9'b010101110; 
          9'b110101111: data <= 9'b010101111; 
          9'b110110000: data <= 9'b010110000; 
          9'b110110001: data <= 9'b010110001; 
          9'b110110010: data <= 9'b010110010; 
          9'b110110011: data <= 9'b010110011; 
          9'b110110100: data <= 9'b010110100; 
          9'b110110101: data <= 9'b010110101; 
          9'b110110110: data <= 9'b010110110; 
          9'b110110111: data <= 9'b010110111; 
          9'b110111000: data <= 9'b010111000; 
          9'b110111001: data <= 9'b010111001; 
          9'b110111010: data <= 9'b010111010; 
          9'b110111011: data <= 9'b010111011; 
          9'b110111100: data <= 9'b010111100; 
          9'b110111101: data <= 9'b010111101; 
          9'b110111110: data <= 9'b010111110; 
          9'b110111111: data <= 9'b010111111; 
          9'b111000000: data <= 9'b011000000; 
          9'b111000001: data <= 9'b011000001; 
          9'b111000010: data <= 9'b011000010; 
          9'b111000011: data <= 9'b011000011; 
          9'b111000100: data <= 9'b011000100; 
          9'b111000101: data <= 9'b011000101; 
          9'b111000110: data <= 9'b011000110; 
          9'b111000111: data <= 9'b011000111; 
          9'b111001000: data <= 9'b011001000; 
          9'b111001001: data <= 9'b011001001; 
          9'b111001010: data <= 9'b011001010; 
          9'b111001011: data <= 9'b011001011; 
          9'b111001100: data <= 9'b011001100; 
          9'b111001101: data <= 9'b011001101; 
          9'b111001110: data <= 9'b011001110; 
          9'b111001111: data <= 9'b011001111; 
          9'b111010000: data <= 9'b011010000; 
          9'b111010001: data <= 9'b011010001; 
          9'b111010010: data <= 9'b011010010; 
          9'b111010011: data <= 9'b011010011; 
          9'b111010100: data <= 9'b011010100; 
          9'b111010101: data <= 9'b011010101; 
          9'b111010110: data <= 9'b011010110; 
          9'b111010111: data <= 9'b011010111; 
          9'b111011000: data <= 9'b011011000; 
          9'b111011001: data <= 9'b011011001; 
          9'b111011010: data <= 9'b011011010; 
          9'b111011011: data <= 9'b011011011; 
          9'b111011100: data <= 9'b011011100; 
          9'b111011101: data <= 9'b011011101; 
          9'b111011110: data <= 9'b011011110; 
          9'b111011111: data <= 9'b011011111; 
          9'b111100000: data <= 9'b011100000; 
          9'b111100001: data <= 9'b011100001; 
          9'b111100010: data <= 9'b011100010; 
          9'b111100011: data <= 9'b011100011; 
          9'b111100100: data <= 9'b011100100; 
          9'b111100101: data <= 9'b011100101; 
          9'b111100110: data <= 9'b011100110; 
          9'b111100111: data <= 9'b011100111; 
          9'b111101000: data <= 9'b011101000; 
          9'b111101001: data <= 9'b011101001; 
          9'b111101010: data <= 9'b011101010; 
          9'b111101011: data <= 9'b011101011; 
          9'b111101100: data <= 9'b011101100; 
          9'b111101101: data <= 9'b011101101; 
          9'b111101110: data <= 9'b011101110; 
          9'b111101111: data <= 9'b011101111; 
          9'b111110000: data <= 9'b011110000; 
          9'b111110001: data <= 9'b011110001; 
          9'b111110010: data <= 9'b011110010; 
          9'b111110011: data <= 9'b011110011; 
          9'b111110100: data <= 9'b011110100; 
          9'b111110101: data <= 9'b011110101; 
          9'b111110110: data <= 9'b011110110; 
          9'b111110111: data <= 9'b011110111; 
          9'b111111000: data <= 9'b011111000; 
          9'b111111001: data <= 9'b011111001; 
          9'b111111010: data <= 9'b011111010; 
          9'b111111011: data <= 9'b011111011; 
          9'b111111100: data <= 9'b011111100; 
          9'b111111101: data <= 9'b011111101; 
          9'b111111110: data <= 9'b011111110; 
          9'b111111111: data <= 9'b011111111; 
          default: data <= 9'b0; 
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
  input [8:0] addr;                        
  output reg [8:0] data;        
  
  // synthesis attribute rom_style of data is "block" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 9'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          9'b000000000: data <= 9'b011000000; 
          9'b000000001: data <= 9'b011100000; 
          9'b000000010: data <= 9'b011010000; 
          9'b000000011: data <= 9'b011110000; 
          9'b000000100: data <= 9'b011001000; 
          9'b000000101: data <= 9'b011101000; 
          9'b000000110: data <= 9'b011011000; 
          9'b000000111: data <= 9'b011111000; 
          9'b000001000: data <= 9'b011000100; 
          9'b000001001: data <= 9'b011100100; 
          9'b000001010: data <= 9'b011010100; 
          9'b000001011: data <= 9'b011110100; 
          9'b000001100: data <= 9'b011001100; 
          9'b000001101: data <= 9'b011101100; 
          9'b000001110: data <= 9'b011011100; 
          9'b000001111: data <= 9'b011111100; 
          9'b000010000: data <= 9'b011000010; 
          9'b000010001: data <= 9'b011100010; 
          9'b000010010: data <= 9'b011010010; 
          9'b000010011: data <= 9'b011110010; 
          9'b000010100: data <= 9'b011001010; 
          9'b000010101: data <= 9'b011101010; 
          9'b000010110: data <= 9'b011011010; 
          9'b000010111: data <= 9'b011111010; 
          9'b000011000: data <= 9'b011000110; 
          9'b000011001: data <= 9'b011100110; 
          9'b000011010: data <= 9'b011010110; 
          9'b000011011: data <= 9'b011110110; 
          9'b000011100: data <= 9'b011001110; 
          9'b000011101: data <= 9'b011101110; 
          9'b000011110: data <= 9'b011011110; 
          9'b000011111: data <= 9'b011111110; 
          9'b000100000: data <= 9'b011000001; 
          9'b000100001: data <= 9'b011100001; 
          9'b000100010: data <= 9'b011010001; 
          9'b000100011: data <= 9'b011110001; 
          9'b000100100: data <= 9'b011001001; 
          9'b000100101: data <= 9'b011101001; 
          9'b000100110: data <= 9'b011011001; 
          9'b000100111: data <= 9'b011111001; 
          9'b000101000: data <= 9'b011000101; 
          9'b000101001: data <= 9'b011100101; 
          9'b000101010: data <= 9'b011010101; 
          9'b000101011: data <= 9'b011110101; 
          9'b000101100: data <= 9'b011001101; 
          9'b000101101: data <= 9'b011101101; 
          9'b000101110: data <= 9'b011011101; 
          9'b000101111: data <= 9'b011111101; 
          9'b000110000: data <= 9'b011000011; 
          9'b000110001: data <= 9'b011100011; 
          9'b000110010: data <= 9'b011010011; 
          9'b000110011: data <= 9'b011110011; 
          9'b000110100: data <= 9'b011001011; 
          9'b000110101: data <= 9'b011101011; 
          9'b000110110: data <= 9'b011011011; 
          9'b000110111: data <= 9'b011111011; 
          9'b000111000: data <= 9'b011000111; 
          9'b000111001: data <= 9'b011100111; 
          9'b000111010: data <= 9'b011010111; 
          9'b000111011: data <= 9'b011110111; 
          9'b000111100: data <= 9'b011001111; 
          9'b000111101: data <= 9'b011101111; 
          9'b000111110: data <= 9'b011011111; 
          9'b000111111: data <= 9'b011111111; 
          9'b001000000: data <= 9'b010000000; 
          9'b001000001: data <= 9'b010100000; 
          9'b001000010: data <= 9'b010010000; 
          9'b001000011: data <= 9'b010110000; 
          9'b001000100: data <= 9'b010001000; 
          9'b001000101: data <= 9'b010101000; 
          9'b001000110: data <= 9'b010011000; 
          9'b001000111: data <= 9'b010111000; 
          9'b001001000: data <= 9'b010000100; 
          9'b001001001: data <= 9'b010100100; 
          9'b001001010: data <= 9'b010010100; 
          9'b001001011: data <= 9'b010110100; 
          9'b001001100: data <= 9'b010001100; 
          9'b001001101: data <= 9'b010101100; 
          9'b001001110: data <= 9'b010011100; 
          9'b001001111: data <= 9'b010111100; 
          9'b001010000: data <= 9'b010000010; 
          9'b001010001: data <= 9'b010100010; 
          9'b001010010: data <= 9'b010010010; 
          9'b001010011: data <= 9'b010110010; 
          9'b001010100: data <= 9'b010001010; 
          9'b001010101: data <= 9'b010101010; 
          9'b001010110: data <= 9'b010011010; 
          9'b001010111: data <= 9'b010111010; 
          9'b001011000: data <= 9'b010000110; 
          9'b001011001: data <= 9'b010100110; 
          9'b001011010: data <= 9'b010010110; 
          9'b001011011: data <= 9'b010110110; 
          9'b001011100: data <= 9'b010001110; 
          9'b001011101: data <= 9'b010101110; 
          9'b001011110: data <= 9'b010011110; 
          9'b001011111: data <= 9'b010111110; 
          9'b001100000: data <= 9'b010000001; 
          9'b001100001: data <= 9'b010100001; 
          9'b001100010: data <= 9'b010010001; 
          9'b001100011: data <= 9'b010110001; 
          9'b001100100: data <= 9'b010001001; 
          9'b001100101: data <= 9'b010101001; 
          9'b001100110: data <= 9'b010011001; 
          9'b001100111: data <= 9'b010111001; 
          9'b001101000: data <= 9'b010000101; 
          9'b001101001: data <= 9'b010100101; 
          9'b001101010: data <= 9'b010010101; 
          9'b001101011: data <= 9'b010110101; 
          9'b001101100: data <= 9'b010001101; 
          9'b001101101: data <= 9'b010101101; 
          9'b001101110: data <= 9'b010011101; 
          9'b001101111: data <= 9'b010111101; 
          9'b001110000: data <= 9'b010000011; 
          9'b001110001: data <= 9'b010100011; 
          9'b001110010: data <= 9'b010010011; 
          9'b001110011: data <= 9'b010110011; 
          9'b001110100: data <= 9'b010001011; 
          9'b001110101: data <= 9'b010101011; 
          9'b001110110: data <= 9'b010011011; 
          9'b001110111: data <= 9'b010111011; 
          9'b001111000: data <= 9'b010000111; 
          9'b001111001: data <= 9'b010100111; 
          9'b001111010: data <= 9'b010010111; 
          9'b001111011: data <= 9'b010110111; 
          9'b001111100: data <= 9'b010001111; 
          9'b001111101: data <= 9'b010101111; 
          9'b001111110: data <= 9'b010011111; 
          9'b001111111: data <= 9'b010111111; 
          9'b010000000: data <= 9'b001000000; 
          9'b010000001: data <= 9'b001100000; 
          9'b010000010: data <= 9'b001010000; 
          9'b010000011: data <= 9'b001110000; 
          9'b010000100: data <= 9'b001001000; 
          9'b010000101: data <= 9'b001101000; 
          9'b010000110: data <= 9'b001011000; 
          9'b010000111: data <= 9'b001111000; 
          9'b010001000: data <= 9'b001000100; 
          9'b010001001: data <= 9'b001100100; 
          9'b010001010: data <= 9'b001010100; 
          9'b010001011: data <= 9'b001110100; 
          9'b010001100: data <= 9'b001001100; 
          9'b010001101: data <= 9'b001101100; 
          9'b010001110: data <= 9'b001011100; 
          9'b010001111: data <= 9'b001111100; 
          9'b010010000: data <= 9'b001000010; 
          9'b010010001: data <= 9'b001100010; 
          9'b010010010: data <= 9'b001010010; 
          9'b010010011: data <= 9'b001110010; 
          9'b010010100: data <= 9'b001001010; 
          9'b010010101: data <= 9'b001101010; 
          9'b010010110: data <= 9'b001011010; 
          9'b010010111: data <= 9'b001111010; 
          9'b010011000: data <= 9'b001000110; 
          9'b010011001: data <= 9'b001100110; 
          9'b010011010: data <= 9'b001010110; 
          9'b010011011: data <= 9'b001110110; 
          9'b010011100: data <= 9'b001001110; 
          9'b010011101: data <= 9'b001101110; 
          9'b010011110: data <= 9'b001011110; 
          9'b010011111: data <= 9'b001111110; 
          9'b010100000: data <= 9'b001000001; 
          9'b010100001: data <= 9'b001100001; 
          9'b010100010: data <= 9'b001010001; 
          9'b010100011: data <= 9'b001110001; 
          9'b010100100: data <= 9'b001001001; 
          9'b010100101: data <= 9'b001101001; 
          9'b010100110: data <= 9'b001011001; 
          9'b010100111: data <= 9'b001111001; 
          9'b010101000: data <= 9'b001000101; 
          9'b010101001: data <= 9'b001100101; 
          9'b010101010: data <= 9'b001010101; 
          9'b010101011: data <= 9'b001110101; 
          9'b010101100: data <= 9'b001001101; 
          9'b010101101: data <= 9'b001101101; 
          9'b010101110: data <= 9'b001011101; 
          9'b010101111: data <= 9'b001111101; 
          9'b010110000: data <= 9'b001000011; 
          9'b010110001: data <= 9'b001100011; 
          9'b010110010: data <= 9'b001010011; 
          9'b010110011: data <= 9'b001110011; 
          9'b010110100: data <= 9'b001001011; 
          9'b010110101: data <= 9'b001101011; 
          9'b010110110: data <= 9'b001011011; 
          9'b010110111: data <= 9'b001111011; 
          9'b010111000: data <= 9'b001000111; 
          9'b010111001: data <= 9'b001100111; 
          9'b010111010: data <= 9'b001010111; 
          9'b010111011: data <= 9'b001110111; 
          9'b010111100: data <= 9'b001001111; 
          9'b010111101: data <= 9'b001101111; 
          9'b010111110: data <= 9'b001011111; 
          9'b010111111: data <= 9'b001111111; 
          9'b011000000: data <= 9'b000000000; 
          9'b011000001: data <= 9'b000100000; 
          9'b011000010: data <= 9'b000010000; 
          9'b011000011: data <= 9'b000110000; 
          9'b011000100: data <= 9'b000001000; 
          9'b011000101: data <= 9'b000101000; 
          9'b011000110: data <= 9'b000011000; 
          9'b011000111: data <= 9'b000111000; 
          9'b011001000: data <= 9'b000000100; 
          9'b011001001: data <= 9'b000100100; 
          9'b011001010: data <= 9'b000010100; 
          9'b011001011: data <= 9'b000110100; 
          9'b011001100: data <= 9'b000001100; 
          9'b011001101: data <= 9'b000101100; 
          9'b011001110: data <= 9'b000011100; 
          9'b011001111: data <= 9'b000111100; 
          9'b011010000: data <= 9'b000000010; 
          9'b011010001: data <= 9'b000100010; 
          9'b011010010: data <= 9'b000010010; 
          9'b011010011: data <= 9'b000110010; 
          9'b011010100: data <= 9'b000001010; 
          9'b011010101: data <= 9'b000101010; 
          9'b011010110: data <= 9'b000011010; 
          9'b011010111: data <= 9'b000111010; 
          9'b011011000: data <= 9'b000000110; 
          9'b011011001: data <= 9'b000100110; 
          9'b011011010: data <= 9'b000010110; 
          9'b011011011: data <= 9'b000110110; 
          9'b011011100: data <= 9'b000001110; 
          9'b011011101: data <= 9'b000101110; 
          9'b011011110: data <= 9'b000011110; 
          9'b011011111: data <= 9'b000111110; 
          9'b011100000: data <= 9'b000000001; 
          9'b011100001: data <= 9'b000100001; 
          9'b011100010: data <= 9'b000010001; 
          9'b011100011: data <= 9'b000110001; 
          9'b011100100: data <= 9'b000001001; 
          9'b011100101: data <= 9'b000101001; 
          9'b011100110: data <= 9'b000011001; 
          9'b011100111: data <= 9'b000111001; 
          9'b011101000: data <= 9'b000000101; 
          9'b011101001: data <= 9'b000100101; 
          9'b011101010: data <= 9'b000010101; 
          9'b011101011: data <= 9'b000110101; 
          9'b011101100: data <= 9'b000001101; 
          9'b011101101: data <= 9'b000101101; 
          9'b011101110: data <= 9'b000011101; 
          9'b011101111: data <= 9'b000111101; 
          9'b011110000: data <= 9'b000000011; 
          9'b011110001: data <= 9'b000100011; 
          9'b011110010: data <= 9'b000010011; 
          9'b011110011: data <= 9'b000110011; 
          9'b011110100: data <= 9'b000001011; 
          9'b011110101: data <= 9'b000101011; 
          9'b011110110: data <= 9'b000011011; 
          9'b011110111: data <= 9'b000111011; 
          9'b011111000: data <= 9'b000000111; 
          9'b011111001: data <= 9'b000100111; 
          9'b011111010: data <= 9'b000010111; 
          9'b011111011: data <= 9'b000110111; 
          9'b011111100: data <= 9'b000001111; 
          9'b011111101: data <= 9'b000101111; 
          9'b011111110: data <= 9'b000011111; 
          9'b011111111: data <= 9'b000111111; 
          9'b100000000: data <= 9'b000000000; 
          9'b100000001: data <= 9'b000000001; 
          9'b100000010: data <= 9'b000000010; 
          9'b100000011: data <= 9'b000000011; 
          9'b100000100: data <= 9'b000000100; 
          9'b100000101: data <= 9'b000000101; 
          9'b100000110: data <= 9'b000000110; 
          9'b100000111: data <= 9'b000000111; 
          9'b100001000: data <= 9'b000001000; 
          9'b100001001: data <= 9'b000001001; 
          9'b100001010: data <= 9'b000001010; 
          9'b100001011: data <= 9'b000001011; 
          9'b100001100: data <= 9'b000001100; 
          9'b100001101: data <= 9'b000001101; 
          9'b100001110: data <= 9'b000001110; 
          9'b100001111: data <= 9'b000001111; 
          9'b100010000: data <= 9'b000010000; 
          9'b100010001: data <= 9'b000010001; 
          9'b100010010: data <= 9'b000010010; 
          9'b100010011: data <= 9'b000010011; 
          9'b100010100: data <= 9'b000010100; 
          9'b100010101: data <= 9'b000010101; 
          9'b100010110: data <= 9'b000010110; 
          9'b100010111: data <= 9'b000010111; 
          9'b100011000: data <= 9'b000011000; 
          9'b100011001: data <= 9'b000011001; 
          9'b100011010: data <= 9'b000011010; 
          9'b100011011: data <= 9'b000011011; 
          9'b100011100: data <= 9'b000011100; 
          9'b100011101: data <= 9'b000011101; 
          9'b100011110: data <= 9'b000011110; 
          9'b100011111: data <= 9'b000011111; 
          9'b100100000: data <= 9'b000100000; 
          9'b100100001: data <= 9'b000100001; 
          9'b100100010: data <= 9'b000100010; 
          9'b100100011: data <= 9'b000100011; 
          9'b100100100: data <= 9'b000100100; 
          9'b100100101: data <= 9'b000100101; 
          9'b100100110: data <= 9'b000100110; 
          9'b100100111: data <= 9'b000100111; 
          9'b100101000: data <= 9'b000101000; 
          9'b100101001: data <= 9'b000101001; 
          9'b100101010: data <= 9'b000101010; 
          9'b100101011: data <= 9'b000101011; 
          9'b100101100: data <= 9'b000101100; 
          9'b100101101: data <= 9'b000101101; 
          9'b100101110: data <= 9'b000101110; 
          9'b100101111: data <= 9'b000101111; 
          9'b100110000: data <= 9'b000110000; 
          9'b100110001: data <= 9'b000110001; 
          9'b100110010: data <= 9'b000110010; 
          9'b100110011: data <= 9'b000110011; 
          9'b100110100: data <= 9'b000110100; 
          9'b100110101: data <= 9'b000110101; 
          9'b100110110: data <= 9'b000110110; 
          9'b100110111: data <= 9'b000110111; 
          9'b100111000: data <= 9'b000111000; 
          9'b100111001: data <= 9'b000111001; 
          9'b100111010: data <= 9'b000111010; 
          9'b100111011: data <= 9'b000111011; 
          9'b100111100: data <= 9'b000111100; 
          9'b100111101: data <= 9'b000111101; 
          9'b100111110: data <= 9'b000111110; 
          9'b100111111: data <= 9'b000111111; 
          9'b101000000: data <= 9'b001000000; 
          9'b101000001: data <= 9'b001000001; 
          9'b101000010: data <= 9'b001000010; 
          9'b101000011: data <= 9'b001000011; 
          9'b101000100: data <= 9'b001000100; 
          9'b101000101: data <= 9'b001000101; 
          9'b101000110: data <= 9'b001000110; 
          9'b101000111: data <= 9'b001000111; 
          9'b101001000: data <= 9'b001001000; 
          9'b101001001: data <= 9'b001001001; 
          9'b101001010: data <= 9'b001001010; 
          9'b101001011: data <= 9'b001001011; 
          9'b101001100: data <= 9'b001001100; 
          9'b101001101: data <= 9'b001001101; 
          9'b101001110: data <= 9'b001001110; 
          9'b101001111: data <= 9'b001001111; 
          9'b101010000: data <= 9'b001010000; 
          9'b101010001: data <= 9'b001010001; 
          9'b101010010: data <= 9'b001010010; 
          9'b101010011: data <= 9'b001010011; 
          9'b101010100: data <= 9'b001010100; 
          9'b101010101: data <= 9'b001010101; 
          9'b101010110: data <= 9'b001010110; 
          9'b101010111: data <= 9'b001010111; 
          9'b101011000: data <= 9'b001011000; 
          9'b101011001: data <= 9'b001011001; 
          9'b101011010: data <= 9'b001011010; 
          9'b101011011: data <= 9'b001011011; 
          9'b101011100: data <= 9'b001011100; 
          9'b101011101: data <= 9'b001011101; 
          9'b101011110: data <= 9'b001011110; 
          9'b101011111: data <= 9'b001011111; 
          9'b101100000: data <= 9'b001100000; 
          9'b101100001: data <= 9'b001100001; 
          9'b101100010: data <= 9'b001100010; 
          9'b101100011: data <= 9'b001100011; 
          9'b101100100: data <= 9'b001100100; 
          9'b101100101: data <= 9'b001100101; 
          9'b101100110: data <= 9'b001100110; 
          9'b101100111: data <= 9'b001100111; 
          9'b101101000: data <= 9'b001101000; 
          9'b101101001: data <= 9'b001101001; 
          9'b101101010: data <= 9'b001101010; 
          9'b101101011: data <= 9'b001101011; 
          9'b101101100: data <= 9'b001101100; 
          9'b101101101: data <= 9'b001101101; 
          9'b101101110: data <= 9'b001101110; 
          9'b101101111: data <= 9'b001101111; 
          9'b101110000: data <= 9'b001110000; 
          9'b101110001: data <= 9'b001110001; 
          9'b101110010: data <= 9'b001110010; 
          9'b101110011: data <= 9'b001110011; 
          9'b101110100: data <= 9'b001110100; 
          9'b101110101: data <= 9'b001110101; 
          9'b101110110: data <= 9'b001110110; 
          9'b101110111: data <= 9'b001110111; 
          9'b101111000: data <= 9'b001111000; 
          9'b101111001: data <= 9'b001111001; 
          9'b101111010: data <= 9'b001111010; 
          9'b101111011: data <= 9'b001111011; 
          9'b101111100: data <= 9'b001111100; 
          9'b101111101: data <= 9'b001111101; 
          9'b101111110: data <= 9'b001111110; 
          9'b101111111: data <= 9'b001111111; 
          9'b110000000: data <= 9'b010000000; 
          9'b110000001: data <= 9'b010000001; 
          9'b110000010: data <= 9'b010000010; 
          9'b110000011: data <= 9'b010000011; 
          9'b110000100: data <= 9'b010000100; 
          9'b110000101: data <= 9'b010000101; 
          9'b110000110: data <= 9'b010000110; 
          9'b110000111: data <= 9'b010000111; 
          9'b110001000: data <= 9'b010001000; 
          9'b110001001: data <= 9'b010001001; 
          9'b110001010: data <= 9'b010001010; 
          9'b110001011: data <= 9'b010001011; 
          9'b110001100: data <= 9'b010001100; 
          9'b110001101: data <= 9'b010001101; 
          9'b110001110: data <= 9'b010001110; 
          9'b110001111: data <= 9'b010001111; 
          9'b110010000: data <= 9'b010010000; 
          9'b110010001: data <= 9'b010010001; 
          9'b110010010: data <= 9'b010010010; 
          9'b110010011: data <= 9'b010010011; 
          9'b110010100: data <= 9'b010010100; 
          9'b110010101: data <= 9'b010010101; 
          9'b110010110: data <= 9'b010010110; 
          9'b110010111: data <= 9'b010010111; 
          9'b110011000: data <= 9'b010011000; 
          9'b110011001: data <= 9'b010011001; 
          9'b110011010: data <= 9'b010011010; 
          9'b110011011: data <= 9'b010011011; 
          9'b110011100: data <= 9'b010011100; 
          9'b110011101: data <= 9'b010011101; 
          9'b110011110: data <= 9'b010011110; 
          9'b110011111: data <= 9'b010011111; 
          9'b110100000: data <= 9'b010100000; 
          9'b110100001: data <= 9'b010100001; 
          9'b110100010: data <= 9'b010100010; 
          9'b110100011: data <= 9'b010100011; 
          9'b110100100: data <= 9'b010100100; 
          9'b110100101: data <= 9'b010100101; 
          9'b110100110: data <= 9'b010100110; 
          9'b110100111: data <= 9'b010100111; 
          9'b110101000: data <= 9'b010101000; 
          9'b110101001: data <= 9'b010101001; 
          9'b110101010: data <= 9'b010101010; 
          9'b110101011: data <= 9'b010101011; 
          9'b110101100: data <= 9'b010101100; 
          9'b110101101: data <= 9'b010101101; 
          9'b110101110: data <= 9'b010101110; 
          9'b110101111: data <= 9'b010101111; 
          9'b110110000: data <= 9'b010110000; 
          9'b110110001: data <= 9'b010110001; 
          9'b110110010: data <= 9'b010110010; 
          9'b110110011: data <= 9'b010110011; 
          9'b110110100: data <= 9'b010110100; 
          9'b110110101: data <= 9'b010110101; 
          9'b110110110: data <= 9'b010110110; 
          9'b110110111: data <= 9'b010110111; 
          9'b110111000: data <= 9'b010111000; 
          9'b110111001: data <= 9'b010111001; 
          9'b110111010: data <= 9'b010111010; 
          9'b110111011: data <= 9'b010111011; 
          9'b110111100: data <= 9'b010111100; 
          9'b110111101: data <= 9'b010111101; 
          9'b110111110: data <= 9'b010111110; 
          9'b110111111: data <= 9'b010111111; 
          9'b111000000: data <= 9'b011000000; 
          9'b111000001: data <= 9'b011000001; 
          9'b111000010: data <= 9'b011000010; 
          9'b111000011: data <= 9'b011000011; 
          9'b111000100: data <= 9'b011000100; 
          9'b111000101: data <= 9'b011000101; 
          9'b111000110: data <= 9'b011000110; 
          9'b111000111: data <= 9'b011000111; 
          9'b111001000: data <= 9'b011001000; 
          9'b111001001: data <= 9'b011001001; 
          9'b111001010: data <= 9'b011001010; 
          9'b111001011: data <= 9'b011001011; 
          9'b111001100: data <= 9'b011001100; 
          9'b111001101: data <= 9'b011001101; 
          9'b111001110: data <= 9'b011001110; 
          9'b111001111: data <= 9'b011001111; 
          9'b111010000: data <= 9'b011010000; 
          9'b111010001: data <= 9'b011010001; 
          9'b111010010: data <= 9'b011010010; 
          9'b111010011: data <= 9'b011010011; 
          9'b111010100: data <= 9'b011010100; 
          9'b111010101: data <= 9'b011010101; 
          9'b111010110: data <= 9'b011010110; 
          9'b111010111: data <= 9'b011010111; 
          9'b111011000: data <= 9'b011011000; 
          9'b111011001: data <= 9'b011011001; 
          9'b111011010: data <= 9'b011011010; 
          9'b111011011: data <= 9'b011011011; 
          9'b111011100: data <= 9'b011011100; 
          9'b111011101: data <= 9'b011011101; 
          9'b111011110: data <= 9'b011011110; 
          9'b111011111: data <= 9'b011011111; 
          9'b111100000: data <= 9'b011100000; 
          9'b111100001: data <= 9'b011100001; 
          9'b111100010: data <= 9'b011100010; 
          9'b111100011: data <= 9'b011100011; 
          9'b111100100: data <= 9'b011100100; 
          9'b111100101: data <= 9'b011100101; 
          9'b111100110: data <= 9'b011100110; 
          9'b111100111: data <= 9'b011100111; 
          9'b111101000: data <= 9'b011101000; 
          9'b111101001: data <= 9'b011101001; 
          9'b111101010: data <= 9'b011101010; 
          9'b111101011: data <= 9'b011101011; 
          9'b111101100: data <= 9'b011101100; 
          9'b111101101: data <= 9'b011101101; 
          9'b111101110: data <= 9'b011101110; 
          9'b111101111: data <= 9'b011101111; 
          9'b111110000: data <= 9'b011110000; 
          9'b111110001: data <= 9'b011110001; 
          9'b111110010: data <= 9'b011110010; 
          9'b111110011: data <= 9'b011110011; 
          9'b111110100: data <= 9'b011110100; 
          9'b111110101: data <= 9'b011110101; 
          9'b111110110: data <= 9'b011110110; 
          9'b111110111: data <= 9'b011110111; 
          9'b111111000: data <= 9'b011111000; 
          9'b111111001: data <= 9'b011111001; 
          9'b111111010: data <= 9'b011111010; 
          9'b111111011: data <= 9'b011111011; 
          9'b111111100: data <= 9'b011111100; 
          9'b111111101: data <= 9'b011111101; 
          9'b111111110: data <= 9'b011111110; 
          9'b111111111: data <= 9'b011111111; 
          default: data <= 9'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp4(
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
  output [8:0] rom_out_0;            
  output [8:0] rom_out_1;            
  output [8:0] rom_out_2;            
  output [8:0] rom_out_3;            
  output wen_out;
  output out_start;
  
  reg [8:0] rom_addr_0;        
  reg [1:0] state;        
  
  addr_rom_dp4_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp4_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_1)); 
  addr_rom_dp4_mem2 addr_rom_inst_2(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_2)); 
  addr_rom_dp4_mem3 addr_rom_inst_3(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_3)); 
  
  assign wen_out = state[0];        
  assign out_start = (state == 2'b01) && (rom_addr_0[7:0] == {8{1'b0}}); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 9'b0;    
      state <= 1'b0;            
      end
    else begin                        
      case (state)              
        2'b00: begin              
          rom_addr_0 <= 9'b0;   
          if (in_start)  begin              
            state <= 2'b01;              
            rom_addr_0 <= rom_addr_0 + 1;    
          end
        end
        2'b01: begin              
          rom_addr_0 <= rom_addr_0 + 1;    
          if (rom_addr_0 == {8{1'b0}})  begin 
            state <= 2'b11;              
          end
        end
        2'b11: begin              
          rom_addr_0 <= rom_addr_0 + 1;    
          if (in_start)  begin              
            state <= 2'b01;              
          end
          else if (rom_addr_0 == {8{1'b0}})  begin 
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
  
  wire [DATA_WIDTH-1:0] wire_in [3:0];              
  wire [DATA_WIDTH-1:0] wire_out [3:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  assign wire_in[2] = inData_2;    
  assign wire_in[3] = inData_3;    
  
  wire [8:0] addr_wire_0;        
  wire [8:0] addr_wire_1;        
  wire [8:0] addr_wire_2;        
  wire [8:0] addr_wire_3;        
  addr_rom_ctrl_dp4 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .rom_out_2(addr_wire_2), .rom_out_3(addr_wire_3), .clk(clk), .rst(rst));

  block_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(9)) 
         ram_inst_0(.wen(wen_wire), .en(1'b1), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  block_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(9)) 
         ram_inst_1(.wen(wen_wire), .en(1'b1), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  block_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(9)) 
         ram_inst_2(.wen(wen_wire), .en(1'b1), .addr(addr_wire_2), .din(wire_in[2]), .dout(wire_out[2]), .clk(clk) );

  block_ram_sp #(.DATA_WIDTH(32), .ADDR_WIDTH(9)) 
         ram_inst_3(.wen(wen_wire), .en(1'b1), .addr(addr_wire_3), .din(wire_in[3]), .dout(wire_out[3]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign outData_2 = wire_out[2];    
  assign outData_3 = wire_out[3];    
  assign out_start = out_start_wire;    
  
endmodule                        


module per_dp4_5(
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

  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  assign wireIn[2] = inData_2;    
  assign wireIn[3] = inData_3;    
  
  ingressStage_p4 ingressStage_p4_inst(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .inData_2(wireIn[2]), .inData_3(wireIn[3]), .outData_0(wireOut_LB[0]), .outData_1(wireOut_LB[1]), .outData_2(wireOut_LB[2]), .outData_3(wireOut_LB[3]), .in_start(in_start), .out_start(out_start_LB), .clk(clk), .rst(rst));
  
  mem_stage_dp4 mem_stage_dp4_inst(.inData_0(wireOut_LB[0]), .inData_1(wireOut_LB[1]), .inData_2(wireOut_LB[2]), .inData_3(wireOut_LB[3]), .outData_0(wireIn_RB[0]), .outData_1(wireIn_RB[1]), .outData_2(wireIn_RB[2]), .outData_3(wireIn_RB[3]), .in_start(out_start_LB), .out_start(out_start_MemStage), .clk(clk), .rst(rst));
  
  egressStage_p4 egressStage_p4_inst(.inData_0(wireIn_RB[0]), .inData_1(wireIn_RB[1]), .inData_2(wireIn_RB[2]), .inData_3(wireIn_RB[3]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .outData_2(wireOut[2]), .outData_3(wireOut[3]), .in_start(out_start_MemStage), .out_start(out_start_RB), .clk(clk), .rst(rst));
  
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign outData_2 = wireOut[2];    
  assign outData_3 = wireOut[3];    
  assign out_start = out_start_RB;    
  
endmodule                        

