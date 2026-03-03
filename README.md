# UART Verilog Implementation

## Overview

This project implements a basic UART (Universal Asynchronous Receiver
Transmitter) in Verilog.

**Configuration:** - System Clock: 100 MHz - Baud Rate: 9600 - Receiver
Oversampling: 16x - Data Bits: 8 - Parity: None - Stop Bits: 1 - LSB
First Transmission

------------------------------------------------------------------------

## Project Structure

    ├── BR_generator.v
    ├── transmission.v
    ├── receiver.v
    ├── UART_top.v
    └── UART_top_tb.v

------------------------------------------------------------------------

## Module Description

### BR_generator.v

Generates baud rate enable signals. - enb_tx → 1x baud tick for
transmitter - enb_rx → 16x baud tick for receiver

### transmission.v

UART Transmitter module.

Inputs: - clk - rst - wr_enb - enb - data_in\[7:0\]

Outputs: - tx - tx_busy

Function: - Sends start bit - Sends 8 data bits (LSB first) - Sends stop
bit - Sets tx_busy during transmission

### receiver.v

UART Receiver module.

Inputs: - clk - rst - rx - rdy_clr - clk_en

Outputs: - rdy - data_out\[7:0\]

Function: - Detects start bit - Samples incoming data - Stores received
byte - Raises rdy when data is valid

### UART_top.v

Top-level module connecting all components.

Inputs: - clk - wr_enb - rdy_clr - rst - data_in\[7:0\]

Outputs: - rdy - busy - data_out\[7:0\]

Internal Connections: - enb_tx → transmitter enable - enb_rx → receiver
sampling enable - tx internally looped to receiver for simulation

### UART_top_tb.v

Testbench for simulation.

Features: - 10 ns clock generation - Reset sequence - Sends test bytes -
Waits for transmission completion - Displays received data

Tested Values: - 0x41 - 0x55

------------------------------------------------------------------------

## Simulation Flow

1.  Apply reset
2.  Load data_in
3.  Assert wr_enb
4.  Wait until busy becomes 0
5.  Wait until rdy becomes 1
6.  Read data_out
7.  Clear ready using rdy_clr

------------------------------------------------------------------------

## Notes

-   Synchronous design
-   Suitable for FPGA implementation
-   Basic UART (8N1 format)
-   Designed for simulation and learning purposes
