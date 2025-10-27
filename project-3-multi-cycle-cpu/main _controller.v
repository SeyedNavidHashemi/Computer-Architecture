`timescale 1ns/1ns
`define R_type    7'b0110011
`define LW_type   7'b0000011
`define I_type    7'b0010011
`define JALR_type 7'b1100111
`define S_type    7'b0100011
`define J_type    7'b1101111
`define B_type    7'b1100011
`define U_type    7'b0110111

module Main_controller(clk, rst, opc, zero, pos, PC_write_cond, PC_write, Adr_src, old_PC_write, Mem_write, IR_write, Reg_write, Imm_src, ALU_srcA, ALU_srcB, ALU_opc, Result_src);
    input[6:0] opc;
    input zero, pos, clk, rst;
    output reg PC_write, old_PC_write, Mem_write, IR_write, Reg_write, PC_write_cond;
    output reg[1:0] Adr_src, ALU_srcA, ALU_srcB, ALU_opc;
    output reg[2:0] Imm_src, Result_src;

    parameter[3:0]
    IF = 0, ID = 1, B1 = 2, U1 = 3, R1 = 4, R2 = 5, J1 = 6, J2 = 7, MR = 8, LW1 = 9, LW2 = 10, SW = 11, JLR1 = 12, JLR2 = 13;

    reg [3:0] ps, ns;
    always @(posedge clk, posedge rst) begin
        if(rst)
            ps <= IF;
        else
            ps <= ns;
    end

    always @(ps, opc) begin
        case(ps)
            IF: ns <= ID;
            ID: ns <= (opc == `JALR_type) ? JLR1:
                      ((opc == `LW_type) || (opc == `I_type) || (opc == `S_type)) ? MR:
                      (opc == `J_type) ? J1:
                      (opc == `R_type) ? R1:
                      (opc == `U_type) ? U1:
                      (opc == `B_type) ? B1: IF;
            B1: ns <= IF;
            U1: ns <= IF;
            R1: ns <= R2;
            R2: ns <= IF;
            J1: ns <= J2;
            J2: ns <= IF;
            MR: ns <= (opc == `S_type) ? SW:
                      (opc == `LW_type) ? LW1: IF;
            LW1: ns <= LW2;
            LW2: ns <= IF;
            SW: ns <= IF;
            JLR1: ns <= JLR2;
            JLR2: ns <= IF;
        endcase
    end

    always @(ps) begin
        {PC_write, old_PC_write, Mem_write, IR_write, Reg_write, Adr_src, ALU_srcA, ALU_srcB, ALU_opc, Imm_src, Result_src} = 19'b0;//Br
        case(ps)
            IF: 
            begin
                Adr_src <= 1'b0;
                IR_write <= 1'b1;
                ALU_srcA <= 2'b00;
                ALU_srcB <= 2'b10;
                ALU_opc <= 2'b00;
                Result_src <= 3'd1;
                PC_write <= 1'b1;
                old_PC_write <= 1'b1;
            end 

            ID: 
            begin
                ALU_srcA <= 2'd1;
                ALU_srcB <= 2'd1;
                Imm_src <= 3'b010;//B_type
                ALU_opc <= 2'b00;
            end 

            B1: 
            begin
                ALU_srcA <= 2'b10;
                ALU_srcB <= 2'b00;
                ALU_opc <= 2'b01;
                Result_src <= 3'd0;
                PC_write_cond <= 1'b1;
            end

            U1: 
            begin
                Imm_src <= 3'b100;//U_type
                Result_src <= 3'd3;
                Reg_write <= 1'b1;
            end 

            R1: 
            begin
                ALU_srcA <= 2'b10;
                ALU_srcB <= 2'b00;
                ALU_opc <= 2'b10;//f3, f7
            end 

            R2: 
            begin
                Result_src <= 3'd0;
                Reg_write <= 1'b1;
            end 

            MR: 
            begin
                ALU_srcA <= 2'b10;
                ALU_srcB <= 2'b01;
                Imm_src <= ((opc == `I_type) | (opc == `LW_type)) ? 3'b000://I_type
                           (opc == `S_type) ? 3'b001 : 3'bzzz;//S_type
                ALU_opc <= ((opc == `I_type) | (opc == `LW_type)) ? 2'b10://f3, f7
                           (opc == `S_type) ? 2'b00 : 3'bzzz;//+
            end 

            LW1: 
            begin
                Result_src <= 3'b000;
                Adr_src <= 1'b1;
            end

            LW2: 
            begin
                Result_src <= 3'b010;
                Reg_write <= 1'b1;
            end

            SW: 
            begin
                Result_src <= 3'b000;
                Adr_src <= 1'b1;
                Mem_write <= 1'b1;
            end 

            JLR1: 
            begin
                Result_src <= 3'b100;
                Reg_write <= 1'b1;
                ALU_srcA <= 2'b10;
                ALU_srcB <= 2'b01;
                Imm_src <= 3'b000;//I_type
            end

            JLR2: 
            begin
                Result_src <= 3'b000;
                PC_write <= 1'b1;
            end
        endcase
    end

endmodule