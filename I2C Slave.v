`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2026 15:58:47
// Design Name: 
// Module Name: I2C Slave
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


module I2C_Slave(	slave_reset,
				 	slave_scl_input,
				 	slave_sda_input,
				 	slave_data_out,
				 	slave_data
				 );
	input slave_reset;
	input slave_scl_input;
	input [7:0] slave_data;
	
	output [7:0] slave_data_out;
	
	inout slave_sda_input;
	
	wire start_stop_detect;
	wire slave_sda_in,slave_tri_en;
	wire slave_shift_data, slave_load_data;
	wire slave_rec_data_shift;
	wire slave_sda_out;
	wire slave_ack_sel, slave_muc_sel;
	wire slave_ack_out,slave_serial_out_data,slave_rec_addr_shift,slave_rd_wr;
	wire [6:0] slave_addr_out;
	
	slave_start_stop_detector startStopDet(.slave_reset(slave_reset),
										   .slave_scl_in(slave_scl_input),
										   .slave_sda_in(slave_sda_input),
										   .start_stop_detect(start_stop_detect)
										  );
										  
	slave_tristate_logic tri_slave(	.slave_sda_out(slave_sda_out),
								   	.slave_tri_en(slave_tri_en),
									.slave_sda_in(slave_sda_in),
									.slave_sda(slave_sda_input)
								  );
								  
	slave_sipo_addr sipo1(	.slave_serial_in(slave_sda_in),
							.slave_scl_sixt(slave_scl_input),
							.slave_rec_addr_shift(slave_rec_addr_shift),
							.slave_addr_out(slave_addr_out),
							.slave_rd_wr(slave_rd_wr)
						  );
						  
	slave_sipo_data sipo2(	.slave_serial_in(),
							.slave_rec_data_shift(), 
							.slave_scl_sixt(),
							.slave_data_out()
						  );
						  
	slave_piso_data piso1(	.slave_data(slave_data),
							.slave_scl_sixt(slave_scl_input),
							.slave_load_data(slave_load_data),
							.slave_shift_data(slave_shift_data),
							.slave_serial_out_data(slave_serial_out_data)
						 );
						 
	slave_mux slaveMux1(	.slave_mux_sel(slave_mux_sel), 
							.slave_serial_out_data(slave_serial_out_data),
							.slave_mux_out(slave_sda_out), 
							.slave_acknowledge(slave_ack_out)
					   );
	
	slave_mux2x1 slaveMux2( .slave_ack_sel(slave_ack_sel),
							.slave_ack_out(slave_ack_out)
						  );
	
	slave_fsm fsm_slave( .slave_tri_en(slave_tri_en),
						 .slave_shift_addr(slave_rec_addr_shift),
						 .slave_shift_piso(slave_shift_data),
						 .slave_load_piso(slave_load_data),
						 .slave_shift_data(slave_rec_data_shift), 
						 .slave_ack_sel(slave_ack_sel),
						 .slave_mux_sel(slave_mux_sel),
						 .slave_scl_sixt(slave_scl_input),
						 .slave_ack(slave_sda_input),
						 .slave_start_bit(start_stop_detect),
						 .slave_addr_rcvd(slave_addr_out),
						 .slave_rd_wr(slave_rd_wr),
						 .slave_reset(slave_reset)
					 );
endmodule
