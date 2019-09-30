module EXTEND(input [23:0] Instr,
					input [1:0] ImmSrc,
					output reg [31:0] ExtImm);
	
	always
		case(ImmSrc)
			// 8-bit unsigned immediate
			2'b00: ExtImm = {24'b0, Instr[7:0]};
			// 12-bit unsigned immediate
			2'b01: ExtImm = {20'b0, Instr[11:0]};
			// 24-bit two's complement shifted branch
			2'b10: ExtImm = {{6{Instr[23]}}, Instr[23:0], 2'b00};
			default: ExtImm = 32'bx; // undefined
		endcase
endmodule