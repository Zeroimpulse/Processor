`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:58 02/16/2012 
// Design Name: 
// Module Name:    TopLevel 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TopLevel(
    input start,
	 input CLK,
    output halt,
	 output wire [2:0] WriteReg,
    output [15:0] WriteVal,
    output REGWRITE,
    output MEMWRITE,
	 output MEMREAD,
	 output [2:0] ALUOP,
	 output [1:0] ALUSRC,
	 output [2:0] REGSRC,
	 output [1:0] REGDST,
	 output [1:0] REGWRITESRC,
	 output BEQ,
	 output JUMP,
	 output JR,
	 output lmhw,
	 output isZero,
    output [15:0] PC,
	 output BRANCH,
	 output ZERO,
	 output BRANCHING,
	 output [15:0] ALUOut,
	 output [15:0] SPAddress,
	 output [15:0] SPPlusOne,
	 output [15:0] MemOut,
	 output [15:0] Target,
	 output [2:0] RegA,
	 output [2:0] RegB,
	 output [15:0] ReadA,
	 output [15:0] ReadB,
	 output [15:0] LoadValue,
	 output [15:0] RegFive,
	 
    output reg [15:0] InstCounter,
	 output wire [9:0] Instruction
    );


	// control signals not defined as outputs
/*	 wire MEMREAD,HALT;
	 wire [2:0] ALUOP;
	 wire ALUSRC,BEQ,JUMP,JR,LMHW;
	 wire [2:0] REGSRC;
	 wire [1:0] REGDST;
	 wire [1:0] REGWRITESRC;
*/
	 // ALU outputs
	 /*
	 wire ZERO,BRANCHING;
	 wire [15:0] ALUOut;
	 wire [15:0] SPAddress;
	 
	 
	 // Data mem wires
	 wire [15:0] MemOut;
	 
	 // IF module inputs
	 wire [15:0] Target;
	 
	 //Register File Inputs
	 wire [2:0] RegA;
	 wire [2:0] RegB;
	 
	 // Register File outputs
	 
	 wire [15:0] ReadA;
	 wire [15:0] ReadB;
	 wire [15:0] LoadValue;
*/
	 
	 // assign input to memory
	 //assign memWriteValue = ReadB;

	 // Fetch Module (really just PC, we could have incorporated InstRom here as well)
	 IF if_module (
		.Target(Target), //possible Branch address
		.Init(start), 
		.Halt(halt), 
		.CLK(CLK), 
		.PC(PC) //current PC
	);

	// instruction ROM
	SearchInstRom inst_module(
	.InstAddress(PC), 
	.InstOut(Instruction)
	);

	// Control module
	Control control_module (
		.OPCODE(Instruction[9:6]),
		.FUNCTION (Instruction[2:0]),
		.ALU_OP(ALUOP), 
		.ALU_SRC(ALUSRC), 
		.REG_WRITE(REGWRITE), 
		.BRANCH(BRANCH), 
		.BEQ(BEQ),
		.MEM_WRITE(MEMWRITE), 
		.MEM_READ(MEMREAD), 
		.REG_DST(REGDST), 
		.isZero(isZero),
		.HALT(halt),
		.JUMP(JUMP),
		.JR(JR),
		.LMHW(LMHW),
		.REGWRITESRC(REGWRITESRC),
		.REG_SRC(REGSRC)
	);
	
	Reg_File_Input_Muxes Muxes (
		.RegASrc(REGSRC),
		.BEQ(BEQ),
		.RegWriteSrc(REGWRITESRC),
		.RegDst(REGDST),
		.lmhw(LMHW),
		.rs(Instruction[5:3]),
		.rt(Instruction[2:0]),
		.ALUOut(ALUOut), //----
		.MemOut(MemOut), //---
		.SPAddress(SPPlusOne), //---
		.PC(PC),  //
		.RegFive(RegFive),
		.ReadA(RegA),
		.ReadB(RegB),
		.WriteReg(WriteReg),
		.WriteValue(WriteVal)
	 );

	reg_file register_module (
		.CLK(CLK), 
		.RegWrite(REGWRITE), 
		.srcA(RegA), 
		.srcB(RegB), 
		.writeReg(WriteReg), 	  // mux above
		.writeValue(WriteVal),
		.ReadA(ReadA), 
		.ReadB(ReadB),
		.LoadValue(LoadValue),
		.RegFive(RegFive),
		.SPAddress(SPAddress)
	);
	
	
	ALU ALU_Module ( 
		.OP(ALUOP), 
		.INPUTA(ReadA), 
		.INPUTB(ReadB),
		.OUT(ALUOut), 
		.SP(SPAddress),
		.LoadValue(LoadValue),
		.IMM({{13{Instruction[2]}},Instruction[2:0]}),
		.ALUsrc(ALUSRC),
		.BRANCH(BRANCH),
		.BRANCHING(BRANCHING),
		.SPAddress(SPPlusOne)
	);
	
	ALU_Branch ALU_branch_module	(
		.RS(ReadA),
		.imm(Instruction[5:0]),
		.PC(PC),
		.JUMP(JUMP),
		.BRANCH(BRANCHING),
		.jr_control(JR),
		.BEQ(BEQ),
		.isZero(isZero),
		.OUT(Target)
	);

	DataMemory Data_Module(
		.DataAddress(ALUOut), 
		.MemRead(MEMREAD), 
		.MemWrite(MEMWRITE),
		.DataIn(ReadA), 
		.DataOut(MemOut), 
		.CLK(CLK)
	);
	
	// might help debug
	
	always@(posedge CLK)
	begin
	if (~halt)
		$display("PC = ", PC, ", InstCounter = ", InstCounter);
	end
	
	
	always@(posedge CLK)
	if (start == 1)
		InstCounter = 0;
	else if(halt == 0)
		InstCounter = InstCounter+1;

endmodule