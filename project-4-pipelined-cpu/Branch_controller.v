`timescale 1ns/1ns
`define BEQ 3'b001
`define BNE 3'b010
`define BLT 3'b011
`define BGE 3'b100
`define JUMP 3'b000
`define JAL  2'b01
`define JALR 2'b10

module BranchController(JumpE, BranchE, zero, pos, PCSrcE);
    input zero, pos;
    input [1:0] JumpE;
    inout [2:0] BranchE;
    output reg [1:0] PCSrcE;
    
    always @(JumpE, BranchE, zero, pos) begin
        case(BranchE)
            `JUMP : PCSrcE <= (JumpE == `JAL)  ? 2'b01 :
                             (JumpE == `JALR) ? 2'b10 : 2'b00;

            `BEQ : PCSrcE <= (zero) ? 2'b01 : 2'b00;
            `BNE : PCSrcE <= (~zero) ? 2'b01 : 2'b00;
            `BLT : PCSrcE <= (~pos & ~zero) ? 2'b01 : 2'b00;
            `BGE : PCSrcE <= (zero | pos) ? 2'b01 : 2'b00;
        endcase
    end

endmodule