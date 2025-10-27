`timescale 1ns/1ns
`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101
module Branch_controller(branch, func3, zero, pos, Par_PcSrc);
    input [2:0] func3;
    input branch, zero, pos;
    output reg [1:0] Par_PcSrc;
    reg temp1, temp2;
    assign temp1 = zero & pos;
    assign temp2 = zero | pos;
    
    always @(branch, func3, zero, pos, temp1, temp2) begin
        case(func3)
            `BEQ: Par_PcSrc <= {1'b0, zero};
            `BNE: Par_PcSrc <= {1'b0, ~zero};
            `BLT: Par_PcSrc <= {1'b0, ~pos};
            `BGE: Par_PcSrc <= {1'b0, temp2};
            default: Par_PcSrc <= 2'b00;
        endcase
    end
endmodule
// (zero | pos)