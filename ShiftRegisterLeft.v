/*********************** 
* Name:
*	ShiftRegisterLeft.v
* Description:
* Shift Register entra numero paralelo sale serial
* 
* Inputs:
*	clk: Input Clock 
*	reset: Señal de entrada de reset
*	serialInput: Entrada Serial
*	load: Load data
*	shift: Shift data
*	parallelInput: Entrada Paralela
* Outputs:
*	serialOutput: Salida de dato serial
*	parallelOutput: Salida de dato paralelo
* Version:  
*	1.0
* Author: 
*	José Luis Pizano Escalante
* Modificacion:
*	Ivan Martinez Flores & Jorge Araiza Martinez 
* Fecha: 
*	26/09/2018
***********************/

module ShiftRegisterLeft
#(
	parameter WORD_LENGTH = 4,
	parameter WORD = WORD_LENGTH*2
)
(
	input clk,
	input reset,
	input serialInput,
	input load,
	input shift,
	input [WORD_LENGTH - 1 : 0] parallelInput,
	
	output serialOutput,
	output [WORD - 1 : 0] parallelOutput
	

);

reg [WORD - 1 : 0] shiftRegister_logic;


always@(posedge clk, negedge reset) begin
	
	if(reset == 1'b0)
		shiftRegister_logic <= {WORD{1'b0}};
	else
		case ({load, shift})
			2'b01:
				shiftRegister_logic <= {shiftRegister_logic[WORD -2 : 0], serialInput};
			2'b10:
				shiftRegister_logic <= parallelInput;
			default:
				shiftRegister_logic <= shiftRegister_logic;
		endcase
end


assign serialOutput = shiftRegister_logic[WORD - 1]; 
assign parallelOutput = shiftRegister_logic;


endmodule