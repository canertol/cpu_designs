module DATA_REG (clk,in, out, EN);
	input [7:0] in;
	input clk, EN;
	output reg [7:0] out;

	initial begin
		out = 8'bx;
	end


	always @(posedge clk) 
		begin
			if (EN == 1) 
				begin
						out <= in;
				end
		end 
	  
endmodule