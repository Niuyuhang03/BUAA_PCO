`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:41 12/11/2017 
// Design Name: 
// Module Name:    ext 
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
module ext(
	input [15:0]imm16,
	input [2:0] EXTop,
	output reg [31:0] EO
    );
	wire [31:0] EO0 = {{16'b0}, imm16};
	wire [31:0] EO1 = {imm16, {16'b0}};
	wire [31:0] EO2 = (imm16[15] == 1) ? {{{16{1'b1}}, imm16}} : {{16'b0}, imm16};
	wire [31:0] EO3 = (imm16[15] == 1) ? {{{14{1'b1}}, imm16, 2'b0}} : {{14'b0}, imm16, 2'b0};
	
	initial begin
		EO = 0;
	end
	
	always @* begin
		case (EXTop)
			0:EO <= EO0;
			1:EO <= EO1;
			2:EO <= EO2;
			3:EO <= EO3;
		endcase
	end

endmodule
