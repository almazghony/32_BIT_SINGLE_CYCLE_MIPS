module instruction_memory #(
    parameter MEM_WIDTH = 32,
    parameter MEM_DEPTH = 1024, //206
    parameter ADDR_SIZE = 32
)(
    input  [ADDR_SIZE-1 : 0] read_address,
    output [MEM_WIDTH-1 : 0] instruction
);


    // memory array
    //assume it is loaded by the OS
    //for simulation purpose, it will be loaded by the testbecnh
    reg [MEM_WIDTH-1 : 0] inst_mem [MEM_DEPTH-1 : 0];

    assign instruction = inst_mem[read_address[31 : 2]];
endmodule