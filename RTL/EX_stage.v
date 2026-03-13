module EX_stage (
    input [3:0]     ALUCtrl,
    input           RegWrite,
    input           ALUSrc,
    input           clk,
    input [4:0]     shamt,
    input [4:0]     read_reg1,
    input [4:0]     read_reg2,
    input [4:0]     write_reg,
    input [31:0]    MUX_MemtoReg_out,
    input [31:0]    immediate_ext,
    output [31:0]   result,
    output [31:0]   read_data2,
    output          zero
);

    wire [31:0] mux_ALUSrc_out;
    wire [31:0] read_data1;

    mux2X1 #(32) mux_ALUSrc (
        .in1(read_data2), 
        .in2(immediate_ext),
        .sel(ALUSrc),
        .out(mux_ALUSrc_out)
    );
    
    register_file reg_file (
        .clk(clk),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(MUX_MemtoReg_out),
        .RegWrite(RegWrite),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    alu alu_unit (
        .in1_alu(read_data1),
        .in2_alu(mux_ALUSrc_out),
        .shamt(shamt),
        .ALUCtrl(ALUCtrl),
        .zero(zero),
        .result(result)
    );

endmodule