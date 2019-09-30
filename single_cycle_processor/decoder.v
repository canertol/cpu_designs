module decoder #(parameter IN_WIDTH = 3) (
	in, out
);
	input [(IN_WIDTH-1):0] in;
	output reg [((1<<IN_WIDTH)-1):0] out;

	always @(in)
	begin
		out = {(1<<IN_WIDTH){1'b0}};
		out[in] = 1'b1;
	end

endmodule