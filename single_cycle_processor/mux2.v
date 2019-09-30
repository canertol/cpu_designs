module mux2 #(parameter W = 4)( select, mux_in1, mux_in2, mux_out );

input 	  select;
input[W-1:0] mux_in1, mux_in2;
output wire [W-1:0] mux_out;

assign mux_out = select ? mux_in2 : mux_in1;

endmodule