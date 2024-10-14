module tb_tt_um_murmann_group;

  // Testbench signals
  reg [7:0] ui_in;    // Dedicated inputs
  wire [7:0] uo_out;  // Dedicated outputs
  reg [7:0] uio_in;   // IOs: Input path
  wire [7:0] uio_out; // IOs: Output path
  wire [7:0] uio_oe;  // IOs: Enable path
  reg clk;            // clock
  reg rst_n;          // reset (active low)
  reg ena;            // enable

  // Instantiate the top module
  tt_um_murmann_group uut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .uio_in(uio_in),
    .uio_out(uio_out),
    .uio_oe(uio_oe),
    .ena(ena),
    .clk(clk),
    .rst_n(rst_n)
  );

  // Clock generation
  always #5 clk = ~clk; // 100MHz clock (10ns period)

  initial begin
    // Initialize inputs
    ui_in = 8'b00000000;
    uio_in = 8'b00000000;
    clk = 0;
    rst_n = 0;
    ena = 1;

    // Release reset after some time
    #20 rst_n = 1;

    // Apply input stimulus (toggle ui_in[0] to simulate ADC input)
    repeat(16) begin
      #10 ui_in[0] = ~ui_in[0]; // Toggle the input every 10ns
    end

    // Wait for decimation filter to complete
    #100;

    // Finish simulation
    $stop;
  end

  // Monitor outputs for debugging
  initial begin
    $monitor("At time %0t: ui_in = %b, uo_out = %b, uio_out = %b, uio_oe = %b, rst_n = %b", $time, ui_in, uo_out, uio_out, uio_oe,rst_n);
  end

endmodule