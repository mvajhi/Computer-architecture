module memory(
    input [31:0] A,
    input [31:0]WD,
    input clk, rst, We,
    output reg [31:0] RD
);
    reg [31:0] mem [15999:0];
    initial begin
        $readmemh("data.mem", mem);
    end

    assign RD = mem[A[31:2]];
endmodule
