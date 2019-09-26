// Written by XJ
// Create Date: 25.09.2019 17:33:36
// Project Name: practical0
// Module Name: fulladder

`timescale 1ns / 1ps

module fulladder(
    input bit0,
    input bit1,
    input carry_in,
    output sum,
    output carry_out,
    input clock,
    input reset
    );
    
    reg sm, co;
    
always @(posedge clock or posedge reset)
begin
    if (reset == 1'b0)
        begin
            sm <= 1'b0;
            co <= 1'b0;
        end
    else
        begin
            sm <= (bit0 ^ bit1) ^ carry_in;
            co <= (bit0 & bit1) | (carry_in & (bit0 ^ bit1));
        end
end    

assign sum = sm;
assign carry_out = co; 

endmodule
