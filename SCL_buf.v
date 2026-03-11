`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 14:55:15
// Design Name: 
// Module Name: SCL_buf
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


module SCL_buf(
				master_scl,
				master_scl_en,
				master_scl_out
			);
input master_scl;
input master_scl_en;
output master_scl_out;

bufif1 scl_buff(master_scl,master_scl_out,master_scl_en);
endmodule
