module pc_mux(rst_in,pc_src_in,epc_in,trap_addr_in,branch_addr_in,iaddr_in,ahb_ready_in,pc_in,iaddr_out,pc_pluse_4_out,mis_instr_log_out,pc_mux_out);

	input wire rst_in,branch_addr_in,ahb_ready_in;
	input wire [1:0] pc_src_in;
	input wire [31:0] epc_in,trap_addr_in;
	input wire [30:0] iaddr_in,pc_in;
	
	output wire mis_instr_log_out;
	output reg [31:0] iaddr_out,pc_mux_out;
	output wire [31:0] pc_pluse_4_out;

	reg [31:0] next_pc;

	parameter BOOT_ADDR = 32'b000000;

	assign pc_pluse_4_out = pc_in + 32'h0000004;

	always@(*)
		begin 
			if(branch_addr_in)
				next_pc = {iaddr_in[30:0],1'b0};
			else
				next_pc = pc_pluse_4_out;
		end 

	always@(*)
		begin 
			case(pc_src_in)
				2'b00 : pc_mux_out = BOOT_ADDR;
				2'b01 : pc_mux_out = epc_in;
				2'b10 : pc_mux_out = trap_addr_in;
				2'b11 : pc_mux_out = next_pc;
			endcase
		end 

	assign mis_instr_log_out = next_pc[1] & branch_addr_in;

	always@(*)
		begin 
			if(rst_in)
				iaddr_out = BOOT_ADDR;
			else if(ahb_ready_in && !rst_in)
				iaddr_out = pc_mux_out;
			else 
				iaddr_out = iaddr_out;
		end 
endmodule 
