module SM_TB;

parameter WORD_LENGTH = 5
;

reg clk_tb = 0;
reg reset_tb;
reg [WORD_LENGTH-1:0] data_in_tb = 0;
reg load_tb;

wire data_out_tb;



SM
#(
	.WORD_LENGTH(WORD_LENGTH)
)
DUT
(
	.clk(clk_tb),
	.reset(reset_tb),
	.data_in(data_in_tb),
	.load(load_tb),
	.data_out(data_out_tb)

);

/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk_tb = !clk_tb;
  end
/*********************************************************/
initial begin // reset generator
   #1 reset_tb = 0;
   #7 reset_tb = 1;

end
/*********************************************************/
initial begin // load data generator
   #8 load_tb = 0;
   #10 load_tb = 1;
   #12 load_tb = 0;
end
/*********************************************************/
initial begin // data
   #7 data_in_tb = 0;
   
end


endmodule