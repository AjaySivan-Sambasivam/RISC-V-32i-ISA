module alu(op_1_in,op_2_in,opcode_in,result_out);
	input [31:0] op_1_in,op_2_in;
	input [3:0] opcode_in;
	output reg [31:0] result_out;

	always@(*)
		begin 
			case(opcode_in)
				begin
					0000 : result_out = op_1_in+op_2_in;
					1000 : result_out = op_1_in-op_2_in;
					0010 : result_out = (op_1_in[31]^op_2_in[31]) ? op_1_in[31]:(op_1_in<op_2_in);
					0011 : result_out = (op_1_in<op_2_in) ? 1'b1:1'b0;
					0111 : result_out = op_1_in & op_2_in;
					0110 : result_out = op_1_in | op_2_in;
					0100 : result_out = op_1_in ^ op_2_in;
					0001 : result_out = op_1_in << op_2_in;
					0101 : result_out = op_1_in >> op_2_in;
					1101 : result_out = op_1_in >>> op_2_in;
				end 
			endcase 
		begin 
endmodule 



