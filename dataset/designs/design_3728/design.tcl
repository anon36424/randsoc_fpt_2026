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



########## emc ##########
create_bd_cell -type hier ip_0_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_0_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 4 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 11 CONFIG.C_TAVDV_PS_MEM_0 14940 CONFIG.C_TAVDV_PS_MEM_1 14487 CONFIG.C_TAVDV_PS_MEM_2 16240 CONFIG.C_TCEDV_PS_MEM_0 14301 CONFIG.C_TCEDV_PS_MEM_1 14806 CONFIG.C_TCEDV_PS_MEM_2 15432 CONFIG.C_THZCE_PS_MEM_0 7456 CONFIG.C_THZCE_PS_MEM_1 6440 CONFIG.C_THZCE_PS_MEM_2 7255 CONFIG.C_THZOE_PS_MEM_0 6398 CONFIG.C_THZOE_PS_MEM_1 7291 CONFIG.C_THZOE_PS_MEM_2 7185 CONFIG.C_TLZWE_PS_MEM_0 5404 CONFIG.C_TLZWE_PS_MEM_1 507 CONFIG.C_TLZWE_PS_MEM_2 9705 CONFIG.C_TWC_PS_MEM_0 16072 CONFIG.C_TWC_PS_MEM_1 14257 CONFIG.C_TWC_PS_MEM_2 13718 CONFIG.C_TWPH_PS_MEM_0 12211 CONFIG.C_TWPH_PS_MEM_1 11055 CONFIG.C_TWPH_PS_MEM_2 11511 CONFIG.C_TWP_PS_MEM_0 13067 CONFIG.C_TWP_PS_MEM_1 12831 CONFIG.C_TWP_PS_MEM_2 11934 CONFIG.C_WR_REC_TIME_MEM_0 25672 CONFIG.C_WR_REC_TIME_MEM_1 27551 CONFIG.C_WR_REC_TIME_MEM_2 28844 " [get_bd_cells ip_0_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc/EMC_INTF] [get_bd_intf_pins ip_0_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/clk
connect_bd_net [get_bd_pins ip_0_emc/clk] [get_bd_pins ip_0_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/rdclk
connect_bd_net [get_bd_pins ip_0_emc/rdclk] [get_bd_pins ip_0_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/rst
connect_bd_net [get_bd_pins ip_0_emc/rst] [get_bd_pins ip_0_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_0_emc/emc_0/S_AXI_MEM]


########## emc ##########
create_bd_cell -type hier ip_1_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_1_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 2 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 2 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 3 CONFIG.C_TAVDV_PS_MEM_0 13504 CONFIG.C_TAVDV_PS_MEM_1 13586 CONFIG.C_TAVDV_PS_MEM_2 14687 CONFIG.C_TCEDV_PS_MEM_0 15284 CONFIG.C_TCEDV_PS_MEM_1 14611 CONFIG.C_TCEDV_PS_MEM_2 14821 CONFIG.C_THZCE_PS_MEM_0 6313 CONFIG.C_THZCE_PS_MEM_1 7576 CONFIG.C_THZCE_PS_MEM_2 7082 CONFIG.C_THZOE_PS_MEM_0 7156 CONFIG.C_THZOE_PS_MEM_1 6987 CONFIG.C_THZOE_PS_MEM_2 7115 CONFIG.C_TLZWE_PS_MEM_0 7272 CONFIG.C_TLZWE_PS_MEM_1 5664 CONFIG.C_TLZWE_PS_MEM_2 358 CONFIG.C_TWC_PS_MEM_0 14630 CONFIG.C_TWC_PS_MEM_1 14040 CONFIG.C_TWC_PS_MEM_2 15659 CONFIG.C_TWPH_PS_MEM_0 12471 CONFIG.C_TWPH_PS_MEM_1 11263 CONFIG.C_TWPH_PS_MEM_2 12242 CONFIG.C_TWP_PS_MEM_0 11147 CONFIG.C_TWP_PS_MEM_1 12071 CONFIG.C_TWP_PS_MEM_2 12279 CONFIG.C_WR_REC_TIME_MEM_0 26193 CONFIG.C_WR_REC_TIME_MEM_1 25661 CONFIG.C_WR_REC_TIME_MEM_2 25696 " [get_bd_cells ip_1_emc/emc_0]
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


########## axi_hwicap ##########
create_bd_cell -type hier ip_2_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_2_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 0 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_2_axi_hwicap/axi_hwicap_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_2_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap/ICAP] [get_bd_intf_pins ip_2_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_2_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_2_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## uartlite ##########
create_bd_cell -type hier ip_3_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_3_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 8 CONFIG.PARITY No_Parity " [get_bd_cells ip_3_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/UART] [get_bd_intf_pins ip_3_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/clk
connect_bd_net [get_bd_pins ip_3_uartlite/clk] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/reset
connect_bd_net [get_bd_pins ip_3_uartlite/reset] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_3_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_uartlite/irq
connect_bd_net [get_bd_pins ip_3_uartlite/irq] [get_bd_pins ip_3_uartlite/uart_0/interrupt]


########## axi_iic ##########
create_bd_cell -type hier ip_4_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_4_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x3b CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 93 CONFIG.C_SDA_INERTIAL_DELAY 165 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 326.889294877347 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_4_axi_iic/axi_iic_0]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_5_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_5_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 1 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_5_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_5_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/IIC] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/SPI_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_6_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_6_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Half CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_divide_by_zero 0 CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Rec_Square_Root " [get_bd_cells ip_6_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_floating_point/aclk
connect_bd_net [get_bd_pins ip_6_floating_point/aclk] [get_bd_pins ip_6_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_floating_point/aclken
connect_bd_net [get_bd_pins ip_6_floating_point/aclken] [get_bd_pins ip_6_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_6_floating_point/aresetn
connect_bd_net [get_bd_pins ip_6_floating_point/aresetn] [get_bd_pins ip_6_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_6_floating_point/S_AXIS_A] [get_bd_intf_pins ip_6_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_6_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_6_floating_point/floating_point_0/M_AXIS_RESULT]


########## dft ##########
create_bd_cell -type hier ip_7_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_7_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 17 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_7_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/CLK
connect_bd_net [get_bd_pins ip_7_dft/CLK] [get_bd_pins ip_7_dft/dft_0/CLK]
create_bd_pin -dir I -from 16 -to 0 ip_7_dft/XN_RE
connect_bd_net [get_bd_pins ip_7_dft/XN_RE] [get_bd_pins ip_7_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 16 -to 0 ip_7_dft/XN_IM
connect_bd_net [get_bd_pins ip_7_dft/XN_IM] [get_bd_pins ip_7_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/FD_IN
connect_bd_net [get_bd_pins ip_7_dft/FD_IN] [get_bd_pins ip_7_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/FWD_INV
connect_bd_net [get_bd_pins ip_7_dft/FWD_INV] [get_bd_pins ip_7_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_7_dft/SIZE
connect_bd_net [get_bd_pins ip_7_dft/SIZE] [get_bd_pins ip_7_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/RFFD
connect_bd_net [get_bd_pins ip_7_dft/RFFD] [get_bd_pins ip_7_dft/dft_0/RFFD]
create_bd_pin -dir O -from 16 -to 0 ip_7_dft/XK_RE
connect_bd_net [get_bd_pins ip_7_dft/XK_RE] [get_bd_pins ip_7_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 16 -to 0 ip_7_dft/XK_IM
connect_bd_net [get_bd_pins ip_7_dft/XK_IM] [get_bd_pins ip_7_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_7_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_7_dft/BLK_EXP] [get_bd_pins ip_7_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/FD_OUT
connect_bd_net [get_bd_pins ip_7_dft/FD_OUT] [get_bd_pins ip_7_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_7_dft/DATA_VALID] [get_bd_pins ip_7_dft/dft_0/DATA_VALID]


########## cordic ##########
create_bd_cell -type hier ip_8_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_8_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 33 CONFIG.Iterations 24 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 45 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 45 CONFIG.Round_Mode Round_Pos_Inf " [get_bd_cells ip_8_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_cordic/aclk
connect_bd_net [get_bd_pins ip_8_cordic/aclk] [get_bd_pins ip_8_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_cordic/aresetn
connect_bd_net [get_bd_pins ip_8_cordic/aresetn] [get_bd_pins ip_8_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_8_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_8_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_8_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_8_cordic/cordic_0/M_AXIS_DOUT]


########## axi_dma ##########
create_bd_cell -type hier ip_9_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_9_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 48 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_9_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_9_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_9_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_9_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_9_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_9_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_9_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_9_axi_dma/axi_resetn] [get_bd_pins ip_9_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_9_axi_dma/s2mm_introut] [get_bd_pins ip_9_axi_dma/axi_dma_0/s2mm_introut]


########## complex_multiplier ##########
create_bd_cell -type hier ip_10_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_10_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 55 CONFIG.aresetn 0 CONFIG.bportwidth 46 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 16 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_10_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_10_complex_multiplier/aclk] [get_bd_pins ip_10_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_10_complex_multiplier/aclken] [get_bd_pins ip_10_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_iic ##########
create_bd_cell -type hier ip_11_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_11_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x68 CONFIG.C_GPO_WIDTH 5 CONFIG.C_SCL_INERTIAL_DELAY 10 CONFIG.C_SDA_INERTIAL_DELAY 44 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 262.5815367137404 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_11_axi_iic/axi_iic_0]
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


########## emc ##########
create_bd_cell -type hier ip_12_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_12_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_MEM2_TYPE 0 CONFIG.C_MEM2_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_SYNCH_PIPEDELAY_2 2 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 3 CONFIG.C_TAVDV_PS_MEM_0 14485 CONFIG.C_TAVDV_PS_MEM_1 13566 CONFIG.C_TCEDV_PS_MEM_0 15794 CONFIG.C_TCEDV_PS_MEM_1 14782 CONFIG.C_THZCE_PS_MEM_0 6866 CONFIG.C_THZCE_PS_MEM_1 6617 CONFIG.C_THZOE_PS_MEM_0 6890 CONFIG.C_THZOE_PS_MEM_1 7549 CONFIG.C_TLZWE_PS_MEM_0 4723 CONFIG.C_TLZWE_PS_MEM_1 8565 CONFIG.C_TWC_PS_MEM_0 15579 CONFIG.C_TWC_PS_MEM_1 16120 CONFIG.C_TWPH_PS_MEM_0 11584 CONFIG.C_TWPH_PS_MEM_1 11399 CONFIG.C_TWP_PS_MEM_0 12150 CONFIG.C_TWP_PS_MEM_1 12536 CONFIG.C_WR_REC_TIME_MEM_0 27327 CONFIG.C_WR_REC_TIME_MEM_1 26182 " [get_bd_cells ip_12_emc/emc_0]
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
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_15_intc/concat_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_15_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_15_intc/irq] [get_bd_intf_pins ip_15_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_16_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_16_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 11 CONFIG.NUM_SI 2 " [get_bd_cells ip_16_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi/clk
connect_bd_net [get_bd_pins ip_16_axi/clk] [get_bd_pins ip_16_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi/reset
connect_bd_net [get_bd_pins ip_16_axi/reset] [get_bd_pins ip_16_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_M0] [get_bd_intf_pins ip_16_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_M1] [get_bd_intf_pins ip_16_axi/axi_0/S01_AXI]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S9] [get_bd_intf_pins ip_16_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_16_axi/AXI_S10] [get_bd_intf_pins ip_16_axi/axi_0/M10_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_17_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_17_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_17_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_17_axis_broadcaster/aclk] [get_bd_pins ip_17_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_17_axis_broadcaster/aresetn] [get_bd_pins ip_17_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_19_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_19_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 5 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aclk] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aresetn] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_20_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_20_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_22_axis_dwidth_converter/aclk] [get_bd_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_22_axis_dwidth_converter/aresetn] [get_bd_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_23_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_23_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_23_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_23_axis_combiner/aclk] [get_bd_pins ip_23_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_23_axis_combiner/aresetn] [get_bd_pins ip_23_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_23_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_23_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_combiner/M_AXIS] [get_bd_intf_pins ip_23_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_24_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_24_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aclk] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aresetn] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 16 -to 0 ip_26_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 16 -to 0 ip_27_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_28_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_28_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_28_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_28_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_1] [get_bd_pins ip_28_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_28_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_2] [get_bd_pins ip_28_slice_and_concat/concat/In2]


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


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_32_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_14_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc_EMC_INTF] [get_bd_intf_pins ip_0_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_1_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_1_emc_EMC_INTF] [get_bd_intf_pins ip_1_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_2_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap_ICAP] [get_bd_intf_pins ip_2_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_2_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_2_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite_UART] [get_bd_intf_pins ip_3_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_4_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic_IIC] [get_bd_intf_pins ip_4_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_5_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi_IIC] [get_bd_intf_pins ip_5_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_11_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_iic_IIC] [get_bd_intf_pins ip_11_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_12_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_12_emc_EMC_INTF] [get_bd_intf_pins ip_12_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_15_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS]

########## Connecting Protocol.DATA ports ##########

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_0_emc/rst]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_1_emc/rst]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_3_uartlite/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_iic/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_6_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_8_cordic/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_iic/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_12_emc/rst]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_0_emc/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_0_emc/rdclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_1_emc/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_1_emc/rdclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_3_uartlite/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_4_axi_iic/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_6_floating_point/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_7_dft/CLK]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_8_cordic/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_9_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_9_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_9_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_10_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_11_axi_iic/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_12_emc/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_12_emc/rdclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_13_reset/clk_in]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_locked] [get_bd_pins ip_13_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_15_intc/irq_0] [get_bd_pins ip_2_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_15_intc/irq_1] [get_bd_pins ip_3_uartlite/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_2] [get_bd_pins ip_4_axi_iic/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_3] [get_bd_pins ip_5_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_4] [get_bd_pins ip_9_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_15_intc/irq_5] [get_bd_pins ip_11_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_16_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_16_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_16_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_emc/AXI] [get_bd_intf_pins ip_16_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_16_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_16_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_iic/AXI] [get_bd_intf_pins ip_16_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_16_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_16_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_16_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_iic/AXI] [get_bd_intf_pins ip_16_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_emc/AXI] [get_bd_intf_pins ip_16_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_intc/AXI] [get_bd_intf_pins ip_16_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_17_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_18_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_floating_point/S_AXIS_A] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_2_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_7_dft/RFFD]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_7_dft/XN_IM]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_RE]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_7_dft/XN_RE]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_7_dft/SIZE]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_7_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_1] [get_bd_pins ip_7_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_2] [get_bd_pins ip_7_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_10_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_7_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_6_floating_point/aclken]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_7_dft/FD_IN]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_16_axi/reset]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_15_intc/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_16_axi/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_17_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_18_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_23_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_cordic/S_AXIS_PHASE declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_cordic/S_AXIS_PHASE declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_cordic/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_cordic/M_AXIS_DOUT declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_1 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_1 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_combiner/S_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_combiner/S_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_combiner/S_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_combiner/S_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }


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
