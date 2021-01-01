`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:35 12/11/2017 
// Design Name: 
// Module Name:    mux 
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
module M32_5_1(
	input [31:0] A,
	input [31:0] B,
	input [31:0] C,
	input [31:0] D,
	input [31:0] E,
	input [2:0] op,
	output reg [31:0] O
    );
	 
	initial begin
		O = 0;
	end
	
	always @* begin
		case (op)
			3'd0:O <= A;
			3'd1:O <= B;
			3'd2:O <= C;
			3'd3:O <= D;
			3'd4:O <= E;
		endcase
	end

endmodule

module M32_4_1(
	input [31:0] A,
	input [31:0] B,
	input [31:0] C,
	input [31:0] D,
	input [1:0] op,
	output reg [31:0] O
    );
	 
	initial begin
		O = 0;
	end
	
	always @* begin
		case (op)
			2'd0:O <= A;
			2'd1:O <= B;
			2'd2:O <= C;
			2'd3:O <= D;
		endcase
	end

endmodule

module M32_3_1(
	input [31:0] A,
	input [31:0] B,
	input [31:0] C,
	input [1:0] op,
	output reg [31:0] O
    );
	 
	initial begin
		O = 0;
	end
	
	always @* begin
		case (op)
			2'd0:O <= A;
			2'd1:O <= B;
			2'd2:O <= C;
		endcase
	end

endmodule

module M32_2_1(
	input [31:0] A,
	input [31:0] B,
	input op,
	output reg [31:0] O
	 );
	 
	initial begin
		O = 0;
	end
	
	always @* begin
		case (op)
			1'b0:O <= A;
			1'b1:O <= B;
		endcase
	end
	
endmodule

module M5_3_1(
	input [4:0] A,
	input [4:0] B,
	input [4:0] C,
	input [1:0] op,
	output reg [4:0] O
    );
	 
	initial begin
		O = 0;
	end
	
	always @* begin
		case (op)
			2'd0:O <= A;
			2'd1:O <= B;
			2'd2:O <= C;
		endcase
	end

endmodule