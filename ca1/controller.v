module controller (input start,
                   input dp_dvz,
                   input dp_ovf,
                   input co,
                   input clk,
                   input rst,
                   input be,
                   output reg valid,
                   output reg inc_counter,
                   output reg ld_Q,
                   output reg ld_ACC,
                   output reg ld_B,
                   output reg ld_counter,
                   output reg [1:0] select,
                   output reg busy,
                   output reg ovf,
                   output reg dvz
                   );
    parameter IDLE = 3'd0 , LOAD = 3'd1 , FOR = 3'd2 , UPDATE_ACC_AND_Q = 3'd3,SET_OUTPUT = 3'd4;
    reg [2:0] ps;
    reg [2:0] ns;

    always @(posedge clk) begin
        if(rst == 1'b1) 
            ps <= 3'b0;
        else ps <= ns;
    end

    always @(start,dp_dvz,dp_ovf,co,ps) begin
        ns = IDLE;
        case(ps)
            IDLE : ns = (start == 1'b0) ? IDLE :LOAD ;
            LOAD : ns = (dp_dvz == 1'b1) ? IDLE : FOR ;
            FOR : ns = (co == 1'b0) ? UPDATE_ACC_AND_Q : SET_OUTPUT;
            UPDATE_ACC_AND_Q : ns = (dp_ovf == 1'b0) ? FOR : IDLE;
            SET_OUTPUT : ns = IDLE;
            default : ns = IDLE;
        endcase
    end

    always @(start,dp_dvz,dp_ovf,co,ps) begin
        valid = 1'b0;
        inc_counter = 1'b0;
        ld_Q = 1'b0;
        ld_ACC = 1'b0;
        ld_B = 1'b0;
        ld_counter = 1'b0;
        select = 2'b00;
        busy = 1'b1;
        ovf = 1'b0;
        dvz = 1'b0;
        case (ps)
            IDLE : 
                begin
                    busy = 1'b0;
                end
            LOAD :  
                begin
                    ld_Q = 1'b1;
                    ld_ACC = 1'b1;
                    ld_counter = 1'b1;
                    ld_B = 1'b1;
                    select = 2'd1;
                    dvz = dp_dvz;
                end
            FOR :   
                begin
                    inc_counter = 1'b1;
                end
            UPDATE_ACC_AND_Q :  
                begin
                    ld_Q = 1'b1;
                    ld_ACC = 1'b1;
                    select = (be==1) ? 2'd2 : 2'd3;
                    ovf = dp_ovf;
                end
            SET_OUTPUT :
                begin
                    valid = 1'b1;  
                end
        endcase
    end
endmodule