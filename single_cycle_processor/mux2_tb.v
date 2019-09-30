module mux2_tb();
	reg select;
	reg[3:0] mux_in1, mux_in2;
	wire [3:0] mux_out;
	reg[8:0] testvectors[31:0]; // array of testvectors
	reg [4:0] vectornum;

	mux2 #4 DUT(select, mux_in1, mux_in2, mux_out);
	
	// load vectors
	initial
	begin
	$readmemb("C:/Users/Caner/Documents/GitHub/Course-Projects/EE446/LAB1/mux2_tb.tv",testvectors);
	vectornum = 0;
	end
	
	//apply test vectors
	always
	begin
	 #5;
	 {mux_in1, mux_in2,select} = testvectors[vectornum];
	 vectornum = vectornum +1;
	end

endmodule
