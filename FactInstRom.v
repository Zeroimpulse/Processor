`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: karen Abramowitz
// 
// Create Date:    12:50:22 04/02/2013 
// Design Name: 
// Module Name:    FactInstRom 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This is a basic verilog module to behave as an instruction ROM
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FactInstRom(InstAddress, InstOut);
    input [15:0] InstAddress;
    output [9:0] InstOut;


reg[9:0] InstOut;
	 always @ (InstAddress)
		begin
		case (InstAddress)
		
		0 : InstOut = 10'b0100011000;//lhw $g1, 0
		1 : InstOut = 10'b1011000010;//jal 2
		2 : InstOut = 10'b0110100000; //shw $g2, 0
		3 : InstOut = 10'b1110000000;//halt
		4 : InstOut = 10'b0011000000;//push $ra :fact
		5 : InstOut = 10'b0011011000;//push $g1
		6 : InstOut = 10'b1000011011;//is0 $g1, 3 
		7 : InstOut = 10'b0001011111;//addi $g1, -1
		8 : InstOut = 10'b1011111011;//jal -5
		9 : InstOut = 10'b1100000100;//j 4 
		10 : InstOut = 10'b1010100001;//dclr $g2, 1
		11 : InstOut = 10'b0001001110;//addi $sp, -2
		12 : InstOut = 10'b1010010001;//dclr $g0, 1
		13 : InstOut = 10'b1101000000;//jr $ra
		14 : InstOut = 10'b0100011010;//lhwsp $g1, 0 
		15 : InstOut = 10'b0001001110;//addi $sp, -2
		16 : InstOut = 10'b0100000110;//lhwsp $ra, 1 
		17 : InstOut = 10'b1001100001;//beq $g2, 1 
		18 : InstOut = 10'b1100000011;//j 3
		19 : InstOut = 10'b1010100000;//dclr $g2, 0
		20 : InstOut = 10'b0000100011;//add $g2, $g1
		21 : InstOut = 10'b1101000000;//jr $ra
		22 : InstOut = 10'b1010101000;//dclr $g3, 0
		23 : InstOut = 10'b1000011101;//is0, $g1, 5
		24 : InstOut = 10'b0111011001;//last0 $g1, 1
		25 : InstOut = 10'b0000101100;//add $g3,$g2
		26 : InstOut = 10'b0010100001;//shift $g2, 1
		27 : InstOut = 10'b0010011111;//shift $g1, -1
		28 : InstOut = 10'b1100111010;//j -6
		29 : InstOut = 10'b1010100000;//dclr $g2, 0
		30 : InstOut = 10'b0000100101;//add $g2, $g3
		31 : InstOut = 10'b1101000000;//jr $ra
		
		default : InstOut = 10'b1110000000;
    endcase
  end

endmodule