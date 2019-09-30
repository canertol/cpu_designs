module alu #(parameter W = 4) (
	// Inputs
	A, B,
	// Outputs
	out, CO, OVF, Z ,N,
	// Control Signal
	ALU_control);
	// Inputs
	input [W-1:0] A;
	input [W-1:0]  B;
	// Outputs
	output reg[W-1:0] out;
	output reg CO, OVF, Z ,N;
	// Signal
	input[2:0] ALU_control;
	
	always@(*)
	begin
		case (ALU_control)
			// Arithmetic operations
			3'b000: begin
						{CO,out} = A + B;
						OVF = (A[W-1] & B[W-1] & !out[W-1])| (!A[W-1] & !B[W-1] & out[W-1]);
					  end	
			3'b001: begin
						{CO,out} = A - B;	
						OVF = (A[W-1] & !B[W-1] & !out[W-1])| (!A[W-1] & B[W-1] & out[W-1]);
					  end
			3'b010: begin
						{CO,out} = B - A;
						OVF = (B[W-1] & !A[W-1] & !out[W-1])| (!B[W-1] & A[W-1] & out[W-1]);
					  end

			// Logic operations	
			3'b011: out = A ~^ B;
			3'b100: out = A & B;	
			3'b101: out = A | B;	
			3'b110: out = A ^ B;	
			3'b111: out = A & ~B;

		endcase
		
		
		//OVF = ({CO,out[W-1]} == 2'b01)|({CO,out[W-1]} == 2'b10);
		

		if((ALU_control != 3'b000) && (ALU_control != 3'b001) && (ALU_control != 3'b010))
			begin
				CO = 1'b0;
				OVF = 1'b0;
			end
		
		N = out[W-1];
		Z = out=={W{1'b0}};
	end
endmodule
