`timescale 1ns/1ns
`define SW_LW 2'b00
`define BEQ 2'b01
`define RT 2'b10
`define IT 2'b11
module ALU_controller(ALU_opc, func3, func7, ALU_cntr);
    input [2:0] func3;
    input [1:0] ALU_opc;
    input [6:0] func7;
    output reg [2:0] ALU_cntr;
    parameter [2:0]
    ADD = 0, SUB = 1, AND = 2, OR = 3, SLT = 4, XOR = 5, SLTU = 6;
    always @(ALU_opc, func3, func7) begin
        case (ALU_opc)
            `SW_LW   : ALU_cntr <= ADD;

            `BEQ   : ALU_cntr <= SUB;

            `RT   : ALU_cntr <= (func3 == 3'h0x0 & func7 == 7'h0x00 ) ? ADD:
                                (func3 == 3'h0x0 & func7 == 7'h0x20) ? SUB:
                                (func3 == 3'h0x7) ? AND:
                                (func3 == 3'h0x6) ? OR:
                                (func3 == 3'h0x2) ? SLT:
                                (func3 == 3'h0x3) ? SLTU:3'bzzz;

            `IT   : ALU_cntr <= (func3 == 3'h0x0) ? ADD:
                                (func3 == 3'h0x4) ? XOR:
                                (func3 == 3'h0x6) ? OR:
                                (func3 == 3'h0x2) ? SLT:
                                (func3 == 3'h0x3) ? SLTU:3'bzzz;

            default: ALU_cntr <= ADD;
        endcase
    end
endmodule
