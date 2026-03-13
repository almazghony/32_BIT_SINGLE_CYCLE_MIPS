module control_unit (
    input [5:0]      opcode,
    output reg       RegDst,  
    output reg       Branch,  
    output reg       MemRead,
    output reg       MemtoReg,
    output reg [1:0] ALUOp,
    output reg       MemWrite,
    output reg       ALUSrc,
    output reg       RegWrite,
    output reg       Jump
);
    localparam ON  = 1'b1;
    localparam OFF = 1'b0;

    localparam ALUOP_ADD  = 2'b00;
    localparam ALUOP_SUB  = 2'b01;
    localparam ALUOP_AND  = 2'b11;
    localparam ALUOP_FUNC = 2'b10;
    
    localparam R_TYPE  = 6'b000000;
    localparam ADDI    = 6'b001000;  
    localparam ANDI    = 6'b001100;  
    localparam LW      = 6'b100011;
    localparam SW      = 6'b101011;
    localparam BEQ     = 6'b000100;
    localparam J       = 6'b000010; 

    // localparam OP_ADDI  = 6'b001000;
 

    always @(*) begin
        RegDst = OFF;  
        Branch = OFF;  
        MemRead = OFF;
        MemtoReg = OFF;
        ALUOp = ALUOP_ADD;
        MemWrite = OFF;
        ALUSrc = OFF;
        RegWrite = OFF;
        Jump = OFF;
        
        case(opcode)
            R_TYPE: begin
                RegDst = ON;
                ALUOp = ALUOP_FUNC;
                RegWrite = ON;
            end
            ADDI: begin
                RegWrite = ON;
                ALUSrc = ON;
                ALUOp = ALUOP_ADD;
            end
            ANDI: begin
                RegWrite = ON;
                ALUSrc = ON;
                ALUOp = ALUOP_AND;
            end
            LW: begin
                MemRead = ON;
                MemtoReg = ON;
                ALUOp = ALUOP_ADD;
                ALUSrc = ON;
                RegWrite = ON;
            end
            SW: begin
                ALUOp = ALUOP_ADD;
                MemWrite = ON;
                ALUSrc = ON;
            end
            
            BEQ: begin
                Branch    = ON;
                ALUOp     = ALUOP_SUB;
            end
            J:    
                Jump = ON; 
            
            default: begin
                RegDst = OFF;  
                Branch = OFF;  
                MemRead = OFF;
                MemtoReg = OFF;
                ALUOp = ALUOP_ADD;
                MemWrite = OFF;
                ALUSrc = OFF;
                RegWrite = OFF;
                Jump = OFF;
            end
        endcase
    end



endmodule