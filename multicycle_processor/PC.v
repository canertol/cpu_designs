module PC #(parameter W=8)(CLK,NEXT,CURRENT,RST, EN);
	input [W-1:0] NEXT;
	input CLK,RST, EN;
	output reg [W-1:0] CURRENT;

	initial begin
	CURRENT = 0;
	end
	
	always @(posedge CLK)
		if(RST==0 && EN==1)
			CURRENT <= NEXT;
		else if (RST ==1)
			CURRENT <= 0;
		
endmodule