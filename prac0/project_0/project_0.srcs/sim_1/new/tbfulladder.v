`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2019 20:33:54
// Design Name: 
// Module Name: tbfulladder
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


module tbfulladder;

reg b0, b1, ci; 

wire sum, co;

fulladder f (
    .bit0   (b0),
    .bit1   (b1),
    .carry_in   (ci),
    .sum    (sum),   
    .carry_out  (co)
);

initial
    begin
    
    {ci, b1, b0} = 3'b000;
    
    #100
    
    #10 {ci, b1, b0} = 3'b001;
    #10 {ci, b1, b0} = 3'b010;
    #10 {ci, b1, b0} = 3'b100;
    #10 {ci, b1, b0} = 3'b011;
    #10 {ci, b1, b0} = 3'b101;
    #10 {ci, b1, b0} = 3'b110;
    #10 {ci, b1, b0} = 3'b111;

    #10 $finish;
    
    end
endmodule
