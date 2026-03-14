`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 14:44:32
// Design Name: 
// Module Name: slave_sipo_data
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


module slave_sipo_data(
						slave_serial_in,
						slave_rec_data_shift, 
						slave_scl_sixt,
						slave_data_out
  					  );
  					  
input slave_serial_in, slave_rec_data_shift;
input slave_scl_sixt;
output [7:0] slave_data_out;
    
reg [7:0] slave_temp_data;
    
    always @(posedge slave_scl_sixt)
    	if(slave_rec_data_shift)
    		slave_temp_data <= {slave_temp_data[6:0], slave_serial_in};
    	else	
    		slave_temp_data <= slave_temp_data;
    	
assign slave_data_out = slave_temp_data;
endmodule
