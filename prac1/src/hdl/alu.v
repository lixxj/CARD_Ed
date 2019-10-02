`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
//
// Description:    Integer ALU for RISC-V core (RV32I version)
//
// Completed by XJ Xingjian Li, s2003300
// 
// Sep/Oct 2019
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

localparam [3:0]  
                  ALU_OPC_AND  = 4'b0111, // bitwise AND
                  ALU_OPC_OR   = 4'b0110, // bitwise OR
                  ALU_OPC_XOR  = 4'b0100, // bitwise XOR
                  ALU_OPC_ADD  = 4'b0000, // 2's complement addition
                  ALU_OPC_SUB  = 4'b1000, // 2's complement subtraction
                  ALU_OPC_SLT  = 4'b0010, // set if less than (signed)
                  ALU_OPC_SLTU = 4'b0011, // set if less than (unsigned)
                  ALU_OPC_SLL  = 4'b0001, // shift-left logical
                  ALU_OPC_SRL  = 4'b0101, // shift-right logical
                  ALU_OPC_SRA  = 4'b1101; // shift-right arithmetic

always @(*)
    begin   
        case(exe_alu_opc_r)
            
            // logical group
            ALU_OPC_AND:
                alu_result = exe_reg1_r & exe_src2_r; 
            ALU_OPC_OR:
                alu_result = exe_reg1_r | exe_src2_r; 
            ALU_OPC_XOR:
                alu_result = exe_reg1_r ^ exe_src2_r; 
            
            // Additive group (ignore overflow)
            ALU_OPC_ADD: 
                begin
                    if (exe_sel_pc_r == 32'b0) // use exe_reg1_r
                        alu_result = $signed(exe_reg1_r) + $signed(exe_src2_r);
                    else // exe_sel_pc_r is 1, use exe_pc_r
                        alu_result = $signed(exe_pc_r) + $signed(exe_src2_r);     
                end
            ALU_OPC_SUB:
                alu_result = $signed(exe_reg1_r) - $signed(exe_src2_r);
            
            // Set group
            ALU_OPC_SLT:
                begin
                    if ($signed(exe_reg1_r) < $signed(exe_src2_r)) 
                        alu_result = 32'b1; 
                    else
                        alu_result = 32'b0;
                end
            ALU_OPC_SLTU:
                begin
                    if (exe_reg1_r < exe_src2_r) 
                        alu_result = 32'b1; 
                    else
                        alu_result = 32'b0;
                end
            
            // Shift group (amount is given by the 5 LSBs of exe_src2_r)
            ALU_OPC_SLL: 
                alu_result = exe_reg1_r << exe_src2_r[4:0]; 
            ALU_OPC_SRL: 
                alu_result = exe_reg1_r >> exe_src2_r[4:0]; 
            ALU_OPC_SRA: 
                alu_result = $signed(exe_reg1_r) >>> exe_src2_r[4:0];
            
            default: alu_result = 32'b0; 
        
        endcase
    end
    
endmodule // alu
