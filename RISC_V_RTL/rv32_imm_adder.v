module imm_adder(iadder_src_in,pc_in,rs_1_in,imm_in,iadder_out);

	input iadder_src_in;
	input [31:0] pc_in; 
	input [31:0] rs_1_in;
        input [31:0]imm_in;

	output [31:0] iadder_out;

	reg [31:0] w;

	assign w = iadder_src_in ? rs_1_in:pc_in;
	assign iadder_out = w + imm_in;

endmodule


