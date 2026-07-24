`timescale 1ns / 1ps
// Arithmetic Logic Unit
module alu
(
    input [31:0] operand_1,operand_2,
    input alu_op,
    output [31:0] alu_result
);

assign alu_result = (alu_op ? operand_1 - operand_2 : operand_1 + operand_2);

endmodule