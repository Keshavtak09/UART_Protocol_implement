module receiver(input clk,rst,rx,rdy_clr,clk_en,output reg rdy,output reg [7:0]data_out);
parameter start_state_rx = 2'b00;
parameter data_out_rx = 2'b01;
parameter stop_state_rx = 2'b10;
reg [1:0] state = start_state_rx;
reg [3:0] sample = 0;
reg [3:0] index = 0;
reg [7:0] temp = 8'h0;
always@(posedge clk)
begin
if(rst)
begin
rdy = 0;
data_out = 0;
end
else begin
if(rdy_clr)
rdy <=0;
if(clk_en)begin
case(state)
start_state_rx:begin
if(!rx || sample != 0)
sample <= sample + 4'b1;
if(sample == 15)begin
state <= data_out_rx;
index <= 0;
sample <= 0;
temp <= 0;
end
end
data_out_rx:begin
sample <= sample +4'b1;
if(sample == 4'h8) begin
temp[index] <= rx;
index <= index + 4'b1;
end
if(index == 8 && sample == 15)
state <= stop_state_rx;
end
stop_state_rx:begin
if(sample == 15)begin
state <= start_state_rx;
data_out <= temp;
rdy <= 1'b1;
sample <= 0;
end
else begin
sample <= sample + 4'b1;
end
end
endcase
end
end
end
endmodule
