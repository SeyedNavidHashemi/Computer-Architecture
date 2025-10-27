`timescale 1ns/1ns
module Hazard_Unit(Rs1D, Rs2D, RdE, Rs2E, Rs1E, PCSrcE,
                   ResultSrcE0, RdM, RegWriteM, RdW, RegWriteW,
                   StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);

    input ResultSrcE0, RegWriteM, RegWriteW;
    input [1:0] PCSrcE;
    input [4:0] Rs1D, Rs2D, RdE, Rs2E, Rs1E, RdM, RdW;
    output reg StallF, StallD, FlushD, FlushE;
    output reg [1:0] ForwardAE, ForwardBE;

    //Data Hazard Logic
    always @(RegWriteM, RegWriteW, Rs1E, RdM, RdW) begin
        if(((Rs1E == RdM) && RegWriteM) && Rs1E)
            ForwardAE <= 2'b10;
        else if(((Rs1E == RdW) && RegWriteW) && Rs1E)
            ForwardAE <= 2'b01;
        else
            ForwardAE <= 2'b00;
    end    
    always @(RegWriteM, RegWriteW, Rs2E, RdM, RdW) begin
        if(((Rs2E == RdM) && RegWriteM) && Rs2E)
            ForwardBE <= 2'b10;
        else if(((Rs2E == RdW) && RegWriteW) && Rs2E)
            ForwardBE <= 2'b01;
        else
            ForwardBE <= 2'b00;
    end    

    //Load Word Stall Logic
    reg lwStall;
    assign lwStall = (((Rs1D == RdE) || (Rs2D == RdE)) && ResultSrcE0) ? 1'b1 : 1'b0;
    assign StallF = lwStall;
    assign StallD = lwStall;

    //Control Hazard Flush
    assign FlushD = (PCSrcE != 2'b00 ) ? 1'b1 : 1'b0;
    assign FlushE = lwStall || (PCSrcE != 2'b00);

endmodule

