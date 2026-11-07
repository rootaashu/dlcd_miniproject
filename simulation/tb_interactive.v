
`timescale 1ns/1ps

module tb_interactive;

    parameter N = 8;

    reg clk;
    reg rst_n;
    reg load;
    reg shift_en;
    reg [N-1:0] parallel_in;

    wire serial_out;
    wire [N-1:0] parallel_out;

    integer i;
    integer scan_result;

    reg [N-1:0] user_input;

    // DUT
    serial_complementer #(.N(N)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .shift_en(shift_en),
        .parallel_in(parallel_in),
        .serial_out(serial_out),
        .parallel_out(parallel_out)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst_n = 0;
        load = 0;
        shift_en = 0;
        parallel_in = 0;

        #12;
        rst_n = 1;

        forever begin

            $display("\n================================");
            $display(" SERIAL 2's COMPLEMENTER");
            $display("================================");
            $display("Enter an %0d-bit binary number:", N);

            scan_result = $fscanf(32'h80000000, "%b", user_input);

            if (scan_result != 1) begin
                $display("Input ended. Exiting.");
                $finish;
            end

            // Load input
            @(negedge clk);
            parallel_in = user_input;
            load = 1;

            @(posedge clk);
            #1;
            load = 0;

            $display("\nOriginal Number : %b", user_input);
            $write("Serial Output  : ");

            // Shift and complement
            for (i = 0; i < N; i = i + 1) begin

                @(negedge clk);

                $write("%b", serial_out);
                shift_en = 1;

                @(posedge clk);
                #1;
                shift_en = 0;

            end

            $display("\n2's Complement : %b", parallel_out);
            $display("================================");

        end

    end

endmodule

