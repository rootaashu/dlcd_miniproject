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


    reg [N-1:0] shift_reg;
    wire seen_one;
    wire serial_in;

    assign serial_out = shift_reg[0];

    assign serial_in = serial_out ^ seen_one;

    assign parallel_out = shift_reg;

    first_one_ff state_ff (
        .clk(clk),
        .rst_n(rst_n),
        .clear(load),
        .enable(shift_en),
        .serial_bit(serial_out),
        .seen_one(seen_one)
    );


 always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            shift_reg <= {N{1'b0}};

        else if (load)
            shift_reg <= parallel_in;

        else if (shift_en)
            shift_reg <= {serial_in, shift_reg[N-1:1]};
    end

endmodule
