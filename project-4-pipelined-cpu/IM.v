`timescale 1ns/1ns
module Instruction_memory(address, instruction);
    input [31:0] address;
    output [31:0] instruction;

    reg [31:0] instruction_memory [0:19];
    wire [31:0] new_adr;
    assign new_adr = {2'b00, address[31:2]};

    
    initial $readmemb("inst_pipeline.mem", instruction_memory);

    assign instruction = instruction_memory[new_adr];
endmodule