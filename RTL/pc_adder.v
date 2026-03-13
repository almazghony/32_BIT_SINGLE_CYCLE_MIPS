module pc_adder #(
    parameter ADDR_SIZE = 32
)(
    input   [ADDR_SIZE-1 : 0] read_address,
    output  [ADDR_SIZE-1 : 0] pc_plus4
);

    assign pc_plus4 = read_address + 4;

endmodule