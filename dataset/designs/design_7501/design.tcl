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



########## axi_timer ##########
create_bd_cell -type hier ip_0_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_0_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.mode_64bit 1 " [get_bd_cells ip_0_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_0_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_0_axi_timer/capturetrig0] [get_bd_pins ip_0_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/freeze
connect_bd_net [get_bd_pins ip_0_axi_timer/freeze] [get_bd_pins ip_0_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_0_axi_timer/s_axi_aclk] [get_bd_pins ip_0_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_0_axi_timer/s_axi_aresetn] [get_bd_pins ip_0_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_0_axi_timer/generateout0] [get_bd_pins ip_0_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_0_axi_timer/generateout1] [get_bd_pins ip_0_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_0_axi_timer/pwm0] [get_bd_pins ip_0_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_0_axi_timer/interrupt] [get_bd_pins ip_0_axi_timer/axi_timer_0/interrupt]


########## axi_hwicap ##########
create_bd_cell -type hier ip_1_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_1_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 0 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 1 CONFIG.C_WRITE_FIFO_DEPTH 1024 " [get_bd_cells ip_1_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_1_axi_hwicap/icap_clk] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_1_axi_hwicap/eos_in] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_1_axi_hwicap/s_axi_aclk] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_1_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap/ICAP] [get_bd_intf_pins ip_1_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_1_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_1_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_2_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_2_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_2_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_2_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/MII] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/clk] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/reset] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/irq] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 246 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 257 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 245 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 256 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/C_IN
connect_bd_net [get_bd_pins ip_3_accumulator/C_IN] [get_bd_pins ip_3_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/SCLR
connect_bd_net [get_bd_pins ip_3_accumulator/SCLR] [get_bd_pins ip_3_accumulator/accumulator_0/SCLR]


########## axi_iic ##########
create_bd_cell -type hier ip_4_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_4_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x61 CONFIG.C_GPO_WIDTH 8 CONFIG.C_SCL_INERTIAL_DELAY 172 CONFIG.C_SDA_INERTIAL_DELAY 102 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 476.9459098660254 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_4_axi_iic/axi_iic_0]
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


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_5_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_5_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_5_axi_ethernet_lite/axi_ethernetlite_0]
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


########## gpio ##########
create_bd_cell -type hier ip_6_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_6_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x2 CONFIG.C_DOUT_DEFAULT_2 0x2 CONFIG.C_GPIO2_WIDTH 19 CONFIG.C_GPIO_WIDTH 2 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_6_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/GPIO] [get_bd_intf_pins ip_6_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/GPIO2] [get_bd_intf_pins ip_6_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/clk
connect_bd_net [get_bd_pins ip_6_gpio/clk] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/rst
connect_bd_net [get_bd_pins ip_6_gpio/rst] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_6_gpio/gpio_0/S_AXI]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_7_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_7_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_7_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_7_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite/MII] [get_bd_intf_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_7_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_7_axi_ethernet_lite/clk] [get_bd_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_7_axi_ethernet_lite/reset] [get_bd_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_7_axi_ethernet_lite/irq] [get_bd_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## dft ##########
create_bd_cell -type hier ip_8_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_8_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 14 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_8_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_dft/CLK
connect_bd_net [get_bd_pins ip_8_dft/CLK] [get_bd_pins ip_8_dft/dft_0/CLK]
create_bd_pin -dir I -from 13 -to 0 ip_8_dft/XN_RE
connect_bd_net [get_bd_pins ip_8_dft/XN_RE] [get_bd_pins ip_8_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 13 -to 0 ip_8_dft/XN_IM
connect_bd_net [get_bd_pins ip_8_dft/XN_IM] [get_bd_pins ip_8_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_8_dft/FD_IN
connect_bd_net [get_bd_pins ip_8_dft/FD_IN] [get_bd_pins ip_8_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_8_dft/FWD_INV
connect_bd_net [get_bd_pins ip_8_dft/FWD_INV] [get_bd_pins ip_8_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_8_dft/SIZE
connect_bd_net [get_bd_pins ip_8_dft/SIZE] [get_bd_pins ip_8_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_8_dft/RFFD
connect_bd_net [get_bd_pins ip_8_dft/RFFD] [get_bd_pins ip_8_dft/dft_0/RFFD]
create_bd_pin -dir O -from 13 -to 0 ip_8_dft/XK_RE
connect_bd_net [get_bd_pins ip_8_dft/XK_RE] [get_bd_pins ip_8_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 13 -to 0 ip_8_dft/XK_IM
connect_bd_net [get_bd_pins ip_8_dft/XK_IM] [get_bd_pins ip_8_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_8_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_8_dft/BLK_EXP] [get_bd_pins ip_8_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_8_dft/FD_OUT
connect_bd_net [get_bd_pins ip_8_dft/FD_OUT] [get_bd_pins ip_8_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_8_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_8_dft/DATA_VALID] [get_bd_pins ip_8_dft/dft_0/DATA_VALID]


########## axi_cdma ##########
create_bd_cell -type hier ip_9_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_9_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 34 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_9_axi_cdma/axi_cdma_0]
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


########## fft ##########
create_bd_cell -type hier ip_10_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_10_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 1 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 8192 " [get_bd_cells ip_10_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_fft/aclk
connect_bd_net [get_bd_pins ip_10_fft/aclk] [get_bd_pins ip_10_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_10_fft/event_frame_started
connect_bd_net [get_bd_pins ip_10_fft/event_frame_started] [get_bd_pins ip_10_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_fft/S_AXIS_DATA] [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_fft/M_AXIS_DATA] [get_bd_intf_pins ip_10_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_10_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_CONFIG]


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
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_13_intc/concat_0]
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
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/irq_6
connect_bd_net [get_bd_pins ip_13_intc/irq_6] [get_bd_pins ip_13_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_13_intc/irq_7
connect_bd_net [get_bd_pins ip_13_intc/irq_7] [get_bd_pins ip_13_intc/concat_0/In7]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_13_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_13_intc/irq] [get_bd_intf_pins ip_13_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_14_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_14_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 9 CONFIG.NUM_SI 1 " [get_bd_cells ip_14_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_legacy/clk
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_legacy/reset
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_legacy/AXI_M0] [get_bd_intf_pins ip_14_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_14_axi_legacy/clk] [get_bd_pins ip_14_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_14_axi_legacy/reset] [get_bd_pins ip_14_axi_legacy/axi_0/S00_ARESETN]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_15_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_15_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_15_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_15_axis_broadcaster/aclk] [get_bd_pins ip_15_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_15_axis_broadcaster/aresetn] [get_bd_pins ip_15_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_16_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_16_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_16_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_16_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 256 -to 0 ip_16_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 257 " [get_bd_cells ip_16_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_3] [get_bd_pins ip_16_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/slice_3/dout] [get_bd_pins ip_16_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 245 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 256 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 256 CONFIG.DIN_TO 11 CONFIG.DIN_WIDTH 257 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_18_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_18_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_18_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_18_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_1] [get_bd_pins ip_18_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/slice_1/dout] [get_bd_pins ip_18_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_19_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_19_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 13 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/slice_0/dout] [get_bd_pins ip_19_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_19_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_19_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_1] [get_bd_pins ip_19_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/slice_1/dout] [get_bd_pins ip_19_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_20_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_20_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_20_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 13 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_20_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/slice_0/dout] [get_bd_pins ip_20_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_20_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_20_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_20_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_21_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_22_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_22_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_22_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_12_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_1_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap_ICAP] [get_bd_intf_pins ip_1_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_1_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_1_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_2_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite_MII] [get_bd_intf_pins ip_2_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_4_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic_IIC] [get_bd_intf_pins ip_4_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_5_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite_MII] [get_bd_intf_pins ip_5_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_5_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_5_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio_GPIO] [get_bd_intf_pins ip_6_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio_GPIO2] [get_bd_intf_pins ip_6_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_7_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite_MII] [get_bd_intf_pins ip_7_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_7_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_7_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_13_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_15_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_10_fft/M_AXIS_DATA]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 13 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_18_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 4 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_23_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_iic/reset]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_6_gpio/rst]
connect_bd_net [get_bd_pins ip_11_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_0_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_2_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_4_axi_iic/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_5_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_6_gpio/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_7_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_8_dft/CLK]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_10_fft/aclk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_11_reset/clk_in]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_locked] [get_bd_pins ip_11_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_13_intc/irq_0] [get_bd_pins ip_0_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_13_intc/irq_1] [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_13_intc/irq_2] [get_bd_pins ip_2_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_13_intc/irq_3] [get_bd_pins ip_4_axi_iic/irq]
connect_bd_net [get_bd_pins ip_13_intc/irq_4] [get_bd_pins ip_5_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_13_intc/irq_5] [get_bd_pins ip_7_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_13_intc/irq_6] [get_bd_pins ip_9_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_13_intc/irq_7] [get_bd_pins ip_10_fft/event_frame_started]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/M_AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_iic/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_intc/AXI] [get_bd_intf_pins ip_14_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_DATA] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_8_dft/XN_RE]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_0_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_0_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_0_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_3] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_8_dft/RFFD]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_1] [get_bd_pins ip_8_dft/XK_RE]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_8_dft/XN_IM]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_8_dft/XK_RE]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_1] [get_bd_pins ip_8_dft/XK_IM]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_8_dft/SIZE]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_8_dft/XK_IM]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_8_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_8_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_1_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_8_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_8_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_8_dft/FD_IN]
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_14_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_11_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_13_intc/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_14_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_12_clk_wiz/clk_out] [get_bd_pins ip_15_axis_broadcaster/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }


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
