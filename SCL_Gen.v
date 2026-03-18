`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 14:40:37
// Design Name:
// Module Name: SCL_Gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//master scl generator to generate 100khz scl

module SCL_Gen( fpga_clock, scl_clock );
input fpga_clock;
output scl_clock;
integer count =0;

always @(posedge fpga_clock)
	if(count<500)
		count <=count +1;
	else
		count <=1;
		
assign scl_clock =(count <251)? 0:1;

endmodule
