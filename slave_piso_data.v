`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 14:54:17
// Design Name: 
// Module Name: slave_piso_data
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


module slave_piso_data(
						slave_data,
						slave_scl_sixt,
						slave_load_data,
						slave_shift_data,
						slave_serial_out_data
   					 );
   					 	
    input [7:0]slave_data;
    input slave_load_data,slave_shift_data;
    input slave_scl_sixt;
    output slave_serial_out_data;
    
    reg [7:0] slave_temp_data;
    
    always @(negedge slave_scl_sixt)
    	if(slave_load_data)
    		slave_temp_data =slave_data;
    	else if(slave_shift_data)
    		slave_temp_data = {slave_temp_data[6:0],1'b0};
    	
assign slave_serial_out_data = slave_temp_data[7];
    
endmodule
