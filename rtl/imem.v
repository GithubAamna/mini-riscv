`timescale 1ns / 1ps
// Instruction Memory
module imem
(
    input [7:0]addr, //input address from the Program Counter
    output [31:0]instruction 
);

reg [31:0] mem [255:0]; //Generating Instruction memory
assign instruction = mem[addr];

endmodule