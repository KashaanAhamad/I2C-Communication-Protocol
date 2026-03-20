`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2026 20:40:15
// Design Name: 
// Module Name: piso_address_tb
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


module piso_address_tb( );
    
reg clock=0;
reg load,shift,rd_wr;
reg [6:0]address;
wire serial_out;

	piso_address p1(clock,load,shift,address,rd_wr,serial_out);

always #5 clock=~clock;

initial begin
    address=7'b1100110;
    rd_wr=1;
    load=1;
    #6 load=0;
    #6 shift=1;
end


endmodule
