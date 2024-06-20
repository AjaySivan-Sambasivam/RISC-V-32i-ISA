module instruction_mux(flush_in,mp_instr_in,opcode_out,funct3_out,funct7_out,rs1addr_out,rs2addr_out,rdaddr_out,csr_addr_out,instr_out);

	input flush_in;
	input [31:0] mp_instr_in;

	output reg [6:0] opcode_out;
	output reg [2:0] funct3_out;
	output reg [6:0] funct7_out;
	output reg [4:0] rs1addr_out;
	output reg [4:0] rs2addr_out;
	output reg [4:0] rdaddr_out;
	output reg [11:0] csr_addr_out;
	output reg [31:7] instr_out;

	reg [31:0] fl_h=32'h00000013;

		always@(*)
			begin 
				if(flush_in == 1'b1)
					begin 
						opcode_out = fl_h[6:0];
						funct3_out = fl_h[14:12];
						funct7_out = fl_h[31:25];
						csr_addr_out = fl_h[31:20];
						rs1addr_out = fl_h[19:15];
						rs2addr_out = fl_h[24:20];
						rdaddr_out = fl_h[11:7];
						instr_out = fl_h[31:7];
					end 
				else 
					begin 
						opcode_out = mp_instr_in[6:0];
						funct3_out = mp_instr_in[14:12];
						funct7_out = mp_instr_in[31:25];
						csr_addr_out = mp_instr_in[31:20];
						rs1addr_out = mp_instr_in[19:15];
						rs2addr_out = mp_instr_in[24:20];
						rdaddr_out = mp_instr_in[11:7];
						instr_out = mp_instr_in[31:7];
					end 
			end 
endmodule 
