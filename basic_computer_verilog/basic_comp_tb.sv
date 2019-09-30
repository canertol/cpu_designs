module basic_comp_tb();
 
	reg clk, set_S, set_FGI, set_FGO;
	wire FGI_out, FGO_out;
	reg [8:0] INPR_in, OUTR_out;
 
  basic_comp DUT(clk, set_S, set_FGI, set_FGO,
	FGI_out, FGO_out,
	INPR_in, OUTR_out);
 
  always // no sensitivity list, so it always executes
	begin
	clk <= 1; 
	#5;
	clk <= 0;
 	#5;
	end	
  
  initial begin
		set_S <= 1'b0;
		set_FGI <= 1'b0;
		set_FGO <= 1'b0;
		INPR_in <= 2'h00;
			
  end
  initial begin
		// Input
		set_FGI <= 1'b1;
		set_FGO <= 1'b0;
		INPR_in <= 2'hAB;
		#20;
		// Output
		set_FGI <= 1'b0;
		set_FGO <= 1'b1;
		INPR_in <= 2'hAB;
		#20;
		
  end
 
endmodule

module ALU_tb();
	//Inputs
	reg [15:0]from_DR;
	reg [7:0] from_INPR;
	reg [15:0]from_AC;
	reg from_E;
	// Outputs
	reg [15:0] out;
	reg carry;
	// Signals
	reg and_, add, comp, cir, cil, trans_dr, trans_inpr;
	


	alu DUT(
		// Inputs
		from_DR, from_INPR, from_AC, from_E,
		// Outputs
		out, carry,
		// Signals
		and_, add, comp, cir, cil, trans_dr, trans_inpr
	);
		 
		 
		 initial begin
			from_DR <= 16'hAAAA;
			#10;
			from_INPR <= 8'hCA;
			#10;
			from_AC <= 16'hBBBB;
			#10;
			from_E <= 1'b1;
			#10;
		// AND
			and_ <= 1'b1;
			add  <= 1'b0;
			comp <= 1'b0;
			cir  <= 1'b0;
			cil  <= 1'b0;
			trans_dr <= 1'b0;
			trans_inpr <= 1'b0;
			#20;
		// ADD
			and_ <= 1'b0;
			add  <= 1'b1;
			comp <= 1'b0;
			cir  <= 1'b0;
			cil  <= 1'b0;
			trans_dr <= 1'b0;
			trans_inpr <= 1'b0;
			#20;
		 // COMP
			and_ <= 1'b0;
			add  <= 1'b0;
			comp <= 1'b1;
			cir  <= 1'b0;
			cil  <= 1'b0;
			trans_dr <= 1'b0;
			trans_inpr <= 1'b0;
			#20;
		// CIR	
			and_ <= 1'b0;
			add  <= 1'b0;
			comp <= 1'b0;
			cir  <= 1'b1;
			cil  <= 1'b0;
			trans_dr <= 1'b0;
			trans_inpr <= 1'b0;
			#20;
		// CIL	
			and_ <= 1'b0;
			add  <= 1'b0;
			comp <= 1'b0;
			cir  <= 1'b0;
			cil  <= 1'b1;
			trans_dr <= 1'b0;
			trans_inpr <= 1'b0;
			#20;
		// TRANS_DR	
			and_ <= 1'b0;
			add  <= 1'b0;
			comp <= 1'b0;
			cir  <= 1'b0;
			cil  <= 1'b0;
			trans_dr <= 1'b1;
			trans_inpr <= 1'b0;
			#20;
		// TRANS_INPR	
			and_ <= 1'b0;
			add  <= 1'b0;
			comp <= 1'b0;
			cir  <= 1'b0;
			cil  <= 1'b0;
			trans_dr <= 1'b0;
			trans_inpr <= 1'b1;
			#20;
		 
		 end
		
endmodule

module control_timing_unit_tb();
	
			// Inputs
			reg [15:0] IR;
			reg clk;
			reg [3:0] SC_out;
			reg [15:0] T;
			reg [7:0] D;
			reg I_out, load_I;
			reg IRQ, IEN, FGI, FGO, E, AC_MSB, AC_zero, DR_zero;

			// Outputs
			reg load_AR, clr_AR, inc_AR,
			load_PC, clr_PC, inc_PC,
			load_DR, inc_DR,
			load_AC, clr_AC, inc_AC,
			load_IR,
			load_TR,
			load_OUTR,
			set_IRQ, clr_IRQ,
			set_IEN, clr_IEN,
			load_E, clr_E, comp_E,
			clr_S,
			clr_FGI,
			clr_FGO,
			ALU_and, ALU_add, ALU_comp, ALU_cir, ALU_cil, ALU_trans_dr, ALU_trans_inpr,
			RAM_r, RAM_w;
			reg [2:0] bus_select;

	control_timing_unit DUT(// Inputs
			clk, IR,
			IRQ, IEN, FGI, FGO, E, AC_MSB, AC_zero, DR_zero,

			// Outputs
			load_AR, clr_AR, inc_AR,
			load_PC, clr_PC, inc_PC,
			load_DR, inc_DR,
			load_AC, clr_AC, inc_AC,
			load_IR,
			load_TR,
			load_OUTR,
			set_IRQ, clr_IRQ,
			set_IEN, clr_IEN,
			load_E, clr_E, comp_E,
			clr_S,
			clr_FGI,
			clr_FGO,
			ALU_and, ALU_add, ALU_comp, ALU_cir, ALU_cil, ALU_trans_dr, ALU_trans_inpr,
			RAM_r, RAM_w,
			bus_select);
			
			  always // no sensitivity list, so it always executes
				begin
				clk <= 1; 
				#5;
				clk <= 0;
				#5;
				end	
						
				
			initial begin
		// REGISTER REFERENCE INSTRUCTIONS
			IR <= 16'h7800; // CLA
			#10;
			IR <= 16'h7400; // CLE
			#10;
			IR <= 16'h7200; // CMA
			#10;
			IR <= 16'h7100; // CME
			#10;
			IR <= 16'h7080; // CIR
			#10;
			IR <= 16'h7040; // CIL
			#10;
			IR <= 16'h7020; // INC
			#10;
			IR <= 16'h7010; // SPA
			#10;
			IR <= 16'h7008; // SNA
			#10;
			IR <= 16'h7004; // SZA
			#10;
			IR <= 16'h7002; // SZE
			#10;
			IR <= 16'h7001; // HLT
			#10;
		// I/O operations	
			IR <= 16'hF800; // INP
			#10;
			IR <= 16'hF400; // OUT
			#10;
			IR <= 16'hF200; // SKI
			#10;
			IR <= 16'hF100; // SKO
			#10;
			IR <= 16'hF080; // ION
			#10;
			IR <= 16'hF040; // IOF
			#10;
			
		// OTHERS
			
			IR <= 16'h0800; // AND direct
			#10;
			IR <= 16'h8800; // AND indirect
			#10;
			IR <= 16'h1400; // ADD direct
			#10;
			IR <= 16'h9400; // ADD indirect
			#10;
			IR <= 16'h2200; // LDA direct
			#10;
			IR <= 16'hA200; // LDA indirect
			#10;
			IR <= 16'h3100; // STA direct
			#10;
			IR <= 16'h3100; // STA indirect
			#10;
			IR <= 16'h4080; // BUN direct
			#10;
			IR <= 16'hC080; // BUN indirect
			#10;
			IR <= 16'h5040; // BSA direct
			#10;
			IR <= 16'hD040; // BSA indirect
			#10;
			IR <= 16'h6040; // ISZ direct
			#10;
			IR <= 16'hE040; // ISZ indirect
			#10;
			end

	

endmodule
