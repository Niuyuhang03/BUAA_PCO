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
// Create Date:    17:37:56 12/11/2017 
// Design Name: 
// Module Name:    Eregs 
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
module Eregs(
	input clk,
	input reset,
	input [31:0] IR,
	input [31:0] PC8,
	input [31:0] V1,
	input [31:0] V2,
	input [31:0] E32,
	input [4:0] RFA3,
	input stall,
	input Bsel,
	input [2:0] ALUctr,
	input movzres,
	
	output reg [4:0] RFA3E,
	output reg [31:0] IR_E,
	output reg [31:0] PC8_E,
	output reg [31:0] V1_E,
	output reg [31:0] V2_E,
	output reg [31:0] E32_E,
	output reg [1:0] Res_E,
	output reg Bsel_E,
	output reg [2:0] ALUctr_E
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
	wire movz = (IR[`op] == 6'b0 && IR[`func] == `movz && movzres == 0) ? 1 : 0;
	
	initial begin
		IR_E = 0;
		PC8_E = 32'h0000300c;
		V1_E = 0;
		V2_E = 0;
		E32_E = 0;
		Res_E = 0;
		RFA3E = 0;
		Bsel_E = 0;
		ALUctr_E = 0;
	end
	
	always @(posedge clk) begin
		if (reset == 1 || stall == 1) begin
			IR_E = 0;
			PC8_E = 32'h0000300c;
			V1_E = 0;
			V2_E = 0;
			E32_E = 0;
			RFA3E = 0;
			Bsel_E = 0;
			ALUctr_E = 0;
			Res_E = 0;
		end
		else begin
		/*res:该级指令使用哪个功能部件来产生寄存器新值*/
			Res_E = (addu || subu || ori || lui || movz) ? `ALU :
						lw ? `DM :
					  (jalr || jal) ? `PC : `NW;
			if (movzres == 1) begin
				IR_E <= 0;
			end
			else begin
				IR_E <= IR;
			end
			PC8_E <= PC8;
			V1_E <= V1;
			V2_E <= V2;
			E32_E <= E32;
			RFA3E <= RFA3;
			Bsel_E <= Bsel;
			ALUctr_E <= ALUctr;
		end
	end
endmodule
