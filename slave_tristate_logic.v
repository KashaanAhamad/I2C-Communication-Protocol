`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 14:34:03
// Design Name: 
// Module Name: slave_tristate_logic
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


module slave_tristate_logic(
								slave_sda_out,
								slave_tri_en,
								slave_sda_in,
								slave_sda
    						);
    						
input slave_sda_out,slave_tri_en;
inout slave_sda;
output slave_sda_in;

bufif0 b1(slave_sda,slave_sda_out,slave_tri_en);
buf b2(slave_sda_in, slave_sda);

endmodule


