module ALU (
    input signed [31:0] A,
    input signed [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] ALUResult,
    output reg Zero,
    output reg Neg
);
    `include "constants.vh"
    always @(*) begin
        case(ALUOp)
            op_add: ALUResult = A + B;
            op_sub: ALUResult = A - B;
            op_and: ALUResult = A & B;
            op_or: ALUResult = A | B;
            op_slt: ALUResult = A < B;
            op_sltu: ALUResult = $unsigned(A) < $unsigned(B);
            op_xor: ALUResult = A ^ B;
        endcase
    end
    assign Zero = (ALUResult == 0);
    assign Neg =  ALUResult[31];
endmodule