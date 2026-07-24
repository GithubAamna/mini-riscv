`timescale 1ns / 1ps
// Branch Comparator
module branch_comp
(
    input [31:0] rs1_data,
    input [31:0] rs2_data,
    output br_equal
);

assign br_equal = (rs1_data == rs2_data);
endmodule