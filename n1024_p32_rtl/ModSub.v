`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2020 04:22:09 PM
// Design Name: 
// Module Name: ModSub
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


module ModSub(
        input   [27:0]  x,
        input   [27:0]  y,
        input   [27:0]  q,
        input   [27:0]  clk,
        output  [27:0]  out
    );
    
    wire [28:0] z1;
    wire [28:0] z2;
    
    assign z1 = x - y;
    assign z2 = z1 + q;
    
    assign out = (z2 < q) ? z2[27:0] : z1[27:0];   
    
endmodule
