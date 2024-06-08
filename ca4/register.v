module register #(parameter bit = 32) (
    input clk,
    input rst,
    input ld,
    input [bit - 1:0] par_in,
    output reg [bit - 1:0] par_out
);
    always @(posedge clk) begin
        if (rst == 1'b1)
            par_out <= 0;
        else if (ld == 1'b1)
            par_out <= par_in;
    end
endmodule