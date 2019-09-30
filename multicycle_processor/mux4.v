module mux4 #(parameter W=8)(D0, D1, D2, D3, select, out);
	input [(W-1):0] D0;
	input [(W-1):0] D1;  
	input [(W-1):0] D2;
	input [(W-1):0] D3;
	input [1:0] select;
	output [(W-1):0] out;
	 
   // 00 -> D1, 01 ->D2, 10 -> c, 11 -> d
   assign out = select[1] ? (select[0] ? D3 : D2) : (select[0] ? D1 : D0); 
 
endmodule
