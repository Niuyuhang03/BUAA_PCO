`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:07 12/25/2017 
// Design Name: 
// Module Name:    muldiv 
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
module muldiv(
	input clk, 
	input reset,
	input [31:0] A,
	input [31:0] B,
	input [3:0] op,
	output reg [31:0] HI,
	output reg [31:0] LO,
	output reg busy,
	output start
    );
	assign start = (op == 4'b0001 || op == 4'b0010 || op == 4'b0011 || op == 4'b0100) ? 1 : 0;
	reg [63:0] temp;
	reg [2:0] mulcnt;
	reg [3:0] divcnt;
	/* 000ÎÞ
		001ÓÐ·ûºÅ³Ë
		010ÎÞ·ûºÅ³Ë
		011ÓÐ·ûºÅ³ý
		100ÎÞ·ûºÅ³ý
		101mthi
		110mtlo
	*/
	initial begin
		HI = 0;
		LO = 0;
		busy = 0;
		mulcnt = 0;
		divcnt = 0;
		temp = 0;
	end
	
	always @(posedge clk) begin
		if (reset == 1) begin
			HI = 0;
			LO = 0;
			busy = 0;
			mulcnt = 0;
			divcnt = 0;
			temp = 0;
		end
		else if (start == 1) begin
			busy <= 1;
			if (op == 4'b0001) begin
				temp <= $signed({A[31] == 1'b1 ? {32{1'b1}} : 32'b0, A}) * $signed({B[31] == 1'b1 ? {32{1'b1}} : 32'b0, B});
				mulcnt = 1;
			end
			else if (op == 4'b0010) begin
				temp <= {32'b0, A} * {32'b0, B};
				mulcnt = 1;
			end
			else if (op == 4'b0011) begin
				temp = {$signed(A) % $signed(B), $signed(A) / $signed(B)};
				divcnt = 1;
			end
			else if (op == 4'b0100) begin
				temp <= {A % B, A / B};
				divcnt = 1;
			end
		end
		else begin
			if (op == 4'b0101) begin
				HI <= A;
			end
			else if (op == 4'b0110) begin
				LO <= A;
			end
			else if (op == 4'b0111) begin
				{HI, LO} = {HI, LO} + {32'b0, A} * {32'b0, B};
			end
			else if (op == 4'b1000) begin
				{HI, LO} = {HI, LO} - {32'b0, A} * {32'b0, B};
			end
		end
		
		if (mulcnt != 0) begin
			mulcnt = mulcnt + 1;
			if (mulcnt == 7) begin
				HI <= temp[63:32];
				LO <= temp[31:0];
				mulcnt = 0;
				busy <= 0;
			end
		end
		else if (divcnt != 0) begin
				divcnt = divcnt + 1;
				if (divcnt == 12) begin
					HI <= temp[63:32];
					LO <= temp[31:0];
					divcnt = 0;
					busy <= 0;
				end
		end
	end

endmodule
