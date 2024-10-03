
module tb_();
   
reg rst, clk, en;

reg [31:0] inp_west0, inp_west4, inp_west8, inp_west12, inp_north0, inp_north1, inp_north2, inp_north3;
wire done;
reg [63:0] d;


top uut (
        clk,
        rst,
        en,
        done,
        d,
		inp_west0, inp_west4, inp_west8, inp_west12,
		      inp_north0, inp_north1, inp_north2, inp_north3
    );


initial begin
	#3  en <= 1'b1;
	#40 en <= 1'b0;
end


initial begin
rst <= 1;
clk <= 0;
#3
rst <= 0;
#2
rst <= 1;

end

initial begin
	repeat(24)
		#5 clk <= ~clk;
end

initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0, tb_);
end

endmodule

