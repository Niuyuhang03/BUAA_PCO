`timescale 1ns / 1ps

`define NW	2'b00
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11

`define op	31:26
`define func	5:0
`define rs	25:21
`define rt	20:16

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
`define lb	6'b100000
`define lbu	6'b100100
`define lh	6'b100001
`define lhu	6'b100101
`define sb	6'b101000
`define sh	6'b101001
`define add	6'b100000
`define sub	6'b100010
`define sll	6'b000000
`define srl	6'b000010
`define sra	6'b000011
`define sllv	6'b000100
`define srlv	6'b000110
`define srav	6'b000111
`define andand	6'b100100
`define andi	6'b001100
`define oror	6'b100101
`define xorxor	6'b100110
`define nornor	6'b100111
`define bgez	6'b000001
`define bltz	6'b000001
`define blez	6'b000110
`define bgtz	6'b000111
`define addi	6'b001000
`define addiu	6'b001001
`define slt	6'b101010
`define slti	6'b001010
`define sltu	6'b101011
`define sltiu	6'b001011
`define bne	6'b000101
`define mfhi	6'b010000
`define mflo	6'b010010
`define mfc0	6'b010000

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:14 12/11/2017 
// Design Name: 
// Module Name:    Mregs 
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
module Mregs(
	input clk,
	input reset,
	input [31:0] IR,
	input [31:0] PC8,
	input [31:0] AO,
	input [31:0] V2,
	input [4:0] RFA3,
	input MemWrite,
	input [31:0] HI,
	input [31:0] LO,
	input OV,
	input [4:0] ExcCode,
	input cp0Write,
	input [7:2] HWInt,
	input BD,
	input IntReq,
	input eret,
	output reg [4:0] RFA3M,
	output reg [31:0] IR_M,
	output reg [31:0] PC8_M,
	output reg [31:0] AO_M,
	output reg [31:0] V2_M,
	output reg [1:0] Res_M,
	output reg MemWrite_M,
	output reg [4:0] ExcCode_M,
	output reg cp0Write_M,
	output reg [7:2] HWInt_M,
	output reg BD_M,
	output reg eret_M
    );
	wire addu = (IR[`op] == 6'b0 && IR[`func] == `addu) ? 1 : 0;
	wire subu = (IR[`op] == 6'b0 && IR[`func] == `subu) ? 1 : 0;
	wire add = (IR[`op] == 6'b0 && IR[`func] == `add) ? 1 : 0;
	wire sub = (IR[`op] == 6'b0 && IR[`func] == `sub) ? 1 : 0;
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
	wire lb = (IR[`op] == `lb) ? 1 : 0;
	wire lbu = (IR[`op] == `lbu) ? 1 : 0;
	wire lh = (IR[`op] == `lh) ? 1 : 0;
	wire lhu = (IR[`op] == `lhu) ? 1 : 0;
	wire sb = (IR[`op] == `sb) ? 1 : 0;
	wire sh = (IR[`op] == `sh) ? 1 : 0;
	wire sll = (IR[`op] == 6'b0 && IR[`func] == `sll && IR != 32'b0) ? 1 : 0;
	wire srl = (IR[`op] == 6'b0 && IR[`func] == `srl) ? 1 : 0;
	wire sra = (IR[`op] == 6'b0 && IR[`func] == `sra) ? 1 : 0;
	wire sllv = (IR[`op] == 6'b0 && IR[`func] == `sllv) ? 1 : 0;
	wire srlv = (IR[`op] == 6'b0 && IR[`func] == `srlv) ? 1 : 0;
	wire srav = (IR[`op] == 6'b0 && IR[`func] == `srav) ? 1 : 0;
	wire andand = (IR[`op] == 6'b0 && IR[`func] == `andand) ? 1 : 0;
	wire andi = (IR[`op] == `andi) ? 1 : 0;
	wire oror = (IR[`op] == 6'b0 && IR[`func] == `oror) ? 1 : 0;
	wire xorxor = (IR[`op] == 6'b0 && IR[`func] == `xorxor) ? 1 : 0;
	wire nornor = (IR[`op] == 6'b0 && IR[`func] == `nornor) ? 1 : 0;
	wire bgez = (IR[`op] == `bgez && IR[`rt] == 5'b00001) ? 1 : 0;
	wire bltz = (IR[`op] == `bltz && IR[`rt] == 5'b00000) ? 1 : 0;
	wire blez = (IR[`op] == `blez) ? 1 : 0;
	wire bgtz= (IR[`op] == `bgtz) ? 1 : 0;
	wire addi = (IR[`op] == `addi) ? 1 : 0;
	wire addiu = (IR[`op] == `addiu) ? 1 : 0;
	wire slt = (IR[`op] == 6'b0 && IR[`func] == `slt) ? 1 : 0;
	wire slti= (IR[`op] == `slti) ? 1 : 0;
	wire sltu = (IR[`op] == 6'b0 && IR[`func] == `sltu) ? 1 : 0;
	wire sltiu= (IR[`op] == `sltiu) ? 1 : 0;
	wire bne= (IR[`op] == `bne) ? 1 : 0;
	wire mfhi = (IR[`op] == 6'b0 && IR[`func] == `mfhi) ? 1 : 0;
	wire mflo = (IR[`op] == 6'b0 && IR[`func] == `mflo) ? 1 : 0;
	wire mfc0 = (IR[`op] == `mfc0 && IR[`rs] == 5'b0) ? 1 : 0;

	initial begin
		IR_M = 0;
		PC8_M = 32'h00003010;
		AO_M = 0;
		V2_M = 0;
		Res_M = 0;
		RFA3M = 0;
		MemWrite_M = 0;
		ExcCode_M = 0;
		cp0Write_M = 0;
		HWInt_M = 0;
		BD_M = 0;
		eret_M = 0;
	end
	
	always @(posedge clk) begin
		if (reset == 1 || IntReq == 1) begin
			IR_M = 0;
			PC8_M = 32'h00003010;
			AO_M = 0;
			V2_M = 0;
			RFA3M = 0;
			MemWrite_M = 0;
			Res_M = 0;
			ExcCode_M = 0;
			cp0Write_M = 0;
			HWInt_M = 0;
			BD_M = 0;
			eret_M = 0;
		end
		else begin
			Res_M = (addu || subu || add || sub || ori || lui || sll || srl || xori || sra || slt || slti || sltu || sltiu
						|| sllv || srlv || srav || andand || andi || oror || xorxor || nornor || addi || addiu || mfhi || mflo) ? `ALU :
					  (lw || lb || lbu || lh || lhu || mfc0) ? `DM :
					  (jalr || jal) ? `PC : `NW;
			IR_M <= IR;
			PC8_M <= PC8;
			AO_M <= mflo == 1 ? LO : 
					  mfhi == 1 ? HI : AO;
			V2_M <= V2;
			RFA3M <= RFA3;
			MemWrite_M <= MemWrite;
			ExcCode_M <= (ExcCode == 5'b0 && OV == 1) ? 5'd12 : ExcCode;
			cp0Write_M <= cp0Write;
			HWInt_M <= HWInt;
			BD_M <= BD;
			eret_M <= eret;
		end
	end

endmodule
