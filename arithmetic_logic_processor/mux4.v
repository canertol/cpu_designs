module mux4 #(parameter W = 4)( select, mux_in1,mux_in2,mux_in3,mux_in4, mux_out );

	input[1:0] select;
	input[W-1:0] mux_in1,mux_in2,mux_in3,mux_in4;
	output reg [W-1:0] mux_out;
	always @(select, mux_in1,mux_in2,mux_in3,mux_in4)
	begin
		case(select)
			2'b00: mux_out = mux_in1;
			2'b01: mux_out = mux_in2;
			2'b10: mux_out = mux_in3;
			2'b11: mux_out = mux_in4;
		endcase
	end

endmodule