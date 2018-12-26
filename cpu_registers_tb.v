module cpu_registers_tb;

reg clk,rst;
reg [7:0] data_in;
reg [3:0]rs, rt, rd;
reg enable_write, output_enable;
wire [7:0]reg_a, reg_b;
wire [7:0]data_out;

cpu_registers dut(
		.clk(clk), .rst(rst),
		.data_in(data_in),
		.rs(rs), .rt(rt), .rd(rd),
		.enable_write(enable_write), .output_enable(output_enable),
		.reg_a(reg_a), .reg_b(reg_b),
		.data_out(data_out)
		);
		
initial
begin
	clk = 0;
	forever #10 clk = !clk;
end

initial
begin
	rst = 1;
	data_in = 30;
	enable_write = 0;
	output_enable = 0; 
end

initial
begin
	#10 rst = 0;
	#20 rs = 2; rt =3; rd = 4;
	#10 enable_write = 1;
	#30 enable_write = 0; output_enable = 1;
	#30 rst =1;
end

endmodule