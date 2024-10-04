module top_module (
    input d,             // Data input for gated clock
    input clk,           // Main clock input
    input reset,         // Reset signal for accumulator
    output [15:0] acc,   // 16-bit accumulator output
    output q             // Output of the gated clock
);

    // Intermediate signal to connect gated clock output to accumulator clock
    wire gated_clk;

    // Instantiate the gated clock module
    gated_clock u1 (
        .d(d),
        .clk(clk),
      .reset(reset),
        .q(q),                // Gated clock output
        .gated_clock_out(gated_clk)     // Connect to gated clock wire
    );

    // Example input value for the accumulator
    reg [15:0] in;

    // Instantiate the accumulator module using the gated clock
    accumulator u2 (
        .in(in),              // Connect input to the accumulator
        .clk(gated_clk),      // Use gated clock as the clock input for accumulator
        .reset(reset),        // Reset signal for accumulator
        .acc(acc)             // Accumulator output
    );

    // Generate test values for in
    always @(posedge gated_clk) begin
        if (!reset) begin
            in <= in + 1;    // Example: Increment input value on each gated clock
        end
    end

endmodule

module gated_clock(
    input d,               // Data input
    input clk,             // Main clock signal
    input reset,
    output reg q,          // Output register
    output gated_clock_out  // Gated clock output
);
    wire not_clk;          // Intermediate wire for NOT gate
    wire a1;               // Intermediate wire for clock gating
  
    // Invert the clock signal
    not (not_clk, clk);

    // Clock gating using AND gate
    and (a1, d, not_clk);
    assign gated_clock_out = a1;

    // Sequential logic using gated clock
    always @(posedge gated_clock_out) begin
      if (reset)
          q <= 1'b0;
      else
          q <= d;  // Capture the value of d on the rising edge of gated clock
    end
endmodule

module accumulator(
    input [15:0] in,       // 16-bit input value
    input clk,             // Clock signal
    input reset,           // Reset signal
    output reg [15:0] acc  // 16-bit accumulator output
);

    // Always block triggered on the clock signal
    always @(posedge clk) begin
        if (reset)
            acc <= 16'b0;   // Reset accumulator to zero
        else
            acc <= acc + in; // Accumulate the input value
    end

endmodule
