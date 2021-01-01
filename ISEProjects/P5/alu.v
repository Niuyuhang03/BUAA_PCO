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
	input [2:0] ALUctr,
	output reg [31:0] AO
    );
	wire [31:0] AO0 = A + B;
	wire [31:0] AO1 = A - B;
	wire [31:0] AO2 = A | B;
	wire [31:0] AO3 = B;
	wire [31:0] AO4 = A ^ B;
	wire [31:0] AO5 = A;
	
	initial begin
		AO = 0;
	end
	
	always @* begin
		case (ALUctr)
			3'd0:AO <= AO0;
			3'd1:AO <= AO1;
			3'd2:AO <= AO2;
			3'd3:AO <= AO3;
			3'd4:AO <= AO4;
			3'd5:AO <= AO5;
		endcase
	end
endmodule
