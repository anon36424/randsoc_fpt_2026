# Verify the running Vivado matches the version this design was built for. IP
# VLNVs are version-specific, so a mismatch otherwise produces cryptic
# "IP definition not found" errors instead of a clear message.
set expected_vivado_version "2024.2"
set actual_vivado_version [version -short]
if {$actual_vivado_version ne $expected_vivado_version} {
    error "RANDSOC: design built for Vivado $expected_vivado_version but running $actual_vivado_version. Set vivado_version in the config to match your Vivado, or run with the matching Vivado."
}

create_project test ./test -part xc7a200tlffv1156-2L -force

create_bd_design bd_design



########## axi_timer ##########
create_bd_cell -type hier ip_0_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_0_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 16 CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_0_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_0_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_0_axi_timer/capturetrig0] [get_bd_pins ip_0_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_0_axi_timer/capturetrig1] [get_bd_pins ip_0_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/freeze
connect_bd_net [get_bd_pins ip_0_axi_timer/freeze] [get_bd_pins ip_0_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_0_axi_timer/s_axi_aclk] [get_bd_pins ip_0_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_0_axi_timer/s_axi_aresetn] [get_bd_pins ip_0_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_0_axi_timer/generateout0] [get_bd_pins ip_0_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_0_axi_timer/generateout1] [get_bd_pins ip_0_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_0_axi_timer/pwm0] [get_bd_pins ip_0_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_0_axi_timer/interrupt] [get_bd_pins ip_0_axi_timer/axi_timer_0/interrupt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_1_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_1_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 47 CONFIG.aresetn 0 CONFIG.atuserwidth 113 CONFIG.bportwidth 9 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 19 CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 22 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_1_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aclk] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## accumulator ##########
create_bd_cell -type hier ip_2_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_2_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 138 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 170 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_2_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/clk
connect_bd_net [get_bd_pins ip_2_accumulator/clk] [get_bd_pins ip_2_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 137 -to 0 ip_2_accumulator/B
connect_bd_net [get_bd_pins ip_2_accumulator/B] [get_bd_pins ip_2_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 169 -to 0 ip_2_accumulator/Q
connect_bd_net [get_bd_pins ip_2_accumulator/Q] [get_bd_pins ip_2_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/SCLR
connect_bd_net [get_bd_pins ip_2_accumulator/SCLR] [get_bd_pins ip_2_accumulator/accumulator_0/SCLR]


########## fft ##########
create_bd_cell -type hier ip_3_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_3_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 6 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 1024 " [get_bd_cells ip_3_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_fft/aclk
connect_bd_net [get_bd_pins ip_3_fft/aclk] [get_bd_pins ip_3_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_3_fft/event_frame_started
connect_bd_net [get_bd_pins ip_3_fft/event_frame_started] [get_bd_pins ip_3_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_fft/M_AXIS_DATA] [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]


########## axi_hwicap ##########
create_bd_cell -type hier ip_4_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_4_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 " [get_bd_cells ip_4_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_4_axi_hwicap/icap_clk] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_4_axi_hwicap/eos_in] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_4_axi_hwicap/s_axi_aclk] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_4_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## reset ##########
create_bd_cell -type hier ip_5_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_5_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_reset/clk_in
connect_bd_net [get_bd_pins ip_5_reset/clk_in] [get_bd_pins ip_5_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_5_reset/reset_in
connect_bd_net [get_bd_pins ip_5_reset/reset_in] [get_bd_pins ip_5_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_5_reset/dcm_locked
connect_bd_net [get_bd_pins ip_5_reset/dcm_locked] [get_bd_pins ip_5_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_5_reset/mb_reset
connect_bd_net [get_bd_pins ip_5_reset/mb_reset] [get_bd_pins ip_5_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_5_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_5_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_5_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset] [get_bd_pins ip_5_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_5_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_5_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_6_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_6_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_in] [get_bd_pins ip_6_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_6_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_6_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_6_clk_wiz/reset
connect_bd_net [get_bd_pins ip_6_clk_wiz/reset] [get_bd_pins ip_6_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_6_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_locked] [get_bd_pins ip_6_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_7_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_7_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_7_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_7_intc/concat_0]
connect_bd_net [get_bd_pins ip_7_intc/concat_0/dout] [get_bd_pins ip_7_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/clk
connect_bd_net [get_bd_pins ip_7_intc/clk] [get_bd_pins ip_7_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/reset
connect_bd_net [get_bd_pins ip_7_intc/reset] [get_bd_pins ip_7_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_intc/AXI] [get_bd_intf_pins ip_7_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/irq_0
connect_bd_net [get_bd_pins ip_7_intc/irq_0] [get_bd_pins ip_7_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/irq_1
connect_bd_net [get_bd_pins ip_7_intc/irq_1] [get_bd_pins ip_7_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/irq_2
connect_bd_net [get_bd_pins ip_7_intc/irq_2] [get_bd_pins ip_7_intc/concat_0/In2]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_7_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_7_intc/irq] [get_bd_intf_pins ip_7_intc/intc_0/interrupt]


########## jtag_axi ##########
create_bd_cell -type hier ip_8_jtag_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0
move_bd_cells [get_bd_cells ip_8_jtag_axi] [get_bd_cells jtag_axi_0]
set_property -dict "CONFIG.PROTOCOL AXI4LITE " [get_bd_cells ip_8_jtag_axi/jtag_axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_jtag_axi/aclk
connect_bd_net [get_bd_pins ip_8_jtag_axi/aclk] [get_bd_pins ip_8_jtag_axi/jtag_axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_jtag_axi/aresetn
connect_bd_net [get_bd_pins ip_8_jtag_axi/aresetn] [get_bd_pins ip_8_jtag_axi/jtag_axi_0/aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_jtag_axi/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_jtag_axi/M_AXI] [get_bd_intf_pins ip_8_jtag_axi/jtag_axi_0/M_AXI]


########## axi_legacy ##########
create_bd_cell -type hier ip_9_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_9_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 3 CONFIG.NUM_SI 1 " [get_bd_cells ip_9_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_legacy/clk
connect_bd_net [get_bd_pins ip_9_axi_legacy/clk] [get_bd_pins ip_9_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_legacy/reset
connect_bd_net [get_bd_pins ip_9_axi_legacy/reset] [get_bd_pins ip_9_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_legacy/AXI_M0] [get_bd_intf_pins ip_9_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_9_axi_legacy/clk] [get_bd_pins ip_9_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_9_axi_legacy/reset] [get_bd_pins ip_9_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_legacy/AXI_S0] [get_bd_intf_pins ip_9_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_9_axi_legacy/clk] [get_bd_pins ip_9_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_9_axi_legacy/reset] [get_bd_pins ip_9_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_legacy/AXI_S1] [get_bd_intf_pins ip_9_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_9_axi_legacy/clk] [get_bd_pins ip_9_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_9_axi_legacy/reset] [get_bd_pins ip_9_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_legacy/AXI_S2] [get_bd_intf_pins ip_9_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_9_axi_legacy/clk] [get_bd_pins ip_9_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_9_axi_legacy/reset] [get_bd_pins ip_9_axi_legacy/axi_0/M02_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_10_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_10_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_10_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_10_axis_broadcaster/aclk] [get_bd_pins ip_10_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_10_axis_broadcaster/aresetn] [get_bd_pins ip_10_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_10_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_10_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_10_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_11_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_11_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_11_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_11_axis_broadcaster/aclk] [get_bd_pins ip_11_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_11_axis_broadcaster/aresetn] [get_bd_pins ip_11_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_12_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_12_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 24 " [get_bd_cells ip_12_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_12_axis_dwidth_converter/aclk] [get_bd_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_12_axis_dwidth_converter/aresetn] [get_bd_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_13_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_13_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 24 " [get_bd_cells ip_13_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aclk] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aresetn] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_14_reduce
create_bd_pin -dir I -from 33 -to 0 ip_14_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_14_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_14_reduce/concat]
connect_bd_net [get_bd_pins ip_14_reduce/out0] [get_bd_pins ip_14_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_0]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_14_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_14_reduce/slice_0/dout] [get_bd_pins ip_14_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_0/Res] [get_bd_pins ip_14_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_1]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_14_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_14_reduce/slice_1/dout] [get_bd_pins ip_14_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_1/Res] [get_bd_pins ip_14_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_2]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_14_reduce/slice_2/dout] [get_bd_pins ip_14_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_2/Res] [get_bd_pins ip_14_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_3]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_14_reduce/slice_3/dout] [get_bd_pins ip_14_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_3/Res] [get_bd_pins ip_14_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_4]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_14_reduce/slice_4/dout] [get_bd_pins ip_14_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_4/Res] [get_bd_pins ip_14_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_5]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_14_reduce/slice_5/dout] [get_bd_pins ip_14_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_5/Res] [get_bd_pins ip_14_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_6]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_14_reduce/slice_6/dout] [get_bd_pins ip_14_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_6/Res] [get_bd_pins ip_14_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_7]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_14_reduce/slice_7/dout] [get_bd_pins ip_14_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_7/Res] [get_bd_pins ip_14_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_8]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_14_reduce/slice_8/dout] [get_bd_pins ip_14_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_8/Res] [get_bd_pins ip_14_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 11 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_9]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_14_reduce/slice_9/dout] [get_bd_pins ip_14_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_9/Res] [get_bd_pins ip_14_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_10]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_14_reduce/slice_10/dout] [get_bd_pins ip_14_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_10/Res] [get_bd_pins ip_14_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 13 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_11]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_14_reduce/slice_11/dout] [get_bd_pins ip_14_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_11/Res] [get_bd_pins ip_14_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 14 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_12]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_14_reduce/slice_12/dout] [get_bd_pins ip_14_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_12/Res] [get_bd_pins ip_14_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_13]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_14_reduce/slice_13/dout] [get_bd_pins ip_14_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_13/Res] [get_bd_pins ip_14_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_14]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_14_reduce/slice_14/dout] [get_bd_pins ip_14_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_14/Res] [get_bd_pins ip_14_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 17 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_15]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_14_reduce/slice_15/dout] [get_bd_pins ip_14_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_15/Res] [get_bd_pins ip_14_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 18 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_16]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_14_reduce/slice_16/dout] [get_bd_pins ip_14_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_16/Res] [get_bd_pins ip_14_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 19 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_17]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_14_reduce/slice_17/dout] [get_bd_pins ip_14_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_17/Res] [get_bd_pins ip_14_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 20 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_18]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_14_reduce/slice_18/dout] [get_bd_pins ip_14_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_18/Res] [get_bd_pins ip_14_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 21 CONFIG.DIN_TO 21 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_19]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_14_reduce/slice_19/dout] [get_bd_pins ip_14_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_19/Res] [get_bd_pins ip_14_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 22 CONFIG.DIN_TO 22 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_20]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_14_reduce/slice_20/dout] [get_bd_pins ip_14_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_20/Res] [get_bd_pins ip_14_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 23 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_21]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_14_reduce/slice_21/dout] [get_bd_pins ip_14_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_21/Res] [get_bd_pins ip_14_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 24 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_22]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_14_reduce/slice_22/dout] [get_bd_pins ip_14_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_22/Res] [get_bd_pins ip_14_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 25 CONFIG.DIN_TO 25 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_23]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_14_reduce/slice_23/dout] [get_bd_pins ip_14_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_23/Res] [get_bd_pins ip_14_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 26 CONFIG.DIN_TO 26 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_24]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_14_reduce/slice_24/dout] [get_bd_pins ip_14_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_24/Res] [get_bd_pins ip_14_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 27 CONFIG.DIN_TO 27 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_25]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_14_reduce/slice_25/dout] [get_bd_pins ip_14_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_25/Res] [get_bd_pins ip_14_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 28 CONFIG.DIN_TO 28 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_26]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_14_reduce/slice_26/dout] [get_bd_pins ip_14_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_26/Res] [get_bd_pins ip_14_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 29 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_27]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_14_reduce/slice_27/dout] [get_bd_pins ip_14_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_27/Res] [get_bd_pins ip_14_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_28]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_14_reduce/slice_28/dout] [get_bd_pins ip_14_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_28/Res] [get_bd_pins ip_14_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_29]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_14_reduce/slice_29/dout] [get_bd_pins ip_14_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_29/Res] [get_bd_pins ip_14_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_30]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_14_reduce/slice_30/dout] [get_bd_pins ip_14_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_30/Res] [get_bd_pins ip_14_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 33 CONFIG.DIN_TO 33 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_14_reduce/slice_31]
connect_bd_net [get_bd_pins ip_14_reduce/in0] [get_bd_pins ip_14_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_14_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_14_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_14_reduce/slice_31/dout] [get_bd_pins ip_14_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_14_reduce/reduce_31/Res] [get_bd_pins ip_14_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_15_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 33 -to 0 ip_16_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_16_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_16_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 169 -to 0 ip_16_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_16_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_16_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/slice_2/dout] [get_bd_pins ip_16_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 137 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 169 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 169 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_20_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_20_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_20_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_21_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_21_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_21_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_21_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_5_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_6_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_7_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_10_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_14_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_0_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_1_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_2_accumulator/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_3_fft/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_5_reset/clk_in]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_locked] [get_bd_pins ip_5_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_7_intc/irq_0] [get_bd_pins ip_0_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_7_intc/irq_1] [get_bd_pins ip_3_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_7_intc/irq_2] [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_jtag_axi/M_AXI] [get_bd_intf_pins ip_9_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_9_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_intc/AXI] [get_bd_intf_pins ip_9_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/M_AXIS_DATA] [get_bd_intf_pins ip_11_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_10_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_10_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_4_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_0_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_14_reduce/in0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_0_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_0_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/B]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_8_jtag_axi/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_9_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_10_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_11_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_12_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_13_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_7_intc/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_8_jtag_axi/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_9_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_10_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_11_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_12_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_13_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 26 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=26 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=26 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/S_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/S_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_0 declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_0 declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_1 declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_1 declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }


assign_bd_address
validate_bd_design

# Save the block design
regenerate_bd_layout
save_bd_design

puts "RANDSOC_BD_VALIDATED_OK"

make_wrapper -files [get_files test/test.srcs/sources_1/bd/bd_design/bd_design.bd] -top
add_files -norecurse test/test.gen/sources_1/bd/bd_design/hdl/bd_design_wrapper.v

launch_runs synth_1
wait_on synth_1
open_run synth_1 -name synth_1
place_ports
write_checkpoint synth.dcp -force
write_verilog synth.v -force
write_edif viv_synth.edf -force
report_io -force -file report_io.txt

reset_project
