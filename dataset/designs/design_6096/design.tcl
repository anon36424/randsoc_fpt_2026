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
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 19 CONFIG.C_GPIO_WIDTH 21 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_0_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO2] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/clk
connect_bd_net [get_bd_pins ip_0_gpio/clk] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/rst
connect_bd_net [get_bd_pins ip_0_gpio/rst] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_0_gpio/gpio_0/S_AXI]


########## axi_dma ##########
create_bd_cell -type hier ip_1_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_1_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 49 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 1024 CONFIG.C_NUM_S2MM_CHANNELS 12 CONFIG.C_S2MM_BURST_SIZE 2 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 19 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 1024 " [get_bd_cells ip_1_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_1_axi_dma/axi_resetn] [get_bd_pins ip_1_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_1_axi_dma/s2mm_introut] [get_bd_pins ip_1_axi_dma/axi_dma_0/s2mm_introut]


########## xadc_wiz ##########
create_bd_cell -type hier ip_2_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_2_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_2_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_2_xadc_wiz/dclk_in] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_2_xadc_wiz/convstclk_in] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
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


########## conv_encoder ##########
create_bd_cell -type hier ip_3_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_3_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 5 CONFIG.convolution_code0 6 CONFIG.convolution_code1 10 CONFIG.convolution_code2 13 CONFIG.convolution_code3 4 CONFIG.convolution_code4 3 CONFIG.convolution_code5 14 CONFIG.convolution_code6 7 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 4 CONFIG.output_rate 6 CONFIG.puncture_code0 1111 CONFIG.puncture_code1 1100 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_3_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_3_conv_encoder/aclk] [get_bd_pins ip_3_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_3_conv_encoder/aclken] [get_bd_pins ip_3_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_3_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_3_conv_encoder/aresetn] [get_bd_pins ip_3_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_iic ##########
create_bd_cell -type hier ip_4_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_4_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x48 CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 195 CONFIG.C_SDA_INERTIAL_DELAY 167 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 921.2206903605497 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_4_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_4_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic/IIC] [get_bd_intf_pins ip_4_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_iic/clk
connect_bd_net [get_bd_pins ip_4_axi_iic/clk] [get_bd_pins ip_4_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_iic/reset
connect_bd_net [get_bd_pins ip_4_axi_iic/reset] [get_bd_pins ip_4_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic/AXI] [get_bd_intf_pins ip_4_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_iic/irq
connect_bd_net [get_bd_pins ip_4_axi_iic/irq] [get_bd_pins ip_4_axi_iic/axi_iic_0/iic2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 5 CONFIG.PARITY No_Parity " [get_bd_cells ip_5_uartlite/uart_0]
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


########## accumulator ##########
create_bd_cell -type hier ip_6_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_6_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 13 CONFIG.Latency 2 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 48 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_6_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_accumulator/clk
connect_bd_net [get_bd_pins ip_6_accumulator/clk] [get_bd_pins ip_6_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 12 -to 0 ip_6_accumulator/B
connect_bd_net [get_bd_pins ip_6_accumulator/B] [get_bd_pins ip_6_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 47 -to 0 ip_6_accumulator/Q
connect_bd_net [get_bd_pins ip_6_accumulator/Q] [get_bd_pins ip_6_accumulator/accumulator_0/Q]


########## axi_iic ##########
create_bd_cell -type hier ip_7_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_7_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0xd CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 165 CONFIG.C_SDA_INERTIAL_DELAY 98 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 754.8293752375732 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_7_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic/IIC] [get_bd_intf_pins ip_7_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_iic/clk
connect_bd_net [get_bd_pins ip_7_axi_iic/clk] [get_bd_pins ip_7_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_iic/reset
connect_bd_net [get_bd_pins ip_7_axi_iic/reset] [get_bd_pins ip_7_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_7_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_iic/irq
connect_bd_net [get_bd_pins ip_7_axi_iic/irq] [get_bd_pins ip_7_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_8_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_8_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_8_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_8_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite/MII] [get_bd_intf_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_8_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_8_axi_ethernet_lite/clk] [get_bd_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_8_axi_ethernet_lite/reset] [get_bd_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_8_axi_ethernet_lite/irq] [get_bd_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_cdma ##########
create_bd_cell -type hier ip_9_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_9_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 59 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_9_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_9_axi_cdma/m_axi_aclk] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_9_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_9_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_cdma/M_AXI] [get_bd_intf_pins ip_9_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_9_axi_cdma/cdma_introut] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/cdma_introut]


########## accumulator ##########
create_bd_cell -type hier ip_10_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_10_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 178 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 188 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_10_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_accumulator/clk
connect_bd_net [get_bd_pins ip_10_accumulator/clk] [get_bd_pins ip_10_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 177 -to 0 ip_10_accumulator/B
connect_bd_net [get_bd_pins ip_10_accumulator/B] [get_bd_pins ip_10_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 187 -to 0 ip_10_accumulator/Q
connect_bd_net [get_bd_pins ip_10_accumulator/Q] [get_bd_pins ip_10_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_10_accumulator/SCLR
connect_bd_net [get_bd_pins ip_10_accumulator/SCLR] [get_bd_pins ip_10_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_10_accumulator/Bypass
connect_bd_net [get_bd_pins ip_10_accumulator/Bypass] [get_bd_pins ip_10_accumulator/accumulator_0/Bypass]


########## microblaze ##########
create_bd_cell -type hier ip_11_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 44 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 2 CONFIG.C_DEBUG_COUNTER_WIDTH 48 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 32 CONFIG.C_DEBUG_EXTERNAL_TRACE 1 CONFIG.C_DEBUG_LATENCY_COUNTERS 0 CONFIG.C_DEBUG_PROFILE_SIZE 0 CONFIG.C_DEBUG_TRACE_SIZE 128 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 2 CONFIG.C_MMU_ITLB_SIZE 1 CONFIG.C_MMU_PRIVILEGED_INSTR 1 CONFIG.C_MMU_TLB_ACCESS 2 CONFIG.C_MMU_ZONES 11 CONFIG.C_NUMBER_OF_PC_BRK 2 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 1 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 3 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0x13 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MMU 2 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_11_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_microblaze/Clk
connect_bd_net [get_bd_pins ip_11_microblaze/Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_microblaze/Reset
connect_bd_net [get_bd_pins ip_11_microblaze/Reset] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_11_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/INTERRUPT] [get_bd_intf_pins ip_11_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/M_AXI_DP] [get_bd_intf_pins ip_11_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_11_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_11_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xe4ecdc0cc1841b4 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_11_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_11_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_11_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_11_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xb0eda685819ac93 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_11_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_11_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_11_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_11_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_11_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 2 " [get_bd_cells ip_11_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_11_microblaze/microblaze_0/DEBUG]


########## axi_iic ##########
create_bd_cell -type hier ip_12_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_12_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x67 CONFIG.C_GPO_WIDTH 4 CONFIG.C_SCL_INERTIAL_DELAY 184 CONFIG.C_SDA_INERTIAL_DELAY 7 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 234.08619807072773 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_12_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_12_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic/IIC] [get_bd_intf_pins ip_12_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_iic/clk
connect_bd_net [get_bd_pins ip_12_axi_iic/clk] [get_bd_pins ip_12_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_iic/reset
connect_bd_net [get_bd_pins ip_12_axi_iic/reset] [get_bd_pins ip_12_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic/AXI] [get_bd_intf_pins ip_12_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_iic/irq
connect_bd_net [get_bd_pins ip_12_axi_iic/irq] [get_bd_pins ip_12_axi_iic/axi_iic_0/iic2intc_irpt]


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


########## axi ##########
create_bd_cell -type hier ip_16_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_16_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 9 CONFIG.NUM_SI 4 " [get_bd_cells ip_16_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi/clk
connect_bd_net [get_bd_pins ip_16_axi/clk] [get_bd_pins ip_16_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi/reset
connect_bd_net [get_bd_pins ip_16_axi/reset] [get_bd_pins ip_16_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_M0] [get_bd_intf_pins ip_16_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_M1] [get_bd_intf_pins ip_16_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_M2] [get_bd_intf_pins ip_16_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_M3] [get_bd_intf_pins ip_16_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S0] [get_bd_intf_pins ip_16_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S1] [get_bd_intf_pins ip_16_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S2] [get_bd_intf_pins ip_16_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S3] [get_bd_intf_pins ip_16_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S4] [get_bd_intf_pins ip_16_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S5] [get_bd_intf_pins ip_16_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S6] [get_bd_intf_pins ip_16_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S7] [get_bd_intf_pins ip_16_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S8] [get_bd_intf_pins ip_16_axi/axi_0/M08_AXI]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_17_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_17_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_17_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_17_axis_dwidth_converter/aclk] [get_bd_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_17_axis_dwidth_converter/aresetn] [get_bd_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_18_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_18_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 128 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_18_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_18_axis_dwidth_converter/aclk] [get_bd_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_18_axis_dwidth_converter/aresetn] [get_bd_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_19_reduce
create_bd_pin -dir I -from 47 -to 0 ip_19_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_19_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_19_reduce/concat]
connect_bd_net [get_bd_pins ip_19_reduce/out0] [get_bd_pins ip_19_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_0]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_19_reduce/slice_0/dout] [get_bd_pins ip_19_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_0/Res] [get_bd_pins ip_19_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_1]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_19_reduce/slice_1/dout] [get_bd_pins ip_19_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_1/Res] [get_bd_pins ip_19_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_2]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_19_reduce/slice_2/dout] [get_bd_pins ip_19_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_2/Res] [get_bd_pins ip_19_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_3]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_19_reduce/slice_3/dout] [get_bd_pins ip_19_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_3/Res] [get_bd_pins ip_19_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_4]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_19_reduce/slice_4/dout] [get_bd_pins ip_19_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_4/Res] [get_bd_pins ip_19_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_5]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_19_reduce/slice_5/dout] [get_bd_pins ip_19_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_5/Res] [get_bd_pins ip_19_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_6]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_19_reduce/slice_6/dout] [get_bd_pins ip_19_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_6/Res] [get_bd_pins ip_19_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 14 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_7]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_19_reduce/slice_7/dout] [get_bd_pins ip_19_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_7/Res] [get_bd_pins ip_19_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_8]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_19_reduce/slice_8/dout] [get_bd_pins ip_19_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_8/Res] [get_bd_pins ip_19_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_9]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_19_reduce/slice_9/dout] [get_bd_pins ip_19_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_9/Res] [get_bd_pins ip_19_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 21 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_10]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_19_reduce/slice_10/dout] [get_bd_pins ip_19_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_10/Res] [get_bd_pins ip_19_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 22 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_11]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_19_reduce/slice_11/dout] [get_bd_pins ip_19_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_11/Res] [get_bd_pins ip_19_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 25 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_12]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_19_reduce/slice_12/dout] [get_bd_pins ip_19_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_12/Res] [get_bd_pins ip_19_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 27 CONFIG.DIN_TO 26 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_13]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_19_reduce/slice_13/dout] [get_bd_pins ip_19_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_13/Res] [get_bd_pins ip_19_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 28 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_14]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_19_reduce/slice_14/dout] [get_bd_pins ip_19_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_14/Res] [get_bd_pins ip_19_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_15]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_19_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_19_reduce/slice_15/dout] [get_bd_pins ip_19_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_15/Res] [get_bd_pins ip_19_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_16]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_19_reduce/slice_16/dout] [get_bd_pins ip_19_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_16/Res] [get_bd_pins ip_19_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 33 CONFIG.DIN_TO 33 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_17]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_19_reduce/slice_17/dout] [get_bd_pins ip_19_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_17/Res] [get_bd_pins ip_19_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 34 CONFIG.DIN_TO 34 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_18]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_19_reduce/slice_18/dout] [get_bd_pins ip_19_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_18/Res] [get_bd_pins ip_19_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 35 CONFIG.DIN_TO 35 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_19]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_19_reduce/slice_19/dout] [get_bd_pins ip_19_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_19/Res] [get_bd_pins ip_19_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 36 CONFIG.DIN_TO 36 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_20]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_19_reduce/slice_20/dout] [get_bd_pins ip_19_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_20/Res] [get_bd_pins ip_19_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 37 CONFIG.DIN_TO 37 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_21]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_19_reduce/slice_21/dout] [get_bd_pins ip_19_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_21/Res] [get_bd_pins ip_19_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 38 CONFIG.DIN_TO 38 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_22]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_19_reduce/slice_22/dout] [get_bd_pins ip_19_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_22/Res] [get_bd_pins ip_19_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 39 CONFIG.DIN_TO 39 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_23]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_19_reduce/slice_23/dout] [get_bd_pins ip_19_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_23/Res] [get_bd_pins ip_19_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 40 CONFIG.DIN_TO 40 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_24]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_19_reduce/slice_24/dout] [get_bd_pins ip_19_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_24/Res] [get_bd_pins ip_19_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 41 CONFIG.DIN_TO 41 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_25]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_19_reduce/slice_25/dout] [get_bd_pins ip_19_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_25/Res] [get_bd_pins ip_19_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 42 CONFIG.DIN_TO 42 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_26]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_19_reduce/slice_26/dout] [get_bd_pins ip_19_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_26/Res] [get_bd_pins ip_19_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 43 CONFIG.DIN_TO 43 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_27]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_19_reduce/slice_27/dout] [get_bd_pins ip_19_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_27/Res] [get_bd_pins ip_19_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 44 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_28]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_19_reduce/slice_28/dout] [get_bd_pins ip_19_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_28/Res] [get_bd_pins ip_19_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 45 CONFIG.DIN_TO 45 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_29]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_19_reduce/slice_29/dout] [get_bd_pins ip_19_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_29/Res] [get_bd_pins ip_19_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 46 CONFIG.DIN_TO 46 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_30]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_19_reduce/slice_30/dout] [get_bd_pins ip_19_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_30/Res] [get_bd_pins ip_19_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 47 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_19_reduce/slice_31]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_19_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_19_reduce/slice_31/dout] [get_bd_pins ip_19_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_31/Res] [get_bd_pins ip_19_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 47 -to 0 ip_20_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_20_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_20_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_20_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 47 -to 0 ip_20_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_20_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_3] [get_bd_pins ip_20_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/slice_3/dout] [get_bd_pins ip_20_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 177 -to 0 ip_21_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_21_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 47 -to 0 ip_21_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 45 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_21_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_21_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/slice_0/dout] [get_bd_pins ip_21_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 187 -to 0 ip_21_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 174 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 188 " [get_bd_cells ip_21_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_1] [get_bd_pins ip_21_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/slice_1/dout] [get_bd_pins ip_21_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_22_slice_and_concat/out0
create_bd_pin -dir I -from 187 -to 0 ip_22_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 187 CONFIG.DIN_TO 175 CONFIG.DIN_WIDTH 188 " [get_bd_cells ip_22_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/slice_0/dout]


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
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_14_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO] [get_bd_intf_pins ip_0_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO2] [get_bd_intf_pins ip_0_gpio/GPIO2]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_4_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic_IIC] [get_bd_intf_pins ip_4_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic_IIC] [get_bd_intf_pins ip_7_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_8_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite_MII] [get_bd_intf_pins ip_8_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_8_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_8_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_12_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic_IIC] [get_bd_intf_pins ip_12_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_19_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_0_gpio/rst]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_3_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_iic/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_iic/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_13_reset/mb_reset] [get_bd_pins ip_11_microblaze/Reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_iic/reset]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_0_gpio/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_2_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_2_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_3_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_4_axi_iic/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_6_accumulator/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_7_axi_iic/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_8_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_10_accumulator/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_11_microblaze/Clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_12_axi_iic/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_13_reset/clk_in]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_locked] [get_bd_pins ip_13_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_15_intc/irq_0] [get_bd_pins ip_1_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_15_intc/irq_1] [get_bd_pins ip_4_axi_iic/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_2] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_3] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_4] [get_bd_pins ip_8_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_5] [get_bd_pins ip_9_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_15_intc/irq_6] [get_bd_pins ip_12_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_microblaze/INTERRUPT] [get_bd_intf_pins ip_15_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_16_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_16_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/M_AXI] [get_bd_intf_pins ip_16_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_microblaze/M_AXI_DP] [get_bd_intf_pins ip_16_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_16_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_16_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_iic/AXI] [get_bd_intf_pins ip_16_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_16_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_16_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_16_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_16_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_iic/AXI] [get_bd_intf_pins ip_16_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_intc/AXI] [get_bd_intf_pins ip_16_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_19_reduce/in0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_2_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_2_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_3] [get_bd_pins ip_6_accumulator/Q]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_10_accumulator/B]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_6_accumulator/Q]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_1] [get_bd_pins ip_10_accumulator/Q]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_6_accumulator/B]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_10_accumulator/Q]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_10_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_10_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_3_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_16_axi/reset]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_15_intc/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_16_axi/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_17_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_18_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 1024 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/S_AXIS_S2MM declared=1024 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/S_AXIS_S2MM declared=1024 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 1024 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=1024 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=1024 actual=ERR $__err" }


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
