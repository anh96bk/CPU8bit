module cpu(
  input clk,
  input rst
);

localparam [3:0]	IDLE = 4'd0,
						STATE_PC = 4'd1,
						STATE_RAM = 4'd2,
						STATE_IR = 4'd3,
						STATE_BUFFER = 4'd4,
						STATE_REGISTER_IN = 4'd5,
						STATE_ALU = 4'd6,
						STATE_ALU_OUT = 4'd7,
						STATE_REGISTER_OUT = 4'd8,
						STATE_ROM = 4'd9,
						STATE_JUMP = 4'd10;


//Program Counter
wire jump;
wire up;
wire [7:0]shamp;
wire [7:0]PC_next;
program_counter cnt(
	.clk(clk),
	.in(shamp),
	.jump(jump),
	.rst(rst),
	.up(up),
	.PC_next(PC_next)
);


//RAM
wire [23:0]data_out_ram;
ram ram(
	.clk(clk),
	.address(PC_next),
	.er(er),
	.data_out(data_out_ram)
);

//Instruction Register
wire enable;
wire [23:0]regi_out;
instruction_register IR(
	.in(data_out_ram),
	.clk(clk),
	.enable(enable),
	.instruction(regi_out)
);


//CPU_Registers
wire enable_write;
wire output_enable;
wire [7:0]data_in;
wire [7:0]reg_a;
wire [7:0]reg_b;

//Register
wire [3:0]opcode;
wire [3:0]rs;
wire [3:0]rt;
wire [3:0]rd;

//register
wire [7:0]data_out;

cpu_registers cpu_r(
	.clk(clk),
	.rst(rst),
	.data_in(data_in),
	.rs(rs),
	.rt(rt),
	.rd(rd),
	.enable_write(enable_write),
	.output_enable(output_enable),
	.reg_a(reg_a),
	.reg_b(reg_b),
	.data_out(data_out)
);

//RESULT
wire eo;
result re(
	.clk(clk),
	.eo(eo),
	.addr(rd),
	.in(data_out)
	);

//ALU
wire enable_alu;
wire flag_carry;
wire flag_zero;
wire [7:0]alu_out;
alu alu1(
	.enable_alu(enable_alu),
	.clk(clk),
	.opcode(opcode),
	.in_a(reg_a),
	.in_b(reg_b),
	.shamp(shamp),
	.alu_out(alu_out),
	.flag_zero(flag_zero),
	.flag_carry(flag_carry)
);


//Intruction Opcode
wire [23:0]instruction;
wire [3:0]state;
wire allow_jump;
wire allow_up;

assign data_in =  alu_out;
assign instruction =  regi_out;
assign opcode = instruction[23:20];
assign rs = instruction[19:16];
assign rt = instruction[15:12];
assign rd = instruction[11:8];
assign shamp =  instruction[7:0];
assign allow_jump = (opcode == 4'b1111)?1:0;

assign jump = (state == STATE_BUFFER & allow_jump)?1:0;
assign up = (state == STATE_PC & allow_up)?1:0;
assign er = (state == STATE_RAM)?1:0; 
assign enable = (state == STATE_IR)?1:0;
assign output_enable = (state == STATE_REGISTER_OUT)?1:0;
assign enable_alu = (state == STATE_ALU)?1:0;
assign enable_write = (state == STATE_ALU_OUT)?1:0;
assign eo = (state == STATE_REGISTER_OUT | state == STATE_ROM)?1:0;

//Control
control_cpu control_path(
	.clk(clk),
	.rst(rst),
	.opcode(opcode),
	.state(state),
	.allow_up(allow_up)
);

endmodule

