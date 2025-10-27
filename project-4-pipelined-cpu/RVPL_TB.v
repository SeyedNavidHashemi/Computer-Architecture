`timescale 1ns/1ns
module RVPL_TB();
    reg clk = 1'b1;
    reg rst = 1'b1;

    RISC_V_Pipeline UUT(.clk(clk), .rst(rst));
    always #5 clk = ~clk;

    initial begin
        #2 rst = 1'b0;
        #4000 $stop;
    end
    
endmodule