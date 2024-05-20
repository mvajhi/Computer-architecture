module PC (
    input clk,
    input rst,
    input [31:0] data_in,
    input enable,
    output reg [31:0] data_out
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            data_out <= 32'b0;
        else if(enable)
            data_out <= data_in;
    end

endmodule