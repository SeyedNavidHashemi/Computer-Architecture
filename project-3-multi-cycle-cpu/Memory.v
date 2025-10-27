`timescale 1ns/1ns
module Memory(clk, address, WD, RD, Mem_write);
    input clk, Mem_write;
    input [31:0] address, WD;
    output [31:0] RD;
    wire [31:0] new_adr;
    reg [31:0] Memory [0:39]; 

    assign RD = Memory[address];
    assign new_adr = {2'b00, address[31:2]};
    initial $readmemb("memory_multi_cycle.mem", Memory); 

    always @(posedge clk) begin
        if(Mem_write)
           Memory[new_adr] <= WD; 
    end
endmodule