module register_B_tb();
	
	reg clk;
	reg [3:0] DATA;
	wire [3:0] A;
	reg reset, WE;
	
	reg[5:0] testvectors[31:0]; // array of testvectors
	reg [4:0] vectornum;

	register_B #4 DUT(clk, DATA, A, reset, WE);
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
	$readmemb("C:/Users/Caner/Documents/GitHub/Course-Projects/EE446/LAB1/register_B_tb.tv",testvectors);
	vectornum = 0;
	end
	
	//apply test vectors
	always
	begin
	 #13;
	 {DATA, reset, WE} = testvectors[vectornum];
	 vectornum = vectornum +1;
	end

endmodule
