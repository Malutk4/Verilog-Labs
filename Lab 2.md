# Лаба 2

Ну чо, сначала нам нужно создать файл, где мы будем ставить соответствие между командой, которую мы передаём на АЛУ и её текстовым названием. Впоследствии мы сможем передавать на АЛУ не 5 знаков, характеризующих команду, а название команды. Это будет применено в testbench. Если коммент обрезается, то там можно проскроллить влево-вправо код

```
`define ALU_OP_WIDTH  5

`define ALU_ADD   5'b00000
`define ALU_SUB   5'b01000

`define ALU_XOR   5'b00100
`define ALU_OR    5'b00110
`define ALU_AND   5'b00111

// shifts
`define ALU_SRA   5'b01101
`define ALU_SRL   5'b00101
`define ALU_SLL   5'b00001

// comparisons
`define ALU_LTS   5'b11100
`define ALU_LTU   5'b11110
`define ALU_GES   5'b11101
`define ALU_GEU   5'b11111
`define ALU_EQ    5'b11000
`define ALU_NE    5'b11001

// set lower than operations
`define ALU_SLTS  5'b00010
`define ALU_SLTU  5'b00011
```

Теперь пишем сам АЛУ. Суть его работы - получать команду, получать две переменных, делать операцию и выдавать результат. Чо как работает распишу в комментариях в коде

```
`include "defines.v" //подключаем наше соответствие операций и названий, который мы написали ранее

module ALURISC (
  input  [4:0]  	ALUOp, //сигнал операции пятибитовый, поэтому тип входного сигнала соответствующий
  input  [31:0]  	A, //переменные, с которыми будет проводиться операция. Они, собсна, 32-х разрядные
  input  [31:0] 	B,
  output reg [31:0] 	Result, //результат для операций, выдающих какое-то значение
  output reg       	Flag //результат для операций сравнения. Может быть только 0 и 1. Reg нужен, но сам Солодовников сказал, что на самом деле они имеют не reg тип. Хз, по этому поводу всё равно вопросов не задают
);

always @ (*) begin //начинаем наш case. Эта собачка и звездочка отвечают за то, что наш АЛУ не хранит ничего в памяти. Он получил данные, обработал их и передал дальше
	case (ALUOp) //сам case. Если находит соответствие между входным сигналом и тем, что прописано ниже, выполняет операцию. Иначе исполняется команда, которую вы пропишете в default
		`ALU_ADD:	Result = A + B;
		`ALU_SUB:	Result = A - B;
		`ALU_XOR:	Result = A ^ B;
		`ALU_OR:	Result = A | B;
		`ALU_AND:	Result = A & B;
		`ALU_SRA:	Result = $signed(A) >>> B; //$signed отвечает за то, что мы работаем со знаковыми переменными. То есть, с учётом "+" и "-"
		`ALU_SRL:	Result = A >> B;
		`ALU_SLL:	Result = A << B;
		`ALU_SLTS:	Result = $signed(A < B);
		`ALU_SLTU:	Result = A < B;
		default:    Result = 0; //default нужен обязательно. Потому что на деле наш прибор при его отсутствии не будет делать ничего, а сам на рандом сделает что-то. Это приведёт к ошибке в его работе. А нам это не нада. Поэтому пишем дефолт
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
```

Ну, теперь testbench. Мы проводим проверку для одной пары переменных всеми командами, а для ещё двух только командами сравнения. Можно передавать команду как "5'b00001", а можно просто писать её название как в define "ALU_SLL". Вот и всё. По сути, ничем не отличается от тестбенча из предыдущей работы

```
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
```
