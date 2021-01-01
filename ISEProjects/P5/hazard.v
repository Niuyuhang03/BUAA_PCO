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
`define movz	6'b001010

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
	/*Tuse指令进入D级后，其后的某个功能部件再经过多少cycle就必须要使用寄存器值*/
	wire Tuse_RS0 = jr | jalr | beq | movz;
	wire Tuse_RS1 = addu | subu | ori | lw | sw;
	wire Tuse_RT0 = beq | movz;
	wire Tuse_RT1 = addu | subu;
	wire Tuse_RT2 = sw;
	
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
	
	assign stall = stall_RS | stall_RT;
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
