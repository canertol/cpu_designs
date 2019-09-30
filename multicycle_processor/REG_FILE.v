module REG_FILE(input RST,CLK,
					 input WE3,
				 	 input [2:0] RA1, RA2, WA3,
					 input [7:0] WD3, R15,
					 output wire [7:0] RD1, RD2, RDstr, R6,R0, R1, R2, R3, R4, R5);
					 
	reg [7:0] RF[7:0];
	integer i;
	initial
	begin
		for (i=0; i<7; i=i+1) RF[i] <= 8'b000000000;
	end
		
	always @(posedge CLK)			
		// Sequantial Write
		begin
		if (WE3) RF[WA3] <= WD3;
		if(RST==1)  for (i=0; i<7; i=i+1) RF[i] <= 8'b0;
		end
		
	assign RD1 = RF[RA1];	// Combinational Read
	assign RD2 = RF[RA2];
	assign RDstr = RF[WA3];
	assign R0 = RF[0];
	assign R1 = RF[1];
	assign R2 = RF[2];
	assign R3 = RF[3];
	assign R4 = RF[4];
	assign R5 = RF[5];
	assign R6 = RF[6];		// LR
	assign R_15 = R15; 		// PC

endmodule