module mux2 #(parameter W=8)(data0, data1, select, out);
	output [(W-1):0] out;
	input [(W-1):0] data0;
	input [(W-1):0] data1;
	input select;
	assign out = (select)?data1:data0;
endmodule