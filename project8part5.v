`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2022 06:50:14 PM
// Design Name: 
// Module Name: part5
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


module ClkDivider1k (
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

module decoder_7_seg1(
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

module counter4(
    input clk, rst,
    output reg [3:0] counterout,
    output reg clk_div
    );
    
 always @ (posedge(clk), posedge(rst))
 begin
     if (rst) 
     begin
        clk_div <= 0;
        counterout <= 0;
     end
     else if (clk & (counterout <= 8))
     begin 
        clk_div <= 0;
        counterout <= counterout + 1;
     end
     else 
     begin
        clk_div <= 1;
        counterout <= 0;
     end
end
endmodule

module counter5(
    input clk, rst,
    output reg [1:0] counterout
    );
    
 always @ (posedge(clk), posedge(rst))
 begin
     if (rst) counterout <= 0;
     else if (clk) counterout <= counterout + 1;
end
endmodule

module mux414bit(
    input [3:0] count1, count2, count3, count4,
    input [1:0] sel,
    output reg [3:0] an,
    output reg [3:0] outcount
    );
always @(count1, count2, count3, count4, sel)
begin
    case (sel)
        2'b00 : begin
                outcount <= count1;
                an <= 4'b1110;
            end        
        2'b01 : begin
                outcount <= count2;
                an <= 4'b1101;
            end
        2'b10 : begin
                outcount <= count3;
                an <= 4'b1011;
            end
        2'b11 : begin
                outcount <= count4;
                an <= 4'b0111;
            end
        default: an <= 4'b1111;
    endcase
end
endmodule
