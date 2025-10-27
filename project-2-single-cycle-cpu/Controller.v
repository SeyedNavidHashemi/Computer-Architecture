`timescale 1ns/1ns
module Controller(opc, func3, func7, zero, pos
                , Pc_src, Reg_write, ALU_src, ALU_cntl
                , Result_src, Mem_write, Imm_src);
    input [6:0] opc, func7;
    input [2:0] func3;
    input zero, pos;
    output [1:0] Pc_src, Result_src;
    output [2:0] ALU_cntl, Imm_src;
    output Reg_write, ALU_src, Mem_write;


    wire [1:0] ALU_opc, Par_PcSrc;
    wire branch, jal, jalr;
    
    Main_controller Main_Cont(.opc(opc), .zero(zero), .branch(branch), .jalr(jalr), .jal(jal), .Reg_write(Reg_write), .Imm_src(Imm_src), .ALU_opc(ALU_opc), .Mem_write(Mem_write), .Result_src(Result_src), .ALU_src(ALU_src));

    Branch_controller Branch_Cont(.branch(branch), .func3(func3), .zero(zero), .pos(pos), .Par_PcSrc(Par_PcSrc));

    ALU_controller ALU_Cont(.ALU_opc(ALU_opc), .func3(func3), .func7(func7), .ALU_cntr(ALU_cntl));


    assign Pc_src = (jalr) ? 2'b10:
                   (jal) ? 2'b01 :
                   (branch) ? Par_PcSrc:2'b00;

endmodule