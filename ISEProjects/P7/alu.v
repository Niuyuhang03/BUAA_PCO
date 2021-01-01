`timescale 1ns / 1ps
`define add	6'b100000
`define sub	6'b100010
`define addi	6'b001000

`define op	31:26
`define func	5:0

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:04 12/11/2017 
// Design Name: 
// Module Name:    alu 
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
module alu(
	input [31:0] A,
	input [31:0] B,
	input [3:0] ALUctr,
	input [31:0] IR,
	output reg [31:0] AO,
	output reg OV
    );
	wire [31:0] AO0 = A + B;
	wire [31:0] AO1 = A - B;
	wire [31:0] AO2 = A | B;
	wire [31:0] AO3 = B;
	wire [31:0] AO4 = A ^ B;
	wire [31:0] AO5 = B << A;
	wire [31:0] AO6 = B >> A;
	wire [31:0] AO7 = $signed(B) >>> A;
	wire [31:0] AO8 = A & B;
	wire [31:0] AO9 = ~(A | B);
	wire [31:0] AO10 = ($signed(A) < $signed(B)) ? 1 : 0;
	wire [31:0] AO11 = (A < B) ? 1 : 0;
	wire [32:0] temp1 = {A[31], A} + {B[31], B};
	wire [32:0] temp2 = {A[31], A} + {B[31], B};
	wire [32:0] temp3 = {A[31], A} - {B[31], B};
	wire add = (IR[`op] == 6'b0 && IR[`func] == `add) ? 1 : 0;
	wire sub = (IR[`op] == 6'b0 && IR[`func] == `sub) ? 1 : 0;
	wire addi = (IR[`op] == `addi) ? 1 : 0;
	
	initial begin
		AO = 0;
		OV = 0;
	end
	
	always @* begin
		case (ALUctr)
			4'd0:AO <= AO0;
			4'd1:AO <= AO1;
			4'd2:AO <= AO2;
			4'd3:AO <= AO3;
			4'd4:AO <= AO4;
			4'd5:AO <= AO5;
			4'd6:AO <= AO6;
			4'd7:AO <= AO7;
			4'd8:AO <= AO8;
			4'd9:AO <= AO9;
			4'd10:AO <= AO10;
			4'd11:AO <= AO11;
		endcase
		if ((add == 1 && (temp1[32] != temp1[31])) || (addi == 1 && (temp2[32] != temp2[31])) || (sub == 1 && (temp3[32] != temp3[31]))) begin
			OV <= 1;
		end
		else begin
			OV <= 0;
		end
	end
endmodule
