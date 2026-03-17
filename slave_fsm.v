`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 15:11:32
// Design Name: 
// Module Name: slave_fsm
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


module slave_fsm(
				slave_tri_en,slave_shift_addr,slave_shift_piso,slave_load_piso,
				slave_shift_data, slave_ack_sel,slave_mux_sel,slave_scl_sixt,
				slave_ack,slave_start_bit,slave_addr_rcvd,slave_rd_wr,slave_reset
    );
    input slave_scl_sixt, slave_reset;
    input slave_ack, slave_start_bit;
    input slave_rd_wr;
    input [6:0] slave_addr_rcvd;
    
    output reg slave_tri_en, slave_ack_sel,slave_mux_sel;
    output reg slave_shift_piso, slave_load_piso;
    output reg slave_shift_addr, slave_shift_data;
    
    parameter slave_device_addr = 7'b1111010;
    parameter sdetect_start= 4'b0000, sstart=4'b0001, saddress_detect=4'b0010,
    		sread_write=4'b0011, ssend_data=4'b0100, sreceive_data=4'b0101,
    		sack_send= 4'b0110, sack_rcvd= 4'b0111, sdetect_stop =4'b1000;
    
    reg [3:0] s_state;
    reg [3:0] s_next_state;
    reg go_slave;
    integer slave_count;
    reg slave_check;
    
    always @(negedge slave_scl_sixt, negedge slave_reset)
    if(!slave_reset) begin
    	slave_count <= 1;
    end
    else if(go_slave)
    	slave_count <= slave_count +1;
    else
    	slave_count <= 1;
    
always@(s_state, slave_ack, slave_start_bit, slave_rd_wr, slave_addr_rcvd,slave_count)
case(s_state)
	sdetect_start:s_next_state=(!slave_start_bit)?sstart:sdetect_start;
	
	sstart:s_next_state=saddress_detect;
	
	saddress_detect:
	begin s_next_state=(slave_count==8)?sread_write:saddress_detect;
		  go_slave=(slave_count==8)?0:1;
	end
	
	sread_write:
			s_next_state= (slave_addr_rcvd==slave_device_addr)?(slave_rd_wr ? ssend_data: sreceive_data): sdetect_start;
	
	ssend_data:begin
			s_next_state=(slave_count==8)?sack_rcvd:ssend_data;
			go_slave=(slave_count==8)?0:1;
	end
	
	sreceive_data:begin
			go_slave=(slave_count==8)?0:1;
			s_next_state=(slave_count==8)?sack_send:sreceive_data;
			//go_slave=(slave_count==8)?0:1;
	end
	
	sack_rcvd:
			s_next_state= slave_ack?sdetect_start:sdetect_stop;
	
	sack_send:
			s_next_state= sdetect_stop;
	
	sdetect_stop:begin
			s_next_state=sdetect_start;
			slave_count=1;
	end
endcase

always @(negedge slave_scl_sixt,negedge slave_reset)
if(!slave_reset)
	s_state <= sdetect_start;
else 
	s_state <= s_next_state;
	
always@(s_state, slave_rd_wr)
if(s_state==sdetect_start)
begin
	slave_tri_en=1;          slave_ack_sel=0;           slave_mux_sel=0;
	slave_shift_piso=0;      slave_load_piso=0;         slave_shift_data=0;
	slave_shift_addr=0;
end

else if(s_state==sstart)
begin
	slave_tri_en=1;          slave_ack_sel=0;           slave_mux_sel=0;
	slave_shift_piso=0;      slave_load_piso=0;         slave_shift_data=0;
	slave_shift_addr=0;
end

else if(s_state==saddress_detect)
begin
	slave_tri_en=1;          slave_ack_sel=0;           slave_mux_sel=0;
	slave_shift_piso=0;      slave_load_piso=0;         slave_shift_data=0;
	slave_shift_addr=1;
end

else if(s_state==sread_write)begin
	slave_tri_en=0;          slave_ack_sel=(slave_addr_rcvd==slave_device_addr);           slave_mux_sel=0;
	slave_shift_piso=0;      slave_load_piso=slave_rd_wr?1:0;         slave_shift_data=0;
	slave_shift_addr=0;
end

else if(s_state==ssend_data)begin
slave_tri_en=0;          slave_ack_sel=0;           slave_mux_sel=1;
slave_shift_piso=1;      slave_load_piso=0;         slave_shift_data=0;
slave_shift_addr=0;
end

else if(s_state==sreceive_data)begin
	slave_tri_en=1;          slave_ack_sel=0;           slave_mux_sel=0;
	slave_shift_piso=0;      slave_load_piso=0;         slave_shift_data=1;
	slave_shift_addr=0;
end

else if(s_state==sack_send)begin
	slave_tri_en=0;          slave_ack_sel=0;           slave_mux_sel=0;
	slave_shift_piso=0;      slave_load_piso=0;         slave_shift_data=0;
	slave_shift_addr=0;
end

else if(s_state==sack_rcvd)begin
	slave_tri_en=1;          slave_ack_sel=1;           slave_mux_sel=0;
	slave_shift_piso=0;      slave_load_piso=0;         slave_shift_data=0;
	slave_shift_addr=0;
end


else if(s_state==sdetect_stop)begin
	slave_tri_en=1;          slave_ack_sel=0;           slave_mux_sel=0;
	slave_shift_piso=0;      slave_load_piso=0;         slave_shift_data=0;
	slave_shift_addr=0;
end

else begin
	slave_tri_en=1;          slave_ack_sel=0;           slave_mux_sel=0;
	slave_shift_piso=0;      slave_load_piso=0;         slave_shift_data=0;
	slave_shift_addr=0;
end

endmodule
