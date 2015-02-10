`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:01:31 04/14/2013
// Design Name:   TopLevel
// Module Name:   C:/Users/Owner/Desktop/Processor 2nd/Lab2_2nd/TopLevel_newTB.v
// Project Name:  Lab2_2nd
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TopLevel
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TopLevel_newTB;

	// Inputs
	reg start;
	reg CLK;

	// Outputs
	wire halt;
	wire [2:0] WriteReg;
	wire [15:0] WriteVal;
	wire REGWRITE;
	wire MEMWRITE;
	wire MEMREAD;
	wire [2:0] ALUOP;
	wire [1:0] ALUSRC;
	wire [2:0] REGSRC;
	wire [1:0] REGDST;
	wire [1:0] REGWRITESRC;
	wire BEQ;
	wire JUMP;
	wire JR;
	wire lmhw;
	wire isZero;
	wire [15:0] PC;
	wire BRANCH;
	wire ZERO;
	wire BRANCHING;
	wire [15:0] ALUOut;
	wire [15:0] SPAddress;
	wire [15:0] SPPlusOne;
	wire [15:0] MemOut;
	wire [15:0] Target;
	wire [2:0] RegA;
	wire [2:0] RegB;
	wire [15:0] ReadA;
	wire [15:0] ReadB;
	wire [15:0] LoadValue;
	wire [15:0] RegFive;
	wire [15:0] InstCounter;
	wire [9:0] Instruction;

	// Instantiate the Unit Under Test (UUT)
	TopLevel uut (
		.start(start), 
		.CLK(CLK), 
		.halt(halt), 
		.WriteReg(WriteReg), 
		.WriteVal(WriteVal), 
		.REGWRITE(REGWRITE), 
		.MEMWRITE(MEMWRITE), 
		.MEMREAD(MEMREAD), 
		.ALUOP(ALUOP), 
		.ALUSRC(ALUSRC), 
		.REGSRC(REGSRC), 
		.REGDST(REGDST), 
		.REGWRITESRC(REGWRITESRC), 
		.BEQ(BEQ), 
		.JUMP(JUMP), 
		.JR(JR), 
		.lmhw(lmhw), 
		.isZero(isZero), 
		.PC(PC), 
		.BRANCH(BRANCH), 
		.ZERO(ZERO), 
		.BRANCHING(BRANCHING), 
		.ALUOut(ALUOut), 
		.SPAddress(SPAddress), 
		.SPPlusOne(SPPlusOne), 
		.MemOut(MemOut), 
		.Target(Target), 
		.RegA(RegA), 
		.RegB(RegB), 
		.ReadA(ReadA), 
		.ReadB(ReadB), 
		.LoadValue(LoadValue), 
		.RegFive(RegFive),
		.InstCounter(InstCounter), 
		.Instruction(Instruction)
	);

initial begin
		// Initialize Inputs
		start = 0;
		CLK = 0;

		// Wait 100 ns for global reset to finish
		#100;
      start = 1; 
		#10;
		start = 0;
		// Add stimulus here

	end

  always begin
     #5  CLK = ~CLK; // Toggle clock every 5 ticks
  end
      
endmodule

