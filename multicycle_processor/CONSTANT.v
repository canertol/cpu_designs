module CONSTANT #(parameter W = 8, V = 1) (bus_in);

	output wire [(W-1):0] bus_in;
	
	assign bus_in = V;

endmodule