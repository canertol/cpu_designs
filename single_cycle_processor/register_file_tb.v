module register_file_tb();
	
	reg clk;
	reg [3:0] data_in;
	reg [1:0] A1, A2, A3;
	reg WE3, rst;
	// outputs
	wire [3:0] RD1, RD2;

	reg[11:0] testvectors[15:0]; // array of testvectors
	reg [4:0] vectornum;

	register_file #4 DUT(clk, data_in, WE3, rst,	A1, A2, A3, RD1, RD2);
	// generate clock
	always // no sensitivity list, so it always executes
	begin
		clk <= 1; 
		#5;
		clk <= 0;
		#5;
	end	
	// load vectors
	initial
	begin
	$readmemb("C:/Users/Caner/Documents/GitHub/Course-Projects/EE446/LAB1/register_file_tb.tv",testvectors);
	vectornum = 0;
	end
	
	//apply test vectors
	always
	begin
	 #13;
	 {data_in, A1, A2, A3, WE3, rst} = testvectors[vectornum];
	 vectornum = vectornum +1;
	end

endmodule
