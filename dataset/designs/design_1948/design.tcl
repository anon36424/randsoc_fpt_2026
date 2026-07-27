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



########## conv_encoder ##########
create_bd_cell -type hier ip_0_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_0_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 4 CONFIG.convolution_code0 0 CONFIG.convolution_code1 3 CONFIG.convolution_code2 15 CONFIG.convolution_code3 3 CONFIG.convolution_code4 12 CONFIG.convolution_code5 4 CONFIG.convolution_code6 6 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 5 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_0_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_0_conv_encoder/aclk] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_0_conv_encoder/aresetn] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## uartlite ##########
create_bd_cell -type hier ip_1_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_1_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 1200 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Even " [get_bd_cells ip_1_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_1_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite/UART] [get_bd_intf_pins ip_1_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_1_uartlite/clk
connect_bd_net [get_bd_pins ip_1_uartlite/clk] [get_bd_pins ip_1_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_uartlite/reset
connect_bd_net [get_bd_pins ip_1_uartlite/reset] [get_bd_pins ip_1_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite/AXI] [get_bd_intf_pins ip_1_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_uartlite/irq
connect_bd_net [get_bd_pins ip_1_uartlite/irq] [get_bd_pins ip_1_uartlite/uart_0/interrupt]


########## uartlite ##########
create_bd_cell -type hier ip_2_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_2_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 230400 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Even " [get_bd_cells ip_2_uartlite/uart_0]
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


########## emc ##########
create_bd_cell -type hier ip_3_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_3_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 14 CONFIG.C_TAVDV_PS_MEM_0 14476 CONFIG.C_TAVDV_PS_MEM_1 14947 CONFIG.C_TAVDV_PS_MEM_2 15448 CONFIG.C_TCEDV_PS_MEM_0 15319 CONFIG.C_TCEDV_PS_MEM_1 16034 CONFIG.C_TCEDV_PS_MEM_2 15097 CONFIG.C_THZCE_PS_MEM_0 7469 CONFIG.C_THZCE_PS_MEM_1 7131 CONFIG.C_THZCE_PS_MEM_2 6686 CONFIG.C_THZOE_PS_MEM_0 7218 CONFIG.C_THZOE_PS_MEM_1 7353 CONFIG.C_THZOE_PS_MEM_2 7257 CONFIG.C_TLZWE_PS_MEM_0 609 CONFIG.C_TLZWE_PS_MEM_1 1902 CONFIG.C_TLZWE_PS_MEM_2 822 CONFIG.C_TWC_PS_MEM_0 13684 CONFIG.C_TWC_PS_MEM_1 13667 CONFIG.C_TWC_PS_MEM_2 14735 CONFIG.C_TWPH_PS_MEM_0 12345 CONFIG.C_TWPH_PS_MEM_1 11711 CONFIG.C_TWPH_PS_MEM_2 13151 CONFIG.C_TWP_PS_MEM_0 11950 CONFIG.C_TWP_PS_MEM_1 11014 CONFIG.C_TWP_PS_MEM_2 12351 CONFIG.C_WR_REC_TIME_MEM_0 26799 CONFIG.C_WR_REC_TIME_MEM_1 28082 CONFIG.C_WR_REC_TIME_MEM_2 29256 " [get_bd_cells ip_3_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc/EMC_INTF] [get_bd_intf_pins ip_3_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/clk
connect_bd_net [get_bd_pins ip_3_emc/clk] [get_bd_pins ip_3_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/rdclk
connect_bd_net [get_bd_pins ip_3_emc/rdclk] [get_bd_pins ip_3_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/rst
connect_bd_net [get_bd_pins ip_3_emc/rst] [get_bd_pins ip_3_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_3_emc/emc_0/S_AXI_MEM]


########## uartlite ##########
create_bd_cell -type hier ip_4_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_4_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY No_Parity " [get_bd_cells ip_4_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_4_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite/UART] [get_bd_intf_pins ip_4_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_4_uartlite/clk
connect_bd_net [get_bd_pins ip_4_uartlite/clk] [get_bd_pins ip_4_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_uartlite/reset
connect_bd_net [get_bd_pins ip_4_uartlite/reset] [get_bd_pins ip_4_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite/AXI] [get_bd_intf_pins ip_4_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_uartlite/irq
connect_bd_net [get_bd_pins ip_4_uartlite/irq] [get_bd_pins ip_4_uartlite/uart_0/interrupt]


########## fft ##########
create_bd_cell -type hier ip_5_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_5_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 8 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 4096 " [get_bd_cells ip_5_fft/fft_0]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_6_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_6_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 1 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_6_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_6_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/IIC] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_6_axi_quad_spi/STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/STARTUP_IO_S] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/STARTUP_IO_S]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/clk] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/reset] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/clk4] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/reset4] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/irq] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_7_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_7_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 3 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 4 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 10 CONFIG.C_TAVDV_PS_MEM_0 16483 CONFIG.C_TAVDV_PS_MEM_1 13750 CONFIG.C_TAVDV_PS_MEM_2 15296 CONFIG.C_TAVDV_PS_MEM_3 14149 CONFIG.C_TCEDV_PS_MEM_0 16352 CONFIG.C_TCEDV_PS_MEM_1 14594 CONFIG.C_TCEDV_PS_MEM_2 14582 CONFIG.C_TCEDV_PS_MEM_3 15134 CONFIG.C_THZCE_PS_MEM_0 6624 CONFIG.C_THZCE_PS_MEM_1 7149 CONFIG.C_THZCE_PS_MEM_2 7084 CONFIG.C_THZCE_PS_MEM_3 7445 CONFIG.C_THZOE_PS_MEM_0 6694 CONFIG.C_THZOE_PS_MEM_1 7098 CONFIG.C_THZOE_PS_MEM_2 7573 CONFIG.C_THZOE_PS_MEM_3 7644 CONFIG.C_TLZWE_PS_MEM_0 5219 CONFIG.C_TLZWE_PS_MEM_1 3578 CONFIG.C_TLZWE_PS_MEM_2 2368 CONFIG.C_TLZWE_PS_MEM_3 3524 CONFIG.C_TWC_PS_MEM_0 14709 CONFIG.C_TWC_PS_MEM_1 13658 CONFIG.C_TWC_PS_MEM_2 13842 CONFIG.C_TWC_PS_MEM_3 15122 CONFIG.C_TWPH_PS_MEM_0 12629 CONFIG.C_TWPH_PS_MEM_1 11613 CONFIG.C_TWPH_PS_MEM_2 11944 CONFIG.C_TWPH_PS_MEM_3 12711 CONFIG.C_TWP_PS_MEM_0 11979 CONFIG.C_TWP_PS_MEM_1 10918 CONFIG.C_TWP_PS_MEM_2 12693 CONFIG.C_TWP_PS_MEM_3 12198 CONFIG.C_WR_REC_TIME_MEM_0 29399 CONFIG.C_WR_REC_TIME_MEM_1 27039 CONFIG.C_WR_REC_TIME_MEM_2 26846 CONFIG.C_WR_REC_TIME_MEM_3 27712 " [get_bd_cells ip_7_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_7_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_7_emc/EMC_INTF] [get_bd_intf_pins ip_7_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_7_emc/clk
connect_bd_net [get_bd_pins ip_7_emc/clk] [get_bd_pins ip_7_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_emc/rdclk
connect_bd_net [get_bd_pins ip_7_emc/rdclk] [get_bd_pins ip_7_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_emc/rst
connect_bd_net [get_bd_pins ip_7_emc/rst] [get_bd_pins ip_7_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_emc/AXI] [get_bd_intf_pins ip_7_emc/emc_0/S_AXI_MEM]


########## accumulator ##########
create_bd_cell -type hier ip_8_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_8_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 30 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 48 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_8_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/clk
connect_bd_net [get_bd_pins ip_8_accumulator/clk] [get_bd_pins ip_8_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 29 -to 0 ip_8_accumulator/B
connect_bd_net [get_bd_pins ip_8_accumulator/B] [get_bd_pins ip_8_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 47 -to 0 ip_8_accumulator/Q
connect_bd_net [get_bd_pins ip_8_accumulator/Q] [get_bd_pins ip_8_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/ADD
connect_bd_net [get_bd_pins ip_8_accumulator/ADD] [get_bd_pins ip_8_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/SCLR
connect_bd_net [get_bd_pins ip_8_accumulator/SCLR] [get_bd_pins ip_8_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/Bypass
connect_bd_net [get_bd_pins ip_8_accumulator/Bypass] [get_bd_pins ip_8_accumulator/accumulator_0/Bypass]


########## axi_cdma ##########
create_bd_cell -type hier ip_9_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_9_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 32 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_9_axi_cdma/axi_cdma_0]
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


########## axi_cdma ##########
create_bd_cell -type hier ip_10_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_10_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 34 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 8 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_10_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_10_axi_cdma/m_axi_aclk] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_10_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_10_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_cdma/M_AXI] [get_bd_intf_pins ip_10_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_10_axi_cdma/cdma_introut] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_11_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_11_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 0 CONFIG.C_FIFO_DEPTH 256 CONFIG.C_NUM_TRANSFER_BITS 8 CONFIG.C_SCK_RATIO 4 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 1 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 0 " [get_bd_cells ip_11_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/IIC] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/clk4] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/reset4] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/irq] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_12_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_12_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 18 CONFIG.C_GPIO_WIDTH 13 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_12_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/GPIO] [get_bd_intf_pins ip_12_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/GPIO2] [get_bd_intf_pins ip_12_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/clk
connect_bd_net [get_bd_pins ip_12_gpio/clk] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/rst
connect_bd_net [get_bd_pins ip_12_gpio/rst] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_12_gpio/gpio_0/S_AXI]


########## axi_dma ##########
create_bd_cell -type hier ip_13_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_13_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 49 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_13_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_13_axi_dma/axi_resetn] [get_bd_pins ip_13_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_13_axi_dma/s2mm_introut] [get_bd_pins ip_13_axi_dma/axi_dma_0/s2mm_introut]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_14_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_14_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_14_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_14_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite/MII] [get_bd_intf_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_14_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_14_axi_ethernet_lite/clk] [get_bd_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_14_axi_ethernet_lite/reset] [get_bd_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_14_axi_ethernet_lite/irq] [get_bd_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_15_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_15_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_15_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_15_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite/MII] [get_bd_intf_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_15_axi_ethernet_lite/clk] [get_bd_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_15_axi_ethernet_lite/reset] [get_bd_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_15_axi_ethernet_lite/irq] [get_bd_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## reset ##########
create_bd_cell -type hier ip_16_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_16_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_reset/clk_in
connect_bd_net [get_bd_pins ip_16_reset/clk_in] [get_bd_pins ip_16_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_16_reset/reset_in
connect_bd_net [get_bd_pins ip_16_reset/reset_in] [get_bd_pins ip_16_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_16_reset/dcm_locked
connect_bd_net [get_bd_pins ip_16_reset/dcm_locked] [get_bd_pins ip_16_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_16_reset/mb_reset
connect_bd_net [get_bd_pins ip_16_reset/mb_reset] [get_bd_pins ip_16_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_16_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_16_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_16_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset] [get_bd_pins ip_16_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_16_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_16_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_17_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_17_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_in] [get_bd_pins ip_17_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_17_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_17_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_17_clk_wiz/reset
connect_bd_net [get_bd_pins ip_17_clk_wiz/reset] [get_bd_pins ip_17_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_17_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_locked] [get_bd_pins ip_17_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_18_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_18_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_18_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 11 " [get_bd_cells ip_18_intc/concat_0]
connect_bd_net [get_bd_pins ip_18_intc/concat_0/dout] [get_bd_pins ip_18_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/clk
connect_bd_net [get_bd_pins ip_18_intc/clk] [get_bd_pins ip_18_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/reset
connect_bd_net [get_bd_pins ip_18_intc/reset] [get_bd_pins ip_18_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_intc/AXI] [get_bd_intf_pins ip_18_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_0
connect_bd_net [get_bd_pins ip_18_intc/irq_0] [get_bd_pins ip_18_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_1
connect_bd_net [get_bd_pins ip_18_intc/irq_1] [get_bd_pins ip_18_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_2
connect_bd_net [get_bd_pins ip_18_intc/irq_2] [get_bd_pins ip_18_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_3
connect_bd_net [get_bd_pins ip_18_intc/irq_3] [get_bd_pins ip_18_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_4
connect_bd_net [get_bd_pins ip_18_intc/irq_4] [get_bd_pins ip_18_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_5
connect_bd_net [get_bd_pins ip_18_intc/irq_5] [get_bd_pins ip_18_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_6
connect_bd_net [get_bd_pins ip_18_intc/irq_6] [get_bd_pins ip_18_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_7
connect_bd_net [get_bd_pins ip_18_intc/irq_7] [get_bd_pins ip_18_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_8
connect_bd_net [get_bd_pins ip_18_intc/irq_8] [get_bd_pins ip_18_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_9
connect_bd_net [get_bd_pins ip_18_intc/irq_9] [get_bd_pins ip_18_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_10
connect_bd_net [get_bd_pins ip_18_intc/irq_10] [get_bd_pins ip_18_intc/concat_0/In10]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_18_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_18_intc/irq] [get_bd_intf_pins ip_18_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_19_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_19_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 15 CONFIG.NUM_SI 3 " [get_bd_cells ip_19_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi/clk
connect_bd_net [get_bd_pins ip_19_axi/clk] [get_bd_pins ip_19_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi/reset
connect_bd_net [get_bd_pins ip_19_axi/reset] [get_bd_pins ip_19_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_M0] [get_bd_intf_pins ip_19_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_M1] [get_bd_intf_pins ip_19_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_M2] [get_bd_intf_pins ip_19_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S0] [get_bd_intf_pins ip_19_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S1] [get_bd_intf_pins ip_19_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S2] [get_bd_intf_pins ip_19_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S3] [get_bd_intf_pins ip_19_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S4] [get_bd_intf_pins ip_19_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S5] [get_bd_intf_pins ip_19_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S6] [get_bd_intf_pins ip_19_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S7] [get_bd_intf_pins ip_19_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S8] [get_bd_intf_pins ip_19_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S9] [get_bd_intf_pins ip_19_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S10] [get_bd_intf_pins ip_19_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S11] [get_bd_intf_pins ip_19_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S12] [get_bd_intf_pins ip_19_axi/axi_0/M12_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S13] [get_bd_intf_pins ip_19_axi/axi_0/M13_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S14] [get_bd_intf_pins ip_19_axi/axi_0/M14_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_20_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_20_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_20_axis_broadcaster/axis_broadcaster_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_21_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_21_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 32 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
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
create_bd_pin -dir O -from 29 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 47 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 47 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 48 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_17_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_1_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite_UART] [get_bd_intf_pins ip_1_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite_UART] [get_bd_intf_pins ip_2_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc_EMC_INTF] [get_bd_intf_pins ip_3_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_4_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite_UART] [get_bd_intf_pins ip_4_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_6_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi_IIC] [get_bd_intf_pins ip_6_axi_quad_spi/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_6_axi_quad_spi_STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi_STARTUP_IO_S] [get_bd_intf_pins ip_6_axi_quad_spi/STARTUP_IO_S]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_7_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_7_emc_EMC_INTF] [get_bd_intf_pins ip_7_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi_IIC] [get_bd_intf_pins ip_11_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO] [get_bd_intf_pins ip_12_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO2] [get_bd_intf_pins ip_12_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_14_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite_MII] [get_bd_intf_pins ip_14_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_14_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_14_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_15_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite_MII] [get_bd_intf_pins ip_15_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_18_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 17 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_24_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_18_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_0_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_1_uartlite/reset]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_2_uartlite/reset]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_3_emc/rst]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_4_uartlite/reset]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_7_emc/rst]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_12_gpio/rst]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_0_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_1_uartlite/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_2_uartlite/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_3_emc/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_3_emc/rdclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_4_uartlite/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_5_fft/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_6_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_6_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_6_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_7_emc/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_7_emc/rdclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_8_accumulator/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_10_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_10_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_12_gpio/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_14_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_15_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_16_reset/clk_in]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_locked] [get_bd_pins ip_16_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_18_intc/irq_0] [get_bd_pins ip_1_uartlite/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_1] [get_bd_pins ip_2_uartlite/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_2] [get_bd_pins ip_4_uartlite/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_3] [get_bd_pins ip_5_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_18_intc/irq_4] [get_bd_pins ip_6_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_5] [get_bd_pins ip_9_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_18_intc/irq_6] [get_bd_pins ip_10_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_18_intc/irq_7] [get_bd_pins ip_11_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_8] [get_bd_pins ip_13_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_18_intc/irq_9] [get_bd_pins ip_14_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_10] [get_bd_pins ip_15_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/M_AXI] [get_bd_intf_pins ip_19_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_cdma/M_AXI] [get_bd_intf_pins ip_19_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_19_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_uartlite/AXI] [get_bd_intf_pins ip_19_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_19_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_19_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_uartlite/AXI] [get_bd_intf_pins ip_19_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_19_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_19_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_emc/AXI] [get_bd_intf_pins ip_19_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_19_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_19_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_19_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_19_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_19_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_19_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_19_axi/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_intc/AXI] [get_bd_intf_pins ip_19_axi/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_20_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_DATA] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_5_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/B]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_8_accumulator/Q]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_8_accumulator/Q]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/ADD]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_19_axi/reset]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_18_intc/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_19_axi/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_20_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 25 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=25 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=25 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }


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
