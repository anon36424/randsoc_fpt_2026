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



########## uartlite ##########
create_bd_cell -type hier ip_0_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_0_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 2400 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Even " [get_bd_cells ip_0_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_0_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_0_uartlite/UART] [get_bd_intf_pins ip_0_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_0_uartlite/clk
connect_bd_net [get_bd_pins ip_0_uartlite/clk] [get_bd_pins ip_0_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_uartlite/reset
connect_bd_net [get_bd_pins ip_0_uartlite/reset] [get_bd_pins ip_0_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_uartlite/AXI] [get_bd_intf_pins ip_0_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_uartlite/irq
connect_bd_net [get_bd_pins ip_0_uartlite/irq] [get_bd_pins ip_0_uartlite/uart_0/interrupt]


########## emc ##########
create_bd_cell -type hier ip_1_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_1_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 64 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 64 CONFIG.C_MEM3_TYPE 0 CONFIG.C_MEM3_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_SYNCH_PIPEDELAY_3 2 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 13 CONFIG.C_TAVDV_PS_MEM_0 15947 CONFIG.C_TAVDV_PS_MEM_1 14531 CONFIG.C_TAVDV_PS_MEM_2 15411 CONFIG.C_TCEDV_PS_MEM_0 14125 CONFIG.C_TCEDV_PS_MEM_1 14042 CONFIG.C_TCEDV_PS_MEM_2 13775 CONFIG.C_THZCE_PS_MEM_0 7630 CONFIG.C_THZCE_PS_MEM_1 7058 CONFIG.C_THZCE_PS_MEM_2 6900 CONFIG.C_THZOE_PS_MEM_0 7232 CONFIG.C_THZOE_PS_MEM_1 6312 CONFIG.C_THZOE_PS_MEM_2 6671 CONFIG.C_TLZWE_PS_MEM_0 1561 CONFIG.C_TLZWE_PS_MEM_1 1760 CONFIG.C_TLZWE_PS_MEM_2 1526 CONFIG.C_TWC_PS_MEM_0 15549 CONFIG.C_TWC_PS_MEM_1 14843 CONFIG.C_TWC_PS_MEM_2 13636 CONFIG.C_TWPH_PS_MEM_0 11533 CONFIG.C_TWPH_PS_MEM_1 12133 CONFIG.C_TWPH_PS_MEM_2 11239 CONFIG.C_TWP_PS_MEM_0 11692 CONFIG.C_TWP_PS_MEM_1 11873 CONFIG.C_TWP_PS_MEM_2 11453 CONFIG.C_WR_REC_TIME_MEM_0 29025 CONFIG.C_WR_REC_TIME_MEM_1 29176 CONFIG.C_WR_REC_TIME_MEM_2 25802 " [get_bd_cells ip_1_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_1_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_1_emc/EMC_INTF] [get_bd_intf_pins ip_1_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_1_emc/clk
connect_bd_net [get_bd_pins ip_1_emc/clk] [get_bd_pins ip_1_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_emc/rdclk
connect_bd_net [get_bd_pins ip_1_emc/rdclk] [get_bd_pins ip_1_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_emc/rst
connect_bd_net [get_bd_pins ip_1_emc/rst] [get_bd_pins ip_1_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_emc/AXI] [get_bd_intf_pins ip_1_emc/emc_0/S_AXI_MEM]


########## cordic ##########
create_bd_cell -type hier ip_2_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_2_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Translate CONFIG.Input_Width 36 CONFIG.Iterations 45 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 40 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 46 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_2_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_cordic/aclk
connect_bd_net [get_bd_pins ip_2_cordic/aclk] [get_bd_pins ip_2_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]


########## xadc_wiz ##########
create_bd_cell -type hier ip_3_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_3_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING 16 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_3_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_3_xadc_wiz/dclk_in] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_3_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_3_xadc_wiz/convst_in] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_3_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_3_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_3_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
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


########## fft ##########
create_bd_cell -type hier ip_4_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_4_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 4 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 512 " [get_bd_cells ip_4_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_fft/aclk
connect_bd_net [get_bd_pins ip_4_fft/aclk] [get_bd_pins ip_4_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_4_fft/event_frame_started
connect_bd_net [get_bd_pins ip_4_fft/event_frame_started] [get_bd_pins ip_4_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_fft/S_AXIS_DATA] [get_bd_intf_pins ip_4_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_fft/M_AXIS_DATA] [get_bd_intf_pins ip_4_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_4_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_4_fft/fft_0/S_AXIS_CONFIG]


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


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_6_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_6_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_6_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/clk] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/reset] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/irq] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## dft ##########
create_bd_cell -type hier ip_7_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_7_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 9 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_7_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/CLK
connect_bd_net [get_bd_pins ip_7_dft/CLK] [get_bd_pins ip_7_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/SCLR
connect_bd_net [get_bd_pins ip_7_dft/SCLR] [get_bd_pins ip_7_dft/dft_0/SCLR]
create_bd_pin -dir I -from 8 -to 0 ip_7_dft/XN_RE
connect_bd_net [get_bd_pins ip_7_dft/XN_RE] [get_bd_pins ip_7_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 8 -to 0 ip_7_dft/XN_IM
connect_bd_net [get_bd_pins ip_7_dft/XN_IM] [get_bd_pins ip_7_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/FD_IN
connect_bd_net [get_bd_pins ip_7_dft/FD_IN] [get_bd_pins ip_7_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/FWD_INV
connect_bd_net [get_bd_pins ip_7_dft/FWD_INV] [get_bd_pins ip_7_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_7_dft/SIZE
connect_bd_net [get_bd_pins ip_7_dft/SIZE] [get_bd_pins ip_7_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/RFFD
connect_bd_net [get_bd_pins ip_7_dft/RFFD] [get_bd_pins ip_7_dft/dft_0/RFFD]
create_bd_pin -dir O -from 8 -to 0 ip_7_dft/XK_RE
connect_bd_net [get_bd_pins ip_7_dft/XK_RE] [get_bd_pins ip_7_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 8 -to 0 ip_7_dft/XK_IM
connect_bd_net [get_bd_pins ip_7_dft/XK_IM] [get_bd_pins ip_7_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_7_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_7_dft/BLK_EXP] [get_bd_pins ip_7_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/FD_OUT
connect_bd_net [get_bd_pins ip_7_dft/FD_OUT] [get_bd_pins ip_7_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_7_dft/DATA_VALID] [get_bd_pins ip_7_dft/dft_0/DATA_VALID]


########## uartlite ##########
create_bd_cell -type hier ip_8_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_8_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Odd " [get_bd_cells ip_8_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_8_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_8_uartlite/UART] [get_bd_intf_pins ip_8_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_8_uartlite/clk
connect_bd_net [get_bd_pins ip_8_uartlite/clk] [get_bd_pins ip_8_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_uartlite/reset
connect_bd_net [get_bd_pins ip_8_uartlite/reset] [get_bd_pins ip_8_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_uartlite/AXI] [get_bd_intf_pins ip_8_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_uartlite/irq
connect_bd_net [get_bd_pins ip_8_uartlite/irq] [get_bd_pins ip_8_uartlite/uart_0/interrupt]


########## axi_hwicap ##########
create_bd_cell -type hier ip_9_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_9_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 1024 " [get_bd_cells ip_9_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_9_axi_hwicap/icap_clk] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_9_axi_hwicap/eos_in] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_9_axi_hwicap/s_axi_aclk] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_9_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_9_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## microblaze ##########
create_bd_cell -type hier ip_10_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 64 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 6 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 2 CONFIG.C_MMU_ITLB_SIZE 4 CONFIG.C_MMU_PRIVILEGED_INSTR 2 CONFIG.C_MMU_TLB_ACCESS 1 CONFIG.C_MMU_ZONES 0 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0xa4 CONFIG.C_PVR_USER2 0x6ba8b627 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 0 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 0 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MMU 3 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_10_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_microblaze/Clk
connect_bd_net [get_bd_pins ip_10_microblaze/Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_10_microblaze/Reset
connect_bd_net [get_bd_pins ip_10_microblaze/Reset] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_10_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/INTERRUPT] [get_bd_intf_pins ip_10_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/M_AXI_DP] [get_bd_intf_pins ip_10_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_10_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_10_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xb09e0946866452c CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_10_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_10_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_10_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_10_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x8e5426690e7559b CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_10_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_10_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_10_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_10_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_10_microblaze/mem/BRAM_PORTB]


########## uartlite ##########
create_bd_cell -type hier ip_11_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_11_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Even " [get_bd_cells ip_11_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_11_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_11_uartlite/UART] [get_bd_intf_pins ip_11_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_11_uartlite/clk
connect_bd_net [get_bd_pins ip_11_uartlite/clk] [get_bd_pins ip_11_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_uartlite/reset
connect_bd_net [get_bd_pins ip_11_uartlite/reset] [get_bd_pins ip_11_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_uartlite/AXI] [get_bd_intf_pins ip_11_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_11_uartlite/irq
connect_bd_net [get_bd_pins ip_11_uartlite/irq] [get_bd_pins ip_11_uartlite/uart_0/interrupt]


########## uartlite ##########
create_bd_cell -type hier ip_12_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_12_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Odd " [get_bd_cells ip_12_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_12_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_12_uartlite/UART] [get_bd_intf_pins ip_12_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_12_uartlite/clk
connect_bd_net [get_bd_pins ip_12_uartlite/clk] [get_bd_pins ip_12_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_uartlite/reset
connect_bd_net [get_bd_pins ip_12_uartlite/reset] [get_bd_pins ip_12_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_uartlite/AXI] [get_bd_intf_pins ip_12_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_uartlite/irq
connect_bd_net [get_bd_pins ip_12_uartlite/irq] [get_bd_pins ip_12_uartlite/uart_0/interrupt]


########## fft ##########
create_bd_cell -type hier ip_13_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_13_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 9 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 2048 " [get_bd_cells ip_13_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_fft/aclk
connect_bd_net [get_bd_pins ip_13_fft/aclk] [get_bd_pins ip_13_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_13_fft/event_frame_started
connect_bd_net [get_bd_pins ip_13_fft/event_frame_started] [get_bd_pins ip_13_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/S_AXIS_DATA] [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/M_AXIS_DATA] [get_bd_intf_pins ip_13_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_CONFIG]


########## reset ##########
create_bd_cell -type hier ip_14_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_14_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_reset/clk_in
connect_bd_net [get_bd_pins ip_14_reset/clk_in] [get_bd_pins ip_14_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_14_reset/reset_in
connect_bd_net [get_bd_pins ip_14_reset/reset_in] [get_bd_pins ip_14_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_14_reset/dcm_locked
connect_bd_net [get_bd_pins ip_14_reset/dcm_locked] [get_bd_pins ip_14_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/mb_reset
connect_bd_net [get_bd_pins ip_14_reset/mb_reset] [get_bd_pins ip_14_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_14_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset] [get_bd_pins ip_14_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_14_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_15_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_15_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_in] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_15_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_15_clk_wiz/reset
connect_bd_net [get_bd_pins ip_15_clk_wiz/reset] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_locked] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_16_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_16_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_16_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 9 " [get_bd_cells ip_16_intc/concat_0]
connect_bd_net [get_bd_pins ip_16_intc/concat_0/dout] [get_bd_pins ip_16_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/clk
connect_bd_net [get_bd_pins ip_16_intc/clk] [get_bd_pins ip_16_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/reset
connect_bd_net [get_bd_pins ip_16_intc/reset] [get_bd_pins ip_16_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_intc/AXI] [get_bd_intf_pins ip_16_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_0
connect_bd_net [get_bd_pins ip_16_intc/irq_0] [get_bd_pins ip_16_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_1
connect_bd_net [get_bd_pins ip_16_intc/irq_1] [get_bd_pins ip_16_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_2
connect_bd_net [get_bd_pins ip_16_intc/irq_2] [get_bd_pins ip_16_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_3
connect_bd_net [get_bd_pins ip_16_intc/irq_3] [get_bd_pins ip_16_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_4
connect_bd_net [get_bd_pins ip_16_intc/irq_4] [get_bd_pins ip_16_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_5
connect_bd_net [get_bd_pins ip_16_intc/irq_5] [get_bd_pins ip_16_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_6
connect_bd_net [get_bd_pins ip_16_intc/irq_6] [get_bd_pins ip_16_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_7
connect_bd_net [get_bd_pins ip_16_intc/irq_7] [get_bd_pins ip_16_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_8
connect_bd_net [get_bd_pins ip_16_intc/irq_8] [get_bd_pins ip_16_intc/concat_0/In8]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_16_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_16_intc/irq] [get_bd_intf_pins ip_16_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_17_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_17_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 9 CONFIG.NUM_SI 1 " [get_bd_cells ip_17_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_legacy/clk
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_legacy/reset
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_M0] [get_bd_intf_pins ip_17_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_S0] [get_bd_intf_pins ip_17_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_S1] [get_bd_intf_pins ip_17_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_S2] [get_bd_intf_pins ip_17_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_S3] [get_bd_intf_pins ip_17_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_S4] [get_bd_intf_pins ip_17_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_S5] [get_bd_intf_pins ip_17_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_S6] [get_bd_intf_pins ip_17_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_S7] [get_bd_intf_pins ip_17_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_legacy/AXI_S8] [get_bd_intf_pins ip_17_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_17_axi_legacy/clk] [get_bd_pins ip_17_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_17_axi_legacy/reset] [get_bd_pins ip_17_axi_legacy/axi_0/M08_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_18_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_18_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_18_axis_broadcaster/axis_broadcaster_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_20_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_20_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aclk] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aresetn] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_21_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_21_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_22_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_22_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 3 CONFIG.S_TDATA_NUM_BYTES 36 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_22_axis_dwidth_converter/aclk] [get_bd_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_22_axis_dwidth_converter/aresetn] [get_bd_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_23_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_23_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_1] [get_bd_pins ip_23_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_2] [get_bd_pins ip_23_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_3] [get_bd_pins ip_23_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 8 -to 0 ip_23_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_23_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_4] [get_bd_pins ip_23_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/slice_4/dout] [get_bd_pins ip_23_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_24_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_24_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/slice_0/dout] [get_bd_pins ip_24_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 8 -to 0 ip_24_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_24_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_1] [get_bd_pins ip_24_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/slice_1/dout] [get_bd_pins ip_24_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 8 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 2 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 8 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_27_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_27_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/slice_0/dout] [get_bd_pins ip_27_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_27_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_27_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_2] [get_bd_pins ip_27_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_3] [get_bd_pins ip_27_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_28_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_15_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_0_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_0_uartlite_UART] [get_bd_intf_pins ip_0_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_1_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_1_emc_EMC_INTF] [get_bd_intf_pins ip_1_emc/EMC_INTF]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_3_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_3_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_3_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite_MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_8_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_8_uartlite_UART] [get_bd_intf_pins ip_8_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_11_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_11_uartlite_UART] [get_bd_intf_pins ip_11_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_12_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_12_uartlite_UART] [get_bd_intf_pins ip_12_uartlite/UART]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_18_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 2 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_26_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir O -from 0 -to 0 control_O
connect_bd_net [get_bd_pins control_O] [get_bd_pins ip_28_slice_and_concat/out0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_0_uartlite/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_1_emc/rst]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset] [get_bd_pins ip_7_dft/SCLR]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_8_uartlite/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_14_reset/mb_reset] [get_bd_pins ip_10_microblaze/Reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_11_uartlite/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_12_uartlite/reset]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_0_uartlite/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_1_emc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_1_emc/rdclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_2_cordic/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_3_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_4_fft/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_6_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_7_dft/CLK]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_8_uartlite/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_9_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_9_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_10_microblaze/Clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_11_uartlite/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_12_uartlite/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_13_fft/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_14_reset/clk_in]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_locked] [get_bd_pins ip_14_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_16_intc/irq_0] [get_bd_pins ip_0_uartlite/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_1] [get_bd_pins ip_4_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_16_intc/irq_2] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_3] [get_bd_pins ip_6_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_4] [get_bd_pins ip_8_uartlite/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_5] [get_bd_pins ip_9_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_16_intc/irq_6] [get_bd_pins ip_11_uartlite/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_7] [get_bd_pins ip_12_uartlite/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_8] [get_bd_pins ip_13_fft/event_frame_started]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_microblaze/INTERRUPT] [get_bd_intf_pins ip_16_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_microblaze/M_AXI_DP] [get_bd_intf_pins ip_17_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_uartlite/AXI] [get_bd_intf_pins ip_17_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_emc/AXI] [get_bd_intf_pins ip_17_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_17_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_17_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_uartlite/AXI] [get_bd_intf_pins ip_17_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_17_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_uartlite/AXI] [get_bd_intf_pins ip_17_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_uartlite/AXI] [get_bd_intf_pins ip_17_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_intc/AXI] [get_bd_intf_pins ip_17_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/M_AXIS_DATA] [get_bd_intf_pins ip_19_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_DATA] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_fft/S_AXIS_DATA] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_7_dft/XN_RE]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_3_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_1] [get_bd_pins ip_3_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_2] [get_bd_pins ip_3_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_3] [get_bd_pins ip_7_dft/RFFD]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_4] [get_bd_pins ip_7_dft/XK_RE]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_7_dft/SIZE]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_RE]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_1] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_9_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_7_dft/XN_IM]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_7_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_2] [get_bd_pins ip_7_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_3] [get_bd_pins ip_7_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_3_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_7_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_3_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_3_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_3_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_7_dft/FD_IN]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_3_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_17_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_16_intc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_17_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_18_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_19_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_CARTESIAN declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_CARTESIAN declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_fft/S_AXIS_DATA declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_fft/S_AXIS_DATA declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_fft/M_AXIS_DATA declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_fft/M_AXIS_DATA declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 22 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_fft/S_AXIS_CONFIG declared=22 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_fft/S_AXIS_CONFIG declared=22 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 26 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=26 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=26 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 22 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=22 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=22 actual=ERR $__err" }


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
