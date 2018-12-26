module cpu_registers(
  input wire clk,
  input wire rst,
  input wire [7:0] data_in,
  input wire [3:0] rs,
  input wire [3:0] rt,
  input wire [3:0] rd,
  input wire enable_write,
  input wire output_enable,
  output wire [7:0] reg_a,
  output wire [7:0] reg_b,
  output reg [7:0]data_out
);

  reg [7:0] registers[0:15];
  
  initial
	begin
		registers[0] = 8'b0;
		registers[1] = 8'b0;
		registers[2] = 8'b0;
		registers[3] = 8'b0;
		registers[4] = 8'b0;
		registers[5] = 8'b0;
		registers[6] = 8'b0;
		registers[7] = 8'b0;
		registers[8] = 8'b0;
		registers[9] = 8'b0;
		registers[10] = 8'b0;
		registers[11] = 8'b0;
		registers[12] = 8'b0;
		registers[13] = 8'b0;
		registers[14] = 8'b0;
		registers[15] = 8'b0;
	end

  always @ (posedge clk) begin
  if(!rst)
  begin
    if (enable_write & ~output_enable)
      registers[rd] = data_in;
		else
		begin
		data_out = registers[rd];
		end
  end else
  begin
  		registers[0] = 8'b0;
		registers[1] = 8'b0;
		registers[2] = 8'b0;
		registers[3] = 8'b0;
		registers[4] = 8'b0;
		registers[5] = 8'b0;
		registers[6] = 8'b0;
		registers[7] = 8'b0;
		registers[8] = 8'b0;
		registers[9] = 8'b0;
		registers[10] = 8'b0;
		registers[11] = 8'b0;
		registers[12] = 8'b0;
		registers[13] = 8'b0;
		registers[14] = 8'b0;
		registers[15] = 8'b0;
  end
  end

  assign reg_a = registers[rs];
  assign reg_b = registers[rt];
  

endmodule
