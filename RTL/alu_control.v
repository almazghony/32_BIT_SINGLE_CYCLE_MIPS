module alu_control (
    input      [1:0] ALUOp,
    input      [5:0] funct,
    output reg [3:0] ALUCtrl
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUCtrl = 4'b0010;
            2'b01: ALUCtrl = 4'b0110;
            2'b11: ALUCtrl = 4'b0000;
            2'b10: 
                case(funct)
                    6'h20: ALUCtrl = 4'b0010;
                    6'h24: ALUCtrl = 4'b0000;
                    6'h25: ALUCtrl = 4'b0001;
                    6'h22: ALUCtrl = 4'b0110;
                    6'h2a: ALUCtrl = 4'b0111;
                    6'h00: ALUCtrl = 4'b1000;
                    6'h02: ALUCtrl = 4'b1001;
                    6'h03: ALUCtrl = 4'b1010;
                    
                    default: ALUCtrl = 4'b0010;
                endcase
            default: ALUCtrl = 4'b0010;
        endcase

    end
endmodule