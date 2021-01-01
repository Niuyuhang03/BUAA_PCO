`timescale 1ns / 1ps

`define rs	25:21
`define rt	20:16
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:02 12/11/2017 
// Design Name: 
// Module Name:    mips 
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
module mips(
	input clk,
	input reset
    );
	wire RegWrite, MemWrite, FdmdataM, Bsel, stall, beq, movz;
	wire [1:0] PCsel, WRsel, WDsel, RESE, RESM, RESW, FaluaE, FalubE;
	wire [2:0] EXTop, ALUctr, Fcmp1D, Fcmp2D, FPCF;
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
		.movz(movz)
	);
	
	Ectr ECTR(
		.instruction(IRD),
		
		.Bsel(Bsel),
		.ALUctr(ALUctr)
	);
	
	Mctr MCTR(
		.instruction(IRE),
		
		.MemWrite(MemWrite)
	);
	
	Wctr WCTR(
		.instruction(IRM),
		
		.RegWrite(RegWrite),
		.WDsel(WDsel)
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
		.Bsel(Bsel),
		.stall(stall),
		.beq(beq),
		.movz(movz),
		
		.IRF(IRF),
		.IRD(IRD),
		.IRE(IRE),
		.IRM(IRM),
		.RESE(RESE),
		.RESM(RESM),
		.RESW(RESW),
		.RFA3E(RFA3E),
		.RFA3M(RFA3M),
		.RFA3W(RFA3W)
	);

endmodule