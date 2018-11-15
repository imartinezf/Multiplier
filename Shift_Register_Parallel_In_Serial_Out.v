 /******************************************************************* 
* Name:
*	Shift_Register_PI_SO.v
* Description:
* 	This circuit reads a number of N bits, and gives the same number 
*  bit by bit at the output every signal clock, starting with the LSB.
*  The circuit is usually called Parallel Input Serial Output Shift Register.
* Inputs:
*  Clk: Clock Signal
*  Reset: Resets the whole block.
*  Enable: Needed to start working.
*  Shift_Load: This input is the control to decide if we load a new word,
*  or shift the current one.
*  Parallel_In: Data.
* Outputs:
*  Serial_Out
* Version:  
*	1.0
* Author: 
*	Jorge Antonio Araiza Martinez
*  Ivan Martinez Flores
* Fecha: 
*	10/10/2018 
*********************************************************************/
module Shift_Register_Parallel_In_Serial_Out
#(
	parameter WORD_LENGTH = 8
)
(
	// Inputs //
	input Clk,
	input Reset,
	input Enable,
	input Shift_Load,
	input [WORD_LENGTH - 1 : 0] Parallel_In,
	//Outputs//
	output Serial_Out
);
reg [WORD_LENGTH - 1 : 0] current_state;

always @(posedge Clk or negedge Reset) 
begin
	if(Reset == 1'b0) 
		   current_state= 0;
			
	else	if (Enable == 1'b1) 
	begin
			if    (Shift_Load == 1'b1) 
				current_state = Parallel_In;
				
			else	if (Shift_Load == 1'b0) 
				current_state = current_state >> 1'b1;
	end
end

assign Serial_Out = current_state[0];

endmodule 