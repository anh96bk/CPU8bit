module instruction_register_tb;

reg clk;
reg [23:0]in;
reg enable;
wire [23:0]instruction;


instruction_register dut(
						.in(in),
						.clk(clk),
						.enable(enable),
						.instruction(instruction));
						
initial
begin
	clk = 0;
	forever #5 clk = !clk;
end

initial
begin
	in = 0;
	enable = 0;
end

initial
begin
		#10 in = 20;
		#20 enable = 1;
		#30 enable = 0;
		#10 in = 30;
end
						
endmodule
						