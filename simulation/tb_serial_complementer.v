
`timescale 1ns/1ps

module tb_serial_complementer;

    parameter N = 8;

    reg clk;
    reg rst_n;
    reg load;
    reg shift_en;
    reg [N-1:0] parallel_in;

    wire serial_out;
    wire [N-1:0] parallel_out;

    integer i;

    // Instantiate the design
    serial_complementer #(.N(N)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .shift_en(shift_en),
        .parallel_in(parallel_in),
        .serial_out(serial_out),
        .parallel_out(parallel_out)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    // Test one input
    task test_input;
        input [N-1:0] data;
        input [N-1:0] expected;

        begin
            @(negedge clk);
            parallel_in = data;
            load = 1'b1;

            @(posedge clk);
            #1;
            load = 1'b0;

            $display("\nInput: %b", data);
            $write("Serial output (LSB first): ");

            for (i = 0; i < N; i = i + 1) begin
                @(negedge clk);

                $write("%b", serial_out);
                shift_en = 1'b1;

                @(posedge clk);
                #1;
                shift_en = 1'b0;
            end

            $display("\nExpected: %b", expected);
            $display("Actual:   %b", parallel_out);

            if (parallel_out === expected)
                $display("RESULT: PASS");
            else
                $display("RESULT: FAIL");
        end
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        load = 0;
        shift_en = 0;
        parallel_in = 0;

        #12;
        rst_n = 1;

        test_input(8'b10110000, 8'b01010000);
        test_input(8'b00001101, 8'b11110011);
        test_input(8'b00000000, 8'b00000000);
        test_input(8'b11111111, 8'b00000001);
        test_input(8'b00000001, 8'b11111111);

        $display("\nAll test cases completed.");

        $finish;
    end

endmodule

