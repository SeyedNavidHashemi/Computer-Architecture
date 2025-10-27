`timescale 1ns/1ns

// `define Init 4'b0000
// `define Load_A 4'b0001
// `define Check_dv0 4'b0010
// `define Load_ACC 4'b0011
// `define Comp 4'b0100
// `define Sub 4'b0101
// `define Shift 4'b0110
// `define Check_i9 4'b0111
// `define OverFlow 4'b1000
// `define Finish 4'b1001

module controller (start, clk, sclr, agtb, all_z_q, all_z_b, Cout, ld_a, ld_b, ld_acc, sh_acc, ld_q, sh_q, sel_X, SET_f, RESET_f, SET_new, RESET_new, Finish_OR_N, ovf, valid, busy, dvz, Dec_cnt, Ld_cnt, Sel);
    input start, clk, sclr, agtb, all_z_q, all_z_b, Cout, Finish_OR_N;
    output ld_a, ld_b, ld_acc, sh_acc, ld_q, sh_q, sel_X, SET_f, RESET_f, ovf, valid, busy, dvz, Dec_cnt, Ld_cnt, Sel, SET_new, RESET_new;
    reg ld_a, ld_b, ld_acc, sh_acc, ld_q, sh_q, sel_X, SET_f, RESET_f, ovf, valid, busy, dvz, Dec_cnt, Ld_cnt, Sel, SET_new, RESET_new;

    reg[3:0] ps, ns;
    parameter[0:3]
    Init = 0, Load_A = 1, Check_dv0 = 2, Load_ACC = 3, Comp = 4, Sub = 5, Shift = 6, Check_i9 = 7, OverFlow = 8, Finish = 9, DVZ = 10;
    
    always @(ps, start, agtb, all_z_q, all_z_b, Cout) begin
        case(ps)
            Init: ns = start ? Load_A : Init;
            Load_A: ns = Check_dv0;
            Check_dv0: ns = all_z_b ? DVZ : Load_ACC;
            DVZ: ns = Init;
            Load_ACC: ns = Comp;
            Comp: ns = agtb ? Sub : Shift;
            Sub: ns = Shift;
            Shift: ns = (Cout == 1'b1) && (Finish_OR_N == 1'b1) ? Finish:
                        (Cout == 1'b1) && (Sel == 1'b0) ? Check_i9:
                        (Cout == 1'b0) ? Comp : Comp;
            Check_i9: ns = all_z_q ? Comp : OverFlow;
            OverFlow: ns = Init;
            Finish: ns = Init; 
        endcase
    end

    always @(ps) begin
        {ld_a, ld_b, ld_acc, sh_acc, ld_q, sh_q, SET_f, RESET_f, sel_X, ovf, valid, busy, dvz, Dec_cnt, Ld_cnt, Sel} = 16'b0000_0000_0000_0000;
        case(ps)
            Init:;
            Load_A: {busy, ld_a, ld_b, Ld_cnt, Sel, RESET_new} = 6'b111101;
            Check_dv0: busy = 1'b1;
            DVZ: {busy, dvz} = 2'b11;
            Load_ACC: {busy, sel_X, ld_acc, ld_q} = 4'b1111;
            Comp: {busy, sel_X, RESET_f} = 3'b101;
            Sub: {busy, ld_acc, SET_f} = 3'b111;
            Shift: {busy, sh_acc, sh_q, Dec_cnt} = 4'b1111;
            Check_i9: {busy, Sel, Ld_cnt, SET_new} = 4'b1111;
            OverFlow: {busy, ovf} = 2'b11;
            Finish: {busy, valid} = 2'b11;
        endcase
    end

    always @(posedge clk) begin
        if(sclr == 1'b1)
            ps <= Init;
        else
            ps <= ns;
    end

endmodule
