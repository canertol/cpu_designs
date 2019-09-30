module Controller_Unit_tb();
	
	  reg CLK,  CLR;
     reg LOAD, COMP;
     reg [2:0] OP;
     reg [1:0] Stat;
	  reg R1m, R0m;
     reg NFlag , Qn, Qz;
     
	  //OUTPUTS
	  wire ERR;
     wire AccRight, AccParallel, AccCLR, QParallel, QSrc, QnCLR, RST, QRight, QzSrc;
	  wire R1Clr, R1Src, R0WE, R1WE;
	  wire [1:0] R0Src, ASrc, BSrc;
	  wire [2:0] ALUCtrl;
	  
	reg [12:0]testvectors[8:0]; // array of testvectors
	reg [3:0] vectornum;

	Controller_Unit #4 DUT(.CLK(CLK),
            .AccRight(AccRight), .AccParallel(AccParallel), .AccCLR(AccCLR), // Acc register control
            .ALUCtrl(ALUCtrl), .ASrc(ASrc), .BSrc(BSrc),  // ALU Controllers
            .Stat(Stat), .NFlag(NFlag),    // Status bits
            .LOAD(LOAD),.R1m(R1m), .R0m(R0m),
            .COMP(COMP), .R1Clr(R1Clr), .R1Src(R1Src), .R0WE(R0WE), .R1WE(R1WE), .R0Src(R0Src),
            .OP(OP),  //ALP Operation
				.QParallel(QParallel), .QSrc(QSrc), .QnCLR(QnCLR), .RST(RST), .QRight(QRight), .QzSrc(QzSrc), .Qn(Qn), .Qz(Qz),
            .CLR(CLR), // reset registers
            .ERR(ERR)
            );
				
				
				
	// generate clock
	always // no sensitivity list, so it always executes
	begin
		CLK <= 1; 
		#50;
		CLK <= 0;
		#50;
	end	
	// load vectors
	initial
	begin
	$readmemb("C:/Users/Caner/Documents/GitHub/Course-Projects/EE446/LAB2/Controller_Unit_tb.tv",testvectors);
	vectornum = 0;
	end
	
	//apply test vectors
	always
	begin
	 #80;
	 {LOAD, COMP, OP, CLR, NFlag, Stat, Qn, Qz, R1m, R0m } = testvectors[vectornum];
	 vectornum = vectornum +1;
	end

endmodule
