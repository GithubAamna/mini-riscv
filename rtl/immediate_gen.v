`timescale 1ns / 1ps
// Immediate Generation Unit
module immediate_gen
(
    input [31:0]instruction,
    output reg[31:0]immediate
);
    always @ (*)
    begin
             //for I format
        if ((instruction[6:0] == 7'b0010011 )|(instruction[6:0] == 7'b0000011)|(instruction[6:0] == 7'b1100111)) 
            immediate = {{21{instruction[31]}},instruction[30:25],instruction[24:21],instruction[20]};
            
            //for S format
        else if (instruction[6:0] == 7'b0100011) 
            immediate = {{21{instruction[31]}},instruction[30:25],instruction[11:8],instruction[7]};

            //for B format
        else if (instruction[6:0] == 7'b1100011) 
            immediate = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};

            //for U-format
        else if (instruction[6:0] == 7'b0110111) 
            immediate = {instruction[31],instruction[30:20],instruction[19:12],{12{1'b0}}};

            //for J format
        else if (instruction[6:0] == 7'b1101111) 
            immediate = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:25],instruction[24:21],1'b0};

        else
            immediate = 32'b0;
                
    end
endmodule