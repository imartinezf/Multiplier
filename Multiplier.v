/*********************** 
* Name:
*	Multiplier.v
* Description:
* Aqui se integra todo
* 
* Inputs:
*	clk: Input Clock 50000000  
* Outputs:
*  flag: Clk out with 50% duty cycle
* Version:  
*	1.0
* Author: 
*	Ivan Martinez Flores & Jorge Araiza Martinez 
* Fecha: 
*	2/10/2018
***********************/
module Multiplier
#(
	parameter WORD_LENGTH = 4
)
( 

	input clk,		//For All
	input reset,	//For All
	input [WORD_LENGTH-1 : 0] data_in_a,	//For ShiftRegisterRight
	input [WORD_LENGTH-1 : 0] data_in_b,	//For ShiftRegisterLeft
	input load,		//For ShiftRegisterLeft and ShiftRegisterRight
	input shift,	//For ShiftRegisterLeft and ShiftRegisterRight
	input selector, //For MUX
		
	output [WORD_LENGTH-1 : 0] data_out		//For ShiftRegisterRight

);

ShiftRegisterRight
#(
	.WORD_LENGTH(WORD_LENGTH)
)
SRRight
(
	.clk(clk),
	.reset(reset),
	.data_in(data_in_a),
	.load(load),
	.shift(shift),
	.data_out(selector)

);

ShiftRegisterLeft
#(
	.WORD_LENGTH(WORD_LENGTH)
)
SRLeft
(
	.clk(clk_tb),
	.reset(reset),
	.load(load),
	.shift(shift),
	.parallelInput(data_in_b),
	//.serialOutput(serialOutput_tb),
	.parallelOutput(data_out)

);

FullAdder
#(
	.WORD_LENGTH(WORD_LENGTH)
)
FA
(
	.clk(clk),
	.reset(reset),
	.data_in_a(),
	.data_in_b(),
	.cin(1'b0),
	.data_out(),
	.cout()

);
endmodule 