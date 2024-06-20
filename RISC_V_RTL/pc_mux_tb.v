/*module pc_mux_tb();
	 reg rst_in,branch_addr_in,ahb_ready_in;
	 reg [1:0] pc_src_in;
	 reg [31:0] epc_in,trap_addr_in,pc_in;
	 reg [30:0] iaddr_in;
	
	 wire mis_instr_log_out;
	 wire [31:0] iaddr_out,pc_pluse_4_out,pc_mux_out;

	  pc_mux DUT(rst_in,pc_src_in,epc_in,trap_addr_in,branch_addr_in,iaddr_in,ahb_ready_in,pc_in,iaddr_out,pc_pluse_4_out,mis_instr_log_out,pc_mux_out);
	
		task reset_in(input a);
			begin 
				rst_in = a;
	 			#10;
				rst_in = ~a;
			end 
		endtask 

		task task1();
			begin 
				pc_in = 32'h00000000001;
				#5;
				branch_addr_in = 1'b0;
				#5;
				pc_src_in = 2'b11;
				#5;
				ahb_ready_in = 1'b1;
			end 
		endtask

	task task2();
		begin 
			iaddr_in = 31'd1;
			#5;
			branch_addr_in = 1'b1;
			#5;
			pc_src_in = 2'b11;
			#5;
			ahb_ready_in = 1'b1;
		end 
	endtask 

	task misaligned();
		begin 
			iaddr_in[30:0] = 31'h0000000001;
			#5;
			branch_addr_in = 1'b1;
		end 
	endtask 

	task task3();
		begin 
			reset_in(1);
			epc_in = 32'd45;
			trap_addr_in = 32'd40;
			#10;
			pc_src_in = 2'b01;
			#10;
			ahb_ready_in = 1'b1;
		end 
	endtask 


		initial 
			begin 
				reset_in(1);
				//task1();
				//misaligned();
				//task2;
				task3();
				#100;
				$finish;
			end 
endmodule */

module test();
reg [3:0] a,b;

initial 
begin 
	a=1001;
	$monitor("a:%0d , B:%0d",a,b);
end 
initial 
begin 
	repeat(1) begin 
	b<=4'b0011;
	$display("b:%0d",b);
		end 
end 
endmodule 

