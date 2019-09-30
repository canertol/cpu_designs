 module register_A #(parameter W = 8) (
	clk,
	DATA, A,
	reset
);
 	input clk;
	input [W-1:0] DATA;
	output reg [W-1:0] A;
	input reset;

	initial
	begin
		A = {W{1'b0}};
	end

	always @(posedge clk)
	begin
		if (!reset)
			A <= DATA;
		else
			begin
				A <= {W{1'b0}};
			end
	end
endmodule
