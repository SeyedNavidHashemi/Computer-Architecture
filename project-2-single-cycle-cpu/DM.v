`timescale 1ns/1ns
module Data_memory(clk, address, WD, RD, Mem_write);
    input clk, Mem_write;
    input [31:0] address, WD;
    output [31:0] RD;
    wire [31:0] new_adr;
    reg [31:0] dataMemory [0:99]; 

    assign new_adr = {2'b00, address[31:2]};
    assign RD = dataMemory[new_adr];
    
    initial $readmemb("data_memory.mem", dataMemory); 

    always @(posedge clk) begin
        if(Mem_write)
           dataMemory[new_adr] <= WD; 
    end
endmodule
