module tb();
    reg clk = 1'b0;
    reg rst;

    processor dut (
        .clk(clk),
        .rst(rst)
    );

    always #10 clk = ~clk;

    initial begin
        rst = 1;
        #11 rst = 0;
        #10000 $finish;
    end
endmodule