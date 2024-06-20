module rv32_reg_block2(clk_in,rst_in,branch_taken_in,rd_addr_in,csr_addr_in,rs1_in,rs2_in,pc_in,pc_pluse4_in,alu_opcode_in,load_size_in,load_unsig_in,alu_src_in,rf_wr_en_in,
			csr_wr_en_in,wb_mux_sel_in,csr_op_in,imm_in,iaddr_out_in,rd_addr_reg_out,csr_addr_reg_out,rs1_reg_out,rs2_reg_out,pc_reg_out,pc_pluse4_reg_out,alu_opcode_reg_out,
			load_size_reg_out,load_unsig_reg_out,alu_src_reg_out,rf_wr_en_reg_out,csr_wr_en_reg_out,wb_mux_sel_reg_out,csr_op_reg_out,imm_reg_out,iaddr_reg_out);

		input clk_in,rst_in,branch_taken_in,load_unsig_in,alu_src_in,rf_wr_en_in,csr_wr_en_in;
		input [4:0] rd_addr_in;
		input [11:0] csr_addr_in;
		input [31:0] rs1_in,rs2_in,pc_in,pc_pluse4_in,imm_in,iaddr_out_in;
		input [3:0] alu_opcode_in,load_size_in;
		input [2:0] wb_mux_sel_in,csr_op_in;


		output reg load_unsig_reg_out,alu_src_reg_out,rf_wr_en_reg_out,csr_wr_en_reg_out;
		output reg [4:0] rd_addr_reg_out;
		output reg [11:0] csr_addr_reg_out;
		output reg [31:0] rs1_reg_out,rs2_reg_out,pc_reg_out,pc_pluse4_reg_out,imm_reg_out,iaddr_reg_out;
		output reg [3:0] alu_opcode_reg_out,load_size_reg_out;
		output reg [2:0] wb_mux_sel_reg_out,csr_op_reg_out;


	always@(posedge clk)
		begin 
			if(rst_in)
				begin 
					load_unsig_reg_out<=1'b0;
					alu_src_reg_out<=1'b0;
					rf_wr_en_reg_out<=1'b0;
					csr_wr_en_reg_out<=1'b0;
					wb_mux_sel_reg_out<=3'b0;
					csr_op_reg_out<=3'b0;
					rd_addr_reg_out<=5'b0;
					csr_addr_reg_out<=12'b0;
					{rs1_reg_out,rs2_reg_out,pc_reg_out,pc_pluse4_reg_out,imm_reg_out,iaddr_reg_out}<={32'b0,32'b0,32'b0,32'b0,32'b0,32'b0};
					alu_opcode_reg_out<=4'b0;
					load_size_reg_out<=4'b0;
				end 

			else 
				begin
					load_unsig_reg_out<=load_unsig_in;
					alu_src_reg_out<=alu_src_in;
					rf_wr_en_reg_out<=rf_wr_en_in;
					csr_wr_en_reg_out<=csr_wr_en_in;
					wb_mux_sel_reg_out<=wb_mux_sel_in;
					csr_op_reg_out<=csr_op_in;
					rd_addr_reg_out<=rd_addr_in;
					csr_addr_reg_out<=csr_addr_in;
					rs1_reg_out<=rs1_in;
					rs2_reg_out<=rs2_in;
					pc_reg_out<=pc_in
					pc_pluse4_reg_out<=pc_pluse4_in;
					imm_reg_out<=imm_in;
					alu_opcode_reg_out<=alu_opcode_in;
					load_size_reg_out<=load_size_in;
				end 

			if(!rst_in && branch_taken_in)
				begin 
					iaddr_reg_out<={iaddr_out_in[31:1],1'b0};
				end 
			else 
				begin 
					iaddr_reg_out<=iaddr_out_in;
				end 
	end 

	endmodule 					
