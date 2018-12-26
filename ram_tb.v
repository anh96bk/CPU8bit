module ram_tb;

reg clk;
reg [7:0]address;
reg er;
wire [23:0]data_out;


ram dut(
						.clk(clk),
						.address(address),
						.er(er),
						.data_out(data_out));
						
initial
begin
	clk = 0;
	forever #5 clk = !clk;
end

initial
begin
	er = 0;
	address = 0;
end

initial
begin
		#10 er = 1;
		#20 address = 1;
		#20 er = 0;
		#20 address = 2;
end
						
endmodule
						