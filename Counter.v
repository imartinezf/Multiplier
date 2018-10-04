/*********************** 
* Name:
*	Counter.v
* Description:
* Contador con enable y bandera de salida
* 
* Inputs:
*	clk: Input Clock  
*	reset: reset de entrada el modulo
* 	enable: enable de entrada al modulo
* Outputs:
*  flag: Flag de salida
* Version:  
*	1.0
* Author: 
*	Ivan Martinez Flores & Jorge Araiza Martinez 
* Fecha: 
*	2/10/2018
***********************/
module Counter
#(
	// Parameter Declarations
	parameter WORD_LENGTH = 4,
	parameter WORD = WORD_LENGTH*2
)

(
	// Input Ports
	input clk,
	input reset,
	input enable,
	
	// Output Ports
	output flag
);

reg flag_r;
reg [WORD-1 : 0] counter_r;

	always@(posedge clk or negedge reset) begin
		if (reset == 1'b0) begin
			counter_r <= {WORD{1'b0}};
			//flag_r <= 1'b0;
		end
		else 
			if(enable == 1'b1) begin  
				counter_r <= counter_r + 1'b1;
			if(counter_r == WORD-1)  
				flag_r <= 1'b1;
			end
		end

		
	assign flag = flag_r;
		

endmodule 