`timescale 1ns/1ns
module A_reg(clk, sclr, a_in, ldA , a_out);
    input[9:0] a_in;
    input clk, sclr, ldA;
    output [9:0] a_out;
    reg [9:0] a_out;

    always @(posedge clk) begin
        if(sclr == 1'b1)
            a_out <= 10'b0;
        else if(ldA == 1'b1)
            a_out <= a_in; 
    end
endmodule

module B_reg(clk, sclr, b_in, ldB , b_out);
    input[9:0] b_in;
    input clk, sclr, ldB;
    output [9:0] b_out;
    reg [9:0] b_out;

    always @(posedge clk) begin
        if(sclr == 1'b1)
            b_out <= 10'b0;
        else if(ldB == 1'b1)
            b_out <= b_in;
    end
endmodule

module Subtractor(operand1, operand2, result);
    input[10:0] operand1, operand2;
    output[10:0] result;

    assign result = operand1 - operand2;
endmodule

module Comparator(operand1, operand2, result);
    input [10:0] operand1, operand2;
    output result;

    assign result = (operand1 >= operand2) ? 1'b1 : 1'b0;
endmodule

module ACC_shreg(acc_in, serin_acc, sclr, clk, ld_acc, sh_acc, acc_out);
    input [10:0] acc_in;
    input serin_acc, sclr, ld_acc, sh_acc, clk;
    output [10:0] acc_out;
    reg [10:0] acc_out;

    always @(posedge clk) begin
        if(sclr == 1'b1)
            acc_out <= 11'b0;
        else if(ld_acc)
            acc_out <= acc_in;
        else if(sh_acc)
            acc_out <= {acc_out[9:0], serin_acc};
    end 
endmodule

module Q_shreg(q_in, serin_q, sclr, clk, ld_q, sh_q, q_out);
    input [9:0] q_in;
    input serin_q, sclr, clk, ld_q, sh_q;
    output [9:0] q_out;
    reg [9:0] q_out;
    always @(posedge clk) begin
        if(sclr == 1'b1)
            q_out <= 10'b0;
        else if(ld_q)
            q_out <= q_in;
        else if(sh_q)
            q_out <= {q_out[8:0], serin_q};
    end
endmodule

module dff(set, reset, sclr, clk, q);
    input set, reset, sclr, clk;
    output q;
    reg q;

    always @(posedge clk) begin
        if(sclr == 1'b1)
            q <= 1'b0;
        else if(set)
            q <= 1'b1;
        else if(reset)
            q <= 1'b0;
    end
endmodule

// module new_dff(clk, sclr, d, ld, q);
//     input clk, sclr, d, ld;
//     output q;
//     reg q;

//     always @(posedge clk) begin
//         if(sclr)
//             q <= 1'b0;
//         else if(ld)
//             q <= d;
//     end
// endmodule

module q_checker(d, result);
    input [5:0] d;
    output result;

    assign result = ~(|{d});
endmodule

module mux_2_to_1_counter(i0, i1, sel, y);
    input [3:0] i0, i1;
    input sel;
    output [3:0] y;

    assign y = sel ? i1 : i0;
endmodule

module mux_2_to_1_acc(i0, i1, sel, y);
    input [10:0] i0, i1;
    input sel;
    output [10:0] y;

    assign y = sel ? i1 : i0;
endmodule

module Counter(clk, sclr, dec_cnt, ld_cnt, cnt_in, cout);
    input clk, sclr, dec_cnt, ld_cnt;
    input[3:0] cnt_in;
    output cout;
    reg cout;
    reg [3:0]cnt_out;

    always @(posedge clk) begin
        if(sclr == 1'b1)
            cnt_out <= 4'b0000;
        else if(ld_cnt)
            cnt_out <= cnt_in;
        else if(dec_cnt)
            cnt_out <= cnt_out - 1;
    end

    assign cout = ~(|{cnt_out});
endmodule