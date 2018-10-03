`timescale 10 ns / 1 ns

module ShiftRegisterRight_TB;


parameter WORD_LENGTH = 2;

reg clk_tb = 0;
reg reset_tb;
reg [WORD_LENGTH-1:0] data_in_tb = 0;
reg load_tb;
reg shift_tb;

wire data_out_tb;

ShiftRegisterRight
#(
	.WORD_LENGTH(WORD_LENGTH)
)
DUT
(
	.clk(clk_tb),
	.reset(reset_tb),
	.data_in(data_in_tb),
	.load(load_tb),
	.shift(shift_tb),
	.data_out(data_out_tb)

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
   #0 data_in_tb = 1;
   #20 data_in_tb = 1;
   
end


endmodule