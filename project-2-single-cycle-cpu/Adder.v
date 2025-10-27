`timescale 1ns/1ns
module Adder(op1, op2, result);
    input [31:0] op1, op2;
    output [31:0] result;

    assign result = op1 + op2;
endmodule