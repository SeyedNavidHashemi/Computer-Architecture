`timescale 1ns/1ns
module RVMC_TB();
    reg clk = 1'b1;
    reg rst = 1'b1;
    RISC_V_multi_cycle UUT(.clk(clk), .rst(rst));
    always #5 clk = ~clk;

    initial begin
        #1 rst = 1'b0;
        #2000 $stop;
    end
    
endmodule