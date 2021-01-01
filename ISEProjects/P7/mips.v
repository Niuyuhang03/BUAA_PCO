`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:35:52 01/03/2018 
// Design Name: 
// Module Name:    mips 
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
module mips(
	input clk,
	input reset
    );
	wire PrWe, IRQ0, IRQ1, timer0we, timer1we;
	wire [1:0] ADD;
	wire [3:0] PrBE;
	wire [31:0] PrAddr, PrRD, PrWD, DAT0, DAT1, PrWD_O;
	
	cpu CPU(
		.clk(clk),
		.reset(reset),
		.PrRD(PrRD),
		.HWInt({4'b0, IRQ1, IRQ0}),
		
		.PrAddr(PrAddr),
		.PrWD(PrWD),
		.PrWe(PrWe),
		.PrBE(PrBE)
	);
	
	bridge BRIDGE(
		.PrAddr(PrAddr),
		.PrWD(PrWD),
		.PrRD0(DAT0),
		.PrRD1(DAT1),
		.PrWe(PrWe),
		.PrBE(PrBE),
		
		.PrRD(PrRD),
		.timer0we(timer0we),
		.timer1we(timer1we),
		.PrWD_O(PrWD_O),
		.ADD(ADD)
	);
	
	timer0 TIMER0(
		.clk(clk),
		.RST_I(reset),
		.ADD_I(ADD),
		.WE_I(timer0we),
		.DAT_I(PrWD_O),
		
		.DAT_O(DAT0),
		.IRQ(IRQ0)
	);
	
	timer1 TIMER1(
		.clk(clk),
		.RST_I(reset),
		.ADD_I(ADD),
		.WE_I(timer1we),
		.DAT_I(PrWD_O),
		
		.DAT_O(DAT1),
		.IRQ(IRQ1)
	);


endmodule
