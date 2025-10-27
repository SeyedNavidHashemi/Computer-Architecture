`timescale 1ns/1ns
module RISC_V_sigle_cycle(clk, rst);

input clk, rst;
wire Reg_write, ALU_src, Mem_write, zero, pos;
wire[1:0] Pc_src, Result_src;
wire[2:0] Imm_src, ALU_cntr, func3;
wire[6:0] opc, func7;

Datapath Datapath(.clk(clk), .rst(rst), .Pc_src(Pc_src), .Reg_write(Reg_write), .Imm_src(Imm_src), .ALU_src(ALU_src), .ALU_cntr(ALU_cntr), .Result_src(Result_src), .Mem_write(Mem_write) 
                , .zero(zero), .pos(pos), .opc(opc), .func3(func3), .func7(func7));
Controller Controller(.opc(opc), .func3(func3), .func7(func7), .zero(zero), .pos(pos)
                , .Pc_src(Pc_src), .Reg_write(Reg_write), .ALU_src(ALU_src), .ALU_cntl(ALU_cntr)
                , .Result_src(Result_src), .Mem_write(Mem_write), .Imm_src(Imm_src));

endmodule