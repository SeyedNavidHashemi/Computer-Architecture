`timescale 1ns/1ns
module Controller(opc, func3, func7,
                  RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, ImmSrcD, luiD);
    input [6:0] opc, func7;
    input [2:0] func3;
    output ALUSrcD, MemWriteD, RegWriteD, luiD;
    output [1:0] ResultSrcD, JumpD;
    output [2:0] ALUControlD, ImmSrcD, BranchD;

    wire [1:0] ALU_opc;

    ALU_controller ALU_controller(.ALU_opc(ALU_opc), .func3(func3), .func7(func7), .ALU_cntr(ALUControlD));
    Main_controller Main_controller(.opc(opc), .func3(func3), .RegWriteD(RegWriteD), .MemWriteD(MemWriteD),
                                    .ALU_opc(ALU_opc),.ResultSrcD(ResultSrcD), .JumpD(JumpD), .BranchD(BranchD),
                                    .ALUSrcD(ALUSrcD), .ImmSrcD(ImmSrcD), .luiD(luiD));

endmodule