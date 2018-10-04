`timescale 10 ns / 1 ns

module Counter_TB;


parameter WORD_LENGTH = 3;
parameter WORD = WORD_LENGTH*2;

reg clk_tb = 0;
reg reset_tb;
reg enable_tb;

wire flag_tb;

Counter
#(
	.WORD_LENGTH(WORD_LENGTH)
)
DUT
(
	.clk(clk_tb),
	.reset(reset_tb),
	.enable(enable_tb),
	.flag(flag_tb)
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
   #0 enable_tb = 0;
   #5 enable_tb = 1;

   
end


endmodule