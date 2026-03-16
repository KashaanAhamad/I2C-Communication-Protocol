`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 15:08:51
// Design Name: 
// Module Name: slave_mux2x1
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


module slave_mux2x1(
					slave_ack_sel,slave_ack_out
   			 );
   			 
input slave_ack_sel;
output reg slave_ack_out;
    
parameter ACK= 1'b0, NACK=1'b1;
    
    always@(*)
    	if(slave_ack_sel)
    		slave_ack_out =ACK;
    	else
    		slave_ack_out =NACK;
    
endmodule
