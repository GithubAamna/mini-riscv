`timescale 1ns / 1ps

module program_counter_tb;

    // Inputs
    reg clock;
    reg resetn;
    reg [31:0] imm;
    reg [31:0] alu_result;
    reg beq_jal_cond;
    reg jalr_cond;

    // Outputs
    wire [31:0] pc;

    // Instantiating the Unit Under Test 
    program_counter uut (
        .clock(clock),
        .resetn(resetn),
        .imm(imm),
        .alu_result(alu_result),
        .beq_jal_cond(beq_jal_cond),
        .jalr_cond(jalr_cond),
        .pc(pc)
    );

    // Clock Generation: 10ns period (100 MHz)
    always #5 clock = ~clock;

    initial begin
        $monitor("Time=%0t | rstn=%b | beq_jal=%b | jalr=%b | imm=%d | alu_res=0x%08h | PC=0x%08h", 
                 $time, resetn, beq_jal_cond, jalr_cond, $signed(imm), alu_result, pc);

        // Initializing the inputs
        clock = 0;
        resetn = 0;
        imm = 0;
        alu_result = 0;
        beq_jal_cond = 0;
        jalr_cond = 0;


        // Asynchronous Reset
        #15; 
        resetn = 1; // Release reset. 
        
        #30; 

        @(negedge clock); 
        beq_jal_cond = 1; //turn on branch condition
        imm = 32'd16; // Jump forward by 16 bytes
        @(negedge clock); // Waiting for the positive edge to latch the new PC
        beq_jal_cond = 0; // Turn off branch condition

        #10; //normal execution


        @(negedge clock);
        jalr_cond = 1; //turn on jump and link condition
        alu_result = 32'h00001001; 
        @(negedge clock);
        jalr_cond = 0; //turn off jump and link condition

        #20; //normal execution for next few cycles

        $finish;
    end

endmodule