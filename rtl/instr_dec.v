`timescale 1ns / 1ps
// Instruction Decoder
module instr_dec(
    input [31:0] instruction, //Instruction from the instruction memory
    output [6:0] opcode,    //selecting the format of instruction
    output [4:0] rs1_addr, //address of first register
    output [4:0] rs2_addr, //address of second register
    output [4:0] rd_addr,  //address of destination register
    output [2:0] func3,    
    output [6:0] func7
);

assign opcode = instruction [6:0];
assign rs1_addr = instruction [19:15];
assign rs2_addr = instruction [24:20];
assign rd_addr = instruction [11:7];
assign func3 =  instruction [14:12];
assign func7 =  instruction [31:25];

endmodule



