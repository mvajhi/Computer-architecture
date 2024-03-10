module main(input [9:0]a_in,[9:0]b_in,start,clk,sclr,
            output [9:0]qout,dvz,ovf,busy,valid);
    wire co,be,inc_counter,ld_Q,ld_ACC,ld_B,ld_counter,dp_ovf;
    wire [1:0] select;
    controller CONTROLLER(start,dvz,dp_ovfovf,co,clk,sclr,be,valid,inc_counter,
                        ld_Q,ld_ACC,ld_B,ld_counter,select,busy);
    Data_path DATA_PATH(clk,sclr,in_a,in_b,inc_counter,
                        ld_counter,ld_B,ld_Q,ld_ACC,
                        select,select,dvz,dp_ovf,co,be,q_out)

endmodule