`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 14:38:22
// Design Name: 
// Module Name: slave_sipo_addr
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


module slave_sipo_addr(
						slave_serial_in,
						slave_scl_sixt,
						slave_rec_addr_shift,
						slave_addr_out,
						slave_rd_wr
   					 );
   					 
input slave_serial_in,slave_rec_addr_shift;
input slave_scl_sixt;
output [6:0] slave_addr_out;
output slave_rd_wr;
    
reg [7:0] slave_temp_addr;
    
    always @(posedge slave_scl_sixt)
    	if(slave_rec_addr_shift)
    		slave_temp_addr <= {slave_temp_addr[6:0],slave_serial_in};
    	else
    		slave_temp_addr <= slave_temp_addr;
    
assign slave_addr_out = slave_temp_addr[7:1];
assign slave_rd_wr = slave_temp_addr[0];
    
endmodule
