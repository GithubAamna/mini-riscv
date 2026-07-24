`timescale 1ns / 1ps

module alu_tb;

    // Inputs
    reg [31:0] operand_1;
    reg [31:0] operand_2;
    reg alu_op;

    // Outputs
    wire [31:0] alu_result;

    // Instantiating the unit under test 
    alu uut (
        .operand_1(operand_1),
        .operand_2(operand_2),
        .alu_op(alu_op),
        .alu_result(alu_result)
    );

    initial begin
        
        $monitor("Time=%0t | ALU_Op=%b | Op1=%d (0x%08h) | Op2=%d (0x%08h) | Result=%d (0x%08h)", 
                 $time, alu_op, $signed(operand_1), operand_1, $signed(operand_2), operand_2, $signed(alu_result), alu_result);

        // Test Case 1: Simple Addition 
        // 15 + 10 = 25
        operand_1 = 32'd15; operand_2 = 32'd10; alu_op = 1'b0; #10;

        // Test Case 2: Addition with a negative number 
        // 20 + (-5) = 15
        operand_1 = 32'd20; operand_2 = -32'd5; alu_op = 1'b0; #10;

        // Test Case 3: Zero Addition 
        // 0 + 4096 = 4096
        operand_1 = 32'd0; operand_2 = 32'd4096; alu_op = 1'b0; #10;

        // Test Case 4: Simple Subtraction 
        // 50 - 15 = 35
        operand_1 = 32'd50; operand_2 = 32'd15; alu_op = 1'b1; #10;

        // Test Case 5: Subtraction resulting in a negative number 
        // 10 - 25 = -15
        operand_1 = 32'd10; operand_2 = 32'd25; alu_op = 1'b1; #10;

        // Test Case 6: Subtraction of a negative number 
        // 10 - (-5) = 15
        operand_1 = 32'd10; operand_2 = -32'd5; alu_op = 1'b1; #10;

        $finish;
    end

endmodule