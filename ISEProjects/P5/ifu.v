`timescale 1ns / 1ps

`define ADD4	2'b00
`define NPC	2'b01
`define RFV1	2'b10
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:31:55 12/11/2017 
// Design Name: 
// Module Name:    ifu 
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
module ifu(
	input clk,
	input reset,
	input [1:0] PCsel,
	input [15:0] i16,
	input [25:0] i26,
	input [31:0] PCtempD,
	input CO,
	input beq,
	input stall,
	output [31:0] instruction,
	output [31:0] PC8
    );
	reg [31:0] PC;
	reg [31:0] instructions [1023:0];
	assign instruction = instructions[PC[11:2]];
	assign PC8 = PC + 8;
	integer i;
	
	initial begin
		for (i = 0; i < 1024; i = i + 1) begin
			instructions[i] = 0;
		end
		PC = 32'h00003000;
		$readmemh("code.txt", instructions);
	end

	always @(posedge clk) begin
		if (reset == 1) begin
			PC = 32'h00003000;
		end
		else if (stall == 0)begin
			case (PCsel)
				`ADD4: PC <= PC + 4;
				`NPC: begin
							if(beq == 1 && CO == 0) begin
								PC <= PC + 4;
							end
							else if (beq == 1)begin
								PC <= PC + {(i16[15] == 1) ? {14{1'b1}} : 14'b0, i16, 2'b0};
							end
							else begin
								PC <= {PC[31:28], i26, 2'b0};
							end
						end
				`RFV1: PC <= PCtempD;
			endcase
		end
	end
endmodule
