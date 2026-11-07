module first_one_ff (
    input  wire clk,
    input  wire rst_n,
    input  wire clear,
    input  wire enable,
    input  wire serial_bit,
    output reg  seen_one
);
