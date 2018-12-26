module cpu_tb;

reg clk;
reg rst;

cpu dut(
					.clk(clk),
					.rst(rst));
				
initial
begin
	clk = 0;
	forever #10 clk = !clk;
end	

initial
begin
	#10 rst = 1;
	#50 rst = 0;
end


endmodule
