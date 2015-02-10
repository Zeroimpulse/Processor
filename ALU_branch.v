`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:04:41 04/03/2013 
// Design Name: 
// Module Name:    ALU_Branch 
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
module ALU_Branch(
   input [15:0] RS,
   input [15:0] PC,
	input [5:0] imm,
	input BRANCH,
	input JUMP,
   input BEQ,
	input jr_control,
	input isZero,
	// input [15:0] JumpAddress,
   output reg [15:0] OUT

	 
	 
    );
	 
	reg [15:0] jump_immediate;
	reg [15:0] branch_immediate; 
	always @(RS, PC, imm, BRANCH, JUMP, BEQ, jr_control)
	begin
	
	
	
	jump_immediate = {{10{imm[5]}},imm[5:0]};
	//$display("imm =", imm,"jump_imm=", jump_immediate);
	branch_immediate = {{13{imm[2]}},imm[2:0]};
	
	if (isZero)
			branch_immediate[15:3] = 13'b0000000000000;

	if (jr_control == 1) 
		OUT = RS; 
   else 
		begin 
				if (BRANCH ==0 ) 
					branch_immediate = 0; 
				if (JUMP == 1) 	
					branch_immediate = jump_immediate;	
				if ((BEQ == 1'b1) && (branch_immediate[15] == 1)) 
					OUT = PC + 1 - branch_immediate;	  
				else 
				begin
						OUT = PC + 1 + branch_immediate;
					//$display(OUT, "=", PC, "+1", branch_immediate);
				end
						
			end
			 //$display("Branch immediate:" , branch_immediate);
			 //$display("Out = :", OUT);
		end
	
	
  endmodule
