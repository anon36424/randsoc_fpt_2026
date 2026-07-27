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



########## axi_cdma ##########
create_bd_cell -type hier ip_0_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_0_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 37 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 128 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_0_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_0_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_0_axi_cdma/m_axi_aclk] [get_bd_pins ip_0_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_0_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_0_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_0_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_0_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_cdma/M_AXI] [get_bd_intf_pins ip_0_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_0_axi_cdma/cdma_introut] [get_bd_pins ip_0_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_1_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_1_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SHARED_STARTUP 1 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_1_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_1_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi/IIC] [get_bd_intf_pins ip_1_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_1_axi_quad_spi/STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi/STARTUP_IO_S] [get_bd_intf_pins ip_1_axi_quad_spi/axi_quad_spi_0/STARTUP_IO_S]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/clk] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/reset] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_1_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/irq] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_2_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_2_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_GPIO_WIDTH 16 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_2_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/GPIO] [get_bd_intf_pins ip_2_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/clk
connect_bd_net [get_bd_pins ip_2_gpio/clk] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/rst
connect_bd_net [get_bd_pins ip_2_gpio/rst] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_2_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_gpio/irq
connect_bd_net [get_bd_pins ip_2_gpio/irq] [get_bd_pins ip_2_gpio/gpio_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_3_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_3_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 1200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Odd " [get_bd_cells ip_3_uartlite/uart_0]
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


########## emc ##########
create_bd_cell -type hier ip_4_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_4_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 3 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 10 CONFIG.C_TAVDV_PS_MEM_0 15164 CONFIG.C_TAVDV_PS_MEM_1 14211 CONFIG.C_TAVDV_PS_MEM_2 13788 CONFIG.C_TCEDV_PS_MEM_0 16147 CONFIG.C_TCEDV_PS_MEM_1 16056 CONFIG.C_TCEDV_PS_MEM_2 13957 CONFIG.C_THZCE_PS_MEM_0 7465 CONFIG.C_THZCE_PS_MEM_1 7191 CONFIG.C_THZCE_PS_MEM_2 7607 CONFIG.C_THZOE_PS_MEM_0 6926 CONFIG.C_THZOE_PS_MEM_1 6818 CONFIG.C_THZOE_PS_MEM_2 6552 CONFIG.C_TLZWE_PS_MEM_0 286 CONFIG.C_TLZWE_PS_MEM_1 1396 CONFIG.C_TLZWE_PS_MEM_2 9354 CONFIG.C_TWC_PS_MEM_0 13529 CONFIG.C_TWC_PS_MEM_1 16059 CONFIG.C_TWC_PS_MEM_2 16337 CONFIG.C_TWPH_PS_MEM_0 11467 CONFIG.C_TWPH_PS_MEM_1 10840 CONFIG.C_TWPH_PS_MEM_2 12023 CONFIG.C_TWP_PS_MEM_0 10843 CONFIG.C_TWP_PS_MEM_1 11746 CONFIG.C_TWP_PS_MEM_2 11882 CONFIG.C_WR_REC_TIME_MEM_0 27470 CONFIG.C_WR_REC_TIME_MEM_1 26030 CONFIG.C_WR_REC_TIME_MEM_2 26278 " [get_bd_cells ip_4_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_4_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_4_emc/EMC_INTF] [get_bd_intf_pins ip_4_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_4_emc/clk
connect_bd_net [get_bd_pins ip_4_emc/clk] [get_bd_pins ip_4_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_emc/rdclk
connect_bd_net [get_bd_pins ip_4_emc/rdclk] [get_bd_pins ip_4_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_emc/rst
connect_bd_net [get_bd_pins ip_4_emc/rst] [get_bd_pins ip_4_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_emc/AXI] [get_bd_intf_pins ip_4_emc/emc_0/S_AXI_MEM]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 115200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Even " [get_bd_cells ip_5_uartlite/uart_0]
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
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tanh CONFIG.Input_Width 22 CONFIG.Iterations 46 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 46 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 46 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_6_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_cordic/aclk
connect_bd_net [get_bd_pins ip_6_cordic/aclk] [get_bd_pins ip_6_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_cordic/aclken
connect_bd_net [get_bd_pins ip_6_cordic/aclken] [get_bd_pins ip_6_cordic/cordic_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_6_cordic/aresetn
connect_bd_net [get_bd_pins ip_6_cordic/aresetn] [get_bd_pins ip_6_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_6_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_6_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_6_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_6_cordic/cordic_0/M_AXIS_DOUT]


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
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_9_intc/concat_0]
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
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_3
connect_bd_net [get_bd_pins ip_9_intc/irq_3] [get_bd_pins ip_9_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_4
connect_bd_net [get_bd_pins ip_9_intc/irq_4] [get_bd_pins ip_9_intc/concat_0/In4]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_9_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_9_intc/irq] [get_bd_intf_pins ip_9_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_10_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_10_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 7 CONFIG.NUM_SI 1 " [get_bd_cells ip_10_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi/clk
connect_bd_net [get_bd_pins ip_10_axi/clk] [get_bd_pins ip_10_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi/reset
connect_bd_net [get_bd_pins ip_10_axi/reset] [get_bd_pins ip_10_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_M0] [get_bd_intf_pins ip_10_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S0] [get_bd_intf_pins ip_10_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S1] [get_bd_intf_pins ip_10_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S2] [get_bd_intf_pins ip_10_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S3] [get_bd_intf_pins ip_10_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S4] [get_bd_intf_pins ip_10_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S5] [get_bd_intf_pins ip_10_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S6] [get_bd_intf_pins ip_10_axi/axi_0/M06_AXI]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_11_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_11_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_11_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_12_axis_dwidth_converter/axis_dwidth_converter_0]
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
create_bd_pin -dir O -from 0 -to 0 ip_13_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_8_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_1_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi_IIC] [get_bd_intf_pins ip_1_axi_quad_spi/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_1_axi_quad_spi_STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi_STARTUP_IO_S] [get_bd_intf_pins ip_1_axi_quad_spi/STARTUP_IO_S]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio_GPIO] [get_bd_intf_pins ip_2_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite_UART] [get_bd_intf_pins ip_3_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_4_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_4_emc_EMC_INTF] [get_bd_intf_pins ip_4_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_9_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_13_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_2_gpio/rst]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_3_uartlite/reset]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_4_emc/rst]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_6_cordic/aresetn]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_1_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_1_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_2_gpio/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_3_uartlite/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_4_emc/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_4_emc/rdclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_6_cordic/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_7_reset/clk_in]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_locked] [get_bd_pins ip_7_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_9_intc/irq_0] [get_bd_pins ip_0_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_9_intc/irq_1] [get_bd_pins ip_1_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_9_intc/irq_2] [get_bd_pins ip_2_gpio/irq]
connect_bd_net [get_bd_pins ip_9_intc/irq_3] [get_bd_pins ip_3_uartlite/irq]
connect_bd_net [get_bd_pins ip_9_intc/irq_4] [get_bd_pins ip_5_uartlite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/M_AXI] [get_bd_intf_pins ip_10_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_10_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_10_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_10_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_emc/AXI] [get_bd_intf_pins ip_10_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_10_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_intc/AXI] [get_bd_intf_pins ip_10_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_cordic/M_AXIS_DOUT]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_6_cordic/aclken]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_13_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_10_axi/reset]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_11_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_12_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_9_intc/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_10_axi/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_11_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_12_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_cordic/S_AXIS_CARTESIAN declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_cordic/S_AXIS_CARTESIAN declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_cordic/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_cordic/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
