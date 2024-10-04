module top_module (
    input d,         // Data input for gated clock
    input clk,       // Main clock input
    input reset,     // Reset signal for accumulator
    output [15:0] acc,  // 16-bit accumulator output
    output q         // Output of the gated clock
);

    // Intermediate signal to connect gated clock output to accumulator clock
    wire gated_clk;

    // Instantiate the gated clock module
    gated_clock u1 (
        .d(d),
        .clk(clk),
        .q(q),           // Gated clock output
        .clock(gated_clk) // Connect to gated clock wire
    );

    // Instantiate the accumulator module using the gated clock
    accumulator u2 (
        .in(16'b1),        // Example 16-bit input value
        .clk(gated_clk),   // Use gated clock as the clock input for accumulator
        .reset(reset),     // Reset signal for accumulator
        .acc(acc)          // Accumulator output
    );

endmodule

module gated_clock(
    input d,      // Data input
    input clk,    // Main clock signal
    output reg q, // Output register
    output clock  // Gated clock output
);

    wire a1;      // Intermediate wire for clock gating

    // Clock gating using AND gate
    and (a1, d, clk);
    assign clock = a1;

    // Sequential logic using gated clock
    always @(posedge clock) begin
        q <= d;  // Capture the value of d on rising edge of gated clock
    end
endmodule

module accumulator(
    input [15:0] in,   // 16-bit input value
    input clk,         // Clock signal
    input reset,       // Reset signal
    output reg [15:0] acc  // 16-bit accumulator output
);

    // Always block triggered on the clock signal
    always @(posedge clk) begin
        if (reset)
            acc <= 16'b0;  // Reset accumulator to zero
        else
            acc <= acc + in;  // Accumulate the input value
    end

endmodule
