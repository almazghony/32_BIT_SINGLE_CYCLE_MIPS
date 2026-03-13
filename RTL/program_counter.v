module program_counter #(
    parameter ADDR_SIZE = 32
)(
    input      [ADDR_SIZE-1 : 0]    next_pc,
    input                           rst,
    input                           clk,
    output reg [ADDR_SIZE-1 : 0]    read_address
);

    always @(posedge clk, posedge rst) begin
        if (rst)
            read_address <= {ADDR_SIZE{1'b0}};
        else
            read_address <= next_pc;
    end
    
endmodule