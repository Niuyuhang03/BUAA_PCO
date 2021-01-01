`timescale 1ns / 1ps

`define op	31:26
`define func	5:0
`define rs	25:21
`define rt	20:16

`define NW	2'b00
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11

`define EtoD_PC	3'd4
`define MtoD_PC	3'd3
`define MtoD_ALU	3'd2
`define WtoD_mux	3'd1
`define DtoD_V	3'd0

`define MtoE_PC	2'd3
`define MtoE_ALU	2'd2
`define WtoE_mux	2'd1
`define EtoE_V	2'd0

`define EtoF_PC	3'd4
`define MtoF_PC	3'd3
`define MtoF_ALU	3'd2
`define WtoF_mux	3'd1
`define FtoF_V	3'd0

`define WtoM_mux 1'b1
`define MtoM_V	1'b0

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

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:18:43 12/11/2017 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
	input [31:0] IR,
	input [1:0] Res_E,
	input [1:0] Res_M,
	input [1:0] Res_W,
	input [4:0] A3_E,
	input [4:0] A3_M,
	input [4:0] A3_W,
	input [4:0] A1_D,
	input [4:0] A2_D,
	input [4:0] A1_E,
	input [4:0] A2_E,
	input [4:0] A2_M,
	input busy,
	input start,
	output stall,
	output [2:0] Fcmp1D,
	output [2:0] Fcmp2D,
	output [1:0] FaluaE,
	output [1:0] FalubE,
	output [2:0] FPCF,
	output FdmdataM
    );
	 /*暂停信号*/
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
	wire addi = (IR[`op] == `addi) ? 1 : 0;
	wire addiu = (IR[`op] == `addiu) ? 1 : 0;
	wire slt = (IR[`op] == 6'b0 && IR[`func] == `slt) ? 1 : 0;
	wire slti= (IR[`op] == `slti) ? 1 : 0;
	wire sltu = (IR[`op] == 6'b0 && IR[`func] == `sltu) ? 1 : 0;
	wire sltiu= (IR[`op] == `sltiu) ? 1 : 0;
	wire bne= (IR[`op] == `bne) ? 1 : 0;
	wire bltz = (IR[`op] == `bltz && IR[`rt] == 5'b00000) ? 1 : 0;
	wire blez = (IR[`op] == `blez) ? 1 : 0;
	wire bgtz= (IR[`op] == `bgtz) ? 1 : 0;
	wire mult = (IR[`op] == 6'b0 && IR[`func] == `mult) ? 1 : 0;
	wire multu = (IR[`op] == 6'b0 && IR[`func] == `multu) ? 1 : 0;
	wire mfhi = (IR[`op] == 6'b0 && IR[`func] == `mfhi) ? 1 : 0;
	wire mflo = (IR[`op] == 6'b0 && IR[`func] == `mflo) ? 1 : 0;
	wire div = (IR[`op] == 6'b0 && IR[`func] == `div) ? 1 : 0;
	wire divu = (IR[`op] == 6'b0 && IR[`func] == `divu) ? 1 : 0;
	wire mthi = (IR[`op] == 6'b0 && IR[`func] == `mthi) ? 1 : 0;
	wire mtlo = (IR[`op] == 6'b0 && IR[`func] == `mtlo) ? 1 : 0;
	wire madd = (IR[`op] ==`madd && IR[`func] == 6'b0) ? 1 : 0;
	wire msub = (IR[`op] ==`madd && IR[`func] == `msub) ? 1 : 0;

	/*Tuse指令进入D级后，其后的某个功能部件再经过多少cycle就必须要使用寄存器值*/
	wire Tuse_RS0 = jr | jalr | beq | bgez | bne | bgtz | blez | bltz;
	wire Tuse_RS1 = addu | subu | add | sub | ori | lw | sw | sb | sh | lb | lbu | lh | lhu | slt | slti | sltiu | sltu | divu | mtlo | msub
						| xori | sllv | srlv | srav | andand | andi | oror | xorxor | nornor | addi | addiu | mult | multu | div | mthi | madd;
	wire Tuse_RT0 = beq | bne;
	wire Tuse_RT1 = addu | subu | add | sub | sll | srl | sra | sllv | srlv | div | divu | madd | msub
						 | srav | andand | oror | xorxor | nornor | slt | sltu | mult | multu;
	wire Tuse_RT2 = sw | sb | sh;
	
	wire stall_RS0_E1 = Tuse_RS0 & (Res_E == `ALU) & (IR[`rs] == A3_E);
	wire stall_RS0_E2 = Tuse_RS0 & (Res_E == `DM) & (IR[`rs] == A3_E);
	wire stall_RS1_E2 = Tuse_RS1 & (Res_E == `DM) & (IR[`rs] == A3_E);
	wire stall_RS0_M1 = Tuse_RS0 & (Res_M == `DM) & (IR[`rs] == A3_M);
	
	wire stall_RT0_E1 = Tuse_RT0 & (Res_E == `ALU) & (IR[`rt] == A3_E);
	wire stall_RT0_E2 = Tuse_RT0 & (Res_E == `DM) & (IR[`rt] == A3_E);
	wire stall_RT1_E2 = Tuse_RT1 & (Res_E == `DM) & (IR[`rt] == A3_E);
	wire stall_RT0_M1 = Tuse_RT0 & (Res_M == `DM) & (IR[`rt] == A3_M);
	
	wire stall_RS = stall_RS0_E1 |  stall_RS0_E2 | stall_RS1_E2 | stall_RS0_M1;
	wire stall_RT = stall_RT0_E1 | stall_RT0_E2 | stall_RT1_E2 | stall_RT0_M1;
	wire stall_busy = (mult | multu | mfhi | mflo | div | divu | mthi | mtlo | madd | msub) & (busy | start);
	
	assign stall = stall_RS | stall_RT | stall_busy;
	/*转发mux选择信号*/
	assign Fcmp1D = ((A1_D == A3_E) && (A3_E != 5'd0) && (Res_E == `PC)) ? `EtoD_PC :
						 ((A1_D == A3_M) && (A3_M != 5'd0) && (Res_M == `PC)) ? `MtoD_PC :
						 ((A1_D == A3_M) && (A3_M != 5'd0) && (Res_M == `ALU)) ? `MtoD_ALU :
						 ((A1_D == A3_W) && (A3_W != 5'd0) && (Res_W != `NW)) ? `WtoD_mux : `DtoD_V;
	assign Fcmp2D = ((A2_D == A3_E) && (A3_E != 5'd0) && (Res_E == `PC)) ? `EtoD_PC :
						 ((A2_D == A3_M) && (A3_M != 5'd0) && (Res_M == `PC)) ? `MtoD_PC :
						 ((A2_D == A3_M) && (A3_M != 5'd0) && (Res_M == `ALU)) ? `MtoD_ALU :
						 ((A2_D == A3_W) && (A3_W != 5'd0) && (Res_W != `NW)) ? `WtoD_mux : `DtoD_V;
	assign FaluaE = ((A1_E == A3_M) && (A3_M != 5'd0) && (Res_M == `PC)) ? `MtoE_PC :
						 ((A1_E == A3_M) && (A3_M != 5'd0) && (Res_M == `ALU)) ? `MtoE_ALU :
						 ((A1_E == A3_W) && (A3_W != 5'd0) && (Res_W != `NW)) ? `WtoE_mux : `EtoE_V;
	assign FalubE = ((A2_E == A3_M) && (A3_M != 5'd0) && (Res_M == `PC)) ? `MtoE_PC :
						 ((A2_E == A3_M) && (A3_M != 5'd0) && (Res_M == `ALU)) ? `MtoE_ALU :
						 ((A2_E == A3_W) && (A3_W != 5'd0) && (Res_W != `NW)) ? `WtoE_mux : `EtoE_V;
	assign FdmdataM = ((A2_M == A3_W) && (A3_W != 5'd0) && (Res_W != `NW)) ? `WtoM_mux : `MtoM_V;
	assign FPCF = ((A1_D == A3_E) && (A3_E != 5'd0) && (Res_E == `PC)) ? `EtoF_PC :
					  ((A1_D == A3_M) && (A3_M != 5'd0) && (Res_M == `PC)) ? `MtoF_PC :
					  ((A1_D == A3_M) && (A3_M != 5'd0) && (Res_M == `ALU)) ? `MtoF_ALU :
					  ((A1_D == A3_W) && (A3_W != 5'd0) && (Res_W != `NW)) ? `WtoF_mux : `FtoF_V;/*FPCF特殊处理，不先存在d级寄存器中了，否则要用A1_F*/

endmodule
