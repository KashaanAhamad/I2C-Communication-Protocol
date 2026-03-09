`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2026 13:48:42
// Design Name: 
// Module Name: mux_2x1
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


module mux_2x1( ack_sel, ack_out );
	input ack_sel;
	output reg ack_out;

parameter ACK = 0, NACK =1;

	always@(ack_sel)begin
		case(ack_sel)
			1'b0:ack_out = NACK;
			1'b1:ack_out = ACK;
		endcase
	end
endmodule
