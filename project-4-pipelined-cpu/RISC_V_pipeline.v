`timescale 1ns/1ns
module RISC_V_Pipeline(clk, rst);
    input clk, rst;

    wire RegWriteD, MemWriteD, ALUSrcD, luiD;
    wire [1:0] ResultSrcD, JumpD;
    wire [2:0] BranchD, ALUControlD, ImmSrcD, func3; 
    wire [6:0] opc, func7;

    Datapath Datapath(.clk(clk), .rst(rst), .RegWriteD(RegWriteD), .ResultSrcD(ResultSrcD), .MemWriteD(MemWriteD), .JumpD(JumpD),
                      .BranchD(BranchD), .ALUControlD(ALUControlD), .ALUSrcD(ALUSrcD), .ImmSrcD(ImmSrcD), .luiD(luiD),
                      .opc(opc), .func3(func3), .func7(func7));
            
    Controller Controller(.opc(opc), .func3(func3), .func7(func7),
                          .RegWriteD(RegWriteD), .ResultSrcD(ResultSrcD), .MemWriteD(MemWriteD), .JumpD(JumpD), .BranchD(BranchD),
                          .ALUControlD(ALUControlD), .ALUSrcD(ALUSrcD), .ImmSrcD(ImmSrcD), .luiD(luiD));
endmodule