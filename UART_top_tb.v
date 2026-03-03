`timescale 1ns / 1ps

module UART_top_tb;

reg clk,rst;
reg [7:0] data_in;
reg wr_enb;
reg rdy_clr;

wire rdy;
wire [7:0] data_out;
wire busy;

UART_top dut(clk,wr_enb,rdy_clr,rst,data_in,rdy,busy,data_out);

initial begin
{clk,rst,data_in,rdy_clr,wr_enb}=0;
end

always #5 clk=~clk;

task send_byte(input [7:0] din);
begin
@(negedge clk);
data_in=din;
wr_enb=1'b1;
@(negedge clk);
wr_enb=1'b0;
end
endtask

task clear_ready;
begin
@(negedge clk);
rdy_clr=1'b1;
@(negedge clk);
rdy_clr=1'b0;
end
endtask

initial begin
@(negedge clk);
rst=1'b1;
@(negedge clk);
rst=1'b0;

send_byte(8'h41);
wait(!busy);
wait(rdy);
$display("recived data is %h",data_out);
clear_ready;

send_byte(8'h55);
wait(!busy);
wait(rdy);
$display("recived data is %h",data_out);
clear_ready;

#400 $finish;
end

endmodule
