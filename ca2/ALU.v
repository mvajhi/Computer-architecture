module ALU (
    input signed [31:0] A,
    input signed [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] ALUResult,
    output reg Zero
);
    always @(*) begin
        case(ALUOp)
            3'b000: ALUResult = A + B;
            3'b001: ALUResult = A - B;
            3'b010: ALUResult = A & B;
            3'b011: ALUResult = A | B;
            3'b100: ALUResult = A < B;
            3'b101: ALUResult = $unsigned(A) < $unsigned(B);
        endcase
    end
    assign Zero = (ALUResult == 0);
endmodule