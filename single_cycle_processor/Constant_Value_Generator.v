module Constant_Value_Generator #(parameter W = 4, V = 4'b0000) (bus_in);

	output wire [(W-1):0] bus_in;
	
	assign bus_in = V;

endmodule