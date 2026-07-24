`timescale 1ns / 1ps

module immediate_gen_tb;

    // Inputs
    reg [31:0] instruction;

    // Outputs
    wire [31:0] immediate;

    // Instantiating the unit under test 
    immediate_gen uut (
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin
        
        $monitor("Time=%0t | Instruction=0x%08h | Output Immediate=0x%08h", 
                 $time, instruction, immediate);

        // Test Case 1: I-Format -> ADDI x1, x2, 0x123
        instruction = 32'h12310093; #10;

        // Test Case 2: I-Format -> ADDI x1, x2, -1
        instruction = 32'hFFF10093; #10;

        // Test Case 3: S-Format -> SW x2, 16(x1)
        instruction = 32'h0020a823; #10;

        // Test Case 4: B-Format -> BEQ x1, x2, +16
        instruction = 32'h00208863; #10;

        // Test Case 5: U-Format -> LUI x1, 0x12345
        instruction = 32'h123450B7; #10;

        // Test Case 6: J-Format -> JAL x1, -4
        instruction = 32'hFFDFF0EF; #10;

        // Test Case 7: R-Format -> ADD x1, x2, x3
        instruction = 32'h003100B3; #10;

        $finish;
    end

endmodule