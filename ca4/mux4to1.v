module multiplexer_4to1 (
    input [1:0] S, 
    input [31:0] D0,
    input [31:0] D1,
    input [31:0] D2,
    input [31:0] D3, 
    output [31:0]Y 
);
    assign Y = (S == 2'b00) ? D0 :
               (S == 2'b01) ? D1 :
               (S == 2'b10) ? D2 :
               (S == 2'b11) ? D3 : 4'b0;
endmodule