module ram (
	input wire clk,
	input wire [7:0]address,
	input wire er,						//read if er is high
	output reg [23:0]data_out
	);
	
reg [23:0] mem [0:255];

initial $readmemb("C:/altera/13.0/MCU8BIT/RAM.txt", mem);

always @(posedge clk) begin
	if(er) begin
		data_out <= mem[address];
	end
end
endmodule
