`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: karen Abramowitz
// 
// Create Date:    12:50:22 04/02/2013 
// Design Name: 
// Module Name:    SearchInstRom 
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
module SearchInstRom(InstAddress, InstOut);
    input [15:0] InstAddress;
    output [9:0] InstOut;


	reg[9:0] InstOut;
	
	always @ (InstAddress)
		begin
		case (InstAddress)
		

		0 : InstOut = 10'b1010110010; //dclr $load, 2
		1 : InstOut = 10'b0100010000; //lhw $g0, 0 
		2 : InstOut = 10'b1010111100; //dclr $load2, 4 
		3 : InstOut = 10'b1010011101; //dclr $g1, 5
		4 : InstOut = 10'b0001111001; //addi, $load2, 1
		5 : InstOut = 10'b1001111111; //beq, $load2, -1
		6 : InstOut = 10'b1100000011; //j 3
		7 : InstOut = 10'b1010111110; //dclr $load2, 6
		8 : InstOut = 10'b0110111001; //shw $load2, 1 
		9 : InstOut = 10'b1110000000; //halt
		10 : InstOut = 10'b0100101001; //lhw2 $g3, 0
		11 : InstOut = 10'b1001101011; //beq $g3, 3
		12 : InstOut = 10'b0101101001; //lmhw $g3, 1
		13 : InstOut = 10'b1001101001; //beq $g3, 1
		14 : InstOut = 10'b1100110101; //j -11
		15 : InstOut = 10'b1010011111; //dclr $g1, 7
		16 : InstOut = 10'b0000111011; //add $load2, $g1
		17 : InstOut = 10'b0110111001; //shw $load2, 1
		default : InstOut = 10'b1110000000;
    endcase
  end

endmodule