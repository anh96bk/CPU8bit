module control_cpu(
	input clk,rst,
	input [3:0]opcode,
	output reg [3:0]state,
	output reg allow_up
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
						
						
parameter JUMP = 4'b1111;
						
initial
begin
	state <= IDLE;
	allow_up = 0;
end
	
						
always @(posedge clk)
begin
	if(rst)
	begin
		state <= IDLE;
	end else
	case(state)
		IDLE:
			begin
				state <= STATE_PC;
			end
		STATE_PC:
			begin
				state <= STATE_RAM;
			end
		STATE_RAM:
			begin
				allow_up = 0;
				state <= STATE_IR;
			end
		STATE_IR:
		begin
			state <= STATE_BUFFER;
		end
		STATE_BUFFER:
		begin
			if(opcode == JUMP)
			begin
				state <= STATE_JUMP;
			end
			else begin
				state <= STATE_REGISTER_IN;
			end
		end
		STATE_REGISTER_IN:
			begin
				state <= STATE_ALU;
			end
		STATE_ALU:
			begin
				state <= STATE_ALU_OUT;
			end
		STATE_ALU_OUT:
			begin
				allow_up = 1;
				state <= STATE_REGISTER_OUT;
			end
		STATE_REGISTER_OUT:
		begin
			state <= STATE_ROM;
		end
		STATE_ROM:
		begin
			state <= STATE_PC;
		end
		STATE_JUMP:
		begin
			state <= STATE_RAM;
		end
		default: state <= IDLE;
	endcase
end
					
endmodule