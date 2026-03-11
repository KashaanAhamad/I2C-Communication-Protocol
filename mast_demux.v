`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2026 13:52:32
// Design Name: 
// Module Name: mast_demux
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


module mast_demux(
				master_demux_select,
				master_demux_in,
				master_slave_data,
				master_ack
    );
    
    input master_demux_select, master_demux_in;
    output reg master_slave_data, master_ack;
    
    always@(master_demux_select, master_demux_in)
    	case(master_demux_select)
    		1'b0:begin
    			master_ack = master_demux_in;
    			master_slave_data = 1'b0;
    		end
    		1'b1:begin
    			 master_ack=1'b0;
    			 master_slave_data=master_demux_in;
			end
		endcase
endmodule
