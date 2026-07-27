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



########## dft ##########
create_bd_cell -type hier ip_0_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_0_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 14 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_0_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/CLK
connect_bd_net [get_bd_pins ip_0_dft/CLK] [get_bd_pins ip_0_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/CE
connect_bd_net [get_bd_pins ip_0_dft/CE] [get_bd_pins ip_0_dft/dft_0/CE]
create_bd_pin -dir I -from 13 -to 0 ip_0_dft/XN_RE
connect_bd_net [get_bd_pins ip_0_dft/XN_RE] [get_bd_pins ip_0_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 13 -to 0 ip_0_dft/XN_IM
connect_bd_net [get_bd_pins ip_0_dft/XN_IM] [get_bd_pins ip_0_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/FD_IN
connect_bd_net [get_bd_pins ip_0_dft/FD_IN] [get_bd_pins ip_0_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/FWD_INV
connect_bd_net [get_bd_pins ip_0_dft/FWD_INV] [get_bd_pins ip_0_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_0_dft/SIZE
connect_bd_net [get_bd_pins ip_0_dft/SIZE] [get_bd_pins ip_0_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_0_dft/RFFD
connect_bd_net [get_bd_pins ip_0_dft/RFFD] [get_bd_pins ip_0_dft/dft_0/RFFD]
create_bd_pin -dir O -from 13 -to 0 ip_0_dft/XK_RE
connect_bd_net [get_bd_pins ip_0_dft/XK_RE] [get_bd_pins ip_0_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 13 -to 0 ip_0_dft/XK_IM
connect_bd_net [get_bd_pins ip_0_dft/XK_IM] [get_bd_pins ip_0_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_0_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_0_dft/BLK_EXP] [get_bd_pins ip_0_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_0_dft/FD_OUT
connect_bd_net [get_bd_pins ip_0_dft/FD_OUT] [get_bd_pins ip_0_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_0_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_0_dft/DATA_VALID] [get_bd_pins ip_0_dft/dft_0/DATA_VALID]


########## axi_iic ##########
create_bd_cell -type hier ip_1_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_1_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x7c CONFIG.C_GPO_WIDTH 8 CONFIG.C_SCL_INERTIAL_DELAY 237 CONFIG.C_SDA_INERTIAL_DELAY 45 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 138.19358274571064 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_1_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_1_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_iic/IIC] [get_bd_intf_pins ip_1_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_iic/clk
connect_bd_net [get_bd_pins ip_1_axi_iic/clk] [get_bd_pins ip_1_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_iic/reset
connect_bd_net [get_bd_pins ip_1_axi_iic/reset] [get_bd_pins ip_1_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_iic/AXI] [get_bd_intf_pins ip_1_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_iic/irq
connect_bd_net [get_bd_pins ip_1_axi_iic/irq] [get_bd_pins ip_1_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_hwicap ##########
create_bd_cell -type hier ip_2_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_2_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 1 CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 0 CONFIG.C_READ_FIFO_DEPTH 128 CONFIG.C_WRITE_FIFO_DEPTH 256 " [get_bd_cells ip_2_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_2_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_2_axi_hwicap/icap_clk] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_2_axi_hwicap/eos_in] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_2_axi_hwicap/s_axi_aclk] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_2_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_2_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_3_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_3_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 23 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_3_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/GPIO] [get_bd_intf_pins ip_3_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/clk
connect_bd_net [get_bd_pins ip_3_gpio/clk] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/rst
connect_bd_net [get_bd_pins ip_3_gpio/rst] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_3_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_gpio/irq
connect_bd_net [get_bd_pins ip_3_gpio/irq] [get_bd_pins ip_3_gpio/gpio_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_4_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_4_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 44 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 256 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 8 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_NUM_MM2S_CHANNELS 8 CONFIG.C_NUM_S2MM_CHANNELS 8 CONFIG.C_S2MM_BURST_SIZE 256 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 26 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 8 " [get_bd_cells ip_4_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_4_axi_dma/axi_resetn] [get_bd_pins ip_4_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_4_axi_dma/mm2s_introut] [get_bd_pins ip_4_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_4_axi_dma/s2mm_introut] [get_bd_pins ip_4_axi_dma/axi_dma_0/s2mm_introut]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 9600 CONFIG.C_DATA_BITS 5 CONFIG.PARITY No_Parity " [get_bd_cells ip_5_uartlite/uart_0]
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


########## axi_dma ##########
create_bd_cell -type hier ip_6_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_6_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 41 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 4 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 128 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 512 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 17 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_6_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_6_axi_dma/axi_resetn] [get_bd_pins ip_6_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_6_axi_dma/mm2s_introut] [get_bd_pins ip_6_axi_dma/axi_dma_0/mm2s_introut]


########## uartlite ##########
create_bd_cell -type hier ip_7_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_7_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 57600 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Even " [get_bd_cells ip_7_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_7_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite/UART] [get_bd_intf_pins ip_7_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_7_uartlite/clk
connect_bd_net [get_bd_pins ip_7_uartlite/clk] [get_bd_pins ip_7_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_uartlite/reset
connect_bd_net [get_bd_pins ip_7_uartlite/reset] [get_bd_pins ip_7_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite/AXI] [get_bd_intf_pins ip_7_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_uartlite/irq
connect_bd_net [get_bd_pins ip_7_uartlite/irq] [get_bd_pins ip_7_uartlite/uart_0/interrupt]


########## uartlite ##########
create_bd_cell -type hier ip_8_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_8_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 115200 CONFIG.C_DATA_BITS 6 CONFIG.PARITY No_Parity " [get_bd_cells ip_8_uartlite/uart_0]
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


########## gpio ##########
create_bd_cell -type hier ip_9_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_9_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x0 CONFIG.C_GPIO2_WIDTH 20 CONFIG.C_GPIO_WIDTH 14 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_9_gpio/gpio_0]
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


########## dft ##########
create_bd_cell -type hier ip_10_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_10_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 8 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_10_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/CLK
connect_bd_net [get_bd_pins ip_10_dft/CLK] [get_bd_pins ip_10_dft/dft_0/CLK]
create_bd_pin -dir I -from 7 -to 0 ip_10_dft/XN_RE
connect_bd_net [get_bd_pins ip_10_dft/XN_RE] [get_bd_pins ip_10_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 7 -to 0 ip_10_dft/XN_IM
connect_bd_net [get_bd_pins ip_10_dft/XN_IM] [get_bd_pins ip_10_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/FD_IN
connect_bd_net [get_bd_pins ip_10_dft/FD_IN] [get_bd_pins ip_10_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/FWD_INV
connect_bd_net [get_bd_pins ip_10_dft/FWD_INV] [get_bd_pins ip_10_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_10_dft/SIZE
connect_bd_net [get_bd_pins ip_10_dft/SIZE] [get_bd_pins ip_10_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/RFFD
connect_bd_net [get_bd_pins ip_10_dft/RFFD] [get_bd_pins ip_10_dft/dft_0/RFFD]
create_bd_pin -dir O -from 7 -to 0 ip_10_dft/XK_RE
connect_bd_net [get_bd_pins ip_10_dft/XK_RE] [get_bd_pins ip_10_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 7 -to 0 ip_10_dft/XK_IM
connect_bd_net [get_bd_pins ip_10_dft/XK_IM] [get_bd_pins ip_10_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_10_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_10_dft/BLK_EXP] [get_bd_pins ip_10_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/FD_OUT
connect_bd_net [get_bd_pins ip_10_dft/FD_OUT] [get_bd_pins ip_10_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_10_dft/DATA_VALID] [get_bd_pins ip_10_dft/dft_0/DATA_VALID]


########## cordic ##########
create_bd_cell -type hier ip_11_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_11_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sinh_and_Cosh CONFIG.Input_Width 29 CONFIG.Iterations 20 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 31 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 44 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_11_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_cordic/aclk
connect_bd_net [get_bd_pins ip_11_cordic/aclk] [get_bd_pins ip_11_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_11_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_11_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_11_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_11_cordic/cordic_0/M_AXIS_DOUT]


########## axi_timer ##########
create_bd_cell -type hier ip_12_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_12_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_12_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_timer/S_AXI] [get_bd_intf_pins ip_12_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_12_axi_timer/capturetrig0] [get_bd_pins ip_12_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/freeze
connect_bd_net [get_bd_pins ip_12_axi_timer/freeze] [get_bd_pins ip_12_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_12_axi_timer/s_axi_aclk] [get_bd_pins ip_12_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_12_axi_timer/s_axi_aresetn] [get_bd_pins ip_12_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_12_axi_timer/generateout0] [get_bd_pins ip_12_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_12_axi_timer/generateout1] [get_bd_pins ip_12_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_12_axi_timer/pwm0] [get_bd_pins ip_12_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_12_axi_timer/interrupt] [get_bd_pins ip_12_axi_timer/axi_timer_0/interrupt]


########## dft ##########
create_bd_cell -type hier ip_13_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_13_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 12 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_13_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_dft/CLK
connect_bd_net [get_bd_pins ip_13_dft/CLK] [get_bd_pins ip_13_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_13_dft/CE
connect_bd_net [get_bd_pins ip_13_dft/CE] [get_bd_pins ip_13_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_13_dft/SCLR
connect_bd_net [get_bd_pins ip_13_dft/SCLR] [get_bd_pins ip_13_dft/dft_0/SCLR]
create_bd_pin -dir I -from 11 -to 0 ip_13_dft/XN_RE
connect_bd_net [get_bd_pins ip_13_dft/XN_RE] [get_bd_pins ip_13_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 11 -to 0 ip_13_dft/XN_IM
connect_bd_net [get_bd_pins ip_13_dft/XN_IM] [get_bd_pins ip_13_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_13_dft/FD_IN
connect_bd_net [get_bd_pins ip_13_dft/FD_IN] [get_bd_pins ip_13_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_13_dft/FWD_INV
connect_bd_net [get_bd_pins ip_13_dft/FWD_INV] [get_bd_pins ip_13_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_13_dft/SIZE
connect_bd_net [get_bd_pins ip_13_dft/SIZE] [get_bd_pins ip_13_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_13_dft/RFFD
connect_bd_net [get_bd_pins ip_13_dft/RFFD] [get_bd_pins ip_13_dft/dft_0/RFFD]
create_bd_pin -dir O -from 11 -to 0 ip_13_dft/XK_RE
connect_bd_net [get_bd_pins ip_13_dft/XK_RE] [get_bd_pins ip_13_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 11 -to 0 ip_13_dft/XK_IM
connect_bd_net [get_bd_pins ip_13_dft/XK_IM] [get_bd_pins ip_13_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_13_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_13_dft/BLK_EXP] [get_bd_pins ip_13_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_13_dft/FD_OUT
connect_bd_net [get_bd_pins ip_13_dft/FD_OUT] [get_bd_pins ip_13_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_13_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_13_dft/DATA_VALID] [get_bd_pins ip_13_dft/dft_0/DATA_VALID]


########## cordic ##########
create_bd_cell -type hier ip_14_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_14_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 31 CONFIG.Iterations 6 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 40 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 46 CONFIG.Round_Mode Truncate " [get_bd_cells ip_14_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_cordic/aclk
connect_bd_net [get_bd_pins ip_14_cordic/aclk] [get_bd_pins ip_14_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_14_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_14_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_14_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_14_cordic/cordic_0/M_AXIS_DOUT]


########## axi_iic ##########
create_bd_cell -type hier ip_15_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_15_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x42 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 17 CONFIG.C_SDA_INERTIAL_DELAY 94 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 244.3783394103242 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_15_axi_iic/axi_iic_0]
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


########## microblaze ##########
create_bd_cell -type hier ip_16_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 36 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 2 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 8 CONFIG.C_MMU_ITLB_SIZE 4 CONFIG.C_MMU_PRIVILEGED_INSTR 1 CONFIG.C_MMU_TLB_ACCESS 3 CONFIG.C_MMU_ZONES 11 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MMU 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_16_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_MASK 0xa49e9e7f6dc88d6 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_16_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_16_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_16_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_16_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_16_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_16_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_16_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_16_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xee3caa62721ae08 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_16_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_16_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_16_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_16_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_16_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_16_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_16_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_16_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_16_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_16_microblaze/mem/BRAM_PORTB]


########## axi_dma ##########
create_bd_cell -type hier ip_17_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_17_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 58 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_17_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_17_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_17_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_17_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_17_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_17_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_17_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_17_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_17_axi_dma/axi_resetn] [get_bd_pins ip_17_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_17_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_17_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_17_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_17_axi_dma/mm2s_introut] [get_bd_pins ip_17_axi_dma/axi_dma_0/mm2s_introut]


########## reset ##########
create_bd_cell -type hier ip_18_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_18_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_reset/clk_in
connect_bd_net [get_bd_pins ip_18_reset/clk_in] [get_bd_pins ip_18_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_18_reset/reset_in
connect_bd_net [get_bd_pins ip_18_reset/reset_in] [get_bd_pins ip_18_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_18_reset/dcm_locked
connect_bd_net [get_bd_pins ip_18_reset/dcm_locked] [get_bd_pins ip_18_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_18_reset/mb_reset
connect_bd_net [get_bd_pins ip_18_reset/mb_reset] [get_bd_pins ip_18_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_18_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_18_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_18_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset] [get_bd_pins ip_18_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_18_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_18_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_19_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_19_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_in] [get_bd_pins ip_19_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_19_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_19_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_19_clk_wiz/reset
connect_bd_net [get_bd_pins ip_19_clk_wiz/reset] [get_bd_pins ip_19_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_19_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_locked] [get_bd_pins ip_19_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_20_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_20_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_20_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 12 " [get_bd_cells ip_20_intc/concat_0]
connect_bd_net [get_bd_pins ip_20_intc/concat_0/dout] [get_bd_pins ip_20_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/clk
connect_bd_net [get_bd_pins ip_20_intc/clk] [get_bd_pins ip_20_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/reset
connect_bd_net [get_bd_pins ip_20_intc/reset] [get_bd_pins ip_20_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_20_intc/AXI] [get_bd_intf_pins ip_20_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_0
connect_bd_net [get_bd_pins ip_20_intc/irq_0] [get_bd_pins ip_20_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_1
connect_bd_net [get_bd_pins ip_20_intc/irq_1] [get_bd_pins ip_20_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_2
connect_bd_net [get_bd_pins ip_20_intc/irq_2] [get_bd_pins ip_20_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_3
connect_bd_net [get_bd_pins ip_20_intc/irq_3] [get_bd_pins ip_20_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_4
connect_bd_net [get_bd_pins ip_20_intc/irq_4] [get_bd_pins ip_20_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_5
connect_bd_net [get_bd_pins ip_20_intc/irq_5] [get_bd_pins ip_20_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_6
connect_bd_net [get_bd_pins ip_20_intc/irq_6] [get_bd_pins ip_20_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_7
connect_bd_net [get_bd_pins ip_20_intc/irq_7] [get_bd_pins ip_20_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_8
connect_bd_net [get_bd_pins ip_20_intc/irq_8] [get_bd_pins ip_20_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_9
connect_bd_net [get_bd_pins ip_20_intc/irq_9] [get_bd_pins ip_20_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_10
connect_bd_net [get_bd_pins ip_20_intc/irq_10] [get_bd_pins ip_20_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_11
connect_bd_net [get_bd_pins ip_20_intc/irq_11] [get_bd_pins ip_20_intc/concat_0/In11]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_20_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_20_intc/irq] [get_bd_intf_pins ip_20_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_21_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_21_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 13 CONFIG.NUM_SI 6 " [get_bd_cells ip_21_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_legacy/clk
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_legacy/reset
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M0] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M1] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M2] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M3] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M4] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S04_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S04_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S04_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M5] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S05_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S05_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S0] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S1] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S2] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S3] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S4] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S5] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S6] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S7] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S8] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S9] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S10] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S11] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S12] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M12_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_22_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_22_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aclk] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aresetn] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_25_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_25_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_25_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_25_axis_combiner/aclk] [get_bd_pins ip_25_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_25_axis_combiner/aresetn] [get_bd_pins ip_25_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_25_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_25_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_combiner/M_AXIS] [get_bd_intf_pins ip_25_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_26_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_26_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 18 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aclk] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aresetn] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_27_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_27_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_27_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_27_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_27_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/slice_1/dout] [get_bd_pins ip_27_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 13 -to 0 ip_28_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_28_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_29_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_29_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_29_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 13 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_29_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/slice_0/dout] [get_bd_pins ip_29_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_29_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_29_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_29_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/slice_1/dout] [get_bd_pins ip_29_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_30_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_30_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/slice_0/dout] [get_bd_pins ip_30_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_30_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_30_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_2] [get_bd_pins ip_30_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_32_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_32_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_32_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 7 -to 0 ip_32_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_1] [get_bd_pins ip_32_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 7 -to 0 ip_32_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_32_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_2] [get_bd_pins ip_32_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/slice_2/dout] [get_bd_pins ip_32_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_33_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_33_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 7 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/slice_0/dout] [get_bd_pins ip_33_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_33_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_33_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_2] [get_bd_pins ip_33_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_3] [get_bd_pins ip_33_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_4] [get_bd_pins ip_33_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_5] [get_bd_pins ip_33_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_6] [get_bd_pins ip_33_slice_and_concat/concat/In6]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 4 -to 0 ip_34_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_34_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 11 -to 0 ip_34_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_34_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_1] [get_bd_pins ip_34_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/slice_1/dout] [get_bd_pins ip_34_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_35_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_35_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/slice_0/dout] [get_bd_pins ip_35_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 11 -to 0 ip_35_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_35_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_35_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/slice_1/dout] [get_bd_pins ip_35_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 11 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_37_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_37_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_37_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_1] [get_bd_pins ip_37_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_2] [get_bd_pins ip_37_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_39_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_39_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_39_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_39_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_40_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_40_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_40_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_40_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_41_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_41_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_41_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_41_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_42_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_42_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_42_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_42_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_43_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_43_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_43_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_43_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_44_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_44_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_44_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_45_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_45_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_45_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_46_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_46_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_46_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_46_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_47_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_47_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_47_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_47_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_47_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_18_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_19_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_1_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_iic_IIC] [get_bd_intf_pins ip_1_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio_GPIO] [get_bd_intf_pins ip_3_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_7_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite_UART] [get_bd_intf_pins ip_7_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_8_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_8_uartlite_UART] [get_bd_intf_pins ip_8_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO] [get_bd_intf_pins ip_9_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO2] [get_bd_intf_pins ip_9_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_15_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_iic_IIC] [get_bd_intf_pins ip_15_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 4 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_34_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 3 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_38_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_39_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_41_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_42_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_43_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_19_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_iic/reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_3_gpio/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_7_uartlite/reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_8_uartlite/reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_9_gpio/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset] [get_bd_pins ip_13_dft/SCLR]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_iic/reset]
connect_bd_net [get_bd_pins ip_18_reset/mb_reset] [get_bd_pins ip_16_microblaze/Reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_0_dft/CLK]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_1_axi_iic/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_3_gpio/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_7_uartlite/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_8_uartlite/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_9_gpio/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_10_dft/CLK]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_11_cordic/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_12_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_13_dft/CLK]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_14_cordic/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_15_axi_iic/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_16_microblaze/Clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_17_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_17_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_17_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_18_reset/clk_in]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_locked] [get_bd_pins ip_18_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_20_intc/irq_0] [get_bd_pins ip_1_axi_iic/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_1] [get_bd_pins ip_2_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_20_intc/irq_2] [get_bd_pins ip_3_gpio/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_3] [get_bd_pins ip_4_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_4] [get_bd_pins ip_4_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_5] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_6] [get_bd_pins ip_6_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_7] [get_bd_pins ip_7_uartlite/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_8] [get_bd_pins ip_8_uartlite/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_9] [get_bd_pins ip_12_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_20_intc/irq_10] [get_bd_pins ip_15_axi_iic/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_11] [get_bd_pins ip_17_axi_dma/mm2s_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_microblaze/INTERRUPT] [get_bd_intf_pins ip_20_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_21_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_21_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_microblaze/M_AXI_DP] [get_bd_intf_pins ip_21_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_21_axi_legacy/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_21_axi_legacy/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_iic/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_uartlite/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_uartlite/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_timer/S_AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_iic/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_intc/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_11_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_14_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_combiner/M_AXIS]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_10_dft/XN_RE]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_0_dft/RFFD]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_0_dft/XK_RE]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_0_dft/SIZE]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_0_dft/XK_RE]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_13_dft/SIZE]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_0_dft/XK_RE]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_0_dft/XK_IM]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_0_dft/XN_IM]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_0_dft/XK_IM]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_0_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_2] [get_bd_pins ip_0_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_2_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_0_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_13_dft/XN_IM]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_10_dft/RFFD]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_1] [get_bd_pins ip_10_dft/XK_RE]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_2] [get_bd_pins ip_10_dft/XK_IM]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_0_dft/XN_RE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_10_dft/XK_IM]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_10_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_2] [get_bd_pins ip_10_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_3] [get_bd_pins ip_10_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_4] [get_bd_pins ip_12_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_5] [get_bd_pins ip_12_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_6] [get_bd_pins ip_12_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_13_dft/RFFD]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_1] [get_bd_pins ip_13_dft/XK_RE]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_13_dft/XN_RE]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_13_dft/XK_RE]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_13_dft/XK_IM]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_10_dft/XN_IM]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_13_dft/XK_IM]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_10_dft/SIZE]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_13_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_1] [get_bd_pins ip_13_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_2] [get_bd_pins ip_13_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_13_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_13_dft/CE]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_10_dft/FD_IN]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_0_dft/CE]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_12_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_12_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_0_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_10_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_0_dft/FD_IN]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_13_dft/FD_IN]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_21_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_20_intc/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_21_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_25_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/S_AXIS_S2MM declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/S_AXIS_S2MM declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/M_AXIS_MM2S declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/M_AXIS_MM2S declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_cordic/S_AXIS_PHASE declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_cordic/S_AXIS_PHASE declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_cordic/S_AXIS_PHASE declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_cordic/S_AXIS_PHASE declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_cordic/M_AXIS_DOUT declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_cordic/M_AXIS_DOUT declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_combiner/S_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_combiner/S_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_combiner/S_AXIS_1 declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_combiner/S_AXIS_1 declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 144 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_combiner/M_AXIS declared=144 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_combiner/M_AXIS declared=144 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 144 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=144 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=144 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
