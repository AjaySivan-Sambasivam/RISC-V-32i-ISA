module rv32_top(mp_dmdata_in,ahb_resp_in,mp_rst_in,ahb_ready_in)

	input mp_clk_in,mp_rst_in,ahb_ready_in;


	wire [31:0] pc_reg_wir,pc_mux_wir,imm_out_wir,int_rs1_wir,iaddr_add_wir;
	wire [2:0]imm_type_wir
	wire [31:7] instr_wir;
	wire iaddr_src_wir;
	wire wr_en_gen_wir;
	wire [6:0] ins_op_wir;
	wire [4:0] ins_rs1addr_wir,ins_rs2addr_wir,ins_rdaddr_wir;


pc_mux PC(.rst_in(mp_rst_in),
					.pc_src_in(),
					.epc_in(),
					.trap_addr_in(),
					.branch_addr_in(),
					.iaddr_in(),
					.ahb_ready_in(ahb_ready_in),
					.pc_in(pc_reg_wir),
					.iaddr_out(),
					.pc_pluse_4_out(),
					.mis_instr_log_out,
					.pc_mux_out(pc_mux_wir));


reg_block1 REG1(.pc_mux_in(pc_mux_wir),
								.mp_clk_in(mp_clk_in),
								.mp_rst_in(mp_rst_in),
								.pc_out(pc_reg_wir));

 imm_generator IMM_GEN(.instr_in(instr_wir),
				 							 .imm_type_in(imm_type_wir),
											 .imm_out(imm_out_wir));

 instruction_mux INS_MUX(.flush_in(),
				 								 .mp_instr_in(),
												 .opcode_out(ins_op_wir),
												 .funct3_out(),
												 .funct7_out(),
												 .rs1addr_out(ins_rs1addr_wir),
												 .rs2addr_out(ins_rs2addr_wir),
												 .rdaddr_out(ins_rdaddr_wir),
												 .csr_addr_out(),
												 .instr_out(instr_wir));

rv32_branch_unit BRN(.rs1_in(),
										 .rs2_in(),
										 .opcode_in(),
										 .funct3_in(),
										 .branch_taken_out());

imm_adder IMM_ADD(.iadder_src_in(iaddr_src_wir),
									.pc_in(pc_reg_wir),
									.rs_1_in(int_rs1_wir),
									.imm_in(imm_out_wir),
									.iadder_out(iaddr_add_wir));


rv32_integer_file INT_FILE(.mp_clk_in(mp_clk_in),
													 .mp_rst_in(mp_rst_in),
													 .rs_2_addr_in(ins_rs2addr_wir),
													 .rs_1_addr_in(ins_rs1addr_wir),
													 .rd_addr_in(ins_rdaddr_wir),
													 .wr_eb_in(wr_en_gen_wir),
													 .rd_in(),
													 .rs_1_out(int_rs1_wir),
													 .rs_2_out());


wr_eb_generator WR_EB_GEN(.flush_in(),
													.rf_wr_en_reg_in(),
													.csr_wr_eb_reg_in(),
													.wr_en_integer_file_out(wr_en_gen_wir),
													.wr_en_csr_file_out());

msrv32_dec DEC( .opcode_in(),
						.funct7_5_in(),
            .funct3_in(),
            .iadder_1_to_0_in(iaddr_add_wir),
            .trap_taken_in(),
            .alu_opcode_out(),
            .mem_wr_req_out(),
            .load_size_out(),
            .load_unsigned_out(),
            .alu_src_out(),
            .iadder_src_out(iaddr_src_wir),
            .csr_wr_en_out(),
            .rf_wr_en_out(),
            .wb_mux_sel_out(),
            .imm_type_out(imm_type_wir),
            .csr_op_out(),
            .illegal_instr_out(),
            .misaligned_load_out(),
						.misaligned_store_out());

