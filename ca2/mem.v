module memory(
    input [31:0] A,
    input [31:0]WD,
    input clk, rst, We,
    output reg [31:0] RD
);
    reg [31:0] mem [0:9];
    initial begin
        $readmemb("data.mem", mem);
    end

    always @(posedge clk) begin
        if (We) begin
            mem[A] <= WD;
        end
    end
    assign RD = mem[A[31:2]];
endmodule
