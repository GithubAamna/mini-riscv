`timescale 1ns / 1ps

module tb_control_logic;

    // Inputs to the module
    reg [6:0] opcode;
    reg [2:0] func3;
    reg [6:0] func7;

    // Outputs from the module
    wire mem2reg;
    wire mem_write;
    wire alu_op;
    wire operand_sel;
    wire reg_write;
    wire branch;
    wire jump_and_link;
    wire jalr_cond;
    wire lui_cond;

    // Instantiating the Unit Under Test (UUT)
    control_logic uut (
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .mem2reg(mem2reg),
        .mem_write(mem_write),
        .alu_op(alu_op),
        .operand_sel(operand_sel),
        .reg_write(reg_write),
        .branch(branch),
        .jump_and_link(jump_and_link),
        .jalr_cond(jalr_cond),
        .lui_cond(lui_cond)
    );

    initial begin
        
        $monitor("Time=%0t | Op=%b | Mem2Reg=%b | MemWr=%b | ALUOp=%b | OpSel=%b | RegWr=%b | Br=%b | JAL=%b | JALR=%b | LUI=%b",
                 $time, opcode, mem2reg, mem_write, alu_op, operand_sel, reg_write, branch, jump_and_link, jalr_cond, lui_cond);

        // Test Case 1: ADD 
        opcode = 7'b0110011; func3 = 3'b000; func7 = 7'b0000000; #10;

        // Test Case 2: SUB 
        opcode = 7'b0110011; func3 = 3'b000; func7 = 7'h20; #10;

        // Test Case 3: ADDI 
        opcode = 7'b0010011; func3 = 3'b000; func7 = 7'b0000000; #10;

        // Test Case 4: LW 
        opcode = 7'b0000011; func3 = 3'b010; func7 = 7'b0000000; #10;

        // Test Case 5: SW 
        opcode = 7'b0100011; func3 = 3'b010; func7 = 7'b0000000; #10;

        // Test Case 6: BEQ 
        opcode = 7'b1100011; func3 = 3'b000; func7 = 7'b0000000; #10;

        // Test Case 7: JAL
        opcode = 7'b1101111; func3 = 3'b000; func7 = 7'b0000000; #10;

        // Test Case 8: LUI
        opcode = 7'b0110111; func3 = 3'b000; func7 = 7'b0000000; #10;

        $finish;
    end

endmodule