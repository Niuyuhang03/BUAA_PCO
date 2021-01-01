`timescale 1ns / 1ps
`define SR	5'd12
`define CAUSE	5'd13
`define EPC	5'd14
`define PrID	5'd15
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:53 01/01/2018 
// Design Name: 
// Module Name:    cp0 
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
module cp0(
	input clk,
	input reset,
	input [4:0] A1, 		/*读cp0寄存器号*/
	input [4:0] A2, 		/*写cp0寄存器号*/
	input [31:0] DIn,
	input [31:0] PC,		/*中断异常PC*/
	input BD,				/*发生在延迟槽？ 1:是 0:否*/
	input [6:2] ExcCode, /*中断异常类型*/
	input [5:0] HWInt,	/*6个中断设备*/
	input We,
	input EXLClr,
	input AdEL,
	input AdES,
	output IntReq,
	output reg [31:2] EPC,
	output [31:0] DOut
    );
	/*SR [15:10]为6个外部中断使能 [1]为是否进入异常 [0]为全局中断使能*/
	/*CAUSE [15:10]为6个外部中断 [6:2]为异常编码*/
	reg [31:0] SR, CAUSE, PrID;
	wire IntReq1 = SR[0] & (~SR[1]) & ((SR[15] & HWInt[5]) | (SR[14] & HWInt[4]) | (SR[13] & HWInt[3]) 
						| (SR[12] & HWInt[2]) | (SR[11] & HWInt[1]) | (SR[10] & HWInt[0]));/*中断*/
	wire [6:2] exccode = (ExcCode == 5'b0 && AdEL == 1) ? 5'd4 :
						(ExcCode == 5'b0 && AdES == 1) ? 5'd5 : 
						(IntReq1 == 1'b1) ? 5'b0 : ExcCode;
	wire IntReq2 = SR[0] & (~SR[1]) & (exccode != 5'b0); /*异常*/
	assign IntReq = IntReq1 | IntReq2;
	assign DOut = (A1 == 5'd12) ? {16'b0, SR[15:10], 8'b0, SR[1:0]} :
					  (A1 == 5'd13) ? {CAUSE[31], 15'b0, CAUSE[15:10], 3'b0, CAUSE[6:2], 2'b0} :
					  (A1 == 5'd14) ? {EPC[31:2], 2'b0} :
					  (A1 == 5'd15) ? PrID : 32'b0;
	wire [31:0] PCsub4 = PC - 4;
	 
	initial begin
		EPC = 0;
		SR = {16'b0, {6{1'b1}}, 9'b0, 1'b1};
		CAUSE = 0;
		PrID = 0;
	end
	
	always @(posedge clk) begin
		if (reset) begin
			EPC = 0;
			SR = {16'b0, {6{1'b1}}, 9'b0, 1'b1};
			CAUSE = 0;
			PrID = 0;
		end
		else begin
			if (We == 1'b1) begin
				case(A2)
					`SR:begin
							SR[15:10] <= DIn[15:10];
							SR[1:0] <= DIn[1:0];
						 end
					`EPC:begin
								EPC <= DIn[31:2];
						  end
				endcase
			end
			else begin
				CAUSE[31] <= (IntReq == 1) ? BD : CAUSE[31];
				EPC <= (IntReq == 1 && BD == 0) ? PC[31:2] :
						 (IntReq == 1 && BD == 1) ? PCsub4[31:2] : EPC;
				CAUSE[15:10] <= (IntReq == 1) ? HWInt : CAUSE[15:10];
				CAUSE[6:2] <= (IntReq == 1) ? exccode : CAUSE[6:2];
				if (EXLClr == 1'b1) begin
					SR[1] <= 1'b0;
				end
				else begin
					SR[1] <= (IntReq == 1) ? 1 : SR[1];
				end
			end
		end
	end


endmodule
