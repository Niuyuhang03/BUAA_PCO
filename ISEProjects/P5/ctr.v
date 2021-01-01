`timescale 1ns / 1ps

`define ADD4	2'b00
`define NPC	2'b01
`define RFV1	2'b10

`define MFalubE	1'b0
`define E32_E	1'b1

`define IR_Wrt	2'b00
`define IR_Wrd	2'b01
`define x1f 2'b10

`define AO_W	2'b00
`define DR_W 2'b01
`define PC8_W	2'b10

`define op	31:26
`define rs	25:21
`define rt	20:16
`define rd	15:11
`define func	5:0
`define i16	15:0
`define i26	25:0

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
// Create Date:    19:10:36 12/11/2017 
// Design Name: 
// Module Name:    ctr 
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
module Dctr(
	input [31:0] instruction,
	output beq,
	output movz,
	output [1:0] PCsel,
	output [15:0] i16,
	output [25:0] i26,
	output [2:0] EXTop,
	output [1:0] WRsel
    );
	wire addu = (instruction[`op] == 6'b0 && instruction[`func] == `addu) ? 1 : 0;
	wire subu = (instruction[`op] == 6'b0 && instruction[`func] == `subu) ? 1 : 0;
	wire jr = (instruction[`op] == 6'b0 && instruction[`func] == `jr) ? 1 : 0;
	wire jalr = (instruction[`op] == 6'b0 && instruction[`func] == `jalr) ? 1 : 0;
	wire ori = (instruction[`op] == `ori) ? 1 : 0;
	wire lw = (instruction[`op] == `lw) ? 1 : 0;
	wire sw = (instruction[`op] == `sw) ? 1 : 0;
	wire lui = (instruction[`op] == `lui) ? 1 : 0;
	wire xori = (instruction[`op] == `xori) ? 1 : 0;
	wire jal = (instruction[`op] == `jal) ? 1 : 0;
	wire j = (instruction[`op] == `j) ? 1 : 0;
	wire nop = (instruction == 32'b0) ? 1 : 0;
	
	assign movz = (instruction[`op] == 6'b0 && instruction[`func] == `movz) ? 1 : 0;
	assign beq = (instruction[`op] == `beq) ? 1 : 0;
	assign PCsel = (lw || sw || addu || subu || ori || lui || nop || movz) ? `ADD4 :
						(j || jal || beq) ? `NPC : `RFV1;
	assign i16 = instruction[`i16];
	assign i26 = instruction[`i26];
	/* 000无符号扩展
		001低16位补0
		010有符号扩展
		011有符号扩展后逻辑左移2位
		100低2位拼接0后有符号扩展*/
	assign EXTop = (addu || subu || jalr || jr || xori || j || ori || jal) ? 0 :
						(lui) ? 1 : (lw || sw) ? 2 : 
						(beq) ? 3 : 3;
	assign WRsel = (lw || ori || lui) ? `IR_Wrt : 
						(addu || subu || jalr || movz) ? `IR_Wrd : `x1f;

endmodule

module Ectr(
	input [31:0] instruction,
	output Bsel,
	output [2:0] ALUctr
    );
	wire addu = (instruction[`op] == 6'b0 && instruction[`func] == `addu) ? 1 : 0;
	wire subu = (instruction[`op] == 6'b0 && instruction[`func] == `subu) ? 1 : 0;
	wire jr = (instruction[`op] == 6'b0 && instruction[`func] == `jr) ? 1 : 0;
	wire jalr = (instruction[`op] == 6'b0 && instruction[`func] == `jalr) ? 1 : 0;
	wire ori = (instruction[`op] == `ori) ? 1 : 0;
	wire lw = (instruction[`op] == `lw) ? 1 : 0;
	wire sw = (instruction[`op] == `sw) ? 1 : 0;
	wire beq = (instruction[`op] == `beq) ? 1 : 0;
	wire lui = (instruction[`op] == `lui) ? 1 : 0;
	wire xori = (instruction[`op] == `xori) ? 1 : 0;
	wire jal = (instruction[`op] == `jal) ? 1 : 0;
	wire j = (instruction[`op] == `j) ? 1 : 0;
	wire movz = (instruction[`op] == 6'b0 && instruction[`func] == `movz) ? 1 : 0;

	/* 000加
		001减
		010或
		011B
		100异或
		101A*/
	assign ALUctr = (addu || jalr || jr || beq || lw || jal || sw || j) ? 0 : 
						  subu ? 1 : 
						  ori ? 2 : 
						  lui ? 3 : 
						  movz ? 5 : 4;
	assign Bsel = (lw || sw || ori || lui) ? `E32_E : `MFalubE;
	 
endmodule

module Mctr(
	input [31:0] instruction,
	output MemWrite
    );
	wire addu = (instruction[`op] == 6'b0 && instruction[`func] == `addu) ? 1 : 0;
	wire subu = (instruction[`op] == 6'b0 && instruction[`func] == `subu) ? 1 : 0;
	wire jr = (instruction[`op] == 6'b0 && instruction[`func] == `jr) ? 1 : 0;
	wire jalr = (instruction[`op] == 6'b0 && instruction[`func] == `jalr) ? 1 : 0;
	wire ori = (instruction[`op] == `ori) ? 1 : 0;
	wire lw = (instruction[`op] == `lw) ? 1 : 0;
	wire sw = (instruction[`op] == `sw) ? 1 : 0;
	wire beq = (instruction[`op] == `beq) ? 1 : 0;
	wire lui = (instruction[`op] == `lui) ? 1 : 0;
	wire xori = (instruction[`op] == `xori) ? 1 : 0;
	wire jal = (instruction[`op] == `jal) ? 1 : 0;
	wire j = (instruction[`op] == `j) ? 1 : 0;
	wire movz = (instruction[`op] == 6'b0 && instruction[`func] == `movz) ? 1 : 0;

	assign MemWrite = sw ? 1 : 0;
	 
endmodule

module Wctr(
	input [31:0] instruction,
	output RegWrite,
	output [1:0] WDsel
    );
	wire addu = (instruction[`op] == 6'b0 && instruction[`func] == `addu) ? 1 : 0;
	wire subu = (instruction[`op] == 6'b0 && instruction[`func] == `subu) ? 1 : 0;
	wire jr = (instruction[`op] == 6'b0 && instruction[`func] == `jr) ? 1 : 0;
	wire jalr = (instruction[`op] == 6'b0 && instruction[`func] == `jalr) ? 1 : 0;
	wire ori = (instruction[`op] == `ori) ? 1 : 0;
	wire lw = (instruction[`op] == `lw) ? 1 : 0;
	wire sw = (instruction[`op] == `sw) ? 1 : 0;
	wire beq = (instruction[`op] == `beq) ? 1 : 0;
	wire lui = (instruction[`op] == `lui) ? 1 : 0;
	wire xori = (instruction[`op] == `xori) ? 1 : 0;
	wire jal = (instruction[`op] == `jal) ? 1 : 0;
	wire j = (instruction[`op] == `j) ? 1 : 0;
	wire movz = (instruction[`op] == 6'b0 && instruction[`func] == `movz) ? 1 : 0;
	
	assign RegWrite = (addu || subu || jalr || lw || lui || ori || jal || xori || movz) ? 1 : 0;
	assign WDsel = lw ? `DR_W :
						(jal || jalr) ? `PC8_W : ` AO_W;

endmodule
