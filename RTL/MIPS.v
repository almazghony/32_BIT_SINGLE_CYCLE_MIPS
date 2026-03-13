module MIPS (
    input rst,
    input clk
);

    wire [1:0] ALUOp;
    wire [5:0] opcode;
    wire       MemtoReg;
    wire       MemRead;
    wire       MemWrite;
    wire       RegWrite;
    wire       RegDst;
    wire       ALUSrc;
    wire       zero;
    wire       Branch;
    wire       Jump;

    datapath U_datapath (
        .ALUOp(ALUOp),
        .MemtoReg(MemtoReg),
        .Branch(Branch),
        .Jump(Jump),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .clk(clk),
        .rst(rst),
        .opcode(opcode),
        .zero(zero)
    );

    control_unit U_control_unit (
        .opcode(opcode),
        .RegDst(RegDst),  
        .Branch(Branch),  
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump)
    );

endmodule