module data_path (
    ports
);
    // F part
    multiplexer_4to1 mux_pc(
        .S(PCSrcE),
        .D0(PCPlus4F),
        .D1(ALUResultE),
        .D2(PCTragetE),
        .D3(32'b0),
        .Y(PCFP)
        );
    
    PC pc(
        .clk(clk),
        .rst(rst),
        .data_in(PCFP),
        .data_out(PCF),
        .enable(StalF)
    );

    memory_inst mem_inst(
        .A(PCF),
        .WD(32'b0),
        .clk(clk),
        .rst(rst),
        .We(1'b0),
        .RD(InstrF)
    );

    adder pc_adder(
        .A(PCF),
        .B(32'd4),
        .C(PCPlus4F)
    );

    // D part
    register #(.bit(3*32)) reg_F_D(
        .clk(clk),
        .rst(rst | FlushD),
        .ld(StalD),
        .par_in({InstrF, PCF, PCPlus4F}),
        .par_in({InstrD, PCD, PCPlus4D})
    );

    file_reg Reg_file(
        .clk(~clk),
        .rst(rst),
        .A1(InstrD[19:15]),
        .A2(InstrD[24:20]),
        .A3(RdW),
        .We(RegWriteW),
        .RD1(RD1D),
        .RD2(RD2D)
    );

    imm_extend imm_ex(
        .unextend_data(InstrD[31:7]),
        .extend_func(ImmSrcD),
        .extended_data(ExtImmD)
    );


    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD = InstrD[11:7];

    register #(.bit(/*TODO*/)) reg_D_E(
        .clk(clk),
        .rst(rst | FlushE),
        .ld(1'b1),
        .par_in({RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD ,
        RD1D, RD2D, PCD, Rs1D, Rs2D, RdD, ExtImmD, PCPlus4D}),
        .par_in({RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE ,
        RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ExtImmE, PCPlus4E})
    );

    // E part
    multiplexer_4to1 alusrcA(
        .S(ForwardAE),
        .D0(RD1E),
        .D1(ResultW),
        .D2(ALUResultM),
        .D3(32'b0),
        .Y(SrcAE)
    );
    multiplexer_4to1 alusrcregB(
        .S(ForwardBE),
        .D0(RD2E),
        .D1(ResultW),
        .D2(ALUResultM),
        .D3(32'b0),
        .Y(RegBE)
    );
    multiplexer_2to1  alusrcB(
        .S(ALUSrcE),
        .D0(RegBE),
        .D1(ExtImmE),
        .Y(SrcBE)
    );
    ALU alu(
        .A(SrcAE),
        .B(SrcBE),
        .ALUOp(ALUControlE),
        .ALUResult(ALUResultE)
        .Zero(Zero),
        .Neg(Neg)
    );
    adder addr_imm_pc(
        .A(PCE),
        .B(ExtImmE),
        .C(PCTragetE)
    );

    logic PCSelector(
        .Zero(Zero),
        .Neg(Neg),
        .Jump(JumpE),
        .Branch(BranchE),
        .PCSrc(PCSrcE)
    );

    assign WriteDataE = RegBE;

    register #(.bit(/*TODO*/)) reg_E_M(
        .clk(clk),
        .rst(rst),
        .ld(1'b1),
        .par_in({RegWriteE, ResultSrcE, MemWriteE,
        ALUResultE, WriteDataE, RdE, ExtImmE, PCPlus4E}),
        .par_in({RegWriteM, ResultSrcM, MemWriteM,
        ALUResultM, WriteDataM, RdM, ExtImmM, PCPlus4M})
    );

    // M part
    memory_data data_mem(
        .A(ALUResultM),
        .WD(WriteDataM),
        .clk(clk),
        .rst(rst),
        .We(MemWriteM),
        .RD(ReadDataM)
    );

    register #(.bit(/*TODO*/)) reg_M_W(
        .clk(clk),
        .rst(rst),
        .ld(1'b1),
        .par_in({RegWriteM, ResultSrcM,
        ALUResultM, ReadDataM, RdM, ExtImmM, PCPlus4M}),
        .par_in({RegWriteW, ResultSrcW,
        ALUResultW, ReadDataW, RdW, ExtImmW, PCPlus4W})
    );

    // W part
    multiplexer_4to1 mux_W(
        .S(ResultSrcW),
        .D0(ALUResultW),
        .D1(ReadDataW),
        .D2(PCPlus4W),
        .D3(ExtImmW),
        .Y(ResultW)
    );
endmodule