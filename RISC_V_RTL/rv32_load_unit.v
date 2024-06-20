module load_unit(ahb_resp_in,dmdata_in,iaddr_1to0_in,load_unsig_in,load_size_in,lu_data_out);

	input ahb_resp_in,load_unsig_in;
	input [31:0] dmdata_in;
	input [1:0] iaddr_1to0_in,load_size_in;

	output reg [31:0] lu_data_out;
always@(*)
	begin
		if(!ahb_resp_in)
			if(load_size_in==2'b00)
				if(!load_unsig_in)
					begin 
						case(iaddr_1to0_in)
							begin 
								00 : lu_data_out = {3{8'b0},dmdata_in[7:0]};
								01 : lu_data_out = {3{8'b0},dmdata_in[15:8]};
								10 : lu_data_out = {3{8'b0},dmdata_in[23:16]};
								11 : lu_data_out = {3{8'b0},dmdata_in[31:24]};
							end 
						endcase
					end 
				else
					begin
						case(iaddr_1to0_in)
							begin 
								00 : lu_data_out = {24{dmdata_in[7]},dmdata_in[7:0]};
								01 : lu_data_out = {24{dmdata_in[15]},dmdata_in[15:8]};
								10 : lu_data_out = {24{dmdata_in[23]},dmdata_in[23:16]};
								11 : lu_data_out = {24{dmdata_in[31]},dmdata_in[31:24]};
							end 
						endcase
					end 
			else if(load_size_in==2'b01)
				if(!load_unsig_in)
					begin 
						case(iaddr_1to0_in[1])
							begin 
								0 : lu_data_out = {2{8'b0},dmdata_in[15:0]};
								1 : lu_data_out = {2{8'b0},dmdata_in[31:16]};
							end 
						endcase 
					end 
				else
					begin 
						case(iaddr_1to0_in[1])
							begin 
								0 : lu_data_out = {16{dmdata_in[15]},dmdata_in[15:0]};
								1 : lu_data_out = {16{dmdata_in[31]},dmdata_in[31:16]};
							end 
						endcase 
			else 
				lu_data_out = dmdata_in;
		else 
			lu_data_out = 32'bz;
	end 
endmodule 
