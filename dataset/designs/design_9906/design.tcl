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
set_property -dict "CONFIG.a_precision_type Half CONFIG.a_tuser_width 7 CONFIG.add_sub_value Both CONFIG.c_bram_usage Full_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage Full_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Exponential CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_0_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_floating_point/aclk
connect_bd_net [get_bd_pins ip_0_floating_point/aclk] [get_bd_pins ip_0_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_floating_point/aclken
connect_bd_net [get_bd_pins ip_0_floating_point/aclken] [get_bd_pins ip_0_floating_point/floating_point_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_0_floating_point/S_AXIS_A] [get_bd_intf_pins ip_0_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_0_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_0_floating_point/floating_point_0/M_AXIS_RESULT]


########## dft ##########
create_bd_cell -type hier ip_1_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_1_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 10 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_1_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CLK
connect_bd_net [get_bd_pins ip_1_dft/CLK] [get_bd_pins ip_1_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CE
connect_bd_net [get_bd_pins ip_1_dft/CE] [get_bd_pins ip_1_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/SCLR
connect_bd_net [get_bd_pins ip_1_dft/SCLR] [get_bd_pins ip_1_dft/dft_0/SCLR]
create_bd_pin -dir I -from 9 -to 0 ip_1_dft/XN_RE
connect_bd_net [get_bd_pins ip_1_dft/XN_RE] [get_bd_pins ip_1_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 9 -to 0 ip_1_dft/XN_IM
connect_bd_net [get_bd_pins ip_1_dft/XN_IM] [get_bd_pins ip_1_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FD_IN
connect_bd_net [get_bd_pins ip_1_dft/FD_IN] [get_bd_pins ip_1_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FWD_INV
connect_bd_net [get_bd_pins ip_1_dft/FWD_INV] [get_bd_pins ip_1_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_1_dft/SIZE
connect_bd_net [get_bd_pins ip_1_dft/SIZE] [get_bd_pins ip_1_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/RFFD
connect_bd_net [get_bd_pins ip_1_dft/RFFD] [get_bd_pins ip_1_dft/dft_0/RFFD]
create_bd_pin -dir O -from 9 -to 0 ip_1_dft/XK_RE
connect_bd_net [get_bd_pins ip_1_dft/XK_RE] [get_bd_pins ip_1_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 9 -to 0 ip_1_dft/XK_IM
connect_bd_net [get_bd_pins ip_1_dft/XK_IM] [get_bd_pins ip_1_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_1_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_1_dft/BLK_EXP] [get_bd_pins ip_1_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/FD_OUT
connect_bd_net [get_bd_pins ip_1_dft/FD_OUT] [get_bd_pins ip_1_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_1_dft/DATA_VALID] [get_bd_pins ip_1_dft/dft_0/DATA_VALID]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_2_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_2_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_2_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_2_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_quad_spi/IIC] [get_bd_intf_pins ip_2_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_2_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_2_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_2_axi_quad_spi/clk] [get_bd_pins ip_2_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_2_axi_quad_spi/reset] [get_bd_pins ip_2_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_2_axi_quad_spi/clk4] [get_bd_pins ip_2_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_2_axi_quad_spi/reset4] [get_bd_pins ip_2_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_2_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_2_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_2_axi_quad_spi/irq] [get_bd_pins ip_2_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_3_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_3_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 53 CONFIG.aresetn 0 CONFIG.atuserwidth 98 CONFIG.bportwidth 50 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 101 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_3_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_3_complex_multiplier/aclk] [get_bd_pins ip_3_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_3_complex_multiplier/aclken] [get_bd_pins ip_3_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## xadc_wiz ##########
create_bd_cell -type hier ip_4_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_4_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_DCLK 0 CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_4_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/ot_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/eoc_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/eos_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/alarm_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/busy_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_4_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_4_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_4_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/jtaglocked_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/jtagmodified_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/jtagbusy_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 2400 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Odd " [get_bd_cells ip_5_uartlite/uart_0]
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
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_6_axi_ethernet_lite/axi_ethernetlite_0]
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


########## reset ##########
create_bd_cell -type hier ip_7_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_7_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_reset/clk_in
connect_bd_net [get_bd_pins ip_7_reset/clk_in] [get_bd_pins ip_7_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_7_reset/reset_in
connect_bd_net [get_bd_pins ip_7_reset/reset_in] [get_bd_pins ip_7_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_7_reset/dcm_locked
connect_bd_net [get_bd_pins ip_7_reset/dcm_locked] [get_bd_pins ip_7_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/mb_reset
connect_bd_net [get_bd_pins ip_7_reset/mb_reset] [get_bd_pins ip_7_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_7_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset] [get_bd_pins ip_7_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_7_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_8_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_8_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_in] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_8_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_8_clk_wiz/reset
connect_bd_net [get_bd_pins ip_8_clk_wiz/reset] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_8_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_locked] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_9_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_9_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_9_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_9_intc/concat_0]
connect_bd_net [get_bd_pins ip_9_intc/concat_0/dout] [get_bd_pins ip_9_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/clk
connect_bd_net [get_bd_pins ip_9_intc/clk] [get_bd_pins ip_9_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/reset
connect_bd_net [get_bd_pins ip_9_intc/reset] [get_bd_pins ip_9_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_intc/AXI] [get_bd_intf_pins ip_9_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_0
connect_bd_net [get_bd_pins ip_9_intc/irq_0] [get_bd_pins ip_9_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_1
connect_bd_net [get_bd_pins ip_9_intc/irq_1] [get_bd_pins ip_9_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_2
connect_bd_net [get_bd_pins ip_9_intc/irq_2] [get_bd_pins ip_9_intc/concat_0/In2]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_9_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_9_intc/irq] [get_bd_intf_pins ip_9_intc/intc_0/interrupt]


########## jtag_axi ##########
create_bd_cell -type hier ip_10_jtag_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0
move_bd_cells [get_bd_cells ip_10_jtag_axi] [get_bd_cells jtag_axi_0]
set_property -dict "CONFIG.PROTOCOL AXI4LITE " [get_bd_cells ip_10_jtag_axi/jtag_axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_jtag_axi/aclk
connect_bd_net [get_bd_pins ip_10_jtag_axi/aclk] [get_bd_pins ip_10_jtag_axi/jtag_axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_jtag_axi/aresetn
connect_bd_net [get_bd_pins ip_10_jtag_axi/aresetn] [get_bd_pins ip_10_jtag_axi/jtag_axi_0/aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_jtag_axi/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_jtag_axi/M_AXI] [get_bd_intf_pins ip_10_jtag_axi/jtag_axi_0/M_AXI]


########## axi ##########
create_bd_cell -type hier ip_11_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_11_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 5 CONFIG.NUM_SI 1 " [get_bd_cells ip_11_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi/clk
connect_bd_net [get_bd_pins ip_11_axi/clk] [get_bd_pins ip_11_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi/reset
connect_bd_net [get_bd_pins ip_11_axi/reset] [get_bd_pins ip_11_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_M0] [get_bd_intf_pins ip_11_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S0] [get_bd_intf_pins ip_11_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S1] [get_bd_intf_pins ip_11_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S2] [get_bd_intf_pins ip_11_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S3] [get_bd_intf_pins ip_11_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S4] [get_bd_intf_pins ip_11_axi/axi_0/M04_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_12_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_12_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_12_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_12_axis_broadcaster/aclk] [get_bd_pins ip_12_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_12_axis_broadcaster/aresetn] [get_bd_pins ip_12_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_12_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_12_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_12_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_12_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 26 " [get_bd_cells ip_14_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_15_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_16_axis_dwidth_converter/axis_dwidth_converter_0]
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
create_bd_pin -dir O -from 9 -to 0 ip_17_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_17_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 9 -to 0 ip_17_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_17_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_17_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/slice_1/dout] [get_bd_pins ip_17_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_18_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_18_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 9 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/slice_0/dout] [get_bd_pins ip_18_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 9 -to 0 ip_18_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_18_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_1] [get_bd_pins ip_18_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/slice_1/dout] [get_bd_pins ip_18_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_19_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_19_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 9 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/slice_0/dout] [get_bd_pins ip_19_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_19_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_1] [get_bd_pins ip_19_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_19_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_2] [get_bd_pins ip_19_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 6 -to 0 ip_20_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_20_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_20_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_20_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_3] [get_bd_pins ip_20_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_4] [get_bd_pins ip_20_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_5] [get_bd_pins ip_20_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_6] [get_bd_pins ip_20_slice_and_concat/concat/In6]


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

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_8_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_2_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_quad_spi_IIC] [get_bd_intf_pins ip_2_axi_quad_spi/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_4_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_4_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_4_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite_MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_9_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_12_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 6 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_20_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset] [get_bd_pins ip_1_dft/SCLR]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_0_floating_point/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_1_dft/CLK]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_2_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_2_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_2_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_3_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_6_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_7_reset/clk_in]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_locked] [get_bd_pins ip_7_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_9_intc/irq_0] [get_bd_pins ip_2_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_9_intc/irq_1] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_9_intc/irq_2] [get_bd_pins ip_6_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_jtag_axi/M_AXI] [get_bd_intf_pins ip_11_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_11_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_11_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_11_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_11_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_intc/AXI] [get_bd_intf_pins ip_11_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_12_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_floating_point/S_AXIS_A] [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_IM]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_1_dft/RFFD]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_1_dft/SIZE]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_1] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_RE]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_1] [get_bd_pins ip_1_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_2] [get_bd_pins ip_1_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_1_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_4_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_4_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_3] [get_bd_pins ip_4_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_4] [get_bd_pins ip_4_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_5] [get_bd_pins ip_4_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_6] [get_bd_pins ip_4_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_3_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_0_floating_point/aclken]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_1_dft/FD_IN]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_1_dft/CE]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_1_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_10_jtag_axi/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_11_axi/reset]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_12_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_13_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_9_intc/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_10_jtag_axi/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_11_axi/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_12_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_13_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_14_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_15_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_16_axis_dwidth_converter/aclk]

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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 208 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/M_AXIS_DOUT declared=208 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/M_AXIS_DOUT declared=208 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_broadcaster/M_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_broadcaster/M_AXIS_2 declared=16 actual=ERR $__err" }
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
  set __s [expr {$__aw == 208 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=208 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=208 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }


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
