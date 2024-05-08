module tb();
    reg clk;
    reg rst;

    processor dut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 1;
        #10 rst = 0;
    end
endmodule