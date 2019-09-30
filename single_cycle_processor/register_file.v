module register_file #(parameter W = 4)(
	clk, 
	data_in,
	WE3, rst,
	A1, A2, A3, 
	RD1, RD2
	);

	// inputs
	input clk;
	input [W-1:0] data_in;
	input [1:0] A1, A2, A3;
	input WE3, rst;
	// outputs
	output wire [W-1:0] RD1, RD2;
	// wires
	wire [3:0] d; // output of decoder
	wire [W-1:0] r_out1,r_out2, r_out3, r_out4; // register outputs
	wire EN1, EN2, EN3, EN4; // write enables
	
	decoder #(2) decoder1(
		.in(A3), 
		.out(d)
	);
	
	assign EN1 = WE3 & d[0];
	assign EN2 = WE3 & d[1];
	assign EN3 = WE3 & d[2];
	assign EN4 = WE3 & d[3];
	
	register_B #(W) reg1(
		.clk(clk),
		.DATA(data_in),
		.A(r_out1),
		.reset(rst),
		.WE(EN1)	
	);
	
	register_B #(W) reg2(
		.clk(clk),
		.DATA(data_in),
		.A(r_out2),
		.reset(rst),
		.WE(EN2)		
	);
	
	register_B #(W) reg3(
		.clk(clk),
		.DATA(data_in),
		.A(r_out3),
		.reset(rst),
		.WE(EN3)		
	);
	
	register_B #(W) reg4(
		.clk(clk),
		.DATA(data_in),
		.A(r_out4),
		.reset(rst),
		.WE(EN4)		
	);
	
	mux4 #(W) mux_1(
		.select(A1),
		.mux_in1(r_out1),
		.mux_in2(r_out2),
		.mux_in3(r_out3),
		.mux_in4(r_out4),
		.mux_out(RD1)
	);
	
	mux4 #(W) mux_2(
		.select(A2),
		.mux_in1(r_out1),
		.mux_in2(r_out2),
		.mux_in3(r_out3),
		.mux_in4(r_out4),
		.mux_out(RD2)
	);
  
endmodule
