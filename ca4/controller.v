module controller(
    input [6:0] op,
    input [2:0] func3,
    input [6:0] func7,
    output reg RegWrite,
    output reg [1:0] ResultSrc,
    output reg MemWrite,
    output reg [1:0] Jump,
    output reg [2:0] Branch,
    output reg [2:0] ALUControl,
    output reg ALUSrc,
    output reg [2:0] ImmSrc
);
    `include "constants.vh"
    always @(*) begin
        {RegWrite, ResultSrc, MemWrite, Jump, Branch, ALUControl, ALUSrc, ImmSrc} = 16'b0;
        case(op)
            R_type: begin
                RegWrite = 1'b1;
                ResultSrc = Result_ALU;
                ALUSrc = ALU_src_reg;

                MemWrite = 1'b0;
                Jump = J_disable;
                Branch = B_disable;
                ImmSrc = imm_default;

                case(func7)
                    func7_R_type_default:
                        case(func3)
                            func3_R_type_add_sub: ALUControl = op_add;
                            func3_R_type_sll: ALUControl = op_default;
                            func3_R_type_slt: ALUControl = op_slt;
                            func3_R_type_sltu: ALUControl = op_sltu;
                            func3_R_type_xor: ALUControl = op_xor;
                            func3_R_type_or: ALUControl = op_or;
                            func3_R_type_and: ALUControl = op_and;
                        endcase
                    func7_R_type_sub:
                        if (func3 == func3_R_type_add_sub)
                            ALUControl = op_sub;
                endcase
            end

            I_type_alu: begin
                RegWrite = 1'b1;
                ResultSrc = Result_ALU;
                ALUSrc = ALU_src_imm;
                ImmSrc = imm_I_type;

                MemWrite = 1'b0;
                Jump = J_disable;
                Branch = B_disable;

                case(func3)
                    func3_I_type_addi: ALUControl = op_add;
                    func3_I_type_slti: ALUControl = op_slt;
                    func3_I_type_sltiu: ALUControl = op_sltu;
                    func3_I_type_xori: ALUControl = op_xor;
                    func3_I_type_ori: ALUControl = op_or;
                    func3_I_type_andi: ALUControl = op_and;
                endcase
            end

            I_type_load: begin
                RegWrite = 1'b1;
                ResultSrc = Result_mem;
                ALUSrc = ALU_src_imm;
                ALUControl = op_add;
                ImmSrc = imm_I_type;

                MemWrite = 1'b0;
                Jump = J_disable;
                Branch = B_disable;
            end

            I_type_jump: begin
                RegWrite = 1'b1;
                ResultSrc = Result_PC;
                ALUSrc = ALU_src_imm;
                ALUControl = op_add;
                Jump = JumpJalr;
                ImmSrc = imm_I_type;

                MemWrite = 1'b0;
                Branch = B_disable;
            end

            S_type: begin
                ALUSrc = ALU_src_imm;
                ALUControl = op_add;
                MemWrite = 1'b1;
                ImmSrc = imm_S_type;

                RegWrite = 1'b0;
                Jump = J_disable;
                Branch = B_disable;
                ResultSrc = Result_ALU;
            end

            B_type: begin
                ALUSrc = ALU_src_reg;
                ALUControl = op_sub;
                ImmSrc = imm_B_type;

                RegWrite = 1'b0;
                Jump = J_disable;
                MemWrite = 1'b0;
                ResultSrc = Result_ALU;

                case(func3)
                    func3_B_type_beq : Branch = B_type_beq;
                    func3_B_type_bne : Branch = B_type_bne;
                    func3_B_type_blt : Branch = B_type_blt;
                    func3_B_type_bge : Branch = B_type_bge;
                endcase
            end

            J_type: begin
                RegWrite = 1'b1;
                ResultSrc = Result_PC;
                Jump = JumpJal;
                ImmSrc = imm_J_type;

                MemWrite = 1'b0;
                Branch = B_disable;
                ALUControl = op_add;
                ALUSrc = ALU_src_imm;
            end

            U_type: begin
                RegWrite = 1'b1;
                ResultSrc = Result_imm;
                ImmSrc = imm_U_type;

                MemWrite = 1'b0;
                Jump = J_disable;
                Branch = B_disable;
                ALUControl = op_add;
                ALUSrc = ALU_src_imm;
            end
        endcase
    end
endmodule