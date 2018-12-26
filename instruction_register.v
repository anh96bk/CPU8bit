module instruction_register (
  input wire [23:0] in,
  input wire clk,
  input wire enable,
  output reg [23:0] instruction
);

initial
begin
	instruction = 0;
end

  always @(posedge clk) 
  begin
	if (enable)
		instruction <= in;
  end
endmodule
