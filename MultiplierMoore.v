/*********************** 
* Name:
*	MultiplierMoore.v
* Description:
* Moore State Machine
* 
* Inputs:
*	clk: clock de entrada
*	Reset: Reset de entrada 
*	Start,
*	Reset_Sync,
*	flag
* Outputs:
*	load, load data into shift registers
*	shift, shift data in shift registers
*	sync_reset:	reset register
*	ready:	bandera de ready
*	enable: enable para el counter 
*	reset_out
* Version:  
*	1.0
* Author: 
*	Ivan Martinez Flores & Jorge Araiza Martinez 
* Fecha: 
*	2/10/2018
***********************/
module MultiplierMoore
#(
	parameter IDLE = 0,
	parameter LOAD = 1,
	parameter SHIFT = 2,
	parameter FINISH = 3,
	parameter SYNC_RESET = 4

)
(
	// Input Ports
	input clk,
	input reset,
	input Start,
	input Reset_Sync,
	input flag,

	// Output Ports
	output load, //load data into shift registers
	output shift, //shift data in shift registers
	output sync_reset, //reset register
	output ready,
	output enable, //enable counter 
	output reset_out
);


reg [2:0] state; 

reg flag_r;
reg load_r;
reg shift_r;
reg sync_reset_r;
reg enable_r;
//reg start_r;
reg ready_r;
reg reset_out_r;
/****************************************************
**********************************/
always@(posedge clk or negedge reset ) begin

	if(reset == 1'b0)
			state <= IDLE;
	else 
	   case(state)
		
			IDLE:
				if (Start == 1'b1)
					state <= LOAD;
				else
					state <= IDLE;					
			LOAD:
					state <= SHIFT;
					
			SHIFT:
				if(flag == 1'b1)
					state <= FINISH;
				else
					state <= SHIFT;
			FINISH:
				
					state <= SYNC_RESET;
				
			SYNC_RESET:
				if (Reset_Sync == 1'b1)
					state <= IDLE;
				else
					state <= IDLE;//SYNC_RESET;	
						
			default:
					state <= IDLE;

			endcase
end//end always
/*------------------------------------------------------------------------------------------*/

always@(state) begin
	 case(state)
		IDLE: 
			begin
				load_r = 1'b0;
				shift_r = 1'b0;
				sync_reset_r = 1'b0;
				enable_r = 1'b0;
				ready_r = 1'b0;
				reset_out_r = 1'b0;
			end
		LOAD: 
			begin
				load_r = 1'b1;
				shift_r = 1'b0;
				sync_reset_r = 1'b1;
				enable_r = 1'b1;
				ready_r = 1'b0;
				reset_out_r = 1'b1;
			end
		
		SHIFT: 
			begin
				load_r = 1'b0;
				shift_r = 1'b1;
				sync_reset_r = 1'b1;
				enable_r = 1'b0;
				ready_r = 1'b0;
				reset_out_r = 1'b1;
			end
		FINISH:
			begin
				load_r = 1'b0;
				shift_r = 1'b0;
				sync_reset_r = 1'b1;
				enable_r = 1'b0;
				ready_r = 1'b1;
				reset_out_r = 1'b1;
			end
		SYNC_RESET:
			begin
				load_r = 1'b0;
				shift_r = 1'b0;
				sync_reset_r = 1'b0;
				enable_r = 1'b0;
				ready_r = 1'b1;
				reset_out_r = 1'b1;
			end
	default: 		
			begin
				load_r = 1'b0;
				shift_r = 1'b0;
				sync_reset_r = 1'b0;
				enable_r = 1'b0;
				ready_r = 1'b1;
				reset_out_r = 1'b1;
			end

	endcase
end

// Asingnacion de salidas

assign load = load_r; 
assign shift = shift_r;
assign sync_reset = sync_reset_r;
assign ready = ready_r;
assign enable = enable_r;
assign reset_out = reset_out_r;

endmodule

