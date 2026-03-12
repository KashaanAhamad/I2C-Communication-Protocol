`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2026 14:04:17
// Design Name: 
// Module Name: mast_fsm
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


module mast_fsm(
				master_start_bit,
				master_rd_wr,
				master_scl_sixt,
				master_rst,
				master_ack,
				master_load_add,
				master_shift_add,
				master_load_data,
				master_shift_data,
				master_mux_sel,
				master_tri_en,
				master_demux_sel,
				master_shift_d_slave,
				master_ack_sel,
				master_scl_en
    );
    
    input master_start_bit,master_rd_wr,master_rst,master_ack,master_scl_sixt;
    output reg master_load_add, master_shift_add;
    output reg master_load_data, master_shift_data,master_ack_sel;
    output reg master_tri_en,master_demux_sel,master_shift_d_slave;
    output reg master_scl_en;
    output reg[1:0]master_mux_sel;
    
    parameter master_idle = 4'b0000, 	master_start =4'b0001, 			transmit_scl =4'b0010,
    		  master_address = 4'b0011, master_ack_add = 4'b0111, 		master_send_data = 4'b0101,
    		  master_ack_rd=4'b0110,	master_receive_data=4'b0111, 	master_ack_sd =4'b1000, 	master_stop =4'b1001;
    		  
    reg [3:0] master_state, master_next_state;
    reg go;
    integer master_count = 1;
    
    always@(negedge master_scl_sixt)begin
		if(go)
			master_count<=master_count+1;
		else
			master_count<=1;
	end
	
	always@(master_state,master_rd_wr,master_ack,master_start_bit,master_count)
	case(master_state)
	
	master_idle:
				master_next_state=(master_start_bit==1)?master_start:master_idle;
	
	master_start:
				master_next_state=transmit_scl;
	
	transmit_scl:
				master_next_state=master_address;
	
	master_address:begin
				master_next_state=(master_count==8)?master_ack_add:master_address;
				go=(master_count==8)?0:1;
			end
	
	master_ack_add:
				master_next_state=(master_ack==0)?((master_rd_wr==0)?master_send_data:master_receive_data):master_idle;
	
	master_send_data:begin
				master_next_state=(master_count==8)?master_ack_rd:master_send_data;
				go=(master_count==8)?0:1;
			end
	
	master_ack_rd:
				master_next_state=(master_ack==0)?master_stop:master_send_data;
	
	master_receive_data:begin
				master_next_state=(master_count==8)?master_ack_sd:master_receive_data;
				go=(master_count==8)?0:1;
			end
	
	master_ack_sd:
				master_next_state=master_stop;
	
	master_stop:
				master_next_state=master_idle;
	
	default:
				master_next_state=master_idle;
	
	endcase


always@(negedge master_scl_sixt,negedge master_rst)
if(!master_rst)
master_state<=master_idle;
else
master_state=master_next_state;

always@(master_state)begin

	if(master_state==master_idle)begin
			master_tri_en=1'b1;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b0;        master_shift_add=1'b0;         master_ack_sel=0;
			master_load_data=1'b0;       master_shift_data=1'b0;         master_scl_en=0;
	end
	
	else if(master_state==master_start)begin
			master_tri_en=1'b0;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b1;        master_shift_add=1'b0;         master_ack_sel=0;
			master_load_data=1'b0;       master_shift_data=1'b0;        master_mux_sel=2'b00;
			master_scl_en=0;
	end
	
	else if(master_state==transmit_scl)begin
			master_tri_en=1'b0;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b0;        master_shift_add=1'b0;         master_ack_sel=0;
			master_load_data=1'b0;       master_shift_data=1'b0;        master_mux_sel=2'b00;
			master_scl_en=1;
	end
	
	else if(master_state==master_address)begin
			master_tri_en=1'b0;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b0;        master_shift_add=1'b1;         master_ack_sel=0;
			master_load_data=1'b0;       master_shift_data=1'b0;        master_mux_sel=2'b01;
			master_scl_en=1;
	end
	
	else if(master_state==master_ack_add)begin
			master_tri_en=1'b1;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b0;        master_shift_add=1'b0;         master_ack_sel=0;
			master_load_data=1'b1;       master_shift_data=1'b0;        master_mux_sel=2'b00;
			master_scl_en=1;
	end
	
	else if(master_state==master_send_data)begin
			master_tri_en=1'b0;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b0;        master_shift_add=1'b0;         master_ack_sel=0;
			master_load_data=1'b0;       master_shift_data=1'b1;        master_mux_sel=2'b10;
			master_scl_en=1;
	end
	
	else if(master_state==master_receive_data)begin
			master_tri_en=1'b1;          master_demux_sel=1'b1;         master_shift_d_slave=1'b1;
			master_load_add=1'b0;        master_shift_add=1'b0;         master_ack_sel=0;
			master_load_data=1'b0;       master_shift_data=1'b0;        master_mux_sel=2'b00;
			master_scl_en=1;
	end
	
	else if(master_state==master_ack_rd)begin
			master_tri_en=1'b1;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b0;        master_shift_add=1'b0;         master_ack_sel=0;
			master_load_data=1'b0;       master_shift_data=1'b0;        master_mux_sel=2'b11;
			master_scl_en=1;
	end
	
	else if(master_state==master_ack_sd)begin
			master_tri_en=1'b0;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b0;        master_shift_add=1'b0;         master_ack_sel=1;
			master_load_data=1'b0;       master_shift_data=1'b0;        master_mux_sel=2'b11;
			master_scl_en=1;
	end
	
	else if(master_state==master_stop)begin
			master_tri_en=1'b1;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b0;        master_shift_add=1'b0;         master_ack_sel=0;
			master_load_data=1'b0;       master_shift_data=1'b0;        master_mux_sel=2'b11;
			master_scl_en=0;
	end
	
	else
		begin
			master_tri_en=1'b0;          master_demux_sel=1'b0;         master_shift_d_slave=1'b0;
			master_load_add=1'b0;        master_shift_add=1'b0;         master_ack_sel=0;
			master_load_data=1'b0;       master_shift_data=1'b0;        master_mux_sel=2'b11;
			master_scl_en=0;
		end
	end
	
endmodule
