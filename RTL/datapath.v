module datapath (
    input  [1:0] ALUOp,
    input        MemtoReg,
    input        Branch,
    input        Jump,
    input        MemRead,
    input        MemWrite,
    input        RegWrite,
    input        RegDst,
    input        ALUSrc,
    input        clk,
    input        rst,
    output [5:0] opcode,
    output       zero
);

    wire [31:0] instruction;
    wire [4:0]  rs;
    wire [4:0]  rt;
    wire [4:0]  rd;
    wire [3:0]  ALUCtrl;
    wire [15:0] immediate;
    wire [4:0]  mux_RegDst_out;
    wire [4:0]  shamt;
    wire [5:0]  funct;
    wire [31:0] immediate_ext;
    wire [25:0] jump_addr;
    wire [31:0] alu_result;
    wire [31:0] read_data2;
    wire [31:0] read_data;
    wire [31:0] MUX_MemtoReg_out;
    wire [31:0] shifted_imm;
    wire [27:0] shifted_jump_address;
    wire [31:0] pc_plus4;
    wire [31:0] pc_branch;
    wire [31:0] next_pc;
    wire [31:0] pc_src_jump;
    wire [31:0] pc_src_branch;

    assign pc_src_jump = {pc_plus4[31:28], shifted_jump_address};
    assign BranchandZero = Branch & zero;
    IF_stage U_IF (
        .next_pc(next_pc),
        .rst(rst),
        .clk(clk),
        .instruction(instruction),
        .pc_plus4(pc_plus4)
    );

    ID_stage U_ID (
        .instruction(instruction),
        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct), 
        .immediate(immediate),
        .jump_addr(jump_addr)
    );

    sign_extend U1_signEX (
        .data_in(immediate),
        .data_out(immediate_ext)
    );

    mux2X1 #(5) mux_RegDst (
        .in1(rt), 
        .in2(rd),
        .sel(RegDst),
        .out(mux_RegDst_out)
    );

    alu_control U_ALUCrl (
        .ALUOp(ALUOp),
        .funct(funct),
        .ALUCtrl(ALUCtrl)
    );

    EX_stage U_EX (
        .ALUCtrl(ALUCtrl),
        .ALUSrc(ALUSrc),
        .shamt(shamt),
        .RegWrite(RegWrite),
        .clk(clk),
        .read_reg1(rs),
        .read_reg2(rt),
        .write_reg(mux_RegDst_out),
        .MUX_MemtoReg_out(MUX_MemtoReg_out),
        .immediate_ext(immediate_ext),
        .zero(zero),
        .result(alu_result),
        .read_data2(read_data2)
    );

    data_memory DATA_MEM (
        .address(alu_result),
        .write_data(read_data2),
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),   
        .read_data(read_data)
    );

    mux2X1 #(32) MUX_MemtoReg (
        .in1(alu_result),
        .in2(read_data),
        .sel(MemtoReg),
        .out(MUX_MemtoReg_out)
    );

    shift_left2 #(32, 32) U_shift_imm (
        .in(immediate_ext),
        .out(shifted_imm)
    );
    

    branch_adder BRANCH_ADD (
        .pc_plus4(pc_plus4),
        .shifted_imm(shifted_imm),
        .pc_branch(pc_branch)
    );

    mux2X1 #(32) U1_PCSrc (
        .in1(pc_plus4),
        .in2(pc_branch),
        .sel(BranchandZero),
        .out(pc_src_branch)
    );

    mux2X1 #(32) U2_PCSrc (
        .in1(pc_src_branch),
        .in2(pc_src_jump),
        .sel(Jump),
        .out(next_pc)
    );
  
    shift_left2 #(26, 28) U_shift_jump (
        .in(jump_addr),
        .out(shifted_jump_address)
    );
    
endmodule



