`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2022 05:31:07 PM
// Design Name: 
// Module Name: part3b
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


module ClkDivider1 (
    input clk, rst,
    output reg clk_div
    );
	
localparam terminalcount = (50000 - 1);
reg [17:0] count;
wire tc;

assign tc = (count == terminalcount);	// Place a comparator on the counter output

always @ (posedge(clk), posedge(rst))
begin
    if (rst) count <= 0;
    else if (tc) count <= 0;		// Reset counter when terminal count reached
    else count <= count + 1;
end

always @ (posedge(clk), posedge(rst))
begin
    if (rst) clk_div <= 0;
    else if (tc) clk_div = !clk_div;	// T-FF with tc as input signal
end
endmodule

module ClkDivider2 (
    input clk, rst,
    output reg clk_div
    );
	
localparam terminalcount = (500 - 1);
reg [17:0] count;
wire tc;

assign tc = (count == terminalcount);	// Place a comparator on the counter output

always @ (posedge(clk), posedge(rst))
begin
    if (rst) count <= 0;
    else if (tc) count <= 0;		// Reset counter when terminal count reached
    else count <= count + 1;
end

always @ (posedge(clk), posedge(rst))
begin
    if (rst) clk_div <= 0;
    else if (tc) clk_div = !clk_div;	// T-FF with tc as input signal
end
endmodule

module decoder_7_seg(
    input [3:0] I0,
    output reg [7:0] SEG
    );

always @(I0)
begin
    case(I0)
        0 : SEG = 7'b1000000;
        1 : SEG = 7'b1111001;
        2 : SEG = 7'b0100100;
        3 : SEG = 7'b0110000;
        4 : SEG = 7'b0011001;
        5 : SEG = 7'b0010010;
        6 : SEG = 7'b0000010;
        7 : SEG = 7'b1111000;
        8 : SEG = 7'b0000000;
        9 : SEG = 7'b0010000;
        default : SEG = 7'b1111111; 
    endcase
end
endmodule

module counter3(
    input clk, rst,
    output reg [3:0] counterout
    );
    
 always @ (posedge(clk), posedge(rst))
 begin
     if (rst) counterout <= 0;
     else if (clk & (counterout <= 8)) counterout <= counterout + 1;
     else counterout <= 0;
end
endmodule

module anode_controlla(
    output [3:0] AN
    );

assign AN[0] = 0;
assign AN[1] = 1;
assign AN[2] = 1;
assign AN[3] = 1;
endmodule
