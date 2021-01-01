`timescale 1ns / 1ps
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
	output reg [31:0] AO
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
	
	initial begin
		AO = 0;
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
	end
endmodule
