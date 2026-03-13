module shift_left2 #(
    parameter IN_WIDTH = 32,
    parameter OUT_WIDTH = 32
)(
    input [IN_WIDTH-1:0] in,
    output [OUT_WIDTH-1:0] out
);

    assign out = in << 2;
endmodule