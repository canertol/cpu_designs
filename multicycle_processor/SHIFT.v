module SHIFT (data, control,out);
	input [2:0]control;
	input signed [7:0]data;
	output [7:0]out;
	reg [7:0]out;

always @(*)
	begin
		if(control[2:0]==3'b000)
		out = {data[6:0],data[7]} ;	

		else if(control[2:0]==3'b001)
		out = {data[0],data[7:1]} ;	
		
		else if(control[2:0]==3'b010)
		out = data << 1 ;	
		
		else if(control[2:0]==3'b011)
		out = data >>> 1 ;	
			
		else if (control[2:0]==3'b100)
		out = data >> 1;
	end
endmodule