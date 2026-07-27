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
set_property -dict "CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_TEMP_BUS 0 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_0_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_0_xadc_wiz/s_axi_aclk] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_0_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/convst_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_0_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
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


########## axi_hwicap ##########
create_bd_cell -type hier ip_1_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_1_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 512 " [get_bd_cells ip_1_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_1_axi_hwicap/icap_clk] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_1_axi_hwicap/eos_in] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_1_axi_hwicap/s_axi_aclk] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_2_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_2_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 38 CONFIG.aresetn 1 CONFIG.bportwidth 29 CONFIG.ctrltuserwidth 239 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Manual CONFIG.minimumlatency 19 CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 11 CONFIG.roundmode Random_Rounding " [get_bd_cells ip_2_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_2_complex_multiplier/aclk] [get_bd_pins ip_2_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_2_complex_multiplier/aclken] [get_bd_pins ip_2_complex_multiplier/cmpy_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_2_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_2_complex_multiplier/aresetn] [get_bd_pins ip_2_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 14 CONFIG.Latency 2 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 33 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 13 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 32 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/CE
connect_bd_net [get_bd_pins ip_3_accumulator/CE] [get_bd_pins ip_3_accumulator/accumulator_0/CE]


########## conv_encoder ##########
create_bd_cell -type hier ip_4_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_4_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 3 CONFIG.convolution_code0 1 CONFIG.convolution_code1 3 CONFIG.convolution_code2 4 CONFIG.convolution_code3 0 CONFIG.convolution_code4 2 CONFIG.convolution_code5 0 CONFIG.convolution_code6 3 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 12 CONFIG.output_rate 20 CONFIG.puncture_code0 111111001111 CONFIG.puncture_code1 111001111111 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_4_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_4_conv_encoder/aclk] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_4_conv_encoder/aclken] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aclken]
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
set_property -dict "CONFIG.channels 12 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 8 " [get_bd_cells ip_5_fft/fft_0]
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


########## dft ##########
create_bd_cell -type hier ip_6_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_6_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 12 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_6_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/CLK
connect_bd_net [get_bd_pins ip_6_dft/CLK] [get_bd_pins ip_6_dft/dft_0/CLK]
create_bd_pin -dir I -from 11 -to 0 ip_6_dft/XN_RE
connect_bd_net [get_bd_pins ip_6_dft/XN_RE] [get_bd_pins ip_6_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 11 -to 0 ip_6_dft/XN_IM
connect_bd_net [get_bd_pins ip_6_dft/XN_IM] [get_bd_pins ip_6_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FD_IN
connect_bd_net [get_bd_pins ip_6_dft/FD_IN] [get_bd_pins ip_6_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FWD_INV
connect_bd_net [get_bd_pins ip_6_dft/FWD_INV] [get_bd_pins ip_6_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_6_dft/SIZE
connect_bd_net [get_bd_pins ip_6_dft/SIZE] [get_bd_pins ip_6_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/RFFD
connect_bd_net [get_bd_pins ip_6_dft/RFFD] [get_bd_pins ip_6_dft/dft_0/RFFD]
create_bd_pin -dir O -from 11 -to 0 ip_6_dft/XK_RE
connect_bd_net [get_bd_pins ip_6_dft/XK_RE] [get_bd_pins ip_6_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 11 -to 0 ip_6_dft/XK_IM
connect_bd_net [get_bd_pins ip_6_dft/XK_IM] [get_bd_pins ip_6_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_6_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_6_dft/BLK_EXP] [get_bd_pins ip_6_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/FD_OUT
connect_bd_net [get_bd_pins ip_6_dft/FD_OUT] [get_bd_pins ip_6_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_6_dft/DATA_VALID] [get_bd_pins ip_6_dft/dft_0/DATA_VALID]


########## axi_dma ##########
create_bd_cell -type hier ip_7_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_7_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 35 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_7_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_7_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_7_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_7_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_7_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_7_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_7_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_7_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_7_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_7_axi_dma/axi_resetn] [get_bd_pins ip_7_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_7_axi_dma/mm2s_introut] [get_bd_pins ip_7_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_7_axi_dma/s2mm_introut] [get_bd_pins ip_7_axi_dma/axi_dma_0/s2mm_introut]


########## floating_point ##########
create_bd_cell -type hier ip_8_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_8_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Resources CONFIG.b_tuser_width 3 CONFIG.c_a_exponent_width 6 CONFIG.c_a_fraction_width 10 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Greater_Than CONFIG.c_has_invalid_op 1 CONFIG.c_mult_usage No_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_type Compare CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_8_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_floating_point/aclk
connect_bd_net [get_bd_pins ip_8_floating_point/aclk] [get_bd_pins ip_8_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_floating_point/aclken
connect_bd_net [get_bd_pins ip_8_floating_point/aclken] [get_bd_pins ip_8_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_8_floating_point/aresetn
connect_bd_net [get_bd_pins ip_8_floating_point/aresetn] [get_bd_pins ip_8_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_8_floating_point/S_AXIS_A] [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_8_floating_point/S_AXIS_B] [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_8_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_8_floating_point/floating_point_0/M_AXIS_RESULT]


########## cordic ##########
create_bd_cell -type hier ip_9_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_9_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Rotate CONFIG.Input_Width 43 CONFIG.Iterations 16 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 14 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 34 CONFIG.Round_Mode Round_Pos_Inf " [get_bd_cells ip_9_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_cordic/aclk
connect_bd_net [get_bd_pins ip_9_cordic/aclk] [get_bd_pins ip_9_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_cordic/aresetn
connect_bd_net [get_bd_pins ip_9_cordic/aresetn] [get_bd_pins ip_9_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_9_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_9_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_9_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_9_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_9_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_9_cordic/cordic_0/M_AXIS_DOUT]


########## complex_multiplier ##########
create_bd_cell -type hier ip_10_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_10_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 63 CONFIG.aresetn 0 CONFIG.bportwidth 9 CONFIG.btuserwidth 17 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 19 CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 21 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_10_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_10_complex_multiplier/aclk] [get_bd_pins ip_10_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_11_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_11_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 16 CONFIG.C_TAVDV_PS_MEM_0 14215 CONFIG.C_TCEDV_PS_MEM_0 16374 CONFIG.C_THZCE_PS_MEM_0 7332 CONFIG.C_THZOE_PS_MEM_0 6539 CONFIG.C_TLZWE_PS_MEM_0 9039 CONFIG.C_TWC_PS_MEM_0 14430 CONFIG.C_TWPH_PS_MEM_0 12288 CONFIG.C_TWP_PS_MEM_0 11705 CONFIG.C_WR_REC_TIME_MEM_0 27955 " [get_bd_cells ip_11_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_11_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_11_emc/EMC_INTF] [get_bd_intf_pins ip_11_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_11_emc/clk
connect_bd_net [get_bd_pins ip_11_emc/clk] [get_bd_pins ip_11_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_emc/rdclk
connect_bd_net [get_bd_pins ip_11_emc/rdclk] [get_bd_pins ip_11_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_emc/rst
connect_bd_net [get_bd_pins ip_11_emc/rst] [get_bd_pins ip_11_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_emc/AXI] [get_bd_intf_pins ip_11_emc/emc_0/S_AXI_MEM]


########## floating_point ##########
create_bd_cell -type hier ip_12_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_12_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Double CONFIG.a_tuser_width 98 CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Performance CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_mult_usage No_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_type Absolute " [get_bd_cells ip_12_floating_point/floating_point_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_12_floating_point/S_AXIS_A] [get_bd_intf_pins ip_12_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_12_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_12_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_iic ##########
create_bd_cell -type hier ip_13_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_13_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x38 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 35 CONFIG.C_SDA_INERTIAL_DELAY 64 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 904.6049652953666 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_13_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_13_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_iic/IIC] [get_bd_intf_pins ip_13_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_iic/clk
connect_bd_net [get_bd_pins ip_13_axi_iic/clk] [get_bd_pins ip_13_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_iic/reset
connect_bd_net [get_bd_pins ip_13_axi_iic/reset] [get_bd_pins ip_13_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_iic/AXI] [get_bd_intf_pins ip_13_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_iic/irq
connect_bd_net [get_bd_pins ip_13_axi_iic/irq] [get_bd_pins ip_13_axi_iic/axi_iic_0/iic2intc_irpt]


########## dft ##########
create_bd_cell -type hier ip_14_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_14_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 9 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_14_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_dft/CLK
connect_bd_net [get_bd_pins ip_14_dft/CLK] [get_bd_pins ip_14_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_14_dft/CE
connect_bd_net [get_bd_pins ip_14_dft/CE] [get_bd_pins ip_14_dft/dft_0/CE]
create_bd_pin -dir I -from 8 -to 0 ip_14_dft/XN_RE
connect_bd_net [get_bd_pins ip_14_dft/XN_RE] [get_bd_pins ip_14_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 8 -to 0 ip_14_dft/XN_IM
connect_bd_net [get_bd_pins ip_14_dft/XN_IM] [get_bd_pins ip_14_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_14_dft/FD_IN
connect_bd_net [get_bd_pins ip_14_dft/FD_IN] [get_bd_pins ip_14_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_14_dft/FWD_INV
connect_bd_net [get_bd_pins ip_14_dft/FWD_INV] [get_bd_pins ip_14_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_14_dft/SIZE
connect_bd_net [get_bd_pins ip_14_dft/SIZE] [get_bd_pins ip_14_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_14_dft/RFFD
connect_bd_net [get_bd_pins ip_14_dft/RFFD] [get_bd_pins ip_14_dft/dft_0/RFFD]
create_bd_pin -dir O -from 8 -to 0 ip_14_dft/XK_RE
connect_bd_net [get_bd_pins ip_14_dft/XK_RE] [get_bd_pins ip_14_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 8 -to 0 ip_14_dft/XK_IM
connect_bd_net [get_bd_pins ip_14_dft/XK_IM] [get_bd_pins ip_14_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_14_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_14_dft/BLK_EXP] [get_bd_pins ip_14_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_14_dft/FD_OUT
connect_bd_net [get_bd_pins ip_14_dft/FD_OUT] [get_bd_pins ip_14_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_14_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_14_dft/DATA_VALID] [get_bd_pins ip_14_dft/dft_0/DATA_VALID]


########## axi_iic ##########
create_bd_cell -type hier ip_15_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_15_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x34 CONFIG.C_GPO_WIDTH 8 CONFIG.C_SCL_INERTIAL_DELAY 34 CONFIG.C_SDA_INERTIAL_DELAY 253 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 830.1577389328179 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_15_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_15_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_iic/IIC] [get_bd_intf_pins ip_15_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_iic/clk
connect_bd_net [get_bd_pins ip_15_axi_iic/clk] [get_bd_pins ip_15_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_iic/reset
connect_bd_net [get_bd_pins ip_15_axi_iic/reset] [get_bd_pins ip_15_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_iic/AXI] [get_bd_intf_pins ip_15_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_iic/irq
connect_bd_net [get_bd_pins ip_15_axi_iic/irq] [get_bd_pins ip_15_axi_iic/axi_iic_0/iic2intc_irpt]


########## conv_encoder ##########
create_bd_cell -type hier ip_16_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_16_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 6 CONFIG.convolution_code0 21 CONFIG.convolution_code1 27 CONFIG.convolution_code2 17 CONFIG.convolution_code3 35 CONFIG.convolution_code4 50 CONFIG.convolution_code5 29 CONFIG.convolution_code6 15 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 7 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_16_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_16_conv_encoder/aclk] [get_bd_pins ip_16_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_16_conv_encoder/aresetn] [get_bd_pins ip_16_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_16_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_16_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_16_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_16_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## conv_encoder ##########
create_bd_cell -type hier ip_17_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_17_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 9 CONFIG.convolution_code0 405 CONFIG.convolution_code1 38 CONFIG.convolution_code2 215 CONFIG.convolution_code3 311 CONFIG.convolution_code4 280 CONFIG.convolution_code5 7 CONFIG.convolution_code6 77 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 3 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_17_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_17_conv_encoder/aclk] [get_bd_pins ip_17_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_17_conv_encoder/aresetn] [get_bd_pins ip_17_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_17_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_17_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_17_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_17_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## uartlite ##########
create_bd_cell -type hier ip_18_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_18_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 230400 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Odd " [get_bd_cells ip_18_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_18_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite/UART] [get_bd_intf_pins ip_18_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_18_uartlite/clk
connect_bd_net [get_bd_pins ip_18_uartlite/clk] [get_bd_pins ip_18_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_uartlite/reset
connect_bd_net [get_bd_pins ip_18_uartlite/reset] [get_bd_pins ip_18_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite/AXI] [get_bd_intf_pins ip_18_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_18_uartlite/irq
connect_bd_net [get_bd_pins ip_18_uartlite/irq] [get_bd_pins ip_18_uartlite/uart_0/interrupt]


########## cordic ##########
create_bd_cell -type hier ip_19_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_19_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Arc_Tan CONFIG.Input_Width 32 CONFIG.Iterations 16 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 43 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 47 CONFIG.Round_Mode Round_Pos_Inf " [get_bd_cells ip_19_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_cordic/aclk
connect_bd_net [get_bd_pins ip_19_cordic/aclk] [get_bd_pins ip_19_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_19_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_19_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_19_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_19_cordic/cordic_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_20_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_20_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 10 CONFIG.C_TAVDV_PS_MEM_0 16166 CONFIG.C_TAVDV_PS_MEM_1 16470 CONFIG.C_TCEDV_PS_MEM_0 15775 CONFIG.C_TCEDV_PS_MEM_1 13706 CONFIG.C_THZCE_PS_MEM_0 7012 CONFIG.C_THZCE_PS_MEM_1 7213 CONFIG.C_THZOE_PS_MEM_0 7467 CONFIG.C_THZOE_PS_MEM_1 7067 CONFIG.C_TLZWE_PS_MEM_0 6872 CONFIG.C_TLZWE_PS_MEM_1 4159 CONFIG.C_TWC_PS_MEM_0 13656 CONFIG.C_TWC_PS_MEM_1 14824 CONFIG.C_TWPH_PS_MEM_0 12076 CONFIG.C_TWPH_PS_MEM_1 11436 CONFIG.C_TWP_PS_MEM_0 12742 CONFIG.C_TWP_PS_MEM_1 12690 CONFIG.C_WR_REC_TIME_MEM_0 28831 CONFIG.C_WR_REC_TIME_MEM_1 27484 " [get_bd_cells ip_20_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_20_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_20_emc/EMC_INTF] [get_bd_intf_pins ip_20_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_20_emc/clk
connect_bd_net [get_bd_pins ip_20_emc/clk] [get_bd_pins ip_20_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_emc/rdclk
connect_bd_net [get_bd_pins ip_20_emc/rdclk] [get_bd_pins ip_20_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_emc/rst
connect_bd_net [get_bd_pins ip_20_emc/rst] [get_bd_pins ip_20_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_20_emc/AXI] [get_bd_intf_pins ip_20_emc/emc_0/S_AXI_MEM]


########## axi_timer ##########
create_bd_cell -type hier ip_21_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_21_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_21_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_timer/S_AXI] [get_bd_intf_pins ip_21_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_21_axi_timer/capturetrig0] [get_bd_pins ip_21_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_timer/freeze
connect_bd_net [get_bd_pins ip_21_axi_timer/freeze] [get_bd_pins ip_21_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_21_axi_timer/s_axi_aclk] [get_bd_pins ip_21_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_21_axi_timer/s_axi_aresetn] [get_bd_pins ip_21_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_21_axi_timer/generateout0] [get_bd_pins ip_21_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_21_axi_timer/generateout1] [get_bd_pins ip_21_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_21_axi_timer/pwm0] [get_bd_pins ip_21_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_21_axi_timer/interrupt] [get_bd_pins ip_21_axi_timer/axi_timer_0/interrupt]


########## emc ##########
create_bd_cell -type hier ip_22_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_22_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 5 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 2 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 4 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 8 CONFIG.C_TAVDV_PS_MEM_0 16280 CONFIG.C_TAVDV_PS_MEM_1 15801 CONFIG.C_TAVDV_PS_MEM_2 15944 CONFIG.C_TCEDV_PS_MEM_0 16050 CONFIG.C_TCEDV_PS_MEM_1 15098 CONFIG.C_TCEDV_PS_MEM_2 14932 CONFIG.C_THZCE_PS_MEM_0 7197 CONFIG.C_THZCE_PS_MEM_1 7433 CONFIG.C_THZCE_PS_MEM_2 6954 CONFIG.C_THZOE_PS_MEM_0 7572 CONFIG.C_THZOE_PS_MEM_1 7369 CONFIG.C_THZOE_PS_MEM_2 7419 CONFIG.C_TLZWE_PS_MEM_0 8586 CONFIG.C_TLZWE_PS_MEM_1 4961 CONFIG.C_TLZWE_PS_MEM_2 726 CONFIG.C_TWC_PS_MEM_0 14033 CONFIG.C_TWC_PS_MEM_1 14072 CONFIG.C_TWC_PS_MEM_2 15749 CONFIG.C_TWPH_PS_MEM_0 12024 CONFIG.C_TWPH_PS_MEM_1 13016 CONFIG.C_TWPH_PS_MEM_2 11266 CONFIG.C_TWP_PS_MEM_0 11135 CONFIG.C_TWP_PS_MEM_1 12178 CONFIG.C_TWP_PS_MEM_2 11084 CONFIG.C_WR_REC_TIME_MEM_0 26481 CONFIG.C_WR_REC_TIME_MEM_1 26333 CONFIG.C_WR_REC_TIME_MEM_2 26956 " [get_bd_cells ip_22_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_22_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_22_emc/EMC_INTF] [get_bd_intf_pins ip_22_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_22_emc/clk
connect_bd_net [get_bd_pins ip_22_emc/clk] [get_bd_pins ip_22_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_emc/rdclk
connect_bd_net [get_bd_pins ip_22_emc/rdclk] [get_bd_pins ip_22_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_emc/rst
connect_bd_net [get_bd_pins ip_22_emc/rst] [get_bd_pins ip_22_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_22_emc/AXI] [get_bd_intf_pins ip_22_emc/emc_0/S_AXI_MEM]


########## gpio ##########
create_bd_cell -type hier ip_23_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_23_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_GPIO_WIDTH 25 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_23_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_23_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_23_gpio/GPIO] [get_bd_intf_pins ip_23_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_23_gpio/clk
connect_bd_net [get_bd_pins ip_23_gpio/clk] [get_bd_pins ip_23_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_gpio/rst
connect_bd_net [get_bd_pins ip_23_gpio/rst] [get_bd_pins ip_23_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_23_gpio/AXI] [get_bd_intf_pins ip_23_gpio/gpio_0/S_AXI]


########## fft ##########
create_bd_cell -type hier ip_24_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_24_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 10 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 128 " [get_bd_cells ip_24_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_fft/aclk
connect_bd_net [get_bd_pins ip_24_fft/aclk] [get_bd_pins ip_24_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_24_fft/event_frame_started
connect_bd_net [get_bd_pins ip_24_fft/event_frame_started] [get_bd_pins ip_24_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_24_fft/S_AXIS_DATA] [get_bd_intf_pins ip_24_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_24_fft/M_AXIS_DATA] [get_bd_intf_pins ip_24_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_24_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_24_fft/fft_0/S_AXIS_CONFIG]


########## floating_point ##########
create_bd_cell -type hier ip_25_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_25_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.add_sub_value Both CONFIG.c_a_exponent_width 16 CONFIG.c_a_fraction_width 49 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.c_result_exponent_width 14 CONFIG.c_result_fraction_width 18 CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Float_to_float CONFIG.result_precision_type Custom " [get_bd_cells ip_25_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_floating_point/aclk
connect_bd_net [get_bd_pins ip_25_floating_point/aclk] [get_bd_pins ip_25_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_25_floating_point/S_AXIS_A] [get_bd_intf_pins ip_25_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_25_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_25_floating_point/floating_point_0/M_AXIS_RESULT]


########## reset ##########
create_bd_cell -type hier ip_26_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_26_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_reset/clk_in
connect_bd_net [get_bd_pins ip_26_reset/clk_in] [get_bd_pins ip_26_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_26_reset/reset_in
connect_bd_net [get_bd_pins ip_26_reset/reset_in] [get_bd_pins ip_26_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_26_reset/dcm_locked
connect_bd_net [get_bd_pins ip_26_reset/dcm_locked] [get_bd_pins ip_26_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_26_reset/mb_reset
connect_bd_net [get_bd_pins ip_26_reset/mb_reset] [get_bd_pins ip_26_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_26_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_26_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_26_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset] [get_bd_pins ip_26_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_26_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_26_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_27_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_27_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_in] [get_bd_pins ip_27_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_27_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_27_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_27_clk_wiz/reset
connect_bd_net [get_bd_pins ip_27_clk_wiz/reset] [get_bd_pins ip_27_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_27_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_locked] [get_bd_pins ip_27_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_28_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_28_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_28_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 10 " [get_bd_cells ip_28_intc/concat_0]
connect_bd_net [get_bd_pins ip_28_intc/concat_0/dout] [get_bd_pins ip_28_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/clk
connect_bd_net [get_bd_pins ip_28_intc/clk] [get_bd_pins ip_28_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/reset
connect_bd_net [get_bd_pins ip_28_intc/reset] [get_bd_pins ip_28_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_28_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_28_intc/AXI] [get_bd_intf_pins ip_28_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_0
connect_bd_net [get_bd_pins ip_28_intc/irq_0] [get_bd_pins ip_28_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_1
connect_bd_net [get_bd_pins ip_28_intc/irq_1] [get_bd_pins ip_28_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_2
connect_bd_net [get_bd_pins ip_28_intc/irq_2] [get_bd_pins ip_28_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_3
connect_bd_net [get_bd_pins ip_28_intc/irq_3] [get_bd_pins ip_28_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_4
connect_bd_net [get_bd_pins ip_28_intc/irq_4] [get_bd_pins ip_28_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_5
connect_bd_net [get_bd_pins ip_28_intc/irq_5] [get_bd_pins ip_28_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_6
connect_bd_net [get_bd_pins ip_28_intc/irq_6] [get_bd_pins ip_28_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_7
connect_bd_net [get_bd_pins ip_28_intc/irq_7] [get_bd_pins ip_28_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_8
connect_bd_net [get_bd_pins ip_28_intc/irq_8] [get_bd_pins ip_28_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_9
connect_bd_net [get_bd_pins ip_28_intc/irq_9] [get_bd_pins ip_28_intc/concat_0/In9]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_28_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_28_intc/irq] [get_bd_intf_pins ip_28_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_29_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_29_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 11 CONFIG.NUM_SI 3 " [get_bd_cells ip_29_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axi_legacy/clk
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_29_axi_legacy/reset
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_M0] [get_bd_intf_pins ip_29_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_M1] [get_bd_intf_pins ip_29_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_M2] [get_bd_intf_pins ip_29_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S0] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S1] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S2] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S3] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S4] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S5] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S6] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S7] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S8] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S9] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S10] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M10_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_30_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_30_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_30_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_30_axis_broadcaster/aclk] [get_bd_pins ip_30_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_30_axis_broadcaster/aresetn] [get_bd_pins ip_30_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_31_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_31_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_31_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_31_axis_broadcaster/aclk] [get_bd_pins ip_31_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_31_axis_broadcaster/aresetn] [get_bd_pins ip_31_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_32_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_32_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 6 " [get_bd_cells ip_32_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_32_axis_broadcaster/aclk] [get_bd_pins ip_32_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_32_axis_broadcaster/aresetn] [get_bd_pins ip_32_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M03_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_4
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_4] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M04_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_5
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_5] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M05_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_33_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_33_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_33_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_33_axis_broadcaster/aclk] [get_bd_pins ip_33_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_33_axis_broadcaster/aresetn] [get_bd_pins ip_33_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_34_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_34_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_34_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_34_axis_broadcaster/aclk] [get_bd_pins ip_34_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_34_axis_broadcaster/aresetn] [get_bd_pins ip_34_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_35_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_35_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_35_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_35_axis_broadcaster/aclk] [get_bd_pins ip_35_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_35_axis_broadcaster/aresetn] [get_bd_pins ip_35_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_36_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_36_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_36_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_36_axis_broadcaster/aclk] [get_bd_pins ip_36_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_36_axis_broadcaster/aresetn] [get_bd_pins ip_36_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_37_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_37_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_37_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_37_axis_broadcaster/aclk] [get_bd_pins ip_37_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_37_axis_broadcaster/aresetn] [get_bd_pins ip_37_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_38_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_38_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_38_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_38_axis_broadcaster/aclk] [get_bd_pins ip_38_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_38_axis_broadcaster/aresetn] [get_bd_pins ip_38_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_39_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_39_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_39_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_39_axis_broadcaster/aclk] [get_bd_pins ip_39_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_39_axis_broadcaster/aresetn] [get_bd_pins ip_39_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_40_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_40_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_40_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_40_axis_dwidth_converter/aclk] [get_bd_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_40_axis_dwidth_converter/aresetn] [get_bd_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_41_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_41_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aclk] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aresetn] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_42_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_42_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aclk] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aresetn] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_43_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_43_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_43_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_43_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_43_axis_dwidth_converter/aclk] [get_bd_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_43_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_43_axis_dwidth_converter/aresetn] [get_bd_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_43_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_43_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_44_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_44_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_44_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aclk] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aresetn] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_45_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_45_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_45_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aclk] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aresetn] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_46_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_46_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_46_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aclk] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aresetn] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_47_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_47_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_47_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aclk] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aresetn] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_48_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_48_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_48_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_48_axis_dwidth_converter/aclk] [get_bd_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_48_axis_dwidth_converter/aresetn] [get_bd_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_49_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_49_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 3 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_49_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aclk] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aresetn] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_50_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_50_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 48 " [get_bd_cells ip_50_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_50_axis_dwidth_converter/aclk] [get_bd_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_50_axis_dwidth_converter/aresetn] [get_bd_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_51_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_51_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 9 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_51_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_51_axis_dwidth_converter/aclk] [get_bd_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_51_axis_dwidth_converter/aresetn] [get_bd_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_52_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_52_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_52_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_52_axis_combiner/aclk] [get_bd_pins ip_52_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_52_axis_combiner/aresetn] [get_bd_pins ip_52_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_combiner/M_AXIS] [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_53_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_53_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_53_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_53_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_53_axis_dwidth_converter/aclk] [get_bd_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_53_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_53_axis_dwidth_converter/aresetn] [get_bd_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_54_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_54_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_54_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_54_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_54_axis_dwidth_converter/aclk] [get_bd_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_54_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_54_axis_dwidth_converter/aresetn] [get_bd_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_55_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_55_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_55_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_55_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_55_axis_combiner/aclk] [get_bd_pins ip_55_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_55_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_55_axis_combiner/aresetn] [get_bd_pins ip_55_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_55_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_55_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_55_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_55_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_55_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_55_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_55_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_55_axis_combiner/M_AXIS] [get_bd_intf_pins ip_55_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_56_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_56_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_56_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_56_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_56_axis_dwidth_converter/aclk] [get_bd_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_56_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_56_axis_dwidth_converter/aresetn] [get_bd_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_56_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_56_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_56_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_56_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_57_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_57_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_57_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_57_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_57_axis_combiner/aclk] [get_bd_pins ip_57_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_57_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_57_axis_combiner/aresetn] [get_bd_pins ip_57_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_combiner/M_AXIS] [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_58_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_58_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_58_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_58_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_58_axis_dwidth_converter/aclk] [get_bd_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_58_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_58_axis_dwidth_converter/aresetn] [get_bd_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_58_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_58_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_58_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_58_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_59_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_59_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 7 " [get_bd_cells ip_59_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_59_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_59_axis_combiner/aclk] [get_bd_pins ip_59_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_59_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_59_axis_combiner/aresetn] [get_bd_pins ip_59_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/S_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S03_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/S_AXIS_4
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_4] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S04_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/S_AXIS_5
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_5] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S05_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/S_AXIS_6
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_6] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S06_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/M_AXIS] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_60_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_60_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_60_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_60_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_60_axis_combiner/aclk] [get_bd_pins ip_60_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_60_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_60_axis_combiner/aresetn] [get_bd_pins ip_60_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_60_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_60_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_60_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_60_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_60_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_60_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_60_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_60_axis_combiner/M_AXIS] [get_bd_intf_pins ip_60_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_61_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_61_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_61_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_61_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_61_axis_combiner/aclk] [get_bd_pins ip_61_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_61_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_61_axis_combiner/aresetn] [get_bd_pins ip_61_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_61_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_61_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_61_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_61_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_61_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_61_axis_combiner/M_AXIS] [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_62_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_62_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_62_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_62_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_62_axis_dwidth_converter/aclk] [get_bd_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_62_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_62_axis_dwidth_converter/aresetn] [get_bd_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_62_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_62_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_62_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_62_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_63_slice_and_concat
create_bd_pin -dir O -from 25 -to 0 ip_63_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_63_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_63_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_63_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_63_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_63_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_63_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_1] [get_bd_pins ip_63_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_63_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_2] [get_bd_pins ip_63_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 32 -to 0 ip_63_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_63_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 22 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 33 " [get_bd_cells ip_63_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_3] [get_bd_pins ip_63_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/slice_3/dout] [get_bd_pins ip_63_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_64_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_64_slice_and_concat/out0
create_bd_pin -dir I -from 32 -to 0 ip_64_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_64_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 28 CONFIG.DIN_TO 23 CONFIG.DIN_WIDTH 33 " [get_bd_cells ip_64_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_64_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_64_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_65_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_65_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_65_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_65_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_65_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 32 -to 0 ip_65_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_65_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 29 CONFIG.DIN_WIDTH 33 " [get_bd_cells ip_65_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_65_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/slice_0/dout] [get_bd_pins ip_65_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_1] [get_bd_pins ip_65_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 11 -to 0 ip_65_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_65_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_65_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_2] [get_bd_pins ip_65_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/slice_2/dout] [get_bd_pins ip_65_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_66_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_66_slice_and_concat/out0
create_bd_pin -dir I -from 11 -to 0 ip_66_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_66_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_66_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_67_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_67_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_67_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_67_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_67_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_67_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/slice_0/dout] [get_bd_pins ip_67_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 11 -to 0 ip_67_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_1] [get_bd_pins ip_67_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_68_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_68_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_68_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_68_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_68_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_68_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_68_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_1] [get_bd_pins ip_68_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_68_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_2] [get_bd_pins ip_68_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_68_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_3] [get_bd_pins ip_68_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 8 -to 0 ip_68_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_68_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_68_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_4] [get_bd_pins ip_68_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/slice_4/dout] [get_bd_pins ip_68_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_69_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_69_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_69_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_69_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_69_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_69_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_69_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_69_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/slice_0/dout] [get_bd_pins ip_69_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 8 -to 0 ip_69_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_69_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_69_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_1] [get_bd_pins ip_69_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/slice_1/dout] [get_bd_pins ip_69_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_70_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_70_slice_and_concat/out0
create_bd_pin -dir I -from 8 -to 0 ip_70_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_70_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_70_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_70_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_70_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_71_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_71_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_71_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_71_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_71_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_71_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_71_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_71_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_0] [get_bd_pins ip_71_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/slice_0/dout] [get_bd_pins ip_71_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_71_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_1] [get_bd_pins ip_71_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_71_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_2] [get_bd_pins ip_71_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_71_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_3] [get_bd_pins ip_71_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_71_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_4] [get_bd_pins ip_71_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_71_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_5] [get_bd_pins ip_71_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_71_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_6] [get_bd_pins ip_71_slice_and_concat/concat/In6]


########## slice_and_concat ##########
create_bd_cell -type hier ip_72_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_72_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_72_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_72_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_72_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/in_0] [get_bd_pins ip_72_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_72_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_73_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_73_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_73_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_73_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_73_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/in_0] [get_bd_pins ip_73_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_73_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_74_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_74_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_74_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_74_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_74_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/in_0] [get_bd_pins ip_74_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_74_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_75_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_75_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_75_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_75_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_75_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/in_0] [get_bd_pins ip_75_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_75_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_76_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_76_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_76_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_76_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_76_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/in_0] [get_bd_pins ip_76_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_76_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_77_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_77_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_77_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_77_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_77_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/in_0] [get_bd_pins ip_77_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_77_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_78_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_78_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_78_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_78_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_78_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/in_0] [get_bd_pins ip_78_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/out0] [get_bd_pins ip_78_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_79_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_79_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_79_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_80_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_80_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_80_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_81_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_81_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_81_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_81_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_81_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/in_0] [get_bd_pins ip_81_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/out0] [get_bd_pins ip_81_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_82_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_82_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_82_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_83_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_83_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_83_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_26_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_27_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_0_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_0_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_0_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_11_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_11_emc_EMC_INTF] [get_bd_intf_pins ip_11_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_13_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_iic_IIC] [get_bd_intf_pins ip_13_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_15_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_iic_IIC] [get_bd_intf_pins ip_15_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_18_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite_UART] [get_bd_intf_pins ip_18_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_20_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_20_emc_EMC_INTF] [get_bd_intf_pins ip_20_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_22_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_22_emc_EMC_INTF] [get_bd_intf_pins ip_22_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_23_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_23_gpio_GPIO] [get_bd_intf_pins ip_23_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_28_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_30_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 25 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_63_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 6 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_72_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_73_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_74_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_75_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_76_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_77_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_78_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_81_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_27_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_28_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_0_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_2_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_4_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_8_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_9_cordic/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_11_emc/rst]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_iic/reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_iic/reset]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_16_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_17_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_18_uartlite/reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_20_emc/rst]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_21_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_22_emc/rst]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_23_gpio/rst]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_0_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_2_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_4_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_5_fft/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_6_dft/CLK]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_7_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_7_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_7_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_7_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_8_floating_point/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_9_cordic/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_10_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_11_emc/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_11_emc/rdclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_13_axi_iic/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_14_dft/CLK]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_15_axi_iic/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_16_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_17_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_18_uartlite/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_19_cordic/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_20_emc/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_20_emc/rdclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_21_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_22_emc/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_22_emc/rdclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_23_gpio/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_24_fft/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_25_floating_point/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_26_reset/clk_in]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_locked] [get_bd_pins ip_26_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_28_intc/irq_0] [get_bd_pins ip_0_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_28_intc/irq_1] [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_28_intc/irq_2] [get_bd_pins ip_5_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_28_intc/irq_3] [get_bd_pins ip_7_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_28_intc/irq_4] [get_bd_pins ip_7_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_28_intc/irq_5] [get_bd_pins ip_13_axi_iic/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_6] [get_bd_pins ip_15_axi_iic/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_7] [get_bd_pins ip_18_uartlite/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_8] [get_bd_pins ip_21_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_28_intc/irq_9] [get_bd_pins ip_24_fft/event_frame_started]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_29_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_29_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_29_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_29_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_29_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_emc/AXI] [get_bd_intf_pins ip_29_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_iic/AXI] [get_bd_intf_pins ip_29_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_iic/AXI] [get_bd_intf_pins ip_29_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_uartlite/AXI] [get_bd_intf_pins ip_29_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_emc/AXI] [get_bd_intf_pins ip_29_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axi_timer/S_AXI] [get_bd_intf_pins ip_29_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_emc/AXI] [get_bd_intf_pins ip_29_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_gpio/AXI] [get_bd_intf_pins ip_29_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_intc/AXI] [get_bd_intf_pins ip_29_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_31_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_32_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_fft/M_AXIS_DATA] [get_bd_intf_pins ip_38_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_39_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_floating_point/S_AXIS_A] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_5_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_floating_point/S_AXIS_A] [get_bd_intf_pins ip_50_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_floating_point/S_AXIS_A] [get_bd_intf_pins ip_51_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_53_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_52_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_53_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_54_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_54_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_55_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_55_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_56_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_55_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_56_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_58_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_57_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_58_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_4] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_5] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_6] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_fft/S_AXIS_DATA] [get_bd_intf_pins ip_59_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_60_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_60_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_DATA] [get_bd_intf_pins ip_60_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_61_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_61_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_62_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_61_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_floating_point/S_AXIS_B] [get_bd_intf_pins ip_62_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_1] [get_bd_pins ip_0_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_2] [get_bd_pins ip_0_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_3] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_14_dft/SIZE]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_14_dft/XN_IM]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_1] [get_bd_pins ip_6_dft/RFFD]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_2] [get_bd_pins ip_6_dft/XK_RE]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_6_dft/SIZE]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_6_dft/XK_RE]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_6_dft/XK_RE]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_1] [get_bd_pins ip_6_dft/XK_IM]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_14_dft/XN_RE]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_6_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_1] [get_bd_pins ip_6_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_2] [get_bd_pins ip_6_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_3] [get_bd_pins ip_14_dft/RFFD]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_4] [get_bd_pins ip_14_dft/XK_RE]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_IM]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_14_dft/XK_RE]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_1] [get_bd_pins ip_14_dft/XK_IM]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_1_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_14_dft/XK_IM]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_RE]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_0] [get_bd_pins ip_14_dft/XK_IM]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_1] [get_bd_pins ip_14_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_2] [get_bd_pins ip_14_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_3] [get_bd_pins ip_14_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_4] [get_bd_pins ip_21_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_5] [get_bd_pins ip_21_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_6] [get_bd_pins ip_21_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_14_dft/CE]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_21_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_8_floating_point/aclken]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_21_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_6_dft/FD_IN]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_14_dft/FD_IN]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/out0] [get_bd_pins ip_6_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/CE]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/out0] [get_bd_pins ip_79_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/out0] [get_bd_pins ip_2_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/out0] [get_bd_pins ip_80_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/out0] [get_bd_pins ip_4_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/out0] [get_bd_pins ip_14_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/out0] [get_bd_pins ip_82_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_83_slice_and_concat/out0] [get_bd_pins ip_0_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_83_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_83_slice_and_concat/out0] [get_bd_pins ip_83_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_29_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_48_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_49_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_50_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_51_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_52_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_53_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_54_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_55_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_56_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_57_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_58_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_59_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_60_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_61_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_62_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_28_intc/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_29_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_30_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_31_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_32_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_33_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_34_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_35_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_36_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_37_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_38_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_39_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_45_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_46_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_47_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_48_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_49_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_50_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_51_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_52_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_53_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_54_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_55_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_56_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_57_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_58_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_59_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_60_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_61_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_62_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_A declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_A declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/M_AXIS_DOUT declared=32 actual=ERR $__err" }
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
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 18 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=18 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=18 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_B declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_B declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/M_AXIS_RESULT declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/M_AXIS_RESULT declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_cordic/S_AXIS_CARTESIAN declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_cordic/S_AXIS_CARTESIAN declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_A declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_A declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_cordic/S_AXIS_CARTESIAN declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_cordic/S_AXIS_CARTESIAN declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_cordic/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_cordic/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_fft/S_AXIS_DATA declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_fft/S_AXIS_DATA declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_fft/M_AXIS_DATA declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_fft/M_AXIS_DATA declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_fft/S_AXIS_CONFIG declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_fft/S_AXIS_CONFIG declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 72 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_floating_point/S_AXIS_A declared=72 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_floating_point/S_AXIS_A declared=72 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_3 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_3 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M04_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_4 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_4 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M05_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_5 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_5 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/S_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/S_AXIS declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 72 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/M_AXIS declared=72 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/M_AXIS declared=72 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_55_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_55_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_55_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_55_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_55_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_55_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_55_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_55_axis_combiner/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_55_axis_combiner/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_58_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_58_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_58_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_58_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S03_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_3 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_3 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S04_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_4 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_4 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S05_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_5 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_5 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S06_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_6 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_6 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/M_AXIS declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/M_AXIS declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_60_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_60_axis_combiner/S_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_60_axis_combiner/S_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_60_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_60_axis_combiner/S_AXIS_1 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_60_axis_combiner/S_AXIS_1 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_60_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_60_axis_combiner/M_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_60_axis_combiner/M_AXIS declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_62_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_62_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_62_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_62_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }


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
