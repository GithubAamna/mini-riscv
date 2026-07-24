`timescale 1ns / 1ps
// Register file
module reg_file
#(parameter ADDR_WIDTH=5,
  parameter DATA_WIDTH=32)
(
    input clock,
    input resetn,
    input write_en,
    input [ADDR_WIDTH-1:0] rs1_addr,
    input [ADDR_WIDTH-1:0] rs2_addr,
    input [ADDR_WIDTH-1:0] rd_addr,
    input [DATA_WIDTH-1:0] write_data,
    output [DATA_WIDTH-1:0] rs1_data,
    output [DATA_WIDTH-1:0] rs2_data
);

localparam DEPTH_REG= (1 << ADDR_WIDTH);
reg [DATA_WIDTH-1:0] register_file[DEPTH_REG-1:0];

always @ (posedge clock, negedge resetn)
begin
	if (!resetn)
	begin
		integer i;
		for (i=0; i< DEPTH_REG; i=i+1)
        begin
            register_file[i] <= {DATA_WIDTH{1'b0}}; 
        end

	end

	else begin
		if (write_en && rd_addr!= {ADDR_WIDTH{1'b0}})
		    register_file[rd_addr] <= write_data;
	
	end
end
    assign rs1_data = (rs1_addr != {ADDR_WIDTH{1'b0}}) ? register_file[rs1_addr] : 32'b0;
    assign rs2_data = (rs2_addr != {ADDR_WIDTH{1'b0}}) ? register_file[rs2_addr] : 32'b0;

endmodule