module Data_path (
    input clk,
    input sclr,
    input [9:0] in_a,
    input [9:0] in_b,
    input increace_counter,
    input ld_counter,
    input ld_b,
    input ld_q,
    input ld_acc,
    input [1:0] select_q,
    input [1:0] select_acc,
    output dvz,
    output ovf,
    output co_counter,
    output be,
    output [9:0] q_out
);
    
endmodule

module (#parameter bit = 10) Reg (
    input clk,
    input rst,
    input ld,
    input [bit - 1:0] par_in,
    output reg [bit - 1:0] par_out
);
    always @(posedge clk) begin
        if (rst == 1'b1)
            par_out <= bit'b0;
        else if (ld == 1'b1)
            par_out <= par_in;
    end
endmodule