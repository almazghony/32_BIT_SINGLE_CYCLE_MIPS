module mux2X1 #(
    parameter WIDTH = 32
)(
    input   [WIDTH-1:0] in1,
    input   [WIDTH-1:0] in2,
    input               sel,
    output  [WIDTH-1:0] out
);

    assign out = (sel) ? in2 : in1;
endmodule