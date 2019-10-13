// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Aug 14 21:32:22 2019
// Host        : bilbo running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/nigel/Documents/svn_roots/computerdesign/CARD_Practicals_2019/Practical_2/proj/RV32IM_PYNQ_Z2.srcs/sources_1/ip/cpu_clock_gen/cpu_clock_gen_stub.v
// Design      : cpu_clock_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module cpu_clock_gen(clk_60MHz, clk_75MHz, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_60MHz,clk_75MHz,reset,locked,clk_in1" */;
  output clk_60MHz;
  output clk_75MHz;
  input reset;
  output locked;
  input clk_in1;
endmodule
