`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:42:08 01/03/2018 
// Design Name: 
// Module Name:    bridge 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bridge(
	input [31:0] PrAddr,
	input [31:0] PrWD,	/*Ð´Êý¾Ý*/
	input [31:0] PrRD0,
	input [31:0] PrRD1,
	input PrWe,
	input [3:0] PrBE,
	output [31:0] PrRD,
	output timer0we,
	output timer1we,
	output [31:0] PrWD_O,
	output [1:0] ADD
    );
	wire timer0 = (PrAddr == 32'h7f00 || PrAddr == 32'h7f04 || PrAddr == 32'h7f08) ? 1 : 0;
	wire timer1 = (PrAddr == 32'h7f10 || PrAddr == 32'h7f14 || PrAddr == 32'h7f18) ? 1 : 0;
	
	assign timer0we = (PrWe && (PrAddr == 32'h7f00 || PrAddr == 32'h7f04)) ? 1 : 0;
	assign timer1we = (PrWe && (PrAddr == 32'h7f10 || PrAddr == 32'h7f14)) ? 1 : 0;
	assign PrRD = (timer0 == 1'b1) ? PrRD0 :
					  (timer1 == 1'b1) ? PrRD1 : 32'b0;
	assign PrWD_O = PrWD;
	assign ADD = (PrAddr[3:0] == 4'h0) ? 2'b0 :
					 (PrAddr[3:0] == 4'h4) ? 2'b01 : ADD;

endmodule
