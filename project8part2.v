`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2022 03:28:18 PM
// Design Name: 
// Module Name: part2
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


module counter1(
    input clk, rst,
    output reg [27:0] counterout
    );
    
 always @ (posedge(clk), posedge(rst))
 begin
     if (rst) counterout <= 0;
     else if (clk) counterout <= counterout + 1;
end
endmodule

module takeout(
    input [27:0] counterout,
    output X
    );

assign X = counterout[27];
endmodule

module counter2(
    input clk, rst,
    output reg [3:0] counterout
    );
    
 always @ (posedge(clk), posedge(rst))
 begin
     if (rst) counterout <= 0;
     else if (clk) counterout <= counterout + 1;
end
endmodule
