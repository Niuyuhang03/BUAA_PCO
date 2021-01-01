`timescale 1ns / 1ps

`define op	31:26
`define rs	25:21
`define rt	20:16
`define rd	15:11
`define func	5:0

`define sw	6'b101011
`define sb	6'b101000
`define sh	6'b101001

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
	input [31:0] IR,
	input [31:0] addr,
	input [31:0] din,
	input MemWrite,
	input [31:0] PC8,
	output [31:0] dout,
	output [1:0] A
    );
	reg [31:0] memory [4095:0];
	integer i;
	
	assign dout = memory[addr[13:2]];
	assign A = addr[1:0];
	wire sw = (IR[`op] == `sw) ? 1 : 0;
	wire sb = (IR[`op] == `sb) ? 1 : 0;
	wire sh = (IR[`op] == `sh) ? 1 : 0;
	wire [3:0] BE = sw ? 4'b1111:
						 sh ? (A[1] == 1'b1 ? 4'b1100 : 4'b0011) :
						 sb ? ((A == 2'b00) ? 4'b0001 :
								 (A == 2'b01) ? 4'b0010 :
								 (A == 2'b10) ? 4'b0100 :
								 (A == 2'b11) ? 4'b1000 : 4'b0) : 4'b0;
	
	initial begin
		for (i = 0; i < 4096; i = i + 1) begin
			memory[i] = 0;
		end
	end
	
	always @(posedge clk) begin
		if (reset == 1) begin
			for (i = 0; i < 4096; i = i + 1) begin
				memory[i] = 0;
			end
		end
		else begin
			if (MemWrite == 1) begin
				memory[addr[13:2]][7:0] = (BE[0] == 1'b1 ?  din[7:0] : memory[addr[13:2]][7:0]);
				memory[addr[13:2]][15:8] = (BE[1] == 1'b1 ?  (sb ? din[7:0] : sh ? din[15:8] : din[15:8]) : memory[addr[13:2]][15:8]);
				memory[addr[13:2]][23:16] = (BE[2] == 1'b1 ?  (sb ? din[7:0] : sh ? din[7:0] : din[23:16]) : memory[addr[13:2]][23:16]);
				memory[addr[13:2]][31:24] = (BE[3] == 1'b1 ?  (sb ? din[7:0] : sh ? din[15:8] : din[31:24]) : memory[addr[13:2]][31:24]);
				$display("%d@%h: *%h <= %h", $time, PC8 - 8, {addr[31:2], 2'b0}, memory[addr[13:2]]);
			end
		end
	end

endmodule
