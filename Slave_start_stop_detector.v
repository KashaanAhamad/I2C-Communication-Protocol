`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 14:12:50
// Design Name: 
// Module Name: slave_start_stop_detector
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


module slave_start_stop_detector(
							slave_reset,
							slave_scl_in,
							slave_sda_in,
							start_stop_detect
    );
    
    input slave_reset;
    input slave_scl_in,slave_sda_in;
    output start_stop_detect;
    //wire rst_clock;
    
    wire t,s1,s2;
    
slave_toggle_register s13(.in(slave_scl_in),
							.out(t),
							.rst(slave_reset),
							.clk(slave_sda_in)
							);
							
slave_reg2 s33(	.in(t),
				.out(s2),
				.rst(slave_reset),
				.clk(slave_sda_in),
				.load(slave_scl_in)
			  );  
				
slave_reg1 s23(.in(t),
				.out(s1),
				.rst(slave_reset),
				.clk(slave_sda_in),
				.load(slave_scl_in)
				);   
assign start_stop_detect = ~(s1^s2);

endmodule


module slave_toggle_register (in,out,rst,clk);
input in,rst;
input clk;
output reg out;

always @(posedge clk,negedge rst)
begin
	if(!rst)
		out<=1;
	else if(in)
		out<= !out;
end
endmodule


module slave_reg1(in,out,rst,clk,load);
input in,rst,clk,load;
output reg out;

always @(posedge clk, negedge rst)
begin
	if(!rst)
		out <=0;
	else if(load)
		out <=in;
end
endmodule


module slave_reg2(in,out,rst,clk,load);
input in,rst,clk,load;
output reg out;

always @(negedge clk,negedge rst)
begin
	if(!rst)
		out<=0;
	else if(load)
		out<=in;
end

endmodule


