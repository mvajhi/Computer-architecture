module logic (
    input Zero,
    input Neg,
    input [1:0] Jump,
    input [2:0] Branch,
    output reg [1:0] PCSrc
);
    `include "constants.vh"
    always @(*) begin
        PCSrc = PC_4;
        case(Jump)
            JumpJal: PCSrc = PC_imm;
            JumpJalr: PCSrc = PC_reg_imm;
        endcase
        
        case(Branch)
            B_type_beq: PCSrc = Zero ? PC_imm : PC_4;
            B_type_bne: PCSrc = Zero ? PC_4 : PC_imm;
            B_type_blt: PCSrc = Neg ? PC_imm : PC_4;
            B_type_bge: PCSrc = Neg ? PC_4 : PC_imm;
        endcase
    end
endmodule