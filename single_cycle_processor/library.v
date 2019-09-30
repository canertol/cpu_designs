/////////////////////////////////////////////////////////////////////
/// MODULE LIBRARY FOR EE446 LABORATORY /////////////////////////////
/////////////////////////////////////////////////////////////////////

/// N-bit Register with Sync. Reset///
//////////////////////////////////////
module reg_w_rst #(parameter N=8) (clk, rst, in, out);

	input clk, rst;
	input [N-1:0] in;
	output reg [N-1:0] out;

	always @(posedge clk)
	begin
		if (rst) begin
			out <= 0;
		end else begin
			out <= in;
		end
	end

endmodule

/// N-bit Register with Sync. Reset and Write Enable///
///////////////////////////////////////////////////////
module reg_w_rst_en #(parameter N=8) (clk, rst, en, in, out);

	input clk, rst, en;
	input [N-1:0] in;
	output reg [N-1:0] out;

	always @(posedge clk)
	begin
		if (en) begin
			if (rst) begin
				out <= 0;
			end else begin
				out <= in;
			end
		end
	end

endmodule


/// N-bit Shift Register with Sync. Reset ///
/////////////////////////////////////////////
module reg_w_shft #(parameter N=8) (clk, rst, par_ser, shftr_l, p_in, p_out, s_in_l, s_in_r, s_out_l, s_out_r);

	input clk, rst, par_ser, shftr_l, s_in_l, s_in_r;
	input [N-1:0] p_in;
	
	output s_out_l, s_out_r;
	output reg [N-1:0] p_out;

	assign s_out_l = p_out[N-1];
	assign s_out_r = p_out[0];
	
	always @(posedge clk)
	begin
		if (rst)
			p_out <= 0;
		else
			if (par_ser)
				p_out <= p_in;
			else
				if (shftr_l)
					p_out <= {s_in_l, p_out[N-1:1]};
				else
					p_out <= {p_out[N-2:0], s_in_r};
		
	end

endmodule

/// 8-Bit ALU ///
/////////////////

module alu(A, B, I, F, C_out, OVF, Z, N);

	input [7:0] A;
	input [7:0] B;
	input [2:0] I;

	output reg C_out, OVF, Z, N;
	output reg [7:0] F;

always @(A, B, I)
	begin
	case(I)
		3'b000:	begin
					{C_out, F} = A + B;
					if (A[7] ~^ B[7])
						OVF = F[7] ^ A[7];
					else
						OVF = 0;
					end
		3'b001:	begin
					{C_out, F} = A - B;
					if ((A[7] ^ B[7]))
						OVF = F[7] ^ A[7];
					else
						OVF = 0;
					end
		3'b010:	begin
					F = A & B;
					C_out = 0;
					OVF = 0;
					end
		3'b011:	begin
					F = A | B;
					C_out = 0;
					OVF = 0;
					end
		3'b100:	begin
					F = A ^ B;
					C_out = 0;
					OVF = 0;
					end
		3'b101:	begin
					F = A ~^ B;
					C_out = 0;
					OVF = 0;
					end
		3'b110:	begin
					F = A & (~B);
					C_out = 0;
					OVF = 0;
					end
		3'b111:	begin
					F = A | (~B);
					C_out = 0;
					OVF = 0;
					end
	endcase			
	N = F[7];
	Z = (F == 8'b0);
	end
endmodule

/// 2x1 MUX ///
///////////////
module mux_2x1 #(parameter N=8) (in0, in1, sel, out);

	input [N-1:0] in0, in1;
	input sel;

	output [N-1:0] out;

	assign out = sel ? in1 : in0;

endmodule


/// 4x1 MUX ///
///////////////
module mux_4x1 #(parameter N=8) (in0, in1, in2, in3, sel, out);

	input [N-1:0] in0, in1, in2, in3;
	input [1:0] sel;

	output reg [N-1:0] out;

	always @(in0, in1, in2, in3, sel)
		case(sel)
			2'b00: out = in0;
			2'b01: out = in1;
			2'b10: out = in2;
			2'b11: out = in3;
		endcase

endmodule


/// 2x4 decoder ///
///////////////////
module dec_2x4(A, D);

	input [1:0] A;
	output [3:0] D;

	assign D[3] = A[1] & A[0];
	assign D[2] = A[1] & (~A[0]);
	assign D[1] = (~A[1]) & A[0];
	assign D[0] = (~A[1]) & (~A[0]);

endmodule

