module register_file (
    input           clk,
    input           RegWrite,
    input [4:0]     write_reg,
    input [31:0]    write_data,
    input [4:0]     read_reg1,
    input [4:0]     read_reg2,
    output [31:0]   read_data1,
    output [31:0]   read_data2
);

    reg [31:0] registers [0:31];

    // Write on clock edge (ignore writes to $0)
    always @(posedge clk) begin
        if (RegWrite && write_reg != 0)
            registers[write_reg] <= write_data;
    end

    // Async read (force $0 to 0)
    assign read_data1 = (read_reg1 == 0) ? 32'b0 : registers[read_reg1];
    assign read_data2 = (read_reg2 == 0) ? 32'b0 : registers[read_reg2];
    
endmodule