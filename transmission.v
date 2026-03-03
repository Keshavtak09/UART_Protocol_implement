module transmission(input clk,rst,wr_enb,enb,input [7:0] data_in,output reg tx, output tx_busy);
parameter idle_state = 2'b00;
parameter start_state = 2'b01;
parameter data_state = 2'b10;
parameter stop_state = 2'b11;
reg [7:0] data = 8'h00;
reg [2:0] index = 3'h0;
reg [1:0] state = idle_state;

always@(posedge clk)
begin
if(rst)
tx = 1'b1;
else begin
case(state)
idle_state:begin
if(wr_enb)begin
state <= start_state;
data <= data_in;
index <= 3'h0;
end
end
start_state:begin
if(enb)begin
tx <= 1'b0;
state <= data_state;
end
end
data_state:begin
if(enb)begin
tx <= data[index];
if(index == 3'h7)
state <= stop_state;
else begin
index <= index + 3'h1;
end
end
end
stop_state:begin
if(enb)begin
tx <= 1'b1;
state <= idle_state;
end
end
endcase
end
end
  assign tx_busy = (state != idle_state);
endmodule
