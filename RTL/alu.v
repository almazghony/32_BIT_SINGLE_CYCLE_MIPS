module alu 
(
    input       [31:0]  in1_alu,
    input       [31:0]  in2_alu,
    input       [3:0]   ALUCtrl,
    input       [4:0]   shamt,
    output              zero,
    output reg  [31:0]  result
);

    assign zero = (result == 32'b0);
    always @(*) begin
        case (ALUCtrl)
            4'b0000: result = in1_alu & in2_alu;
            4'b0001: result = in1_alu | in2_alu;
            4'b0010: result = in1_alu + in2_alu;
            4'b0110: result = in1_alu - in2_alu;
            4'b0111: result = (in1_alu < in2_alu);
            4'b1100: result = ~(in1_alu | in2_alu);
            4'b1000: result = in2_alu << shamt;
            4'b1001: result = in2_alu >> shamt;
            4'b1010: result = $signed(in2_alu) >>> shamt;
            default: result = 0;
        endcase
    end
endmodule