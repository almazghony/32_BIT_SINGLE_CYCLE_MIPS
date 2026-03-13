module EX_stage_tb;
    reg  [3:0]     ALUCtrl;
    reg            RegWrite;
    reg            ALUSrc;
    reg            clk;
    reg  [4:0]     read_reg1;
    reg  [4:0]     read_reg2;
    reg  [4:0]     write_reg;
    reg  [31:0]    MUX_MemtoReg_out;
    reg  [31:0]    immediate_ext;
    wire [31:0]    result;
    wire [31:0]    read_data2;
    wire           zero;

    EX_stage dut_EX(
        .*
    );

    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        //R-type test
        RegWrite = 1;
        ALUSrc = 0;
        MUX_MemtoReg_out = 0;
        immediate_ext = 0;
    
        dut_EX.reg_file.registers[1] = 4'b1010;
        dut_EX.reg_file.registers[2] = 4'b1100;
        write_reg = 3;
        read_reg1 = 1;
        read_reg2 = 2;
        //Test AND
        ALUCtrl = 0;
        @(negedge clk);
        // Test ADD
        ALUCtrl = 2;
        @(negedge clk);
        //Test OR
        ALUCtrl = 1;
        @(negedge clk);
        //Test sub
        ALUCtrl = 6;
        @(negedge clk);
        //Test slt
        ALUCtrl = 12;
        @(negedge clk);
        $stop;
    end

endmodule