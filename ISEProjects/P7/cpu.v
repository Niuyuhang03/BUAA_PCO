`timescale 1ns / 1ps
/*addu, subu, ori, lw, sw, beq, lui, j, jal, jr, jr, nop, lb, lbu, lh, lhu, sb, sh, sub, add, sll, srl, xori, sra, sllv, srlv, srav*/
/*and, andi, or, xor, nor, addi, addiu, slt, slti, sltu, sltiu, bne, bgtz, bgez, bltz, blez*/
`define rs	25:21
`define rt	20:16
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:34:48 01/03/2018 
// Design Name: 
// Module Name:    cpu 
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
module cpu(
	input clk,
	input reset,
	input [31:0] PrRD,
	input [7:2] HWInt,
	output [31:0] PrAddr,
	output [31:0] PrWD,
	output PrWe,
	output [3:0] PrBE
    );
	wire RegWrite, MemWrite, FdmdataM, Bsel, stall, beq, bgez, bne, bgtz, blez, bltz, busy, start, RI, cp0write, BD, eret;
	wire [1:0] PCsel, WRsel, RESE, RESM, RESW, FaluaE, FalubE, Asel, WDsel;
	wire [2:0] EXTop, Fcmp1D, Fcmp2D, FPCF, dmextop;
	wire [3:0] ALUctr, muldivop;
	wire [4:0] RFA3E, RFA3M, RFA3W;
	wire [15:0] i16;
	wire [25:0] i26;
	wire [31:0] IRF, IRD, IRE, IRM;
	
	Dctr DCTR(
		.instruction(IRF),
		
		.i16(i16),
		.i26(i26),
		.WRsel(WRsel),
		.PCsel(PCsel),
		.EXTop(EXTop),
		.beq(beq),
		.bgez(bgez),
		.bne(bne),
		.bgtz(bgtz),
		.blez(blez),
		.bltz(bltz),
		.RI(RI),
		.eret(eret)
	);
	
	Ectr ECTR(
		.instruction(IRD),
		
		.Asel(Asel),
		.Bsel(Bsel),
		.ALUctr(ALUctr),
		.muldivop(muldivop)
	);
	
	Mctr MCTR(
		.instruction(IRE),
		
		.MemWrite(MemWrite),
		.cp0Write(cp0Write)
	);
	
	Wctr WCTR(
		.instruction(IRM),
		
		.RegWrite(RegWrite),
		.WDsel(WDsel),
		.dmextop(dmextop),
		.BD(BD)
	);
	
	hazard HAZARD(
		.IR(IRD),
		.Res_E(RESE),
		.Res_M(RESM),
		.Res_W(RESW),
		.A3_E(RFA3E),
		.A3_M(RFA3M),
		.A3_W(RFA3W),
		.A1_D(IRD[`rs]),
		.A2_D(IRD[`rt]),
		.A1_E(IRE[`rs]),
		.A2_E(IRE[`rt]),
		.A2_M(IRM[`rt]),
		.start(start),
		.busy(busy),
	
		.stall(stall),
		.Fcmp1D(Fcmp1D),
		.Fcmp2D(Fcmp2D),
		.FaluaE(FaluaE),
		.FalubE(FalubE),
		.FdmdataM(FdmdataM),
		.FPCF(FPCF)
	);
	
	datapath DATAPATH(
		.clk(clk),
		.reset(reset),
		.PCsel(PCsel),
		.i16(i16),
		.i26(i26),
		.RegWrite(RegWrite),
		.EXTop(EXTop),
		.ALUctr(ALUctr),
		.MemWrite(MemWrite),
		.WRsel(WRsel),
		.WDsel(WDsel),
		.Fcmp1D(Fcmp1D),
		.Fcmp2D(Fcmp2D),
		.FdmdataM(FdmdataM),
		.FaluaE(FaluaE),
		.FalubE(FalubE),
		.FPCF(FPCF),
		.Asel(Asel),
		.Bsel(Bsel),
		.stall(stall),
		.beq(beq),
		.bgez(bgez),
		.bne(bne),
		.bgtz(bgtz),
		.blez(blez),
		.bltz(bltz),
		.dmextop(dmextop),
		.muldivop(muldivop),
		.RI(RI),
		.HWInt(HWInt),
		.cp0Write(cp0Write),
		.BD(BD),
		.PrRD(PrRD),
		.eret(eret),
		
		.IRF(IRF),
		.IRD(IRD),
		.IRE(IRE),
		.IRM(IRM),
		.RESE(RESE),
		.RESM(RESM),
		.RESW(RESW),
		.RFA3E(RFA3E),
		.RFA3M(RFA3M),
		.RFA3W(RFA3W),
		.busy(busy),
		.start(start),
		.AOM(PrAddr),
		.din(PrWD),
		.MemWriteM(PrWe),
		.BE(PrBE)
	);

endmodule
