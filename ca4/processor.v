module processor(input clk, rst);
    wire [6:0]op;
    wire [2:0]func3;
    wire [6:0]func7;
    wire RegWrite;
    wire [1:0] ResultSrc;
    wire MemWrite;
    wire [1:0] Jump;
    wire [2:0] Branch;
    wire [2:0] ALUControl;
    wire ALUSrc;
    wire [2:0] ImmSrc;

    wire [4:0] Rs1D;
    wire [4:0] Rs2D;
    wire [4:0] RdE;
    wire [4:0] Rs1E;
    wire [4:0] Rs2E;
    wire [1:0] PCSrcE;
    wire [4:0] RdM;
    wire [4:0] RdW;
    wire ResultSrcE0;
    wire [1:0] ResultSrcM;
    wire RegWriteM;
    wire RegWriteW;
    wire StallF;
    wire StallD;
    wire FlushD;
    wire FlushE;
    wire [1:0] ForwardAE;
    wire [1:0] ForwardBE;

    controller ctrl (
        .op(op),
        .func3(func3),
        .func7(func7),
        .RegWrite(RegWrite),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .Jump(Jump),
        .Branch(Branch),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc)
    );

    hazard_unit hazard (
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .RdE(RdE),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .PCSrcE(PCSrcE),
        .RdM(RdM),
        .RdW(RdW),
        .ResultSrcE0(ResultSrcE0),
        .ResultSrcM(ResultSrcM),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .StallF(StallF),
        .StallD(StallD),
        .FlushD(FlushD),
        .FlushE(FlushE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );

    data_path dp (
        .clk(clk),
        .rst(rst),
        // controller connections
        .RegWriteD(RegWrite),
        .ResultSrcD(ResultSrc),
        .MemWriteD(MemWrite),
        .JumpD(Jump),
        .BranchD(Branch),
        .ALUControlD(ALUControl),
        .ALUSrcD(ALUSrc),
        .ImmSrcD(ImmSrc),
        .op(op),
        .func3(func3),
        .func7(func7),
        // hazard_unit connections
        .StallF(StallF),
        .StallD(StallD),
        .FlushD(FlushD),
        .FlushE(FlushE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .H_Rs1D(Rs1D),
        .H_Rs2D(Rs2D),
        .H_RdE(RdE),
        .H_Rs1E(Rs1E),
        .H_Rs2E(Rs2E),
        .H_PCSrcE(PCSrcE),
        .H_RdM(RdM),
        .H_RdW(RdW),
        .H_ResultSrcE0(ResultSrcE0),
        .H_ResultSrcM(ResultSrcM),
        .H_RegWriteM(RegWriteM),
        .H_RegWriteW(RegWriteW)
    );

endmodule