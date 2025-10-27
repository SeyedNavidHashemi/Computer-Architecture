`timescale 1ns/1ns
module Register_file(clk, A1, A2, A3, WD, RD1, RD2, Reg_write);
input clk, Reg_write;
input [4:0] A1, A2, A3;
inout [31:0] WD;
output [31:0] RD1, RD2;

reg [31:0] register_file [0:31];

assign RD1 = register_file[A1];
assign RD2 = register_file[A2];

initial register_file[0] = 32'd0;
    
always @(posedge clk) begin
    if(Reg_write)
        if(A3 != 5'b00000)
            register_file[A3] = WD;
end

endmodule