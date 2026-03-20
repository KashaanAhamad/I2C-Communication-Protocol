`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2026 20:44:31
// Design Name: 
// Module Name: mast_piso_data_tb
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


module mast_piso_data_tb(   );

reg clock=0;
reg load,shift;
reg [7:0]data;
wire serial_out;

mast_piso_data p1(data,clock,load,shift,serial_out);

always #5 clock=~clock;

initial begin
    data=8'b11001101;
    load=0;
    #2 load=1;
    #9 shift=1; load=0;
end

endmodule
