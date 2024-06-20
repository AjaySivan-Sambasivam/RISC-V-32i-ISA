module reg_block1(pc_mux_in,mp_clk_in,mp_rst_in,pc_out);

	input wire mp_clk_in,mp_rst_in;
	input wire [31:0] pc_mux_in;
	output reg [31:0] pc_out;
	
	parameter BOOT_ADDR =32'b000000000;

		always@(posedge mp_clk_in)
			begin 
				if(mp_rst_in)
					pc_out = BOOT_ADDR;
				else 
					pc_out = pc_mux_in;
			end 
endmodule 

module reg_block1_tb();

	reg mp_clk_in=0,mp_rst_in;
	reg [31:0] pc_mux_in;
	wire [31:0] pc_out;

	reg_block1 DUV(pc_mux_in,mp_clk_in,mp_rst_in,pc_out);

	/*initial begin 
		forever
			#10 mp_clk_in = ~mp_clk_in;
		end */
		always #1 mp_clk_in = ~mp_clk_in;

		initial 
			begin 
				@(negedge mp_clk_in)
				mp_rst_in=1;
				@(negedge mp_clk_in)
				mp_rst_in=0;
				@(negedge mp_clk_in)
				pc_mux_in=32'd45;
				#100;
				$finish;
			end 
endmodule 



