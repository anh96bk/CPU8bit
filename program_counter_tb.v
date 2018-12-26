module program_counter_tb;


reg clk;
reg rst;
reg jump;
reg up;
reg [7:0]in;
wire [7:0]PC_next;

program_counter dut(.clk(clk), .in(in), .jump(jump), .rst(rst), .up(up), .PC_next(PC_next));

initial 
begin
	clk = 0;
	forever #10 clk = !clk;
end

initial
begin
	in = 8'b00000100;
	jump = 0;
	rst = 1;
	up = 0;
end

initial
begin
	#10 rst = 0;
	#100 jump = 1;
	#50 jump = 0;
	#20 up = 1;
	#50 rst = 1;
end
endmodule
