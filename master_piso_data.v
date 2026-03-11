`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 16:23:28
// Design Name: 
// Module Name: master_piso_data
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


module master_piso_data(
						master_scl,
						master_load_data,
						master_shift_data,
						master_data,
						master_serial_out_data
				    );
input master_scl;
input master_load_data;
input master_shift_data;
input [7:0] master_data;
output	master_serial_out_data;

reg [7:0] master_temp_data;

always @(negedge master_scl)
begin
	if(master_load_data)
		master_temp_data <= master_data;
	else if(master_shift_data)
		master_temp_data <= {master_temp_data[6:0],1'b0};
end

assign master_serial_out_data = master_temp_data[7];

endmodule
