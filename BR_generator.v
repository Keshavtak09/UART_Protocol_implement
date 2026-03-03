module BR_generator(input clk,rst,output reg enb_tx,enb_rx);
reg [15:0] counter_tx;
reg [15:0] counter_rx;
parameter clk_frequency = 100000000;
parameter baud_rate = 9600;
parameter factor_tx = clk_frequency/baud_rate;
parameter factor_rx = clk_frequency/(baud_rate*16);

always@(posedge clk)
begin
if(rst)
begin
counter_tx <= 0;
enb_tx = 0;
end
else if(counter_tx == factor_tx - 1)
begin
counter_tx = 0;
enb_tx = 1;
end
else
begin
counter_tx = counter_tx + 1'b1;
enb_tx = 0;
end
end
always@(posedge clk)
begin
if(rst)
begin
counter_rx <= 0;
end
else if(counter_rx == factor_rx - 1)
begin
counter_rx = 0;
enb_rx = 1;
end
else
begin
counter_rx = counter_rx + 1'b1;
enb_rx = 0;
end
end
endmodule
