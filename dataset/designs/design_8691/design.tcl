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



########## cordic ##########
create_bd_cell -type hier ip_0_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_0_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 19 CONFIG.Iterations 25 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 20 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 48 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_0_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aclk
connect_bd_net [get_bd_pins ip_0_cordic/aclk] [get_bd_pins ip_0_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aresetn
connect_bd_net [get_bd_pins ip_0_cordic/aresetn] [get_bd_pins ip_0_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]


########## uartlite ##########
create_bd_cell -type hier ip_1_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_1_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 115200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Even " [get_bd_cells ip_1_uartlite/uart_0]
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


########## axi_dma ##########
create_bd_cell -type hier ip_2_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_2_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 64 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 32 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_2_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_2_axi_dma/axi_resetn] [get_bd_pins ip_2_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_2_axi_dma/mm2s_introut] [get_bd_pins ip_2_axi_dma/axi_dma_0/mm2s_introut]


########## axi_iic ##########
create_bd_cell -type hier ip_3_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_3_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x69 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 193 CONFIG.C_SDA_INERTIAL_DELAY 120 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 172.52286804764415 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_3_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_3_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_iic/IIC] [get_bd_intf_pins ip_3_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_iic/clk
connect_bd_net [get_bd_pins ip_3_axi_iic/clk] [get_bd_pins ip_3_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_iic/reset
connect_bd_net [get_bd_pins ip_3_axi_iic/reset] [get_bd_pins ip_3_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_iic/AXI] [get_bd_intf_pins ip_3_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_iic/irq
connect_bd_net [get_bd_pins ip_3_axi_iic/irq] [get_bd_pins ip_3_axi_iic/axi_iic_0/iic2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_4_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_4_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 4 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 4 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 13 CONFIG.C_TAVDV_PS_MEM_0 14217 CONFIG.C_TAVDV_PS_MEM_1 14601 CONFIG.C_TAVDV_PS_MEM_2 16127 CONFIG.C_TAVDV_PS_MEM_3 15861 CONFIG.C_TCEDV_PS_MEM_0 15832 CONFIG.C_TCEDV_PS_MEM_1 13660 CONFIG.C_TCEDV_PS_MEM_2 13964 CONFIG.C_TCEDV_PS_MEM_3 13932 CONFIG.C_THZCE_PS_MEM_0 7020 CONFIG.C_THZCE_PS_MEM_1 7015 CONFIG.C_THZCE_PS_MEM_2 7289 CONFIG.C_THZCE_PS_MEM_3 6424 CONFIG.C_THZOE_PS_MEM_0 6783 CONFIG.C_THZOE_PS_MEM_1 6762 CONFIG.C_THZOE_PS_MEM_2 7643 CONFIG.C_THZOE_PS_MEM_3 7357 CONFIG.C_TLZWE_PS_MEM_0 8084 CONFIG.C_TLZWE_PS_MEM_1 6770 CONFIG.C_TLZWE_PS_MEM_2 5591 CONFIG.C_TLZWE_PS_MEM_3 2676 CONFIG.C_TWC_PS_MEM_0 15562 CONFIG.C_TWC_PS_MEM_1 15463 CONFIG.C_TWC_PS_MEM_2 14477 CONFIG.C_TWC_PS_MEM_3 15686 CONFIG.C_TWPH_PS_MEM_0 11434 CONFIG.C_TWPH_PS_MEM_1 11069 CONFIG.C_TWPH_PS_MEM_2 12158 CONFIG.C_TWPH_PS_MEM_3 12759 CONFIG.C_TWP_PS_MEM_0 11518 CONFIG.C_TWP_PS_MEM_1 11138 CONFIG.C_TWP_PS_MEM_2 12578 CONFIG.C_TWP_PS_MEM_3 11307 CONFIG.C_WR_REC_TIME_MEM_0 27992 CONFIG.C_WR_REC_TIME_MEM_1 24590 CONFIG.C_WR_REC_TIME_MEM_2 26470 CONFIG.C_WR_REC_TIME_MEM_3 27468 " [get_bd_cells ip_4_emc/emc_0]
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


########## cordic ##########
create_bd_cell -type hier ip_5_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_5_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Translate CONFIG.Input_Width 45 CONFIG.Iterations 32 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 29 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 43 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_5_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_cordic/aclk
connect_bd_net [get_bd_pins ip_5_cordic/aclk] [get_bd_pins ip_5_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_cordic/aclken
connect_bd_net [get_bd_pins ip_5_cordic/aclken] [get_bd_pins ip_5_cordic/cordic_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_5_cordic/aresetn
connect_bd_net [get_bd_pins ip_5_cordic/aresetn] [get_bd_pins ip_5_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_5_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_5_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_5_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_5_cordic/cordic_0/M_AXIS_DOUT]


########## gpio ##########
create_bd_cell -type hier ip_6_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_6_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x337d5 CONFIG.C_GPIO_WIDTH 21 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x14727f " [get_bd_cells ip_6_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/GPIO] [get_bd_intf_pins ip_6_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/clk
connect_bd_net [get_bd_pins ip_6_gpio/clk] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/rst
connect_bd_net [get_bd_pins ip_6_gpio/rst] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_6_gpio/gpio_0/S_AXI]


########## uartlite ##########
create_bd_cell -type hier ip_7_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_7_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 110 CONFIG.C_DATA_BITS 7 CONFIG.PARITY No_Parity " [get_bd_cells ip_7_uartlite/uart_0]
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


########## gpio ##########
create_bd_cell -type hier ip_8_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_8_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 23 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x7fffff " [get_bd_cells ip_8_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio/GPIO] [get_bd_intf_pins ip_8_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_8_gpio/clk
connect_bd_net [get_bd_pins ip_8_gpio/clk] [get_bd_pins ip_8_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_gpio/rst
connect_bd_net [get_bd_pins ip_8_gpio/rst] [get_bd_pins ip_8_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio/AXI] [get_bd_intf_pins ip_8_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_gpio/irq
connect_bd_net [get_bd_pins ip_8_gpio/irq] [get_bd_pins ip_8_gpio/gpio_0/ip2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_9_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_9_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_9_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_9_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_ethernet_lite/MII] [get_bd_intf_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_9_axi_ethernet_lite/clk] [get_bd_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_9_axi_ethernet_lite/reset] [get_bd_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_9_axi_ethernet_lite/irq] [get_bd_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## conv_encoder ##########
create_bd_cell -type hier ip_10_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_10_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 4 CONFIG.convolution_code0 15 CONFIG.convolution_code1 11 CONFIG.convolution_code2 6 CONFIG.convolution_code3 8 CONFIG.convolution_code4 10 CONFIG.convolution_code5 1 CONFIG.convolution_code6 15 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 7 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_10_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_10_conv_encoder/aclk] [get_bd_pins ip_10_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_10_conv_encoder/aclken] [get_bd_pins ip_10_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_10_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_10_conv_encoder/aresetn] [get_bd_pins ip_10_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## reset ##########
create_bd_cell -type hier ip_11_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_11_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_reset/clk_in
connect_bd_net [get_bd_pins ip_11_reset/clk_in] [get_bd_pins ip_11_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_reset/reset_in
connect_bd_net [get_bd_pins ip_11_reset/reset_in] [get_bd_pins ip_11_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_11_reset/dcm_locked
connect_bd_net [get_bd_pins ip_11_reset/dcm_locked] [get_bd_pins ip_11_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_11_reset/mb_reset
connect_bd_net [get_bd_pins ip_11_reset/mb_reset] [get_bd_pins ip_11_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_11_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_11_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_11_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset] [get_bd_pins ip_11_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_11_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_11_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_12_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_12_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_in] [get_bd_pins ip_12_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_12_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_12_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_12_clk_wiz/reset
connect_bd_net [get_bd_pins ip_12_clk_wiz/reset] [get_bd_pins ip_12_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_12_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_locked] [get_bd_pins ip_12_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_13_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_13_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_13_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_13_intc/concat_0]
connect_bd_net [get_bd_pins ip_13_intc/concat_0/dout] [get_bd_pins ip_13_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/clk
connect_bd_net [get_bd_pins ip_13_intc/clk] [get_bd_pins ip_13_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/reset
connect_bd_net [get_bd_pins ip_13_intc/reset] [get_bd_pins ip_13_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_intc/AXI] [get_bd_intf_pins ip_13_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/irq_0
connect_bd_net [get_bd_pins ip_13_intc/irq_0] [get_bd_pins ip_13_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/irq_1
connect_bd_net [get_bd_pins ip_13_intc/irq_1] [get_bd_pins ip_13_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/irq_2
connect_bd_net [get_bd_pins ip_13_intc/irq_2] [get_bd_pins ip_13_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/irq_3
connect_bd_net [get_bd_pins ip_13_intc/irq_3] [get_bd_pins ip_13_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/irq_4
connect_bd_net [get_bd_pins ip_13_intc/irq_4] [get_bd_pins ip_13_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/irq_5
connect_bd_net [get_bd_pins ip_13_intc/irq_5] [get_bd_pins ip_13_intc/concat_0/In5]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_13_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_13_intc/irq] [get_bd_intf_pins ip_13_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_14_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_14_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 9 CONFIG.NUM_SI 2 " [get_bd_cells ip_14_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_legacy/clk
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_legacy/reset
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_M0] [get_bd_intf_pins ip_14_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_M1] [get_bd_intf_pins ip_14_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_S0] [get_bd_intf_pins ip_14_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_S1] [get_bd_intf_pins ip_14_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_S2] [get_bd_intf_pins ip_14_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_S3] [get_bd_intf_pins ip_14_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_S4] [get_bd_intf_pins ip_14_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_S5] [get_bd_intf_pins ip_14_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_S6] [get_bd_intf_pins ip_14_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_S7] [get_bd_intf_pins ip_14_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_S8] [get_bd_intf_pins ip_14_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/M08_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_15_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_15_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_15_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_16_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aclk] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aresetn] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_17_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_17_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 3 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_17_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_18_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_18_axis_dwidth_converter/aclk] [get_bd_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_18_axis_dwidth_converter/aresetn] [get_bd_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_20_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_20_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_20_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_12_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_1_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite_UART] [get_bd_intf_pins ip_1_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_3_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_iic_IIC] [get_bd_intf_pins ip_3_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_4_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_4_emc_EMC_INTF] [get_bd_intf_pins ip_4_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio_GPIO] [get_bd_intf_pins ip_6_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_7_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite_UART] [get_bd_intf_pins ip_7_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio_GPIO] [get_bd_intf_pins ip_8_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_9_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_ethernet_lite_MII] [get_bd_intf_pins ip_9_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_13_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_0_cordic/aresetn]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_1_uartlite/reset]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_iic/reset]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_4_emc/rst]
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_5_cordic/aresetn]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_6_gpio/rst]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_7_uartlite/reset]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_8_gpio/rst]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_10_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_0_cordic/aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_1_uartlite/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_3_axi_iic/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_4_emc/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_4_emc/rdclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_5_cordic/aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_6_gpio/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_7_uartlite/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_8_gpio/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_9_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_10_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_11_reset/clk_in]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_locked] [get_bd_pins ip_11_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_13_intc/irq_0] [get_bd_pins ip_1_uartlite/irq]
connect_bd_net [get_bd_pins ip_13_intc/irq_1] [get_bd_pins ip_2_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_13_intc/irq_2] [get_bd_pins ip_3_axi_iic/irq]
connect_bd_net [get_bd_pins ip_13_intc/irq_3] [get_bd_pins ip_7_uartlite/irq]
connect_bd_net [get_bd_pins ip_13_intc/irq_4] [get_bd_pins ip_8_gpio/irq]
connect_bd_net [get_bd_pins ip_13_intc/irq_5] [get_bd_pins ip_9_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_14_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_14_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_uartlite/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_iic/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_emc/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_uartlite/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_gpio/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_intc/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_2_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_5_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_5_cordic/aclken]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_10_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_14_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_13_intc/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_14_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_15_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_16_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_17_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_18_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_PHASE declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_PHASE declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_cordic/S_AXIS_CARTESIAN declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_cordic/S_AXIS_CARTESIAN declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
