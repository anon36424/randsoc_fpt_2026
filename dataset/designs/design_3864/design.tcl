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



########## xadc_wiz ##########
create_bd_cell -type hier ip_0_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_0_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_TEMP_BUS 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_0_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_0_xadc_wiz/s_axi_aclk] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_0_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/convstclk_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_0_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/eoc_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/eos_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/alarm_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/busy_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_0_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_0_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_0_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## fft ##########
create_bd_cell -type hier ip_1_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_1_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 12 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 32 " [get_bd_cells ip_1_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_fft/aclk
connect_bd_net [get_bd_pins ip_1_fft/aclk] [get_bd_pins ip_1_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_1_fft/event_frame_started
connect_bd_net [get_bd_pins ip_1_fft/event_frame_started] [get_bd_pins ip_1_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_fft/S_AXIS_DATA] [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_fft/M_AXIS_DATA] [get_bd_intf_pins ip_1_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_1_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_CONFIG]


########## gpio ##########
create_bd_cell -type hier ip_2_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_2_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x1ffffff CONFIG.C_DOUT_DEFAULT_2 0x15e4342 CONFIG.C_GPIO2_WIDTH 26 CONFIG.C_GPIO_WIDTH 25 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0xb26be9 CONFIG.C_TRI_DEFAULT_2 0xc4b9e6 " [get_bd_cells ip_2_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/GPIO] [get_bd_intf_pins ip_2_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/GPIO2] [get_bd_intf_pins ip_2_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/clk
connect_bd_net [get_bd_pins ip_2_gpio/clk] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/rst
connect_bd_net [get_bd_pins ip_2_gpio/rst] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_2_gpio/gpio_0/S_AXI]


########## complex_multiplier ##########
create_bd_cell -type hier ip_3_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_3_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 45 CONFIG.aresetn 0 CONFIG.atuserwidth 83 CONFIG.bportwidth 51 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 86 CONFIG.roundmode Truncate " [get_bd_cells ip_3_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_3_complex_multiplier/aclk] [get_bd_pins ip_3_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_3_complex_multiplier/aclken] [get_bd_pins ip_3_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## conv_encoder ##########
create_bd_cell -type hier ip_4_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_4_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 4 CONFIG.convolution_code0 4 CONFIG.convolution_code1 3 CONFIG.convolution_code2 7 CONFIG.convolution_code3 0 CONFIG.convolution_code4 7 CONFIG.convolution_code5 3 CONFIG.convolution_code6 13 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 4 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_4_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_4_conv_encoder/aclk] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_4_conv_encoder/aresetn] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## fft ##########
create_bd_cell -type hier ip_5_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_5_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 9 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 128 " [get_bd_cells ip_5_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_fft/aclk
connect_bd_net [get_bd_pins ip_5_fft/aclk] [get_bd_pins ip_5_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_5_fft/event_frame_started
connect_bd_net [get_bd_pins ip_5_fft/event_frame_started] [get_bd_pins ip_5_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_fft/S_AXIS_DATA] [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_fft/M_AXIS_DATA] [get_bd_intf_pins ip_5_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_5_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_CONFIG]


########## conv_encoder ##########
create_bd_cell -type hier ip_6_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_6_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 3 CONFIG.convolution_code0 5 CONFIG.convolution_code1 5 CONFIG.convolution_code2 4 CONFIG.convolution_code3 0 CONFIG.convolution_code4 5 CONFIG.convolution_code5 1 CONFIG.convolution_code6 3 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 6 CONFIG.output_rate 9 CONFIG.puncture_code0 001111 CONFIG.puncture_code1 111011 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_6_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_6_conv_encoder/aclk] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_6_conv_encoder/aresetn] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_6_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_6_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## floating_point ##########
create_bd_cell -type hier ip_7_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_7_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.add_sub_value Subtract CONFIG.b_tuser_width 13 CONFIG.c_a_exponent_width 8 CONFIG.c_a_fraction_width 39 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.c_optimization Low_Latency CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Add_Subtract " [get_bd_cells ip_7_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_floating_point/aclk
connect_bd_net [get_bd_pins ip_7_floating_point/aclk] [get_bd_pins ip_7_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_7_floating_point/S_AXIS_A] [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_7_floating_point/S_AXIS_B] [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_7_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_7_floating_point/floating_point_0/M_AXIS_RESULT]


########## conv_encoder ##########
create_bd_cell -type hier ip_8_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_8_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 5 CONFIG.convolution_code0 3 CONFIG.convolution_code1 20 CONFIG.convolution_code2 8 CONFIG.convolution_code3 14 CONFIG.convolution_code4 13 CONFIG.convolution_code5 20 CONFIG.convolution_code6 0 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 5 CONFIG.output_rate 6 CONFIG.puncture_code0 11010 CONFIG.puncture_code1 10011 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_8_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_8_conv_encoder/aclk] [get_bd_pins ip_8_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_8_conv_encoder/aclken] [get_bd_pins ip_8_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_8_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_8_conv_encoder/aresetn] [get_bd_pins ip_8_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## gpio ##########
create_bd_cell -type hier ip_9_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_9_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 7 CONFIG.C_GPIO_WIDTH 8 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_9_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/GPIO] [get_bd_intf_pins ip_9_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/GPIO2] [get_bd_intf_pins ip_9_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/clk
connect_bd_net [get_bd_pins ip_9_gpio/clk] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/rst
connect_bd_net [get_bd_pins ip_9_gpio/rst] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_9_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_gpio/irq
connect_bd_net [get_bd_pins ip_9_gpio/irq] [get_bd_pins ip_9_gpio/gpio_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_10_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_10_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 55 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 1 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 8 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 8 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 8 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 14 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 8 " [get_bd_cells ip_10_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_10_axi_dma/axi_resetn] [get_bd_pins ip_10_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/M_AXI] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_10_axi_dma/mm2s_introut] [get_bd_pins ip_10_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_10_axi_dma/s2mm_introut] [get_bd_pins ip_10_axi_dma/axi_dma_0/s2mm_introut]


########## cordic ##########
create_bd_cell -type hier ip_11_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_11_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Arc_Tan CONFIG.Input_Width 41 CONFIG.Iterations 25 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 31 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 43 CONFIG.Round_Mode Round_Pos_Inf " [get_bd_cells ip_11_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_cordic/aclk
connect_bd_net [get_bd_pins ip_11_cordic/aclk] [get_bd_pins ip_11_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_11_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_11_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_11_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_11_cordic/cordic_0/M_AXIS_DOUT]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_12_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_12_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_12_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_12_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite/MII] [get_bd_intf_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_12_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_12_axi_ethernet_lite/clk] [get_bd_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_12_axi_ethernet_lite/reset] [get_bd_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_12_axi_ethernet_lite/irq] [get_bd_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## reset ##########
create_bd_cell -type hier ip_13_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_13_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_reset/clk_in
connect_bd_net [get_bd_pins ip_13_reset/clk_in] [get_bd_pins ip_13_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_13_reset/reset_in
connect_bd_net [get_bd_pins ip_13_reset/reset_in] [get_bd_pins ip_13_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_13_reset/dcm_locked
connect_bd_net [get_bd_pins ip_13_reset/dcm_locked] [get_bd_pins ip_13_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_13_reset/mb_reset
connect_bd_net [get_bd_pins ip_13_reset/mb_reset] [get_bd_pins ip_13_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_13_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_13_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_13_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset] [get_bd_pins ip_13_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_13_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_13_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_14_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_14_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_in] [get_bd_pins ip_14_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_14_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_14_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_14_clk_wiz/reset
connect_bd_net [get_bd_pins ip_14_clk_wiz/reset] [get_bd_pins ip_14_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_14_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_locked] [get_bd_pins ip_14_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_15_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_15_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_15_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_15_intc/concat_0]
connect_bd_net [get_bd_pins ip_15_intc/concat_0/dout] [get_bd_pins ip_15_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_15_intc/clk
connect_bd_net [get_bd_pins ip_15_intc/clk] [get_bd_pins ip_15_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_intc/reset
connect_bd_net [get_bd_pins ip_15_intc/reset] [get_bd_pins ip_15_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_intc/AXI] [get_bd_intf_pins ip_15_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_15_intc/irq_0
connect_bd_net [get_bd_pins ip_15_intc/irq_0] [get_bd_pins ip_15_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_15_intc/irq_1
connect_bd_net [get_bd_pins ip_15_intc/irq_1] [get_bd_pins ip_15_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_15_intc/irq_2
connect_bd_net [get_bd_pins ip_15_intc/irq_2] [get_bd_pins ip_15_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_15_intc/irq_3
connect_bd_net [get_bd_pins ip_15_intc/irq_3] [get_bd_pins ip_15_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_15_intc/irq_4
connect_bd_net [get_bd_pins ip_15_intc/irq_4] [get_bd_pins ip_15_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_15_intc/irq_5
connect_bd_net [get_bd_pins ip_15_intc/irq_5] [get_bd_pins ip_15_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_15_intc/irq_6
connect_bd_net [get_bd_pins ip_15_intc/irq_6] [get_bd_pins ip_15_intc/concat_0/In6]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_15_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_15_intc/irq] [get_bd_intf_pins ip_15_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_16_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_16_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 5 CONFIG.NUM_SI 1 " [get_bd_cells ip_16_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_legacy/clk
connect_bd_net [get_bd_pins ip_16_axi_legacy/clk] [get_bd_pins ip_16_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_legacy/reset
connect_bd_net [get_bd_pins ip_16_axi_legacy/reset] [get_bd_pins ip_16_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_legacy/AXI_M0] [get_bd_intf_pins ip_16_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_16_axi_legacy/clk] [get_bd_pins ip_16_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_16_axi_legacy/reset] [get_bd_pins ip_16_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_legacy/AXI_S0] [get_bd_intf_pins ip_16_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_16_axi_legacy/clk] [get_bd_pins ip_16_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_16_axi_legacy/reset] [get_bd_pins ip_16_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_legacy/AXI_S1] [get_bd_intf_pins ip_16_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_16_axi_legacy/clk] [get_bd_pins ip_16_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_16_axi_legacy/reset] [get_bd_pins ip_16_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_legacy/AXI_S2] [get_bd_intf_pins ip_16_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_16_axi_legacy/clk] [get_bd_pins ip_16_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_16_axi_legacy/reset] [get_bd_pins ip_16_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_legacy/AXI_S3] [get_bd_intf_pins ip_16_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_16_axi_legacy/clk] [get_bd_pins ip_16_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_16_axi_legacy/reset] [get_bd_pins ip_16_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_legacy/AXI_S4] [get_bd_intf_pins ip_16_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_16_axi_legacy/clk] [get_bd_pins ip_16_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_16_axi_legacy/reset] [get_bd_pins ip_16_axi_legacy/axi_0/M04_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_17_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_17_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_17_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_17_axis_broadcaster/aclk] [get_bd_pins ip_17_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_17_axis_broadcaster/aresetn] [get_bd_pins ip_17_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_18_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_18_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_18_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_18_axis_broadcaster/aclk] [get_bd_pins ip_18_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_18_axis_broadcaster/aresetn] [get_bd_pins ip_18_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_19_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_19_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_19_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_19_axis_broadcaster/aclk] [get_bd_pins ip_19_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_19_axis_broadcaster/aresetn] [get_bd_pins ip_19_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_20_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_20_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 5 " [get_bd_cells ip_20_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_20_axis_broadcaster/aclk] [get_bd_pins ip_20_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_20_axis_broadcaster/aresetn] [get_bd_pins ip_20_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M03_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_4
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_4] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M04_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_21_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_21_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_21_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_21_axis_broadcaster/aclk] [get_bd_pins ip_21_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_21_axis_broadcaster/aresetn] [get_bd_pins ip_21_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_22_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_22_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_22_axis_dwidth_converter/aclk] [get_bd_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_22_axis_dwidth_converter/aresetn] [get_bd_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_23_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_23_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aclk] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aresetn] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_24_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_24_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aclk] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aresetn] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_25_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_25_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_25_axis_dwidth_converter/aclk] [get_bd_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_25_axis_dwidth_converter/aresetn] [get_bd_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_26_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_26_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aclk] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aresetn] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_27_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_27_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 48 " [get_bd_cells ip_27_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aclk] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aresetn] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_28_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_28_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_28_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aclk] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aresetn] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_29_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_29_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_29_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_29_axis_combiner/aclk] [get_bd_pins ip_29_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_29_axis_combiner/aresetn] [get_bd_pins ip_29_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_combiner/M_AXIS] [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_30_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_30_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_30_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_30_axis_combiner/aclk] [get_bd_pins ip_30_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_30_axis_combiner/aresetn] [get_bd_pins ip_30_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_30_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_30_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_30_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_combiner/M_AXIS] [get_bd_intf_pins ip_30_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_31_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_31_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_31_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aclk] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aresetn] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_32_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_32_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 4 " [get_bd_cells ip_32_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_32_axis_combiner/aclk] [get_bd_pins ip_32_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_32_axis_combiner/aresetn] [get_bd_pins ip_32_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_combiner/S_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/S03_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_combiner/M_AXIS] [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_33_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_33_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_33_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aclk] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aresetn] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_34_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_34_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 3 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_34_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aclk] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aresetn] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 2 -to 0 ip_35_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_35_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_35_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_2] [get_bd_pins ip_35_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_36_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_14_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_0_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_0_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_0_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio_GPIO] [get_bd_intf_pins ip_2_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio_GPIO2] [get_bd_intf_pins ip_2_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO] [get_bd_intf_pins ip_9_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO2] [get_bd_intf_pins ip_9_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_12_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite_MII] [get_bd_intf_pins ip_12_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_12_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_12_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_15_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_17_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 2 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_35_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_0_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_2_gpio/rst]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_4_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_6_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_8_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_9_gpio/rst]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_0_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_0_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_1_fft/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_2_gpio/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_3_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_4_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_5_fft/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_6_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_7_floating_point/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_8_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_9_gpio/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_11_cordic/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_12_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_13_reset/clk_in]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_locked] [get_bd_pins ip_13_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_15_intc/irq_0] [get_bd_pins ip_0_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_15_intc/irq_1] [get_bd_pins ip_1_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_15_intc/irq_2] [get_bd_pins ip_5_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_15_intc/irq_3] [get_bd_pins ip_9_gpio/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_4] [get_bd_pins ip_10_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_15_intc/irq_5] [get_bd_pins ip_10_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_15_intc/irq_6] [get_bd_pins ip_12_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/M_AXI] [get_bd_intf_pins ip_16_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_16_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_16_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_16_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_16_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_intc/AXI] [get_bd_intf_pins ip_16_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_18_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_19_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_20_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/M_AXIS_DATA] [get_bd_intf_pins ip_21_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_1_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_floating_point/S_AXIS_A] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_DATA] [get_bd_intf_pins ip_3_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_fft/S_AXIS_DATA] [get_bd_intf_pins ip_29_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_floating_point/S_AXIS_B] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_0_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_2] [get_bd_pins ip_0_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_3_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_8_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_16_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_15_intc/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_16_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_17_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_18_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_19_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_20_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_21_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_28_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_29_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_30_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_32_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_33_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_34_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/M_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/M_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 27 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_CONFIG declared=27 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_CONFIG declared=27 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_A declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_A declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 176 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/M_AXIS_DOUT declared=176 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/M_AXIS_DOUT declared=176 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 17 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=17 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=17 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_B declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_B declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/M_AXIS_RESULT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/M_AXIS_RESULT declared=48 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/M_AXIS_MM2S declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/M_AXIS_MM2S declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/S_AXIS_S2MM declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/S_AXIS_S2MM declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_cordic/S_AXIS_CARTESIAN declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_cordic/S_AXIS_CARTESIAN declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_3 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_3 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_3 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_3 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M04_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_4 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_4 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/S_AXIS declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/S_AXIS declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_0 declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_0 declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_1 declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_1 declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_2 declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_2 declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/M_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/M_AXIS declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_combiner/S_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_combiner/S_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_combiner/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_combiner/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/S_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/S_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/S03_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/S_AXIS_3 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/S_AXIS_3 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 17 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=17 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=17 actual=ERR $__err" }


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
