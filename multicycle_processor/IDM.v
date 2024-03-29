module IDM(A, WD, clk, WE, out); 
 input [7:0] WD;                    
 input[7:0] A;
 input clk, WE;
 output [15:0] out;
 reg [15:0] data[63:0]; // 2^6 memory slots
 
 initial begin
 // INSTRUCTION PART /////////////////////////////////////
	data[0] = 16'b11_000_000_00000000; 	 // LDD R0, #0
	data[1] = 16'b11_000_001_00000000; 	 // LDD R1, #0
	data[2] = 16'b11_000_010_00000000; 	 // LDD R2, #0
	data[3] = 16'b11_000_011_00111000; 	 // LDD R3, #56
	data[4] = 16'b11_000_100_00111001; 	 // LDD R4, #57
	data[5] = 16'b11_000_101_00111010; 	 // LDD R5, #58
	data[6] = 16'b00_010_000_000_011_00; // ADDI R0, R0, [R3]
	data[7] = 16'b00_010_001_001_100_00; // ADDI R1, R1, [R4]
	data[8] = 16'b00_010_010_010_101_00; // ADDI R2, R2, [R5]
	data[9] = 16'b11_000_011_10100110; 	 // LDD R3, #8'b10100110; R3 = 0xA6
	 
	data[10] = 16'b10_001_110_00010100;  // BLD #20;  2s Complement
	
	data[11] = 16'b10_001_110_00011011;  // BLD #27;  Sum of an array
	
	data[12] = 16'b11_000_011_01111111;  // LDD R3, #0x7F
	data[13] = 16'b10_001_110_00101000;  // BLD #40;  Odd?
	
	data[14] = 16'b11_000_011_01111110;  // LDD R3, #0x7E
	data[15] = 16'b10_001_110_00101000;  // BLD #40;  Even?
	data[16] = 16'b11_111_111_11111111;  // END
	 
// Subroutine 1 , 2s Complement
	data[20] = 16'b11_000_000_11111111;  // LDD R0, #0xFF
	data[21] = 16'b00_110_011_011_000_00;// XOR R3, R3, R0
	data[22] = 16'b11_000_000_00000001;  // LDD R0, #1
 	data[23] = 16'b00_000_011_011_000_00;// ADD R3, R3, R0
	data[24] = 16'b10_010_110_000_110_00;// BLI LR
		 
// Subroutine 2, Sum of an array
	data[27] = 16'b11_000_000_00000001;   // LDD R0, #1
	data[28] = 16'b11_000_001_00000010;   // LDD R1, #2
	data[29] = 16'b11_000_010_00000011;   // LDD R2, #3
	data[30] = 16'b11_000_100_00000100;   // LDD R4, #4
	data[31] = 16'b11_000_101_00000101;   // LDD R5, #5
	data[32] = 16'b00_000_000_000_001_00; // ADD R0, R1
	data[33] = 16'b00_000_010_010_000_00; // ADD R2, R0
	data[34] = 16'b00_000_100_100_010_00; // ADD R4, R2
	data[35] = 16'b00_000_101_101_100_00; // ADD R5, R4
	data[36] = 16'b11_000_011_00000000;  // LDD R3, #0
   data[37] = 16'b00_000_011_011_101_00; // ADD R3, R5
	data[38] = 16'b10_010_110_000_110_00; // BLI LR
	 
// Subroutine 3, Even/Odd?
	data[40] = 16'b11_000_100_00000001;  // LDD R4, #0x1
	data[41] = 16'b00_100_101_100_011_00;// AND R5, R4, R3
	data[42] = 16'b10_100_00000101100;   // BNE #44
	data[43] = 16'b10_011_00000110010;   // BEQ #50
	 
	 //MEM1
	data[44] = 16'b01_000_011_011_00000; // ROL R3
	data[45] = 16'b01_000_011_011_00000; // ROL R3
	data[46] = 16'b01_000_011_011_00000; // ROL R3
	data[47] = 16'b11_000_100_11110111;  // LDD R4, #0xF7
	data[48] = 16'b00_100_011_011_100_00;// AND R3, R4
	data[49] = 16'b10_010_110_000_110_00;// BLI LR
		
	 //MEM2
	data[50] = 16'b01_000_011_011_00000; // ROL R3
	data[51] = 16'b01_000_011_011_00000; // ROL R3
	data[52] = 16'b11_000_100_01111000;  // LDD R4, #0x78
	data[53] = 16'b00_100_011_011_100_00;// AND R3, R4
	data[54] = 16'b10_010_110_000_110_00;// BLI LR
	 
 // DATA PART /////////////////////////////////////	
   data[56] = 20;
	data[57] = 30;
	data[58] = 40;
	
	data[59] = 4'h0001;
	data[60] = 4'h0002;
	data[61] = 4'h0003;
	data[62] = 4'h0004;
	data[63] = 4'h0005;
 
 end
 
 always @(posedge clk)begin
  if(WE) data[A[7:0]]<= WD;
 end
 
 assign out = data[A[7:0]];
endmodule
 