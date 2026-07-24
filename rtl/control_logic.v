`timescale 1ns / 1ps
// Control Logic Unit
module control_logic
(
  input [6:0]opcode,
  input [2:0]func3,
  input [6:0]func7,
  
  output mem2reg,     //
  output mem_write,   //bit to enable data memory
  output alu_op,      //select bit for add and sub operation
  output operand_sel, 
  output reg_write,   //bit to enable writing to register file
  output branch,
  output jump_and_link,
  output jalr_cond,
  output lui_cond
  );

assign alu_op = ((opcode == 7'b0110011) & (func7 == 7'h20));
assign operand_sel = (opcode != 7'b0110011) & (opcode != 7'b1100011);
assign mem_write = ((opcode == 7'b0100011) & (func3 == 3'h2)); //sw
assign mem2reg = ((opcode == 7'b0000011) & (func3 == 3'h2)); //lw
assign reg_write = (opcode != 7'b0100011) & (opcode != 7'b1100011) ;
assign branch = (opcode == 7'b1100011);
assign jump_and_link = (opcode == 7'b1101111);
assign jalr_cond = ((opcode == 7'b1100111) & (func3 == 3'h0));
assign lui_cond = (opcode ==7'b0110111);

endmodule