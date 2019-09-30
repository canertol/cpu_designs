module basic_comp (
	clk,
	set_S, set_FGI, set_FGO,
	FGI_out, FGO_out,
	INPR_in, OUTR_out
);
	input clk, set_S, set_FGI, set_FGO;
	input [7:0] INPR_in;
	output FGI_out, FGO_out, OUTR_out;
	
	wire [15:0] ALU_out;
	wire [15:0] BUS [0:7];
	wire [7:0] INPR_out;
	wire  load_AR, clr_AR, inc_AR,
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
	wire IRQ_out, IEN_out, CARRY, E_out, FGI_out, FGO_out, S_out;
	wire [15:0] AC_out;
	wire [11:0] DR_out;
	wire [2:0] bus_select;		
	wire DR_zero, AC_zero;
	wire [15:0] AR_bus, PC_bus, DR_bus, AC_bus, IR_bus, TR_bus, INPR_bus, OUTR_bus, RAM_bus, BUS_out;
	
	
	assign  BUS[1] = AR_bus;
	assign  BUS[2] = PC_bus;
	assign  BUS[3] = DR_bus;
	assign  BUS[4] = AC_bus;
	assign  BUS[5] = IR_bus;
	assign  BUS[6] = TR_bus;
	assign  BUS[7] = RAM_bus;
	
	assign AC_zero = |AC_out;	
	assign DR_zero = |DR_out;

	
	// REGISTERS AND MEMORY CONTROL
	register #(12) AR(.clk(clk), .in(BUS_out[11:0]), .out(AR_bus[11:0]), .load(load_AC), .clr(clr_AC), .inc(inc_AC));
	register #(12) PC(.clk(clk), .in(BUS_out[11:0]), .out(PC_bus[11:0]), .load(load_PC), .clr(clr_PC), .inc(inc_PC));
	register #(12) DR(.clk(clk), .in(BUS_out[11:0]), .out( DR_bus[11:0]), .load(load_DR), .inc(inc_DR));
	register #(16) AC(.clk(clk), .in(BUS_out[15:0]), .out(AC_bus[15:0]), .load(load_AC), .clr(clr_AC), .inc(inc_AC));
	register #(16) IR(.clk(clk), .in(BUS_out[15:0]), .out(IR_bus[15:0]), .load(load_IR));
	register #(12) TR(.clk(clk), .in(BUS_out[11:0]), .out(TR_bus[11:0]), .load(load_TR));
	register #(8) INPR(.clk(clk), .in(INPR_in), .out(INPR_out));
	register #(8) OUTR(.clk(clk), .in(BUS_out[7:0]), .out(OUTR_out), .load(load_OUTR));
	
	ram #(12,16) RAM(.clk(clk), .addr(),	.r(RAM_r), .w(RAM_w),	.in(RAM_bus), .out(RAM_bus));
		
	ff IRQ(.clk(clk),.out(IRQ_out), .set(set_IRQ), .clr(clr_IRQ));
	ff IEN(.clk(clk),.out(IEN_out), .set(set_IEN), .clr(clr_IEN));
	ff E(.clk(clk), .in(CARRY), .out(E_out),	.load(load_E), .clr(clr_E), .comp(comp_E));
	ff S(.clk(clk),	.out(S_out), .set(set_S), .clr(clr_S)); 
	ff FGI(.clk(clk),	.out(FGI_out), .set(set_FGI), .clr(clr_FGI));
	ff FGO(.clk(clk),	.out(FGO_out), .set(set_FGO), .clr(clr_FGO));
	
	bus #(16,3) common_bus(.select(bus_select), .in(BUS), .out(BUS_out));
	
	alu ALU(	.from_DR(DR_out), .from_INPR(INPR_out), .from_AC(AC_bus), .from_E(E_out),.out(ALU_out), .carry(CARRY),	
				.and_(ALU_and), .add(ALU_add), .comp(ALU_comp), .cir(ALU_cir), .cil(ALU_cil), .trans_dr(ALU_trans_dr), .trans_inpr(ALU_trans_inpr));
	
	control_timing_unit CTU(.clk(clk), .IR(BUS_out[11:0]), .IRQ(IRQ_out), .IEN(IEN_out), .FGI(FGI_out), .FGO(FGO_out), 
									.E(E_out), .AC_MSB(AC_out[15]), .AC_zero(AC_zero), .DR_zero(DR_zero),
									.load_AR(load_AR), .clr_AR(clr_AR), .inc_AR(inc_AR),
									.load_PC(load_PC), .clr_PC(clr_PC), .inc_PC(inc_PC),
									.load_DR(load_DR), .inc_DR(inc_DR),
									.load_AC(load_AC), .clr_AC(clr_AC), .inc_AC(inc_AC),
									.load_IR(load_IR),
									.load_TR(load_TR),
									.load_OUTR(load_OUTR),
									.set_IRQ(set_IRQ), .clr_IRQ(clr_IRQ),
									.set_IEN(set_IEN), .clr_IEN(clr_IEN),
									.load_E(load_E), .clr_E(clr_E), .comp_E(comp_E),
									.clr_S(clr_S),
									.clr_FGI(clr_FGI),
									.clr_FGO(clr_FGO), 
									.ALU_and(ALU_and), .ALU_add(ALU_add), .ALU_comp(ALU_comp), .ALU_cir(ALU_cir), 
									.ALU_cil(ALU_cil), .ALU_trans_dr(ALU_trans_dr), .ALU_trans_inpr(ALU_trans_inpr),
									.RAM_r(RAM_r), .RAM_w(RAM_w), .bus_select(bus_select));

endmodule


/*
 * CPU modules
 */
module control_timing_unit (
	// Inputs
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
	bus_select
);
	// Inputs
	input clk;
	input [15:0] IR;
	input IRQ, IEN, FGI, FGO, E, AC_MSB, AC_zero, DR_zero;

	// Outputs
	output reg load_AR, clr_AR, inc_AR,
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
	output wire [2:0] bus_select;
	wire [3:0] SC_out;
	wire [2:0] IR_14_13_12;
	wire [11:0] IR_11_0;
	wire [15:0] T;
	wire [7:0] D;
	wire I_out, load_I;
	wire clr_SC;
	
	assign IR_14_13_12 = IR[14:12];	
	assign IR_11_0 = IR[11:0];
	
	// I FF
	ff I(.clk(clk),.in(IR[15]), .out(I_out),.load(load_I));
	
	// SC (Sequence counter)
	counter #(4) SC(.clk(clk), .out(SC_out), .clr(clr_SC));
	
	// Decoder for instructions (For D signals)
	decoder #(3) dec3_8(.in(IR_14_13_12), .out(D));
	
	//Decoder for SC (For T signals)
	decoder #(3) dec4_16(.in(SC_out), .out(T));
	
	// Control logic
	control_logic 	control_log(.clk(clk), .D(D), .T(T), .IR(IR_11_0), .I(I_out), .IRQ(IRQ), .IEN(IEN), .FGI(FGI), .FGO(FGO), .E(E), .AC_MSB(AC_MSB), .AC_zero(AC_zero), .DR_zero(DR_zero),
		.load_AR(load_AR), .clr_AR(clr_AR), .inc_AR(inc_AR),
		.load_PC(load_PC), .clr_PC(clr_PC), .inc_PC(inc_PC),
		.load_DR(load_DR), .inc_DR(inc_DR),
		.load_AC(load_AC), .clr_AC(clr_AC), .inc_AC(inc_AC),
		.load_IR(load_IR),
		.load_TR(load_TR),
		.load_OUTR(load_OUTR),
		.load_I(load_I),
		.set_IRQ(set_IRQ), .clr_IRQ(clr_IRQ),
		.set_IEN(set_IEN), .clr_IEN(clr_IEN),
		.load_E(load_E), .clr_E(clr_E), .comp_E(comp_E),
		.clr_S(clr_S),
		.clr_FGI(clr_FGI),
		.clr_FGO(clr_FGO), 
		.clr_SC(clr_SC),
		.ALU_and(ALU_and), .ALU_add(ALU_add), .ALU_comp(ALU_comp), .ALU_cir(ALU_cir), .ALU_cil(ALU_cil), .ALU_trans_dr(ALU_trans_dr), .ALU_trans_inpr(ALU_trans_inpr),
		.RAM_r(RAM_r), .RAM_w(RAM_w),
		.bus_select(bus_select));
endmodule


module control_logic (
	// Inputs
	clk, D, T,
	IR, I, IRQ, IEN, FGI, FGO, E, AC_MSB, AC_zero, DR_zero,
	// Outputs
	load_AR, clr_AR, inc_AR,
	load_PC, clr_PC, inc_PC,
	load_DR, inc_DR,
	load_AC, clr_AC, inc_AC,
	load_IR,
	load_TR,
	load_OUTR,
	load_I,
	set_IRQ, clr_IRQ,
	set_IEN, clr_IEN,
	load_E, clr_E, comp_E,
	clr_S,
	clr_FGI,
	clr_FGO,
	clr_SC,
	ALU_and, ALU_add, ALU_comp, ALU_cir, ALU_cil, ALU_trans_dr, ALU_trans_inpr,
	RAM_r, RAM_w,
	bus_select
);
   // Inputs
	input clk,I, IRQ, IEN, FGI, FGO, E, AC_MSB, AC_zero, DR_zero;
	input [11:0]IR, T; 
	input [7:0] D;
	// Outputs
	output reg load_AR, clr_AR, inc_AR,
	load_PC, clr_PC, inc_PC,
	load_DR, inc_DR,
	load_AC, clr_AC, inc_AC,
	load_IR,
	load_TR,
	load_OUTR,
	load_I,
	set_IRQ, clr_IRQ,
	set_IEN, clr_IEN,
	load_E, clr_E, comp_E,
	clr_S,
	clr_FGI,
	clr_FGO,
	clr_SC,
	ALU_and, ALU_add, ALU_comp, ALU_cir, ALU_cil, ALU_trans_dr, ALU_trans_inpr,
	RAM_r, RAM_w;
	output reg[2:0]bus_select;
	
	always@(posedge clk)
	begin
	if(IRQ==0)
		begin
	//FETCH
		if(T[0]==1) // IRQ'T0 			
			begin
			load_AR <= 1;
			bus_select <= 3'b010;
			end
			
		if(T[1]==1)	// IRQ'T1		
			begin
			RAM_r <= 1;
			bus_select <= 3'b111;
			load_IR <= 1;
			inc_PC <= 1;			
			end
	// DECODE
		if(T[2]==1)	// IRQ'T2			
			begin
			load_I <= 1;
			load_AR <= 1;
			bus_select <= 3'b101;
			end
		if(D[7]==1) 						// D7=1
			begin
				if(I==0)						// D7I'
					begin
					if(T[3]==1)  			// D7I'T3 = r
						begin
						if(IR[11]==1)		// rB11
							clr_AC <= 1;		
							
						if(IR[10]==1)		// rB10
							clr_E <= 1;
							
						if(IR[9]==1)		// rB9
							ALU_comp <= 1;
							
						if(IR[8]==1)		// rB8
							comp_E <= 1;
							
						if(IR[7]==1)		// rB7
							ALU_cir <= 1;
							load_E <= 1;
							
						if(IR[6]==1)		// rB6
							ALU_cil <= 1;
							load_E <= 1;
							
						if(IR[5]==1)		// rB5
							inc_AC <= 1;
							
						if(IR[4]==1)		// rB4
							if(AC_MSB==0)
								inc_PC <= 1;
								
						if(IR[3]==1)		// rB3
							if(AC_MSB==1)
								inc_PC <= 1;
							
						if(IR[2]==1)		// rB2
							if(AC_zero==1)
								inc_PC <= 1;
							
						if(IR[1]==1)		// rB1
							if(E==0)
								inc_PC <= 1;
							
						if(IR[0]==1)
								clr_S <= 1;
						end
					end
							
				else							// D7I
					if(T[3]==1)				// D7IT3 = p
						begin
						clr_S <= 1;
						
						if(IR[11]==1)		// pB11
							ALU_trans_inpr <= 1;
							clr_FGI <= 1;
							load_AC <= 1;
							
						if(IR[10]==1)		// pB10
							clr_FGO <= 1;
							bus_select <= 3'b100;
							load_OUTR <= 1;
							
							
						if(IR[9]==1)		// pB9
							if(FGI==1)
							inc_PC <= 1;
							
							
						if(IR[8]==1)		// pB8
							if(FGO==1)
							inc_PC <= 1;
							
						if(IR[7]==1)		// pB7
							set_IEN <= 1;
							
						if(IR[6]==1)		// pB6
							clr_IEN <= 1;
						end
						
				
			end
		else // D7'
	// INDIRECT
			begin
			if(I==1) // D7'IT3
				begin
				load_AR <= 1;
				bus_select <= 3'b111;
				RAM_r <= 1;
				end
	// MEMORY-REFERENCE			
			if(D[0]==1)						// D0
			begin
				if(T[4]==1)					// D0T4
					begin
					bus_select <= 3'b111;
					RAM_r <= 1;
					load_DR <= 1;
					end
				if(T[5]==1)					// D0T5
					begin
					ALU_and <= 1;
					clr_SC <= 1;
					end
			end
			
			if(D[1]==1)						// D1
				begin
					if(T[4]==1)				// D1T4
						begin
						bus_select <= 3'b111;
						RAM_r <= 1;
						load_DR <= 1;
						end
					if(T[5]==1)				// D1T5
						begin
						ALU_add <= 1;
						clr_SC <= 0;
						end
				end
				
			if(D[2]==1)						// D2
				begin
					if(T[4]==1)				// D2T4
						begin
						bus_select <= 3'b111;
						RAM_r <= 1;
						load_DR <= 1;
						end
					if(T[5]==1)				// D2T5
						begin
						ALU_trans_dr <= 1;
						clr_SC <= 1;
						end
				end
			if(D[3]==1)						// D3
				begin
					if(T[4]==1)				// D3T4
						begin
						bus_select <= 3'b100;
						clr_SC <= 1;
						RAM_w <= 1;
						end
				end
			if(D[4]==1)						// D4
			begin
				if(T[4]==1)					// D4T4
				begin
				load_PC <= 1;
				clr_SC <= 1;
				bus_select <= 3'b001;
				end				
			end
			if(D[5]==1)						// D5
			begin
				if(T[4]==1)					// D5T5
					begin
					bus_select <= 3'b010;
					RAM_w <= 1;
					inc_AR <=1;
					end	
				if(T[5]==1)					// D5T5
					begin
					bus_select <= 3'b001;
					load_PC <= 1;
					clr_SC <= 1;
					end
			end
			if(D[6]==1)						// D6
			begin
				if(T[4]==1)					// D6T4
					begin
					bus_select <= 3'b111;
					RAM_r <= 1;
					load_DR <= 1;
					end
				if(T[5]==1)					// D6T5
					begin
					inc_DR <= 1;
					end
				if(T[6]==1)					// D6T6
					begin
					bus_select <= 3'b011;
					RAM_w <= 1;
						if(DR_zero==1)
							begin
							inc_PC <= 1;
							end
					clr_SC <= 1;
					end
			end				
		end
			
			
		
		
		
		//if(D[7]~=0 && I==1 && T[3]==1) // D7'IT3
		if(T[0]!=0 && T[1]!=0 && T[2]!=0 && IEN && (FGI || FGO)) // T0'T1'T2'(IEN)(FGI + FGO)
			begin
			set_IRQ <= 1;
			end
		end
	else	// IRQ
	// INTERRUPT
		begin
		if(T[0]) // IRQ T0
			begin
			clr_AR <= 1;
			bus_select <= 3'b010;
			load_TR <= 1;			
			end
		
		if(T[1]) // IRQ T1
			begin
			clr_PC <= 1;
			bus_select <= 3'b110;
			RAM_w <= 1;
			end
		
		
		if(T[2]) // IRQ T2
			begin
			inc_PC <= 1;
			clr_IEN <= 1;
			clr_IRQ <= 1;
			clr_SC <= 1;
			end
		end
	
	
	
	end
	/* FILL HERE */

endmodule


module alu (
	// Inputs
	from_DR, from_INPR, from_AC, from_E,
	// Outputs
	out, carry,
	// Signals
	and_, add, comp, cir, cil, trans_dr, trans_inpr
);
	// Inputs
	input [15:0]from_DR;
	input [7:0] from_INPR;
	input [15:0]from_AC;
	input from_E;
	// Outputs
	output reg[15:0] out;
	output reg carry;
	// Signals
	input and_, add, comp, cir, cil, trans_dr, trans_inpr;
	
	always@(*)
	begin
		begin
			out <= from_AC & from_DR;
		
		end
		if(add)
		begin
			{carry,out} <= from_AC + from_DR;
			
		end
		if(comp)
		begin
			carry <= ~from_E;

		end
		if(cir)
		begin
			carry 	<= from_AC[0];
			out 		<= from_AC>>1;
			out[15]  <= from_E;

		end
		if(cil)
		begin
			carry <= from_AC[15];
			out   <= from_AC<<1;
			out[0]<= from_E;

		end
		if(trans_dr)
		begin
			out <= from_DR;

		end
		if(trans_inpr)
		begin
		out[7:0] <= from_INPR;

	end
	end
	/* FILL HERE */

endmodule


/*
 * Basic modules
 */
 module register #(parameter WIDTH = 8) (
	clk,
	in, out,
	load, clr, inc
);
 	input clk;
	input [WIDTH-1:0] in;
	output reg [WIDTH-1:0] out;
	input load, clr, inc;

	initial
	begin
		out = {WIDTH{1'b0}};
	end

	always @(posedge clk)
	begin
		if (load)
			out <= in;
		else if (clr)
			out <= {WIDTH{1'b0}};
		else if (inc)
			out <= out + {{WIDTH-1{1'b0}}, 1'b1};
	end
endmodule


module ff (
	clk,
	in, out,
	load, set, clr, comp
);
	input clk;
	input in;
	output reg out;
	input load, set, clr, comp;

	initial
	begin
		out = 1'b0;
	end

	always @(posedge clk)
	begin
		if (load)
			out <= in;
		else if (set)
			out <= 1'b1;
		else if (clr)
			out <= 1'b0;
		else if (comp)
			out <= ~out;
	end
endmodule


module counter #(parameter WIDTH = 4) (
	clk,
	out,
	clr
);
	input clk;
	output reg [WIDTH-1:0] out;
	input clr;

	initial
	begin
		out = {WIDTH{1'b0}};
	end

	always @(posedge clk)
	begin
		if (clr)
			out <= {WIDTH{1'b0}};
		else
			out <= out + {{WIDTH-1{1'b0}}, 1'b1};
	end
endmodule


module decoder #(parameter IN_WIDTH = 3) (
	in, out
);
	input [IN_WIDTH-1:0] in;
	output reg [(1<<IN_WIDTH)-1:0] out;

	always @(in)
	begin
		out = {(1<<IN_WIDTH){1'b0}};
		out[in] = 1'b1;
	end

endmodule


module encoder #(parameter OUT_WIDTH = 3) (
	in,	out
);
	input [(1<<OUT_WIDTH)-1:0] in;
	output reg [OUT_WIDTH-1:0] out;

	integer i;
	always @(in)
	begin
		out = {OUT_WIDTH{1'b0}};
		for (i=(1<<OUT_WIDTH)-1; i>=0; i=i-1)
			if (in[i]) out = i;
	end
endmodule


module bus #(parameter DATA_WIDTH = 16, SELECT_WIDTH = 3) (
	select,
	in, out
);
	input [SELECT_WIDTH-1:0] select;
	input [DATA_WIDTH-1:0] in [0:(1<<SELECT_WIDTH)-1];
	output reg [DATA_WIDTH-1:0] out;

	always @(*)
	begin
		out = in[select];
	end
endmodule


module ram #(parameter ADDR_WIDTH = 12, DATA_WIDTH = 16) (
	clk,
	addr,
	r, w,
	in, out
);
	input clk;
	input [ADDR_WIDTH-1:0] addr;
	input r;
	input w;
	input [DATA_WIDTH-1:0] in;
	output [DATA_WIDTH-1:0] out;

	reg [DATA_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];

	assign out = r ? memory[addr] : {DATA_WIDTH{1'bz}};

	always @(posedge clk)
		if (w)
			memory[addr] <= in;

endmodule
