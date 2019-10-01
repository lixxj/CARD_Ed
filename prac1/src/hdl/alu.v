// Completed by XJ
// Xingjian(XJ) Li, s2003300
// Sep/Oct 2019

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
//
// Description:    Integer ALU for RISC-V core (RV32I version)
//
// This module is expected to implement an RV32I ALU.
// This file initially contains only the module header and a set of opcode
// definitions for each of the 10 ALU operations that are to be implemented.
//
// The ALU operates on two operands using the operator defined by exe_alu_opc_r.
//
// The first operand for ALU_OPC_ADD operations may be either exe_pc_r or
// exe_reg1_r, depending on the value of exe_sel_pc_r:
//   (a). if exe_sel_pc_r is 1, then use exe_pc_r
//   (b). if exe_sel_pc_r is 0, then use exe_reg1_r
//
// The first operand for all other operations is always exe_reg1_r.
//
// The second operand for all operations is always exe_src2_r.
//
// The result of the operation should be returned through the alu_result output.
//
// If you choose to use continuous assignment to define alu_result, then you
// should remove the 'reg' declaration keyword from the output port definition
// of alu_result.
//
// Your ALU instructions can be tested incrementally, in four groups of
// instructions, by setting the following macros in the tb.v testbench file
// to either 1 (to enable) or 0 (to disable).
//
//  a) Logical operations  { AND, OR, XOR  } by setting ENABLE_LOGIC to 1 or 0
//  b) Additive operations { ADD, SUB      } by setting ENABLE_ADD to 1 or 0
//  c) Set operations      { SLT, SLTU     } by setting ENABLE_SET to 1 or 0
//  d) Shift operations    { SLL, SRL, SRA } by setting ENABLE_SHIFTS to 1 or 0
//
////////////////////////////////////////////////////////////////////////////////

module alu(
  input       [3:0]     exe_alu_opc_r,  // ALU opcode 
  input                 exe_sel_pc_r,   // Choose between PC (1) or reg1 (0)
  input       [31:0]    exe_pc_r,       // PC at the EXE stage
  input       [31:0]    exe_reg1_r,     // reg1 at the EXE stage
  input       [31:0]    exe_src2_r,     // Second source operand at EXE
  output  reg [31:0]    alu_result      // ALU result output
);

localparam [3:0]  // logical
                  ALU_OPC_AND  = 4'b0111, // bitwise AND
                  ALU_OPC_OR   = 4'b0110, // bitwise OR
                  ALU_OPC_XOR  = 4'b0100, // bitwise XOR
                  // Additive
                  ALU_OPC_ADD  = 4'b0000, // 2's complement addition
                  ALU_OPC_SUB  = 4'b1000, // 2's complement subtraction
                  // Set
                  ALU_OPC_SLT  = 4'b0010, // set if less than (signed)
                  ALU_OPC_SLTU = 4'b0011, // set if less than (unsigned)
                  // Shift
                  // The shift amount is given by the least-significant 5 bits of the second source operand - Nigel
                  ALU_OPC_SLL  = 4'b0001, // shift-left logical
                  ALU_OPC_SRL  = 4'b0101, // shift-right logical
                  ALU_OPC_SRA  = 4'b1101; // shift-right arithmetic

/////////////////////////q1: signed?
/////////////////////////q2: addition overflow?
/////////////////////////q3: set bits?


endmodule