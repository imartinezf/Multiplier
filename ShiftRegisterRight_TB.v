`timescale 10 ns / 1 ns

module ShiftRegisterRight_TB;


parameter WORD_LENGTH = 2;
parameter WORD = WORD_LENGTH*2;

reg clk_tb = 0;
reg reset_tb;
reg [WORD_LENGTH-1:0] parallelInput_tb = 0;
reg serialInput_tb;
reg load_tb;
reg shift_tb;

wire serialOutput_tb;
wire [WORD - 1 : 0] parallelOutput_tb;

ShiftRegisterRight
#(
	.WORD_LENGTH(WORD_LENGTH)
)
DUT
(

	.clk(clk_tb),
	.reset(reset_tb),
	.parallelInput(parallelInput_tb),
	.serialInput(serialInput_tb),
	.load(load_tb),
	.shift(shift_tb),
	.serialOutput(serialOutput_tb),
	.parallelOutput(parallelOutput_tb)

);

/*********************************************************/
initial // Clock generator
  begin
    forever #1 clk_tb = !clk_tb;
  end
/*********************************************************/
initial begin // reset generator
   #1 reset_tb = 0;
   #3 reset_tb = 1;
   #16 reset_tb = 0;
   #4 reset_tb = 1;
end
/*********************************************************/
initial begin // load data generator
   #3 load_tb = 0;
   #4 load_tb = 1;
   #5 load_tb = 0;

   #11 load_tb = 1;
   #12 load_tb = 0;
end
/*********************************************************/
initial begin // shift generator
   #0 shift_tb = 0;
   #7 shift_tb = 1;
   #8 shift_tb = 0;

   #10 shift_tb = 1;
   #2 shift_tb = 0;
   #2 shift_tb = 1;
   #2 shift_tb = 0;
end
/*********************************************************/
initial begin // data
   #0 parallelInput_tb = 1;
   #20 parallelInput_tb = 1;
	#0 serialInput_tb = 0;
   
end


endmodule