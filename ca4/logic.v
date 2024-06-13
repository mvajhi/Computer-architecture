module logic (
    input Zero,
    input Neg,
    input [1:0] Jump,
    input [2:0] Branch,
    output [1:0] PCSrc
);
    `include "constants.v"
    always @(*) begin
        PCSrc = PC_4;
        case(Jump)
            JumpJal: PCSrc = PC_imm;
            JumpJalr: PCSrc = PC_reg_imm;
        endcase
        
        case(Branch)
            func3_B_type_beq: pc_en = zero ? PC_imm : PC_4;
            func3_B_type_bne: pc_en = zero ? PC_4 : PC_imm;
            func3_B_type_blt: pc_en = negetive ? PC_imm : PC_4;
            func3_B_type_bge: pc_en = negetive ? PC_4 : PC_imm;
        endcase
    end
endmodule