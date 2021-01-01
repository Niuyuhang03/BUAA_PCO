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
	output reg CO0,
	output reg CO1,
	output reg CO2,
	output reg CO3,
	output reg CO4,
	output reg CO5
    );
	initial begin
		CO0 = 0;
		CO1 = 0;
		CO2 = 0;
		CO3 = 0;
		CO4 = 0;
		CO5 = 0;
	end

	always @* begin
		/*CO0 0不相等 1相等*/
		if (D1 != D2) begin
			CO0 <= 0;
		end
		else begin
			CO0 <= 1;
		end
		/*CO1 0大于 1小等*/
		if ($signed(D1) > $signed(D2)) begin
			CO1 <= 0;
		end
		else begin
			CO1 <= 1;
		end
		/*CO2 0大等 1小于*/
		if ($signed(D1) >= $signed(D2)) begin
			CO2 <= 0;
		end
		else begin
			CO2 <= 1;
		end
		/*CO3 0不等于0 1等于0*/
		if (D1 != 32'b0) begin
			CO3 <= 0;
		end
		else begin
			CO3 <= 1;
		end
		/*CO4 0大于0 1小等0*/
		if (D1[31] == 0 && D1 != 32'b0) begin
			CO4 <= 0;
		end
		else begin
			CO4 <= 1;
		end
		/*CO5 0大等0 1小于0*/
		if (D1[31] == 0 || D1 == 32'b0) begin
			CO5 <= 0;
		end
		else begin
			CO5 <= 1;
		end
	end

endmodule
