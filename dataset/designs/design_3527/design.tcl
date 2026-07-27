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



########## gpio ##########
create_bd_cell -type hier ip_0_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_0_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 1 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_0_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/clk
connect_bd_net [get_bd_pins ip_0_gpio/clk] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/rst
connect_bd_net [get_bd_pins ip_0_gpio/rst] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_0_gpio/gpio_0/S_AXI]


########## gpio ##########
create_bd_cell -type hier ip_1_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_1_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 19 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x0 " [get_bd_cells ip_1_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio/GPIO] [get_bd_intf_pins ip_1_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_1_gpio/clk
connect_bd_net [get_bd_pins ip_1_gpio/clk] [get_bd_pins ip_1_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_gpio/rst
connect_bd_net [get_bd_pins ip_1_gpio/rst] [get_bd_pins ip_1_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio/AXI] [get_bd_intf_pins ip_1_gpio/gpio_0/S_AXI]


########## fft ##########
create_bd_cell -type hier ip_2_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_2_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 8 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 16 " [get_bd_cells ip_2_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_fft/aclk
connect_bd_net [get_bd_pins ip_2_fft/aclk] [get_bd_pins ip_2_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_2_fft/event_frame_started
connect_bd_net [get_bd_pins ip_2_fft/event_frame_started] [get_bd_pins ip_2_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_2_fft/S_AXIS_DATA] [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_2_fft/M_AXIS_DATA] [get_bd_intf_pins ip_2_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_2_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_CONFIG]


########## axi_cdma ##########
create_bd_cell -type hier ip_3_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_3_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 64 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_3_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_3_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_3_axi_cdma/m_axi_aclk] [get_bd_pins ip_3_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_3_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_3_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_3_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_3_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_cdma/M_AXI] [get_bd_intf_pins ip_3_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_3_axi_cdma/cdma_introut] [get_bd_pins ip_3_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_4_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_4_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 57 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 8 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 16 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_NUM_MM2S_CHANNELS 16 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 21 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_4_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_4_axi_dma/axi_resetn] [get_bd_pins ip_4_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_4_axi_dma/mm2s_introut] [get_bd_pins ip_4_axi_dma/axi_dma_0/mm2s_introut]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_5_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_5_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_5_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_5_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite/MII] [get_bd_intf_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_5_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_5_axi_ethernet_lite/clk] [get_bd_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_5_axi_ethernet_lite/reset] [get_bd_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_5_axi_ethernet_lite/irq] [get_bd_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## xadc_wiz ##########
create_bd_cell -type hier ip_6_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_6_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 16 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_DCLK 1 CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_6_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_6_xadc_wiz/dclk_in] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_6_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_6_xadc_wiz/reset_in] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/eoc_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/eos_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/alarm_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/busy_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_6_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_6_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_6_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/jtaglocked_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/jtagmodified_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/jtagbusy_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## accumulator ##########
create_bd_cell -type hier ip_7_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_7_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 10 CONFIG.Latency 2 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 34 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_7_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/clk
connect_bd_net [get_bd_pins ip_7_accumulator/clk] [get_bd_pins ip_7_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 9 -to 0 ip_7_accumulator/B
connect_bd_net [get_bd_pins ip_7_accumulator/B] [get_bd_pins ip_7_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 33 -to 0 ip_7_accumulator/Q
connect_bd_net [get_bd_pins ip_7_accumulator/Q] [get_bd_pins ip_7_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/ADD
connect_bd_net [get_bd_pins ip_7_accumulator/ADD] [get_bd_pins ip_7_accumulator/accumulator_0/ADD]


########## floating_point ##########
create_bd_cell -type hier ip_8_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_8_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Square_root CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_8_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_floating_point/aclk
connect_bd_net [get_bd_pins ip_8_floating_point/aclk] [get_bd_pins ip_8_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_8_floating_point/S_AXIS_A] [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_8_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_8_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_9_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_9_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 3 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_9_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_9_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/IIC] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/clk] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/reset] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/clk4] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/reset4] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/irq] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_10_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_10_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 63 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 256 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 8 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 12 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_10_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_10_axi_dma/axi_resetn] [get_bd_pins ip_10_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_10_axi_dma/mm2s_introut] [get_bd_pins ip_10_axi_dma/axi_dma_0/mm2s_introut]


########## axi_hwicap ##########
create_bd_cell -type hier ip_11_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_11_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 " [get_bd_cells ip_11_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_11_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_11_axi_hwicap/icap_clk] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_11_axi_hwicap/eos_in] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_11_axi_hwicap/s_axi_aclk] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_11_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_11_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_11_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_hwicap/ICAP] [get_bd_intf_pins ip_11_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_11_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_11_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## emc ##########
create_bd_cell -type hier ip_12_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_12_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 5 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 2 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 5 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 5 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 5 CONFIG.C_TAVDV_PS_MEM_0 14037 CONFIG.C_TAVDV_PS_MEM_1 14625 CONFIG.C_TAVDV_PS_MEM_2 14990 CONFIG.C_TAVDV_PS_MEM_3 15907 CONFIG.C_TCEDV_PS_MEM_0 16253 CONFIG.C_TCEDV_PS_MEM_1 16392 CONFIG.C_TCEDV_PS_MEM_2 15186 CONFIG.C_TCEDV_PS_MEM_3 13697 CONFIG.C_THZCE_PS_MEM_0 6424 CONFIG.C_THZCE_PS_MEM_1 7498 CONFIG.C_THZCE_PS_MEM_2 7690 CONFIG.C_THZCE_PS_MEM_3 6900 CONFIG.C_THZOE_PS_MEM_0 7034 CONFIG.C_THZOE_PS_MEM_1 7508 CONFIG.C_THZOE_PS_MEM_2 6548 CONFIG.C_THZOE_PS_MEM_3 6736 CONFIG.C_TLZWE_PS_MEM_0 5765 CONFIG.C_TLZWE_PS_MEM_1 2616 CONFIG.C_TLZWE_PS_MEM_2 6544 CONFIG.C_TLZWE_PS_MEM_3 766 CONFIG.C_TWC_PS_MEM_0 14533 CONFIG.C_TWC_PS_MEM_1 14119 CONFIG.C_TWC_PS_MEM_2 14244 CONFIG.C_TWC_PS_MEM_3 15108 CONFIG.C_TWPH_PS_MEM_0 11025 CONFIG.C_TWPH_PS_MEM_1 11023 CONFIG.C_TWPH_PS_MEM_2 13082 CONFIG.C_TWPH_PS_MEM_3 12009 CONFIG.C_TWP_PS_MEM_0 12957 CONFIG.C_TWP_PS_MEM_1 11376 CONFIG.C_TWP_PS_MEM_2 12019 CONFIG.C_TWP_PS_MEM_3 12256 CONFIG.C_WR_REC_TIME_MEM_0 28327 CONFIG.C_WR_REC_TIME_MEM_1 25829 CONFIG.C_WR_REC_TIME_MEM_2 24930 CONFIG.C_WR_REC_TIME_MEM_3 25676 " [get_bd_cells ip_12_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_12_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_12_emc/EMC_INTF] [get_bd_intf_pins ip_12_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_12_emc/clk
connect_bd_net [get_bd_pins ip_12_emc/clk] [get_bd_pins ip_12_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_emc/rdclk
connect_bd_net [get_bd_pins ip_12_emc/rdclk] [get_bd_pins ip_12_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_emc/rst
connect_bd_net [get_bd_pins ip_12_emc/rst] [get_bd_pins ip_12_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_emc/AXI] [get_bd_intf_pins ip_12_emc/emc_0/S_AXI_MEM]


########## axi_cdma ##########
create_bd_cell -type hier ip_13_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_13_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 37 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 2 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_13_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_13_axi_cdma/m_axi_aclk] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_13_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_13_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_cdma/M_AXI] [get_bd_intf_pins ip_13_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_13_axi_cdma/cdma_introut] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_14_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_14_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 60 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 2 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 512 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 16 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_14_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_14_axi_dma/axi_resetn] [get_bd_pins ip_14_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_14_axi_dma/mm2s_introut] [get_bd_pins ip_14_axi_dma/axi_dma_0/mm2s_introut]


########## reset ##########
create_bd_cell -type hier ip_15_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_15_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/clk_in
connect_bd_net [get_bd_pins ip_15_reset/clk_in] [get_bd_pins ip_15_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/reset_in
connect_bd_net [get_bd_pins ip_15_reset/reset_in] [get_bd_pins ip_15_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/dcm_locked
connect_bd_net [get_bd_pins ip_15_reset/dcm_locked] [get_bd_pins ip_15_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/mb_reset
connect_bd_net [get_bd_pins ip_15_reset/mb_reset] [get_bd_pins ip_15_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_15_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset] [get_bd_pins ip_15_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_15_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_16_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_16_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_in] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_16_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_16_clk_wiz/reset
connect_bd_net [get_bd_pins ip_16_clk_wiz/reset] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_16_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_locked] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_17_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 9 " [get_bd_cells ip_17_intc/concat_0]
connect_bd_net [get_bd_pins ip_17_intc/concat_0/dout] [get_bd_pins ip_17_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/clk
connect_bd_net [get_bd_pins ip_17_intc/clk] [get_bd_pins ip_17_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/reset
connect_bd_net [get_bd_pins ip_17_intc/reset] [get_bd_pins ip_17_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_intc/AXI] [get_bd_intf_pins ip_17_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_0
connect_bd_net [get_bd_pins ip_17_intc/irq_0] [get_bd_pins ip_17_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_1
connect_bd_net [get_bd_pins ip_17_intc/irq_1] [get_bd_pins ip_17_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_2
connect_bd_net [get_bd_pins ip_17_intc/irq_2] [get_bd_pins ip_17_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_3
connect_bd_net [get_bd_pins ip_17_intc/irq_3] [get_bd_pins ip_17_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_4
connect_bd_net [get_bd_pins ip_17_intc/irq_4] [get_bd_pins ip_17_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_5
connect_bd_net [get_bd_pins ip_17_intc/irq_5] [get_bd_pins ip_17_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_6
connect_bd_net [get_bd_pins ip_17_intc/irq_6] [get_bd_pins ip_17_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_7
connect_bd_net [get_bd_pins ip_17_intc/irq_7] [get_bd_pins ip_17_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_8
connect_bd_net [get_bd_pins ip_17_intc/irq_8] [get_bd_pins ip_17_intc/concat_0/In8]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_17_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_17_intc/irq] [get_bd_intf_pins ip_17_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_18_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_18_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 13 CONFIG.NUM_SI 6 " [get_bd_cells ip_18_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi/clk
connect_bd_net [get_bd_pins ip_18_axi/clk] [get_bd_pins ip_18_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi/reset
connect_bd_net [get_bd_pins ip_18_axi/reset] [get_bd_pins ip_18_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_M0] [get_bd_intf_pins ip_18_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_M1] [get_bd_intf_pins ip_18_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_M2] [get_bd_intf_pins ip_18_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_M3] [get_bd_intf_pins ip_18_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_M4] [get_bd_intf_pins ip_18_axi/axi_0/S04_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_M5] [get_bd_intf_pins ip_18_axi/axi_0/S05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S0] [get_bd_intf_pins ip_18_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S1] [get_bd_intf_pins ip_18_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S2] [get_bd_intf_pins ip_18_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S3] [get_bd_intf_pins ip_18_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S4] [get_bd_intf_pins ip_18_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S5] [get_bd_intf_pins ip_18_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S6] [get_bd_intf_pins ip_18_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S7] [get_bd_intf_pins ip_18_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S8] [get_bd_intf_pins ip_18_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S9] [get_bd_intf_pins ip_18_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S10] [get_bd_intf_pins ip_18_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S11] [get_bd_intf_pins ip_18_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S12] [get_bd_intf_pins ip_18_axi/axi_0/M12_AXI]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_19_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_19_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aclk] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aresetn] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_20_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_20_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_20_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_20_axis_combiner/aclk] [get_bd_pins ip_20_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_20_axis_combiner/aresetn] [get_bd_pins ip_20_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/M_AXIS] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_21_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_21_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 36 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 28 -to 0 ip_22_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_22_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_22_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_22_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_3] [get_bd_pins ip_22_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_4] [get_bd_pins ip_22_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_5] [get_bd_pins ip_22_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 33 -to 0 ip_22_slice_and_concat/in_6
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 22 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_22_slice_and_concat/slice_6]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_6] [get_bd_pins ip_22_slice_and_concat/slice_6/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/slice_6/dout] [get_bd_pins ip_22_slice_and_concat/concat/In6]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 33 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 23 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 33 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 33 CONFIG.DIN_TO 33 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_3_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_16_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO] [get_bd_intf_pins ip_0_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio_GPIO] [get_bd_intf_pins ip_1_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_5_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite_MII] [get_bd_intf_pins ip_5_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_5_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_5_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_6_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_6_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_6_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_9_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi_IIC] [get_bd_intf_pins ip_9_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_11_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_hwicap_ICAP] [get_bd_intf_pins ip_11_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_11_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_11_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_12_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_12_emc_EMC_INTF] [get_bd_intf_pins ip_12_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_17_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 28 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_22_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_0_gpio/rst]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_1_gpio/rst]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset] [get_bd_pins ip_6_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_12_emc/rst]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_0_gpio/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_1_gpio/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_2_fft/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_3_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_3_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_5_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_6_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_7_accumulator/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_8_floating_point/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_11_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_11_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_12_emc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_12_emc/rdclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_13_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_13_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_15_reset/clk_in]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_locked] [get_bd_pins ip_15_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_17_intc/irq_0] [get_bd_pins ip_2_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_17_intc/irq_1] [get_bd_pins ip_3_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_17_intc/irq_2] [get_bd_pins ip_4_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_17_intc/irq_3] [get_bd_pins ip_5_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_4] [get_bd_pins ip_9_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_5] [get_bd_pins ip_10_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_17_intc/irq_6] [get_bd_pins ip_11_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_17_intc/irq_7] [get_bd_pins ip_13_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_17_intc/irq_8] [get_bd_pins ip_14_axi_dma/mm2s_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_cdma/M_AXI] [get_bd_intf_pins ip_18_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_18_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_18_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_18_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_cdma/M_AXI] [get_bd_intf_pins ip_18_axi/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_18_axi/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_18_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_gpio/AXI] [get_bd_intf_pins ip_18_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_18_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_18_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_18_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_18_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_18_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_18_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_18_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_emc/AXI] [get_bd_intf_pins ip_18_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_18_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_18_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_intc/AXI] [get_bd_intf_pins ip_18_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_floating_point/S_AXIS_A] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_10_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_2_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_8_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_fft/S_AXIS_DATA] [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_6_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_6_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_3] [get_bd_pins ip_6_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_4] [get_bd_pins ip_6_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_5] [get_bd_pins ip_6_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_6] [get_bd_pins ip_7_accumulator/Q]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/B]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_7_accumulator/Q]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_11_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_7_accumulator/Q]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/ADD]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_18_axi/reset]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_17_intc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_18_axi/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_20_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_fft/M_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_fft/M_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 21 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_CONFIG declared=21 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_CONFIG declared=21 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/M_AXIS_MM2S declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/M_AXIS_MM2S declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_0 declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_0 declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/M_AXIS declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/M_AXIS declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
