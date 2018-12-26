module alu_tb;

reg clk;
reg enable_alu;
reg [3:0]alu_mode;
reg [7:0]in_a;
reg [7:0]in_b;
reg [7:0]shamp;

wire [7:0]alu_out;
wire flag_zero;
wire flag_carry;

alu  dut(.enable_alu(enable_alu),
							.clk(clk), 
							.opcode(alu_mode), 
							.in_a(in_a), 
							.in_b(in_b), 
							.shamp(shamp), 
							.alu_out(alu_out),
							.flag_zero(flag_zero),
							.flag_carry(flag_carry));

initial 
begin
	clk = 0;
	forever #10 clk = !clk;
end

initial
begin
	enable_alu = 0;
	alu_mode = 0;
	in_a = 0;
	in_b = 0;
	shamp = 0;
end

initial
begin
	#20 enable_alu = 1;
	#20 in_a = 240; in_b = 30; shamp = 240; 
	#30 alu_mode = 4'b0010;
	#30 alu_mode = 4'b0000;
	#30 alu_mode = 4'b0100;
	#20 enable_alu = 0;
	#20 alu_mode = 4'b0010;
end
endmodule
