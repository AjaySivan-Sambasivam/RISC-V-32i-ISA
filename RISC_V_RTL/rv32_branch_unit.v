module rv32_branch_unit(rs1_in,rs2_in,opcode_in,funct3_in,branch_taken_out);
	input [31:0] rs1_in,rs2_in;
	input [6:2] opcode_in;
	input [2:0] funct3_in;
	output reg branch_taken_out;

	reg b_take;
	
	
	always@(*)
		begin
			case(funct3_in)
				begin 
					000 : b_take=(rs1_in==rs2_in)? 1'b1:1'b0;
					001 : b_take=(rs1_in!=rs2_in)? 1'b1:1'b0;
					100 : b_take=(rs1_in[31]^rs2_in[31])? rs1_in[31]:rs1_in<rs2_in;
					101 : b_take=(rs1_in[31]^rs2_in[31])? !rs1_in[31]:!rs1_in<rs2_in;
					110 : b_take=(rs1_in<rs2_in)? 1'b1:1'b0;
					111 : b_take=!(rs1_in<rs2_in)? 1'b1:1'b0;
				end 
			endcase
		end

	always@(*)
		begin 
			case(opcode_in)
				begin 
					110_11 : branch_taken_out = 1'b1;
					110_01 : branch_taken_out = 1'b1;
					110_00 : branch_taken_out = b_take;
				end 
			endcase
		end 

endmodule 


