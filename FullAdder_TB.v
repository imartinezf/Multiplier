`timescale 10 ns / 1 ns

module FullAdder_TB;


parameter WORD_LENGTH = 4;
parameter WORD = WORD_LENGTH*2;

reg clk_tb = 0;
reg reset_tb;
reg [WORD-1 : 0] data_in_a_tb;
reg [WORD-1 : 0] data_in_b_tb;
reg cin_tb;

wire [WORD-1 : 0] data_out_tb;
wire cout_tb;

FullAdder
#(
	.WORD_LENGTH(WORD_LENGTH)
)
DUT
(
	.clk(clk_tb),
	.reset(reset_tb),
	.data_in_a(data_in_a_tb),
	.data_in_b(data_in_b_tb),
	.cin(cin_tb),
	.data_out(data_out_tb),
	.cout(cout_tb)

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
end
/*********************************************************/
initial begin // data
   #4 data_in_a_tb = 128;
   #0 data_in_b_tb = 127;
   #0 cin_tb = 0;   

   #14 data_in_a_tb = 255;
   #0 data_in_b_tb = 1;
   #0 cin_tb = 0;

   #14 data_in_a_tb = 120;
   #0 data_in_b_tb = 14;
   #0 cin_tb = 0;
   
end


endmodule