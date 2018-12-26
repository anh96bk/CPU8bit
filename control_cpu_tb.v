module control_cpu_tb;

reg clk, rst;
reg [3:0]opcode;
wire [3:0]state;
wire allow_up;

control_cpu dut(
						.clk(clk),
						.rst(rst),
						.opcode(opcode),
						.state(state),
						.allow_up(allow_up));
						
initial
begin
	clk = 0;
	forever #10 clk = !clk;
end

initial
begin
	#5 rst = 1;
	#10 rst = 0;
	#250 opcode = 4'b1111;
	#100 rst = 1;
end


endmodule
