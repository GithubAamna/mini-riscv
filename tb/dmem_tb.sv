`timescale 1ns / 1ps

module dmem_tb;

    // Inputs
    reg clock;
    reg resetn;
    reg [4:0] mem_addr;
    reg write_en;
    reg [31:0] data_in;

    // Outputs
    wire [31:0] data_out;

    // Instantiating the unit under test 
    dmem uut (
        .clock(clock),
        .resetn(resetn),
        .mem_addr(mem_addr),
        .write_en(write_en),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock Generation: 10ns period (100 MHz)
    always #5 clock = ~clock;

    initial begin
        $monitor("Time=%0t | clk=%b | rstn=%b | we=%b | addr=%d | data_in=0x%08h | data_out=0x%08h", 
                 $time, clock, resetn, write_en, mem_addr, data_in, data_out);

        // Initializing Inputs
        clock = 0;
        resetn = 0;
        write_en = 0;
        mem_addr = 0;
        data_in = 0;

        // Asynchronous Reset
        #15; 
        resetn = 1; // Release reset
        #10;

        // Verifying array initialization 
        mem_addr = 5'd4; #10;
        mem_addr = 5'd31; #10;

        // Changing inputs on the negative edge to ensure stable setup time
        @(negedge clock); 
        write_en = 1;
        mem_addr = 5'd4;
        data_in = 32'hDEADBEEF;

        @(negedge clock); 
        write_en = 0;

        @(negedge clock);
        write_en = 1;
        mem_addr = 5'd31;
        data_in = 32'hCAFEBAFE;
        @(negedge clock);
        write_en = 0;

        mem_addr = 5'd4; #10;  
        mem_addr = 5'd31; #10; 
        mem_addr = 5'd10; #10; 

        $finish;
    end

endmodule