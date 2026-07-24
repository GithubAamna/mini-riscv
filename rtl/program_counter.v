`timescale 1ns / 1ps
// Program Counter
module program_counter(
    input clock,
    input resetn,
    input [31:0]imm,
    input [31:0]alu_result, //output of arithematic logic unit
    input beq_jal_cond,     //signal from control logic unit
    input jalr_cond,        //signal from control logic unit
    output reg [31:0]pc
);
wire [31:0]next_pc;
wire [31:0]intermediate_pc;

assign intermediate_pc = beq_jal_cond ? pc + imm : pc + 4;
assign next_pc = jalr_cond ? (alu_result & 32'hFFFFFFFE) : intermediate_pc;

always @ (posedge clock, negedge resetn)
begin
    if (!resetn)
        pc <= 0;
    else
        pc <= next_pc;
end

endmodule