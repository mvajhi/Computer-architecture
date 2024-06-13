module logic (
    input Zero,
    input Neg,
    input [1:0] Jump,
    input [2:0] Branch,
    output [1:0] PCSrc
);
    // Jump
    parameter JumpJal = 2'b00;
    parameter JumpJalr = 2'b01;
    parameter J_disable = 2'b10;

    // func3 B type code
    parameter func3_B_type_beq = 3'b000;
    parameter func3_B_type_bne = 3'b001;
    parameter func3_B_type_blt = 3'b100;
    parameter func3_B_type_bge = 3'b101;
    parameter B_disable = 3'b110;

    // PCSrc
    parameter PC_4 = 2'b00;
    parameter PC_reg_imm = 2'b01;
    parameter PC_imm = 2'b10;

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