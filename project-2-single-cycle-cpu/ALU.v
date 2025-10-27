`timescale 1ns/ 1ns
module ALU(op1, op2, ALU_func, result, zero, pos);
    input signed [31:0] op1, op2;
    input [2:0] ALU_func;
    output zero, pos;
    output reg signed[31:0] result;

    parameter [2:0]
    ADD = 0, SUB = 1, AND = 2, OR = 3, SLT = 4, XOR = 5, SLTU = 6;

    assign zero = ~(|{result});
    assign pos = ~result[31];

    always @(ALU_func, op1, op2) begin
        case(ALU_func)
            ADD: result = op1 + op2;
            SUB: result = op1 - op2;
            AND: result = op1 & op2;
            OR: result = op1 | op2;
            SLT: result = (op1 < op2) ? 32'd1 : 32'd0;
            XOR: result = op1 ^ op2;
            SLTU: begin
                if ((op1[31] == 1) && (op2[31] == 0)) begin
                    result = 0;
                end
                else if ((op1[31] == 0) && (op2[31] == 1)) begin
                    result = 1;
                end
                else begin
                    result = (op1 < op2) ? 1 : 0;
                end
            end
            default: result = 32'bz;
        endcase
    end

endmodule