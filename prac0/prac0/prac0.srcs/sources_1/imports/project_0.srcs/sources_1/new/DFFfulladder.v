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
    wire sm, co;
    assign sm = (bit0 ^ bit1) ^ carry_in;
    assign co = (bit0 & bit1) | (carry_in & (bit0 ^ bit1));
    
always @(posedge clock or posedge reset)
begin
    if (reset == 1'b1)
        begin
            sum <= 1'b0;
            carry_out <= 1'b0;
        end // if
    else
        begin
            sum <= sm;
            carry_out <= co;
        end // else
end // always

endmodule // fulladder

