`define par_in_counter 4'd1
`define counter_if_value 4'd10
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
    output [9:0] Q_out
);
    wire [10:0] ACC, ACC_next, ACC_in, ACC_sub, ACC_else;
    wire [9:0] Q, Q_next, Q_in, Q_sub, Q_else;
    wire [10:0] sub_out;
    wire [9:0] B;
    wire [3:0] count_out;

    assign Q_out = Q;

    assign {ACC_in, Q_in} = {10'b0, in_A, 1'b0};

    assign {ACC_sub, Q_sub} = {sub_out[9:0], Q, 1'b1};

    assign {ACC_else, Q_else} = {ACC[9:0], Q, 1'b10};

    // Reg
    Reg #(.bit(11)) ACC_reg (clk, sclr, ld_ACC, ACC_next, ACC);
    Reg #(.bit(10)) Q_reg (clk, sclr, ld_Q, Q_next, Q);
    Reg #(.bit(10)) B_reg (clk, sclr, ld_B, in_B, B);

    // Counter
    Counter counter (clk, sclr, increace_counter, ld_counter,
                     `par_in_counter, co_counter, count_out);
    
    //MUX
    MUX #(.bit(11)) ACC_MUX (select_ACC, 11'b0, ACC_in, ACC_sub, ACC_else, ACC_next);
    MUX #(.bit(10)) Q_MUX (select_Q, 10'b0, Q_in, Q_sub, Q_else, Q_next);

    // Sub
    Subtractor subtractor (ACC, {1'b0, B}, sub_out);

    // Comparator
    Comparator_be cmp (ACC, {1'b0, B}, be);

    //Gates
    assign ovf = (|Q_next[9:4]) & (~(|(`counter_if_value ^ count_out)));
    assign dvz = ~|in_B;
endmodule

module Reg #(parameter bit = 10) (
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

module MUX #(parameter bit = 10) (
    input [1:0] select,
    input [bit-1:0] inp_0,
    input [bit-1:0] inp_1,
    input [bit-1:0] inp_2,
    input [bit-1:0] inp_3,
    output [bit-1:0] out
);
    assign out = (select == 2'b00) ? inp_0: 
                 (select == 2'b01) ? inp_1: 
                 (select == 2'b10) ? inp_2: 
                 (select == 2'b11) ? inp_3: {bit{1'bx}};
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
    input [10:0] Small,
    output out
);
    assign out = big >= Small;
endmodule