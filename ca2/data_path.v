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
    output [6:0]func7,
    output ZERO
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
wire [31:0]memmory_out;
//module memory(
//    input [31:0] A,
//    input [31:0]WD,
//    input clk, rst, We,
//    output reg [31:0] RD
//);
memory MEMMORY(alu_res,RD2,clk,rst,wedata,memmory_out);
wire [31:0]write_data;
//module multiplexer_2to1 (
//    input wire S, 
//    input wire [31:0]D0, 
//    input wire [31:0]D1, 
//    output wire [31:0]Y 
//);
multiplexer_2to1 write_data_select(outsel,alu_res,memmory_out,write_data);
wire [31:0]choice0,choice1,choice2,choice3;
adder choice0_ADDER(32'h00000004,pcout,choice0);
assign choice2 = write_data;
assign choice3 = extended_imm;
//module adder(
//    input [31:0] A,
//    input [31:0] B,
//    output [31:0] C
//);
adder choice1_ADDER(pcout,extended_data,choice1);
//module multiplexer_4to1 (
//    input [1:0] S, 
//    input [31:0] D0,
//    input [31:0] D1,
//    input [31:0] D2,
//    input [31:0] D3, 
//    output [31:0]Y 
//);
multiplexer_4to1 pc_choice(pcsel,choice0,choice1,choice2,choice3,pcin);
//module multiplexer_2to1 (
//    input wire S, 
//    input wire [31:0]D0, 
//    input wire [31:0]D1, 
//    output wire [31:0]Y 
//);
multiplexer_2to1 WD_select(regsel,write_data,choice0,WD);
assign ZERO=zero;

endmodule