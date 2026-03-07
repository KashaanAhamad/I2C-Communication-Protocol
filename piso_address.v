`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 15:25:19
// Design Name: 
// Module Name: piso_address
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


module piso_address(
					clock,
					load,
					shift,
					address,
					rd_wr,
					serial_out
				 );
input clock,load,shift,rd_wr;
input [6:0]address;
output serial_out;

reg [7:0] temp;

always @(negedge clock)
begin
	if(load)
		temp <= {address,rd_wr};
	else if(shift)
		temp <= {temp[6:0],1'b0};
end

assign serial_out = temp[7];

endmodule
