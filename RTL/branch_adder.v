module branch_adder (
    input [31:0] pc_plus4,
    input [31:0] shifted_imm,
    output [31:0] pc_branch
);

    assign pc_branch = shifted_imm + pc_plus4;
endmodule