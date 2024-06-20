module wb_mux_sel_unit(alu_src_reg_in,wb_mux_sel_reg_in,alu_result_in,lu_output_in,imm_reg_in,
			iaddr_out_reg_in,csr_data_in,pc_plus_4_in,rs2_reg_in,wb_mux_out,
			alu_2nd_src_mux_out);


	input [31:0] alu_result_in,lu_output_in,imm_reg_in,iaddr_out_reg_in,csr_data_in,
			pc_plus_4_in,rs2_reg_in;
	input [2:0] wb_mux_sel_reg_in;
	input alu_src_reg_in;

	output reg [31:0] wb_mux_out,alu_2nd_src_mux_out;

	parameter WB_ALU=3'b000,
		WB_LU=3'b001,
		WB_IMM=3'b010,
		WB_CSR=3'b011,
		WB_PC_PLUS=3'b100,
		WB_IADDR_OUT=3'b101;

	always@(*)
		begin 
			case(wb_mux_sel_reg_in) 
				begin 
					WB_ALU : wb_mux_out = alu_result_in;
					WB_LU : wb_mux_out = lu_output_in;
					WB_IMM : wb_mux_out = imm_reg_in;
					WB_CSR : wb_mux_out = csr_data_in;
					WB_PC_PLUS : wb_mux_out = pc_plus_4_in;
					WB_IADDR_OUT : wb_mux_out = iaddr_out_reg_in;
						default wb_mux_out = alu_result_in;
				end 
			endcase 
		end 

always@(*)
	begin 
		if(alu_src_reg_in)
			alu_2nd_src_mux_out = rs2_reg_in;
		else 
			alu_2nd_src_mux_out = imm_reg_in;
	end 

endmodule 

