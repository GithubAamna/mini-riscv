`timescale 1ns / 1ps

module imem_tb;

    // Inputs
    reg [7:0] addr;

    // Outputs
    wire [31:0] instruction;

    // Instantiating the unit under test (UUT)
    imem uut (
        .addr(addr),
        .instruction(instruction)
    );

    initial begin
        
        // Injecting dummy machine code directly into the UUT's array
        uut.mem[0]   = 32'h00000033; 
        uut.mem[1]   = 32'h00100093; 
        uut.mem[2]   = 32'h002081B3; 
        uut.mem[255] = 32'hFFFFFFFF; 

        // Monitor changes and print them to the console
        $monitor("Time=%0t | Address Index=%d | Output Instruction=0x%08h", 
                 $time, addr, instruction);

        // Test Case 1: Read index 0
        addr = 8'd0; #10;

        // Test Case 2: Read index 1
        addr = 8'd1; #10;

        // Test Case 3: Read index 2
        addr = 8'd2; #10;

        // Test Case 4: Read an uninitialized memory slot
        addr = 8'd10; #10;

        // Test Case 5: Read index 255
        addr = 8'd255; #10;

        $finish;
    end

endmodule