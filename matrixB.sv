module matrixB #(
    parameter integer stride = 4,
    parameter integer width = 32
) (
    input logic rden, clk, rst_n,
    output logic [31:0] d0, d1, d2, d3
);
    logic rden_r0, rden_r1, rden_r2, rden_r3;

    logic [31:0] mem [15:0];

    initial begin
        $readmemh("C:/Users/Dell/dan/intelFPGA_lite/18.1/project/24_fall/gemm/dmatrixB.txt", mem);
    end

    logic [31:0] block0 [3:0];
    logic [31:0] block1 [3:0];
    logic [31:0] block2 [3:0];
    logic [31:0] block3 [3:0];

    logic [1:0] index, index_b0, index_b1, index_b2, index_b3;

    // Assign blocks from memory using a loop
    always_comb begin
        for (int i = 0; i < 4; i++) begin
            block0[i] = mem[i*stride];
            block1[i] = mem[i*stride + 1];
            block2[i] = mem[i*stride + 2];
            block3[i] = mem[i*stride + 3];
        end
    end

    assign rden_r0 = rden;
    assign index_b0 = index;
    flopr #(3) row1 (clk, rst_n, {rden_r0, index_b0}, {rden_r1, index_b1});
    flopr #(3) row2 (clk, rst_n, {rden_r1, index_b1}, {rden_r2, index_b2});
    flopr #(3) row3 (clk, rst_n, {rden_r2, index_b2}, {rden_r3, index_b3});

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            d0 <= 32'b0;
            d1 <= 32'b0;
            d2 <= 32'b0;
            d3 <= 32'b0;
            index <= 2'b0;
        end else begin
            if (rden)   
                index <= index + 1'b1;

            if (rden_r0) 
                d0 <= block0[index_b0];
            else 
                d0 <= 32'b0;
                
            if (rden_r1) 
                d1 <= block1[index_b1];
            else 
                d1 <= 32'b0;

            if (rden_r2) 
                d2 <= block2[index_b2];
            else 
                d2 <= 32'b0;

            if (rden_r3) 
                d3 <= block3[index_b3];
            else 
                d3 <= 32'b0; 
        end
    end
endmodule

module flopr #(parameter WIDTH = 8)
    (input logic clk, reset,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q);
    always_ff @(posedge clk or negedge reset)
    if (!reset) q <= 0;
    else q <= d;
endmodule
