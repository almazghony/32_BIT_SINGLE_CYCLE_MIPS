module ID_stage (
    input  [31:0] instruction,
    output [5:0]  opcode,     
    output [4:0]  rs,         
    output [4:0]  rt,         
    output [4:0]  rd,         
    output [4:0]  shamt,      
    output [5:0]  funct,      
    output [15:0] immediate,  
    output [25:0] jump_addr   
);
    // --- Bit Slicing (Wiring) ---
    assign opcode = instruction[31:26];
    assign rs     = instruction[25:21];
    assign rt     = instruction[20:16];
    assign rd     = instruction[15:11];
    assign shamt  = instruction[10:6];
    assign funct  = instruction[5:0];

    // Immediate is the lower 16 bits
    assign immediate = instruction[15:0];

    // Jump address is the lower 26 bits
    assign jump_addr = instruction[25:0];

endmodule