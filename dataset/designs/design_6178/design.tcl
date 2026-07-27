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
set_property -dict "CONFIG.COUNT_WIDTH 8 CONFIG.GEN0_ASSERT Active_Low CONFIG.GEN1_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.TRIG1_ASSERT Active_High CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_0_axi_timer/axi_timer_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_1_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_1_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Performance CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_type Square_root CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_1_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_floating_point/aclk
connect_bd_net [get_bd_pins ip_1_floating_point/aclk] [get_bd_pins ip_1_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_1_floating_point/S_AXIS_A] [get_bd_intf_pins ip_1_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_1_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_1_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_dma ##########
create_bd_cell -type hier ip_2_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_2_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 34 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_2_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_2_axi_dma/axi_resetn] [get_bd_pins ip_2_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_2_axi_dma/mm2s_introut] [get_bd_pins ip_2_axi_dma/axi_dma_0/mm2s_introut]


########## fft ##########
create_bd_cell -type hier ip_3_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_3_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 6 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 64 " [get_bd_cells ip_3_fft/fft_0]
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
set_property -dict "CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 0 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 1 CONFIG.C_WRITE_FIFO_DEPTH 128 " [get_bd_cells ip_4_axi_hwicap/axi_hwicap_0]
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
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_7_intc/concat_0]
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
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/irq_3
connect_bd_net [get_bd_pins ip_7_intc/irq_3] [get_bd_pins ip_7_intc/concat_0/In3]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_7_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_7_intc/irq] [get_bd_intf_pins ip_7_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_8_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_8_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 2 " [get_bd_cells ip_8_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_legacy/clk
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_legacy/reset
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_M0] [get_bd_intf_pins ip_8_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_M1] [get_bd_intf_pins ip_8_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_S0] [get_bd_intf_pins ip_8_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_S1] [get_bd_intf_pins ip_8_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_S2] [get_bd_intf_pins ip_8_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_S3] [get_bd_intf_pins ip_8_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/M03_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_9_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_9_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_9_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_9_axis_broadcaster/aclk] [get_bd_pins ip_9_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_9_axis_broadcaster/aresetn] [get_bd_pins ip_9_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_10_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_10_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_10_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aclk] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aresetn] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_11_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_11_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 24 " [get_bd_cells ip_11_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aclk] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aresetn] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_12_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_12_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_13_slice_and_concat
create_bd_pin -dir O -from 1 -to 0 ip_13_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_13_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_13_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_13_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_13_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_14_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_14_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_14_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_15_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_16_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_0

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
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 1 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_13_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_14_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_15_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_16_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_0_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_1_floating_point/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_3_fft/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_5_reset/clk_in]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_locked] [get_bd_pins ip_5_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_7_intc/irq_0] [get_bd_pins ip_0_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_7_intc/irq_1] [get_bd_pins ip_2_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_7_intc/irq_2] [get_bd_pins ip_3_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_7_intc/irq_3] [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_8_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_8_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_8_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_intc/AXI] [get_bd_intf_pins ip_8_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_9_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_2_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_floating_point/S_AXIS_A] [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_9_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_9_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_4_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_0_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_12_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_0_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_0_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_14_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_8_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_9_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_10_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_11_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_7_intc/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_8_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_9_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_10_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_11_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
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
  set __s [expr {$__aw == 18 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=18 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=18 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
