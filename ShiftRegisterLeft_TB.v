`timescale 10 ns / 1 ns

module ShiftRegisterLeft_TB;


parameter WORD_LENGTH = 8;

reg clk_tb = 0;
reg reset_tb;
reg serialInput_tb = 0;
reg load_tb;
reg shift_tb;
reg [WORD_LENGTH - 1 : 0] parallelInput_tb;

wire serialOutput_tb;
wire [WORD_LENGTH - 1 : 0] parallelOutput;

ShiftRegisterLeft
#(
	.WORD_LENGTH(WORD_LENGTH)
)
DUT
(
	.clk(clk_tb),
	.reset(reset_tb),
	.serialInput(serialInput_tb),
	.load(load_tb),
	.shift(shift_tb),
	.parallelInput(parallelInput_tb),
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
   #2 reset_tb = 1;
end
/*********************************************************/
initial begin // load data generator
   #2 load_tb = 0;
   #2 load_tb = 1;
   #2 load_tb = 0;
end
/*********************************************************/
initial begin // shift generator
   #0 shift_tb = 0;
   #7 shift_tb = 1;
  // #8 shift_tb = 0;

  // #10 shift_tb = 1;
  // #2 shift_tb = 0;
  // #2 shift_tb = 1;
  // #2 shift_tb = 0;
end
/*********************************************************/
initial begin // data
   #0 parallelInput_tb = 170;
   #0 serialInput_tb = 0; //Only a test
   
end


endmodule