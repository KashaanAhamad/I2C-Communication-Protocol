`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 15:00:27
// Design Name: 
// Module Name: slave_mux
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


module slave_mux(
					slave_mux_sel, 
					slave_serial_out_data,
					slave_mux_out, 
					slave_acknowledge
  			   );
  			   
    input slave_serial_out_data, slave_acknowledge, slave_mux_sel;
    output reg slave_mux_out;
    
    //assign = slave_mux_out = slave_mux_sel? slave_serial_out_data: slave_acknowledge;
    
    always @(slave_mux_sel,slave_serial_out_data,slave_acknowledge)
    if(slave_mux_sel)
    	slave_mux_out = slave_serial_out_data;
    else 
    	slave_mux_out = slave_acknowledge;
    	
endmodule
