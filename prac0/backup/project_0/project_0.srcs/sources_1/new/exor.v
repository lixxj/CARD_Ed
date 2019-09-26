// Written by XJ
// Create Date: 25.09.2019 17:33:36
// Project Name: practical0
// Module Name: exor

`timescale 1ns / 1ps

module exor(
    input btn0,
    input btn1,
    input btn2,
    input btn3,
    output led0,
    output led1,
    output led2,
    output led3
    );
    
assign led0 = btn0;
assign led1 = btn1;
assign led2 = btn2 |(btn0 ^ btn1);
assign led3 = btn3 |(btn0 & btn1);

endmodule
