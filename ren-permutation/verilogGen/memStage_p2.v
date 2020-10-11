
module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1#(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_1 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk), .rst(rst));

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp ram_inst_1 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp ram_inst_1 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp ram_inst_0 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp ram_inst_1 #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
        (.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_0(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_1(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;                                        
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_0(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_1(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_0(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_1(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_0(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_1(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_0(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_1(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
in_data_0,                       
in_data_1,                       
out_data_0,                       
out_data_1,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_0(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_1(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter_128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_0(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_1(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[6:0] == 127); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[6:0] == 127) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter_128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_0(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_1(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module  counter_128(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [6:0] counter_out;            
  
  reg [6:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 7'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[6:0] == 127) begin  
        status_couting <= 1'b0;                 
        counter_r <= 7'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
in_data_0,
in_data_1,
out_data_0,
out_data_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] in_data_0,
      in_data_1;
  output [DATA_WIDTH-1:0] out_data_0,
      out_data_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = in_data_0;    
  assign wire_in[1] = in_data_1;    
  
  wire [6:0] addr_w_wire_0;        
  wire [6:0] addr_w_wire_1;        
  wire [6:0] addr_r_wire_0;        

  counter_128 counter_inst(.in_start(in_start), .counter_out(addr_r_wire_0), .clk(clk), .rst(rst));

  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_w_wire_0), .rom_out_1(addr_w_wire_1), .clk(clk), .rst(rst));

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_0(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_dp #(.DATA_WIDTH(16), .ADDR_WIDTH(7)) 
         ram_inst_1(.wen(wen_wire), .addr_r(addr_r_wire_0), .addr_w(addr_w_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign out_data_0 = wire_out[0];    
  assign out_data_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData0,
inData1,
outData0,
outData1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData0,
      inData1;
  output [DATA_WIDTH-1:0] outData0,
      outData1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData0;    
  assign wire_in[1] = inData1;    
  
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData0,
inData1,
outData0,
outData1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData0,
      inData1;
  output [DATA_WIDTH-1:0] outData0,
      outData1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData0;    
  assign wire_in[1] = inData1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData0 = wire_out[0];    
  assign outData1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData0,
inData1,
outData0,
outData1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData0,
      inData1;
  output [DATA_WIDTH-1:0] outData0,
      outData1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData0;    
  assign wire_in[1] = inData1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData0 = wire_out[0];    
  assign outData1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData0,
inData1,
outData0,
outData1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData0,
      inData1;
  output [DATA_WIDTH-1:0] outData0,
      outData1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData0;    
  assign wire_in[1] = inData1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData0 = wire_out[0];    
  assign outData1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData0,
inData1,
outData0,
outData1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData0,
      inData1;
  output [DATA_WIDTH-1:0] outData0,
      outData1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData0;    
  assign wire_in[1] = inData1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData0 = wire_out[0];    
  assign outData1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH([2, 3])) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData0;    
  assign wire_in[1] = inData1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData0 = wire_out[0];    
  assign outData1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
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
      end                                    
    end
  end                              

endmodule                        


module  counter_8(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [2:0] counter_out;            
  
  reg [2:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 3'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[2:0] == 7) begin  
        status_couting <= 1'b0;                 
        counter_r <= 3'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      end                                    
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem0(
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
          2'b00: data <= 2'b00; 
          2'b01: data <= 2'b10; 
          2'b10: data <= 2'b01; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_dp2_mem1(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
  output reg [2:0] data;        
  
  // synthesis attribute rom_style of data is "distributed" 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      data <= 3'b0;    
      end
    else begin                        
      if (en)                           
        case(addr)                        
          3'b000: data <= 3'b000; 
          3'b001: data <= 3'b010; 
          3'b010: data <= 3'b001; 
          3'b011: data <= 3'b011; 
          3'b100: data <= 3'b000; 
          3'b101: data <= 3'b011; 
          3'b110: data <= 3'b010; 
          3'b111: data <= 3'b001; 
          default: data <= 3'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [2:0] rom_out_1;            
  output wen_out;
  output out_start;
  
  reg [1:0] rom_addr_0;        
  reg [2:0] rom_addr_1;        
  reg addr_updating;        
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_1),.data(rom_out_1)); 
  
  assign wen_out = addr_updating;        
  assign out_start = (rom_addr_0[1:0] == 3); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;    
      rom_addr_1 <= 3'b0;    
      addr_updating <= 1'b0;            
      end
    else begin                        
      if (addr_updating || in_start == 1'b1)  begin              
        rom_addr_0 <= rom_addr_0 + 1;    
        rom_addr_1 <= rom_addr_1 + 1;    
        end
      if (rom_addr_0[1:0] == 3) begin  
        addr_updating <= 1'b0;                 
        rom_addr_0 <= 2'b0;    
        rom_addr_1 <= 3'b0;    
        end
      if (in_start) begin                     
        addr_updating <= 1'b1;                 
        end                                    
    end
  end                              

endmodule                        


module mem_stage_dp2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 16;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData0;    
  assign wire_in[1] = inData1;    
  
  wire [1:0] addr_wire_0;        
  wire [2:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out(wen_wire), .out_start(out_start_wire), .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  dist_ram_sp #(.DATA_WIDTH(16), .ADDR_WIDTH(3)) 
         ram_inst_1(.wen(wen_wire), .addr(addr_wire_1), .din(wire_in[1]), .dout(wire_out[1]), .clk(clk) );

  
  assign outData0 = wire_out[0];    
  assign outData1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        

