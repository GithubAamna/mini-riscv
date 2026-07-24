`timescale 1ns / 1ps
// Data Memory
module dmem
(
    input clock,
    input resetn,
    input [4:0] mem_addr,
    input write_en, //enable for writing to register file
    input [31:0]data_in, //input data
    output [31:0]data_out //output data
);

reg [31:0] dmem [31:0];

always @ (posedge clock, negedge resetn)
begin
    if (!resetn)
    begin
		integer i;
		for (i=0; i< 32; i=i+1)
        begin
            dmem[i] <= {32{1'b0}}; //initializing register file to zero upon reset
        end
    end
    else if (write_en)
        dmem[mem_addr] <= data_in;
    
end
assign data_out =dmem[mem_addr];

endmodule