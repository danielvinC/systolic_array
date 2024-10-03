module multip(inp_west0, inp_west4, inp_west8, inp_west12,
		      inp_north0, inp_north1, inp_north2, inp_north3,
		      clk, rst, done, result15);
	
	input [31:0] inp_west0, inp_west4, inp_west8, inp_west12,
		      inp_north0, inp_north1, inp_north2, inp_north3;
	output reg done;
	input clk, rst;

	logic [31:0] mem[0:15];

	reg [3:0] count;
	
	wire [31:0] inp_north0, inp_north1, inp_north2, inp_north3;
	wire [31:0] inp_west0, inp_west4, inp_west8, inp_west12;
	wire [31:0] outp_south0, outp_south1, outp_south2, outp_south3, outp_south4, outp_south5, outp_south6, outp_south7, outp_south8, outp_south9, outp_south10, outp_south11, outp_south12, outp_south13, outp_south14, outp_south15;
	wire [31:0] outp_east0, outp_east1, outp_east2, outp_east3, outp_east4, outp_east5, outp_east6, outp_east7, outp_east8, outp_east9, outp_east10, outp_east11, outp_east12, outp_east13, outp_east14, outp_east15;
	wire [63:0] result0, result1, result2, result3, result4, result5, result6, result7, result8, result9, result10, result11, result12, result13, result14;
    output reg [63:0] result15;
	
	assign mem[0] = result0;
	assign mem[1] = result1;
	assign mem[2] = result2;
	assign mem[3] = result3;
	assign mem[4] = result4;
	assign mem[5] = result5;
	assign mem[6] = result6;
	assign mem[7] = result7;
	assign mem[8] = result8;
	assign mem[9] = result9;
	assign mem[10] = result10;
	assign mem[11] = result11;
	assign mem[12] = result12;
	assign mem[13] = result13;
	assign mem[14] = result14;
	assign mem[15] = result15;

	initial begin
        $writememh("mem.data", mem);
    end


	//from north and west
	PE P0 (inp_north0, inp_west0, clk, rst, outp_south0, outp_east0, result0);
	//from north
	PE P1 (inp_north1, outp_east0, clk, rst, outp_south1, outp_east1, result1);
	PE P2 (inp_north2, outp_east1, clk, rst, outp_south2, outp_east2, result2);
	PE P3 (inp_north3, outp_east2, clk, rst, outp_south3, outp_east3, result3);
	
	//from west
	PE P4 (outp_south0, inp_west4, clk, rst, outp_south4, outp_east4, result4);
	PE P8 (outp_south4, inp_west8, clk, rst, outp_south8, outp_east8, result8);
	PE P12 (outp_south8, inp_west12, clk, rst, outp_south12, outp_east12, result12);
	
	//no direct inputs
	//second row
	PE P5 (outp_south1, outp_east4, clk, rst, outp_south5, outp_east5, result5);
	PE P6 (outp_south2, outp_east5, clk, rst, outp_south6, outp_east6, result6);
	PE P7 (outp_south3, outp_east6, clk, rst, outp_south7, outp_east7, result7);
	//third row
	PE P9 (outp_south5, outp_east8, clk, rst, outp_south9, outp_east9, result9);
	PE P10 (outp_south6, outp_east9, clk, rst, outp_south10, outp_east10, result10);
	PE P11 (outp_south7, outp_east10, clk, rst, outp_south11, outp_east11, result11);
	//fourth row
	PE P13 (outp_south9, outp_east12, clk, rst, outp_south13, outp_east13, result13);
	PE P14 (outp_south10, outp_east13, clk, rst, outp_south14, outp_east14, result14);
	PE P15 (outp_south11, outp_east14, clk, rst, outp_south15, outp_east15, result15);
	
	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			done <= 0;
			count <= 0;
		end
		else begin
			if(count == 9) begin
				done <= 1;
				count <= 0;
			end
			else begin
				done <= 0;
				count <= count + 1;
			end
		end	
	end 
	
		      
endmodule