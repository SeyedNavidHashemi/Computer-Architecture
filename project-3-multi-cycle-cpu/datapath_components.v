`timescale 1ns/1ns

module reg_32_bit(clk, rst, reg_in, reg_out);
    input clk, rst;
    input [31:0] reg_in;
    output reg[31:0] reg_out;

    always @(posedge clk, posedge rst) begin
        if(rst)
            reg_out <= 32'b0;
        else
            reg_out <= reg_in;
    end
endmodule

module reg_32_bit_load(clk, rst, load, reg_in, reg_out);
    input clk, rst, load;
    input [31:0] reg_in;
    output reg[31:0] reg_out;

    always @(posedge clk, posedge rst) begin
        if(rst)
            reg_out <= 32'b0;
        else if(load)
            reg_out <= reg_in;
    end
endmodule

module Mux_2_to_1(op1, op2, select, result);
    input [31:0] op1, op2;
    input select;
    output [31:0] result;
    
    assign result = (select == 1'b1) ? op2 : op1;
endmodule

module Mux_4_to_1(op1, op2, op3, op4, select, result);
    input [31:0] op1, op2, op3, op4;
    input [1:0] select;
    output [31:0] result;
    
    assign result = (select == 2'b00) ? op1:
                    (select == 2'b01) ? op2:
                    (select == 2'b10) ? op3:
                    (select == 2'b11) ? op4:
                    op1;
endmodule

module Mux_5_to_1(op1, op2, op3, op4, op5, select, result);
    input [31:0] op1, op2, op3, op4, op5;
    input [2:0] select;
    output [31:0] result;
    
    assign result = (select == 2'b000) ? op1:
                    (select == 2'b001) ? op2:
                    (select == 2'b010) ? op3:
                    (select == 2'b011) ? op4:
                    (select == 2'b100) ? op5:
                    op1;
endmodule

module Register_file(clk, A1, A2, A3, WD, RD1, RD2, Reg_write);
    input clk, Reg_write;
    input [4:0] A1, A2, A3;
    inout [31:0] WD;
    output [31:0] RD1, RD2;

    reg [31:0] register_file [0:31];

    assign RD1 = register_file[A1];
    assign RD2 = register_file[A2];

    initial register_file[0] = 32'd0;
        
    always @(posedge clk) begin
        if(Reg_write)
            if(A3 != 5'b00000)
                register_file[A3] = WD;
    end

endmodule