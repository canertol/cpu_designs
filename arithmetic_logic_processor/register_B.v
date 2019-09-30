 module register_B #(parameter W = 8) (
	clk,
	DATA, A,
	reset, WE
);
 	input clk;
	input [W-1:0] DATA;
	output reg [W-1:0] A;
	input reset, WE;

	initial
	begin
		A = {W{1'b0}};
	end

	always @(posedge clk)
	begin
		if (reset)
				A <= {W{1'b0}};
		else if(WE==1)
			A <= DATA;
		else
			A <= A;
		
	end
endmodule
