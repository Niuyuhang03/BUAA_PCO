`timescale 1ns / 1ps
`define IDLE	2'b00
`define LOAD	2'b01
`define CNTING	2'b10
`define INT	2'b11

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:41 01/03/2018 
// Design Name: 
// Module Name:    timer 
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
module timer0(
	input clk,
	input RST_I,
	input [1:0] ADD_I,
	input WE_I,
	input [31:0] DAT_I,
	output [31:0] DAT_O,
	output IRQ
    );
	reg state, irqtry;
	reg [31:0] CTRL, PRESET, COUNT;
	
	assign IRQ = irqtry & (CTRL[3] == 1) & (CTRL[2:1] == 2'b0);
	assign DAT_O = (ADD_I == 2'b0) ? {28'b0, CTRL[3:0]} :
						(ADD_I == 2'b01) ? PRESET :
						(ADD_I == 2'b10) ? COUNT : 32'b0;

	initial begin
		state = 0;
		CTRL = 0;
		PRESET = 0;
		COUNT = 0;
		irqtry = 0;
	end
	
	always @(posedge clk) begin
		if (RST_I == 1'b1) begin
			state = 0;
			CTRL = 0;
			PRESET = 0;
			COUNT = 0;
			irqtry = 0;
		end
		else begin
			if (WE_I == 1'b1) begin
				if (ADD_I == 2'b00) begin
					CTRL[3:0] <= DAT_I[3:0];
				end
				else if (ADD_I == 2'b01) begin
					PRESET <= DAT_I;
				end
			end
			
			case(state)
				`IDLE:begin
							if (CTRL[0] == 1'b1) begin
								state <= `LOAD;
								irqtry <= 0;
							end
						end
				`LOAD:begin
							if (CTRL[0] == 1'b1) begin
								COUNT <= PRESET;
								state <= `CNTING;	
							end
						end
				`CNTING:begin
								if (CTRL[0] == 1'b1) begin
									COUNT = COUNT - 32'd1;
									if (COUNT == 32'd1) begin
										state <= `INT;
									end
								end
						  end
				`INT:begin
							if (CTRL[0] == 1'b1) begin
								if (CTRL[2:1] == 2'b0) begin
									COUNT <= 32'b0;
									CTRL[0] <= 0;
									irqtry <= 1;
									state <= `IDLE;
								end
								else if (CTRL[2:1] == 2'b01) begin
									COUNT <= 32'b0;
									irqtry <= 1;
									state <= `IDLE;
								end
							end
					  end
			endcase
		end
	end


endmodule

module timer1(
	input clk,
	input RST_I,
	input [1:0] ADD_I,
	input WE_I,
	input [31:0] DAT_I,
	output [31:0] DAT_O,
	output IRQ
    );
	reg state, irqtry;
	reg [31:0] CTRL, PRESET, COUNT;
	
	assign IRQ = irqtry & (CTRL[3] == 1) & (CTRL[2:1] == 2'b0);
	assign DAT_O = (ADD_I == 2'b0) ? {28'b0, CTRL[3:0]} :
						(ADD_I == 2'b01) ? PRESET :
						(ADD_I == 2'b10) ? COUNT : 32'b0;

	initial begin
		state = 0;
		CTRL = 0;
		PRESET = 0;
		COUNT = 0;
		irqtry = 0;
	end
	
	always @(posedge clk) begin
		if (RST_I == 1'b1) begin
			state = 0;
			CTRL = 0;
			PRESET = 0;
			COUNT = 0;
			irqtry = 0;
		end
		else begin
			if (WE_I == 1'b1) begin
				if (ADD_I == 2'b00) begin
					CTRL[3:0] <= DAT_I[3:0];
				end
				else if (ADD_I == 2'b01) begin
					PRESET <= DAT_I;
				end
			end
			
			case(state)
				`IDLE:begin
							if (CTRL[0] == 1'b1) begin
								state <= `LOAD;
								irqtry <= 0;
							end
						end
				`LOAD:begin
							if (CTRL[0] == 1'b1) begin
								COUNT <= PRESET;
								state <= `CNTING;	
							end
							else if (CTRL[0] == 1'b0) begin
								COUNT <= 32'b0;
								state <= `IDLE;
							end
						end
				`CNTING:begin
								if (CTRL[0] == 1'b1) begin
									COUNT = COUNT - 32'd1;
									if (COUNT == 32'd1) begin
										state <= `INT;
									end
								end
								else if (CTRL[0] == 1'b0) begin
									COUNT <= 32'b0;
									state <= `IDLE;
								end
						  end
				`INT:begin
							if (CTRL[0] == 1'b1) begin
								if (CTRL[2:1] == 2'b0) begin
									COUNT <= 32'b0;
									CTRL[0] <= 0;
									irqtry <= 1;
									state <= `IDLE;
								end
								else if (CTRL[2:1] == 2'b01) begin
									COUNT <= 32'b0;
									irqtry <= 1;
									state <= `IDLE;
								end
							end
							else if (CTRL[0] == 1'b0) begin
								COUNT <= 32'b0;
								state <= `IDLE;
							end
					  end
			endcase
		end
	end


endmodule
