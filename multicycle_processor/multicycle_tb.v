module multicycle_tb();

 reg	clock;
 reg	reset;
 wire	zeroflag;
 wire IRegen;
 wire [1:0] ASrc1;
 wire RegWrite;
 wire carry, FlgWrite,pcEN,IDMWrite,IDMSrc,ASrc0, RD2en;
 wire [2:0] ALUCtrl;
 wire [1:0] BSrc;
 wire	[15:0] Instr;
 wire	[3:0] next_state;
 wire	[7:0] PCout;
 wire	[7:0] LR,R0,R1,R2,R3,R4,R5;
 wire [1:0] RegSrc;
 wire	[2:0] ShiftCtrl;
 wire	[3:0] state;
 wire [7:0] ToReg;

 multicycle DUT(
	reset,
	clock,
	zeroflag,
	IRegen,
	RegWrite,
	carry,
	FlgWrite,
	pcEN,
	IDMWrite,
	IDMSrc,
	ASrc0,
	RD2en,
	ALUCtrl,
	ASrc1,
	BSrc,
	Instr,
	LR,
	next_state,
	PCout,
	R0,
	R1,
	R2,
	R3,
	R4,
	R5,
	RegSrc,
	ShiftCtrl,
	state,
	ToReg
);
	
integer j;
	
initial begin
  clock=0;
  reset = 1;
end
	
always @(*)
 	begin
	reset = 0;
	for(j=0; j<10000; j=j+1) begin
	clock = ~clock;
			if(R2 != 8'b00000000)
				$display("Error in %1d case",R2);
			else
				$display("No error in %1d case",R2);			
	#10;
		end
	#1 $display("t=%t",$time," r2=%1d",R2);
	end
 

 endmodule