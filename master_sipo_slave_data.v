`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 18:26:28
// Design Name: 
// Module Name: master_sipo_slave_data
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


module master_sipo_slave_data(
							   master_serial_in,
							   master_scl,
							   master_data_shift,
							   master_data_out
    						);
input 	master_serial_in;
input 	master_scl;
input 	master_data_shift;
output 	[7:0]master_data_out;

reg [7:0] master_temp_recieved;

always @(posedge master_scl)
begin
	if(master_data_shift)
		master_temp_recieved <= {master_temp_recieved[6:0],master_serial_in};
	else 
		master_temp_recieved <= master_temp_recieved;
end

 //assign master_data_out=master_temp_received;
assign master_data_out = master_data_shift? master_data_out:master_temp_recieved;

endmodule
