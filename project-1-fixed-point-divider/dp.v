module datapath(A_in, B_in, dec_CNT, ld_CNT, sel_CNT, clk, sclr, ld_a, ld_b, ld_acc, sh_acc, ld_q, sh_q, set_f, reset_f, sel_X, Q_out, all_zero, AgTb, B_is_zero, CoUt, set_new, reset_new, Finish_or_not);
    input [9:0] A_in, B_in;
    input clk, sclr, ld_a, ld_b, ld_acc, sh_acc, ld_q, sh_q, sel_X, dec_CNT, ld_CNT, sel_CNT, set_f, reset_f, set_new, reset_new;
    output all_zero, AgTb, B_is_zero, CoUt, Finish_or_not;
    output [9:0] Q_out;

    wire [10:0] sub_res, acc_reg, mux_res_acc;
    wire [9:0] a_reg, b_reg;
    wire [3:0] mux_res_cnt;
    wire f_reg;

    Subtractor subtractor(acc_reg, {1'b0, b_reg}, sub_res);
    A_reg reg_A(clk, sclr, A_in, ld_a, a_reg);
    B_reg reg_B(clk, sclr, B_in, ld_b, b_reg);
    mux_2_to_1_acc m1(sub_res, {10'b0000000000, a_reg[9]}, sel_X, mux_res_acc);
    Q_shreg reg_q({a_reg[8:0], 1'b0}, f_reg, sclr, clk, ld_q, sh_q, Q_out);
    ACC_shreg reg_acc(mux_res_acc, Q_out[9], sclr, clk, ld_acc, sh_acc, acc_reg);
    q_checker q_ch(Q_out[9:4], all_zero);
    dff d_flip_flop(set_f, reset_f, sclr, clk, f_reg);
    Comparator comp(acc_reg, {1'b0, b_reg}, AgTb);
    Counter cnt(clk, sclr, dec_CNT, ld_CNT, mux_res_cnt, CoUt);
    dff new_dff(set_new, reset_new, sclr, clk, Finish_or_not);


    assign mux_res_cnt = sel_CNT ? 4'b0011 : 4'b1001;
    assign B_is_zero = (~|{b_reg});
endmodule