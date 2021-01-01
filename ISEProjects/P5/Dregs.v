`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:49 12/11/2017 
// Design Name: 
// Module Name:    Dregs 
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
module Dregs(
	input clk,
	input reset,
	input [31:0] IR,
	input [31:0] PC8,
	input stall,
	input [1:0] PCsel,
	input [15:0] i16,
	input [25:0] i26,
	input beq,
	input [2:0] EXTop,
	input [1:0] WRsel,
	output reg [31:0] IR_D,
	output reg [31:0] PC8_D,
	output reg [1:0] PCsel_D,
	output reg [15:0] i16_D,
	output reg [25:0] i26_D,
	output reg beq_D,
	output reg [2:0] EXTop_D,
	output reg [1:0] WRsel_D
    );
	
	initial begin
		IR_D = 0;
		PC8_D = 32'h00003008;
		PCsel_D = 0;
		i16_D = 0;
		i26_D = 0;
		beq_D = 0;
		EXTop_D = 0;
		WRsel_D = 0;
	end

	always @(posedge clk) begin
		if (reset == 1) begin
			IR_D = 0;
			PC8_D = 32'h00003008;
			PCsel_D = 0;
			i16_D = 0;
			i26_D = 0;
			beq_D = 0;
			EXTop_D = 0;
			WRsel_D = 0;
		end
		else if (stall == 0)begin
			IR_D <= IR;
			PC8_D <= PC8;
			PCsel_D <= PCsel;
			i16_D <= i16;
			i26_D <= i26;
			beq_D <= beq;
			EXTop_D <= EXTop;
			WRsel_D <= WRsel;
		end
	end
endmodule
