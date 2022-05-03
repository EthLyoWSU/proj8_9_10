`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2022 04:04:27 PM
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


module swreg1(
    input [10:0] sw,
    input [1:0] btn,
    input clk,
    output reg [7:0] op1, op2,
    output [2:0] aha
    );
always @ (posedge(clk)) begin
    if (btn[0]) op1 <= sw[7:0];
    if (btn[1]) op2 <= sw[7:0];
    end
assign aha = sw[10:8];
endmodule

module btntool1(
    input [3:0] btn,
    output [1:0] btnreg,
    output btnrst, btnsig
    );
assign btnreg = btn[1:0];
assign btnout = btn[2];
assign btnsig = btn[3];
endmodule

module mux414bit3(
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

module counter53(
    input clk,
    output reg [1:0] counterout
    );
    
 always @ (posedge(clk))
 begin
    if (clk) counterout <= counterout + 1;
end
endmodule

module ClkDivider1k3 (
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

module toout3(
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

module decoder_7_seg3(
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


module inverter(
    input [7:0] inreg,
    input sig,
    output [7:0] outreg
    );

assign outreg = sig? ~inreg : inreg;
endmodule

module xortool(
    input [7:0] op1, op2,
    output [7:0] outres
    );
assign outres = op1 ^ op2;
endmodule

module ortool(
    input [7:0] op1, op2,
    output [7:0] outres
    );
assign outres = op1 | op2;
endmodule

module andtool(
    input [7:0] op1, op2,
    output [7:0] outres
    );
assign outres = op1 & op2;
endmodule

module decodesw(
    input [2:0] sw,
    output reg i0,
    output reg [2:0] i1
    );
always @ (sw)
    begin
    case (sw)
    3'b000 :
        begin
            i0 <= 0;
            i1 <= sw;
        end
    3'b001 :
        begin
            i0 <= 0;
            i1 <= sw;
        end
    3'b010 :
        begin
            i0 <= 1;
            i1 <= sw;
        end                
    3'b011 :
        begin
            i0 <= 0;
            i1 <= sw;
        end
    3'b100 :
        begin
            i0 <= 0;
            i1 <= sw;
        end
    3'b101 :
        begin
            i0 <= 0;
            i1 <= sw;
        end
    default :
        begin
            i0 <= 0;
            i1 <= 3'b000;
        end
    endcase
    end
endmodule

module increment(
    input [7:0] op1,
    output [7:0] opo
    );
assign opo = op1 + 1;
endmodule

module mux(
    input [7:0] a0, a1, a2, a3, a4, a5,
    input [2:0] sel,
    input [1:0] led,
    output reg [7:0] x,
    output reg [1:0] ledo 
    );
always @ (a0, a1, a2, a3, a4, a5, sel, led)
begin
    case (sel)
        3'b000 : 
            begin
                x <= a0;
                ledo <= led;
            end   
        3'b001 : 
            begin
                x <= a1;
                ledo <= 3'b000;
            end  
        3'b010 : 
            begin
                x <= a2;
                ledo <= led;
            end
        3'b011 : 
            begin
                x <= a3;
                ledo <= 3'b000;
            end
        3'b100 : 
            begin
                x <= a4;
                ledo <= 3'b000;
            end
        3'b101 : 
            begin
                x <= a5;
                ledo <= 3'b000;
            end
        default
            begin
                x <= 8'b00000000;
                ledo <= 3'b000;
            end                           
    endcase
end
endmodule
