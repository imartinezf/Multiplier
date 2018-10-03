/*********************** 
* Name:
*	FullAdder.v
* Description:
* Shift Register entra numero paralelo sale serial
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
module FullAdder
#(
	parameter WORD_LENGTH = 4,
	parameter WORD = WORD_LENGTH*2
)
( 

	input clk,
	input reset,
	input [WORD-1 : 0] data_in_a,
	input [WORD-1 : 0] data_in_b,
	input cin, //Carry In
		
	output [WORD-1 : 0] data_out,
	output cout //Carry Out

);
	//if(reset == 1'b0) begin
//		assign data_in_a <= 0;
//		assign data_in_b <= 0;
//		assign cin <= 0;
//	end
	assign {cout,data_out}=data_in_a+data_in_b+cin;

endmodule 