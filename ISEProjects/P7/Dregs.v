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
	input bgez,
	input bne,
	input bgtz,
	input blez,
	input bltz,
	input [2:0] EXTop,
	input [1:0] WRsel,
	input [4:0] ExcCode,
	input RI,
	input IntReq,
	input eret,
	input eretD,
	output reg [31:0] IR_D,
	output reg [31:0] PC8_D,
	output reg [1:0] PCsel_D,
	output reg [15:0] i16_D,
	output reg [25:0] i26_D,
	output reg beq_D,
	output reg bgez_D,
	output reg bne_D,
	output reg bgtz_D,
	output reg bltz_D,
	output reg blez_D,
	output reg [2:0] EXTop_D,
	output reg [1:0] WRsel_D,
	output reg [4:0] ExcCode_D,
	output reg eret_D
    );
	
	initial begin
		IR_D = 0;
		PC8_D = 32'h00003008;
		PCsel_D = 0;
		i16_D = 0;
		i26_D = 0;
		beq_D = 0;
		bgez_D = 0;
		bne_D = 0;
		bgtz_D = 0;
		bltz_D = 0;
		blez_D = 0;
		EXTop_D = 0;
		WRsel_D = 0;
		ExcCode_D = 0;
		eret_D = 0;
	end

	always @(posedge clk) begin
		if (reset == 1 || IntReq == 1 || eretD) begin
			IR_D = 0;
			PC8_D = 32'h00003008;
			PCsel_D = 0;
			i16_D = 0;
			i26_D = 0;
			beq_D = 0;
			bgez_D = 0;
			bne_D = 0;
			bgtz_D = 0;
			bltz_D = 0;
			blez_D = 0;
			EXTop_D = 0;
			WRsel_D = 0;
			ExcCode_D = 0;
			eret_D = 0;
		end
		else if (stall == 0)begin
			if (RI == 1'b0) begin
				IR_D <= 32'b0;
			end
			else begin
				IR_D <= IR;
			end
			PC8_D <= PC8;
			PCsel_D <= PCsel;
			i16_D <= i16;
			i26_D <= i26;
			beq_D <= beq;
			bgez_D <= bgez;
			bne_D <= bne;
			bgtz_D <= bgtz;
			bltz_D <= bltz;
			blez_D <= blez;
			EXTop_D <= EXTop;
			WRsel_D <= WRsel;
			if (ExcCode == 5'b0 && RI == 1'b0) begin
				ExcCode_D <= 5'd10;
			end
			else begin
				ExcCode_D <= ExcCode;
			end
			eret_D <= eret;
		end
	end
endmodule
