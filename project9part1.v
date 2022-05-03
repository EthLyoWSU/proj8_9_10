`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2022 03:34:05 PM
// Design Name: 
// Module Name: part1
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


module adder(
    input A, B, CIN,
    output sum, P, G
    );
    
assign sum = A ^ B ^ CIN;
assign P = A ^ B;
assign G = A & B;
endmodule

module carrylook4(
    input P0, P1, P2, P3,
    input G0, G1, G2, G3,
    input C0,
    output C1, C2, C3, C4
    );
wire tmp1, tmp2, tmp3, tmp4;

assign tmp1 = C0 & P0 | G0;
assign tmp2 = tmp1 & P1 | G1;
assign tmp3 = tmp2 & P2 | G2;
assign tmp4 = tmp3 & P3 | G3;
assign C1 = tmp1;
assign C2 = tmp2;
assign C3 = tmp3;
assign C4 = tmp4;

endmodule

module globalin(
    output cin
    );
assign cin = 0;
endmodule

module forinputs(
    input [7:0]sw,
    output [3:0] A,
    output [3:0] B
    );
assign A = sw[3:0];
assign B = sw[7:4];
endmodule

module formath(
    input [3:0] X,
    output I0, I1, I2, I3
    );

assign I0 = X[0];
assign I1 = X[1];
assign I2 = X[2];
assign I3 = X[3];
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

module anode_controller(
    input clk,
    output reg [3:0] AN
    );
    
reg tmp = 0;
always @(posedge clk)
begin
    tmp = ~tmp;
    if (tmp == 0)
        AN <= 4'b1101;
    else
        AN <= 4'b1110;
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

module counter5(
    input clk,
    output reg [1:0] counterout
    );
    
 always @ (posedge(clk))
 begin
    if (clk) counterout <= counterout + 1;
end
endmodule

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

module toout(
    input I0, I1, I2, I3, CIN,
    output reg [3:0] W, X, Y, Z
    );
wire [4:0] tmp = {CIN, I3, I2, I1, I0};
always @ (10, I1, I2, I3, CIN)
begin
    W <= tmp % 10;
    X <= (tmp / 10) % 10;
    Y <= ((tmp / 10) / 10) % 10;
    Z <= (((tmp / 10) / 10) / 10) % 10;
end
endmodule

module btntoolfor1(
    input [3:0] btn,
    output btnrst
    );
assign btnrst = btn[0];

endmodule
