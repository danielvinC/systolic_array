module tb_rom;

    // Parameters
    parameter WIDTH = 32;

    // Testbench signals
    logic clk, rst_n, rden;
    logic [WIDTH-1:0] d0, d1, d2, d3;

    // Instantiate the DUT (Device Under Test)
    rom #(.stride(4), .width(WIDTH)) dut (
        .rden(rden),
        .clk(clk),
        .rst_n(rst_n),
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst_n = 0;
        rden = 0;

        // Reset the DUT
        #10 rst_n = 1;

        // Load data into memory
        #10 rden = 1;

        // Wait for a few clock cycles
        #40 rden = 0;

        // Finish simulation
        #100 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | d0: %h | d1: %h | d2: %h | d3: %h", $time, d0, d1, d2, d3);
    end

endmodule
