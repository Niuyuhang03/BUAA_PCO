`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:21 12/11/2017 
// Design Name: 
// Module Name:    dm 
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
module dm(
	input clk,
	input reset,
	input [31:0] addr,
	input [31:0] din,
	input MemWrite,
	input [31:0] PC8,
	output [31:0] dout
    );
	reg [31:0] memory [1023:0];
	integer i;
	assign dout = memory[addr[11:2]];
	
	initial begin
		for (i = 0; i < 1024; i = i + 1) begin
			memory[i] = 0;
		end
	end
	
	always @(posedge clk) begin
		if (reset == 1) begin
			for (i = 0; i < 1024; i = i + 1) begin
				memory[i] = 0;
			end
		end
		else begin
			if (MemWrite == 1) begin
				$display("%d@%h: *%h <= %h", $time, PC8 - 8, addr, din);
				memory[addr[11:2]] <= din;
			end
		end
	end

endmodule
