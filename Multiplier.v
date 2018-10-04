/*********************** 
* Name:
*	Multiplier.v
* Description:
* Aqui se integra todo
* 
* Inputs:
*	clk: Input Clock   
*	reset: Señal de reset
*	data_in_a: Dato de Entrada
*	data_in_b: Dato de Entrada
*	Start: Start de la maquina de estados moore
*	Reset_Sync: Reset Sincrono
* Outputs:
*  data_out: Dato de salida de FullAdder 
*	ready: ready de maquina de estados moore
*	cout: carry out de FullAdder
* Version:  
*	1.0
* Author: 
*	Ivan Martinez Flores & Jorge Araiza Martinez 
* Fecha: 
*	2/10/2018
***********************/
module Multiplier
#(
	parameter WORD_LENGTH = 4,
	parameter WORD = WORD_LENGTH*2
)
( 

	input clk,		//For All
	input reset,

	input [WORD_LENGTH-1 : 0] data_in_a,	//For ShiftRegisterRight
	input [WORD_LENGTH-1 : 0] data_in_b,	//For ShiftRegisterLeft
	
	input Start,
	input Reset_Sync,

	
	output [WORD-1 : 0] data_out,		//For ShiftRegisterRight
	output ready,
	output cout

);

wire [WORD-1 : 0] data_out_w;
wire reset_sync_w;
wire reset_w;		//For All
wire enable_w;		//For Counter
wire flag_w;		//From Counter to MultiplierMoore


wire load_w;	//For ShiftRegisterLeft and ShiftRegisterRight Load Data into Register
wire shift_w;	//For ShiftRegisterLeft and ShiftRegisterRight from Register

wire selector; //For MUX
wire [WORD-1 : 0] data_out_SSL_MUX_w;
wire [WORD-1 : 0] data_out_MUX_FA_w;
wire [WORD-1 : 0] data_out_RSReset_FA;

ShiftRegisterRight
#(
	.WORD_LENGTH(WORD_LENGTH)
)
SRRight
(

	.clk(clk),
	.reset(reset_w),
	.serialInput(1'b0),
	.load(load_w),
	.shift(shift_w),
	.parallelInput(data_in_b),
	.serialOutput(selector),
	.parallelOutput()

);

ShiftRegisterLeft
#(
	.WORD_LENGTH(WORD_LENGTH)
)
SRLeft
( 
	.clk(clk),
	.reset(reset_w),
	.serialInput(1'b0),
	.load(load_w),
	.shift(shift_w),
	.parallelInput(data_in_a),
	.serialOutput(),
	.parallelOutput(data_out_SSL_MUX_w)

);

FullAdder
#(
	.WORD_LENGTH(WORD_LENGTH)
)
FA
(
	.clk(clk),
	.reset(reset_w),
	.data_in_a(data_out_MUX_FA_w),
	.data_in_b(data_out),
	.cin(1'b0),
	.data_out(data_out_w),
	.cout(cout)

);

Mux2to1
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Mux
(
	.Data_0(data_out_SSL_MUX_w),
	.Data_1({WORD{1'b0}}),
	.Selector(selector),
	.flag(flag_w),
	.Mux_Output(data_out_MUX_FA_w)

);

Register_Sync_Reset
#(
	.WORD_LENGTH(WORD_LENGTH)
)
RSReset
(
	.clk(clk),
	.reset(reset_w),
	.enable(1'b1), 
	.flag(flag_w),
	.Sync_Reset(reset_sync_w),
	.Data_Input(data_out_w),
	.Data_Output(data_out)

);

MultiplierMoore SMMoore
(
	.clk(clk),
	.reset(reset),
	.Start(Start),
	.Reset_Sync(Reset_Sync),
	.load(load_w), 
	.shift(shift_w), 
	.sync_reset(reset_sync_w), 
	.ready(ready),
	.reset_out(reset_w),
	.flag(flag_w),
	.enable(enable_w) //Enable Counter
	
);

Counter
#(
	.WORD_LENGTH(WORD_LENGTH)
)
CounterFlag
(
	.clk(clk),
	.reset(reset_w),
	.enable(enable_w),
	.flag(flag_w)

);

endmodule 