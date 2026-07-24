`timescale 1ns / 1ps

module riscv_dev_tb;

    // Inputs
    reg clock;
    reg resetn;

    // Instantiating the Top-Level Processor 
    riscv_dev uut (
        .clock(clock),
        .resetn(resetn)
    );

    // Clock Generation: 10ns period (100 MHz)
    always #5 clock = ~clock;

    initial begin
        
        // This command looks for 'program.hex' in the tb directory
        // and loads the hexadecimal instructions into the 'mem' array.
        $readmemh("../tb/self_test.hex", uut.instruction_mem_1.mem);

        $monitor("Time=%0t | rstn=%b | PC=0x%08h | Inst=0x%08h | ALU=0x%08h | RegWriteData=0x%08h", 
                 $time, resetn, uut.new_pc, uut.instruction, uut.alu_result, uut.dest_in);

        // System Reset
        clock = 0;
        resetn = 0;

        // Holding reset low to ensure the Program Counter and Reg File are cleared
        #15; 
        resetn = 1;

        // Processor run freely to execute the loaded program.
        #200;

        $finish;
    end


endmodule