`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:32:03 12/20/2017 
// Design Name: 
// Module Name:    dmext 
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
module dmext(
	input [1:0] A,
	input [31:0] Dout,
	input [2:0] op,
	output reg [31:0] Doutext
    );
	
	initial begin
		Doutext = 0;
	end
	
	always @* begin
		case (op)
			3'b0: begin
						Doutext <= Dout;
					end
			3'b001:begin
						if (A == 2'b0) begin
							Doutext <= {24'b0, Dout[7:0]};
						end
						else if (A == 2'b01) begin
							Doutext <= {24'b0, Dout[15:8]};
						end
						else if (A == 2'b10) begin
							Doutext <= {24'b0, Dout[23:16]};
						end
						else if (A == 2'b11) begin
							Doutext <= {24'b0, Dout[31:24]};
						end
					 end
			3'b010:begin
						if (A == 2'b0) begin
							Doutext <= {Dout[7] == 1'b1 ? {24{1'b1}} : 24'b0, Dout[7:0]};
						end
						else if (A == 2'b01) begin
							Doutext <= {Dout[15] == 1'b1 ? {24{1'b1}} : 24'b0, Dout[15:8]};
						end
						else if (A == 2'b10) begin
							Doutext <= {Dout[23] == 1'b1 ? {24{1'b1}} : 24'b0, Dout[23:16]};
						end
						else if (A == 2'b11) begin
							Doutext <= {Dout[31] == 1'b1 ? {24{1'b1}} : 24'b0, Dout[31:24]};
						end
					 end
			3'b011:begin
						if (A[1] == 1'b0) begin
							Doutext <= {16'b0, Dout[15:0]};
						end
						else if (A[1] == 1'b1) begin
							Doutext <= {16'b0, Dout[31:16]};
						end
					 end
			3'b100:begin
						if (A[1] == 1'b0) begin
							Doutext <= {Dout[15] == 1'b1 ? {16{1'b1}} : 16'b0, Dout[15:0]};
						end
						else if (A[1] == 1'b1) begin
							Doutext <= {Dout[31] == 1'b1 ? {16{1'b1}} : 16'b0, Dout[31:16]};
						end
					 end
		endcase
	end

endmodule
