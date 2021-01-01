`timescale 1ns / 1ps

`define NW	2'b00
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11

`define op	31:26
`define func	5:0

`define addu	6'b100001
`define subu	6'b100011
`define jr	6'b001000
`define jalr	6'b001001
`define ori	6'b001101
`define lw	6'b100011
`define sw	6'b101011
`define beq	6'b000100
`define lui	6'b001111
`define xori	6'b001110
`define jal	6'b000011
`define j	6'b000010
`define movz	6'b001010
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:44 12/11/2017 
// Design Name: 
// Module Name:    Wregs 
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
module Wregs(
	input clk,
	input reset,
	input [31:0] IR,
	input [31:0] PC8,
	input [31:0] AO,
	input [31:0] DR,
	input [4:0] RFA3,
	input RegWrite,
	input [1:0] WDsel,
	output reg [4:0] RFA3W,
	output reg [31:0] PC8_W,
	output reg [31:0] AO_W,
	output reg [31:0] DR_W,
	output reg [1:0] Res_W,
	output reg RegWrite_W,
	output reg [1:0] WDsel_W
    );
	wire addu = (IR[`op] == 6'b0 && IR[`func] == `addu) ? 1 : 0;
	wire subu = (IR[`op] == 6'b0 && IR[`func] == `subu) ? 1 : 0;
	wire jr = (IR[`op] == 6'b0 && IR[`func] == `jr) ? 1 : 0;
	wire jalr = (IR[`op] == 6'b0 && IR[`func] == `jalr) ? 1 : 0;
	wire ori = (IR[`op] == `ori) ? 1 : 0;
	wire lw = (IR[`op] == `lw) ? 1 : 0;
	wire sw = (IR[`op] == `sw) ? 1 : 0;
	wire beq = (IR[`op] == `beq) ? 1 : 0;
	wire lui = (IR[`op] == `lui) ? 1 : 0;
	wire xori = (IR[`op] == `xori) ? 1 : 0;
	wire jal = (IR[`op] == `jal) ? 1 : 0;
	wire j = (IR[`op] == `j) ? 1 : 0;
	wire movz = (IR[`op] == 6'b0 && IR[`func] == `movz) ? 1 : 0;

	initial begin
		PC8_W = 32'h00003014;
		AO_W = 0;
		DR_W = 0;
		Res_W = 0;
		RFA3W = 0;
		RegWrite_W = 0;
		WDsel_W = 0;
	end
	
	always @(posedge clk) begin
		if (reset == 1) begin
			PC8_W = 32'h00003014;
			AO_W = 0;
			DR_W = 0;
			RFA3W = 0;
			RegWrite_W = 0;
			WDsel_W = 0;
			Res_W = 0;
		end
		else begin
			Res_W <= (addu || subu || ori || lui  || movz) ? `ALU :
						lw ? `DM :
					  (jalr || jal) ? `PC : `NW;
			PC8_W <= PC8;
			AO_W <= AO;
			DR_W <= DR;
			RFA3W <= RFA3;
			RegWrite_W <= RegWrite;
			WDsel_W <= WDsel;
		end
	end

endmodule
