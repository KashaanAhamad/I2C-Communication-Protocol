`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 19:11:30
// Design Name: 
// Module Name: master_tristate_logic
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


module master_tristate_logic(
								master_sda_out,
								master_tri_en,
								master_sda_in,
								master_sda
    						);
input 		master_sda_out;
input 		master_tri_en;
output 		master_sda_in;
inout	 	master_sda;

bufif0 b1(master_sda,master_sda_out,master_tri_en);
buf b2(master_sda_in,master_sda);

endmodule
