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



########## axi_iic ##########
create_bd_cell -type hier ip_0_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_0_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x38 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 147 CONFIG.C_SDA_INERTIAL_DELAY 223 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 353.0079901782345 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_0_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic/IIC] [get_bd_intf_pins ip_0_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_iic/clk
connect_bd_net [get_bd_pins ip_0_axi_iic/clk] [get_bd_pins ip_0_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_iic/reset
connect_bd_net [get_bd_pins ip_0_axi_iic/reset] [get_bd_pins ip_0_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_0_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_iic/irq
connect_bd_net [get_bd_pins ip_0_axi_iic/irq] [get_bd_pins ip_0_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_1_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_1_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 59 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 256 CONFIG.C_S2MM_BURST_SIZE 128 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 20 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 256 " [get_bd_cells ip_1_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_1_axi_dma/axi_resetn] [get_bd_pins ip_1_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_1_axi_dma/s2mm_introut] [get_bd_pins ip_1_axi_dma/axi_dma_0/s2mm_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_2_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_2_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 63 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 9 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_2_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_2_axi_dma/axi_resetn] [get_bd_pins ip_2_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXI] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_2_axi_dma/mm2s_introut] [get_bd_pins ip_2_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_2_axi_dma/s2mm_introut] [get_bd_pins ip_2_axi_dma/axi_dma_0/s2mm_introut]


########## xadc_wiz ##########
create_bd_cell -type hier ip_3_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_3_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 0 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_3_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_3_xadc_wiz/dclk_in] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/ot_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/eoc_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/eos_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/alarm_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/busy_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_3_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_3_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_3_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## dft ##########
create_bd_cell -type hier ip_4_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_4_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 8 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_4_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CLK
connect_bd_net [get_bd_pins ip_4_dft/CLK] [get_bd_pins ip_4_dft/dft_0/CLK]
create_bd_pin -dir I -from 7 -to 0 ip_4_dft/XN_RE
connect_bd_net [get_bd_pins ip_4_dft/XN_RE] [get_bd_pins ip_4_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 7 -to 0 ip_4_dft/XN_IM
connect_bd_net [get_bd_pins ip_4_dft/XN_IM] [get_bd_pins ip_4_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FD_IN
connect_bd_net [get_bd_pins ip_4_dft/FD_IN] [get_bd_pins ip_4_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FWD_INV
connect_bd_net [get_bd_pins ip_4_dft/FWD_INV] [get_bd_pins ip_4_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_4_dft/SIZE
connect_bd_net [get_bd_pins ip_4_dft/SIZE] [get_bd_pins ip_4_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/RFFD
connect_bd_net [get_bd_pins ip_4_dft/RFFD] [get_bd_pins ip_4_dft/dft_0/RFFD]
create_bd_pin -dir O -from 7 -to 0 ip_4_dft/XK_RE
connect_bd_net [get_bd_pins ip_4_dft/XK_RE] [get_bd_pins ip_4_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 7 -to 0 ip_4_dft/XK_IM
connect_bd_net [get_bd_pins ip_4_dft/XK_IM] [get_bd_pins ip_4_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_4_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_4_dft/BLK_EXP] [get_bd_pins ip_4_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/FD_OUT
connect_bd_net [get_bd_pins ip_4_dft/FD_OUT] [get_bd_pins ip_4_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_4_dft/DATA_VALID] [get_bd_pins ip_4_dft/dft_0/DATA_VALID]


########## conv_encoder ##########
create_bd_cell -type hier ip_5_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_5_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 3 CONFIG.convolution_code0 1 CONFIG.convolution_code1 4 CONFIG.convolution_code2 3 CONFIG.convolution_code3 1 CONFIG.convolution_code4 1 CONFIG.convolution_code5 5 CONFIG.convolution_code6 3 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 4 CONFIG.output_rate 6 CONFIG.puncture_code0 0111 CONFIG.puncture_code1 0111 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_5_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_5_conv_encoder/aclk] [get_bd_pins ip_5_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_5_conv_encoder/aresetn] [get_bd_pins ip_5_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## reset ##########
create_bd_cell -type hier ip_6_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_6_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_reset/clk_in
connect_bd_net [get_bd_pins ip_6_reset/clk_in] [get_bd_pins ip_6_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_6_reset/reset_in
connect_bd_net [get_bd_pins ip_6_reset/reset_in] [get_bd_pins ip_6_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_6_reset/dcm_locked
connect_bd_net [get_bd_pins ip_6_reset/dcm_locked] [get_bd_pins ip_6_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_6_reset/mb_reset
connect_bd_net [get_bd_pins ip_6_reset/mb_reset] [get_bd_pins ip_6_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_6_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_6_reset/peripheral_areset_n] [get_bd_pins ip_6_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_6_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_6_reset/peripheral_areset] [get_bd_pins ip_6_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_6_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_6_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_7_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_7_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_in] [get_bd_pins ip_7_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_7_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_7_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_7_clk_wiz/reset
connect_bd_net [get_bd_pins ip_7_clk_wiz/reset] [get_bd_pins ip_7_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_7_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_locked] [get_bd_pins ip_7_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_8_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_8_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_8_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_8_intc/concat_0]
connect_bd_net [get_bd_pins ip_8_intc/concat_0/dout] [get_bd_pins ip_8_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_8_intc/clk
connect_bd_net [get_bd_pins ip_8_intc/clk] [get_bd_pins ip_8_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_intc/reset
connect_bd_net [get_bd_pins ip_8_intc/reset] [get_bd_pins ip_8_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_intc/AXI] [get_bd_intf_pins ip_8_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_8_intc/irq_0
connect_bd_net [get_bd_pins ip_8_intc/irq_0] [get_bd_pins ip_8_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_8_intc/irq_1
connect_bd_net [get_bd_pins ip_8_intc/irq_1] [get_bd_pins ip_8_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_8_intc/irq_2
connect_bd_net [get_bd_pins ip_8_intc/irq_2] [get_bd_pins ip_8_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_8_intc/irq_3
connect_bd_net [get_bd_pins ip_8_intc/irq_3] [get_bd_pins ip_8_intc/concat_0/In3]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_8_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_8_intc/irq] [get_bd_intf_pins ip_8_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_9_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_9_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 2 " [get_bd_cells ip_9_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi/clk
connect_bd_net [get_bd_pins ip_9_axi/clk] [get_bd_pins ip_9_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi/reset
connect_bd_net [get_bd_pins ip_9_axi/reset] [get_bd_pins ip_9_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_9_axi/AXI_M0] [get_bd_intf_pins ip_9_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_9_axi/AXI_M1] [get_bd_intf_pins ip_9_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_9_axi/AXI_S0] [get_bd_intf_pins ip_9_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_9_axi/AXI_S1] [get_bd_intf_pins ip_9_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_9_axi/AXI_S2] [get_bd_intf_pins ip_9_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_9_axi/AXI_S3] [get_bd_intf_pins ip_9_axi/axi_0/M03_AXI]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_10_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_10_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_10_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_11_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aclk] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aresetn] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_12_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_12_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 32 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_12_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_12_axis_dwidth_converter/aclk] [get_bd_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_12_axis_dwidth_converter/aresetn] [get_bd_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_13_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_13_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_13_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_13_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_13_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_13_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_2] [get_bd_pins ip_13_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_3] [get_bd_pins ip_13_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 7 -to 0 ip_13_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_13_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_4] [get_bd_pins ip_13_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/slice_4/dout] [get_bd_pins ip_13_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_14_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_14_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_14_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_14_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 7 -to 0 ip_14_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_14_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_14_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/slice_0/dout] [get_bd_pins ip_14_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 7 -to 0 ip_14_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_14_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_1] [get_bd_pins ip_14_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/slice_1/dout] [get_bd_pins ip_14_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 3 -to 0 ip_15_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_15_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_15_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_15_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_16_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_16_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 7 -to 0 ip_16_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_16_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/slice_0/dout] [get_bd_pins ip_16_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_16_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_16_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_16_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_3] [get_bd_pins ip_16_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 1 -to 0 ip_17_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_17_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_17_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_19_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_7_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic_IIC] [get_bd_intf_pins ip_0_axi_iic/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_3_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_3_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_3_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_8_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 3 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_15_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir O -from 1 -to 0 control_O
connect_bd_net [get_bd_pins control_O] [get_bd_pins ip_17_slice_and_concat/out0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_6_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_iic/reset]
connect_bd_net [get_bd_pins ip_6_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_6_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_5_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_0_axi_iic/clk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_3_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_4_dft/CLK]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_5_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_6_reset/clk_in]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_locked] [get_bd_pins ip_6_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_8_intc/irq_0] [get_bd_pins ip_0_axi_iic/irq]
connect_bd_net [get_bd_pins ip_8_intc/irq_1] [get_bd_pins ip_1_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_8_intc/irq_2] [get_bd_pins ip_2_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_8_intc/irq_3] [get_bd_pins ip_2_axi_dma/s2mm_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_9_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/M_AXI] [get_bd_intf_pins ip_9_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_9_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_9_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_9_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_intc/AXI] [get_bd_intf_pins ip_9_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_5_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_2_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_RE]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_3_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_3_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_2] [get_bd_pins ip_3_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_3] [get_bd_pins ip_4_dft/RFFD]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_4] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_4_dft/SIZE]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_1] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_IM]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_4_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_4_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_3] [get_bd_pins ip_4_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_3_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_3_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_4_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_3_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_4_dft/FD_IN]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_3_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_9_axi/reset]
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_10_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_11_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_12_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_8_intc/clk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_9_axi/clk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_10_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_11_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_12_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/S_AXIS_S2MM declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/S_AXIS_S2MM declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=256 actual=ERR $__err" }


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
