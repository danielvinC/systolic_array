module top (
    input logic clk, rst_n, en,
    output logic done,
    output logic [63:0] d,

    output logic [31:0] inp_west0, inp_west4, inp_west8, inp_west12,
		      inp_north0, inp_north1, inp_north2, inp_north3);

    logic [63:0] result15;

    assign d = result15;

    multip systolic_array_2D (inp_west0, inp_west4, inp_west8, inp_west12,
		    inp_north0, inp_north1, inp_north2, inp_north3,
		    clk, rst_n, done, result15);

    matrixA #(1) ma(en, clk, rst_n, inp_west0, inp_west4, inp_west8, inp_west12);
    matrixB #(4) mb(en, clk, rst_n, inp_north0, inp_north1, inp_north2, inp_north3);
endmodule