// TODO fix value
`define par_in_counter 4'd3
`define counter_if_value 4'd9
module Data_path (
    input clk,
    input sclr,
    input [9:0] in_A,
    input [9:0] in_B,
    input increace_counter,
    input ld_counter,
    input ld_B,
    input ld_Q,
    input ld_ACC,
    input [1:0] select_Q,
    input [1:0] select_ACC,
    output dvz,
    output ovf,
    output co_counter,
    output be,
    output [9:0] q_out
);
    wire [10:0] ACC, ACC_next, ACC_in, ACC_sub, ACC_else;
    wire [10:0] Q, Q_next, Q_in, Q_sub, Q_else;
    wire [10:0] sub_out;
    wire [9:0] B;
    wire [3:0] count_out;

    assign {ACC_in, Q_in} = {10'b0, in_A, 1'b0};

    assign {ACC_sub, Q_sub} = {sub_out[9:0], Q, 1'b1};

    assign {ACC_else, Q_else} = {ACC[9:0], Q, 1'b10};

    // Reg
    Reg #(11) ACC_reg (clk, sclr, ld_ACC, ACC_next, ACC);
    Reg #(10) Q_reg (clk, sclr, ld_Q, Q_next, Q);
    Reg #(10) Q_reg (clk, sclr, ld_B, in_B, B);

    // Counter
    Counter counter (clk, sclr, increace_counter, ld_counter,
                     par_in_counter, co_counter, count_out);
    
    //MUX
    MUX #(11) ACC_MUX (select_ACC, {11'b0, ACC_in, ACC_sub, ACC_else}, ACC_next);
    MUX #(10) Q_MUX (select_Q, {10'b0, Q_in, Q_sub, Q_else}, Q_next);

    // Sub
    Subtractor subtractor (ACC, {1'b0, B}, sub_out);

    // Comparator
    Comparator_be cmp (ACC, {1'b0, Q}, be);

    //Gates
    assign ovf = (|Q_next) | (~|(counter_if_value ^ count_out));
    assign dvz = ~|B;
endmodule

module #(parameter bit = 10) Reg (
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

module Counter (
    input clk,
    input rst,
    input inc,
    input ld,
    input [3:0] par_in,
    output co,
    output reg [3:0] par_out
);
    always @(posedge clk) begin
        if (rst == 1'b1)
            par_out <= 4'b0;
        else if (ld == 1'b1)
            par_out <= par_in;
        else if (inc == 1'b1)
            par_out <= par_out + 1;
    end

    assign co = &par_out;
endmodule

module #(parameter bit = 10) MUX (
    input [1:0] select,
    input [bit - 1:0] inp [3:0],
    output [bit - 1:0] out
);
    assign out = (select == 2'b00) ? inp[0]: 
                 (select == 2'b01) ? inp[1]: 
                 (select == 2'b10) ? inp[2]: 
                 (select == 2'b11) ? inp[3]: bit'bx;
endmodule

module Subtractor (
    input [10:0] first,
    input [10:0] second,
    output [10:0] out
);
    assign out = first - second;
endmodule

module Comparator_be (
    input [10:0] big,
    input [10:0] small,
    output out
);
    assign out = big >= small;
endmodule