module main(
        input [9:0]in_a,
        input [9:0]in_b,
        input start,
        input clk,
        input sclr,
        input dvz,
        input ovf,
        input busy,
        input valid,
        output [9:0]qout
        );
    wire co,be,inc_counter,ld_Q,ld_ACC,ld_B,ld_counter,dp_ovf,dp_dvz;
    wire [1:0] select;
    controller CONTROLLER(start,
                          dp_dvz,
                          dp_ovf,
                          co,
                          clk,
                          sclr,
                          be,
                          valid,
                          inc_counter,
                          ld_Q,
                          ld_ACC,
                          ld_B,
                          ld_counter,
                          select,
                          busy,
                          ovf,
                          dvz);
    Data_path DATA_PATH(clk,
                        sclr,
                        in_a,
                        in_b,
                        inc_counter,
                        ld_counter,
                        ld_B,
                        ld_Q,
                        ld_ACC,
                        select,
                        select,
                        dp_dvz,
                        dp_ovf,
                        co,
                        be,
                        qout);

endmodule