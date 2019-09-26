// Written by XJ
// Create Date: 25.09.2019 17:33:36
// Project Name: practical0
// Module Name: DFFfulladder

`timescale 1ns / 1ps

module DFFfulladder(
    input bit0,
    input bit1,
    input carry_in,
    output reg sum,
    output reg carry_out,
    input clock,
    input reset
    );
    
    //reg sm, co;
    
always @(posedge clock or posedge reset)
begin
    if (reset == 1'b0)
        begin
            sum <= 1'b0;
            carry_out <= 1'b0;
        end // if
    else
        begin
            sum <= (bit0 ^ bit1) ^ carry_in;
            carry_out <= (bit0 & bit1) | (carry_in & (bit0 ^ bit1));
        end // else
end // always

//assign sum = sm;
//assign carry_out = co; 

endmodule // fulladder
