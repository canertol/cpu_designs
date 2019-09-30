module FLAG_REG (clk,in, out, EN);
	input in;
	input clk, EN;
	output reg out;

	initial begin
		out = 1'bx;
	end


	always @(posedge clk) 
		begin
			if (EN == 1) 
				begin
						out <= in;
				end
		end 
	  
endmodule