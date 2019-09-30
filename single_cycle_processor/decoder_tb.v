module decoder_tb();
	reg [1:0] in;
	wire [3:0] out;
	reg[1:0] testvectors[3:0]; // array of testvectors
	reg [1:0] vectornum;
	
	decoder #2 DUT(in, out);
	
	// load vectors
	initial
	begin
	$readmemb("C:/Users/Caner/Documents/GitHub/Course-Projects/EE446/LAB1/decoder_tb.tv",testvectors);
	vectornum = 0;
	end
	
	//apply test vectors
	always
	begin
	 #1;
	 in = testvectors[vectornum];
	 vectornum = vectornum +1;
	end

endmodule