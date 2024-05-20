module data_path(
    input clk,
    input rst,
    input pcen,
    input adrsrc,
    input memwrite,
    input irwrite,
    input regwrite,
    input [1:0]alusrca,
    input [1:0]alusrcb,
    input [2:0]aluop,
    input [1:0]resultsrc,
    input [2:0]immsrc,
    output neg,
    output zer,
    output [6:0]func7,
    output [2:0]func3,
    output [6:0]opcode
);
wire [31:0]resultdata;
wire [31:0]pcout;
//module PC (
//    input clk,
//    input rst,
//    input [31:0] data_in,
//    input enable
//    output reg [31:0] data_out
//);
//
//    always @(posedge clk or posedge rst) begin
//        if (rst)
//            data_out <= 32'b0;
//        else
//            data_out <= data_in;
//    end
//
//endmodule
PC pc(clk,rst,resultdata,pcen,pcout);
wire [31:0]aluoutdata;
wire [31:0] memadr;
// module multiplexer_2to1 (
//     input wire S, 
//     input wire [31:0]D0, 
//     input wire [31:0]D1, 
//     output wire [31:0]Y 
// );
//     assign Y = (S == 1'b0) ? D0 : D1;
// endmodule
multiplexer_2to1 memadrselect(adrsrc,pcout,aluoutdata,memadr);
wire [31:0]B;
wire [31:0]memmoryout;
// module memory(
//     input [31:0] A,
//     input [31:0]WD,
//     input clk, rst, We,
//     output reg [31:0] RD
// );
memory Memmory(memadr,B,clk,rst,memwrite,memmoryout);
wire [31:0]instruction;
wire [31:0] oldpc;
wire [31:0]memmorydataregister;
// module register (
//     input clk,
//     input rst,
//     input [31:0] data_in,
//     input enable,
//     output reg [31:0] data_out
// );
register IR(clk,rst,memmoryout,irwrite,instruction);
register OLDPC(clk,rst,pcout,irwrite,oldpc);
register MDR(clk,rst,memmoryout,1'b1,memmorydataregister);
// module imm_extend(
//     input [24:0]unextend_data,
//     input [2:0]extend_func,
//     output reg [31:0]extended_data

// );
//     parameter I_type = 3'b000;
//     parameter S_type = 3'b001;
//     parameter B_type = 3'b010;
//     parameter J_type = 3'b011;
//     parameter U_type = 3'b100;

// always @(*)
//     begin
//         case (extend_func)
//             I_type: extended_data = {{20{unextend_data[24]}}, unextend_data[24:13]};
//             S_type: extended_data = {{20{unextend_data[24]}}, unextend_data[24:18], unextend_data[4:0]};
//             B_type: extended_data = {{20{unextend_data[24]}}, unextend_data[0], unextend_data[23:18], unextend_data[4:1], 1'b0};
//             J_type: extended_data = {{12{unextend_data[24]}}, unextend_data[12:5], unextend_data[13], unextend_data[23:14], 1'b0};
//             U_type: extended_data = {unextend_data[24:5], {12{1'b0}}};
//         endcase
// end
// endmodule
wire [31:0]extended_data;
imm_extend IMM_EXTEND(instruction[31:7],immsrc,extended_data);
wire[31:0]A;
// module file_reg(
//     input clk,
//     input rst,
//     input [4:0] A1, A2, A3,
//     input [31:0] WD,
//     input We,
//     output [31:0] RD1, RD2
// );

//     reg [31:0] Reg_file [31:0];
//     integer i;

//     always @(posedge clk or posedge rst) begin
//         if (rst) begin
//             for (i = 0; i < 32; i = i + 1) begin
//                 Reg_file[i] <= 32'b0;
//             end
//         end else if (We) begin
//             Reg_file[A3] <= WD;
//         end
//     end
//     assign RD1 = Reg_file[A1];
//     assign RD2 = Reg_file[A2];
// endmodule
wire [31:0]registeredA,registeredB;
file_reg FILE_REG(clk,rst,instruction[19:15],instruction[24:20],instruction[11:7],resultdata,regwrite,A,B);
register a(clk,rst,A,1'b1,registeredA);
register b(clk,rst,B,1'b1,registeredB);
wire [31:0]aluopranda,aluoprandb;
// module multiplexer_4to1 (
//     input [1:0] S, 
//     input [31:0] D0,
//     input [31:0] D1,
//     input [31:0] D2,
//     input [31:0] D3, 
//     output [31:0]Y 
// );
//     assign Y = (S == 2'b00) ? D0 :
//                (S == 2'b01) ? D1 :
//                (S == 2'b10) ? D2 :
//                (S == 2'b11) ? D3 : 4'b0;
// endmodule
multiplexer_4to1 alusela(alusrca,pcout,oldpc,registeredA,32'b0,aluopranda);
multiplexer_4to1 aluselb(alusrcb,registeredB,extended_data,32'd4,32'b0,aluoprandb);
wire [31:0]aluresult;
wire [31:0]registeredaluresult;
// module ALU (
//     input signed [31:0] A,
//     input signed [31:0] B,
//     input [2:0] ALUOp,
//     output reg [31:0] ALUResult,
//     output reg Zero,
//     output reg Neg
// );
ALU alu(aluopranda,aluoprandb,aluop,aluresult,zer,neg);
register aluout(clk,rst,aluresult,1'b1,registeredaluresult);
multiplexer_4to1 resultselect(resultsrc,registeredaluresult,aluresult,memmorydataregister,extended_data,resultdata);
endmodule