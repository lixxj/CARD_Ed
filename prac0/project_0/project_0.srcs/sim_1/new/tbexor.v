`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2019 19:08:44
// Design Name: 
// Module Name: tbexor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tbexor;

reg b0, b1, b2, b3;

wire l0, l1, l2, l3;

exor u_exore (
    .btn0   (b0),
    .btn1   (b1),
    .btn2   (b2),
    .btn3   (b3),
    .led0   (l0),
    .led1   (l1),
    .led2   (l2),
    .led3   (l3)
);

initial
    begin
    
    {b0, b1, b2, b3} = 4'b0000;
    
    #100
    
    #10 {b0, b1, b2, b3} = 4'b1000;
    #10 {b0, b1, b2, b3} = 4'b0100;
    #10 {b0, b1, b2, b3} = 4'b0001;
    #10 {b0, b1, b2, b3} = 4'b1100;
    
    #10 $finish;
    
    end
endmodule
