`timescale 1ns / 1ps

`define rs	25:21
`define rt	20:16
`define rd	15:11
`define i16	15:0
`define i26	25:0
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:10:45 12/11/2017 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
	input clk,
	input reset,
	input [1:0] PCsel,
	input [15:0] i16,
	input [25:0] i26,
	input RegWrite,
	input MemWrite,
	input [2:0] EXTop,
	input [3:0] ALUctr,
	input [1:0] WRsel,
	input [1:0] WDsel,
	input [2:0] Fcmp1D,
	input [2:0] Fcmp2D,
	input FdmdataM,
	input [1:0] FaluaE,
	input [1:0] FalubE,
	input [2:0] FPCF,
	input [1:0] Asel,
	input Bsel,
	input stall,
	input beq,
	input bgez,
	input bne,
	input bgtz,
	input blez,
	input bltz,
	input [2:0] dmextop,
	input [3:0] muldivop,
	input RI,
	input [7:2] HWInt,
	input cp0Write,
	input BD,
	input eret,
	input [31:0] PrRD,
	
	output [31:0] IRF,
	output [31:0] IRD,
	output [31:0] IRE,
	output [31:0] IRM,
	output [1:0] RESE,
	output [1:0] RESM,
	output [1:0] RESW,
	output [4:0] RFA3E,
	output [4:0] RFA3M,
	output [4:0] RFA3W,
	output busy,
	output start,
	output [31:0] AOM,
	output [31:0] din,
	output MemWriteM,
	output [3:0] BE
    );
	wire beqD, bgezD, bneD, bgtzD, blezD, bltzD, BselE, RegWriteW, CO0, CO1, CO2, CO3, CO4, CO5,
		  addE, addiE, subE, OV, AdELM, AdESM, IntReq, cp0WriteM, BDM, eretM, eretD;
	wire [1:0] WRselD, PCselD, dmA, AW, AselE, WDselW;
	wire [2:0] EXTopD, opW;
	wire [3:0] ALUctrE, muldivopE;
	wire [4:0] RFA3D, ExcCodeF, ExcCodeD, ExcCodeE, ExcCodeM;
	wire [7:2] HWIntM;
	wire [15:0] i16D;
	wire [25:0] i26D;
	wire [31:2] EPC;
	wire [31:0] data1, data2, PC8F, PC8D, PC8E, PC8M, PC8W, EO, AO, HI, LO, cp0out, cp0outW, addr_o, addrW;
	wire [31:0] AOW, DO, DRW, V1E, V2E, V2M, RFDATA, D1, D2, alua, aluatemp, alub, alubtemp, E32_E, PCtemp, Doutext;
	 
	ifu IFU(
		.clk(clk),
		.reset(reset),
		.PCsel(PCselD),
		.i16(i16D),
		.i26(i26D),
		.PCtempD(PCtemp),
		.CO0(CO0),
		.CO1(CO1),
		.CO2(CO2),
		.CO3(CO3),
		.CO4(CO4),
		.CO5(CO5),
		.beq(beqD),
		.bgez(bgezD),
		.bne(bneD),
		.bgtz(bgtzD),
		.blez(blezD),
		.bltz(bltzD),
		.stall(stall),
		.IntReq(IntReq),
		.EPC(EPC),
		.eret(eretD),
		
		.instruction(IRF),
		.PC8(PC8F),
		.ExcCode(ExcCodeF)
	);
	
	M32_5_1 FPC(
		.A(data1),
		.B(RFDATA),
		.C(AOM),
		.D(PC8M),
		.E(PC8E),
		.op(FPCF),
		
		.O(PCtemp)
	);
	
	Dregs DREGS(
		.clk(clk),
		.reset(reset),
		.IR(IRF),
		.PC8(PC8F),
		.stall(stall),
		.PCsel(PCsel),
		.i16(i16),
		.i26(i26),
		.beq(beq),
		.bgez(bgez),
		.bne(bne),
		.bgtz(bgtz),
		.blez(blez),
		.bltz(bltz),
		.EXTop(EXTop),
		.WRsel(WRsel),
		.ExcCode(ExcCodeF),
		.RI(RI),
		.eret(eret),
		.IntReq(IntReq),
		.eretD(eretD),
		
		.IR_D(IRD),
		.PC8_D(PC8D),
		.PCsel_D(PCselD),
		.i16_D(i16D),
		.i26_D(i26D),
		.beq_D(beqD),
		.bgez_D(bgezD),
		.bne_D(bneD),
		.bgtz_D(bgtzD),
		.blez_D(blezD),
		.bltz_D(bltzD),
		.EXTop_D(EXTopD),
		.WRsel_D(WRselD),
		.ExcCode_D(ExcCodeD),
		.eret_D(eretD)
	);
	
	M5_3_1 RF_A3(
		.A(IRD[`rt]),
		.B(IRD[`rd]),
		.C(5'd31),
		.op(WRselD),
		
		.O(RFA3D)
	);
	
	M32_4_1 RF_DATA(
		.A(AOW),
		.B(Doutext),
		.C(PC8W),
		.D(cp0outW),
		.op(WDselW),
		
		.O(RFDATA)
	);
	
	rf RF(
		.clk(clk),
		.reset(reset),
		.reg1(IRD[`rs]),
		.reg2(IRD[`rt]),
		.writereg(RFA3W),
		.writedata(RFDATA),
		.RegWrite(RegWriteW),
		.PC8(PC8W),
		
		.data1(data1),
		.data2(data2)
	);
	
	ext EXT(
		.imm16(IRD[`i16]),
		.EXTop(EXTopD),
		
		.EO(EO)
	);
	
	M32_5_1 CMPD1(
		.A(data1),
		.B(RFDATA),
		.C(AOM),
		.D(PC8M),
		.E(PC8E),
		.op(Fcmp1D),
		
		.O(D1)
	);
	
	M32_5_1 CMPD2(
		.A(data2),
		.B(RFDATA),
		.C(AOM),
		.D(PC8M),
		.E(PC8E),
		.op(Fcmp2D),
		
		.O(D2)
	);
	
	cmp CMP(
		.D1(D1),
		.D2(D2),
		
		.CO0(CO0),
		.CO1(CO1),
		.CO2(CO2),
		.CO3(CO3),
		.CO4(CO4),
		.CO5(CO5)
	);
	
	Eregs EREGS(
		.clk(clk),
		.reset(reset),
		.IR(IRD),
		.PC8(PC8D),
		.V1(D1),
		.V2(D2),
		.E32(EO),
		.RFA3(RFA3D),
		.stall(stall),
		.Asel(Asel),
		.Bsel(Bsel),
		.ALUctr(ALUctr),
		.muldivop(muldivop),
		.ExcCode(ExcCodeD),
		.IntReq(IntReq),
		
		.RFA3E(RFA3E),
		.IR_E(IRE),
		.PC8_E(PC8E),
		.V1_E(V1E),
		.V2_E(V2E),
		.E32_E(E32_E),
		.Res_E(RESE),
		.Asel_E(AselE),
		.Bsel_E(BselE),
		.ALUctr_E(ALUctrE),
		.muldivop_E(muldivopE),
		.ExcCode_E(ExcCodeE)
	);
	
	M32_4_1 ALUAtemp(
		.A(V1E),
		.B(RFDATA),
		.C(AOM),
		.D(PC8M),
		.op(FaluaE),
		
		.O(aluatemp)
	);
	
	M32_3_1 ALUA(
		.A(aluatemp),
		.B({27'b0, IRE[10:6]}),
		.C({27'b0, aluatemp[4:0]}),
		.op(AselE),
		
		.O(alua)
	);
	
	M32_4_1 ALUBtemp(
		.A(V2E),
		.B(RFDATA),
		.C(AOM),
		.D(PC8M),
		.op(FalubE),
		
		.O(alubtemp)
	);
	
	M32_2_1 ALUB(
		.A(alubtemp),
		.B(E32_E),
		.op(BselE),
		
		.O(alub)
	);
	
	alu ALU(
		.A(alua),
		.B(alub),
		.ALUctr(ALUctrE),
		.IR(IRE),
		
		.AO(AO),
		.OV(OV)
	);
	
	muldiv MULDIV(
		.clk(clk),
		.reset(reset),
		.A(alua),
		.B(alub),
		.op(muldivopE),
		
		.HI(HI),
		.LO(LO),
		.busy(busy),
		.start(start)
	);
	
	Mregs MREGS(
		.clk(clk),
		.reset(reset),
		.IR(IRE),
		.PC8(PC8E),
		.AO(AO),
		.V2(alubtemp),
		.RFA3(RFA3E),
		.MemWrite(MemWrite),
		.HI(HI),
		.LO(LO),
		.OV(OV),
		.ExcCode(ExcCodeE),
		.cp0Write(cp0Write),
		.HWInt(HWInt),
		.BD(BD),
		.eret(eret),
		.IntReq(IntReq),
		
		.RFA3M(RFA3M),
		.IR_M(IRM),
		.PC8_M(PC8M),
		.AO_M(AOM),
		.V2_M(V2M),
		.Res_M(RESM),
		.MemWrite_M(MemWriteM),
		.ExcCode_M(ExcCodeM),
		.cp0Write_M(cp0WriteM),
		.HWInt_M(HWIntM),
		.BD_M(BDM),
		.eret_M(eretM)
	);
	
	M32_2_1 DIN(
		.A(V2M),
		.B(RFDATA),
		.op(FdmdataM),
		
		.O(din)
	);
	
	dm DM(
		.clk(clk),
		.reset(reset),
		.addr(AOM),
		.din(din),
		.MemWrite(MemWriteM),
		.PC8(PC8M),
		.IR(IRM),
		
		.dout(DO),
		.A(dmA),
		.addr_o(addr_o),
		.AdEL(AdELM),
		.AdES(AdESM),
		.BE(BE)
	);
	
	cp0 CP0(
		.clk(clk),
		.reset(reset),
		.AdEL(AdELM),
		.AdES(AdESM),
		.A1(IRM[`rd]),
		.A2(IRM[`rd]),
		.DIn(din),
		.PC(PC8M - 8),
		.BD(BDM),
		.ExcCode(ExcCodeM),
		.HWInt(HWIntM),
		.We(cp0WriteM),
		.EXLClr(eretM),
		
		.IntReq(IntReq),
		.EPC(EPC),
		.DOut(cp0out)
	);
	
	Wregs WREGS(
		.clk(clk),
		.reset(reset),
		.IR(IRM),
		.PC8(PC8M),
		.AO(AOM),
		.DR(DO),
		.RFA3(RFA3M),
		.RegWrite(RegWrite),
		.WDsel(WDsel),
		.A(dmA),
		.op(dmextop),
		.AdEL(AdELM),
		.addr(addr_o),
		.cp0out(cp0out),
		.IntReq(IntReq),
		
		.RFA3W(RFA3W),
		.PC8_W(PC8W),
		.AO_W(AOW),
		.DR_W(DRW),
		.Res_W(RESW),
		.RegWrite_W(RegWriteW),
		.WDsel_W(WDselW),
		.A_W(AW),
		.op_W(opW),
		.addr_W(addrW),
		.cp0out_W(cp0outW)
	);
	
	dmext DMEXT(
		.A(AW),
		.Dout(DRW),
		.op(opW),
		.PrRD(PrRD),
		.addr(addrW),
		
		.Doutext(Doutext)
	);

endmodule
