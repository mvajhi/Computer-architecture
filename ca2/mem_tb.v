module memory_tb;
    reg clk, rst, We;
    reg [31:0] A, WD;
    wire [31:0] RD;

    // Instantiate the memory module
    memory mem_inst (
        .A(A),
        .WD(WD),
        .clk(clk),
        .rst(rst),
        .We(We),
        .RD(RD)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initialize signals
    initial begin
        clk = 0;
        rst = 1;
        We = 0;
        A = 0;
        WD = 0;

        // Reset sequence
        #10 rst = 0;
        #10 rst = 0;

        // Write operation
        #10 We = 1;
        #10 A = 100; // Example address
        #10 WD = 32'h00000011; // Example data
        We = 1;

        // Read operation
        #10 A = 100; // Same address as before
        #10 We = 0;

        // Add more test cases as needed

        $finish;
    end
endmodule
