module datapath_tb;

    reg [1:0] ALUOp,
    reg       MemtoReg,
    reg       MemRead,
    reg       MemWrite,
    reg       RegWrite,
    reg       RegDst,
    reg       ALUSrc,
    reg       clk,
    reg       rst,
    wire      zero

    datapath dut_db (
        .*
    );

    initial clk = 0;
    always #1 clk = ~clk;

    integer i;
    initial begin

    end
        

endmodule