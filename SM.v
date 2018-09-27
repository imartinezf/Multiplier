/*********************** 
* Name:
*	Decodificador.v
* Description:
* Clock divider circuit
* From 50 MHz to 1 MHz with %50 duty cycle
* Inputs:
*	clk: Input Clock 50000000  
* Outputs:
*  flag: Clk out with 50% duty cycle
* Version:  
*	1.0
* Author: 
*	Ivan Martinez Flores & Jorge Araiza Martinez 
* Fecha: 
*	26/09/2018
***********************/
module SM
#(
	parameter WORD_LENGTH = 8
)
( 

	input clk,
	input reset,
	input [WORD_LENGTH-1 : 0] data_in,
	//input shift,
	input load,
	//input ready,
	//input sync_ready,
	//input flag,
	//input start,
		
	output data_out
	//output enable
);

reg load_r;
reg [WORD_LENGTH-1:0] index_r;
reg [(WORD_LENGTH*2)-1 : 0] data_out_r;

	always@(posedge clk or negedge reset) begin
		if(reset == 1'b0) begin
			//index_r <= 1'b0;
			data_out_r <= 1'b0;
			load_r <= 0;
		end else
			if (load == 1'b1) begin
				data_out_r <= {{WORD_LENGTH{1'b1}},data_in};
				index_r <= 1'b0;
				load_r <= 1'b1;
			end
			if (clk == 1'b1 && load_r == 1'b1)
				index_r <= index_r + 1'b1;
			if (index_r == (WORD_LENGTH*2)-1)
				index_r <= 1'b0;
			 
	
	end
	assign data_out = data_out_r[index_r];
endmodule