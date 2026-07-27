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
set_property -dict "CONFIG.C_BAUDRATE 1200 CONFIG.C_DATA_BITS 5 CONFIG.PARITY No_Parity " [get_bd_cells ip_0_uartlite/uart_0]
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


########## gpio ##########
create_bd_cell -type hier ip_1_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_1_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x7ffffff CONFIG.C_DOUT_DEFAULT_2 0x63583a8 CONFIG.C_GPIO2_WIDTH 10 CONFIG.C_GPIO_WIDTH 27 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_1_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio/GPIO] [get_bd_intf_pins ip_1_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio/GPIO2] [get_bd_intf_pins ip_1_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_1_gpio/clk
connect_bd_net [get_bd_pins ip_1_gpio/clk] [get_bd_pins ip_1_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_gpio/rst
connect_bd_net [get_bd_pins ip_1_gpio/rst] [get_bd_pins ip_1_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio/AXI] [get_bd_intf_pins ip_1_gpio/gpio_0/S_AXI]


########## uartlite ##########
create_bd_cell -type hier ip_2_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_2_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 2400 CONFIG.C_DATA_BITS 6 CONFIG.PARITY No_Parity " [get_bd_cells ip_2_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite/UART] [get_bd_intf_pins ip_2_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_2_uartlite/clk
connect_bd_net [get_bd_pins ip_2_uartlite/clk] [get_bd_pins ip_2_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_uartlite/reset
connect_bd_net [get_bd_pins ip_2_uartlite/reset] [get_bd_pins ip_2_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_2_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_uartlite/irq
connect_bd_net [get_bd_pins ip_2_uartlite/irq] [get_bd_pins ip_2_uartlite/uart_0/interrupt]


########## axi_dma ##########
create_bd_cell -type hier ip_3_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_3_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 63 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 128 CONFIG.C_S2MM_BURST_SIZE 2 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 17 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_3_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_3_axi_dma/axi_resetn] [get_bd_pins ip_3_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_3_axi_dma/s2mm_introut] [get_bd_pins ip_3_axi_dma/axi_dma_0/s2mm_introut]


########## conv_encoder ##########
create_bd_cell -type hier ip_4_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_4_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 9 CONFIG.convolution_code0 395 CONFIG.convolution_code1 198 CONFIG.convolution_code2 474 CONFIG.convolution_code3 440 CONFIG.convolution_code4 150 CONFIG.convolution_code5 313 CONFIG.convolution_code6 195 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 3 CONFIG.output_rate 5 CONFIG.puncture_code0 101 CONFIG.puncture_code1 111 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_4_conv_encoder/conv_encoder_0]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_5_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_5_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 1 CONFIG.C_SPI_MEMORY 2 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_5_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_5_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/IIC] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_5_axi_quad_spi/STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/STARTUP_IO_S] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/STARTUP_IO_S]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/clk] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/reset] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/clk4] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/reset4] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/irq] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## axi_cdma ##########
create_bd_cell -type hier ip_6_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_6_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 58 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_6_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_6_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_6_axi_cdma/m_axi_aclk] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_6_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_6_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_cdma/M_AXI] [get_bd_intf_pins ip_6_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_6_axi_cdma/cdma_introut] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_iic ##########
create_bd_cell -type hier ip_7_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_7_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x77 CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 29 CONFIG.C_SDA_INERTIAL_DELAY 56 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 784.1539192417027 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_7_axi_iic/axi_iic_0]
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


########## xadc_wiz ##########
create_bd_cell -type hier ip_8_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_8_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_TEMP_BUS 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_8_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_8_xadc_wiz/s_axi_aclk] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_8_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_8_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_8_xadc_wiz/convst_in] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_8_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_8_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_8_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_8_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_8_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_8_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_8_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_8_xadc_wiz/eoc_out] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_8_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_8_xadc_wiz/eos_out] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_8_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_8_xadc_wiz/alarm_out] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_8_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_8_xadc_wiz/busy_out] [get_bd_pins ip_8_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_8_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_8_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_8_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## axi_iic ##########
create_bd_cell -type hier ip_9_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_9_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x53 CONFIG.C_GPO_WIDTH 7 CONFIG.C_SCL_INERTIAL_DELAY 56 CONFIG.C_SDA_INERTIAL_DELAY 80 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 945.9693286365052 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_9_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_9_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic/IIC] [get_bd_intf_pins ip_9_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_iic/clk
connect_bd_net [get_bd_pins ip_9_axi_iic/clk] [get_bd_pins ip_9_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_iic/reset
connect_bd_net [get_bd_pins ip_9_axi_iic/reset] [get_bd_pins ip_9_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic/AXI] [get_bd_intf_pins ip_9_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_iic/irq
connect_bd_net [get_bd_pins ip_9_axi_iic/irq] [get_bd_pins ip_9_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_hwicap ##########
create_bd_cell -type hier ip_10_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_10_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 1 " [get_bd_cells ip_10_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_10_axi_hwicap/icap_clk] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_10_axi_hwicap/eos_in] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_10_axi_hwicap/s_axi_aclk] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_10_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_10_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_10_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap/ICAP] [get_bd_intf_pins ip_10_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_10_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_10_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## microblaze ##########
create_bd_cell -type hier ip_11_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 64 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 2 CONFIG.C_DEBUG_COUNTER_WIDTH 48 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 19 CONFIG.C_DEBUG_EXTERNAL_TRACE 1 CONFIG.C_DEBUG_LATENCY_COUNTERS 5 CONFIG.C_DEBUG_PROFILE_SIZE 0 CONFIG.C_DEBUG_TRACE_SIZE 32 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 1 CONFIG.C_MMU_ITLB_SIZE 4 CONFIG.C_MMU_PRIVILEGED_INSTR 3 CONFIG.C_MMU_TLB_ACCESS 2 CONFIG.C_MMU_ZONES 5 CONFIG.C_NUMBER_OF_PC_BRK 7 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 0 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 1 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0x4d CONFIG.C_PVR_USER2 0x79edc875 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 0 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MMU 3 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_11_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_11_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_11_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x5bbe1c814814ea5 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_11_microblaze/lmb_ctrl_d]
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
set_property -dict "CONFIG.C_MASK 0xa99d58b50735c75 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_11_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_11_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_11_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_11_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_11_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 1 " [get_bd_cells ip_11_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_11_microblaze/microblaze_0/DEBUG]


########## complex_multiplier ##########
create_bd_cell -type hier ip_12_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_12_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 14 CONFIG.aresetn 1 CONFIG.atuserwidth 117 CONFIG.bportwidth 27 CONFIG.ctrltuserwidth 69 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 3 CONFIG.roundmode Random_Rounding " [get_bd_cells ip_12_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_12_complex_multiplier/aclk] [get_bd_pins ip_12_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_12_complex_multiplier/aresetn] [get_bd_pins ip_12_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_12_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_12_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_12_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_12_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_12_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_12_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_12_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_12_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## gpio ##########
create_bd_cell -type hier ip_13_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_13_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x7fffff CONFIG.C_DOUT_DEFAULT_2 0xe39b1 CONFIG.C_GPIO2_WIDTH 20 CONFIG.C_GPIO_WIDTH 23 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x7fffff CONFIG.C_TRI_DEFAULT_2 0x69c88f " [get_bd_cells ip_13_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_13_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_13_gpio/GPIO] [get_bd_intf_pins ip_13_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_13_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_13_gpio/GPIO2] [get_bd_intf_pins ip_13_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_13_gpio/clk
connect_bd_net [get_bd_pins ip_13_gpio/clk] [get_bd_pins ip_13_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_gpio/rst
connect_bd_net [get_bd_pins ip_13_gpio/rst] [get_bd_pins ip_13_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_gpio/AXI] [get_bd_intf_pins ip_13_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_13_gpio/irq
connect_bd_net [get_bd_pins ip_13_gpio/irq] [get_bd_pins ip_13_gpio/gpio_0/ip2intc_irpt]


########## axi_cdma ##########
create_bd_cell -type hier ip_14_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_14_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 55 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 128 CONFIG.C_M_AXI_MAX_BURST_LEN 4 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_14_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_14_axi_cdma/m_axi_aclk] [get_bd_pins ip_14_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_14_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_14_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_14_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_14_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_cdma/M_AXI] [get_bd_intf_pins ip_14_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_14_axi_cdma/cdma_introut] [get_bd_pins ip_14_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_cdma ##########
create_bd_cell -type hier ip_15_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_15_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 46 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 8 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_15_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_15_axi_cdma/m_axi_aclk] [get_bd_pins ip_15_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_15_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_15_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_15_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_15_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_cdma/M_AXI] [get_bd_intf_pins ip_15_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_15_axi_cdma/cdma_introut] [get_bd_pins ip_15_axi_cdma/axi_cdma_0/cdma_introut]


########## microblaze ##########
create_bd_cell -type hier ip_16_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 52 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 6 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 1 CONFIG.C_NUMBER_OF_PC_BRK 6 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 0 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 0 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0xdd CONFIG.C_PVR_USER2 0xafef6392 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 0 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_16_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_microblaze/Clk
connect_bd_net [get_bd_pins ip_16_microblaze/Clk] [get_bd_pins ip_16_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_16_microblaze/Reset
connect_bd_net [get_bd_pins ip_16_microblaze/Reset] [get_bd_pins ip_16_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_16_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/INTERRUPT] [get_bd_intf_pins ip_16_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/M_AXI_DP] [get_bd_intf_pins ip_16_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_16_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_16_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_16_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_16_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x88b152e3e146581 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_16_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_16_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_16_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_16_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_16_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_16_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_16_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_16_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xd094dd9d4a64119 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_16_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_16_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_16_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_16_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_16_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_16_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_16_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 4 " [get_bd_cells ip_16_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_16_microblaze/microblaze_0/DEBUG]


########## cordic ##########
create_bd_cell -type hier ip_17_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_17_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Rotate CONFIG.Input_Width 9 CONFIG.Iterations 20 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 26 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 42 CONFIG.Round_Mode Round_Pos_Inf " [get_bd_cells ip_17_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_cordic/aclk
connect_bd_net [get_bd_pins ip_17_cordic/aclk] [get_bd_pins ip_17_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_cordic/aresetn
connect_bd_net [get_bd_pins ip_17_cordic/aresetn] [get_bd_pins ip_17_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_17_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_17_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_17_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_17_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_17_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_17_cordic/cordic_0/M_AXIS_DOUT]


########## gpio ##########
create_bd_cell -type hier ip_18_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_18_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x1fff CONFIG.C_DOUT_DEFAULT_2 0x8ad CONFIG.C_GPIO2_WIDTH 6 CONFIG.C_GPIO_WIDTH 13 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x16a CONFIG.C_TRI_DEFAULT_2 0x0 " [get_bd_cells ip_18_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_18_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_18_gpio/GPIO] [get_bd_intf_pins ip_18_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_18_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_18_gpio/GPIO2] [get_bd_intf_pins ip_18_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_18_gpio/clk
connect_bd_net [get_bd_pins ip_18_gpio/clk] [get_bd_pins ip_18_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_gpio/rst
connect_bd_net [get_bd_pins ip_18_gpio/rst] [get_bd_pins ip_18_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_gpio/AXI] [get_bd_intf_pins ip_18_gpio/gpio_0/S_AXI]


########## gpio ##########
create_bd_cell -type hier ip_19_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_19_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 18 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_19_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_19_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio/GPIO] [get_bd_intf_pins ip_19_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_19_gpio/clk
connect_bd_net [get_bd_pins ip_19_gpio/clk] [get_bd_pins ip_19_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_gpio/rst
connect_bd_net [get_bd_pins ip_19_gpio/rst] [get_bd_pins ip_19_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio/AXI] [get_bd_intf_pins ip_19_gpio/gpio_0/S_AXI]


########## dft ##########
create_bd_cell -type hier ip_20_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_20_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 12 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_20_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/CLK
connect_bd_net [get_bd_pins ip_20_dft/CLK] [get_bd_pins ip_20_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/CE
connect_bd_net [get_bd_pins ip_20_dft/CE] [get_bd_pins ip_20_dft/dft_0/CE]
create_bd_pin -dir I -from 11 -to 0 ip_20_dft/XN_RE
connect_bd_net [get_bd_pins ip_20_dft/XN_RE] [get_bd_pins ip_20_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 11 -to 0 ip_20_dft/XN_IM
connect_bd_net [get_bd_pins ip_20_dft/XN_IM] [get_bd_pins ip_20_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/FD_IN
connect_bd_net [get_bd_pins ip_20_dft/FD_IN] [get_bd_pins ip_20_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/FWD_INV
connect_bd_net [get_bd_pins ip_20_dft/FWD_INV] [get_bd_pins ip_20_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_20_dft/SIZE
connect_bd_net [get_bd_pins ip_20_dft/SIZE] [get_bd_pins ip_20_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_20_dft/RFFD
connect_bd_net [get_bd_pins ip_20_dft/RFFD] [get_bd_pins ip_20_dft/dft_0/RFFD]
create_bd_pin -dir O -from 11 -to 0 ip_20_dft/XK_RE
connect_bd_net [get_bd_pins ip_20_dft/XK_RE] [get_bd_pins ip_20_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 11 -to 0 ip_20_dft/XK_IM
connect_bd_net [get_bd_pins ip_20_dft/XK_IM] [get_bd_pins ip_20_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_20_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_20_dft/BLK_EXP] [get_bd_pins ip_20_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_20_dft/FD_OUT
connect_bd_net [get_bd_pins ip_20_dft/FD_OUT] [get_bd_pins ip_20_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_20_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_20_dft/DATA_VALID] [get_bd_pins ip_20_dft/dft_0/DATA_VALID]


########## axi_cdma ##########
create_bd_cell -type hier ip_21_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_21_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 59 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 4 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_21_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_21_axi_cdma/m_axi_aclk] [get_bd_pins ip_21_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_21_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_21_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_21_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_21_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_cdma/M_AXI] [get_bd_intf_pins ip_21_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_21_axi_cdma/cdma_introut] [get_bd_pins ip_21_axi_cdma/axi_cdma_0/cdma_introut]


########## emc ##########
create_bd_cell -type hier ip_22_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_22_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 0 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 8 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 8 CONFIG.C_MEM3_TYPE 1 CONFIG.C_MEM3_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_SYNCH_PIPEDELAY_0 1 CONFIG.C_SYNCH_PIPEDELAY_1 1 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 9 CONFIG.C_TAVDV_PS_MEM_2 13745 CONFIG.C_TAVDV_PS_MEM_3 15290 CONFIG.C_TCEDV_PS_MEM_2 15021 CONFIG.C_TCEDV_PS_MEM_3 15045 CONFIG.C_THZCE_PS_MEM_2 7274 CONFIG.C_THZCE_PS_MEM_3 7568 CONFIG.C_THZOE_PS_MEM_2 7205 CONFIG.C_THZOE_PS_MEM_3 7398 CONFIG.C_TLZWE_PS_MEM_2 5145 CONFIG.C_TLZWE_PS_MEM_3 1316 CONFIG.C_TWC_PS_MEM_2 14746 CONFIG.C_TWC_PS_MEM_3 15686 CONFIG.C_TWPH_PS_MEM_2 12006 CONFIG.C_TWPH_PS_MEM_3 11058 CONFIG.C_TWP_PS_MEM_2 13189 CONFIG.C_TWP_PS_MEM_3 12046 CONFIG.C_WR_REC_TIME_MEM_2 26509 CONFIG.C_WR_REC_TIME_MEM_3 25960 " [get_bd_cells ip_22_emc/emc_0]
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


########## dft ##########
create_bd_cell -type hier ip_23_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_23_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 12 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_23_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_dft/CLK
connect_bd_net [get_bd_pins ip_23_dft/CLK] [get_bd_pins ip_23_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_23_dft/SCLR
connect_bd_net [get_bd_pins ip_23_dft/SCLR] [get_bd_pins ip_23_dft/dft_0/SCLR]
create_bd_pin -dir I -from 11 -to 0 ip_23_dft/XN_RE
connect_bd_net [get_bd_pins ip_23_dft/XN_RE] [get_bd_pins ip_23_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 11 -to 0 ip_23_dft/XN_IM
connect_bd_net [get_bd_pins ip_23_dft/XN_IM] [get_bd_pins ip_23_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_23_dft/FD_IN
connect_bd_net [get_bd_pins ip_23_dft/FD_IN] [get_bd_pins ip_23_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_23_dft/FWD_INV
connect_bd_net [get_bd_pins ip_23_dft/FWD_INV] [get_bd_pins ip_23_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_23_dft/SIZE
connect_bd_net [get_bd_pins ip_23_dft/SIZE] [get_bd_pins ip_23_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_23_dft/RFFD
connect_bd_net [get_bd_pins ip_23_dft/RFFD] [get_bd_pins ip_23_dft/dft_0/RFFD]
create_bd_pin -dir O -from 11 -to 0 ip_23_dft/XK_RE
connect_bd_net [get_bd_pins ip_23_dft/XK_RE] [get_bd_pins ip_23_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 11 -to 0 ip_23_dft/XK_IM
connect_bd_net [get_bd_pins ip_23_dft/XK_IM] [get_bd_pins ip_23_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_23_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_23_dft/BLK_EXP] [get_bd_pins ip_23_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_23_dft/FD_OUT
connect_bd_net [get_bd_pins ip_23_dft/FD_OUT] [get_bd_pins ip_23_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_23_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_23_dft/DATA_VALID] [get_bd_pins ip_23_dft/dft_0/DATA_VALID]


########## accumulator ##########
create_bd_cell -type hier ip_24_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_24_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 10 CONFIG.Latency 2 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 18 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_24_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_accumulator/clk
connect_bd_net [get_bd_pins ip_24_accumulator/clk] [get_bd_pins ip_24_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 9 -to 0 ip_24_accumulator/B
connect_bd_net [get_bd_pins ip_24_accumulator/B] [get_bd_pins ip_24_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 17 -to 0 ip_24_accumulator/Q
connect_bd_net [get_bd_pins ip_24_accumulator/Q] [get_bd_pins ip_24_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_24_accumulator/C_IN
connect_bd_net [get_bd_pins ip_24_accumulator/C_IN] [get_bd_pins ip_24_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_24_accumulator/SCLR
connect_bd_net [get_bd_pins ip_24_accumulator/SCLR] [get_bd_pins ip_24_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_24_accumulator/Bypass
connect_bd_net [get_bd_pins ip_24_accumulator/Bypass] [get_bd_pins ip_24_accumulator/accumulator_0/Bypass]


########## axi_iic ##########
create_bd_cell -type hier ip_25_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_25_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0xb CONFIG.C_GPO_WIDTH 4 CONFIG.C_SCL_INERTIAL_DELAY 116 CONFIG.C_SDA_INERTIAL_DELAY 7 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 900.9824748223997 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_25_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_25_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic/IIC] [get_bd_intf_pins ip_25_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_iic/clk
connect_bd_net [get_bd_pins ip_25_axi_iic/clk] [get_bd_pins ip_25_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_iic/reset
connect_bd_net [get_bd_pins ip_25_axi_iic/reset] [get_bd_pins ip_25_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic/AXI] [get_bd_intf_pins ip_25_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_25_axi_iic/irq
connect_bd_net [get_bd_pins ip_25_axi_iic/irq] [get_bd_pins ip_25_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_timer ##########
create_bd_cell -type hier ip_26_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_26_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_26_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_timer/S_AXI] [get_bd_intf_pins ip_26_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_26_axi_timer/capturetrig0] [get_bd_pins ip_26_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_timer/freeze
connect_bd_net [get_bd_pins ip_26_axi_timer/freeze] [get_bd_pins ip_26_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_26_axi_timer/s_axi_aclk] [get_bd_pins ip_26_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_26_axi_timer/s_axi_aresetn] [get_bd_pins ip_26_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_26_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_26_axi_timer/generateout0] [get_bd_pins ip_26_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_26_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_26_axi_timer/generateout1] [get_bd_pins ip_26_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_26_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_26_axi_timer/pwm0] [get_bd_pins ip_26_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_26_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_26_axi_timer/interrupt] [get_bd_pins ip_26_axi_timer/axi_timer_0/interrupt]


########## floating_point ##########
create_bd_cell -type hier ip_27_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_27_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Int64 CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Performance CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.c_result_exponent_width 9 CONFIG.c_result_fraction_width 13 CONFIG.flow_control Blocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 1 CONFIG.maximum_latency 1 CONFIG.operation_type Fixed_to_float CONFIG.result_precision_type Custom " [get_bd_cells ip_27_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_floating_point/aclk
connect_bd_net [get_bd_pins ip_27_floating_point/aclk] [get_bd_pins ip_27_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_floating_point/aclken
connect_bd_net [get_bd_pins ip_27_floating_point/aclken] [get_bd_pins ip_27_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_27_floating_point/aresetn
connect_bd_net [get_bd_pins ip_27_floating_point/aresetn] [get_bd_pins ip_27_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_27_floating_point/S_AXIS_A] [get_bd_intf_pins ip_27_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_27_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_27_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_28_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_28_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_28_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_28_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_28_axi_ethernet_lite/MII] [get_bd_intf_pins ip_28_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_28_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_28_axi_ethernet_lite/clk] [get_bd_pins ip_28_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_28_axi_ethernet_lite/reset] [get_bd_pins ip_28_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_28_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_28_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_28_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_28_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_28_axi_ethernet_lite/irq] [get_bd_pins ip_28_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_29_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_29_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 3 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 4 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 9 CONFIG.C_TAVDV_PS_MEM_0 14588 CONFIG.C_TAVDV_PS_MEM_1 15181 CONFIG.C_TAVDV_PS_MEM_2 15354 CONFIG.C_TAVDV_PS_MEM_3 16361 CONFIG.C_TCEDV_PS_MEM_0 15412 CONFIG.C_TCEDV_PS_MEM_1 14859 CONFIG.C_TCEDV_PS_MEM_2 13500 CONFIG.C_TCEDV_PS_MEM_3 15643 CONFIG.C_THZCE_PS_MEM_0 7460 CONFIG.C_THZCE_PS_MEM_1 7487 CONFIG.C_THZCE_PS_MEM_2 6660 CONFIG.C_THZCE_PS_MEM_3 7044 CONFIG.C_THZOE_PS_MEM_0 7341 CONFIG.C_THZOE_PS_MEM_1 6571 CONFIG.C_THZOE_PS_MEM_2 7689 CONFIG.C_THZOE_PS_MEM_3 6569 CONFIG.C_TLZWE_PS_MEM_0 9123 CONFIG.C_TLZWE_PS_MEM_1 2756 CONFIG.C_TLZWE_PS_MEM_2 7980 CONFIG.C_TLZWE_PS_MEM_3 9641 CONFIG.C_TWC_PS_MEM_0 13812 CONFIG.C_TWC_PS_MEM_1 16060 CONFIG.C_TWC_PS_MEM_2 13956 CONFIG.C_TWC_PS_MEM_3 13777 CONFIG.C_TWPH_PS_MEM_0 13034 CONFIG.C_TWPH_PS_MEM_1 11021 CONFIG.C_TWPH_PS_MEM_2 12300 CONFIG.C_TWPH_PS_MEM_3 12614 CONFIG.C_TWP_PS_MEM_0 11549 CONFIG.C_TWP_PS_MEM_1 11255 CONFIG.C_TWP_PS_MEM_2 10937 CONFIG.C_TWP_PS_MEM_3 13180 CONFIG.C_WR_REC_TIME_MEM_0 28410 CONFIG.C_WR_REC_TIME_MEM_1 25058 CONFIG.C_WR_REC_TIME_MEM_2 26519 CONFIG.C_WR_REC_TIME_MEM_3 25519 " [get_bd_cells ip_29_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_29_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_29_emc/EMC_INTF] [get_bd_intf_pins ip_29_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_29_emc/clk
connect_bd_net [get_bd_pins ip_29_emc/clk] [get_bd_pins ip_29_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_emc/rdclk
connect_bd_net [get_bd_pins ip_29_emc/rdclk] [get_bd_pins ip_29_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_emc/rst
connect_bd_net [get_bd_pins ip_29_emc/rst] [get_bd_pins ip_29_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_29_emc/AXI] [get_bd_intf_pins ip_29_emc/emc_0/S_AXI_MEM]


########## reset ##########
create_bd_cell -type hier ip_30_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_30_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_reset/clk_in
connect_bd_net [get_bd_pins ip_30_reset/clk_in] [get_bd_pins ip_30_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_30_reset/reset_in
connect_bd_net [get_bd_pins ip_30_reset/reset_in] [get_bd_pins ip_30_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_30_reset/dcm_locked
connect_bd_net [get_bd_pins ip_30_reset/dcm_locked] [get_bd_pins ip_30_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_30_reset/mb_reset
connect_bd_net [get_bd_pins ip_30_reset/mb_reset] [get_bd_pins ip_30_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_30_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_30_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_30_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset] [get_bd_pins ip_30_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_30_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_30_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_31_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_31_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_in] [get_bd_pins ip_31_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_31_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_31_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_31_clk_wiz/reset
connect_bd_net [get_bd_pins ip_31_clk_wiz/reset] [get_bd_pins ip_31_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_31_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_locked] [get_bd_pins ip_31_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_32_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_32_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_32_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 16 " [get_bd_cells ip_32_intc/concat_0]
connect_bd_net [get_bd_pins ip_32_intc/concat_0/dout] [get_bd_pins ip_32_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/clk
connect_bd_net [get_bd_pins ip_32_intc/clk] [get_bd_pins ip_32_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/reset
connect_bd_net [get_bd_pins ip_32_intc/reset] [get_bd_pins ip_32_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_32_intc/AXI] [get_bd_intf_pins ip_32_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_0
connect_bd_net [get_bd_pins ip_32_intc/irq_0] [get_bd_pins ip_32_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_1
connect_bd_net [get_bd_pins ip_32_intc/irq_1] [get_bd_pins ip_32_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_2
connect_bd_net [get_bd_pins ip_32_intc/irq_2] [get_bd_pins ip_32_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_3
connect_bd_net [get_bd_pins ip_32_intc/irq_3] [get_bd_pins ip_32_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_4
connect_bd_net [get_bd_pins ip_32_intc/irq_4] [get_bd_pins ip_32_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_5
connect_bd_net [get_bd_pins ip_32_intc/irq_5] [get_bd_pins ip_32_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_6
connect_bd_net [get_bd_pins ip_32_intc/irq_6] [get_bd_pins ip_32_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_7
connect_bd_net [get_bd_pins ip_32_intc/irq_7] [get_bd_pins ip_32_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_8
connect_bd_net [get_bd_pins ip_32_intc/irq_8] [get_bd_pins ip_32_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_9
connect_bd_net [get_bd_pins ip_32_intc/irq_9] [get_bd_pins ip_32_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_10
connect_bd_net [get_bd_pins ip_32_intc/irq_10] [get_bd_pins ip_32_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_11
connect_bd_net [get_bd_pins ip_32_intc/irq_11] [get_bd_pins ip_32_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_12
connect_bd_net [get_bd_pins ip_32_intc/irq_12] [get_bd_pins ip_32_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_13
connect_bd_net [get_bd_pins ip_32_intc/irq_13] [get_bd_pins ip_32_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_14
connect_bd_net [get_bd_pins ip_32_intc/irq_14] [get_bd_pins ip_32_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_15
connect_bd_net [get_bd_pins ip_32_intc/irq_15] [get_bd_pins ip_32_intc/concat_0/In15]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_32_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_32_intc/irq] [get_bd_intf_pins ip_32_intc/intc_0/interrupt]


########## intc ##########
create_bd_cell -type hier ip_33_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_33_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_33_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 16 " [get_bd_cells ip_33_intc/concat_0]
connect_bd_net [get_bd_pins ip_33_intc/concat_0/dout] [get_bd_pins ip_33_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/clk
connect_bd_net [get_bd_pins ip_33_intc/clk] [get_bd_pins ip_33_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/reset
connect_bd_net [get_bd_pins ip_33_intc/reset] [get_bd_pins ip_33_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_33_intc/AXI] [get_bd_intf_pins ip_33_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_0
connect_bd_net [get_bd_pins ip_33_intc/irq_0] [get_bd_pins ip_33_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_1
connect_bd_net [get_bd_pins ip_33_intc/irq_1] [get_bd_pins ip_33_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_2
connect_bd_net [get_bd_pins ip_33_intc/irq_2] [get_bd_pins ip_33_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_3
connect_bd_net [get_bd_pins ip_33_intc/irq_3] [get_bd_pins ip_33_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_4
connect_bd_net [get_bd_pins ip_33_intc/irq_4] [get_bd_pins ip_33_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_5
connect_bd_net [get_bd_pins ip_33_intc/irq_5] [get_bd_pins ip_33_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_6
connect_bd_net [get_bd_pins ip_33_intc/irq_6] [get_bd_pins ip_33_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_7
connect_bd_net [get_bd_pins ip_33_intc/irq_7] [get_bd_pins ip_33_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_8
connect_bd_net [get_bd_pins ip_33_intc/irq_8] [get_bd_pins ip_33_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_9
connect_bd_net [get_bd_pins ip_33_intc/irq_9] [get_bd_pins ip_33_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_10
connect_bd_net [get_bd_pins ip_33_intc/irq_10] [get_bd_pins ip_33_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_11
connect_bd_net [get_bd_pins ip_33_intc/irq_11] [get_bd_pins ip_33_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_12
connect_bd_net [get_bd_pins ip_33_intc/irq_12] [get_bd_pins ip_33_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_13
connect_bd_net [get_bd_pins ip_33_intc/irq_13] [get_bd_pins ip_33_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_14
connect_bd_net [get_bd_pins ip_33_intc/irq_14] [get_bd_pins ip_33_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_15
connect_bd_net [get_bd_pins ip_33_intc/irq_15] [get_bd_pins ip_33_intc/concat_0/In15]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_33_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_33_intc/irq] [get_bd_intf_pins ip_33_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_34_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_34_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 7 " [get_bd_cells ip_34_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axi/clk
connect_bd_net [get_bd_pins ip_34_axi/clk] [get_bd_pins ip_34_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axi/reset
connect_bd_net [get_bd_pins ip_34_axi/reset] [get_bd_pins ip_34_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_34_axi/AXI_M0] [get_bd_intf_pins ip_34_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_34_axi/AXI_M1] [get_bd_intf_pins ip_34_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_34_axi/AXI_M2] [get_bd_intf_pins ip_34_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_34_axi/AXI_M3] [get_bd_intf_pins ip_34_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_34_axi/AXI_M4] [get_bd_intf_pins ip_34_axi/axi_0/S04_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_34_axi/AXI_M5] [get_bd_intf_pins ip_34_axi/axi_0/S05_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi/AXI_M6
connect_bd_intf_net [get_bd_intf_pins ip_34_axi/AXI_M6] [get_bd_intf_pins ip_34_axi/axi_0/S06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_34_axi/AXI_S0] [get_bd_intf_pins ip_34_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_34_axi/AXI_S1] [get_bd_intf_pins ip_34_axi/axi_0/M01_AXI]


########## axi ##########
create_bd_cell -type hier ip_35_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_35_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_35_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axi/clk
connect_bd_net [get_bd_pins ip_35_axi/clk] [get_bd_pins ip_35_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_35_axi/reset
connect_bd_net [get_bd_pins ip_35_axi/reset] [get_bd_pins ip_35_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_M0] [get_bd_intf_pins ip_35_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S0] [get_bd_intf_pins ip_35_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S1] [get_bd_intf_pins ip_35_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S2] [get_bd_intf_pins ip_35_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S3] [get_bd_intf_pins ip_35_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S4] [get_bd_intf_pins ip_35_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S5] [get_bd_intf_pins ip_35_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S6] [get_bd_intf_pins ip_35_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S7] [get_bd_intf_pins ip_35_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S8] [get_bd_intf_pins ip_35_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S9] [get_bd_intf_pins ip_35_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S10] [get_bd_intf_pins ip_35_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S11] [get_bd_intf_pins ip_35_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S12] [get_bd_intf_pins ip_35_axi/axi_0/M12_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S13] [get_bd_intf_pins ip_35_axi/axi_0/M13_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S14] [get_bd_intf_pins ip_35_axi/axi_0/M14_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_35_axi/AXI_S15] [get_bd_intf_pins ip_35_axi/axi_0/M15_AXI]


########## axi ##########
create_bd_cell -type hier ip_36_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_36_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 7 CONFIG.NUM_SI 1 " [get_bd_cells ip_36_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axi/clk
connect_bd_net [get_bd_pins ip_36_axi/clk] [get_bd_pins ip_36_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axi/reset
connect_bd_net [get_bd_pins ip_36_axi/reset] [get_bd_pins ip_36_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_36_axi/AXI_M0] [get_bd_intf_pins ip_36_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_36_axi/AXI_S0] [get_bd_intf_pins ip_36_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_36_axi/AXI_S1] [get_bd_intf_pins ip_36_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_36_axi/AXI_S2] [get_bd_intf_pins ip_36_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_36_axi/AXI_S3] [get_bd_intf_pins ip_36_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_36_axi/AXI_S4] [get_bd_intf_pins ip_36_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_36_axi/AXI_S5] [get_bd_intf_pins ip_36_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_36_axi/AXI_S6] [get_bd_intf_pins ip_36_axi/axi_0/M06_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_37_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_37_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_37_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


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
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_39_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 3 " [get_bd_cells ip_44_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_46_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_47_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aclk] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aresetn] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_48_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_48_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_48_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_48_axis_combiner/aclk] [get_bd_pins ip_48_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_48_axis_combiner/aresetn] [get_bd_pins ip_48_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/M_AXIS] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_49_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_49_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_49_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aclk] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aresetn] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_50_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_50_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_50_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_50_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_50_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_1] [get_bd_pins ip_50_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_50_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_2] [get_bd_pins ip_50_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_50_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_3] [get_bd_pins ip_50_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 11 -to 0 ip_50_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_50_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_4] [get_bd_pins ip_50_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/slice_4/dout] [get_bd_pins ip_50_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_51_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_51_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_51_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_51_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_51_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_51_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_51_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_51_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/slice_0/dout] [get_bd_pins ip_51_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 11 -to 0 ip_51_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_51_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_51_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_1] [get_bd_pins ip_51_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/slice_1/dout] [get_bd_pins ip_51_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_52_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_52_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_52_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_52_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_52_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_52_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_52_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/slice_0/dout] [get_bd_pins ip_52_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_52_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_1] [get_bd_pins ip_52_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_52_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_2] [get_bd_pins ip_52_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_52_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_3] [get_bd_pins ip_52_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_53_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_53_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_53_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_53_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 11 -to 0 ip_53_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_1] [get_bd_pins ip_53_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 11 -to 0 ip_53_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_53_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_2] [get_bd_pins ip_53_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/slice_2/dout] [get_bd_pins ip_53_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_54_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_54_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_54_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_54_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_54_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/slice_0/dout] [get_bd_pins ip_54_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_54_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_54_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_1] [get_bd_pins ip_54_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/slice_1/dout] [get_bd_pins ip_54_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_55_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_55_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_55_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_55_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_56_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_56_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_56_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_56_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_56_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/slice_0/dout] [get_bd_pins ip_56_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_1] [get_bd_pins ip_56_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_2] [get_bd_pins ip_56_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 17 -to 0 ip_56_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_56_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_3] [get_bd_pins ip_56_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/slice_3/dout] [get_bd_pins ip_56_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_57_slice_and_concat/out0
create_bd_pin -dir I -from 17 -to 0 ip_57_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_57_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_57_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_58_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_58_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 17 -to 0 ip_58_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_58_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/slice_0/dout] [get_bd_pins ip_58_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_58_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_1] [get_bd_pins ip_58_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_58_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_2] [get_bd_pins ip_58_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_58_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_3] [get_bd_pins ip_58_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_59_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_59_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_59_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_60_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_60_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_60_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_61_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_61_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_61_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_62_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_62_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_62_slice_and_concat/in_0


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

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_21_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_30_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_31_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_0_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_0_uartlite_UART] [get_bd_intf_pins ip_0_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio_GPIO] [get_bd_intf_pins ip_1_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio_GPIO2] [get_bd_intf_pins ip_1_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite_UART] [get_bd_intf_pins ip_2_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_5_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi_IIC] [get_bd_intf_pins ip_5_axi_quad_spi/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_5_axi_quad_spi_STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi_STARTUP_IO_S] [get_bd_intf_pins ip_5_axi_quad_spi/STARTUP_IO_S]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic_IIC] [get_bd_intf_pins ip_7_axi_iic/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_8_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_8_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_8_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_9_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic_IIC] [get_bd_intf_pins ip_9_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_10_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap_ICAP] [get_bd_intf_pins ip_10_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_10_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_10_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_13_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_13_gpio_GPIO] [get_bd_intf_pins ip_13_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_13_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_13_gpio_GPIO2] [get_bd_intf_pins ip_13_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_18_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_18_gpio_GPIO] [get_bd_intf_pins ip_18_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_18_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_18_gpio_GPIO2] [get_bd_intf_pins ip_18_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_19_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio_GPIO] [get_bd_intf_pins ip_19_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_22_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_22_emc_EMC_INTF] [get_bd_intf_pins ip_22_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_25_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic_IIC] [get_bd_intf_pins ip_25_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_28_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_28_axi_ethernet_lite_MII] [get_bd_intf_pins ip_28_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_29_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_29_emc_EMC_INTF] [get_bd_intf_pins ip_29_emc/EMC_INTF]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 14 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_53_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_59_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_71_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_31_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_32_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_33_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_0_uartlite/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_1_gpio/rst]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_2_uartlite/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_4_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_iic/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_8_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_iic/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_30_reset/mb_reset] [get_bd_pins ip_11_microblaze/Reset]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_12_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_13_gpio/rst]
connect_bd_net [get_bd_pins ip_30_reset/mb_reset] [get_bd_pins ip_16_microblaze/Reset]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_17_cordic/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_18_gpio/rst]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_19_gpio/rst]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_22_emc/rst]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset] [get_bd_pins ip_23_dft/SCLR]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_25_axi_iic/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_26_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_27_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_28_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_29_emc/rst]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_0_uartlite/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_1_gpio/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_2_uartlite/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_4_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_6_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_6_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_7_axi_iic/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_8_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_9_axi_iic/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_10_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_10_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_11_microblaze/Clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_12_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_13_gpio/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_14_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_14_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_15_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_15_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_16_microblaze/Clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_17_cordic/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_18_gpio/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_19_gpio/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_20_dft/CLK]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_21_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_21_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_22_emc/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_22_emc/rdclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_23_dft/CLK]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_24_accumulator/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_25_axi_iic/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_26_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_27_floating_point/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_28_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_29_emc/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_29_emc/rdclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_30_reset/clk_in]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_locked] [get_bd_pins ip_30_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_32_intc/irq_0] [get_bd_pins ip_0_uartlite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_1] [get_bd_pins ip_2_uartlite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_2] [get_bd_pins ip_3_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_3] [get_bd_pins ip_5_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_4] [get_bd_pins ip_6_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_5] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_6] [get_bd_pins ip_8_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_32_intc/irq_7] [get_bd_pins ip_9_axi_iic/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_8] [get_bd_pins ip_10_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_32_intc/irq_9] [get_bd_pins ip_13_gpio/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_10] [get_bd_pins ip_14_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_11] [get_bd_pins ip_15_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_12] [get_bd_pins ip_21_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_13] [get_bd_pins ip_25_axi_iic/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_14] [get_bd_pins ip_26_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_32_intc/irq_15] [get_bd_pins ip_28_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_microblaze/INTERRUPT] [get_bd_intf_pins ip_32_intc/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_0] [get_bd_pins ip_0_uartlite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_1] [get_bd_pins ip_2_uartlite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_2] [get_bd_pins ip_3_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_3] [get_bd_pins ip_5_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_4] [get_bd_pins ip_6_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_5] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_6] [get_bd_pins ip_8_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_33_intc/irq_7] [get_bd_pins ip_9_axi_iic/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_8] [get_bd_pins ip_10_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_33_intc/irq_9] [get_bd_pins ip_13_gpio/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_10] [get_bd_pins ip_14_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_11] [get_bd_pins ip_15_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_12] [get_bd_pins ip_21_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_13] [get_bd_pins ip_25_axi_iic/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_14] [get_bd_pins ip_26_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_33_intc/irq_15] [get_bd_pins ip_28_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_microblaze/INTERRUPT] [get_bd_intf_pins ip_33_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_34_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_cdma/M_AXI] [get_bd_intf_pins ip_34_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_microblaze/M_AXI_DP] [get_bd_intf_pins ip_34_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_cdma/M_AXI] [get_bd_intf_pins ip_34_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_cdma/M_AXI] [get_bd_intf_pins ip_34_axi/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_microblaze/M_AXI_DP] [get_bd_intf_pins ip_34_axi/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axi_cdma/M_AXI] [get_bd_intf_pins ip_34_axi/AXI_M6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axi/AXI_S0] [get_bd_intf_pins ip_35_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_uartlite/AXI] [get_bd_intf_pins ip_35_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_gpio/AXI] [get_bd_intf_pins ip_35_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_35_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_35_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_35_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_35_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_iic/AXI] [get_bd_intf_pins ip_35_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_35_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_gpio/AXI] [get_bd_intf_pins ip_35_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_gpio/AXI] [get_bd_intf_pins ip_35_axi/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_gpio/AXI] [get_bd_intf_pins ip_35_axi/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axi/AXI_S1] [get_bd_intf_pins ip_36_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_emc/AXI] [get_bd_intf_pins ip_36_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axi_iic/AXI] [get_bd_intf_pins ip_36_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axi_timer/S_AXI] [get_bd_intf_pins ip_36_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_36_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_emc/AXI] [get_bd_intf_pins ip_36_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_intc/AXI] [get_bd_intf_pins ip_36_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_intc/AXI] [get_bd_intf_pins ip_36_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_38_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_39_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_floating_point/S_AXIS_A] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_45_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_48_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_23_dft/XN_RE]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_1] [get_bd_pins ip_8_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_2] [get_bd_pins ip_8_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_3] [get_bd_pins ip_20_dft/RFFD]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_4] [get_bd_pins ip_20_dft/XK_RE]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_23_dft/XN_IM]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_20_dft/XK_RE]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_1] [get_bd_pins ip_20_dft/XK_IM]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_24_accumulator/B]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_20_dft/XK_IM]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_1] [get_bd_pins ip_20_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_2] [get_bd_pins ip_20_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_3] [get_bd_pins ip_20_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_23_dft/RFFD]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_1] [get_bd_pins ip_23_dft/XK_RE]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_2] [get_bd_pins ip_23_dft/XK_IM]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_20_dft/XN_IM]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_23_dft/XK_IM]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_1] [get_bd_pins ip_23_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_10_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_23_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_23_dft/SIZE]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_23_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_1] [get_bd_pins ip_23_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_2] [get_bd_pins ip_23_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_3] [get_bd_pins ip_24_accumulator/Q]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_20_dft/XN_RE]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_24_accumulator/Q]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_20_dft/SIZE]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_24_accumulator/Q]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_1] [get_bd_pins ip_26_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_2] [get_bd_pins ip_26_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_3] [get_bd_pins ip_26_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_23_dft/FD_IN]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_59_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_26_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_60_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_20_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_61_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_24_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_62_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_4_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_63_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_26_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_64_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_24_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_65_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_24_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_23_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_20_dft/FD_IN]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_20_dft/CE]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_8_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_8_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_70_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_27_floating_point/aclken]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_71_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_34_axi/reset]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_35_axi/reset]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_36_axi/reset]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_48_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_49_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_32_intc/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_33_intc/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_34_axi/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_35_axi/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_36_axi/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_37_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_38_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_39_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_45_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_46_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_47_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_48_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_49_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_complex_multiplier/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_complex_multiplier/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_complex_multiplier/M_AXIS_DOUT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_complex_multiplier/M_AXIS_DOUT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_cordic/S_AXIS_CARTESIAN declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_cordic/S_AXIS_CARTESIAN declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_cordic/S_AXIS_PHASE declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_cordic/S_AXIS_PHASE declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_floating_point/M_AXIS_RESULT declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_floating_point/M_AXIS_RESULT declared=24 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/S_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/S_AXIS declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_0 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_0 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_1 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_1 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_2 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_2 declared=24 actual=ERR $__err" }
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
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
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
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_1 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_1 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_1 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_1 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }


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
