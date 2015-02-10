`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:16:56 04/10/2013 
// Design Name: 
// Module Name:    IF 
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
module IF(
    input [15:0] Target,
    input Init,
    input Halt,
	 input CLK,
    output reg[15:0] PC
    );
	 
	 always @(posedge CLK)
	 begin
	 
		if(Init==1)
			PC = 0;
		else if(Halt==1)
			PC = PC;
		else
			PC = Target;
	 end


endmodule