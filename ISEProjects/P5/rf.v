`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:32 12/11/2017 
// Design Name: 
// Module Name:    rf 
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
module rf(
	input clk,
	input reset,
	input [4:0] reg1,
	input [4:0] reg2,
	input [4:0] writereg,
	input [31:0] writedata,
	input RegWrite,
	input [31:0] PC8,
	output [31:0] data1,
	output [31:0] data2
    );
	reg [31:0] regs [31:0];
	integer i;
	assign data1 = regs[reg1];
	assign data2 = regs[reg2];

	initial begin
		for (i = 0; i < 32; i = i + 1) begin
			regs[i] = 0;
		end
	end

	always @(posedge clk) begin
		if (reset == 1) begin
			for (i = 0; i < 32; i = i + 1) begin
				regs[i] = 0;
			end
		end
		else begin
			if (RegWrite == 1) begin
				if (writereg == 5'd0) begin
					$display("%d@%h: $0 <= 00000000", $time, PC8 - 8);
				end
				else begin
					$display("%d@%h: $%d <= %h", $time, PC8 - 8, writereg, writedata);
					regs[writereg] <= writedata;
				end
			end
		end
		regs[0] = 0;
	end

endmodule
