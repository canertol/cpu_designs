module DATA_MEM(input CLK,
					 input WE,
				 	 input [31:0] A,
					 input [31:0] WD,
					 input RST,
					 output wire [31:0] RD);
					 
	reg [31:0] DATA[200:0];
	integer i;
	
	always @(posedge CLK)				// Sequantial Write
		begin
		if (WE) DATA[A] <= WD;
		if(RST==1)  for (i=0; i<201; i=i+1) DATA[i] <= 32'b0;
		end
	assign RD = DATA[A];			// Combinational read

endmodule