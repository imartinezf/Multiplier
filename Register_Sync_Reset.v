 /******************************************************************* 
* Name:
*	Register_Sync_Reset.v
* Description:
* 	This module is a register with eanble.
* Inputs:
*	clk: Clock signal 
*  reset: reset signal 
	sync_reset: When 1 the register value is clear, but only if the register is enable and there a clock edge
*  enable: when 1 the signal on Data_Input is latched, when 0 the previous value is maintained
*	Data_Input: Data to lache data 
* Outputs:
* 	Mux_Output: Data to provide lached data
* Versión:  
*	1.0
* Author: 
*	José Luis Pizano Escalante
* Fecha: 
*	07/02/2013 
*********************************************************************/

 module Register_Sync_Reset
#(
	parameter WORD_LENGTH = 4,
	parameter WORD = WORD_LENGTH*2
)

(
	// Input Ports
	input clk,
	input reset,
	input enable,
	input Sync_Reset,
	input [WORD-1 : 0] Data_Input,
	input flag,

	// Output Ports
	output [WORD-1 : 0] Data_Output
);

reg  [WORD-1 : 0] data_r;

always@(posedge clk or negedge reset) begin
	if(reset == 1'b0) 
		data_r <= 0;
	else 
		if(enable == 1'b1) begin
			data_r <= data_r;
			if(Sync_Reset == 1'b0)
				data_r <= {WORD_LENGTH{1'b0}};
			else
				data_r <= Data_Input;
		end
end

assign Data_Output = data_r;

endmodule