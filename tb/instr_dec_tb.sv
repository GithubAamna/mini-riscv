`timescale 1ns / 1ps

module instr_dec_tb;

    // Inputs
    reg [31:0] instruction;

    // Outputs
    wire [6:0] opcode;
    wire [4:0] rs1_addr;
    wire [4:0] rs2_addr;
    wire [4:0] rd_addr;
    wire [2:0] func3;
    wire [6:0] func7;

    // Instantiating the Unit Under Test 
    instr_dec uut (
        .instruction(instruction),
        .opcode(opcode),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .func3(func3),
        .func7(func7)
    );

    initial begin
        $monitor("Time=%0t | Inst=0x%08h || Op=0x%02h | rs1=%d | rs2=%d | rd=%d | f3=%b | f7=0x%02h", 
                 $time, instruction, opcode, rs1_addr, rs2_addr, rd_addr, func3, func7);

        // Test Case 1: R-Type Instruction (ADD x1, x2, x3)
        instruction = 32'h003100B3; #10;

        // Test Case 2: I-Type Instruction (ADDI x5, x6, 15)
        instruction = 32'h00F30293; #10;

        // Test Case 3: S-Type Instruction (SW x7, 16(x8))
        instruction = 32'h00742823; #10;

        // Test Case 4: U-Type Instruction (LUI x9, 0x12345)
        instruction = 32'h123454B7; #10;

        // Test Case 5: B-Type Instruction (BEQ x10, x11, +16)
        instruction = 32'h00B50863; #10;

        $finish;
    end

endmodule