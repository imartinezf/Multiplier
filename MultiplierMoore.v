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
	input Reset,
	input Start,
	input FinishLoad,
	input FinishShift,
	input Finish,
	input Reset_Sync,

	// Output Ports
	output load, //load data into shift registers
	output shift, //shift data in shift registers
	output sync_reset, //reset register
	//output start, //star multiplicacion
	output ready,
	output enable, //enable counter 
	output reset	
);


reg [2:0] state; 

reg load_r;
reg shift_r;
reg sync_reset_r;
reg enable_r;
//reg start_r;
reg ready_r;
reg reset_r;
/****************************************************
**********************************/
always@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
			state <= IDLE;
	else 
	   case(state)
		
			IDLE:
				if(Start == 1'b1)
					state <= LOAD;
				else
					state <= IDLE;					
			LOAD:
				if (FinishLoad == 1'b1)
					state <= SHIFT;
				else 
					state <= LOAD;	
			SHIFT:
				if(FinishShift)
					state <= FINISH;
				else
					state <= SHIFT;
			FINISH:
				if(Finish)
					state <= FINISH;
				else
					state <= IDLE;	
			SYNC_RESET:
				if(Reset_Sync)
					state <= FINISH;
				else
					state <= IDLE;	
						
			default:
					state <= IDLE;

			endcase
end//end always
/*------------------------------------------------------------------------------------------*/

always@(state)begin
	 case(state)
		IDLE: 
			begin
				load_r = 1'b0;
				shift_r = 1'b0;
				sync_reset_r = 1'b1;
				enable_r = 1'b0;
				//start_r = 1'b0;
				ready_r = 1'b0;
				reset_r = 1'b0;
			end
		LOAD: 
			begin
				load_r = 1'b1;
				shift_r = 1'b0;
				sync_reset_r = 1'b1;
				enable_r = 1'b1;
				//start_r = 1'b0;
				ready_r = 1'b0;
				reset_r = 1'b1;
			end
		
		SHIFT: 
			begin
				load_r = 1'b0;
				shift_r = 1'b1;
				sync_reset_r = 1'b1;
				enable_r = 1'b1;
				//start_r = 1'b0;
				ready_r = 1'b0;
				reset_r = 1'b1;
			end
		FINISH:
			begin
				load_r = 1'b0;
				shift_r = 1'b0;
				sync_reset_r = 1'b1;
				enable_r = 1'b1;
				//start_r = 1'b0;
				ready_r = 1'b1;
				reset_r = 1'b1;
			end
		SYNC_RESET:
			begin
				load_r = 1'b0;
				shift_r = 1'b0;
				sync_reset_r = 1'b0;
				enable_r = 1'b1;
				//start_r = 1'b0;
				ready_r = 1'b0;
				reset_r = 1'b0;
			end
	default: 		
			begin
				load_r = 1'b0;
				shift_r = 1'b0;
				sync_reset_r = 1'b1;
				enable_r = 1'b1;
				//start_r = 1'b0;
				ready_r = 1'b0;
				reset_r = 1'b1;
			end

	endcase
end

// Asingnación de salidas

assign load = load_r; 
assign shift = shift_r;
assign sync_reset = sync_reset_r;
//assign start = start_r;
assign ready = ready_r;
assign enable = enable_r;
assign reset = reset_r;

endmodule

