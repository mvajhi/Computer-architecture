module inst_mem(
    input [31:0] A,
    output reg [31:0] RD
);
    reg [31:0] mem [15999:0];
    initial begin
        $readmemh("inst.mem", mem);
    end
    assign RD = mem[A[31:2]];
endmodule
