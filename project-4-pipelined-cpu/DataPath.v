`timescale 1ns/1ns
module Datapath(clk, rst, RegWriteD, ResultSrcD, MemWriteD, JumpD,
                BranchD, ALUControlD, ALUSrcD, ImmSrcD, luiD, opc, func3, func7);

    input clk, rst, RegWriteD, MemWriteD, ALUSrcD, luiD;
    input [1:0] ResultSrcD, JumpD;
    input [2:0] BranchD, ALUControlD, ImmSrcD;
    output [6:0] opc, func7;
    output [2:0] func3;

    wire RegWriteE, MemWriteE, ALUSrcE, luiE, 
         RegWriteM, MemWriteM, luiM, RegWriteW,
         StallF, StallD, FlushD, FlushE,
         zero, pos;
    wire [1:0] ResultSrcE, JumpE, PCSrcE, ResultSrcM, ResultSrcW,
               ForwardAE, ForwardBE;
    wire [2:0] BranchE, ALUControlE;
    wire [4:0] Rs1D, Rs2D, RdD, Rs1E, Rs2E, RdE, RdM, RdW;

    wire [31:0] PCF, PCPlus4F, PCFprime, InstrF, PCTargetE, ALUResultE, InstD, PCD, PCPlus4D, ResultW, RD1D, RD2D, luiForward, 
                ExtImmD, RD1E, RD2E, PCE, ExtImmE, PCPlus4E, SrcAE, SrcBE, WriteDataE, ALUResultM, WriteDataM,
                PCPlus4M, ExtImmM, ReadDataM, ALUResultW, ReadDataW, ExtImmW, PCPlus4W;


    Mux_4_to_1 mux_PCF(.op1(PCPlus4F), .op2(PCTargetE), .op3(ALUResultE), .op4(32'bz), .select(PCSrcE), .result(PCFprime));

    reg_32_bit_load reg_PCF(.clk(clk), .rst(rst), .load(~StallF), .reg_in(PCFprime), .reg_out(PCF));

    Adder Adder_PCF(.op1(PCF), .op2(32'd4), .adder_res(PCPlus4F));

    Instruction_memory IM(.address(PCF), .instruction(InstrF));

    Register_F Register_F(.clk(clk), .rst(rst), .EN(~StallD), .CLR(FlushD), .PCF(PCF), .InstrF(InstrF), .PCPlus4F(PCPlus4F), .InstD(InstD), .PCD(PCD), .PCPlus4D(PCPlus4D));

    assign opc = InstD[6:0];
    assign func3 = InstD[14:12];
    assign func7 = InstD[31:25];

    Register_file Register_file(.clk(clk), .A1(InstD[19:15]), .A2(InstD[24:20]), .A3(RdW), .WD(ResultW), .RD1(RD1D), .RD2(RD2D), .Reg_write(RegWriteW));

    ImmExtension ImmExtension(.Imm_in(InstD[31:7]), .Imm_src(ImmSrcD), .result(ExtImmD));

    Register_D Register_D(.clk(clk), .rst(rst), .CLR(FlushE), .RegWriteD(RegWriteD), .ResultSrcD(ResultSrcD), .MemWriteD(MemWriteD), .JumpD(JumpD),
                .BranchD(BranchD), .ALUControlD(ALUControlD), .ALUSrcD(ALUSrcD), .luiD(luiD), .RD1D(RD1D), .RD2D(RD2D), .PCD(PCD), .Rs1D(Rs1D),
                .Rs2D(Rs2D), .RdD(InstD[11:7]), .ExtImmD(ExtImmD), .PCPlus4D(PCPlus4D), .RegWriteE(RegWriteE), .ResultSrcE(ResultSrcE), .MemWriteE(MemWriteE), 
                .JumpE(JumpE), .BranchE(BranchE), .ALUControlE(ALUControlE), .ALUSrcE(ALUSrcE), .luiE(luiE), .RD1E(RD1E), .RD2E(RD2E), .PCE(PCE), .Rs1E(Rs1E), .Rs2E(Rs2E),
                .RdE(RdE), .ExtImmE(ExtImmE), .PCPlus4E(PCPlus4E));

    Mux_4_to_1 mux_A_EX(.op1(RD1E), .op2(ResultW), .op3(luiForward), .op4(32'bz), .select(ForwardAE), .result(SrcAE));
    Mux_4_to_1 mux_B_EX(.op1(RD2E), .op2(ResultW), .op3(luiForward), .op4(32'bz), .select(ForwardBE), .result(WriteDataE));

    Mux_2_to_1 mux_SrcB_EX(.op1(WriteDataE), .op2(ExtImmE), .select(ALUSrcE), .result(SrcBE));

    Adder Adder_PCE(.op1(PCE), .op2(ExtImmE), .adder_res(PCTargetE));

    ALU ALU(.op1(SrcAE), .op2(SrcBE), .ALU_func(ALUControlE), .result(ALUResultE), .zero(zero), .pos(pos));

    Register_EX Register_EX(.clk(clk), .rst(rst), .RegWriteE(RegWriteE), .ResultSrcE(ResultSrcE), .MemWriteE(MemWriteE), .luiE(luiE), 
                 .ALUResultE(ALUResultE), .WriteDataE(WriteDataE), .RdE(RdE), .PCPlus4E(PCPlus4E), .ExtImmE(ExtImmE),
                 .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .MemWriteM(MemWriteM), .luiM(luiM), .ALUResultM(ALUResultM),
                 .WriteDataM(WriteDataM), .RdM(RdM), .PCPlus4M(PCPlus4M), .ExtImmM(ExtImmM));


    Mux_2_to_1 lui_forward(.op1(ALUResultM), .op2(ExtImmM), .select(luiM), .result(luiForward));

    Data_memory DM(.clk(clk), .address(ALUResultM), .WD(WriteDataM), .RD(ReadDataM), .Mem_write(MemWriteM));

    Register_MEM Register_MEM(.clk(clk), .rst(rst), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .ALUResultM(ALUResultM), .ReadDataM(ReadDataM), .RdM(RdM), .ExtImmM(ExtImmM), .PCPlus4M(PCPlus4M),
                    .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW), .ALUResultW(ALUResultW), .ReadDataW(ReadDataW), .ExtImmW(ExtImmW), .PCPlus4W(PCPlus4W), .RdW(RdW)); 

    Mux_4_to_1 mux_Res_WBop1(.op1(ALUResultW), .op2(ReadDataW), .op3(PCPlus4W), .op4(ExtImmW), .select(ResultSrcW), .result(ResultW));

    Hazard_Unit Hazard_Unit(.Rs1D(Rs1D), .Rs2D(Rs2D), .RdE(RdE), .Rs2E(Rs2E), .Rs1E(Rs1E), .PCSrcE(PCSrcE),
                   .ResultSrcE0(ResultSrcE[0]), .RdM(RdM), .RegWriteM(RegWriteM), .RdW(RdW), .RegWriteW(RegWriteW),
                   .StallF(StallF), .StallD(StallD), .FlushD(FlushD), .FlushE(FlushE), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE));
    
    BranchController BranchController(.JumpE(JumpE), .BranchE(BranchE), .zero(zero), .pos(pos), .PCSrcE(PCSrcE));

endmodule