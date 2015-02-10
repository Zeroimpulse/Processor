`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:48 04/03/2013 
// Design Name: 
// Module Name:    DataMemory 
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
module DataMemory(CLK, MemRead, MemWrite, DataAddress, DataIn, DataOut);
    input CLK;
    input MemRead;
    input MemWrite;
	 input [15:0] DataAddress; //8 bits
    input [15:0] DataIn;
    output [15:0] DataOut;
	 reg [15:0] DataOut;
	 reg [15:0] my_memory [255:0];
	 integer i;
	 
	

    initial begin
       // $readmemh("dataram_init.list", my_memory);
		 
		 for (i = 0 ; i < 256 ; i= i+1) 
		   begin
			my_memory[i] = 10;
		   end
		
		//initial for factorial
		my_memory[0] = 7;
		
		my_memory[9] = 15;
		my_memory[96] = 5;
		my_memory[97] = 0;
		my_memory[98] = 12455;
		my_memory[99] = 0;
		my_memory[100] = 2;
		my_memory[101] = 0;
		my_memory[102] = 12;
		my_memory[103] = 19;
		my_memory[138] = 15;
		
		
    end

    always @ (MemRead or DataAddress or DataIn)
        		  
		  
		  if(MemRead)
            DataOut = my_memory[DataAddress[7:0]];			
			else
            DataOut = 16'bZ;
    
	 always @ (posedge CLK)
        if(MemWrite) begin
            my_memory[DataAddress[7:0]] = DataIn;
				$display("MemWrite: ",DataIn," to Mem[",DataAddress[7:0],"]");
				
				
        end

endmodule
