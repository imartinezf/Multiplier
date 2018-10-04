/*********************** 
* Name:
*	FullAdder.v
* Description:
* Sumador con Carry de salida
* 
* Inputs:
*	clk: Clock de entrada
*	reset: Reset de entrada
*	data_in_a: Dato de entrada para hacer la sumatoria 
*	data_in_b: Dato de entrada para hacer la sumatoria
*	cin: Carry de entrada, usualmente en cero.
* Outputs:
*  data_out: Dato de salida de la sumatoria
*	cout: Carry de salida de la sumatoria
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
	input cin, //Carry In,
		
	output [WORD-1 : 0] data_out,
	output cout //Carry Out
);


assign {cout,data_out} = data_in_a+data_in_b+cin;
	
	
endmodule