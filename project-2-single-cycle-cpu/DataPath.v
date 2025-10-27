`timescale 1ns/1ns
module Datapath(clk, rst, Pc_src, Reg_write, Imm_src, ALU_src, ALU_cntr, Result_src, Mem_write 
                , zero, pos, opc, func3, func7);
    input [2:0] Imm_src, ALU_cntr;
    input [1:0] Pc_src, Result_src;
    input clk, rst, Reg_write, ALU_src, Mem_write; 
    output zero, pos;
    output [2:0] func3;
    output [6:0] opc, func7;

    wire [31:0] Pc_out, Pc_src_out, Pc_next, Pc_jump,
                Inst, Imm_out, RD1, RD2, ALU_out, ALU_src_out, 
                Data_mem_out, Result_out;

    assign opc = Inst[6:0];
    assign func3 = Inst[14:12];
    assign func7 = Inst[31:25];

    Pc_reg PC(.clk(clk), .rst(rst), .pc_in(Pc_src_out), .pc_out(Pc_out));

    Instruction_memory IM(.address(Pc_out), .instruction(Inst));

    Register_file RF(.clk(clk), .A1(Inst[19:15]), .A2(Inst[24:20]), .A3(Inst[11:7]), .WD(Result_out), .RD1(RD1), .RD2(RD2), .Reg_write(Reg_write));

    Mux_2_to_1 ALU_MUX(.op1(RD2), .op2(Imm_out), .select(ALU_src), .result(ALU_src_out));

    ALU ALU(.op1(RD1), .op2(ALU_src_out), .ALU_func(ALU_cntr), .result(ALU_out), .zero(zero), .pos(pos));

    Data_memory DM(.clk(clk), .address(ALU_out), .WD(RD2), .RD(Data_mem_out), .Mem_write(Mem_write));

    Mux_4_to_1 RES_MUX(.op1(ALU_out), .op2(Data_mem_out), .op3(Imm_out), .op4(Pc_next), .select(Result_src), .result(Result_out));

    ImmExtension IMM_EXT(.Imm_in(Inst[31:7]), .Imm_src(Imm_src), .result(Imm_out));

    Adder PC_ADD(.op1(Pc_out), .op2(32'd4), .result(Pc_next));

    Adder JUMP_PC_ADD(.op1(Imm_out), .op2(Pc_out), .result(Pc_jump));

    Mux_4_to_1 PC_MUX(.op1(Pc_next), .op2(Pc_jump), .op3(ALU_out), .op4(32'bz), .select(Pc_src), .result(Pc_src_out));

    
endmodule