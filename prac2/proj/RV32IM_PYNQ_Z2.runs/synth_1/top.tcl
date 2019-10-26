# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_msg_config -id {Common 17-41} -limit 10000000
create_project -in_memory -part xc7z020clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/proj/RV32IM_PYNQ_Z2.cache/wt [current_project]
set_property parent.project_path /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/proj/RV32IM_PYNQ_Z2.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part_repo_paths {/afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/repo/board_files} [current_project]
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]
set_property ip_repo_paths /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/repo [current_project]
update_ip_catalog
set_property ip_output_repo /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/proj/RV32IM_PYNQ_Z2.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/inc/params.v
set_property file_type "Verilog Header" [get_files /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/inc/params.v]
read_mem {
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/others/deps_test.hex
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/others/mbrot.hex
}
read_verilog -library xil_defaultlib {
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/alu.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/branch_cache.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/branch_predictor.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/bypass_or_stall.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/cpu.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/csr_unit.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/dccm_ram.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/decoder.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/divider.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/dvi_display.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/exec_unit.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/fetch_unit.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/frame_buffer.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/msec_timer.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/predictor_state.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/ras.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/regfile.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/resync.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/ssd_driver.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/store_queue.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/vga_control.v
  /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/hdl/top.v
}
read_ip -quiet /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/rgb2dvi_0/rgb2dvi_0.xci
set_property used_in_implementation false [get_files -all /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/rgb2dvi_0/src/rgb2dvi.xdc]
set_property used_in_implementation false [get_files -all /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/rgb2dvi_0/src/rgb2dvi_ooc.xdc]
set_property used_in_implementation false [get_files -all /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/rgb2dvi_0/src/rgb2dvi_clocks.xdc]

read_ip -quiet /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/video_clock_gen/video_clock_gen.xci
set_property used_in_implementation false [get_files -all /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/video_clock_gen/video_clock_gen_board.xdc]
set_property used_in_implementation false [get_files -all /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/video_clock_gen/video_clock_gen.xdc]
set_property used_in_implementation false [get_files -all /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/video_clock_gen/video_clock_gen_ooc.xdc]

read_ip -quiet /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/cpu_clock_gen/cpu_clock_gen.xci
set_property used_in_implementation false [get_files -all /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/cpu_clock_gen/cpu_clock_gen_board.xdc]
set_property used_in_implementation false [get_files -all /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/cpu_clock_gen/cpu_clock_gen.xdc]
set_property used_in_implementation false [get_files -all /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/ip/cpu_clock_gen/cpu_clock_gen_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/constraints/top.xdc
set_property used_in_implementation false [get_files /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/constraints/top.xdc]

read_xdc /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/constraints/timing.xdc
set_property used_in_implementation false [get_files /afs/inf.ed.ac.uk/user/s20/s2003300/Desktop/Coursework/CARD/prac2/src/constraints/timing.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7z020clg400-1 -flatten_hierarchy none -directive RuntimeOptimized -fsm_extraction off


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
