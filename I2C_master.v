`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 14:32:44
// Design Name: 
// Module Name: I2C_master
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


module I2C_master(
					mast_start_bit,
					mast_addr,
					mast_data,
					mast_rd_wr,
					fpga_clk,
					mast_rst,
					
					SDA,			//Serial Data
					SCL,			//Serial Clock
					data_from_slave //Slave Data Recieved Bus
				 );
				 
input mast_start_bit, mast_rd_wr;
input fpga_clk,mast_rst;
input [6:0]mast_addr;
input [7:0]mast_data;

inout tri1 SDA;

output [7:0]data_from_slave;
output tri1 SCL;

wire mast_load_addr, mast_shift_addr,mast_serial_out_addr;
wire mast_load_data,mast_shift_data, mast_serial_out_data,mast_sgift_d_slave;
wire mast_scl;
wire mast_tri_en, mast_sda_in, mast_sda_out, mast_demux_sel,mast_ack, mast_slavedata;
wire mast_scl_en,mast_ack_sel,mast_ack_out;
wire[1:0] mast_mux_sel;


piso_address pisoAddr(.rd_wr(mast_rd_wr),.address(mast_address),.load(mast_load_addr),.shift(mast_shift_addr),.clock(fpga_clk),.serial_out(mast_serial_out_addr));

master_piso_data pisoData(	.master_scl(fpga_clk),
							.master_load_data(mast_load_data),
							.master_shift_data(mast_shift_data),
							.master_data(mast_data),
							.master_serial_out_data(mast_serial_out_data)
						);
						
master_sipo_slave_data sipoSlaveData(
										.master_serial_in(mast_slavedata),
							   			.master_scl(fpga_clk),
							   			.master_data_shift(mast_shift_d_slave),
							   			.master_data_out(data_from_slave)
									);

master_tristate_logic triState_logic(
										.master_sda_out(mast_sda_out),
										.master_tri_en(mast_tri_en),
										.master_sda_in(mast_sda_in),
										.master_sda(SDA)
									);

SCL_buf sclbuffer(.master_scl(fpga_clk),.master_scl_en(mast_scl_en),.master_scl_out(mast_scl));

mux_4x1 mux1(	.address(mast_serial_out_addr),
			.data(mast_serial_out_data),
			.ack(mast_ack_out),
			.mux_sel(mast_mux_sel),
			.mux_out(mast_sda_out)
		  );
		  
mux_2x1 mux2(	.ack_sel(mast_ack_sel),
				.ack_out(mast_ack_out)
			);

mast_demux demux1( 	.master_demux_select(mast_demux_sel),
					.master_demux_in(mast_sda_in),
					.master_slave_data(mast_slavedata),
					.master_ack(mast_ack)
					);
					
mast_fsm masterFSM(	.master_start_bit(mast_start_bit),
					.master_rd_wr(mast_rd_wr),
					.master_scl_sixt(fpga_clk),
					.master_rst(mast_rst),
					.master_ack(mast_ack),
					.master_load_add(mast_load_addr),
					.master_shift_add(mast_shift_addr),
					.master_load_data(mast_load_data),
					.master_shift_data(mast_shift_data),
					.master_mux_sel(mast_mux_sel),
					.master_tri_en(mast_tri_en),
					.master_demux_sel(mast_demux_sel),
					.master_shift_d_slave(mast_shift_d_slave),
					.master_ack_sel(mast_ack_sel),
					.master_scl_en(mast_scl_en)
           );	
           
           assign SCL = mast_scl;	
           	
endmodule
