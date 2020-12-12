`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2020 03:35:33 PM
// Design Name: 
// Module Name: modular_mult
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


module modular_mult(
        input       [27:0]      a, 
        input       [27:0]      b,
        input       [27:0]      q,
        input                   clk,
        input                   rst,
        output      [27:0]      out
    );
    
    reg [27:0] a_reg;
    reg [27:0] b_reg;
    reg [55:0] z_reg;
    reg [27:0] z2_reg;
    reg [27:0] z3_reg;
    reg [27:0] d_reg;
    reg [27:0] d2_reg;
    reg [27:0] d3_reg;
    reg [27:0] d4_reg;
    reg [13:0] c_reg;
    reg [27:0] c2_reg;
    reg [27:0] f_reg;
    
    wire [55:0] z;
    wire [13:0] c;
    wire [27:0] d;
    wire [12:0] e;
    wire [27:0] f;
    wire [27:0] c2;
    wire [27:0] res;
    
    assign c = z_reg[55:52] + z_reg[51:40] + z_reg[39:28];
    assign d = z_reg[55:52] + z_reg[55:40] + z_reg[55:28];
    
    assign e = c_reg[13:12] + c_reg[11:0];
    assign f = ((e[12] + e[11:0]) << 16) - (c_reg[13:12] + e[12]);

    mod_add ma (f_reg, z3_reg, q, clk, c2);
    mod_sub ms (c2_reg, d3_reg, q, clk, out);  
          
    assign z = a_reg * b_reg;
    
    always_ff @(posedge clk) begin
        if (rst) begin
            a_reg <= 0;
            b_reg <= 0;
            z_reg <= 0;
            z2_reg <= 0;
            z3_reg <= 0;
            c_reg <= 0;
            d_reg <= 0;
            d2_reg <= 0;
            d3_reg <= 0;
            c2_reg <= 0;
            f_reg <= 0;
        end
        else begin
            a_reg <= a;
            b_reg <= b;
            z_reg <= z;
            z2_reg <= z_reg[27:0];
            z3_reg <= z2_reg;
            c_reg <= c;
            d_reg <= d;
            d2_reg <= d_reg;
            d3_reg <= d2_reg;
            c2_reg <= c2;
            f_reg <= f;
        end
    end

endmodule
