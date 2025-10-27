`timescale 1ns/1ns
module DS_Ca1_TB();
    reg CLK = 1'b0;
    reg SCLR = 1'b0;
    reg [9:0] A_IN = 10'b0010100000;
    reg [9:0] B_IN = 10'b0000100000;
    reg START = 1'b0;

    wire [9:0] Q_OUT;
    wire DVZ, OVF, BUSY, VALID;

    divider UUT1(.AIN(A_IN), .BIN(B_IN), .START(START), .SCLR(SCLR), .CLK(CLK), .QOUT(Q_OUT), .DVZ(DVZ), .OVF(OVF), .BUSY(BUSY), .VALID(VALID));
    initial repeat(200) #350 CLK = ~CLK;
    initial begin
    #1000 SCLR = 1'b1;
    #1000 SCLR = 1'b0;
    #1000 START = 1'b1;
    #1000 START = 1'b0;

    end
endmodule