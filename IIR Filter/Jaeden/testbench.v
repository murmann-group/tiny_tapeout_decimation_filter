`timescale 1ns/1ps

module testbench;
    // Testbench signals
    reg d;                    // Data input for gated clock
    reg clk;                  // Main clock input
    reg reset;                // Reset signal for accumulator
    wire [15:0] acc;          // 16-bit accumulator output
    wire q;                  // Output of the gated clock

    // Instantiate the top module
    top_module uut (
        .d(d),
        .clk(clk),
        .reset(reset),
        .acc(acc),
        .q(q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        d = 0;
        reset = 1;

        // Reset the system
        #10;
        reset = 0; // Release reset
        #10;

        // Enable gated clock and accumulate values
        d = 1; // Enable gated clock
        #50; // Allow some time for accumulation

        d = 0; // Disable gated clock
        #30; // Wait and observe

        // Test reset functionality
        reset = 1; // Assert reset
        #10;
        reset = 0; // Release reset

        // Finish simulation
        #20;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0t | d: %b | reset: %b | gated clock: %b | acc: %h", 
                 $time, d, reset, q, acc);
    end

endmodule
