`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:36 04/03/2013 
// Design Name: 
// Module Name:    Control 
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
	module Control(
    input [3:0] OPCODE,
	 input [2:0] FUNCTION,
    output reg MEM_READ,
	 output reg MEM_WRITE,
	 output reg [2:0] ALU_OP,
    output reg [1:0] ALU_SRC,
	 output reg BRANCH,
	 output reg BEQ,
	 output reg JUMP,
	 output reg JR,
	 output reg LMHW,
	 output reg REG_WRITE,
	 output reg isZero,
	 output reg [2:0] REG_SRC,
	 output reg [1:0] REG_DST,
	 output reg [1:0] REGWRITESRC,
	 output reg HALT
	
	 );
	
	always @(OPCODE, FUNCTION)
	begin
	
		isZero = 0;
		//0 add, 1 = sub, 2 = last zero, 3 = declare, 4 shift right, 5 shift left, 6 push
		case(OPCODE)
			0 : //add
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b000;//add
				ALU_SRC = 0;
				BRANCH =0;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 1;
				REG_SRC = 3'b000;
				REG_DST = 2'b00;
				REGWRITESRC =2'b00;
				HALT = 0;
			end
			
			1 : //addi
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b000;//add
				ALU_SRC = 1;
				BRANCH =0;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 1;
				REG_SRC = 3'b000;
				REG_DST = 2'b00;
				REGWRITESRC =2'b00;
				HALT = 0;
			end
			
			2 : //shift
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
/*				if (FUNCTION[2] == 0) 
					ALU_OP = 5;//shift left
				else*/
			   ALU_OP = 4;//shift right
				ALU_SRC = 1;
				BRANCH =0;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 1;
				REG_SRC = 3'b000;
				REG_DST = 2'b00;
				REGWRITESRC =2'b00;
				HALT = 0;
			end
			
			3 : //push - there is no pop
			begin
				MEM_READ = 0;
				MEM_WRITE = 1;
				ALU_OP = 3'b110; // push
				ALU_SRC = 1;
				BRANCH =0;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 1;
				REG_SRC = 3'b000;
				REG_DST = 2'b10;
				REGWRITESRC =2'b01;
				HALT = 0;
			end
			
			4 : //lhw, lhw2, lmhwsp
				//controls for load?
			begin
				MEM_READ = 1;
				MEM_WRITE = 0;
				ALU_OP = 3'b000;//add
				ALU_SRC = 2;
				BRANCH =0;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 1;
				case(FUNCTION[1:0])
					0 : REG_SRC=3;
					1 : REG_SRC=4;
					2 : REG_SRC=1;
				endcase
				REG_DST = 2'b01;
				REGWRITESRC =2'b00;
				HALT = 0;
			end
			
			5 : //lmhw
			begin
				MEM_READ = 1;
				MEM_WRITE = 0;
				ALU_OP = 3'b000;//add
				ALU_SRC = 1;
				BRANCH =0;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 1;
				REG_WRITE = 1;
				REG_SRC = 4;
				REG_DST = 2'b01;
				REGWRITESRC =2'b00;
				HALT = 0;
			end
			
			6 : //shw
			begin
				MEM_READ = 0;
				MEM_WRITE = 1;
				ALU_OP = 5;//add to load
				ALU_SRC = 1;
				BRANCH =0;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 0;
				REG_SRC = 0;
				REG_DST = 0; 
				REGWRITESRC =0; 
				HALT = 0;
			end
			
			7 : //last0
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b010; //last zero
				ALU_SRC = 0;//don't care
				BRANCH =1;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 0;
				REG_SRC = 3'b000;
				REG_DST = 2'b10; //don't care
				REGWRITESRC =2'b00;//don't care
				HALT = 0;
			end
			
			8 : //is0
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b111; //7, is 0
				ALU_SRC = 0;//don't care
				BRANCH =1;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 0;
				REG_SRC = 3'b000; 
				REG_DST = 2'b00; //don't care
				REGWRITESRC =2'b00; //don't care
				HALT = 0;
				isZero=1;
			end
			
			9 : //beq
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b001; //sub
				ALU_SRC = 0;
				BRANCH =1;
				BEQ = 1;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 0;
				REG_SRC = 3'b000;
				REG_DST = 2'b00;//don't care
				REGWRITESRC =2'b00; //don't care
				HALT = 0;
			end
			
			10 : //dclr
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b011; //dclr
				ALU_SRC = 1;
				BRANCH =0;
				BEQ = 0;
				JUMP = 0;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 1;
				REG_SRC = 3'b000;//don't care
				REG_DST = 2'b00;
				REGWRITESRC =2'b00;
				HALT = 0;
			end
			
			11 : //jal
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b000;//don't care
				ALU_SRC = 0; //don't care
				BRANCH =0; //don't care
				BEQ = 0;
				JUMP = 1;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 1;
				REG_SRC = 3'b000; //don't care
				REG_DST = 2'b11;
				REGWRITESRC =2'b10;
				HALT = 0;
			end
			
			12: //j
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b000;//don't care
				ALU_SRC = 0; //don't care
				BRANCH =0;//don't care
				BEQ = 0;
				JUMP = 1;
				JR = 0;
				LMHW = 0;
				REG_WRITE = 0;
				REG_SRC = 3'b000;//don't care
				REG_DST = 2'b00; //don't care
				REGWRITESRC =2'b00; //don't care
				HALT = 0;
			end
			
			13: //jr
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b000;//don't care
				ALU_SRC = 0;
				BRANCH =0;
				BEQ = 0; //don't care
				JUMP = 0; //don't care
				JR = 1;
				LMHW = 0;
				REG_WRITE = 0;
				REG_SRC = 3'b000; //don't care
				REG_DST = 2'b10; //don't care
				REGWRITESRC =2'b00; //don't care
				HALT = 0;
			end
			
			14 : //halt
			begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				ALU_OP = 3'b000; //don't care
				ALU_SRC = 0;//don't care
				BRANCH =0;//don't care
				BEQ = 0;//don't care
				JUMP = 0;//don't care
				JR = 0;//don't care
				LMHW = 0;//don't care
				REG_WRITE = 0;
				REG_SRC = 3'b000;//don't care
				REG_DST = 2'b10;//don't care
				REGWRITESRC =2'b00;//don't care
				HALT = 1;
			end
			
		endcase
	
	end
endmodule