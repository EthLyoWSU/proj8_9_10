`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2022 10:17:41 PM
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


module swreg(
    input [7:0] sw,
    input [1:0] btn,
    input clk,
    output reg [7:0] op1, op2
    );
always @ (posedge(clk)) begin
    if (btn[0]) op1 <= sw;
    if (btn[1]) op2 <= sw;
    end
endmodule

module btntool(
    input [3:0] btn,
    output [1:0] btnreg,
    output btnrst, btnsig
    );
assign btnreg = btn[1:0];
assign btnout = btn[2];
assign btnsig = btn[3];
endmodule

module inverter(
    input [7:0] inreg,
    input sig,
    output [7:0] outreg
    );

assign outreg = sig? ~inreg : inreg;
endmodule

module adder2(
    input [7:0] op1, op2,
    input sig,
    output reg [7:0] result,
    output reg [1:0] led
    );
wire [7:0] tmp = (sig)? op1 + op2 + 1: op1 + op2;
always @ (op1, op2, sig)
begin //look into how to manage 2's compliment values, convert to positive value and light the negative number light correctly. Also check for bs overflow underflow
    if ((tmp[7] == 1)) led[0] = 1;
    else led[0] = 0;
    
    
if ((op1[7] == op2[7]) &  (tmp[7] == ~op1[7] )) led[1] = 1;
    else led[1] = 0;
    
    result = tmp;
end
endmodule

module mux414bit2(
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

module counter52(
    input clk,
    output reg [1:0] counterout
    );
    
 always @ (posedge(clk))
 begin
    if (clk) counterout <= counterout + 1;
end
endmodule

module ClkDivider1k2 (
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

module toout2(
    input [7:0] result,
    output reg [3:0] W, X, Y, Z
    );
wire [7:0] tmp = result;
always @ (result)
begin
    W <= tmp % 10;
    X <= (tmp / 10) % 10;
    Y <= ((tmp / 10) / 10) % 10;
    Z <= (((tmp / 10) / 10) / 10) % 10;
end
endmodule

module decoder_7_seg2(
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
