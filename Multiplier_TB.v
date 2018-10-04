`timescale 10 ns / 1 ns

module Multiplier_TB;


parameter WORD_LENGTH = 4;
parameter WORD = WORD_LENGTH*2;

reg clk_tb = 0;
reg reset_tb;
reg [WORD_LENGTH-1 : 0] data_in_a_tb;
reg [WORD_LENGTH-1 : 0] data_in_b_tb;

reg Start_tb;
reg Reset_Sync_tb;

wire [WORD-1 : 0] data_out_tb;
wire cout_tb;
wire ready_tb;

Multiplier
#(
	.WORD_LENGTH(WORD_LENGTH)
)
DUT
(
	.clk(clk_tb),
	.reset(reset_tb),
	.data_in_a(data_in_a_tb),
	.data_in_b(data_in_b_tb),
	.Start(Start_tb),
	.Reset_Sync(Reset_Sync_tb),
	.data_out(data_out_tb),
	.ready(ready_tb),
	.cout(cout_tb)

);

/*********************************************************/
initial // Clock generator
  begin
    forever #1 clk_tb = !clk_tb;
  end
/*********************************************************/
initial begin // Start generator
   #0 reset_tb = 0;
   #2 reset_tb = 1;
   //#4 reset_tb = 0;
end
/*********************************************************/
initial begin // data
   #4 data_in_a_tb = 15;
   #0 data_in_b_tb = 15;

//   #14 data_in_a_tb = 255;
//   #0 data_in_b_tb = 1;

//   #14 data_in_a_tb = 120;
//   #0 data_in_b_tb = 14;
end
/*********************************************************/
initial begin // Start generator
   #1 Start_tb = 0;
   #3 Start_tb = 1;
   #5 Start_tb = 0;
end

initial begin // FinishShift generator
   #1 Reset_Sync_tb = 0;
   #3 Reset_Sync_tb = 1;
   #5 Reset_Sync_tb = 0;
end
/*********************************************************/

endmodule