// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Mon May 06 23:01:48 2019"

module multicycle(
	reset,
	clock,
	zeroflag,
	IRegen,
	RegWrite,
	carry,
	FlgWrite,
	pcEN,
	IDMWrite,
	IDMSrc,
	ASrc0,
	RD2en,
	ALUCtrl,
	ASrc1,
	BSrc,
	Instr,
	LR,
	next_state,
	PCout,
	R0,
	R1,
	R2,
	R3,
	R4,
	R5,
	RegSrc,
	ShiftCtrl,
	state,
	ToReg
);


input wire	reset;
input wire	clock;
output wire	zeroflag;
output wire	IRegen;
output wire	RegWrite;
output wire	carry;
output wire	FlgWrite;
output wire	pcEN;
output wire	IDMWrite;
output wire	IDMSrc;
output wire	ASrc0;
output wire	RD2en;
output wire	[2:0] ALUCtrl;
output wire	[1:0] ASrc1;
output wire	[1:0] BSrc;
output wire	[15:0] Instr;
output wire	[7:0] LR;
output wire	[3:0] next_state;
output wire	[7:0] PCout;
output wire	[7:0] R0;
output wire	[7:0] R1;
output wire	[7:0] R2;
output wire	[7:0] R3;
output wire	[7:0] R4;
output wire	[7:0] R5;
output wire	[1:0] RegSrc;
output wire	[2:0] ShiftCtrl;
output wire	[3:0] state;
output wire	[7:0] ToReg;

wire	C;
wire	carry_ALTERA_SYNTHESIZED;
wire	CLK;
wire	DRegen;
wire	FlgWrite_ALTERA_SYNTHESIZED;
wire	[15:0] IDM;
wire	[15:0] Instr_ALTERA_SYNTHESIZED;
wire	RD2en_ALTERA_SYNTHESIZED;
wire	RST;
wire	Z;
wire	zero;
wire	SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_45;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_46;
wire	[0:7] SYNTHESIZED_WIRE_4;
wire	[1:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	[7:0] SYNTHESIZED_WIRE_47;
wire	[7:0] SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	[7:0] SYNTHESIZED_WIRE_48;
wire	SYNTHESIZED_WIRE_20;
wire	[7:0] SYNTHESIZED_WIRE_49;
wire	[7:0] SYNTHESIZED_WIRE_22;
wire	[1:0] SYNTHESIZED_WIRE_25;
wire	[7:0] SYNTHESIZED_WIRE_26;
wire	[7:0] SYNTHESIZED_WIRE_27;
wire	[0:7] SYNTHESIZED_WIRE_28;
wire	[7:0] SYNTHESIZED_WIRE_29;
wire	[1:0] SYNTHESIZED_WIRE_30;
wire	[7:0] SYNTHESIZED_WIRE_31;
wire	[2:0] SYNTHESIZED_WIRE_32;
wire	[7:0] SYNTHESIZED_WIRE_33;
wire	SYNTHESIZED_WIRE_34;
wire	[7:0] SYNTHESIZED_WIRE_35;
wire	SYNTHESIZED_WIRE_36;
wire	SYNTHESIZED_WIRE_39;
wire	[7:0] SYNTHESIZED_WIRE_40;
wire	[7:0] SYNTHESIZED_WIRE_41;
wire	SYNTHESIZED_WIRE_42;
wire	[2:0] SYNTHESIZED_WIRE_43;

assign	IRegen = SYNTHESIZED_WIRE_42;
assign	RegWrite = SYNTHESIZED_WIRE_9;
assign	pcEN = SYNTHESIZED_WIRE_0;
assign	IDMWrite = SYNTHESIZED_WIRE_39;
assign	IDMSrc = SYNTHESIZED_WIRE_36;
assign	ASrc0 = SYNTHESIZED_WIRE_6;
assign	ALUCtrl = SYNTHESIZED_WIRE_32;
assign	ASrc1 = SYNTHESIZED_WIRE_5;
assign	BSrc = SYNTHESIZED_WIRE_30;
assign	PCout = SYNTHESIZED_WIRE_46;
assign	RegSrc = SYNTHESIZED_WIRE_25;
assign	ShiftCtrl = SYNTHESIZED_WIRE_43;
assign	ToReg = SYNTHESIZED_WIRE_45;
assign	SYNTHESIZED_WIRE_4 = 0;
assign	SYNTHESIZED_WIRE_20 = 1;
assign	SYNTHESIZED_WIRE_28 = 0;
assign	SYNTHESIZED_WIRE_34 = 1;
PC	b2v_inst000(
	.CLK(CLK),
	.RST(RST),
	.EN(SYNTHESIZED_WIRE_0),
	.NEXT(SYNTHESIZED_WIRE_45),
	.CURRENT(SYNTHESIZED_WIRE_46));
	defparam	b2v_inst000.W = 8;


mux4	b2v_inst1(
	.D0(SYNTHESIZED_WIRE_2),
	.D1(SYNTHESIZED_WIRE_46),
	
	.D3(SYNTHESIZED_WIRE_4),
	.select(SYNTHESIZED_WIRE_5),
	.out(SYNTHESIZED_WIRE_31));
	defparam	b2v_inst1.W = 8;


mux2	b2v_inst10(
	.select(SYNTHESIZED_WIRE_6),
	.data0(SYNTHESIZED_WIRE_47),
	.data1(SYNTHESIZED_WIRE_8),
	.out(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst10.W = 8;


REG_FILE	b2v_inst11(
	.RST(RST),
	.CLK(CLK),
	.WE3(SYNTHESIZED_WIRE_9),
	.RA1(Instr_ALTERA_SYNTHESIZED[7:5]),
	.RA2(Instr_ALTERA_SYNTHESIZED[4:2]),
	.WA3(Instr_ALTERA_SYNTHESIZED[10:8]),
	.WD3(SYNTHESIZED_WIRE_45),
	.R0(R0),
	.R1(R1),
	.R2(R2),
	.R3(R3),
	.R4(R4),
	.R5(R5),
	.R6(LR),
	.RD1(SYNTHESIZED_WIRE_35),
	.RD2(SYNTHESIZED_WIRE_48),
	.RDstr(SYNTHESIZED_WIRE_41));


FLAG_REG	b2v_inst11111(
	.clk(CLK),
	.in(Z),
	.EN(FlgWrite_ALTERA_SYNTHESIZED),
	.out(zero));


control_unit	b2v_inst12(
	.RST(RST),
	.CLK(CLK),
	.Z(zero),
	.C(carry_ALTERA_SYNTHESIZED),
	.Op(Instr_ALTERA_SYNTHESIZED[15:11]),
	.IDMWrite(SYNTHESIZED_WIRE_39),
	.IRegen(SYNTHESIZED_WIRE_42),
	.DRegen(DRegen),
	.IDMSrc(SYNTHESIZED_WIRE_36),
	.ASrc0(SYNTHESIZED_WIRE_6),
	.RegWrite(SYNTHESIZED_WIRE_9),
	.PCen(SYNTHESIZED_WIRE_0),
	.FlgWrite(FlgWrite_ALTERA_SYNTHESIZED),
	.RD2en(RD2en_ALTERA_SYNTHESIZED),
	.ALUCtrl(SYNTHESIZED_WIRE_32),
	.ASrc1(SYNTHESIZED_WIRE_5),
	.BSrc(SYNTHESIZED_WIRE_30),
	.next_state(next_state),
	.RegSrc(SYNTHESIZED_WIRE_25),
	.Shift(SYNTHESIZED_WIRE_43),
	.state(state));
	defparam	b2v_inst12.S0 = 4'b0000;
	defparam	b2v_inst12.S1 = 4'b0001;
	defparam	b2v_inst12.S10 = 4'b1010;
	defparam	b2v_inst12.S11 = 4'b1011;
	defparam	b2v_inst12.S12 = 4'b1100;
	defparam	b2v_inst12.S13 = 4'b1101;
	defparam	b2v_inst12.S14 = 4'b1110;
	defparam	b2v_inst12.S15 = 4'b1111;
	defparam	b2v_inst12.S2 = 4'b0010;
	defparam	b2v_inst12.S3 = 4'b0011;
	defparam	b2v_inst12.S4 = 4'b0100;
	defparam	b2v_inst12.S5 = 4'b0101;
	defparam	b2v_inst12.S6 = 4'b0110;
	defparam	b2v_inst12.S7 = 4'b0111;
	defparam	b2v_inst12.S8 = 4'b1000;
	defparam	b2v_inst12.S9 = 4'b1001;


FLAG_REG	b2v_inst13(
	.clk(CLK),
	.in(C),
	.EN(FlgWrite_ALTERA_SYNTHESIZED),
	.out(carry_ALTERA_SYNTHESIZED));


DATA_REG	b2v_inst14(
	.clk(CLK),
	.EN(RD2en_ALTERA_SYNTHESIZED),
	.in(SYNTHESIZED_WIRE_48),
	.out(SYNTHESIZED_WIRE_26));


DATA_REG	b2v_inst17(
	.clk(CLK),
	.EN(SYNTHESIZED_WIRE_20),
	.in(SYNTHESIZED_WIRE_49),
	.out(SYNTHESIZED_WIRE_22));


mux4	b2v_inst18(
	.D0(SYNTHESIZED_WIRE_22),
	.D1(Instr_ALTERA_SYNTHESIZED[7:0]),
	.D2(SYNTHESIZED_WIRE_49),
	.D3(SYNTHESIZED_WIRE_48),
	.select(SYNTHESIZED_WIRE_25),
	.out(SYNTHESIZED_WIRE_45));
	defparam	b2v_inst18.W = 8;


mux4	b2v_inst19(
	.D0(SYNTHESIZED_WIRE_26),
	.D1(SYNTHESIZED_WIRE_27),
	.D2(SYNTHESIZED_WIRE_28),
	.D3(SYNTHESIZED_WIRE_29),
	.select(SYNTHESIZED_WIRE_30),
	.out(SYNTHESIZED_WIRE_33));
	defparam	b2v_inst19.W = 8;


ALU	b2v_inst2(
	.A(SYNTHESIZED_WIRE_31),
	.ALUCtrl(SYNTHESIZED_WIRE_32),
	.B(SYNTHESIZED_WIRE_33),
	.co(C),
	.z(Z),
	.out(SYNTHESIZED_WIRE_49));
	defparam	b2v_inst2.W = 8;


DATA_REG	b2v_inst21(
	.clk(CLK),
	.EN(SYNTHESIZED_WIRE_34),
	.in(SYNTHESIZED_WIRE_35),
	.out(SYNTHESIZED_WIRE_47));




mux2	b2v_inst3(
	.select(SYNTHESIZED_WIRE_36),
	.data0(SYNTHESIZED_WIRE_46),
	.data1(SYNTHESIZED_WIRE_45),
	.out(SYNTHESIZED_WIRE_40));
	defparam	b2v_inst3.W = 8;


IDM	b2v_inst4(
	.clk(CLK),
	.WE(SYNTHESIZED_WIRE_39),
	.A(SYNTHESIZED_WIRE_40),
	.WD(SYNTHESIZED_WIRE_41),
	.out(IDM));


INST_REG	b2v_inst5(
	.clk(CLK),
	.EN(SYNTHESIZED_WIRE_42),
	.in(IDM),
	.out(Instr_ALTERA_SYNTHESIZED));


DATA_REG	b2v_inst6(
	.clk(CLK),
	.EN(DRegen),
	.in(IDM[7:0]),
	.out(SYNTHESIZED_WIRE_29));



CONSTANT	b2v_inst8(
	.bus_in(SYNTHESIZED_WIRE_27));
	defparam	b2v_inst8.V = 1;
	defparam	b2v_inst8.W = 8;


SHIFT	b2v_inst9(
	.control(SYNTHESIZED_WIRE_43),
	.data(SYNTHESIZED_WIRE_47),
	.out(SYNTHESIZED_WIRE_8));

assign	zeroflag = zero;
assign	CLK = clock;
assign	RST = reset;
assign	carry = carry_ALTERA_SYNTHESIZED;
assign	FlgWrite = FlgWrite_ALTERA_SYNTHESIZED;
assign	RD2en = RD2en_ALTERA_SYNTHESIZED;
assign	Instr = Instr_ALTERA_SYNTHESIZED;

endmodule
