`timescale 1ns/1ns
module RISC_V_multi_cycle(clk, rst);
    input clk, rst;
    wire Reg_write, Mem_write, zero, pos, PC_write, old_PC_write, Adr_src, IR_write;
    wire[1:0] Pc_src, ALU_srcA, ALU_srcB;
    wire[2:0] Imm_src, ALU_cntr, func3, Result_src;
    wire[6:0] opc, func7;

    Datapath Datapath(.clk(clk), .rst(rst), .Reg_write(Reg_write), .Imm_src(Imm_src), .ALU_srcA(ALU_srcA), .ALU_srcB(ALU_srcB), .ALU_cntr(ALU_cntr),
                .Result_src(Result_src), .Mem_write(Mem_write) , .PC_write(PC_write), .old_PC_write(old_PC_write), .Adr_src(Adr_src), 
                .IR_write(IR_write), .zero(zero), .pos(pos), .opc(opc), .func3(func3), .func7(func7));

    Controller Controller(.clk(clk), .rst(rst), .opc(opc), .func3(func3), .func7(func7), .zero(zero), .pos(pos)
                    , .IR_write(IR_write), .final_PC_write(PC_write), .old_PC_write(old_PC_write)
                    , .Adr_src(Adr_src), .Reg_write(Reg_write), .ALU_srcA(ALU_srcA), .ALU_srcB(ALU_srcB)
                    , .ALU_cntl(ALU_cntr), .Result_src(Result_src), .Mem_write(Mem_write), .Imm_src(Imm_src));
endmodule