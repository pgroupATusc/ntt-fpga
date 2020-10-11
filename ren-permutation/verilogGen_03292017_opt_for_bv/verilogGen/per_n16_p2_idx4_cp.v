
module switch_2_2(
inData_0,
inData_1,
outData_0,
outData_1,
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 8;                                
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


module switch_1_2(
inData_0,
outData_0,
outData_1,
ctrl                            
);                              
  parameter DATA_WIDTH = 8;                                
  input ctrl;                   
  input [DATA_WIDTH-1:0] inData_0;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  
  wire [DATA_WIDTH-1:0] wireIn [0:0];              
  wire [DATA_WIDTH-1:0] wireOut [1:0];              
  
  assign wireIn[0] = inData_0;    
  
  assign wireOut[0] = (!ctrl) ? wireIn[0] : 0;    
  assign wireOut[1] = (ctrl) ? wireIn[0] : 0;     
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  
endmodule                        


module switch_2_1(
inData_0,
inData_1,
outData_0,
ctrl                             
);                               
  parameter DATA_WIDTH = 8;                                
  input ctrl;                      
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0;
  
  wire [DATA_WIDTH-1:0] wireIn [1:0];              
  wire [DATA_WIDTH-1:0] wireOut [0:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  
  assign wireOut[0] = (!ctrl) ? wireIn[0] : wireIn[1];    
  
  assign outData_0 = wireOut[0];    
  
endmodule                        


module  block_ram_sp(
wen,                              
en,                              
clk,                             
addr,                            
din,                            
dout                             
);                               
  parameter DATA_WIDTH = 8;                                
  parameter ADDR_WIDTH = 3;                                
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
  parameter DATA_WIDTH = 8;                                
  parameter ADDR_WIDTH = 3;                                
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
  parameter DATA_WIDTH = 8;                                
  parameter ADDR_WIDTH = 3;                                
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
  parameter DATA_WIDTH = 8;                                
  parameter ADDR_WIDTH = 3;                                
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


module switches_stage_st0_4_L_r(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 8;                                
  input in_start, clk, rst;                   
  input [1-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output reg [DATA_WIDTH-1:0] outData_0,
      outData_1; 
  output reg out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [1:0];              
  wire [DATA_WIDTH-1:0] wireOut [1:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      outData_0 <= 0;    
      outData_1 <= 0;    
      out_start <= 1'b0;              
      end
    else begin                        
      outData_0 <= wireOut[0];    
      outData_1 <= wireOut[1];    
      out_start <= in_start;    
      end
  end                              

endmodule                        


module ctrl_rom_dp2_st0_per4L(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
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
          3'b000: data <= 1'b0; 
          3'b001: data <= 1'b0; 
          3'b010: data <= 1'b0; 
          3'b011: data <= 1'b0; 
          3'b100: data <= 1'b1; 
          3'b101: data <= 1'b1; 
          3'b110: data <= 1'b1; 
          3'b111: data <= 1'b1; 
          default: data <= 1'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp2_st0_per4L(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [0:0] ctrl_out;        
  
  reg state;
  reg [2:0] addr;        
  
  ctrl_rom_dp2_st0_per4L ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 3'b0;       
      state <= 1'b0;       
      end
    else begin  
      case(state)                        
          1'b0: begin
            addr <= 3'b0; 
            if (in_start) begin
                state <= 1'b1;
                addr <= addr + 1;
             end
          end
          1'b1: begin 
            addr <= addr + 1; 
            if (addr == 3'b111) begin
                state <= 1'b0;
            end
          end
      endcase                      
    end
  end                                 

endmodule                        


module wireCon_dp2_st0_L(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 8;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [1:0];              
  wire [DATA_WIDTH-1:0] wireOut [1:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[1];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign out_start = in_start;    
  
endmodule                        


module ingressStage_p2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 8;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  
  wire out_start_w; 
  wire [DATA_WIDTH-1:0] wireIn [1:0];              
  wire [DATA_WIDTH-1:0] wireOut [1:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  
  wire [DATA_WIDTH-1:0] wire_con_in_stage0[1:0];
  wire [DATA_WIDTH-1:0] wire_con_out_stage0[1:0];
  wire [0:0] wire_ctrl_stage0;
  wire in_start_stage0;
  wire con_in_start_stage0;

  switches_stage_st0_4_L_r switch_stage_0(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), 
        .outData_0(wire_con_in_stage0[0]), .outData_1(wire_con_in_stage0[1]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp2_st0_L wire_stage_0(
        .inData_0(wire_con_in_stage0[0]), .inData_1(wire_con_in_stage0[1]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), 
        .in_start(con_in_start_stage0), .out_start(out_start_w), .clk(clk), .rst(rst));
  
  switch_ctrl_dp2_st0_per4L switch_ctrl_stage_0(.in_start(in_start_stage0),.ctrl_out(wire_ctrl_stage0),.clk(clk), .rst(rst));

  
  assign in_start_stage0 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign out_start = out_start_w;    
  
endmodule                        


module switches_stage_st0_4_R_r(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
ctrl,                            
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 8;                                
  input in_start, clk, rst;                   
  input [1-1:0] ctrl;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output reg [DATA_WIDTH-1:0] outData_0,
      outData_1; 
  output reg out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [1:0];              
  wire [DATA_WIDTH-1:0] wireOut [1:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  
  switch_2_2 switch_inst_0(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .ctrl(ctrl[0]), .clk(clk), .rst(rst));
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      outData_0 <= 0;    
      outData_1 <= 0;    
      out_start <= 1'b0;              
      end
    else begin                        
      outData_0 <= wireOut[0];    
      outData_1 <= wireOut[1];    
      out_start <= in_start;    
      end
  end                              

endmodule                        


module ctrl_rom_dp2_st0_per4R(
en,                              
clk,                             
rst,                             
addr,                            
data                             
);                               
  input en, clk, rst;                   
  input [2:0] addr;                        
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
          3'b000: data <= 1'b0; 
          3'b001: data <= 1'b0; 
          3'b010: data <= 1'b0; 
          3'b011: data <= 1'b0; 
          3'b100: data <= 1'b1; 
          3'b101: data <= 1'b1; 
          3'b110: data <= 1'b1; 
          3'b111: data <= 1'b1; 
          default: data <= 1'b0; 
        endcase
    end
  end                              

endmodule                        


module switch_ctrl_dp2_st0_per4R(
in_start,                          
ctrl_out,                        
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [0:0] ctrl_out;        
  
  reg state;
  reg [2:0] addr;            
  
  ctrl_rom_dp2_st0_per4R ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); 
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      addr <= 3'b0;       
      state <= 1'b0;       
      end
    else begin  
      case(state)                        
          1'b0: begin
            addr <= 3'b0; 
            if (in_start) begin
                state <= 1'b1;
                addr <= addr + 1;
             end
          end
          1'b1: begin 
            addr <= addr + 1; 
            if (addr == 3'b111) begin
                state <= 1'b0;
              end
          end
      endcase                      
    end
  end                              

endmodule                        


module wireCon_dp2_st0_R(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 8;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [1:0];              
  wire [DATA_WIDTH-1:0] wireOut [1:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  
  assign wireOut[0] = wireIn[0];    
  assign wireOut[1] = wireIn[1];    
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign out_start = in_start;    
  
endmodule                        


module egressStage_p2(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 8;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  
  wire out_start_w; 
  wire [DATA_WIDTH-1:0] wireIn [1:0];              
  wire [DATA_WIDTH-1:0] wireOut [1:0];              
  
  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  
  wire [DATA_WIDTH-1:0] wire_switch_in_stage0[1:0];
  wire [DATA_WIDTH-1:0] wire_switch_out_stage0[1:0];
  wire [0:0] wire_ctrl_stage0;
  wire in_start_stage0;
  wire con_in_start_stage0;

  switches_stage_st0_4_R_r switch_stage_0(
        .inData_0(wire_switch_in_stage0[0]), .inData_1(wire_switch_in_stage0[1]), 
        .outData_0(wireOut[0]), .outData_1(wireOut[1]), 
        .in_start(con_in_start_stage0), .out_start(out_start_w), .ctrl(wire_ctrl_stage0), .clk(clk), .rst(rst));
  
  wireCon_dp2_st0_R wire_stage_0(
        .inData_0(wireIn[0]), .inData_1(wireIn[1]), 
        .outData_0(wire_switch_in_stage0[0]), .outData_1(wire_switch_in_stage0[1]), 
        .in_start(in_start_stage0), .out_start(con_in_start_stage0), .clk(clk), .rst(rst));
  
  switch_ctrl_dp2_st0_per4R switch_ctrl_stage_0(.in_start(con_in_start_stage0),.ctrl_out(wire_ctrl_stage0),.clk(clk), .rst(rst));

  
  assign in_start_stage0 = in_start;    
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign out_start = out_start_w;    
  
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
          2'b01: data <= 2'b01; 
          2'b10: data <= 2'b10; 
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
          2'b01: data <= 2'b01; 
          2'b10: data <= 2'b10; 
          2'b11: data <= 2'b11; 
          default: data <= 2'b0; 
        endcase
    end
  end                              

endmodule                        


module  addr_rom_ctrl_dp2(
in_start,                          
wen_out_up,
wen_out_down,                         
out_start,                         
rom_out_0,                         
rom_out_1,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [1:0] rom_out_0;            
  output [1:0] rom_out_1;            
  output wen_out_up;
  output wen_out_down;
  output out_start;
  
  reg [1:0] rom_addr_0;  
  reg [1:0] state;       
  
  addr_rom_dp2_mem0 addr_rom_inst_0(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_0)); 
  addr_rom_dp2_mem1 addr_rom_inst_1(.en(1'b1),.clk(clk),.rst(rst),.addr(rom_addr_0),.data(rom_out_1)); 
  
  assign wen_out_up = state[1];      
  assign wen_out_down = state[0];  
  assign out_start = (state == 2'b11 && (rom_addr_0 == 0)); 

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      rom_addr_0 <= 2'b0;        
      state <= 2'b0;       
      end
    else begin                        
      case(state)                        
          2'b00: begin
            rom_addr_0 <= 2'b0; 
            if (in_start) begin
                state <= 2'b11;
                rom_addr_0 <= rom_addr_0 + 1;
             end
          end
          2'b11: begin 
            rom_addr_0 <= rom_addr_0 + 1;
            if (rom_addr_0 == 0) begin
                state <= 2'b10;
              end
          end
		  2'b10: begin 
            rom_addr_0 <= rom_addr_0 + 1;
			if (in_start) 
				state <= 2'b11;
            else if (rom_addr_0 == 0) begin
                state <= 2'b01;
              end
          end
		  2'b01: begin 
            rom_addr_0 <= rom_addr_0 + 1;
            if (rom_addr_0 == 0) begin
                state <= 2'b0;
              end
          end
      endcase                                   
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
  parameter DATA_WIDTH = 8;                                
  input in_start, clk, rst;                   
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1;
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wire_in [1:0];              
  wire [DATA_WIDTH-1:0] wire_out [1:0];              
  
  wire wen_up_wire, wen_down_wire;              
  wire out_start_wire;              
  assign wire_in[0] = inData_0;    
  assign wire_in[1] = inData_1;    
  
  wire [1:0] addr_wire_0;        
  wire [1:0] addr_wire_1;        
  addr_rom_ctrl_dp2 addr_gen_inst(.in_start(in_start), .wen_out_up(wen_up_wire), .wen_out_down(wen_down_wire), .out_start(out_start_wire)
                                , .rom_out_0(addr_wire_0), .rom_out_1(addr_wire_1), .clk(clk), .rst(rst));

  dist_ram_sp #(.DATA_WIDTH(8), .ADDR_WIDTH(2)) 
         ram_inst_0(.wen(wen_up_wire), .addr(addr_wire_0), .din(wire_in[0]), .dout(wire_out[0]), .clk(clk) );

  wire [DATA_WIDTH-1:0] in_switch_1_out0;              
  wire [DATA_WIDTH-1:0] out_switch_1_in0;             
  
  wire [DATA_WIDTH-1:0] in_out_switch_1;             
  
  dist_ram_sp #(.DATA_WIDTH(8), .ADDR_WIDTH(2)) 
         ram_inst_1(.wen(wen_down_wire), .addr(addr_wire_1), .din(in_switch_1_out0),.dout(out_switch_1_in0),.clk(clk) );

  reg ctrl_in_switch; 
        switch_1_2 #(.DATA_WIDTH(8)) 
         in_switch_inst_1(.ctrl(ctrl_in_switch), .inData_0(wire_in[1]), .outData_0(in_switch_1_out0),.outData_1(in_out_switch_1));

  reg ctrl_out_switch; 
        switch_2_1 #(.DATA_WIDTH(8)) 
         out_switch_inst_1(.ctrl(ctrl_out_switch), .inData_0(out_switch_1_in0),.inData_1(in_out_switch_1),.outData_0(wire_out[1]) );

  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      ctrl_in_switch <= 1'b0;             
      ctrl_out_switch <= 1'b0;            
      end
    else begin                        
      if(in_start) begin                    
      ctrl_in_switch <= 1'b0;            
      end
    else if (addr_wire_1 == 3) begin 
      ctrl_in_switch <= 1'b1;           
      end
	  
	  if(out_start) begin              
      ctrl_out_switch <= 1'b1;            
      end
    else if (addr_wire_1 == 3) begin       
      ctrl_out_switch <= 1'b0;            
      end
    end
  end                              

  assign outData_0 = wire_out[0];    
  assign outData_1 = wire_out[1];    
  assign out_start = out_start_wire;    
  
endmodule                        


module per_dp2_4(
inData_0,
inData_1,
outData_0,
outData_1,
in_start,                        
out_start,                       
clk,                             
rst                              
);                               
  parameter DATA_WIDTH = 8;                                
  input in_start, clk, rst;        
  input [DATA_WIDTH-1:0] inData_0,
      inData_1;
  output [DATA_WIDTH-1:0] outData_0,
      outData_1; 
  output out_start; 
  
  wire [DATA_WIDTH-1:0] wireIn [1:0];                  
  wire [DATA_WIDTH-1:0] wireOut [1:0];                 
  wire [DATA_WIDTH-1:0] wireOut_LB [1:0];              
  wire [DATA_WIDTH-1:0] wireIn_RB [1:0];               
  wire out_start_LB;               
  wire out_start_MemStage;               
  wire out_start_RB;               

  assign wireIn[0] = inData_0;    
  assign wireIn[1] = inData_1;    
  
  ingressStage_p2 ingressStage_p2_inst(.inData_0(wireIn[0]), .inData_1(wireIn[1]), .outData_0(wireOut_LB[0]), .outData_1(wireOut_LB[1]), .in_start(in_start), .out_start(out_start_LB), .clk(clk), .rst(rst));
  
  mem_stage_dp2 mem_stage_dp2_inst(.inData_0(wireOut_LB[0]), .inData_1(wireOut_LB[1]), .outData_0(wireIn_RB[0]), .outData_1(wireIn_RB[1]), .in_start(out_start_LB), .out_start(out_start_MemStage), .clk(clk), .rst(rst));
  
  egressStage_p2 egressStage_p2_inst(.inData_0(wireIn_RB[0]), .inData_1(wireIn_RB[1]), .outData_0(wireOut[0]), .outData_1(wireOut[1]), .in_start(out_start_MemStage), .out_start(out_start_RB), .clk(clk), .rst(rst));
  
  
  assign outData_0 = wireOut[0];    
  assign outData_1 = wireOut[1];    
  assign out_start = out_start_RB;    
  
endmodule                        

