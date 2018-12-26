module program_counter (
  input wire clk,
  input wire [7:0] in,
  input wire jump,
  input wire up,
  input wire rst,
  output reg [7:0] PC_next
);


  initial
    PC_next = 0;

  always @(posedge clk) begin
  if(!rst)
  begin
	if (jump & ~up)
		PC_next <= in;
	else if(up & ~jump)
		PC_next <= PC_next + 1;
	else
		PC_next <= PC_next;
  end
  else
  begin
	PC_next <= 0;
  end
  end
  
endmodule