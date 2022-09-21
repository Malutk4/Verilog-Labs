`include "defines.v"

module ALURISC (
  input  [4:0]  	ALUOp,
  input  [31:0]  	A,
  input  [31:0] 	B,
  output reg [31:0] 	Result,
  output reg       	Flag
);

always @ (*) begin
	case (ALUOp)
		`ALU_ADD:	Result = A + B;
		`ALU_SUB:	Result = A - B;
		`ALU_XOR:	Result = A ^ B;
		`ALU_OR:	Result = A | B;
		`ALU_AND:	Result = A & B;
		`ALU_SRA:	Result = $signed(A) >>> B;
		`ALU_SRL:	Result = A >> B;
		`ALU_SLL:	Result = A << B;
		`ALU_SLTS:	Result = $signed(A < B);
		`ALU_SLTU:	Result = A < B;
		default:    Result = 0;
	endcase
end

always @ (*) begin
	case (ALUOp)
		`ALU_LTS:	Flag = $signed(A < B);
		`ALU_LTU:	Flag = A < B;
		`ALU_GES:	Flag = $signed(A >= B);
		`ALU_GEU:	Flag = A >= B;
		`ALU_EQ:	Flag = A == B;
		`ALU_NE:	Flag = A != B;
		default:    Flag = 0;
	endcase
end

endmodule