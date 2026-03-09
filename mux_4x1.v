`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2026 13:43:05
// Design Name: 
// Module Name: mux_4x1
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


module mux_4x1(	address,
				data,
				ack,
				mux_sel,
				mux_out
    );
    
    input[1:0] mux_sel;
    input address,data,ack;
    output reg mux_out;
    
    always@(mux_sel,address,data,ack)begin
    	case(mux_sel)
    		2'b00:mux_out =0;
    		2'b01:mux_out =address;
    		2'b10:mux_out = data;
    		2'b11:mux_out = ack;
    	endcase
    end
endmodule
