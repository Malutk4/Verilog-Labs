module testbench();    // <- Не имеет ни входов, ни выходов!
	
	reg [31:0] A;
	reg [31:0] B;
	reg [4:0] ALUOp;
	wire [31:0] Result;
	wire Flag;
	
	ALURISC DUT(         // <- Подключаем проверяемый модуль
	  .A(A),
	  .B(B),
	  .ALUOp(ALUOp),
	  .Result(Result),
	  .Flag(Flag)
	);
	
	initial begin
	    A = 52; B = 40; ALUOp = `ALU_ADD;
    #5;
        A = 52; B = 40; ALUOp = `ALU_SUB;
    #5;
        A = 52; B = 40; ALUOp = `ALU_XOR;
    #5;
        A = 52; B = 40; ALUOp = `ALU_OR;
    #5;
        A = 52; B = 40; ALUOp = `ALU_AND;
    #5;
        A = 52; B = 40; ALUOp = `ALU_SRA;
    #5;
        A = 52; B = 40; ALUOp = `ALU_SRL;
    #5;
        A = 52; B = 40; ALUOp = `ALU_SLL;
    #5;
        A = 52; B = 40; ALUOp = `ALU_SLTS;
    #5;
        A = 52; B = 40; ALUOp = `ALU_SLTU;
    #5;
        A = 52; B = 40; ALUOp = `ALU_LTS;
    #5;
        A = 52; B = 40; ALUOp = `ALU_LTU;
    #5;
        A = 52; B = 40; ALUOp = `ALU_GES;
    #5;
        A = 52; B = 40; ALUOp = `ALU_GEU;
    #5;
        A = 52; B = 40; ALUOp = `ALU_EQ;
    #5;
        A = 52; B = 40; ALUOp = `ALU_NE;
    #5;
    A = 52; B = 40; ALUOp = `ALU_ADD;
    #5;
        A = 52; B = 40; ALUOp = `ALU_EQ;
    #5;
    A = 52; B = 40; ALUOp = `ALU_LTU;
    #5;
        A = 52; B = 40; ALUOp = `ALU_GEU;
    #5;
        A = 40; B = 40; ALUOp = `ALU_ADD;
    #5;
        A = 40; B = 40; ALUOp = `ALU_EQ;
    #5;
    A = 40; B = 40; ALUOp = `ALU_LTU;
    #5;
        A = 40; B = 40; ALUOp = `ALU_GEU;
    #5;
            A = 40; B = 52; ALUOp = `ALU_ADD;
    #5;
        A = 40; B = 52; ALUOp = `ALU_EQ;
    #5;
    A = 40; B = 52; ALUOp = `ALU_LTU;
    #5;
        A = 52; B = 40; ALUOp = `ALU_GEU;
    #5;
	end
	
endmodule