`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101
`define R_type    7'b0110011
`define I_type    7'b0010011
`define JALR_type 7'b1100111
`define LW_type   7'b0000011
`define S_type    7'b0100011
`define B_type    7'b1100011
`define U_type    7'b0110111
`define J_type    7'b1101111

module Main_controller(opc, func3, RegWriteD, MemWriteD, ALU_opc,
                      ResultSrcD, JumpD, BranchD, ALUSrcD, ImmSrcD, luiD);
    input [2:0] func3;
    input [6:0] opc;
    output reg RegWriteD, MemWriteD, ALUSrcD, luiD;
    output reg [1:0] ResultSrcD, ALU_opc, JumpD;
    output reg [2:0] BranchD, ImmSrcD;


    always @(opc, func3) begin
        {ALU_opc, RegWriteD, MemWriteD, ALUSrcD, ResultSrcD, JumpD, BranchD, ImmSrcD, luiD} <= 16'b0;
        case (opc)
            `R_type: begin
                ALU_opc <= 2'b10;
                RegWriteD <= 1'b1;
            end
        
            `I_type: begin
                ALU_opc <= 2'b11;
                ImmSrcD <= 3'b000;
                ALUSrcD <= 1'b1;
                ResultSrcD <= 2'b00;
                RegWriteD  <= 1'b1;
            end
        
            `S_type: begin
                ALU_opc <= 2'b00;
                ImmSrcD <= 3'b001;
                ALUSrcD <= 1'b1;
                MemWriteD  <= 1'b1;
            end
        
            `B_type: begin
                ALU_opc <= 2'b01;
                ImmSrcD <= 3'b010;
                case(func3)
                    `BEQ   : BranchD <= 3'b001;
                    `BNE   : BranchD <= 3'b010;
                    `BLT   : BranchD <= 3'b011;
                    `BGE   : BranchD <= 3'b100;
                    default: BranchD <= 3'b000;
                endcase
            end

            `JALR_type: begin
                ALU_opc <= 2'b00;
                ImmSrcD <= 3'b000;
                RegWriteD <= 1'b1;
                ALUSrcD <= 1'b1;
                JumpD <= 2'b10;
                ResultSrcD <= 2'b10;
            end
            
            `LW_type: begin
                ALU_opc <= 2'b00;
                ImmSrcD <= 3'b000;
                ALUSrcD <= 1'b1;
                RegWriteD  <= 1'b1;
                ResultSrcD <= 2'b01;
            end

            `J_type: begin
                ResultSrcD <= 2'b10;
                RegWriteD <= 1'b1;
                ImmSrcD <= 3'b011;
                JumpD <= 2'b01;
            end

            `U_type: begin
                ImmSrcD <= 3'b100;
                ResultSrcD <= 2'b11;
                RegWriteD <= 1'b1;
                luiD <= 1'b1;
            end
        
        endcase
    end

endmodule
