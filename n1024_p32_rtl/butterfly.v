`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2020 12:10:19 AM
// Design Name: 
// Module Name: butterfly
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module butterfly(
        input   [27:0]  x_in,
        input   [27:0]  y_in,
        output  [27:0]  x_out,
        output  [27:0]  y_out,
        input           clk,
        input           rst
    );
    
    wire    [27:0]  mult;
    wire    [27:0]  w;
    wire    [27:0]  q;
    wire    [27:0]  add_out;
    wire    [27:0]  sub_out;
    
    reg     [27:0]  mult_reg;
    reg     [27:0]  x_out_reg;
    reg     [27:0]  y_out_reg;
    reg     [27:0]  x1_reg;
    reg     [27:0]  x2_reg;
    reg     [27:0]  x3_reg;
    reg     [27:0]  x4_reg;
    reg     [27:0]  x5_reg;
        
    assign  w = 28'habcdef0;
    assign  q = (1<<28) - (1<<16) + 1;
    
    assign  x_out = x_out_reg;
    assign  y_out = y_out_reg;
    
    modularMult mm (y_in, w, q, clk, rst, mult);
    ModAdd ma (x5_reg, mult_reg, q, clk, add_out);
    ModSub ms (x5_reg, mult_reg, q, clk, sub_out);
    
    always_ff @(posedge clk) begin
        if (rst) begin
            mult_reg <= 0;
            x1_reg <= 0;
            x2_reg <= 0;
            x3_reg <= 0;
            x4_reg <= 0;
            x5_reg <= 0;
            x_out_reg <= 0;
            y_out_reg <= 0;
        end
        else begin
            mult_reg <= mult;
            x1_reg <= x_in;
            x2_reg <= x1_reg;
            x3_reg <= x2_reg;
            x4_reg <= x3_reg;
            x5_reg <= x4_reg;
            x_out_reg <= add_out;
            y_out_reg <= sub_out;
        end
    end
    
    
endmodule
