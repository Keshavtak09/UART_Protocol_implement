module UART_top(input clk,wr_enb,rdy_clr,rst,input [7:0] data_in,output rdy,busy,output [7:0] data_out);
wire rx_clk_en;
wire tx_clk_en;
wire tx_temp;

BR_generator brg(clk,rst,tx_clk_en,rx_clk_en);

transmission ut(clk,rst,wr_enb,tx_clk_en,data_in,tx_temp,busy);

receiver ur(clk,rst,tx_temp,rdy_clr,rx_clk_en,rdy,data_out);

endmodule
