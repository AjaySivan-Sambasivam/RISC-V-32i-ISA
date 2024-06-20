module rv32_integer_file(mp_clk_in,mp_rst_in,rs_2_addr_in,rs_1_addr_in,rd_addr_in,wr_eb_in,rd_in,rs_1_out,rs_2_out);

	input mp_clk_in,mp_rst_in,wr_eb_in;
	input [4:0] rs_1_addr_in,rs_2_addr_in,rd_addr_in;
	input [31:0] rd_in;

	output [31:0] rs_1_out,rs_2_out;

	wire [31:0] fwd_out1,fwd_out2;

	reg [31:0] mem [31:0];
	integer i;
	parameter BOOT_ADDR = 32'b000000;

	//assign fwd_out1 = (rs_1_addr_in == rd_addr_in && wr_eb_in) ? 1'b1:1'b0;
 	//assign fwd_out2	= (rs_2_addr_in == rd_addr_in && wr_eb_in) ? 1'b1:1'b0;


	always@(posedge mp_clk_in or posedge mp_rst_in)
		begin 
			if(mp_rst_in)
				for(i=0;i<32;i=i+1)
					begin 
						mem[i] = BOOT_ADDR;
					end 
			else if (wr_eb_in && rd_addr_in)
				begin 
					mem[rd_addr_in] = rd_in;
				end 
		end 

	//assign rs_1_out = fwd_out1 == 1'b1 ? rd_in : mem[rd_addr_in];
	//assign rs_2_out = fwd_out2 == 1'b1 ? rd_in : mem[rd_addr_in];

	assign rs_1_out = (rs_1_addr_in == rd_addr_in && wr_eb_in) ? rd_in : mem[rd_addr_in];
	assign rs_2_out = (rs_2_addr_in == rd_addr_in && wr_eb_in) ? rd_in : mem[rd_addr_in];

	endmodule
