module alu_tb();
	reg [3:0] A;
	reg [3:0]  B;
	// Outputs
	wire [3:0] out;
	wire CO, OVF, Z ,N;
	// Signal
	reg [2:0] ALU_control;
	reg[10:0] testvectors[7:0]; // array of testvectors
	reg [2:0] vectornum;

	alu #4 DUT(A, B,	out, CO, OVF, Z ,N, ALU_control);
	
	// load vectors
	initial
	begin
	$readmemb("C:/Users/Caner/Documents/GitHub/Course-Projects/EE446/LAB1/alu_tb.tv",testvectors);
	vectornum = 0;
	end
	
	//apply test vectors
	always
	begin
	 #5;
	 {A,B,ALU_control} = testvectors[vectornum];
	 vectornum = vectornum +1;
	end

endmodule
