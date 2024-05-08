module data_path(
    input clk,
    input rst,
    input [1:0]pcsel,
    input regsel,
    input [2:0]extend_func,
    input wereg,
    input wedata,
    input aluselb,
    input [2:0]aluop,
    input outsel,
    output [6:0]op,
    output [2:0]func3,
    output [6:0]func7
);
wire [31:0]pcin,pcout;
//module PC (
//    input clk,
//    input rst,
//    input [31:0] data_in,
//    output reg [31:0] data_out
//);
PC  pc(clk,rst,pcin,pcout);
wire [32:0]instruction;
//module inst_mem(
//    input [31:0] A,
//    output reg [31:0] RD
//);
inst_mem instruction_memmory(pcout,instruction);
//module imm_extend(
//    input [24:0]unextend_data,
//    input [2:0]extend_func,
//    output reg [31:0]extended_data
//
//);
wire [31:0]extended_imm; 
imm_extend immediate_extened(instruction[31:7],extend_func,extended_imm);
wire [31:0]WD,RD1,RD2;
//module file_reg(
//    input clk,
//    input rst,
//    input [4:0] A1, A2, A3,
//    input [31:0] WD,
//    input We,
//    output [31:0] RD1, RD2
//);
file_reg file_register(clk,rst,instruction[19:15],instruction[24:20],instruction[11:7],WD,wereg,RD1,RD2);
wire [31:0]ALUB;
//module multiplexer_2to1 (
//    input wire S, 
//    input wire [31:0]D0, 
//    input wire [31:0]D1, 
//    output wire [31:0]Y 
//);
multiplexer_2to1 bselect(aluselb,RD2,extended_imm,ALUB);
wire [31:0]alu_res;
wire zero;
//module ALU (
//    input signed [31:0] A,
//    input signed [31:0] B,
//    input [2:0] ALUOp,
//    output reg [31:0] ALUResult,
//    output reg Zero
//);
ALU alu(RD1,ALUB,aluop,alures,zero);

endmodule