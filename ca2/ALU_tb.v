module ALU_tb();
    reg signed [31:0] A, B;
    reg [2:0] ALUOp;
    wire [31:0] ALUResult;
    wire Zero;

    ALU dut (
        .A(A),
        .B(B),
        .ALUOp(ALUOp),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    initial begin
        A = 10;
        B = 5;
        ALUOp = 3'b000; // Addition operation

        #10;

        A = -5;
        B = 3;
        ALUOp = 3'b001; // Subtraction operation

        #10;

        A = 8;
        B = 3;
        ALUOp = 3'b010; // Bitwise AND operation

        #10;

        A = 5;
        B = 3;
        ALUOp = 3'b011; // Bitwise OR operation

        #10;

        A = 10;
        B = 15;
        ALUOp = 3'b100; // Less than operation

        #10;

        $finish;
    end
endmodule