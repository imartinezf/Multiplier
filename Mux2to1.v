	/*********************** 
* Name:
*	Mux2to1.v
* Description:
* Multiplexor de dos entradas a una salida
* 
* Inputs:
*	Selector: Selector Inpput
*	Data_0: Data 0 input to be selected
*	Data_1: Data 1 input to be selected
*  
* Outputs:
*  Mux_Output: Single Output from MUX
* Version:  
*	1.0
* Author: 
*	Ivan Martinez Flores & Jorge Araiza Martinez 
* Fecha: 
*	2/10/2018
***********************/
module Mux2to1
#(
	parameter WORD_LENGTH = 4,
	parameter WORD = WORD_LENGTH*2 
)
(
	// Input Ports
	input Selector,
	input [WORD-1 : 0] Data_0,
	input [WORD-1 : 0] Data_1,
	input flag,
	
	// Output Ports
	output [WORD-1 : 0] Mux_Output

);

reg [WORD-1 : 0] Mux_logic;

always@(Selector,Data_0 or Data_1) begin
	
	if(Selector == 1'b1)
		Mux_logic = Data_0;
	else
		Mux_logic = Data_1; 
end

assign Mux_Output = Mux_logic;

endmodule