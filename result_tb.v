module result_tb;

reg clk;
reg [7:0]address;
reg eo;
reg [7:0]in;


result dut(
						.clk(clk),
						.eo(eo),
						.addr(address),
						.in(in));
						
initial
begin
	clk = 0;
	forever #5 clk = !clk;
end

initial
begin
	eo = 0;
	address = 0;
	in = 50;
end

initial
begin
		#10 eo = 1;
		#20 address = 1;
		#20 eo = 0;
		#20 address = 2;
end
						
endmodule
						