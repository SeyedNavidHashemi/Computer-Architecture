`timescale 1ns/ 1ns
module Adder(op1, op2, adder_res);
    parameter N = 32;
    input [N-1:0] op1, op2;
    output [N-1:0] adder_res;
    
    assign adder_res = op1 + op2;
endmodule

module Mux_2_to_1(op1, op2, select, result);
    input [31:0] op1, op2;
    input select;
    output [31:0] result;
    
    assign result = (select == 1'b1) ? op2 : op1;
endmodule

module Mux_4_to_1(op1, op2, op3, op4, select, result);
    input [31:0] op1, op2, op3, op4;
    input [1:0] select;
    output [31:0] result;
    
    assign result = (select == 2'b00) ? op1:
                    (select == 2'b01) ? op2:
                    (select == 2'b10) ? op3:
                    (select == 2'b11) ? op4:
                    op1;
endmodule

module Register_F(clk, rst, EN, CLR, PCF, InstrF, PCPlus4F, InstD, PCD, PCPlus4D);
    input clk, rst, EN, CLR;
    input [31:0] PCF, InstrF, PCPlus4F;
    output reg [31:0] InstD, PCD, PCPlus4D;
    
    always @(posedge clk, posedge rst) begin
        if(rst || CLR) begin
            InstD <= 32'b0;
            PCD <= 32'b0;
            PCPlus4D <= 3'b0;
        end 
        else if(EN) begin
            InstD <= InstrF;
            PCD <= PCF;
            PCPlus4D <= PCPlus4F;
        end
        
    end

endmodule

module Register_D(clk, rst, CLR, RegWriteD, ResultSrcD, MemWriteD, JumpD,
                BranchD, ALUControlD, ALUSrcD, luiD, RD1D, RD2D, PCD, Rs1D,
                Rs2D, RdD, ExtImmD, PCPlus4D, RegWriteE, ResultSrcE, MemWriteE, 
                JumpE, BranchE, ALUControlE, ALUSrcE, luiE, RD1E, RD2E, PCE, Rs1E, Rs2E,
                RdE, ExtImmE, PCPlus4E);

    input clk, rst, CLR, ALUSrcD, RegWriteD, MemWriteD, luiD;
    input [31:0] PCD, RD1D, RD2D, PCPlus4D, ExtImmD;
    input [4:0] Rs1D, Rs2D, RdD;
    input [2:0] BranchD, ALUControlD;
    input [1:0] JumpD, ResultSrcD;
    output reg ALUSrcE, RegWriteE, MemWriteE, luiE;
    output reg [31:0] RD1E, RD2E, PCE, PCPlus4E, ExtImmE;
    output reg [4:0] Rs1E, Rs2E, RdE;
    output reg [2:0] BranchE, ALUControlE;
    output reg [1:0] JumpE, ResultSrcE;
    
    always @(posedge clk or posedge rst) begin
        if (rst || CLR) begin
            luiE <= 1'b0;
            ALUSrcE <= 1'b0;
            RegWriteE <= 1'b0;
            MemWriteE <= 1'b0;
            RD1E <= 32'b0;
            RD2E <= 32'b0;
            PCE <= 32'b0;
            PCPlus4E <= 32'b0;
            ExtImmE <= 32'b0;
            Rs1E <= 5'b0;
            Rs2E <= 5'b0;
            RdE <= 5'b0;
            BranchE <= 3'b0;
            ALUControlE <= 3'b000;
            JumpE <= 2'b0;
            ResultSrcE <= 2'b00;
        end
        else begin
            luiE <= luiD;
            ALUSrcE <= ALUSrcD;
            RegWriteE <= RegWriteD;
            MemWriteE <= MemWriteD;
            ALUControlE <= ALUControlD;
            RD1E <= RD1D;
            RD2E <= RD2D;
            PCE <= PCD;
            PCPlus4E <= PCPlus4D;
            ExtImmE <= ExtImmD;
            Rs1E <= Rs1D;
            Rs2E <= Rs2D;
            RdE <= RdD;
            BranchE <= BranchD;
            JumpE <= JumpD;
            ResultSrcE <= ResultSrcD;
        end
    end

endmodule

module Register_EX(clk, rst, RegWriteE, ResultSrcE, MemWriteE, luiE, 
                 ALUResultE, WriteDataE, RdE, PCPlus4E, ExtImmE,
                 RegWriteM, ResultSrcM, MemWriteM, luiM, ALUResultM,
                 WriteDataM, RdM, PCPlus4M, ExtImmM);

    input clk, rst, RegWriteE, MemWriteE, luiE;
    input [1:0] ResultSrcE;
    input [4:0] RdE;
    input [31:0] ALUResultE, WriteDataE, PCPlus4E, ExtImmE;
    
    output reg RegWriteM, MemWriteM, luiM;
    output reg [1:0] ResultSrcM;
    output reg [4:0] RdM;
    output reg [31:0] ALUResultM, WriteDataM, PCPlus4M, ExtImmM;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            RdM <= 5'b0;
            ALUResultM <= 32'b0;
            WriteDataM <= 32'b0;
            PCPlus4M <= 32'b0;
            ExtImmM <= 32'b0;
            RegWriteM <= 1'b0;
            MemWriteM <= 1'b0;
            ResultSrcM <= 2'b0;
            luiM <= 1'b0;
        end 
        
        else begin
            RdM <= RdE;
            ALUResultM <= ALUResultE;
            WriteDataM <= WriteDataE;
            PCPlus4M <= PCPlus4E;
            RegWriteM <= RegWriteE;
            MemWriteM <= MemWriteE;
            ResultSrcM <= ResultSrcE;
            luiM <= luiE;
            ExtImmM <= ExtImmE;
        end
    end

endmodule

module Register_MEM(clk, rst, RegWriteM, ResultSrcM, ALUResultM, ReadDataM, RdM, ExtImmM, PCPlus4M,
                    RegWriteW, ResultSrcW, ALUResultW, ReadDataW, ExtImmW, PCPlus4W, RdW);
    
    input clk, rst, RegWriteM;
    input [1:0] ResultSrcM;
    input [4:0] RdM;
    input [31:0] ALUResultM, ReadDataM, ExtImmM, PCPlus4M;
    output reg RegWriteW;
    output reg [1:0] ResultSrcW;
    output reg [4:0] RdW;
    output reg [31:0] ALUResultW, ReadDataW, ExtImmW, PCPlus4W;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            RegWriteW <= 32'b0;
            ResultSrcW <= 2'b0;
            ALUResultW <= 32'b0;
            ReadDataW <= 32'b0;
            ExtImmW <= 32'b0;
            PCPlus4W <= 32'b0;
            RdW <= 5'b0;
        end 
        
        else begin
            RegWriteW <= RegWriteM; 
            ResultSrcW <= ResultSrcM;
            ALUResultW <= ALUResultM;
            ReadDataW <= ReadDataM;
            ExtImmW <= ExtImmM;
            PCPlus4W <= PCPlus4M;
            RdW <= RdM;
        end 
    end

endmodule

module reg_32_bit_load(clk, rst, load, reg_in, reg_out);
    input clk, rst, load;
    input [31:0] reg_in;
    output reg[31:0] reg_out;

    always @(posedge clk, posedge rst) begin
        if(rst)
            reg_out <= 32'b0;
        else if(load)
            reg_out <= reg_in;
    end
endmodule

module Register_file(clk, A1, A2, A3, WD, RD1, RD2, Reg_write);
    input clk, Reg_write;
    input [4:0] A1, A2, A3;
    inout [31:0] WD;
    output reg [31:0] RD1, RD2;
    reg [31:0] register_file [0:31];

    initial register_file[0] = 32'd0;
        
    always @(posedge clk) begin
        if(Reg_write) begin
            if(A3 != 5'b00000)
                register_file[A3] <= WD;
        end
    end

    always @(negedge clk) begin
        RD1 <= register_file[A1];
        RD2 <= register_file[A2];
    end

endmodule