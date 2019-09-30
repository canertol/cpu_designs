 module shift_reg #(parameter W = 4) (
	clk,
	parallel, right,
	DATA, A, R, L,
	reset
);
 	input clk;
	input [W-1:0] DATA;
	output reg [W-1:0] A;
	input reset, R, L, parallel, right;

	initial
	begin
		A = {W{1'b0}};
	end

	always @(posedge clk)
	begin
		if (reset)
				A = {W{1'b0}};
		else 
			begin
			
			if(parallel==1)
					A = DATA;
			else
			begin
			if(right)
				begin
					A = A >> 1;
					A[W-1] = L;
				end
				else
				begin
					A = A << 1;
					A[0] = R;
				end
			end
		end
	end
endmodule
