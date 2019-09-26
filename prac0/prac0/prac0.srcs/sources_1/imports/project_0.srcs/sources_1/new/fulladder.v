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
    output carry_out
    );
    
    assign sum = (bit0 ^ bit1) ^ carry_in;
    assign carry_out = (bit0 & bit1) | (carry_in & (bit0 ^ bit1));
    
endmodule
