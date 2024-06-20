module imm_generator(instr_in,imm_type_in,imm_out);
	input [31:7] instr_in, [2:0]imm_type_in;
	output reg [31:0] imm_out;

	always@(*)
		begin 
			case(imm_type_in)
					000: imm_out = {{20{instr_in[31]}},instr_in[31:20]};
					001: imm_out = {{20{instr_in[31]}},instr_in[31:20]};
					010: imm_out = {{20{instr_in[31]}},instr_in[31:25],instr_in[11:7]};
					011: imm_out = {{20{instr_in[31]}},instr_in[7],instr_in[30:25],instr_in[11:8],1'b0};
					100: imm_out = {instr_in[31:12],12'h0000};
					101: imm_out = {{12{instr_in[31]}},instr_in[19:12],instr_in[20],instr_in[30:21],1'b0};
					110: imm_out = {27'b0,instr_in[19:15]};
					111: imm_out = {{20{instr_in[31]}},instr_in[31:20]};
			endcase 
		end 

endmodule 
