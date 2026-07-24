module reg_file_tb;

    parameter ADDR_WIDTH=5;
    parameter DATA_WIDTH=32;
    
    // Inputs
    reg clock;
    reg resetn;
    reg write_en;
    reg [ADDR_WIDTH-1:0] rs1_addr;
    reg [ADDR_WIDTH-1:0] rs2_addr;
    reg [ADDR_WIDTH-1:0] rd_addr;
    reg [DATA_WIDTH-1:0] write_data;

    //Outputs
    wire [DATA_WIDTH-1:0] rs1_data;
    wire [DATA_WIDTH-1:0] rs2_data;

    //Instantiating the unit under test
    reg_file u_reg_file
    (
        .clock(clock),
        .resetn(resetn),
        .write_en(write_en),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .write_data(write_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    parameter T=10;

    // Clock Generation
    initial begin
        clock = 1'b0;
        #(T/2);

        forever begin
            clock = ~ clock; #(T/2);
        end
    end

    initial begin
        //Initializing the inputs
        resetn = 1'b0;
        write_en = 1'b0;
        rs1_addr = 1'b0;
        rs2_addr = 1'b0;
        rd_addr = 1'b0;
        write_data = 1'b0;
        #(T/2);

        resetn = 1'b1;
        #(T/2);

        rd_addr = 5;
        write_data = 13;
        write_en = 1;

        #(T);

        write_en=0;
        rs1_addr = 5;

        #(5*T);

        $finish;

    end

endmodule