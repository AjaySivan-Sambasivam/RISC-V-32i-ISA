module store_unit(funct3_in,iaddr_in,rs2_in,mem_wr_req_in,ahb_ready_in,data_out,daddrs_out,wr_mask_out,ahb_btrans_out,wr_req_out);
 
	input [1:0] funct3_in;
	input [31:0] iaddr_in,rs2_in;
	input mem_wr_req_in,ahb_ready_in;

		output [31:0] daddrs_out;
		output reg [31:0] data_out;
		output reg [3:0] wr_mask_out;
		output reg [1:0] ahb_btrans_out;
		output wr_req_out;

	reg [31:0] hw_data;
	reg [31:0] byte_data;
	reg [3:0] hw_mask,byte_mask;
	
	always@(*) //byte & mask
		begin 
			case(iaddr_in[1:0])
				begin 
					00: byte_data = {8'b0,8'b0,8'b0,rs2_in[7:0]};
							byte_mask = {3{1'b0},mem_wr_req_in};
					01: byte_data = {8'b0,8'b0,rs2_in[15:8],8'b0};
							byte_mask = {2{1'b0},mem_wr_req_in,1'b0};
					10: byte_data = {8'b0,rs2_in[23:16],2{8'b0}};
				      byte_mask = {1'b0,mem_wr_req_in,2{1'b0}};
					11: byte_data = {rs2_in[31:14],3{8'b0}};
							byte_mask = {mem_wr_req_in,3{1'b0}};
				end 
		endcase 		
	end 

always@(*) //half word & mask 
	begin 
		case(iaddr_in[1])
			begin 
				0: hw_data = {16'b0,rs2_in[15:0]};
					 hw_mask = {2{1'b0},2{mem_wr_req_in}};
				1: hw_data = {rs2_in[31:16],16'b0};
					 hw_mask = {2{mem_wr_req_in},2{1'b0}};
			end
		endcase
	end 

always@(*)
	begin
		if(ahb_ready_in)
			begin 
				case(funct3_in)
					begin 
						00: data_out = byte_data;
								wr_mask_out = byte_mask;
						01: data_out = hw_data;
								wr_mask_out = hw_mask;
						default data_out = rs2_in;
										wr_mask_out = {4{mem_wr_req_in}};
					end
				endcase
					ahb_btrans_out = 2'b01;
			end 
		else 
					ahb_btrans_out = 2'b00;
	end 

	assign data_out = {rs2_in[31:2],2'b00};
	assign wr_req_out = mem_wr_req_in;
endmodule 
