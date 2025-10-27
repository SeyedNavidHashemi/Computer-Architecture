`timescale 1ns/1ns
`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101
module B_controller(PC_write_cond, func3, zero, pos, Par_PcSrc);
    input [2:0] func3;
    input PC_write_cond, zero, pos;
    output reg [1:0] Par_PcSrc;
    reg temp1, temp2;
    assign temp1 = zero & pos;
    assign temp2 = zero | pos;
    
    always @(func3, zero, pos, temp1, temp2) begin
        case(func3)
            `BEQ: Par_PcSrc <= (zero & PC_write_cond);
            `BNE: Par_PcSrc <= (~zero & PC_write_cond);
            `BLT: Par_PcSrc <= (pos & PC_write_cond);
            `BGE: Par_PcSrc <= (temp2 & PC_write_cond);
            default: Par_PcSrc <= 2'b00;
        endcase
    end
endmodule