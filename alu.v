module alu  (
  input wire enable_alu,
  input wire clk,
  input wire [3:0] opcode,
  input wire [7:0] in_a,
  input wire [7:0] in_b,
  input wire [7:0] shamp,
  output reg [7:0] alu_out,
  output reg flag_zero,
  output reg flag_carry
);

  localparam [3:0] ALU_ADD = 4'b0000,
						ALU_ADC = 4'b0001,
						ALU_SUB = 4'b0010,
						ALU_ADDI = 4'b0011,
						ALU_SUBI = 4'b0100,
						ALU_AND = 4'b0101,
						ALU_OR = 4'b0110,
						ALU_XOR = 4'b0111,
						ALU_SHIFT_RIGHT = 4'b1000,
						ALU_SHIFT_LEFT = 4'b1001;
						
						

  initial begin
    flag_carry = 0;
    flag_zero = 0;
	 alu_out = 8'b0;
  end

  always @(posedge clk) begin
    if (enable_alu) begin
      case (opcode)
        ALU_ADD: {flag_carry, alu_out} = in_a + in_b;
        ALU_ADC: {flag_carry, alu_out} = in_a + in_b + flag_carry;
        ALU_SUB: {flag_carry, alu_out} = in_a - in_b;
        ALU_ADDI: {flag_carry, alu_out} = in_a + shamp;
        ALU_SUBI: {flag_carry, alu_out} = in_a - shamp;
        ALU_AND: alu_out = in_a & in_b;
        ALU_OR:  alu_out = in_a | in_b;
        ALU_XOR: alu_out = in_a ^ in_b;
		  ALU_SHIFT_RIGHT: alu_out = in_a >> shamp;
		  ALU_SHIFT_LEFT: alu_out = in_a << shamp;
        default:  alu_out = 'hxx;
      endcase

      flag_zero = (alu_out == 0) ? 1 : 0;

    end
  end

endmodule