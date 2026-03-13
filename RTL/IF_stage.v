module IF_stage #(
    parameter MEM_WIDTH = 32,
    parameter ADDR_SIZE = 32
)(
    input [ADDR_SIZE-1 : 0]     next_pc,
    input                       rst,
    input                       clk,
    output [MEM_WIDTH-1 : 0]    instruction,
    output [ADDR_SIZE-1 : 0]    pc_plus4
);

    wire [ADDR_SIZE-1: 0] read_address;

    program_counter PC (
        .next_pc(next_pc),
        .rst(rst),
        .clk(clk),
        .read_address(read_address)
    );

    pc_adder PC_ADD (
        .read_address(read_address),
        .pc_plus4(pc_plus4)
    );

    instruction_memory INSTR_MEM (
        .read_address(read_address),
        .instruction(instruction)
    );

    
endmodule