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



########## floating_point ##########
create_bd_cell -type hier ip_0_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_0_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Half CONFIG.a_tuser_width 32 CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Resources CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_divide_by_zero 1 CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_type Reciprocal " [get_bd_cells ip_0_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_floating_point/aclk
connect_bd_net [get_bd_pins ip_0_floating_point/aclk] [get_bd_pins ip_0_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_floating_point/aclken
connect_bd_net [get_bd_pins ip_0_floating_point/aclken] [get_bd_pins ip_0_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_0_floating_point/aresetn
connect_bd_net [get_bd_pins ip_0_floating_point/aresetn] [get_bd_pins ip_0_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_0_floating_point/S_AXIS_A] [get_bd_intf_pins ip_0_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_0_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_0_floating_point/floating_point_0/M_AXIS_RESULT]


########## accumulator ##########
create_bd_cell -type hier ip_1_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_1_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 15 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 27 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_1_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/clk
connect_bd_net [get_bd_pins ip_1_accumulator/clk] [get_bd_pins ip_1_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 14 -to 0 ip_1_accumulator/B
connect_bd_net [get_bd_pins ip_1_accumulator/B] [get_bd_pins ip_1_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 26 -to 0 ip_1_accumulator/Q
connect_bd_net [get_bd_pins ip_1_accumulator/Q] [get_bd_pins ip_1_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/CE
connect_bd_net [get_bd_pins ip_1_accumulator/CE] [get_bd_pins ip_1_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/C_IN
connect_bd_net [get_bd_pins ip_1_accumulator/C_IN] [get_bd_pins ip_1_accumulator/accumulator_0/C_IN]


########## conv_encoder ##########
create_bd_cell -type hier ip_2_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_2_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 9 CONFIG.convolution_code0 486 CONFIG.convolution_code1 25 CONFIG.convolution_code2 175 CONFIG.convolution_code3 172 CONFIG.convolution_code4 330 CONFIG.convolution_code5 287 CONFIG.convolution_code6 508 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 4 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_2_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_2_conv_encoder/aclk] [get_bd_pins ip_2_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_2_conv_encoder/aclken] [get_bd_pins ip_2_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_2_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_2_conv_encoder/aresetn] [get_bd_pins ip_2_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_2_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_2_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_2_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_2_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## uartlite ##########
create_bd_cell -type hier ip_3_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_3_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 1200 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Even " [get_bd_cells ip_3_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/UART] [get_bd_intf_pins ip_3_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/clk
connect_bd_net [get_bd_pins ip_3_uartlite/clk] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/reset
connect_bd_net [get_bd_pins ip_3_uartlite/reset] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_3_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_uartlite/irq
connect_bd_net [get_bd_pins ip_3_uartlite/irq] [get_bd_pins ip_3_uartlite/uart_0/interrupt]


########## axi_timer ##########
create_bd_cell -type hier ip_4_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_4_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 8 CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_4_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_timer/S_AXI] [get_bd_intf_pins ip_4_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_4_axi_timer/capturetrig0] [get_bd_pins ip_4_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_4_axi_timer/capturetrig1] [get_bd_pins ip_4_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/freeze
connect_bd_net [get_bd_pins ip_4_axi_timer/freeze] [get_bd_pins ip_4_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_4_axi_timer/s_axi_aclk] [get_bd_pins ip_4_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_4_axi_timer/s_axi_aresetn] [get_bd_pins ip_4_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_4_axi_timer/generateout0] [get_bd_pins ip_4_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_4_axi_timer/generateout1] [get_bd_pins ip_4_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_4_axi_timer/pwm0] [get_bd_pins ip_4_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_4_axi_timer/interrupt] [get_bd_pins ip_4_axi_timer/axi_timer_0/interrupt]


########## emc ##########
create_bd_cell -type hier ip_5_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_5_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 16 CONFIG.C_TAVDV_PS_MEM_0 14018 CONFIG.C_TCEDV_PS_MEM_0 14577 CONFIG.C_THZCE_PS_MEM_0 6943 CONFIG.C_THZOE_PS_MEM_0 6663 CONFIG.C_TLZWE_PS_MEM_0 332 CONFIG.C_TWC_PS_MEM_0 13861 CONFIG.C_TWPH_PS_MEM_0 13196 CONFIG.C_TWP_PS_MEM_0 12984 CONFIG.C_WR_REC_TIME_MEM_0 26479 " [get_bd_cells ip_5_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_5_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_5_emc/EMC_INTF] [get_bd_intf_pins ip_5_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/clk
connect_bd_net [get_bd_pins ip_5_emc/clk] [get_bd_pins ip_5_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/rdclk
connect_bd_net [get_bd_pins ip_5_emc/rdclk] [get_bd_pins ip_5_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/rst
connect_bd_net [get_bd_pins ip_5_emc/rst] [get_bd_pins ip_5_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_emc/AXI] [get_bd_intf_pins ip_5_emc/emc_0/S_AXI_MEM]


########## conv_encoder ##########
create_bd_cell -type hier ip_6_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_6_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 5 CONFIG.convolution_code0 3 CONFIG.convolution_code1 8 CONFIG.convolution_code2 22 CONFIG.convolution_code3 0 CONFIG.convolution_code4 21 CONFIG.convolution_code5 3 CONFIG.convolution_code6 30 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 2 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_6_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_6_conv_encoder/aclk] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_6_conv_encoder/aclken] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_6_conv_encoder/aresetn] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_6_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_6_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## xadc_wiz ##########
create_bd_cell -type hier ip_7_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_7_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_7_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_7_xadc_wiz/dclk_in] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_7_xadc_wiz/reset_in] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_7_xadc_wiz/convstclk_in] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/ot_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/ot_out]
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


########## conv_encoder ##########
create_bd_cell -type hier ip_8_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_8_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 9 CONFIG.convolution_code0 13 CONFIG.convolution_code1 387 CONFIG.convolution_code2 88 CONFIG.convolution_code3 9 CONFIG.convolution_code4 509 CONFIG.convolution_code5 420 CONFIG.convolution_code6 98 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 3 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_8_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_8_conv_encoder/aclk] [get_bd_pins ip_8_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_8_conv_encoder/aresetn] [get_bd_pins ip_8_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## reset ##########
create_bd_cell -type hier ip_9_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_9_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_reset/clk_in
connect_bd_net [get_bd_pins ip_9_reset/clk_in] [get_bd_pins ip_9_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_reset/reset_in
connect_bd_net [get_bd_pins ip_9_reset/reset_in] [get_bd_pins ip_9_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_9_reset/dcm_locked
connect_bd_net [get_bd_pins ip_9_reset/dcm_locked] [get_bd_pins ip_9_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/mb_reset
connect_bd_net [get_bd_pins ip_9_reset/mb_reset] [get_bd_pins ip_9_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_9_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset] [get_bd_pins ip_9_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_9_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_10_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_10_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_in] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_10_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_10_clk_wiz/reset
connect_bd_net [get_bd_pins ip_10_clk_wiz/reset] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_10_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_locked] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_11_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_11_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_11_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_11_intc/concat_0]
connect_bd_net [get_bd_pins ip_11_intc/concat_0/dout] [get_bd_pins ip_11_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/clk
connect_bd_net [get_bd_pins ip_11_intc/clk] [get_bd_pins ip_11_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/reset
connect_bd_net [get_bd_pins ip_11_intc/reset] [get_bd_pins ip_11_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_intc/AXI] [get_bd_intf_pins ip_11_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_0
connect_bd_net [get_bd_pins ip_11_intc/irq_0] [get_bd_pins ip_11_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_1
connect_bd_net [get_bd_pins ip_11_intc/irq_1] [get_bd_pins ip_11_intc/concat_0/In1]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_11_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_11_intc/irq] [get_bd_intf_pins ip_11_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_12_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_12_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 1 " [get_bd_cells ip_12_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_legacy/clk
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_legacy/reset
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_M0] [get_bd_intf_pins ip_12_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S0] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S1] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S2] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S3] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M03_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_13_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_13_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_13_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aclk] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aresetn] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_14_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_14_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_14_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_14_axis_dwidth_converter/aclk] [get_bd_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_14_axis_dwidth_converter/aresetn] [get_bd_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_15_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_15_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_15_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_15_axis_dwidth_converter/aclk] [get_bd_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_15_axis_dwidth_converter/aresetn] [get_bd_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_16_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_16_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_16_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aclk] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aresetn] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 26 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 27 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 20 -to 0 ip_18_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 10 " [get_bd_cells ip_18_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 26 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 26 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 27 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/slice_0/dout] [get_bd_pins ip_18_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_1] [get_bd_pins ip_18_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_2] [get_bd_pins ip_18_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_3] [get_bd_pins ip_18_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_4] [get_bd_pins ip_18_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_5] [get_bd_pins ip_18_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_6] [get_bd_pins ip_18_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_7] [get_bd_pins ip_18_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_8] [get_bd_pins ip_18_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_9] [get_bd_pins ip_18_slice_and_concat/concat/In9]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_19_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_20_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_21_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_22_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_26_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_10_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite_UART] [get_bd_intf_pins ip_3_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_5_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_5_emc_EMC_INTF] [get_bd_intf_pins ip_5_emc/EMC_INTF]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_7_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_7_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_7_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_11_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi_master
set_property -dict "CONFIG.PROTOCOL AXI4LITE " [get_bd_intf_ports axi_master]
connect_bd_intf_net [get_bd_intf_pins axi_master] [get_bd_intf_pins ip_12_axi_legacy/AXI_M0]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_0_floating_point/M_AXIS_RESULT]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 20 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_18_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_0_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_2_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_3_uartlite/reset]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_5_emc/rst]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_6_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset] [get_bd_pins ip_7_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_8_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_0_floating_point/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_1_accumulator/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_2_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_3_uartlite/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_4_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_5_emc/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_5_emc/rdclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_6_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_7_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_7_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_8_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_9_reset/clk_in]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_locked] [get_bd_pins ip_9_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_11_intc/irq_0] [get_bd_pins ip_3_uartlite/irq]
connect_bd_net [get_bd_pins ip_11_intc/irq_1] [get_bd_pins ip_4_axi_timer/interrupt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_timer/S_AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_emc/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_intc/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_2_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_floating_point/S_AXIS_A] [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/B]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_1] [get_bd_pins ip_4_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_2] [get_bd_pins ip_4_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_3] [get_bd_pins ip_4_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_4] [get_bd_pins ip_7_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_5] [get_bd_pins ip_7_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_6] [get_bd_pins ip_7_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_7] [get_bd_pins ip_7_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_8] [get_bd_pins ip_7_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_9] [get_bd_pins ip_7_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_4_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_0_floating_point/aclken]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/CE]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_2_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_4_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_4_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_6_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_12_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_13_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_11_intc/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_12_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_13_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_14_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_15_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_16_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }


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
