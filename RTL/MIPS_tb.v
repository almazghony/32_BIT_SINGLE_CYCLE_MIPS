module MIPS_tb;

    reg rst;
    reg clk;

    MIPS dut (
        .*
    );

    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $readmemh("registers.dat", dut.U_datapath.U_EX.reg_file.registers);
        $readmemb("inst_mem.dat", dut.U_datapath.U_IF.INSTR_MEM.inst_mem);

        rst = 1;
        @(negedge clk);
        rst = 0;
        
        repeat(30) @(negedge clk);

        // Check registers
        if (dut.U_datapath.U_EX.reg_file.registers[9] != 0) begin
            $display("ADD failed");
            $stop;
        end

        if (dut.U_datapath.U_EX.reg_file.registers[11] != dut.U_datapath.U_EX.reg_file.registers[10] + dut.U_datapath.U_EX.reg_file.registers[9]) begin
            $display("ADD failed");
            $stop;
        end

        if (dut.U_datapath.U_EX.reg_file.registers[14] != dut.U_datapath.U_EX.reg_file.registers[13] - dut.U_datapath.U_EX.reg_file.registers[12]) begin
            $display("SUB failed");
            $stop;
        end

        if (dut.U_datapath.U_EX.reg_file.registers[17] != 1) begin
            $display("SLT failed");
            $stop;
        end

        if (dut.U_datapath.DATA_MEM.data_mem[0] != 32'h00000012) begin
            $display("SW failed");
            $stop;
        end

        if (dut.U_datapath.DATA_MEM.data_mem[1] != 32'h00000013) begin
            $display("SW failed");
            $stop;
        end

        if (dut.U_datapath.U_EX.reg_file.registers[20] != 32'h00000012) begin
            $display("LW failed");
            $stop;
        end

        if (dut.U_datapath.U_EX.reg_file.registers[20] != 32'h00000012) begin
            $display("LW failed");
            $stop;
        end

        $stop;
    end

endmodule