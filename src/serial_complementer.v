module first_one_ff (
    input  wire clk,
    input  wire rst_n,
    input  wire clear,
    input  wire enable,
    input  wire serial_bit,
    output reg  seen_one
)

  always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            seen_one <= 1'b0;
        else if (clear)
            seen_one <= 1'b0;
        else if (enable)
            seen_one <= seen_one | serial_bit;
    end

endmodule;


module serial_complementer #(
    parameter N = 8
)(
    input  wire         clk,
    input  wire         rst_n,
    input  wire         load,
    input  wire         shift_en,
    input  wire [N-1:0] parallel_in,

    output wire         serial_out,
    output wire [N-1:0] parallel_out
);
