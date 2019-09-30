module INST_REG (clk,in, out, EN);
	input [15:0] in;
	input clk, EN;
	output reg [15:0] out;

	initial begin
		out = 16'bx;
	end


	always @(posedge clk) 
		begin
			if (EN == 1) 
				begin
						out <= in;
				end
		end 
	  
endmodule