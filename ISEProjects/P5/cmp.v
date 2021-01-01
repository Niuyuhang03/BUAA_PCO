`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:33 12/11/2017 
// Design Name: 
// Module Name:    cmp 
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
module cmp(
	input [31:0] D1,
	input [31:0] D2,
	input movz,
	output movzres,
	output CO
    );
	assign CO = (D1 == D2) ? 1 : 0;
	/*movzres为1把指令变为nop*/
	assign movzres = (D2 != 0 && movz == 1) ? 1 : 0;

endmodule
