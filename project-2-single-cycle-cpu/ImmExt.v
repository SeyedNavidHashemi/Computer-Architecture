`timescale 1ns/1ns
module ImmExtension(Imm_in, Imm_src, result);
    input [24:0] Imm_in;
    input [2:0] Imm_src;
    output reg [31:0] result;
    parameter [2:0]
    I_type = 0, S_type = 1, B_type = 2, J_type = 3, U_type = 4;
    
    always @(Imm_in, Imm_src) begin
        case(Imm_src)
            I_type   : result <= {{20{Imm_in[24]}}, Imm_in[24:13]};
            S_type   : result <= {{20{Imm_in[24]}}, Imm_in[24:18], Imm_in[4:0]};
            B_type   : result <= {{20{Imm_in[24]}}, Imm_in[0], Imm_in[23:18], Imm_in[4:1], 1'b0};
            J_type   : result <= {{12{Imm_in[24]}}, Imm_in[12:5], Imm_in[13], Imm_in[23:14], 1'b0};
            U_type  : result <= {Imm_in[24:5], {12{1'b0}}};
            default: result <= 32'b0;
        endcase
    end

endmodule