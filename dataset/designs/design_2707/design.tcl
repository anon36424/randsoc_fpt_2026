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



########## fft ##########
create_bd_cell -type hier ip_0_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_0_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 9 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 16 " [get_bd_cells ip_0_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_fft/aclk
connect_bd_net [get_bd_pins ip_0_fft/aclk] [get_bd_pins ip_0_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_0_fft/event_frame_started
connect_bd_net [get_bd_pins ip_0_fft/event_frame_started] [get_bd_pins ip_0_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_fft/S_AXIS_DATA] [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_fft/M_AXIS_DATA] [get_bd_intf_pins ip_0_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_0_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_CONFIG]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_1_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_1_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SPI_MEMORY 2 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_1_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_1_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi/IIC] [get_bd_intf_pins ip_1_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/clk] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/reset] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/clk4] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/reset4] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_1_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_1_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/irq] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_2_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_2_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 5 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 14 CONFIG.C_TAVDV_PS_MEM_0 15647 CONFIG.C_TCEDV_PS_MEM_0 14278 CONFIG.C_THZCE_PS_MEM_0 7034 CONFIG.C_THZOE_PS_MEM_0 6946 CONFIG.C_TLZWE_PS_MEM_0 8004 CONFIG.C_TWC_PS_MEM_0 16288 CONFIG.C_TWPH_PS_MEM_0 12853 CONFIG.C_TWP_PS_MEM_0 12558 CONFIG.C_WR_REC_TIME_MEM_0 27942 " [get_bd_cells ip_2_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_2_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_2_emc/EMC_INTF] [get_bd_intf_pins ip_2_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_2_emc/clk
connect_bd_net [get_bd_pins ip_2_emc/clk] [get_bd_pins ip_2_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_emc/rdclk
connect_bd_net [get_bd_pins ip_2_emc/rdclk] [get_bd_pins ip_2_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_emc/rst
connect_bd_net [get_bd_pins ip_2_emc/rst] [get_bd_pins ip_2_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_emc/AXI] [get_bd_intf_pins ip_2_emc/emc_0/S_AXI_MEM]


########## fft ##########
create_bd_cell -type hier ip_3_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_3_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 2 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 32 " [get_bd_cells ip_3_fft/fft_0]
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


########## complex_multiplier ##########
create_bd_cell -type hier ip_4_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_4_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 19 CONFIG.aresetn 0 CONFIG.atuserwidth 193 CONFIG.bportwidth 22 CONFIG.ctrltuserwidth 99 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Manual CONFIG.minimumlatency 21 CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 2 CONFIG.outtlastbehv OR_all_TLASTs CONFIG.roundmode Random_Rounding " [get_bd_cells ip_4_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_4_complex_multiplier/aclk] [get_bd_pins ip_4_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_4_complex_multiplier/aclken] [get_bd_pins ip_4_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_4_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_4_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_4_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_4_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_4_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_4_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_4_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_4_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_timer ##########
create_bd_cell -type hier ip_5_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_5_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 32 CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_5_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_timer/S_AXI] [get_bd_intf_pins ip_5_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_5_axi_timer/capturetrig0] [get_bd_pins ip_5_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_5_axi_timer/capturetrig1] [get_bd_pins ip_5_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_timer/freeze
connect_bd_net [get_bd_pins ip_5_axi_timer/freeze] [get_bd_pins ip_5_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_5_axi_timer/s_axi_aclk] [get_bd_pins ip_5_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_5_axi_timer/s_axi_aresetn] [get_bd_pins ip_5_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_5_axi_timer/generateout0] [get_bd_pins ip_5_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_5_axi_timer/generateout1] [get_bd_pins ip_5_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_5_axi_timer/pwm0] [get_bd_pins ip_5_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_5_axi_timer/interrupt] [get_bd_pins ip_5_axi_timer/axi_timer_0/interrupt]


########## cordic ##########
create_bd_cell -type hier ip_6_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_6_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Arc_Tanh CONFIG.Input_Width 44 CONFIG.Iterations 25 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 34 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode No_Pipelining CONFIG.Precision 45 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_6_cordic/cordic_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_6_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_6_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_6_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_6_cordic/cordic_0/M_AXIS_DOUT]


########## xadc_wiz ##########
create_bd_cell -type hier ip_7_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_7_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_7_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_7_xadc_wiz/dclk_in] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_7_xadc_wiz/reset_in] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_7_xadc_wiz/convstclk_in] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/eoc_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/eos_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/busy_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_7_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_7_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_7_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/jtaglocked_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/jtagmodified_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/jtagbusy_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## fft ##########
create_bd_cell -type hier ip_8_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_8_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 7 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 2048 " [get_bd_cells ip_8_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_fft/aclk
connect_bd_net [get_bd_pins ip_8_fft/aclk] [get_bd_pins ip_8_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_8_fft/event_frame_started
connect_bd_net [get_bd_pins ip_8_fft/event_frame_started] [get_bd_pins ip_8_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_fft/S_AXIS_DATA] [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_fft/M_AXIS_DATA] [get_bd_intf_pins ip_8_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_8_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_CONFIG]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_9_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_9_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_9_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_9_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_ethernet_lite/MII] [get_bd_intf_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_9_axi_ethernet_lite/clk] [get_bd_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_9_axi_ethernet_lite/reset] [get_bd_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_9_axi_ethernet_lite/irq] [get_bd_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_10_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_10_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_10_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_10_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite/MII] [get_bd_intf_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_10_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_10_axi_ethernet_lite/clk] [get_bd_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_10_axi_ethernet_lite/reset] [get_bd_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_10_axi_ethernet_lite/irq] [get_bd_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## floating_point ##########
create_bd_cell -type hier ip_11_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_11_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.a_tuser_width 23 CONFIG.add_sub_value Both CONFIG.c_a_exponent_width 6 CONFIG.c_a_fraction_width 9 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_mult_usage No_Usage CONFIG.c_result_exponent_width 23 CONFIG.c_result_fraction_width 2 CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Float_to_fixed CONFIG.result_precision_type Custom CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_11_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_floating_point/aclk
connect_bd_net [get_bd_pins ip_11_floating_point/aclk] [get_bd_pins ip_11_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/S_AXIS_A] [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_11_floating_point/floating_point_0/M_AXIS_RESULT]


########## accumulator ##########
create_bd_cell -type hier ip_12_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_12_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 84 CONFIG.Latency 26 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 202 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_12_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_accumulator/clk
connect_bd_net [get_bd_pins ip_12_accumulator/clk] [get_bd_pins ip_12_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 83 -to 0 ip_12_accumulator/B
connect_bd_net [get_bd_pins ip_12_accumulator/B] [get_bd_pins ip_12_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 201 -to 0 ip_12_accumulator/Q
connect_bd_net [get_bd_pins ip_12_accumulator/Q] [get_bd_pins ip_12_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_12_accumulator/ADD
connect_bd_net [get_bd_pins ip_12_accumulator/ADD] [get_bd_pins ip_12_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_12_accumulator/SCLR
connect_bd_net [get_bd_pins ip_12_accumulator/SCLR] [get_bd_pins ip_12_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_12_accumulator/Bypass
connect_bd_net [get_bd_pins ip_12_accumulator/Bypass] [get_bd_pins ip_12_accumulator/accumulator_0/Bypass]


########## emc ##########
create_bd_cell -type hier ip_13_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_13_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 0 CONFIG.C_MEM0_WIDTH 8 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_SYNCH_PIPEDELAY_0 1 CONFIG.C_SYNCH_PIPEDELAY_1 1 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 15 CONFIG.C_TAVDV_PS_MEM_2 13931 CONFIG.C_TCEDV_PS_MEM_2 15054 CONFIG.C_THZCE_PS_MEM_2 6968 CONFIG.C_THZOE_PS_MEM_2 7344 CONFIG.C_TLZWE_PS_MEM_2 619 CONFIG.C_TWC_PS_MEM_2 15474 CONFIG.C_TWPH_PS_MEM_2 12942 CONFIG.C_TWP_PS_MEM_2 10959 CONFIG.C_WR_REC_TIME_MEM_2 29398 " [get_bd_cells ip_13_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_13_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_13_emc/EMC_INTF] [get_bd_intf_pins ip_13_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/clk
connect_bd_net [get_bd_pins ip_13_emc/clk] [get_bd_pins ip_13_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/rdclk
connect_bd_net [get_bd_pins ip_13_emc/rdclk] [get_bd_pins ip_13_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/rst
connect_bd_net [get_bd_pins ip_13_emc/rst] [get_bd_pins ip_13_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_emc/AXI] [get_bd_intf_pins ip_13_emc/emc_0/S_AXI_MEM]


########## axi_timer ##########
create_bd_cell -type hier ip_14_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_14_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_14_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_timer/S_AXI] [get_bd_intf_pins ip_14_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_14_axi_timer/capturetrig0] [get_bd_pins ip_14_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/freeze
connect_bd_net [get_bd_pins ip_14_axi_timer/freeze] [get_bd_pins ip_14_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_14_axi_timer/s_axi_aclk] [get_bd_pins ip_14_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_14_axi_timer/s_axi_aresetn] [get_bd_pins ip_14_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_14_axi_timer/generateout0] [get_bd_pins ip_14_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_14_axi_timer/generateout1] [get_bd_pins ip_14_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_14_axi_timer/pwm0] [get_bd_pins ip_14_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_14_axi_timer/interrupt] [get_bd_pins ip_14_axi_timer/axi_timer_0/interrupt]


########## microblaze ##########
create_bd_cell -type hier ip_15_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 36 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 0 CONFIG.C_DEBUG_COUNTER_WIDTH 32 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 19 CONFIG.C_DEBUG_EXTERNAL_TRACE 0 CONFIG.C_DEBUG_LATENCY_COUNTERS 5 CONFIG.C_DEBUG_PROFILE_SIZE 16384 CONFIG.C_DEBUG_TRACE_SIZE 32768 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 4 CONFIG.C_MMU_ITLB_SIZE 1 CONFIG.C_MMU_PRIVILEGED_INSTR 0 CONFIG.C_MMU_TLB_ACCESS 1 CONFIG.C_MMU_ZONES 5 CONFIG.C_NUMBER_OF_PC_BRK 1 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 3 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 1 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MMU 2 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_15_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_microblaze/Clk
connect_bd_net [get_bd_pins ip_15_microblaze/Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_microblaze/Reset
connect_bd_net [get_bd_pins ip_15_microblaze/Reset] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_15_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/INTERRUPT] [get_bd_intf_pins ip_15_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/M_AXI_DP] [get_bd_intf_pins ip_15_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_15_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_15_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x6ead6df64c3e3ac CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_15_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_15_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_15_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_15_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x63cac96a623a92e CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_15_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_15_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_15_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_15_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_15_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 3 " [get_bd_cells ip_15_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_15_microblaze/microblaze_0/DEBUG]


########## cordic ##########
create_bd_cell -type hier ip_16_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_16_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tan CONFIG.Input_Width 31 CONFIG.Iterations 37 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 9 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 45 CONFIG.Round_Mode Truncate " [get_bd_cells ip_16_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_cordic/aclk
connect_bd_net [get_bd_pins ip_16_cordic/aclk] [get_bd_pins ip_16_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_16_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_16_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_16_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_16_cordic/cordic_0/M_AXIS_DOUT]


########## accumulator ##########
create_bd_cell -type hier ip_17_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_17_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 8 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 26 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_17_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_accumulator/clk
connect_bd_net [get_bd_pins ip_17_accumulator/clk] [get_bd_pins ip_17_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 7 -to 0 ip_17_accumulator/B
connect_bd_net [get_bd_pins ip_17_accumulator/B] [get_bd_pins ip_17_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 25 -to 0 ip_17_accumulator/Q
connect_bd_net [get_bd_pins ip_17_accumulator/Q] [get_bd_pins ip_17_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_17_accumulator/ADD
connect_bd_net [get_bd_pins ip_17_accumulator/ADD] [get_bd_pins ip_17_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_17_accumulator/CE
connect_bd_net [get_bd_pins ip_17_accumulator/CE] [get_bd_pins ip_17_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_17_accumulator/Bypass
connect_bd_net [get_bd_pins ip_17_accumulator/Bypass] [get_bd_pins ip_17_accumulator/accumulator_0/Bypass]


########## axi_timer ##########
create_bd_cell -type hier ip_18_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_18_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 16 CONFIG.GEN0_ASSERT Active_Low CONFIG.GEN1_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.TRIG1_ASSERT Active_High CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_18_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_timer/S_AXI] [get_bd_intf_pins ip_18_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_18_axi_timer/capturetrig0] [get_bd_pins ip_18_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_18_axi_timer/capturetrig1] [get_bd_pins ip_18_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_timer/freeze
connect_bd_net [get_bd_pins ip_18_axi_timer/freeze] [get_bd_pins ip_18_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_18_axi_timer/s_axi_aclk] [get_bd_pins ip_18_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_18_axi_timer/s_axi_aresetn] [get_bd_pins ip_18_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_18_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_18_axi_timer/generateout0] [get_bd_pins ip_18_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_18_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_18_axi_timer/generateout1] [get_bd_pins ip_18_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_18_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_18_axi_timer/pwm0] [get_bd_pins ip_18_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_18_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_18_axi_timer/interrupt] [get_bd_pins ip_18_axi_timer/axi_timer_0/interrupt]


########## reset ##########
create_bd_cell -type hier ip_19_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_19_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_reset/clk_in
connect_bd_net [get_bd_pins ip_19_reset/clk_in] [get_bd_pins ip_19_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_19_reset/reset_in
connect_bd_net [get_bd_pins ip_19_reset/reset_in] [get_bd_pins ip_19_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_19_reset/dcm_locked
connect_bd_net [get_bd_pins ip_19_reset/dcm_locked] [get_bd_pins ip_19_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_19_reset/mb_reset
connect_bd_net [get_bd_pins ip_19_reset/mb_reset] [get_bd_pins ip_19_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_19_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_19_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_19_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset] [get_bd_pins ip_19_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_19_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_19_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_20_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_20_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_in] [get_bd_pins ip_20_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_20_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_20_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_20_clk_wiz/reset
connect_bd_net [get_bd_pins ip_20_clk_wiz/reset] [get_bd_pins ip_20_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_20_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_locked] [get_bd_pins ip_20_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_21_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_21_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_21_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 9 " [get_bd_cells ip_21_intc/concat_0]
connect_bd_net [get_bd_pins ip_21_intc/concat_0/dout] [get_bd_pins ip_21_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/clk
connect_bd_net [get_bd_pins ip_21_intc/clk] [get_bd_pins ip_21_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/reset
connect_bd_net [get_bd_pins ip_21_intc/reset] [get_bd_pins ip_21_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_21_intc/AXI] [get_bd_intf_pins ip_21_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_0
connect_bd_net [get_bd_pins ip_21_intc/irq_0] [get_bd_pins ip_21_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_1
connect_bd_net [get_bd_pins ip_21_intc/irq_1] [get_bd_pins ip_21_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_2
connect_bd_net [get_bd_pins ip_21_intc/irq_2] [get_bd_pins ip_21_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_3
connect_bd_net [get_bd_pins ip_21_intc/irq_3] [get_bd_pins ip_21_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_4
connect_bd_net [get_bd_pins ip_21_intc/irq_4] [get_bd_pins ip_21_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_5
connect_bd_net [get_bd_pins ip_21_intc/irq_5] [get_bd_pins ip_21_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_6
connect_bd_net [get_bd_pins ip_21_intc/irq_6] [get_bd_pins ip_21_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_7
connect_bd_net [get_bd_pins ip_21_intc/irq_7] [get_bd_pins ip_21_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_8
connect_bd_net [get_bd_pins ip_21_intc/irq_8] [get_bd_pins ip_21_intc/concat_0/In8]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_21_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_21_intc/irq] [get_bd_intf_pins ip_21_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_22_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_22_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 10 CONFIG.NUM_SI 1 " [get_bd_cells ip_22_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi/clk
connect_bd_net [get_bd_pins ip_22_axi/clk] [get_bd_pins ip_22_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi/reset
connect_bd_net [get_bd_pins ip_22_axi/reset] [get_bd_pins ip_22_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_M0] [get_bd_intf_pins ip_22_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S0] [get_bd_intf_pins ip_22_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S1] [get_bd_intf_pins ip_22_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S2] [get_bd_intf_pins ip_22_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S3] [get_bd_intf_pins ip_22_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S4] [get_bd_intf_pins ip_22_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S5] [get_bd_intf_pins ip_22_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S6] [get_bd_intf_pins ip_22_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S7] [get_bd_intf_pins ip_22_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S8] [get_bd_intf_pins ip_22_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S9] [get_bd_intf_pins ip_22_axi/axi_0/M09_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_23_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_23_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_23_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_23_axis_broadcaster/aclk] [get_bd_pins ip_23_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_23_axis_broadcaster/aresetn] [get_bd_pins ip_23_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_24_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_24_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_24_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_24_axis_broadcaster/aclk] [get_bd_pins ip_24_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_24_axis_broadcaster/aresetn] [get_bd_pins ip_24_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_25_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_25_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_25_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_25_axis_broadcaster/aclk] [get_bd_pins ip_25_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_25_axis_broadcaster/aresetn] [get_bd_pins ip_25_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_26_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_26_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_26_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_26_axis_broadcaster/aclk] [get_bd_pins ip_26_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_26_axis_broadcaster/aresetn] [get_bd_pins ip_26_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_27_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_27_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_27_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_27_axis_broadcaster/aclk] [get_bd_pins ip_27_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_27_axis_broadcaster/aresetn] [get_bd_pins ip_27_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_28_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_28_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_28_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_28_axis_broadcaster/aclk] [get_bd_pins ip_28_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_28_axis_broadcaster/aresetn] [get_bd_pins ip_28_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_29_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_29_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_29_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_29_axis_dwidth_converter/aclk] [get_bd_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_29_axis_dwidth_converter/aresetn] [get_bd_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_30_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_30_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aclk] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aresetn] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_31_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_31_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_31_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aclk] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aresetn] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_32_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_32_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aclk] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aresetn] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_33_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_33_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 28 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_33_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aclk] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aresetn] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_34_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_34_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_34_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_34_axis_combiner/aclk] [get_bd_pins ip_34_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_34_axis_combiner/aresetn] [get_bd_pins ip_34_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_34_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_34_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_combiner/M_AXIS] [get_bd_intf_pins ip_34_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_35_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_35_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_35_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_35_axis_dwidth_converter/aclk] [get_bd_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_35_axis_dwidth_converter/aresetn] [get_bd_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_36_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_36_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_36_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_36_axis_combiner/aclk] [get_bd_pins ip_36_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_36_axis_combiner/aresetn] [get_bd_pins ip_36_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_36_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_36_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_combiner/M_AXIS] [get_bd_intf_pins ip_36_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_37_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_37_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_37_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aclk] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aresetn] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_38_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_38_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_38_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_38_axis_combiner/aclk] [get_bd_pins ip_38_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_38_axis_combiner/aresetn] [get_bd_pins ip_38_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_combiner/M_AXIS] [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_39_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_39_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_39_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_39_axis_combiner/aclk] [get_bd_pins ip_39_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_39_axis_combiner/aresetn] [get_bd_pins ip_39_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_39_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_39_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_combiner/M_AXIS] [get_bd_intf_pins ip_39_axis_combiner/axis_combiner_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_40_reduce
create_bd_pin -dir I -from 150 -to 0 ip_40_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_40_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_40_reduce/concat]
connect_bd_net [get_bd_pins ip_40_reduce/out0] [get_bd_pins ip_40_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_0]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_40_reduce/slice_0/dout] [get_bd_pins ip_40_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_0/Res] [get_bd_pins ip_40_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_1]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_40_reduce/slice_1/dout] [get_bd_pins ip_40_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_1/Res] [get_bd_pins ip_40_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_2]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_40_reduce/slice_2/dout] [get_bd_pins ip_40_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_2/Res] [get_bd_pins ip_40_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_3]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_40_reduce/slice_3/dout] [get_bd_pins ip_40_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_3/Res] [get_bd_pins ip_40_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 24 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_4]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_40_reduce/slice_4/dout] [get_bd_pins ip_40_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_4/Res] [get_bd_pins ip_40_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 25 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_5]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_40_reduce/slice_5/dout] [get_bd_pins ip_40_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_5/Res] [get_bd_pins ip_40_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 34 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_6]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_40_reduce/slice_6/dout] [get_bd_pins ip_40_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_6/Res] [get_bd_pins ip_40_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 39 CONFIG.DIN_TO 35 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_7]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_40_reduce/slice_7/dout] [get_bd_pins ip_40_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_7/Res] [get_bd_pins ip_40_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 40 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_8]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_40_reduce/slice_8/dout] [get_bd_pins ip_40_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_8/Res] [get_bd_pins ip_40_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 49 CONFIG.DIN_TO 45 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_9]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_40_reduce/slice_9/dout] [get_bd_pins ip_40_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_9/Res] [get_bd_pins ip_40_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 54 CONFIG.DIN_TO 50 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_10]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_40_reduce/slice_10/dout] [get_bd_pins ip_40_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_10/Res] [get_bd_pins ip_40_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 59 CONFIG.DIN_TO 55 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_11]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_40_reduce/slice_11/dout] [get_bd_pins ip_40_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_11/Res] [get_bd_pins ip_40_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 64 CONFIG.DIN_TO 60 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_12]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_40_reduce/slice_12/dout] [get_bd_pins ip_40_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_12/Res] [get_bd_pins ip_40_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 69 CONFIG.DIN_TO 65 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_13]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_40_reduce/slice_13/dout] [get_bd_pins ip_40_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_13/Res] [get_bd_pins ip_40_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 74 CONFIG.DIN_TO 70 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_14]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_40_reduce/slice_14/dout] [get_bd_pins ip_40_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_14/Res] [get_bd_pins ip_40_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 79 CONFIG.DIN_TO 75 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_15]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_40_reduce/slice_15/dout] [get_bd_pins ip_40_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_15/Res] [get_bd_pins ip_40_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 84 CONFIG.DIN_TO 80 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_16]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_40_reduce/slice_16/dout] [get_bd_pins ip_40_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_16/Res] [get_bd_pins ip_40_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 89 CONFIG.DIN_TO 85 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_17]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_40_reduce/slice_17/dout] [get_bd_pins ip_40_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_17/Res] [get_bd_pins ip_40_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 94 CONFIG.DIN_TO 90 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_18]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_40_reduce/slice_18/dout] [get_bd_pins ip_40_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_18/Res] [get_bd_pins ip_40_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 99 CONFIG.DIN_TO 95 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_19]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_40_reduce/slice_19/dout] [get_bd_pins ip_40_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_19/Res] [get_bd_pins ip_40_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 104 CONFIG.DIN_TO 100 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_20]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_40_reduce/slice_20/dout] [get_bd_pins ip_40_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_20/Res] [get_bd_pins ip_40_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 109 CONFIG.DIN_TO 105 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_21]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_40_reduce/slice_21/dout] [get_bd_pins ip_40_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_21/Res] [get_bd_pins ip_40_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 114 CONFIG.DIN_TO 110 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_22]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_40_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_40_reduce/slice_22/dout] [get_bd_pins ip_40_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_22/Res] [get_bd_pins ip_40_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 118 CONFIG.DIN_TO 115 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_23]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 4 " [get_bd_cells ip_40_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_40_reduce/slice_23/dout] [get_bd_pins ip_40_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_23/Res] [get_bd_pins ip_40_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 122 CONFIG.DIN_TO 119 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_24]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 4 " [get_bd_cells ip_40_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_40_reduce/slice_24/dout] [get_bd_pins ip_40_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_24/Res] [get_bd_pins ip_40_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 126 CONFIG.DIN_TO 123 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_25]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 4 " [get_bd_cells ip_40_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_40_reduce/slice_25/dout] [get_bd_pins ip_40_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_25/Res] [get_bd_pins ip_40_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 130 CONFIG.DIN_TO 127 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_26]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 4 " [get_bd_cells ip_40_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_40_reduce/slice_26/dout] [get_bd_pins ip_40_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_26/Res] [get_bd_pins ip_40_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 134 CONFIG.DIN_TO 131 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_27]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 4 " [get_bd_cells ip_40_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_40_reduce/slice_27/dout] [get_bd_pins ip_40_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_27/Res] [get_bd_pins ip_40_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 138 CONFIG.DIN_TO 135 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_28]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 4 " [get_bd_cells ip_40_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_40_reduce/slice_28/dout] [get_bd_pins ip_40_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_28/Res] [get_bd_pins ip_40_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 142 CONFIG.DIN_TO 139 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_29]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 4 " [get_bd_cells ip_40_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_40_reduce/slice_29/dout] [get_bd_pins ip_40_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_29/Res] [get_bd_pins ip_40_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 146 CONFIG.DIN_TO 143 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_30]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 4 " [get_bd_cells ip_40_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_40_reduce/slice_30/dout] [get_bd_pins ip_40_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_30/Res] [get_bd_pins ip_40_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 150 CONFIG.DIN_TO 147 CONFIG.DIN_WIDTH 151 " [get_bd_cells ip_40_reduce/slice_31]
connect_bd_net [get_bd_pins ip_40_reduce/in0] [get_bd_pins ip_40_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_40_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 4 " [get_bd_cells ip_40_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_40_reduce/slice_31/dout] [get_bd_pins ip_40_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_40_reduce/reduce_31/Res] [get_bd_pins ip_40_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 83 -to 0 ip_41_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 10 " [get_bd_cells ip_41_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_41_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_41_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_2] [get_bd_pins ip_41_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_3] [get_bd_pins ip_41_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_4] [get_bd_pins ip_41_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_5] [get_bd_pins ip_41_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_6] [get_bd_pins ip_41_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_7] [get_bd_pins ip_41_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_8] [get_bd_pins ip_41_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 201 -to 0 ip_41_slice_and_concat/in_9
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 74 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 202 " [get_bd_cells ip_41_slice_and_concat/slice_9]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_9] [get_bd_pins ip_41_slice_and_concat/slice_9/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/slice_9/dout] [get_bd_pins ip_41_slice_and_concat/concat/In9]


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_42_slice_and_concat/out0
create_bd_pin -dir I -from 201 -to 0 ip_42_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 82 CONFIG.DIN_TO 75 CONFIG.DIN_WIDTH 202 " [get_bd_cells ip_42_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_42_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 150 -to 0 ip_43_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_43_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 201 -to 0 ip_43_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 201 CONFIG.DIN_TO 83 CONFIG.DIN_WIDTH 202 " [get_bd_cells ip_43_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_43_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/slice_0/dout] [get_bd_pins ip_43_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_1] [get_bd_pins ip_43_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_2] [get_bd_pins ip_43_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_3] [get_bd_pins ip_43_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 25 -to 0 ip_43_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_4] [get_bd_pins ip_43_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_5] [get_bd_pins ip_43_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_6] [get_bd_pins ip_43_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_7] [get_bd_pins ip_43_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_44_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_44_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_44_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_45_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_45_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_45_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_46_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_46_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_46_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_46_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_47_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_47_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_47_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_47_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_47_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_48_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_48_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_48_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_48_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_48_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_48_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_49_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_49_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_49_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_50_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_50_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_50_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_50_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_51_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_51_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_51_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_51_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_51_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_51_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_52_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_52_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_52_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_52_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_52_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_53_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_53_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_54_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_54_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_54_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_54_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_55_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_55_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_55_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_55_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_56_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_57_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_57_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_57_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_57_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_58_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_58_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_19_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_20_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_1_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi_IIC] [get_bd_intf_pins ip_1_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_2_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_2_emc_EMC_INTF] [get_bd_intf_pins ip_2_emc/EMC_INTF]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_7_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_7_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_7_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_9_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_ethernet_lite_MII] [get_bd_intf_pins ip_9_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_10_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite_MII] [get_bd_intf_pins ip_10_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_10_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_10_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_13_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_13_emc_EMC_INTF] [get_bd_intf_pins ip_13_emc/EMC_INTF]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_23_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_40_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 4 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_52_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_54_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_55_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_57_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_58_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_21_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_2_emc/rst]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset] [get_bd_pins ip_7_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_13_emc/rst]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_19_reset/mb_reset] [get_bd_pins ip_15_microblaze/Reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_18_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_0_fft/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_1_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_1_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_1_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_2_emc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_2_emc/rdclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_3_fft/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_4_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_5_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_7_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_7_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_8_fft/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_9_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_10_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_11_floating_point/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_12_accumulator/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_13_emc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_13_emc/rdclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_14_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_15_microblaze/Clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_16_cordic/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_17_accumulator/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_18_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_19_reset/clk_in]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_locked] [get_bd_pins ip_19_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_21_intc/irq_0] [get_bd_pins ip_0_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_21_intc/irq_1] [get_bd_pins ip_1_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_2] [get_bd_pins ip_3_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_21_intc/irq_3] [get_bd_pins ip_5_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_21_intc/irq_4] [get_bd_pins ip_8_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_21_intc/irq_5] [get_bd_pins ip_9_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_6] [get_bd_pins ip_10_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_7] [get_bd_pins ip_14_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_21_intc/irq_8] [get_bd_pins ip_18_axi_timer/interrupt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_microblaze/INTERRUPT] [get_bd_intf_pins ip_21_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_microblaze/M_AXI_DP] [get_bd_intf_pins ip_22_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_22_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_22_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_emc/AXI] [get_bd_intf_pins ip_22_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_timer/S_AXI] [get_bd_intf_pins ip_22_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_22_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_22_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_emc/AXI] [get_bd_intf_pins ip_22_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_timer/S_AXI] [get_bd_intf_pins ip_22_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_timer/S_AXI] [get_bd_intf_pins ip_22_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_intc/AXI] [get_bd_intf_pins ip_22_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_24_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_25_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_fft/M_AXIS_DATA] [get_bd_intf_pins ip_26_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/M_AXIS_DATA] [get_bd_intf_pins ip_27_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_fft/M_AXIS_DATA] [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_floating_point/S_AXIS_A] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_fft/S_AXIS_DATA] [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_35_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_fft/S_AXIS_DATA] [get_bd_intf_pins ip_38_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_39_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_12_accumulator/B]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_5_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_5_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_2] [get_bd_pins ip_5_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_3] [get_bd_pins ip_7_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_4] [get_bd_pins ip_7_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_5] [get_bd_pins ip_7_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_6] [get_bd_pins ip_7_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_7] [get_bd_pins ip_7_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_8] [get_bd_pins ip_7_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_9] [get_bd_pins ip_12_accumulator/Q]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_17_accumulator/B]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_12_accumulator/Q]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_40_reduce/in0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_12_accumulator/Q]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_1] [get_bd_pins ip_14_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_2] [get_bd_pins ip_14_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_3] [get_bd_pins ip_14_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_4] [get_bd_pins ip_17_accumulator/Q]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_5] [get_bd_pins ip_18_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_6] [get_bd_pins ip_18_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_7] [get_bd_pins ip_18_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_14_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_17_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_12_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_12_accumulator/ADD]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_18_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_17_accumulator/CE]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_5_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_5_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_18_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_12_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_4_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_5_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_17_accumulator/ADD]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_14_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_18_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_22_axi/reset]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_21_intc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_22_axi/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_23_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_24_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_25_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_26_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_27_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_28_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_29_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_33_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_34_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_35_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_36_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_37_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_38_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_39_axis_combiner/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_fft/M_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_fft/M_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 17 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_CONFIG declared=17 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_CONFIG declared=17 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 12 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=12 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=12 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_complex_multiplier/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_complex_multiplier/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_complex_multiplier/S_AXIS_B declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_complex_multiplier/S_AXIS_B declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_complex_multiplier/M_AXIS_DOUT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_complex_multiplier/M_AXIS_DOUT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_cordic/S_AXIS_CARTESIAN declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_cordic/S_AXIS_CARTESIAN declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_cordic/M_AXIS_DOUT declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_cordic/M_AXIS_DOUT declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_fft/M_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_fft/M_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_CONFIG declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_CONFIG declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_cordic/S_AXIS_CARTESIAN declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_cordic/S_AXIS_CARTESIAN declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_cordic/M_AXIS_DOUT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_cordic/M_AXIS_DOUT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_3 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_3 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/S_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/S_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_0 declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_0 declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_1 declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_1 declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_2 declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_2 declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_combiner/S_AXIS_1 declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_combiner/S_AXIS_1 declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_combiner/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_combiner/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_combiner/S_AXIS_1 declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_combiner/S_AXIS_1 declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_combiner/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_combiner/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_1 declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_1 declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/M_AXIS declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/M_AXIS declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_combiner/S_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_combiner/S_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_combiner/M_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_combiner/M_AXIS declared=24 actual=ERR $__err" }


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
