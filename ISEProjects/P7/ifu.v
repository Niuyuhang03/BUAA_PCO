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
	input CO0,
	input CO1,
	input CO2,
	input CO3,
	input CO4,
	input CO5,
	input beq,
	input bgez,
	input bne,
	input bgtz,
	input blez,
	input bltz,
	input stall,
	input IntReq,
	input [31:2] EPC,
	input eret,
	output [31:0] instruction,
	output [31:0] PC8,
	output [4:0] ExcCode
    );
	reg [31:0] PC;
	reg [31:0] instructions [4095:0];
	wire [31:0] PCsub = PC - 32'h3000;
	assign ExcCode = (PCsub[31] == 1'b1 || PCsub > 32'h1fff || 
			(PCsub[3:0] != 4'h0 && PCsub[3:0] != 4'h4 && PCsub[3:0] != 4'h8 && PCsub[3:0] != 4'hc)) ? 5'd4 : 5'd0;
	assign instruction = (ExcCode == 5'd0) ? instructions[PCsub[13:2]] : 32'b0;
	assign PC8 = PC + 8;
	integer i;
	
	initial begin
		for (i = 0; i < 4096; i = i + 1) begin
			instructions[i] = 0;
		end
		PC = 32'h00003000;
		$readmemh("code.txt", instructions);
		$readmemh("code_handler.txt", instructions, 1120, 2047);
	end

	always @(posedge clk) begin
		if (reset == 1) begin
			PC = 32'h00003000;
		end
		else if (eret == 1'b1) begin
			PC <= {EPC, 2'b0};
		end
		else if (IntReq == 1'b1) begin
			PC <= 32'h00004180;
		end
		else if (stall == 0)begin
			case (PCsel)
				`ADD4: PC <= PC + 4;
				/*注意不加4，pc已是pc+4*/
				`NPC: begin
							/*CO0 0不相等 1相等*/
							if (beq == 1 && CO0 == 0) begin
								PC <= PC + 4;
							end
							else if (beq == 1 && CO0 == 1)begin
								PC <= PC + {(i16[15] == 1) ? {14{1'b1}} : 14'b0, i16, 2'b0};
							end
							else if (bne == 1 && CO0 == 0) begin
								PC <= PC + {(i16[15] == 1) ? {14{1'b1}} : 14'b0, i16, 2'b0};
							end
							else if (bne == 1 && CO0 == 1) begin
								PC <= PC + 4;
							end
							/*CO4 0大于0 1小等0*/
							else if (bgtz == 1 && CO4 == 0) begin
								PC <= PC + {(i16[15] == 1) ? {14{1'b1}} : 14'b0, i16, 2'b0};
							end
							else if (bgtz == 1 && CO4 == 1) begin
								PC <= PC + 4;
							end
							else if (blez == 1 && CO4 == 0) begin
								PC <= PC + 4;
							end
							else if (blez == 1 && CO4 == 1) begin
								PC <= PC + {(i16[15] == 1) ? {14{1'b1}} : 14'b0, i16, 2'b0};
							end
							/*CO5 0大等0 1小于0*/
							else if (bgez == 1 && CO5 == 0) begin
								PC <= PC + {(i16[15] == 1) ? {14{1'b1}} : 14'b0, i16, 2'b0};
							end
							else if (bgez == 1 && CO5 == 1) begin
								PC <= PC + 4;
							end
							else if (bltz == 1 && CO5 == 0) begin
								PC <= PC + 4;
							end
							else if (bltz == 1 && CO5 == 1) begin
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
