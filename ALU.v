`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:22 10/27/2011 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [2:0] OP,
    input [15:0] INPUTA,
    input [15:0] INPUTB,
	 input [15:0] IMM,
	 input [15:0] SP,
	 input [1:0] ALUsrc,
	 input [15:0] LoadValue,
	 input BRANCH,
    output reg [15:0] OUT,
    output reg BRANCHING,
	 output reg [15:0] SPAddress
    );
	 
	 // if shw, then DATAIN = RS, DATADDRESS = $load + imm
	reg [15:0] temp;
	
	always @(INPUTA, INPUTB, OP, IMM, SP, ALUsrc, BRANCH)
	begin

	case(ALUsrc)
		0 : temp = INPUTB;
		1 : temp = IMM;
		2 : begin temp = 0; temp[0] = IMM[2]; end
	endcase
/*		temp = IMM;
	else
		temp = INPUTB;*/
	
	case(OP) //0 add, 1 = sub, 2 = last zero, 3 = declare, 4 shift, (4shift right, 5 shift left,) 5 shw, 6 push, 7 = isZero
		0 : OUT = INPUTA+temp;
		1 : OUT = INPUTA-temp;
		2 : OUT = INPUTA[0];
		3 : 
			begin 
				case(temp[2:0])
					0 : OUT = 0;
					1 : OUT = 1;
					2 : OUT = 9;
					3 : OUT = 48;
					4 : OUT = 95;
					5 : OUT = 144;
					6 : OUT = -1;
					7 : OUT = -96;
					default: OUT = -5;
				endcase
			end
		4 :  
		begin 
			if (temp[15] == 1)
				OUT = INPUTA >> (-temp); 
			else
				OUT = INPUTA << temp;
		end
		5 : OUT = LoadValue + temp;
		6 : begin OUT = SP + 1; SPAddress = SP + 1; end
		7 : OUT = INPUTA;
		default: OUT = -1;
	endcase
	 
	if (OUT == 0 && BRANCH)
		BRANCHING = 1;
	else
		BRANCHING = 0;
	
	//$display("ALU Out %d \n",OUT);
	end

endmodule