`timescale 1ns/1ns

module Mux_2_to_1(op1, op2, select, result);
    input [31:0] op1, op2;
    input select;
    output [31:0] result;
    
    assign result = (select == 1'b1) ? op2 : op1;
endmodule