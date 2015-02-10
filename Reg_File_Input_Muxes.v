`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:31 04/13/2013 
// Design Name: 
// Module Name:    Reg_File_Input_Muxes 
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
module Reg_File_Input_Muxes(
	
	 //control inputs
	 input [2:0] RegASrc,
	 input BEQ,
	 input [1:0] RegWriteSrc,
	 input [1:0] RegDst,
	 input lmhw,

	 //values
	 input [2:0] rs,
	 input [2:0] rt,
	 input [15:0] ALUOut,
	 input [15:0] MemOut,
	 input [15:0] SPAddress,
	 input [15:0] PC, //have to sign extend 
	 input [15:0] RegFive,
	 
    output reg[2:0] ReadA,
	 output reg[2:0] ReadB,
	 output reg[2:0] WriteReg,
	 output reg[15:0] WriteValue
    );

	always @(RegASrc, BEQ, RegWriteSrc, RegDst, lmhw, rs, rt, ALUOut, MemOut, SPAddress, PC, RegFive)
	begin
		case (RegASrc)
			0 : ReadA = rs;
			1 : ReadA = 1;
			2 : ReadA = 0;
			3 : ReadA = 6;
			4 : ReadA = 7;
			default: ReadA = 0; //should not be reached
		endcase
		
		if (BEQ == 0) //rt also = imm
			ReadB = rt;
		else if (rt[2] == 0)
			ReadB = 2;
		else
			ReadB = 3;
			
		case (RegWriteSrc)
			0 : WriteReg = rs;
			1 : WriteReg = 1;
			2 : WriteReg = 0;
		   default: WriteReg = 0; //should not be reached
		endcase
		
		case (RegDst)
			0 : WriteValue = ALUOut;
			1 : WriteValue = MemOut;
			2 : WriteValue = SPAddress;
			3 : WriteValue = PC + 1;
   		default WriteValue = 0; //should not be reached
		endcase

		if (lmhw)
		begin
				WriteValue[7:0] = WriteValue[15:8];
				WriteValue[15:8] = RegFive[7:0];
		end
			
	end

endmodule