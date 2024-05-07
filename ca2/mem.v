module memory(
    input [31:0] A,
    input WD,
    input clk, rst, We,
    output reg [31:0] RD
);
    reg [31:0] mem [15999:0];
    integer i;

    always @(A or posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 16000; i = i + 1) begin
                mem[i] <= 32'b0;
            end
        end else if (We) begin
            mem[A[31:2]] <= WD;
        end
    end

    assign RD = mem[A[31:2]];
endmodule
