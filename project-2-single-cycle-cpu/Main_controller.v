`timescale 1ns/1ns
`define R_type    7'b0110011
`define I_type    7'b0010011
`define JALR_type 7'b1100111
`define LW_type   7'b0000011
`define S_type    7'b0100011
`define B_type    7'b1100011
`define U_type    7'b0110111
`define J_type    7'b1101111

module Main_controller(opc, zero, branch, jalr, jal, Reg_write, Imm_src, ALU_opc, Mem_write, Result_src, ALU_src);
    input [6:0] opc;
    input zero;
    output reg branch, Reg_write, Mem_write, ALU_src, jal, jalr;
    output reg [1:0] ALU_opc, Result_src;
    output reg [2:0] Imm_src;
    
    always @(opc) begin 
        {branch, jalr, jal, Reg_write, Imm_src, ALU_opc, Mem_write, Result_src, ALU_src} <= 13'b0;
        case(opc)
            `R_type: begin 
                ALU_opc <= 2'b10; 
                Reg_write <= 1'b1; 
                ALU_src <= 1'b0; 
                end
            `I_type:begin
                ALU_opc <= 2'b11;
                Imm_src <= 3'b000;
                Reg_write <= 1'b1;
                ALU_src <= 1'b1;
                Result_src <= 2'b00;
                jalr <= 1'b0;
            end
            `JALR_type:begin
                ALU_opc     <= 2'b00;
                Imm_src    <= 3'b000;
                Reg_write  <= 1'b1;
                ALU_src    <= 1'b1;
                Result_src <= 2'b11;
                // Pc_src <= 2'b10;
                jalr      <= 1'b1;
            end
            `LW_type:begin
                ALU_opc <= 2'b00;
                Imm_src <= 3'b000;
                Reg_write <= 1'b1;
                ALU_src <= 1'b1;
                Result_src <= 2'b01;
                jalr <= 1'b0;
            end
            `S_type:begin
                ALU_opc <= 2'b00;
                Imm_src <= 3'b001;
                Mem_write  <= 1'b1;
                ALU_src <= 1'b1;
            end
            `J_type:begin
                Result_src <= 2'b11;
                Reg_write  <= 1'b1;
                // Pc_src <= 2'b01;
                Imm_src <= 3'b011;
                jal <= 1'b1;
            end
            `B_type:begin
                branch <= 1'b1;
                ALU_opc <= 2'b01;
                Imm_src <= 3'b010;
            end
            `U_type:begin
                Result_src <= 2'b10;
                Reg_write <= 1'b1;
                Imm_src <= 3'b100;
            end
        endcase
    end
endmodule