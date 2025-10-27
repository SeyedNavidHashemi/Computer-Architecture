`timescale 1ns/1ns
`timescale 1ns/1ns
module Datapath(clk, rst, Reg_write, Imm_src, ALU_srcA, ALU_srcB, ALU_cntr,
                Result_src, Mem_write , PC_write, old_PC_write, Adr_src, 
                IR_write, zero, pos, opc, func3, func7);
    input [2:0] Imm_src, ALU_cntr, Result_src;
    input [1:0] ALU_srcA, ALU_srcB;
    input clk, rst, Reg_write, Mem_write, PC_write, Adr_src, old_PC_write, IR_write; 
    output zero, pos;
    output [2:0] func3;
    output [6:0] opc, func7;

    wire [31:0] Pc_out, old_Pc_out, Adr_src_out, Inst, Imm_out, RD1, RD2, A_out, B_out, ALU_A_out, ALU_B_out, ALU_res, ALU_out,
                Mem_out, MD_out, Result_out;

    assign opc = Inst[6:0];
    assign func3 = Inst[14:12];
    assign func7 = Inst[31:25];

    reg_32_bit_load PC(.clk(clk), .rst(rst), .load(PC_write), .reg_in(Result_out), .reg_out(Pc_out)); 
    reg_32_bit_load old_PC(.clk(clk), .rst(rst), .load(old_PC_write), .reg_in(Pc_out), .reg_out(old_Pc_out));

    Mux_2_to_1 after_PC(.op1(Pc_out), .op2(Result_out), .select(Adr_src), .result(Adr_src_out));

    Memory Memory(.clk(clk), .address(Adr_src_out), .WD(Result_out), .RD(Mem_out), .Mem_write(Mem_write));

    reg_32_bit_load IR(.clk(clk), .rst(rst), .load(IR_write), .reg_in(Mem_out), .reg_out(Inst));
    reg_32_bit MDR(.clk(clk), .rst(rst), .reg_in(Mem_out), .reg_out(MD_out));

    Register_file RF(.clk(clk), .A1(Inst[19:15]), .A2(Inst[24:20]), .A3(Inst[11:7]), .WD(Result_out), .RD1(RD1), .RD2(RD2), .Reg_write(Reg_write));

    reg_32_bit A(.clk(clk), .rst(rst), .reg_in(RD1), .reg_out(A_out));
    reg_32_bit B(.clk(clk), .rst(rst), .reg_in(RD2), .reg_out(B_out));

    Mux_4_to_1 After_A(.op1(Pc_out), .op2(old_Pc_out), .op3(A_out), .op4(32'bz), .select(ALU_srcA), .result(ALU_A_out));
    Mux_4_to_1 After_B(.op1(B_out), .op2(Imm_out), .op3(32'd4), .op4(32'bz), .select(ALU_srcB), .result(ALU_B_out));

    ALU ALU(.op1(ALU_A_out), .op2(ALU_B_out), .ALU_func(ALU_cntr), .result(ALU_res), .zero(zero), .pos(pos));

    reg_32_bit Alu_OUT(.clk(clk), .rst(rst), .reg_in(ALU_res), .reg_out(ALU_OUT));
    Mux_5_to_1 after_ALU_OUT(.op1(ALU_out), .op2(ALU_res), .op3(MD_out), .op4(Imm_out), .op5(Pc_out), .select(Result_src), .result(Result_out));






















    // Instruction_memory IM(.address(Pc_out), .instruction(Inst));

    // Register_file RF(.clk(clk), .A1(Inst[19:15]), .A2(Inst[24:20]), .A3(Inst[11:7]), .WD(Result_out), .RD1(RD1), .RD2(RD2), .Reg_write(Reg_write));

    // Mux_2_to_1 ALU_MUX(.op1(RD2), .op2(Imm_out), .select(ALU_src), .result(ALU_src_out));

    // ALU ALU(.op1(RD1), .op2(ALU_src_out), .ALU_func(ALU_cntr), .result(ALU_out), .zero(zero), .pos(pos));

    // Data_memory DM(.clk(clk), .address(ALU_out), .WD(RD2), .RD(Data_mem_out), .Mem_write(Mem_write));

    // Mux_4_to_1 RES_MUX(.op1(ALU_out), .op2(Data_mem_out), .op3(Imm_out), .op4(Pc_next), .select(Result_src), .result(Result_out));

    // ImmExtension IMM_EXT(.Imm_in(Inst[31:7]), .Imm_src(Imm_src), .result(Imm_out));

    // Adder PC_ADD(.op1(Pc_out), .op2(32'd4), .result(Pc_next));

    // Adder JUMP_PC_ADD(.op1(Imm_out), .op2(Pc_out), .result(Pc_jump));

    // Mux_4_to_1 PC_MUX(.op1(Pc_next), .op2(Pc_jump), .op3(ALU_out), .op4(32'bz), .select(Pc_src), .result(Pc_src_out));

    
endmodule