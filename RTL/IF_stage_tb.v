module IF_stage_tb;

    parameter MEM_WIDTH = 32;

    reg                     rst;
    reg                     clk;
    wire [MEM_WIDTH-1 : 0]  instruction;

    IF_stage IF_stage_dut (
        .rst(rst),
        .clk(clk),
        .instruction(instruction)
    );

    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $readmemh("inst_mem.dat", IF_stage_dut.INSTR_MEM.inst_mem);
        rst = 1;
        @(negedge clk);
        rst = 0;

        repeat(10) @(negedge clk);

        $stop;
    end
endmodule