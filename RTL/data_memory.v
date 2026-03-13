module data_memory (
    input   [31:0] address,
    input   [31:0] write_data,
    input          clk,
    input          MemWrite,
    input          MemRead,    // for cash purposes
    output  [31:0] read_data
);

    reg [31:0] data_mem [0 : 256];

    always @(posedge clk) 
        if (MemWrite)
            data_mem[address] <= write_data;

    assign read_data = (MemRead) ? data_mem[address] : 0; 

endmodule