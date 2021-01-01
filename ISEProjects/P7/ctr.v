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
`define DR_W	2'b01
`define PC8_W	2'b10
`define cp0out	2'b11

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
`define mult	6'b011000
`define multu	6'b011001
`define mfhi	6'b010000
`define mflo	6'b010010
`define div	6'b011010
`define divu	6'b011011
`define mthi	6'b010001
`define mtlo	6'b010011
`define madd	6'b011100
`define msub	6'b000100
`define mfc0	6'b010000
`define mtc0	6'b010000
`define eret	6'b010000

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
	output bne,
	output bgez,
	output bltz,
	output bgtz,
	output blez,
	output [1:0] PCsel,
	output [15:0] i16,
	output [25:0] i26,
	output [2:0] EXTop,
	output [1:0] WRsel,
	output RI,
	output eret
    );
	wire addu = (instruction[`op] == 6'b0 && instruction[`func] == `addu) ? 1 : 0;
	wire subu = (instruction[`op] == 6'b0 && instruction[`func] == `subu) ? 1 : 0;
	wire add = (instruction[`op] == 6'b0 && instruction[`func] == `add) ? 1 : 0;
	wire sub = (instruction[`op] == 6'b0 && instruction[`func] == `sub) ? 1 : 0;
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
	wire lb = (instruction[`op] == `lb) ? 1 : 0;
	wire lbu = (instruction[`op] == `lbu) ? 1 : 0;
	wire lh = (instruction[`op] == `lh) ? 1 : 0;
	wire lhu = (instruction[`op] == `lhu) ? 1 : 0;
	wire sb = (instruction[`op] == `sb) ? 1 : 0;
	wire sh = (instruction[`op] == `sh) ? 1 : 0;
	wire sll = (instruction[`op] == 6'b0 && instruction[`func] == `sll && instruction != 32'b0) ? 1 : 0;
	wire srl = (instruction[`op] == 6'b0 && instruction[`func] == `srl) ? 1 : 0;
	wire sra = (instruction[`op] == 6'b0 && instruction[`func] == `sra) ? 1 : 0;
	wire sllv = (instruction[`op] == 6'b0 && instruction[`func] == `sllv) ? 1 : 0;
	wire srlv = (instruction[`op] == 6'b0 && instruction[`func] == `srlv) ? 1 : 0;
	wire srav = (instruction[`op] == 6'b0 && instruction[`func] == `srav) ? 1 : 0;
	wire andand = (instruction[`op] == 6'b0 && instruction[`func] == `andand) ? 1 : 0;
	wire andi = (instruction[`op] == `andi) ? 1 : 0;
	wire oror = (instruction[`op] == 6'b0 && instruction[`func] == `oror) ? 1 : 0;
	wire xorxor = (instruction[`op] == 6'b0 && instruction[`func] == `xorxor) ? 1 : 0;
	wire nornor = (instruction[`op] == 6'b0 && instruction[`func] == `nornor) ? 1 : 0;
	wire addi = (instruction[`op] == `addi) ? 1 : 0;
	wire addiu = (instruction[`op] == `addiu) ? 1 : 0;
	wire slt = (instruction[`op] == 6'b0 && instruction[`func] == `slt) ? 1 : 0;
	wire slti= (instruction[`op] == `slti) ? 1 : 0;
	wire sltu = (instruction[`op] == 6'b0 && instruction[`func] == `sltu) ? 1 : 0;
	wire sltiu = (instruction[`op] == `sltiu) ? 1 : 0;
	wire mult = (instruction[`op] == 6'b0 && instruction[`func] == `mult) ? 1 : 0;
	wire multu = (instruction[`op] == 6'b0 && instruction[`func] == `multu) ? 1 : 0;
	wire mfhi = (instruction[`op] == 6'b0 && instruction[`func] == `mfhi) ? 1 : 0;
	wire mflo = (instruction[`op] == 6'b0 && instruction[`func] == `mflo) ? 1 : 0;
	wire div = (instruction[`op] == 6'b0 && instruction[`func] == `div) ? 1 : 0;
	wire divu = (instruction[`op] == 6'b0 && instruction[`func] == `divu) ? 1 : 0;
	wire mthi = (instruction[`op] == 6'b0 && instruction[`func] == `mthi) ? 1 : 0;
	wire mtlo = (instruction[`op] == 6'b0 && instruction[`func] == `mtlo) ? 1 : 0;
	wire madd = (instruction[`op] ==`madd && instruction[`func] == 6'b0) ? 1 : 0;
	wire msub = (instruction[`op] ==`madd && instruction[`func] == `msub) ? 1 : 0;
	wire mfc0 = (instruction[`op] == `mfc0 && instruction[`rs] == 5'b0) ? 1 : 0;
	wire mtc0 = (instruction[`op] == `mtc0 && instruction[`rs] == 5'b00100) ? 1 : 0;
	assign eret = (instruction == 32'h42000018) ? 1 : 0;
	
	assign bgez = (instruction[`op] == `bgez && instruction[`rt] == 5'b00001) ? 1 : 0;
	assign beq = (instruction[`op] == `beq) ? 1 : 0;
	assign bne= (instruction[`op] == `bne) ? 1 : 0;
	assign bltz = (instruction[`op] == `bltz && instruction[`rt] == 5'b00000) ? 1 : 0;
	assign blez = (instruction[`op] == `blez) ? 1 : 0;
	assign bgtz = (instruction[`op] == `bgtz) ? 1 : 0;
	
	
	assign RI = (lb | lbu | lh | lhu | lw | sb | sh | sw | add | addu | sub | subu | mult | multu | div | divu | sll | srl | sra | sllv
					| srlv | srav | andand | oror | xorxor | nornor | addi | addiu | andi | ori | xori | lui | slt | slti | sltiu | sltu | beq 
					| bne | blez | bgtz | bltz | bgez | j | jal | jalr | jr | mfhi | mflo | mthi | mtlo | mfc0 | mtc0 | eret | nop);
	
	assign PCsel = (lw || lb || lbu || lh || lhu || sw || sb || sh || addu || subu || add || sub || oror || xorxor || addi || addiu || sltu
						|| ori || lui || nop || sll || srl || xori || sra || sllv || srlv || srav || andand || msub
						|| sltiu || mult || multu || mthi || madd || mfc0 || mtc0
						|| mfhi || mflo || andi || nornor || slt || slti || div || divu || mtlo) ? `ADD4 :
						(j || jal || beq || bgez || bne || bgtz || blez || bltz) ? `NPC : `RFV1;
	assign i16 = instruction[`i16];
	assign i26 = instruction[`i26];
	/* 000无符号扩展
		001低16位补0
		010有符号扩展
		011有符号扩展后逻辑左移2位*/
	assign EXTop = (addu || subu || add || sub || jalr || jr || xori || j || ori || jal || sll ||sltu
						|| srl || sra || sllv || srlv || srav || andand || andi || oror || xorxor || nornor || slt) ? 0 :
						(lui) ? 1 : 
						(lw || sw || sb || sh || lb || lbu || lh || lhu || addi || addiu || slti || sltiu) ? 2 : 
						(beq || bgez || bne || bgtz || blez || bltz) ? 3 : 3;
	assign WRsel = (lw || lb || lbu || lh || lhu || ori || lui || xori || andi || addi || addiu || slti || sltiu || mfc0) ? `IR_Wrt : 
						(addu || subu || add || sub || jalr || sll || srl || sra || slt || sltu
						|| sllv || srlv || srav || andand || oror || xorxor || nornor || mfhi || mflo) ? `IR_Wrd : `x1f;

endmodule

module Ectr(
	input [31:0] instruction,
	output [1:0] Asel,
	output Bsel,
	output [3:0] ALUctr,
	output [3:0] muldivop
    );
	wire addu = (instruction[`op] == 6'b0 && instruction[`func] == `addu) ? 1 : 0;
	wire subu = (instruction[`op] == 6'b0 && instruction[`func] == `subu) ? 1 : 0;
	wire add = (instruction[`op] == 6'b0 && instruction[`func] == `add) ? 1 : 0;
	wire sub = (instruction[`op] == 6'b0 && instruction[`func] == `sub) ? 1 : 0;
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
	wire lb = (instruction[`op] == `lb) ? 1 : 0;
	wire lbu = (instruction[`op] == `lbu) ? 1 : 0;
	wire lh = (instruction[`op] == `lh) ? 1 : 0;
	wire lhu = (instruction[`op] == `lhu) ? 1 : 0;
	wire sb = (instruction[`op] == `sb) ? 1 : 0;
	wire sh = (instruction[`op] == `sh) ? 1 : 0;
	wire sll = (instruction[`op] == 6'b0 && instruction[`func] == `sll && instruction != 32'b0) ? 1 : 0;
	wire srl = (instruction[`op] == 6'b0 && instruction[`func] == `srl) ? 1 : 0;
	wire sra = (instruction[`op] == 6'b0 && instruction[`func] == `sra) ? 1 : 0;
	wire sllv = (instruction[`op] == 6'b0 && instruction[`func] == `sllv) ? 1 : 0;
	wire srlv = (instruction[`op] == 6'b0 && instruction[`func] == `srlv) ? 1 : 0;
	wire srav = (instruction[`op] == 6'b0 && instruction[`func] == `srav) ? 1 : 0;
	wire andand = (instruction[`op] == 6'b0 && instruction[`func] == `andand) ? 1 : 0;
	wire andi = (instruction[`op] == `andi) ? 1 : 0;
	wire oror = (instruction[`op] == 6'b0 && instruction[`func] == `oror) ? 1 : 0;
	wire xorxor = (instruction[`op] == 6'b0 && instruction[`func] == `xorxor) ? 1 : 0;
	wire nornor = (instruction[`op] == 6'b0 && instruction[`func] == `nornor) ? 1 : 0;
	wire bgez = (instruction[`op] == `bgez && instruction[`rt] == 5'b00001) ? 1 : 0;
	wire addi = (instruction[`op] == `addi) ? 1 : 0;
	wire addiu = (instruction[`op] == `addiu) ? 1 : 0;
	wire slt = (instruction[`op] == 6'b0 && instruction[`func] == `slt) ? 1 : 0;
	wire slti= (instruction[`op] == `slti) ? 1 : 0;
	wire sltu = (instruction[`op] == 6'b0 && instruction[`func] == `sltu) ? 1 : 0;
	wire sltiu= (instruction[`op] == `sltiu) ? 1 : 0;
	wire bne= (instruction[`op] == `bne) ? 1 : 0;
	wire bltz = (instruction[`op] == `bltz && instruction[`rt] == 5'b00000) ? 1 : 0;
	wire blez = (instruction[`op] == `blez) ? 1 : 0;
	wire bgtz= (instruction[`op] == `bgtz) ? 1 : 0;
	wire mult = (instruction[`op] == 6'b0 && instruction[`func] == `mult) ? 1 : 0;
	wire multu = (instruction[`op] == 6'b0 && instruction[`func] == `multu) ? 1 : 0;
	wire mfhi = (instruction[`op] == 6'b0 && instruction[`func] == `mfhi) ? 1 : 0;
	wire mflo = (instruction[`op] == 6'b0 && instruction[`func] == `mflo) ? 1 : 0;
	wire div = (instruction[`op] == 6'b0 && instruction[`func] == `div) ? 1 : 0;
	wire divu = (instruction[`op] == 6'b0 && instruction[`func] == `divu) ? 1 : 0;
	wire mthi = (instruction[`op] == 6'b0 && instruction[`func] == `mthi) ? 1 : 0;
	wire mtlo = (instruction[`op] == 6'b0 && instruction[`func] == `mtlo) ? 1 : 0;
	wire madd = (instruction[`op] ==`madd && instruction[`func] == 6'b0) ? 1 : 0;
	wire msub = (instruction[`op] ==`madd && instruction[`func] == `msub) ? 1 : 0;
	wire mfc0 = (instruction[`op] == `mfc0 && instruction[`rs] == 5'b0) ? 1 : 0;
	wire mtc0 = (instruction[`op] == `mtc0 && instruction[`rs] == 5'b00100) ? 1 : 0;
	wire eret = (instruction[`op] == `eret && instruction[`func] == 6'b010000) ? 1 : 0;

	/* 0000加
		0001减
		0010或
		0011B
		0100异或
		0101逻辑左移
		0110逻辑右移
		0111算数右移
		1000与
		1001或非
		1010有符号小于置1
		1011无符号小于置1*/
	assign ALUctr = (addu || add || addi || addiu|| jalr || jr || beq || bgez || lw || lb || bne || bgtz || blez || bltz
							|| lbu || lh || lhu || jal || sw || sb || sh || j) ? 0 : 
						 (subu || sub) ? 1 : 
						 (ori || oror) ? 2 : 
						  lui ? 3 : 
						 (xori || xorxor) ? 4 : 
						 (sll || sllv) ? 5 : 
						 (srl || srlv) ? 6 :
						 (sra || srav) ? 7 :
						 (andand || andi) ? 8 :
						  nornor ? 9 : 
						 (slt || slti) ? 10 : 
						 (sltu || sltiu) ? 11 : 11;
	assign Asel = (sllv || srlv || srav) ? 2'b10 : (sll || srl || sra) ? 2'b01 : 2'b0;
	assign Bsel = (lw || lb || lbu || lh || lhu || sw || sb || sh || ori || lui || xori || andi || addi || addiu || slti || sltiu) ? `E32_E : `MFalubE;
	assign muldivop = mult ? 3'b001 : 
							multu ? 4'b0010 :
							div ? 4'b0011 :
							divu ? 4'b0100 :
							mthi ? 4'b0101 :
							mtlo ? 4'b0110 : 
							madd ? 4'b0111 : 
							msub ? 4'b1000 : 4'b0000;
							
endmodule

module Mctr(
	input [31:0] instruction,
	output MemWrite,
	output cp0Write
    );
	wire addu = (instruction[`op] == 6'b0 && instruction[`func] == `addu) ? 1 : 0;
	wire subu = (instruction[`op] == 6'b0 && instruction[`func] == `subu) ? 1 : 0;
	wire add = (instruction[`op] == 6'b0 && instruction[`func] == `add) ? 1 : 0;
	wire sub = (instruction[`op] == 6'b0 && instruction[`func] == `sub) ? 1 : 0;
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
	wire lb = (instruction[`op] == `lb) ? 1 : 0;
	wire lbu = (instruction[`op] == `lbu) ? 1 : 0;
	wire lh = (instruction[`op] == `lh) ? 1 : 0;
	wire lhu = (instruction[`op] == `lhu) ? 1 : 0;
	wire sb = (instruction[`op] == `sb) ? 1 : 0;
	wire sh = (instruction[`op] == `sh) ? 1 : 0;
	wire sll = (instruction[`op] == 6'b0 && instruction[`func] == `sll && instruction != 32'b0) ? 1 : 0;
	wire srl = (instruction[`op] == 6'b0 && instruction[`func] == `srl) ? 1 : 0;
	wire sra = (instruction[`op] == 6'b0 && instruction[`func] == `sra) ? 1 : 0;
	wire sllv = (instruction[`op] == 6'b0 && instruction[`func] == `sllv) ? 1 : 0;
	wire srlv = (instruction[`op] == 6'b0 && instruction[`func] == `srlv) ? 1 : 0;
	wire srav = (instruction[`op] == 6'b0 && instruction[`func] == `srav) ? 1 : 0;
	wire andand = (instruction[`op] == 6'b0 && instruction[`func] == `andand) ? 1 : 0;
	wire andi = (instruction[`op] == `andi) ? 1 : 0;
	wire oror = (instruction[`op] == 6'b0 && instruction[`func] == `oror) ? 1 : 0;
	wire xorxor = (instruction[`op] == 6'b0 && instruction[`func] == `xorxor) ? 1 : 0;
	wire nornor = (instruction[`op] == 6'b0 && instruction[`func] == `nornor) ? 1 : 0;
	wire bgez = (instruction[`op] == `bgez && instruction[`rt] == 5'b00001) ? 1 : 0;
	wire addi = (instruction[`op] == `addi) ? 1 : 0;
	wire addiu = (instruction[`op] == `addiu) ? 1 : 0;
	wire slt = (instruction[`op] == 6'b0 && instruction[`func] == `slt) ? 1 : 0;
	wire slti= (instruction[`op] == `slti) ? 1 : 0;
	wire sltu = (instruction[`op] == 6'b0 && instruction[`func] == `sltu) ? 1 : 0;
	wire sltiu= (instruction[`op] == `sltiu) ? 1 : 0;
	wire bne= (instruction[`op] == `bne) ? 1 : 0;
	wire bltz = (instruction[`op] == `bltz && instruction[`rt] == 5'b00000) ? 1 : 0;
	wire blez = (instruction[`op] == `blez) ? 1 : 0;
	wire bgtz= (instruction[`op] == `bgtz) ? 1 : 0;
	wire mult = (instruction[`op] == 6'b0 && instruction[`func] == `mult) ? 1 : 0;
	wire multu = (instruction[`op] == 6'b0 && instruction[`func] == `multu) ? 1 : 0;
	wire mfhi = (instruction[`op] == 6'b0 && instruction[`func] == `mfhi) ? 1 : 0;
	wire mflo = (instruction[`op] == 6'b0 && instruction[`func] == `mflo) ? 1 : 0;
	wire div = (instruction[`op] == 6'b0 && instruction[`func] == `div) ? 1 : 0;
	wire divu = (instruction[`op] == 6'b0 && instruction[`func] == `divu) ? 1 : 0;
	wire mthi = (instruction[`op] == 6'b0 && instruction[`func] == `mthi) ? 1 : 0;
	wire mtlo = (instruction[`op] == 6'b0 && instruction[`func] == `mtlo) ? 1 : 0;
	wire madd = (instruction[`op] ==`madd && instruction[`func] == 6'b0) ? 1 : 0;
	wire msub = (instruction[`op] ==`madd && instruction[`func] == `msub) ? 1 : 0;
	wire mfc0 = (instruction[`op] == `mfc0 && instruction[`rs] == 5'b0) ? 1 : 0;
	wire mtc0 = (instruction[`op] == `mtc0 && instruction[`rs] == 5'b00100) ? 1 : 0;
	wire eret = (instruction[`op] == `eret && instruction[`func] == 6'b010000) ? 1 : 0;

	assign MemWrite = (sw || sb || sh) ? 1 : 0;
	assign cp0Write = mtc0 ? 1 : 0;
	 
endmodule

module Wctr(
	input [31:0] instruction,
	output RegWrite,
	output [1:0] WDsel,
	output [2:0] dmextop,
	output BD
    );
	wire addu = (instruction[`op] == 6'b0 && instruction[`func] == `addu) ? 1 : 0;
	wire subu = (instruction[`op] == 6'b0 && instruction[`func] == `subu) ? 1 : 0;
	wire add = (instruction[`op] == 6'b0 && instruction[`func] == `add) ? 1 : 0;
	wire sub = (instruction[`op] == 6'b0 && instruction[`func] == `sub) ? 1 : 0;
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
	wire lb = (instruction[`op] == `lb) ? 1 : 0;
	wire lbu = (instruction[`op] == `lbu) ? 1 : 0;
	wire lh = (instruction[`op] == `lh) ? 1 : 0;
	wire lhu = (instruction[`op] == `lhu) ? 1 : 0;
	wire sb = (instruction[`op] == `sb) ? 1 : 0;
	wire sh = (instruction[`op] == `sh) ? 1 : 0;
	wire sll = (instruction[`op] == 6'b0 && instruction[`func] == `sll && instruction != 32'b0) ? 1 : 0;
	wire srl = (instruction[`op] == 6'b0 && instruction[`func] == `srl) ? 1 : 0;
	wire sra = (instruction[`op] == 6'b0 && instruction[`func] == `sra) ? 1 : 0;
	wire sllv = (instruction[`op] == 6'b0 && instruction[`func] == `sllv) ? 1 : 0;
	wire srlv = (instruction[`op] == 6'b0 && instruction[`func] == `srlv) ? 1 : 0;
	wire srav = (instruction[`op] == 6'b0 && instruction[`func] == `srav) ? 1 : 0;
	wire andand = (instruction[`op] == 6'b0 && instruction[`func] == `andand) ? 1 : 0;
	wire andi = (instruction[`op] == `andi) ? 1 : 0;
	wire oror = (instruction[`op] == 6'b0 && instruction[`func] == `oror) ? 1 : 0;
	wire xorxor = (instruction[`op] == 6'b0 && instruction[`func] == `xorxor) ? 1 : 0;
	wire nornor = (instruction[`op] == 6'b0 && instruction[`func] == `nornor) ? 1 : 0;
	wire bgez = (instruction[`op] == `bgez && instruction[`rt] == 5'b00001) ? 1 : 0;
	wire addi = (instruction[`op] == `addi) ? 1 : 0;
	wire addiu = (instruction[`op] == `addiu) ? 1 : 0;
	wire slt = (instruction[`op] == 6'b0 && instruction[`func] == `slt) ? 1 : 0;
	wire slti= (instruction[`op] == `slti) ? 1 : 0;
	wire sltu = (instruction[`op] == 6'b0 && instruction[`func] == `sltu) ? 1 : 0;
	wire sltiu= (instruction[`op] == `sltiu) ? 1 : 0;
	wire bne= (instruction[`op] == `bne) ? 1 : 0;
	wire bltz = (instruction[`op] == `bltz && instruction[`rt] == 5'b00000) ? 1 : 0;
	wire blez = (instruction[`op] == `blez) ? 1 : 0;
	wire bgtz= (instruction[`op] == `bgtz) ? 1 : 0;
	wire mult = (instruction[`op] == 6'b0 && instruction[`func] == `mult) ? 1 : 0;
	wire multu = (instruction[`op] == 6'b0 && instruction[`func] == `multu) ? 1 : 0;
	wire mfhi = (instruction[`op] == 6'b0 && instruction[`func] == `mfhi) ? 1 : 0;
	wire mflo = (instruction[`op] == 6'b0 && instruction[`func] == `mflo) ? 1 : 0;
	wire div = (instruction[`op] == 6'b0 && instruction[`func] == `div) ? 1 : 0;
	wire divu = (instruction[`op] == 6'b0 && instruction[`func] == `divu) ? 1 : 0;
	wire mthi = (instruction[`op] == 6'b0 && instruction[`func] == `mthi) ? 1 : 0;
	wire mtlo = (instruction[`op] == 6'b0 && instruction[`func] == `mtlo) ? 1 : 0;
	wire madd = (instruction[`op] ==`madd && instruction[`func] == 6'b0) ? 1 : 0;
	wire msub = (instruction[`op] ==`madd && instruction[`func] == `msub) ? 1 : 0;
	wire mfc0 = (instruction[`op] == `mfc0 && instruction[`rs] == 5'b0) ? 1 : 0;
	wire mtc0 = (instruction[`op] == `mtc0 && instruction[`rs] == 5'b00100) ? 1 : 0;
	wire eret = (instruction[`op] == `eret && instruction[`func] == 6'b010000) ? 1 : 0;
	
	assign RegWrite = (addu || subu || add || sub || jalr || lw || lb || lbu || lh || lhu || lui || ori || nornor || addi || addiu || sltu
							 || jal || xori || sll || srl || sra || sllv || srlv || srav || andand || sltiu || mfhi || mflo
							 || andi || oror || xorxor || slt || slti || mfc0) ? 1 : 0;
	assign WDsel = (lw || lb || lbu || lh || lhu) ? `DR_W :
						(jal || jalr) ? `PC8_W :
						 mfc0 ? `cp0out : ` AO_W;
	assign BD = (j || jal || jr || jalr || beq || bne || bgez || bgtz || blez || bltz) ? 1 : 0;
	/*0不扩展 
	  1无符号字节扩展 
	  2有符号字节扩展 
	  3无符号半字扩展 
	  4有符号半字扩展*/
	assign dmextop = lbu ? 3'b001 :
						  lb ? 3'b010 :
						  lhu ? 3'b011 :
						  lh ? 3'b100 : 3'b000;

endmodule
