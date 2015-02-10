`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:24:09 10/27/2011 
// Design Name: 
// Module Name:    reg_file 
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
module reg_file(
	 input wire CLK,
    input wire [2:0] srcA,
    input wire [2:0] srcB,
    input wire [2:0] writeReg,
    input wire [15:0] writeValue,
	
	input wire RegWrite,
	 
	 output [15:0] ReadA,
    output [15:0] ReadB,
	 output [15:0] LoadValue,
	 output [15:0] RegFive,
	 output [15:0] SPAddress
    );
	 
reg [15:0] registers[15:0];

integer i;
initial begin
	for (i=0; i<16; i = i+1)
			registers[i] = 0;
			
	registers[1] = -1;
	registers[6] = 9;
end


assign ReadA = registers[srcA];
assign ReadB = registers[srcB];
assign LoadValue = registers[6];
assign RegFive = registers[5];
assign SPAddress = registers[1];

always @ (posedge CLK)
//always @ (RegWrite, srcA, srcB, writeReg, writeValue)
begin
if (RegWrite)
  begin
    registers[writeReg] = writeValue;
	 $display("Register write: RegNum " ,writeReg, " = ", writeValue);
	end

end
endmodule
