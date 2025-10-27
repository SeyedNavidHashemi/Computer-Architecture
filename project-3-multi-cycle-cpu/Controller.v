`timescale 1ns/1ns
module Controller(clk, rst, opc, func3, func7, zero, pos
                , IR_write, final_PC_write, old_PC_write, Adr_src, Reg_write, ALU_srcA, ALU_srcB, ALU_cntl
                , Result_src, Mem_write, Imm_src);
    input [6:0] opc, func7;
    input [2:0] func3;
    input zero, pos, clk, rst;
    output [1:0] ALU_srcA, ALU_srcB;
    output [2:0] ALU_cntl, Imm_src, Result_src;
    output Reg_write, Mem_write, Adr_src, final_PC_write, old_PC_write, IR_write;


    wire [1:0] ALU_opc;
    wire PC_write, PC_write_cond, Par_PcSrc;
    
    Main_controller Main_controller(.clk(clk), .rst(rst), .opc(opc), .zero(zero), .pos(pos), .PC_write_cond(PC_write_cond), .PC_write(PC_write), .Adr_src(Adr_src), .old_PC_write(old_PC_write),
                                    .Mem_write(Mem_write), .IR_write(IR_write), .Reg_write(Reg_write), .Imm_src(Imm_src), .ALU_srcA(ALU_srcA),
                                    .ALU_srcB(ALU_srcB), .ALU_opc(ALU_opc), .Result_src(Result_src));
   
    B_controller B_controller(.PC_write_cond(PC_write_cond), .func3(func3), .zero(zero), .pos(pos), .Par_PcSrc(Par_PcSrc));

    ALU_controller ALU_controller(.ALU_opc(ALU_opc), .func3(func3), .func7(func7), .ALU_cntr(ALU_cntl));


    assign final_PC_write = PC_write | Par_PcSrc;

endmodule