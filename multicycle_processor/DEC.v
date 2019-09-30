module DEC(input [1:0] Op,
			  input [5:0] Funct,
			  input [3:0] Rd,
			  output [1:0]  ImmSrc, 
			  output RegSrc,
			  output reg NoWrite,Shift,
			  output MemtoReg, ALUSrc, RegW, MemW, PCS,
			  output reg [1:0] ALUControl, FlagW
				);
	  reg [8:0] controls;
	  wire Branch, ALUOp;
	  
	// Main Decoder
	always
		casex(Op)
			
			2'b00: if (Funct[5]) controls = 9'b000101001; // Data-processing immediate
					 else controls = 9'b000001001; // Data-processing register
					 
			2'b01: if (Funct[0]) controls = 9'b001111000; // LDR
					 else controls = 9'b101110100; // STR
					 
			2'b10: controls = 9'b110100010; // B 
			
			default: controls = 9'bx; // Unimplemented
		endcase
		
	assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, RegW, MemW, Branch, ALUOp} = controls;
	
	// ALU Decoder
	always
		if (ALUOp) 
			begin // which DP Instr?
				case(Funct[4:1])
					4'b0100: begin
									ALUControl = 2'b00; // ADD
									NoWrite=0;
									Shift=0;
								end
					4'b0010: begin
									ALUControl = 2'b01; // SUB
									NoWrite=0;
									Shift=0;
								end
					4'b0000: begin
									ALUControl = 2'b10; // AND
									NoWrite=0;
									Shift=0;
								end
					4'b1100: begin
									ALUControl = 2'b11; // ORR
									NoWrite=0;
									Shift=0;
								end
					4'b1010: begin 					  // CMP
									NoWrite=1;
									ALUControl = 2'b01; 
									Shift=0;
								end
					4'b1101: begin 
									NoWrite=0;
									ALUControl = 2'bx;  // LSR, LSL
									Shift=1;
								end		
					
					default: begin 
									NoWrite=0;
									ALUControl = 2'bx;  // unimplemented
									Shift=0;
								end		 
				endcase
			// update flags if S bit is set (C & V only for arith)
			FlagW[1] = Funct[0];
			FlagW[0] = Funct[0] & (ALUControl == 2'b00 | ALUControl == 2'b01);
			end 
		else 
			begin
				ALUControl = 2'b00; // add for non-DP instructions
				FlagW = 2'b00; // don't update Flags
				Shift = 0;
			end
			
	// PC  
	assign PCS = ((Rd == 4'b1111) & RegW) | Branch;
endmodule