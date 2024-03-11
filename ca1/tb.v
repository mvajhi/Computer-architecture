`timescale 1ns/1ns
module tb();
    // 32.5 / 4.25 = 4.48
    // reg [9:0]a_in=10'b1000001000;
    // reg [9:0]b_in=10'b0001110100;

    // 32/0.75 = 
    reg [9:0]a_in=10'b1111110000;
    reg [9:0]b_in=10'b0000001100;
    reg start=1'b0;
    reg clk=1'b0;
    reg sclr=1'b1;
    wire [9:0]q_out;
    wire dvz;
    wire ovf;
    wire busy;
    wire valid;
    main MAIN(a_in,b_in,start,clk,sclr,dvz,ovf,busy,valid,q_out);
    always #10 clk = ~clk;
    initial begin
        #10 sclr=1'b0;
        #20 start=1'b1;
        #1000 $stop;
    end
    

endmodule