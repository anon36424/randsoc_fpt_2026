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
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x39 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 168 CONFIG.C_SDA_INERTIAL_DELAY 50 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 452.0276950062133 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_0_axi_iic/axi_iic_0]
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


########## dft ##########
create_bd_cell -type hier ip_1_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_1_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 9 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_1_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CLK
connect_bd_net [get_bd_pins ip_1_dft/CLK] [get_bd_pins ip_1_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CE
connect_bd_net [get_bd_pins ip_1_dft/CE] [get_bd_pins ip_1_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/SCLR
connect_bd_net [get_bd_pins ip_1_dft/SCLR] [get_bd_pins ip_1_dft/dft_0/SCLR]
create_bd_pin -dir I -from 8 -to 0 ip_1_dft/XN_RE
connect_bd_net [get_bd_pins ip_1_dft/XN_RE] [get_bd_pins ip_1_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 8 -to 0 ip_1_dft/XN_IM
connect_bd_net [get_bd_pins ip_1_dft/XN_IM] [get_bd_pins ip_1_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FD_IN
connect_bd_net [get_bd_pins ip_1_dft/FD_IN] [get_bd_pins ip_1_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FWD_INV
connect_bd_net [get_bd_pins ip_1_dft/FWD_INV] [get_bd_pins ip_1_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_1_dft/SIZE
connect_bd_net [get_bd_pins ip_1_dft/SIZE] [get_bd_pins ip_1_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/RFFD
connect_bd_net [get_bd_pins ip_1_dft/RFFD] [get_bd_pins ip_1_dft/dft_0/RFFD]
create_bd_pin -dir O -from 8 -to 0 ip_1_dft/XK_RE
connect_bd_net [get_bd_pins ip_1_dft/XK_RE] [get_bd_pins ip_1_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 8 -to 0 ip_1_dft/XK_IM
connect_bd_net [get_bd_pins ip_1_dft/XK_IM] [get_bd_pins ip_1_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_1_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_1_dft/BLK_EXP] [get_bd_pins ip_1_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/FD_OUT
connect_bd_net [get_bd_pins ip_1_dft/FD_OUT] [get_bd_pins ip_1_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_1_dft/DATA_VALID] [get_bd_pins ip_1_dft/dft_0/DATA_VALID]


########## xadc_wiz ##########
create_bd_cell -type hier ip_2_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_2_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_TEMP_BUS 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_2_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_2_xadc_wiz/s_axi_aclk] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_2_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_2_xadc_wiz/convstclk_in] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_2_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/eoc_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/eos_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/busy_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 11 -to 0 ip_2_xadc_wiz/temp_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/temp_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/temp_out]


########## fft ##########
create_bd_cell -type hier ip_3_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_3_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 12 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 16 " [get_bd_cells ip_3_fft/fft_0]
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


########## axi_cdma ##########
create_bd_cell -type hier ip_4_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_4_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 33 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_4_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_4_axi_cdma/m_axi_aclk] [get_bd_pins ip_4_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_4_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_4_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_4_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_4_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_cdma/M_AXI] [get_bd_intf_pins ip_4_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_4_axi_cdma/cdma_introut] [get_bd_pins ip_4_axi_cdma/axi_cdma_0/cdma_introut]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 1200 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Odd " [get_bd_cells ip_5_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite/UART] [get_bd_intf_pins ip_5_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_5_uartlite/clk
connect_bd_net [get_bd_pins ip_5_uartlite/clk] [get_bd_pins ip_5_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_uartlite/reset
connect_bd_net [get_bd_pins ip_5_uartlite/reset] [get_bd_pins ip_5_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_5_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_5_uartlite/irq
connect_bd_net [get_bd_pins ip_5_uartlite/irq] [get_bd_pins ip_5_uartlite/uart_0/interrupt]


########## cordic ##########
create_bd_cell -type hier ip_6_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_6_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tan CONFIG.Input_Width 11 CONFIG.Iterations 36 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 17 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 28 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_6_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_cordic/aclk
connect_bd_net [get_bd_pins ip_6_cordic/aclk] [get_bd_pins ip_6_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_cordic/aclken
connect_bd_net [get_bd_pins ip_6_cordic/aclken] [get_bd_pins ip_6_cordic/cordic_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_6_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_6_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_6_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_6_cordic/cordic_0/M_AXIS_DOUT]


########## axi_cdma ##########
create_bd_cell -type hier ip_7_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_7_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 47 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_7_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_7_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_7_axi_cdma/m_axi_aclk] [get_bd_pins ip_7_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_7_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_7_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_7_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_7_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_cdma/M_AXI] [get_bd_intf_pins ip_7_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_7_axi_cdma/cdma_introut] [get_bd_pins ip_7_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_hwicap ##########
create_bd_cell -type hier ip_8_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_8_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 1 CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_8_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_8_axi_hwicap/icap_clk] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_8_axi_hwicap/eos_in] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_8_axi_hwicap/s_axi_aclk] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_8_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_8_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_8_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap/ICAP] [get_bd_intf_pins ip_8_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_8_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_8_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## axi_timer ##########
create_bd_cell -type hier ip_9_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_9_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 8 CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_9_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_timer/S_AXI] [get_bd_intf_pins ip_9_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_9_axi_timer/capturetrig0] [get_bd_pins ip_9_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_9_axi_timer/capturetrig1] [get_bd_pins ip_9_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/freeze
connect_bd_net [get_bd_pins ip_9_axi_timer/freeze] [get_bd_pins ip_9_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_9_axi_timer/s_axi_aclk] [get_bd_pins ip_9_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_9_axi_timer/s_axi_aresetn] [get_bd_pins ip_9_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_9_axi_timer/generateout0] [get_bd_pins ip_9_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_9_axi_timer/generateout1] [get_bd_pins ip_9_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_9_axi_timer/pwm0] [get_bd_pins ip_9_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_9_axi_timer/interrupt] [get_bd_pins ip_9_axi_timer/axi_timer_0/interrupt]


########## floating_point ##########
create_bd_cell -type hier ip_10_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_10_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.a_tuser_width 95 CONFIG.add_sub_value Both CONFIG.c_a_exponent_width 8 CONFIG.c_a_fraction_width 37 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Absolute " [get_bd_cells ip_10_floating_point/floating_point_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_10_floating_point/S_AXIS_A] [get_bd_intf_pins ip_10_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_10_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_10_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_iic ##########
create_bd_cell -type hier ip_11_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_11_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x4 CONFIG.C_GPO_WIDTH 3 CONFIG.C_SCL_INERTIAL_DELAY 23 CONFIG.C_SDA_INERTIAL_DELAY 149 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 290.2010150771685 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_11_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_11_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_iic/IIC] [get_bd_intf_pins ip_11_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_iic/clk
connect_bd_net [get_bd_pins ip_11_axi_iic/clk] [get_bd_pins ip_11_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_iic/reset
connect_bd_net [get_bd_pins ip_11_axi_iic/reset] [get_bd_pins ip_11_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_iic/AXI] [get_bd_intf_pins ip_11_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_iic/irq
connect_bd_net [get_bd_pins ip_11_axi_iic/irq] [get_bd_pins ip_11_axi_iic/axi_iic_0/iic2intc_irpt]


########## floating_point ##########
create_bd_cell -type hier ip_12_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_12_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Double CONFIG.a_tuser_width 89 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_divide_by_zero 1 CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage Medium_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Logarithm " [get_bd_cells ip_12_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_floating_point/aclk
connect_bd_net [get_bd_pins ip_12_floating_point/aclk] [get_bd_pins ip_12_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_floating_point/aclken
connect_bd_net [get_bd_pins ip_12_floating_point/aclken] [get_bd_pins ip_12_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_12_floating_point/aresetn
connect_bd_net [get_bd_pins ip_12_floating_point/aresetn] [get_bd_pins ip_12_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_12_floating_point/S_AXIS_A] [get_bd_intf_pins ip_12_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_12_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_12_floating_point/floating_point_0/M_AXIS_RESULT]


########## complex_multiplier ##########
create_bd_cell -type hier ip_13_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_13_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 27 CONFIG.aresetn 1 CONFIG.atuserwidth 214 CONFIG.bportwidth 35 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 55 CONFIG.outtlastbehv AND_all_TLASTs CONFIG.roundmode Truncate " [get_bd_cells ip_13_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_13_complex_multiplier/aclk] [get_bd_pins ip_13_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_13_complex_multiplier/aresetn] [get_bd_pins ip_13_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## fft ##########
create_bd_cell -type hier ip_14_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_14_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 1 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 2048 " [get_bd_cells ip_14_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_fft/aclk
connect_bd_net [get_bd_pins ip_14_fft/aclk] [get_bd_pins ip_14_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_14_fft/event_frame_started
connect_bd_net [get_bd_pins ip_14_fft/event_frame_started] [get_bd_pins ip_14_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_14_fft/S_AXIS_DATA] [get_bd_intf_pins ip_14_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_14_fft/M_AXIS_DATA] [get_bd_intf_pins ip_14_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_14_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_14_fft/fft_0/S_AXIS_CONFIG]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_15_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_15_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_15_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_15_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi/IIC] [get_bd_intf_pins ip_15_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/clk] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/reset] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/clk4] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/reset4] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_15_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_15_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/irq] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## axi_iic ##########
create_bd_cell -type hier ip_16_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_16_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x49 CONFIG.C_GPO_WIDTH 7 CONFIG.C_SCL_INERTIAL_DELAY 246 CONFIG.C_SDA_INERTIAL_DELAY 183 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 856.6312386459582 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_16_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_16_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_iic/IIC] [get_bd_intf_pins ip_16_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_iic/clk
connect_bd_net [get_bd_pins ip_16_axi_iic/clk] [get_bd_pins ip_16_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_iic/reset
connect_bd_net [get_bd_pins ip_16_axi_iic/reset] [get_bd_pins ip_16_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_iic/AXI] [get_bd_intf_pins ip_16_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_iic/irq
connect_bd_net [get_bd_pins ip_16_axi_iic/irq] [get_bd_pins ip_16_axi_iic/axi_iic_0/iic2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_17_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_17_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x1a883 CONFIG.C_GPIO2_WIDTH 31 CONFIG.C_GPIO_WIDTH 17 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x0 CONFIG.C_TRI_DEFAULT_2 0x17e0a " [get_bd_cells ip_17_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/GPIO] [get_bd_intf_pins ip_17_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/GPIO2] [get_bd_intf_pins ip_17_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_17_gpio/clk
connect_bd_net [get_bd_pins ip_17_gpio/clk] [get_bd_pins ip_17_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_gpio/rst
connect_bd_net [get_bd_pins ip_17_gpio/rst] [get_bd_pins ip_17_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/AXI] [get_bd_intf_pins ip_17_gpio/gpio_0/S_AXI]


########## complex_multiplier ##########
create_bd_cell -type hier ip_18_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_18_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 16 CONFIG.aresetn 1 CONFIG.atuserwidth 73 CONFIG.bportwidth 37 CONFIG.btuserwidth 240 CONFIG.ctrltuserwidth 134 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 25 CONFIG.roundmode Random_Rounding " [get_bd_cells ip_18_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_18_complex_multiplier/aclk] [get_bd_pins ip_18_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_18_complex_multiplier/aresetn] [get_bd_pins ip_18_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_18_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## uartlite ##########
create_bd_cell -type hier ip_19_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_19_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 9600 CONFIG.C_DATA_BITS 7 CONFIG.PARITY No_Parity " [get_bd_cells ip_19_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_19_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_19_uartlite/UART] [get_bd_intf_pins ip_19_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_19_uartlite/clk
connect_bd_net [get_bd_pins ip_19_uartlite/clk] [get_bd_pins ip_19_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_uartlite/reset
connect_bd_net [get_bd_pins ip_19_uartlite/reset] [get_bd_pins ip_19_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_uartlite/AXI] [get_bd_intf_pins ip_19_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_19_uartlite/irq
connect_bd_net [get_bd_pins ip_19_uartlite/irq] [get_bd_pins ip_19_uartlite/uart_0/interrupt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_20_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_20_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 26 CONFIG.aresetn 0 CONFIG.atuserwidth 212 CONFIG.bportwidth 27 CONFIG.btuserwidth 246 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 17 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_20_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_20_complex_multiplier/aclk] [get_bd_pins ip_20_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_20_complex_multiplier/aclken] [get_bd_pins ip_20_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_20_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_20_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_20_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## dft ##########
create_bd_cell -type hier ip_21_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_21_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 17 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_21_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/CLK
connect_bd_net [get_bd_pins ip_21_dft/CLK] [get_bd_pins ip_21_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/SCLR
connect_bd_net [get_bd_pins ip_21_dft/SCLR] [get_bd_pins ip_21_dft/dft_0/SCLR]
create_bd_pin -dir I -from 16 -to 0 ip_21_dft/XN_RE
connect_bd_net [get_bd_pins ip_21_dft/XN_RE] [get_bd_pins ip_21_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 16 -to 0 ip_21_dft/XN_IM
connect_bd_net [get_bd_pins ip_21_dft/XN_IM] [get_bd_pins ip_21_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/FD_IN
connect_bd_net [get_bd_pins ip_21_dft/FD_IN] [get_bd_pins ip_21_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/FWD_INV
connect_bd_net [get_bd_pins ip_21_dft/FWD_INV] [get_bd_pins ip_21_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_21_dft/SIZE
connect_bd_net [get_bd_pins ip_21_dft/SIZE] [get_bd_pins ip_21_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_21_dft/RFFD
connect_bd_net [get_bd_pins ip_21_dft/RFFD] [get_bd_pins ip_21_dft/dft_0/RFFD]
create_bd_pin -dir O -from 16 -to 0 ip_21_dft/XK_RE
connect_bd_net [get_bd_pins ip_21_dft/XK_RE] [get_bd_pins ip_21_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 16 -to 0 ip_21_dft/XK_IM
connect_bd_net [get_bd_pins ip_21_dft/XK_IM] [get_bd_pins ip_21_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_21_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_21_dft/BLK_EXP] [get_bd_pins ip_21_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_21_dft/FD_OUT
connect_bd_net [get_bd_pins ip_21_dft/FD_OUT] [get_bd_pins ip_21_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_21_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_21_dft/DATA_VALID] [get_bd_pins ip_21_dft/dft_0/DATA_VALID]


########## conv_encoder ##########
create_bd_cell -type hier ip_22_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_22_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 9 CONFIG.convolution_code0 245 CONFIG.convolution_code1 103 CONFIG.convolution_code2 70 CONFIG.convolution_code3 427 CONFIG.convolution_code4 379 CONFIG.convolution_code5 107 CONFIG.convolution_code6 320 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 9 CONFIG.output_rate 11 CONFIG.puncture_code0 011101110 CONFIG.puncture_code1 000111110 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_22_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_22_conv_encoder/aclk] [get_bd_pins ip_22_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_22_conv_encoder/aclken] [get_bd_pins ip_22_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_22_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_22_conv_encoder/aresetn] [get_bd_pins ip_22_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_22_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_22_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_22_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_22_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## dft ##########
create_bd_cell -type hier ip_23_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_23_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 13 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_23_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_dft/CLK
connect_bd_net [get_bd_pins ip_23_dft/CLK] [get_bd_pins ip_23_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_23_dft/CE
connect_bd_net [get_bd_pins ip_23_dft/CE] [get_bd_pins ip_23_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_23_dft/SCLR
connect_bd_net [get_bd_pins ip_23_dft/SCLR] [get_bd_pins ip_23_dft/dft_0/SCLR]
create_bd_pin -dir I -from 12 -to 0 ip_23_dft/XN_RE
connect_bd_net [get_bd_pins ip_23_dft/XN_RE] [get_bd_pins ip_23_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 12 -to 0 ip_23_dft/XN_IM
connect_bd_net [get_bd_pins ip_23_dft/XN_IM] [get_bd_pins ip_23_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_23_dft/FD_IN
connect_bd_net [get_bd_pins ip_23_dft/FD_IN] [get_bd_pins ip_23_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_23_dft/FWD_INV
connect_bd_net [get_bd_pins ip_23_dft/FWD_INV] [get_bd_pins ip_23_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_23_dft/SIZE
connect_bd_net [get_bd_pins ip_23_dft/SIZE] [get_bd_pins ip_23_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_23_dft/RFFD
connect_bd_net [get_bd_pins ip_23_dft/RFFD] [get_bd_pins ip_23_dft/dft_0/RFFD]
create_bd_pin -dir O -from 12 -to 0 ip_23_dft/XK_RE
connect_bd_net [get_bd_pins ip_23_dft/XK_RE] [get_bd_pins ip_23_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 12 -to 0 ip_23_dft/XK_IM
connect_bd_net [get_bd_pins ip_23_dft/XK_IM] [get_bd_pins ip_23_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_23_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_23_dft/BLK_EXP] [get_bd_pins ip_23_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_23_dft/FD_OUT
connect_bd_net [get_bd_pins ip_23_dft/FD_OUT] [get_bd_pins ip_23_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_23_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_23_dft/DATA_VALID] [get_bd_pins ip_23_dft/dft_0/DATA_VALID]


########## reset ##########
create_bd_cell -type hier ip_24_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_24_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_reset/clk_in
connect_bd_net [get_bd_pins ip_24_reset/clk_in] [get_bd_pins ip_24_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_24_reset/reset_in
connect_bd_net [get_bd_pins ip_24_reset/reset_in] [get_bd_pins ip_24_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_24_reset/dcm_locked
connect_bd_net [get_bd_pins ip_24_reset/dcm_locked] [get_bd_pins ip_24_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_24_reset/mb_reset
connect_bd_net [get_bd_pins ip_24_reset/mb_reset] [get_bd_pins ip_24_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_24_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_24_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_24_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset] [get_bd_pins ip_24_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_24_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_24_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_25_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_25_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_in] [get_bd_pins ip_25_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_25_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_25_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_25_clk_wiz/reset
connect_bd_net [get_bd_pins ip_25_clk_wiz/reset] [get_bd_pins ip_25_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_25_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_locked] [get_bd_pins ip_25_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_26_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_26_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_26_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 13 " [get_bd_cells ip_26_intc/concat_0]
connect_bd_net [get_bd_pins ip_26_intc/concat_0/dout] [get_bd_pins ip_26_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/clk
connect_bd_net [get_bd_pins ip_26_intc/clk] [get_bd_pins ip_26_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/reset
connect_bd_net [get_bd_pins ip_26_intc/reset] [get_bd_pins ip_26_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_26_intc/AXI] [get_bd_intf_pins ip_26_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_0
connect_bd_net [get_bd_pins ip_26_intc/irq_0] [get_bd_pins ip_26_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_1
connect_bd_net [get_bd_pins ip_26_intc/irq_1] [get_bd_pins ip_26_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_2
connect_bd_net [get_bd_pins ip_26_intc/irq_2] [get_bd_pins ip_26_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_3
connect_bd_net [get_bd_pins ip_26_intc/irq_3] [get_bd_pins ip_26_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_4
connect_bd_net [get_bd_pins ip_26_intc/irq_4] [get_bd_pins ip_26_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_5
connect_bd_net [get_bd_pins ip_26_intc/irq_5] [get_bd_pins ip_26_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_6
connect_bd_net [get_bd_pins ip_26_intc/irq_6] [get_bd_pins ip_26_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_7
connect_bd_net [get_bd_pins ip_26_intc/irq_7] [get_bd_pins ip_26_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_8
connect_bd_net [get_bd_pins ip_26_intc/irq_8] [get_bd_pins ip_26_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_9
connect_bd_net [get_bd_pins ip_26_intc/irq_9] [get_bd_pins ip_26_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_10
connect_bd_net [get_bd_pins ip_26_intc/irq_10] [get_bd_pins ip_26_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_11
connect_bd_net [get_bd_pins ip_26_intc/irq_11] [get_bd_pins ip_26_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_26_intc/irq_12
connect_bd_net [get_bd_pins ip_26_intc/irq_12] [get_bd_pins ip_26_intc/concat_0/In12]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_26_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_26_intc/irq] [get_bd_intf_pins ip_26_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_27_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_27_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 13 CONFIG.NUM_SI 2 " [get_bd_cells ip_27_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axi_legacy/clk
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_27_axi_legacy/reset
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_M0] [get_bd_intf_pins ip_27_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_M1] [get_bd_intf_pins ip_27_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S0] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S1] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S2] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S3] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S4] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S5] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S6] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S7] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S8] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S9] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S10] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S11] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_legacy/AXI_S12] [get_bd_intf_pins ip_27_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_27_axi_legacy/clk] [get_bd_pins ip_27_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_27_axi_legacy/reset] [get_bd_pins ip_27_axi_legacy/axi_0/M12_ARESETN]


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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_29_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_29_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_29_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_29_axis_broadcaster/aclk] [get_bd_pins ip_29_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_29_axis_broadcaster/aresetn] [get_bd_pins ip_29_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_30_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_30_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_30_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_31_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_31_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_31_axis_broadcaster/axis_broadcaster_0]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_32_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_32_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_32_axis_broadcaster/axis_broadcaster_0]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_33_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_33_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_33_axis_broadcaster/axis_broadcaster_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_34_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_34_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_34_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aclk] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aresetn] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_35_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_35_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_35_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_35_axis_dwidth_converter/aclk] [get_bd_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_35_axis_dwidth_converter/aresetn] [get_bd_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_36_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_36_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_36_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_36_axis_dwidth_converter/aclk] [get_bd_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_36_axis_dwidth_converter/aresetn] [get_bd_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_37_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_37_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_37_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aclk] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aresetn] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_38_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_38_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_38_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_38_axis_dwidth_converter/aclk] [get_bd_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_38_axis_dwidth_converter/aresetn] [get_bd_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_39_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_39_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 48 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aclk] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aresetn] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_40_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_40_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 48 " [get_bd_cells ip_40_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 3 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 3 " [get_bd_cells ip_43_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_44_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aclk] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aresetn] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_45_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_45_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_45_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_45_axis_combiner/aclk] [get_bd_pins ip_45_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_45_axis_combiner/aresetn] [get_bd_pins ip_45_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_combiner/M_AXIS] [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_46_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_46_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_46_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aclk] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aresetn] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_47_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_47_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_47_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_47_axis_combiner/aclk] [get_bd_pins ip_47_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_47_axis_combiner/aresetn] [get_bd_pins ip_47_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_combiner/M_AXIS] [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_48_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_48_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_48_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_49_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aclk] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aresetn] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_50_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_50_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_50_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_50_axis_combiner/aclk] [get_bd_pins ip_50_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_50_axis_combiner/aresetn] [get_bd_pins ip_50_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/M_AXIS] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_51_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_51_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_51_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_51_axis_dwidth_converter/aclk] [get_bd_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_51_axis_dwidth_converter/aresetn] [get_bd_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_52_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_52_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_52_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_52_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_52_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 8 -to 0 ip_52_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_52_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_52_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_1] [get_bd_pins ip_52_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/slice_1/dout] [get_bd_pins ip_52_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_53_slice_and_concat/out0
create_bd_pin -dir I -from 8 -to 0 ip_53_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_53_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_53_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_54_slice_and_concat/out0
create_bd_pin -dir I -from 8 -to 0 ip_54_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_54_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_54_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_55_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_55_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_55_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_55_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_55_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/slice_0/dout] [get_bd_pins ip_55_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_55_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_1] [get_bd_pins ip_55_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_2] [get_bd_pins ip_55_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_3] [get_bd_pins ip_55_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_4] [get_bd_pins ip_55_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_5] [get_bd_pins ip_55_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_6] [get_bd_pins ip_55_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 11 -to 0 ip_55_slice_and_concat/in_7
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_55_slice_and_concat/slice_7]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_7] [get_bd_pins ip_55_slice_and_concat/slice_7/din]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/slice_7/dout] [get_bd_pins ip_55_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_56_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_56_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_56_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_56_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_56_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/slice_0/dout] [get_bd_pins ip_56_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_1] [get_bd_pins ip_56_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_2] [get_bd_pins ip_56_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_3] [get_bd_pins ip_56_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_4] [get_bd_pins ip_56_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 16 -to 0 ip_56_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_56_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_5] [get_bd_pins ip_56_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/slice_5/dout] [get_bd_pins ip_56_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_57_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_57_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_57_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_57_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_57_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/slice_0/dout] [get_bd_pins ip_57_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 16 -to 0 ip_57_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_57_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_1] [get_bd_pins ip_57_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/slice_1/dout] [get_bd_pins ip_57_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 16 -to 0 ip_58_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_58_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_59_slice_and_concat
create_bd_pin -dir O -from 19 -to 0 ip_59_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_59_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_59_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_59_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_59_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_59_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/slice_0/dout] [get_bd_pins ip_59_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_59_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_1] [get_bd_pins ip_59_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_59_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_2] [get_bd_pins ip_59_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_59_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_3] [get_bd_pins ip_59_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_59_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_4] [get_bd_pins ip_59_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 12 -to 0 ip_59_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_59_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_5] [get_bd_pins ip_59_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/slice_5/dout] [get_bd_pins ip_59_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_60_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_60_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_60_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_60_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 12 -to 0 ip_60_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_60_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_60_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/slice_0/dout] [get_bd_pins ip_60_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 12 -to 0 ip_60_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_60_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_1] [get_bd_pins ip_60_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/slice_1/dout] [get_bd_pins ip_60_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_61_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_61_slice_and_concat/out0
create_bd_pin -dir I -from 12 -to 0 ip_61_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_61_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_61_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_61_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_61_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_62_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_62_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_62_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_62_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_62_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_62_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_62_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_62_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_1] [get_bd_pins ip_62_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_62_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_2] [get_bd_pins ip_62_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_63_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_63_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_63_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_64_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_64_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_64_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_65_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_65_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_66_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_66_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_66_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_67_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_67_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_67_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_68_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_68_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_68_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_69_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_69_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_69_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_70_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_70_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_70_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_71_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_71_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_71_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_72_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_72_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_72_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_73_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_73_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_73_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_74_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_74_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_74_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_75_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_75_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_75_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_76_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_76_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_76_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_77_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_77_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_77_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_4_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_24_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_25_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic_IIC] [get_bd_intf_pins ip_0_axi_iic/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_8_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap_ICAP] [get_bd_intf_pins ip_8_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_8_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_8_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_11_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_iic_IIC] [get_bd_intf_pins ip_11_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_15_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi_IIC] [get_bd_intf_pins ip_15_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_16_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_iic_IIC] [get_bd_intf_pins ip_16_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio_GPIO] [get_bd_intf_pins ip_17_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio_GPIO2] [get_bd_intf_pins ip_17_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_19_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_19_uartlite_UART] [get_bd_intf_pins ip_19_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_26_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 19 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_59_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_63_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_67_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_71_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_74_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_77_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_25_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_26_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_iic/reset]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset] [get_bd_pins ip_1_dft/SCLR]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_2_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_iic/reset]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_12_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_13_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_16_axi_iic/reset]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_17_gpio/rst]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_18_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset_n] [get_bd_pins ip_19_uartlite/reset]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset] [get_bd_pins ip_21_dft/SCLR]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_22_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/peripheral_areset] [get_bd_pins ip_23_dft/SCLR]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_0_axi_iic/clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_1_dft/CLK]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_2_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_2_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_3_fft/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_4_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_4_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_6_cordic/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_7_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_7_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_8_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_8_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_9_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_11_axi_iic/clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_12_floating_point/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_13_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_14_fft/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_15_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_15_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_15_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_16_axi_iic/clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_17_gpio/clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_18_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_19_uartlite/clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_20_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_21_dft/CLK]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_22_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_23_dft/CLK]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_24_reset/clk_in]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_locked] [get_bd_pins ip_24_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_26_intc/irq_0] [get_bd_pins ip_0_axi_iic/irq]
connect_bd_net [get_bd_pins ip_26_intc/irq_1] [get_bd_pins ip_2_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_26_intc/irq_2] [get_bd_pins ip_3_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_26_intc/irq_3] [get_bd_pins ip_4_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_26_intc/irq_4] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_26_intc/irq_5] [get_bd_pins ip_7_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_26_intc/irq_6] [get_bd_pins ip_8_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_26_intc/irq_7] [get_bd_pins ip_9_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_26_intc/irq_8] [get_bd_pins ip_11_axi_iic/irq]
connect_bd_net [get_bd_pins ip_26_intc/irq_9] [get_bd_pins ip_14_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_26_intc/irq_10] [get_bd_pins ip_15_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_26_intc/irq_11] [get_bd_pins ip_16_axi_iic/irq]
connect_bd_net [get_bd_pins ip_26_intc/irq_12] [get_bd_pins ip_19_uartlite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_cdma/M_AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_cdma/M_AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_27_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_27_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_27_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_timer/S_AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_iic/AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_27_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_27_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_iic/AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_gpio/AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_uartlite/AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_intc/AXI] [get_bd_intf_pins ip_27_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_29_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_30_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_31_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_fft/M_AXIS_DATA] [get_bd_intf_pins ip_32_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_floating_point/S_AXIS_A] [get_bd_intf_pins ip_35_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_floating_point/S_AXIS_A] [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_45_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_47_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_fft/S_AXIS_DATA] [get_bd_intf_pins ip_50_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_51_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_IM]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_1_dft/RFFD]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_1] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_8_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_23_dft/SIZE]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_21_dft/XN_IM]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_1] [get_bd_pins ip_1_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_2] [get_bd_pins ip_1_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_3] [get_bd_pins ip_1_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_4] [get_bd_pins ip_2_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_5] [get_bd_pins ip_2_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_6] [get_bd_pins ip_2_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_7] [get_bd_pins ip_2_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_23_dft/XN_RE]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_1] [get_bd_pins ip_9_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_2] [get_bd_pins ip_9_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_3] [get_bd_pins ip_9_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_4] [get_bd_pins ip_21_dft/RFFD]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_5] [get_bd_pins ip_21_dft/XK_RE]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_21_dft/XN_RE]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_21_dft/XK_RE]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_1] [get_bd_pins ip_21_dft/XK_IM]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_1_dft/SIZE]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_21_dft/XK_IM]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_21_dft/XK_IM]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_1] [get_bd_pins ip_21_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_2] [get_bd_pins ip_21_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_3] [get_bd_pins ip_21_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_4] [get_bd_pins ip_23_dft/RFFD]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_5] [get_bd_pins ip_23_dft/XK_RE]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_23_dft/XN_IM]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_23_dft/XK_RE]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_1] [get_bd_pins ip_23_dft/XK_IM]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_RE]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_23_dft/XK_IM]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_21_dft/SIZE]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_23_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_1] [get_bd_pins ip_23_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_2] [get_bd_pins ip_23_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_20_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_63_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_9_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_64_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_12_floating_point/aclken]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_65_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_21_dft/FD_IN]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_23_dft/FD_IN]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_6_cordic/aclken]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_9_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_9_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_70_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_1_dft/CE]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_71_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_22_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_72_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_23_dft/CE]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_73_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_1_dft/FD_IN]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_74_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_21_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_75_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_23_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_76_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_1_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_77_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_27_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_48_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_49_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_50_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_24_reset/interconnect_aresetn] [get_bd_pins ip_51_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_26_intc/clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_27_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_28_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_29_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_30_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_31_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_32_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_33_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_34_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_35_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_36_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_37_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_38_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_45_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_46_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_47_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_48_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_49_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_50_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_25_clk_wiz/clk_out] [get_bd_pins ip_51_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 25 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=25 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=25 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_cordic/S_AXIS_CARTESIAN declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_cordic/S_AXIS_CARTESIAN declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_cordic/M_AXIS_DOUT declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_cordic/M_AXIS_DOUT declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/M_AXIS_RESULT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/M_AXIS_RESULT declared=48 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_B declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_B declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/M_AXIS_DOUT declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/M_AXIS_DOUT declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_fft/S_AXIS_DATA declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_fft/S_AXIS_DATA declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_fft/M_AXIS_DATA declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_fft/M_AXIS_DATA declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 18 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_fft/S_AXIS_CONFIG declared=18 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_fft/S_AXIS_CONFIG declared=18 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_B declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_B declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_3 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_3 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 18 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=18 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=18 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_1 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_1 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 25 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/M_AXIS declared=25 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/M_AXIS declared=25 actual=ERR $__err" }


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
