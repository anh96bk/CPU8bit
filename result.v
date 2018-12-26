module result(
	input clk,
	input eo,
	input [3:0]addr,
	input [7:0]in
	);
	
	
reg [7:0] registers[0:15];

initial
begin
	registers[0] = 0;
	registers[1] = 0;
	registers[2] = 0;
	registers[3] = 0;
	registers[4] = 0;
	registers[5] = 0;
	registers[6] = 0;
	registers[7] = 0;
	registers[8] = 0;
	registers[9] = 0;
	registers[10] = 0;
	registers[11] = 0;
	registers[12] = 0;
	registers[13] = 0;
	registers[14] = 0;
	registers[15] = 0;
end


always @(posedge clk)
begin
	if(eo)
	begin
	registers[addr] = in;
	$writememb("C:/altera/13.0/MCU8BIT/REGISTERS.txt", registers);
	end
	else
	begin
	end
end

endmodule
