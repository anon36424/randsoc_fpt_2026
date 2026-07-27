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



########## axi_iic ##########
create_bd_cell -type hier ip_0_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_0_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x4c CONFIG.C_GPO_WIDTH 3 CONFIG.C_SCL_INERTIAL_DELAY 10 CONFIG.C_SDA_INERTIAL_DELAY 41 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 161.5128462882069 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_0_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic/IIC] [get_bd_intf_pins ip_0_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_iic/clk
connect_bd_net [get_bd_pins ip_0_axi_iic/clk] [get_bd_pins ip_0_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_iic/reset
connect_bd_net [get_bd_pins ip_0_axi_iic/reset] [get_bd_pins ip_0_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_0_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_iic/irq
connect_bd_net [get_bd_pins ip_0_axi_iic/irq] [get_bd_pins ip_0_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_1_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_1_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_1_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_1_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite/MII] [get_bd_intf_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_1_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_1_axi_ethernet_lite/clk] [get_bd_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_1_axi_ethernet_lite/reset] [get_bd_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_1_axi_ethernet_lite/irq] [get_bd_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_hwicap ##########
create_bd_cell -type hier ip_2_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_2_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 1 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 256 " [get_bd_cells ip_2_axi_hwicap/axi_hwicap_0]
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


########## axi_dma ##########
create_bd_cell -type hier ip_3_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_3_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 56 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 1 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 1 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 8 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 256 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 256 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 256 CONFIG.C_S2MM_BURST_SIZE 8 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 1 CONFIG.C_SG_LENGTH_WIDTH 17 CONFIG.C_SG_USE_STSAPP_LENGTH 0 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 256 " [get_bd_cells ip_3_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_3_axi_dma/axi_resetn] [get_bd_pins ip_3_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXI] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_axi_dma/M_AXIS_CNTRL
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXIS_CNTRL] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXIS_CNTRL]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_3_axi_dma/mm2s_introut] [get_bd_pins ip_3_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_axi_dma/S_AXIS_STS
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/S_AXIS_STS] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXIS_STS]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_3_axi_dma/s2mm_introut] [get_bd_pins ip_3_axi_dma/axi_dma_0/s2mm_introut]


########## axi_iic ##########
create_bd_cell -type hier ip_4_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_4_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x11 CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 233 CONFIG.C_SDA_INERTIAL_DELAY 39 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 322.3503629752718 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_4_axi_iic/axi_iic_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_5_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_5_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x1e CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 118 CONFIG.C_SDA_INERTIAL_DELAY 57 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 105.66327813079714 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic/IIC] [get_bd_intf_pins ip_5_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_iic/clk
connect_bd_net [get_bd_pins ip_5_axi_iic/clk] [get_bd_pins ip_5_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_iic/reset
connect_bd_net [get_bd_pins ip_5_axi_iic/reset] [get_bd_pins ip_5_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_5_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_iic/irq
connect_bd_net [get_bd_pins ip_5_axi_iic/irq] [get_bd_pins ip_5_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_timer ##########
create_bd_cell -type hier ip_6_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_6_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.mode_64bit 1 " [get_bd_cells ip_6_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_timer/S_AXI] [get_bd_intf_pins ip_6_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_6_axi_timer/capturetrig0] [get_bd_pins ip_6_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_timer/freeze
connect_bd_net [get_bd_pins ip_6_axi_timer/freeze] [get_bd_pins ip_6_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_6_axi_timer/s_axi_aclk] [get_bd_pins ip_6_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_6_axi_timer/s_axi_aresetn] [get_bd_pins ip_6_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_6_axi_timer/generateout0] [get_bd_pins ip_6_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_6_axi_timer/generateout1] [get_bd_pins ip_6_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_6_axi_timer/pwm0] [get_bd_pins ip_6_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_6_axi_timer/interrupt] [get_bd_pins ip_6_axi_timer/axi_timer_0/interrupt]


########## conv_encoder ##########
create_bd_cell -type hier ip_7_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_7_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 5 CONFIG.convolution_code0 20 CONFIG.convolution_code1 6 CONFIG.convolution_code2 25 CONFIG.convolution_code3 12 CONFIG.convolution_code4 23 CONFIG.convolution_code5 10 CONFIG.convolution_code6 8 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 5 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_7_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_7_conv_encoder/aclk] [get_bd_pins ip_7_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_7_conv_encoder/aclken] [get_bd_pins ip_7_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_7_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_7_conv_encoder/aresetn] [get_bd_pins ip_7_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_7_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_7_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_7_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_7_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_dma ##########
create_bd_cell -type hier ip_8_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_8_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 46 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 4 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 8 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 512 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 17 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_8_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_8_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_8_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_8_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_8_axi_dma/axi_resetn] [get_bd_pins ip_8_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_8_axi_dma/mm2s_introut] [get_bd_pins ip_8_axi_dma/axi_dma_0/mm2s_introut]


########## cordic ##########
create_bd_cell -type hier ip_9_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_9_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Arc_Tanh CONFIG.Input_Width 10 CONFIG.Iterations 18 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 9 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode No_Pipelining CONFIG.Precision 45 CONFIG.Round_Mode Truncate " [get_bd_cells ip_9_cordic/cordic_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_9_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_9_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_9_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_9_cordic/cordic_0/M_AXIS_DOUT]


########## axi_dma ##########
create_bd_cell -type hier ip_10_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_10_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 44 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_10_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_10_axi_dma/axi_resetn] [get_bd_pins ip_10_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_10_axi_dma/s2mm_introut] [get_bd_pins ip_10_axi_dma/axi_dma_0/s2mm_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_11_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_11_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 54 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_11_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_11_axi_dma/axi_resetn] [get_bd_pins ip_11_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_11_axi_dma/s2mm_introut] [get_bd_pins ip_11_axi_dma/axi_dma_0/s2mm_introut]


########## reset ##########
create_bd_cell -type hier ip_12_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_12_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_reset/clk_in
connect_bd_net [get_bd_pins ip_12_reset/clk_in] [get_bd_pins ip_12_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_12_reset/reset_in
connect_bd_net [get_bd_pins ip_12_reset/reset_in] [get_bd_pins ip_12_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_12_reset/dcm_locked
connect_bd_net [get_bd_pins ip_12_reset/dcm_locked] [get_bd_pins ip_12_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/mb_reset
connect_bd_net [get_bd_pins ip_12_reset/mb_reset] [get_bd_pins ip_12_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_12_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset] [get_bd_pins ip_12_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_12_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_13_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_13_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_in] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_13_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_13_clk_wiz/reset
connect_bd_net [get_bd_pins ip_13_clk_wiz/reset] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_13_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_locked] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_14_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_14_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_14_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 11 " [get_bd_cells ip_14_intc/concat_0]
connect_bd_net [get_bd_pins ip_14_intc/concat_0/dout] [get_bd_pins ip_14_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/clk
connect_bd_net [get_bd_pins ip_14_intc/clk] [get_bd_pins ip_14_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/reset
connect_bd_net [get_bd_pins ip_14_intc/reset] [get_bd_pins ip_14_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_intc/AXI] [get_bd_intf_pins ip_14_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_0
connect_bd_net [get_bd_pins ip_14_intc/irq_0] [get_bd_pins ip_14_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_1
connect_bd_net [get_bd_pins ip_14_intc/irq_1] [get_bd_pins ip_14_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_2
connect_bd_net [get_bd_pins ip_14_intc/irq_2] [get_bd_pins ip_14_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_3
connect_bd_net [get_bd_pins ip_14_intc/irq_3] [get_bd_pins ip_14_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_4
connect_bd_net [get_bd_pins ip_14_intc/irq_4] [get_bd_pins ip_14_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_5
connect_bd_net [get_bd_pins ip_14_intc/irq_5] [get_bd_pins ip_14_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_6
connect_bd_net [get_bd_pins ip_14_intc/irq_6] [get_bd_pins ip_14_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_7
connect_bd_net [get_bd_pins ip_14_intc/irq_7] [get_bd_pins ip_14_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_8
connect_bd_net [get_bd_pins ip_14_intc/irq_8] [get_bd_pins ip_14_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_9
connect_bd_net [get_bd_pins ip_14_intc/irq_9] [get_bd_pins ip_14_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_10
connect_bd_net [get_bd_pins ip_14_intc/irq_10] [get_bd_pins ip_14_intc/concat_0/In10]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_14_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_14_intc/irq] [get_bd_intf_pins ip_14_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_15_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_15_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 11 CONFIG.NUM_SI 5 " [get_bd_cells ip_15_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi/clk
connect_bd_net [get_bd_pins ip_15_axi/clk] [get_bd_pins ip_15_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi/reset
connect_bd_net [get_bd_pins ip_15_axi/reset] [get_bd_pins ip_15_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_M0] [get_bd_intf_pins ip_15_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_M1] [get_bd_intf_pins ip_15_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_M2] [get_bd_intf_pins ip_15_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_M3] [get_bd_intf_pins ip_15_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_M4] [get_bd_intf_pins ip_15_axi/axi_0/S04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S0] [get_bd_intf_pins ip_15_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S1] [get_bd_intf_pins ip_15_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S2] [get_bd_intf_pins ip_15_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S3] [get_bd_intf_pins ip_15_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S4] [get_bd_intf_pins ip_15_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S5] [get_bd_intf_pins ip_15_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S6] [get_bd_intf_pins ip_15_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S7] [get_bd_intf_pins ip_15_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S8] [get_bd_intf_pins ip_15_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S9] [get_bd_intf_pins ip_15_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S10] [get_bd_intf_pins ip_15_axi/axi_0/M10_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_16_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_16_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_16_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_16_axis_broadcaster/aclk] [get_bd_pins ip_16_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_16_axis_broadcaster/aresetn] [get_bd_pins ip_16_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_17_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_17_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_17_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_18_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_18_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_18_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_18_axis_dwidth_converter/aclk] [get_bd_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_18_axis_dwidth_converter/aresetn] [get_bd_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_19_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_19_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_22_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_22_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_22_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_22_axis_combiner/aclk] [get_bd_pins ip_22_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_22_axis_combiner/aresetn] [get_bd_pins ip_22_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/M_AXIS] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_23_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_23_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 32 CONFIG.S_TDATA_NUM_BYTES 32 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
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
create_bd_pin -dir O -from 1 -to 0 ip_25_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_25_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_25_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_26_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_28_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_13_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic_IIC] [get_bd_intf_pins ip_0_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_1_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite_MII] [get_bd_intf_pins ip_1_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_1_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_1_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_2_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap_ICAP] [get_bd_intf_pins ip_2_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_2_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_2_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_4_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic_IIC] [get_bd_intf_pins ip_4_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_14_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 1 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_25_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_iic/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_iic/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_7_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_0_axi_iic/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_1_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_4_axi_iic/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_6_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_7_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_12_reset/clk_in]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_locked] [get_bd_pins ip_12_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_14_intc/irq_0] [get_bd_pins ip_0_axi_iic/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_1] [get_bd_pins ip_1_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_2] [get_bd_pins ip_2_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_14_intc/irq_3] [get_bd_pins ip_3_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_4] [get_bd_pins ip_3_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_5] [get_bd_pins ip_4_axi_iic/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_6] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_7] [get_bd_pins ip_6_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_14_intc/irq_8] [get_bd_pins ip_8_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_9] [get_bd_pins ip_10_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_10] [get_bd_pins ip_11_axi_dma/s2mm_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_15_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/M_AXI] [get_bd_intf_pins ip_15_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_15_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_15_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_15_axi/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_15_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_15_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_15_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_iic/AXI] [get_bd_intf_pins ip_15_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_15_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_timer/S_AXI] [get_bd_intf_pins ip_15_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_intc/AXI] [get_bd_intf_pins ip_15_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/M_AXIS_CNTRL] [get_bd_intf_pins ip_16_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_17_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_7_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/S_AXIS_STS] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_6_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_6_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_2_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_6_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_6_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_6_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_7_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_15_axi/reset]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_14_intc/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_15_axi/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_16_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_17_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_18_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_22_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/M_AXIS_MM2S declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/M_AXIS_MM2S declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXIS_CNTRL]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/M_AXIS_CNTRL declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/M_AXIS_CNTRL declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/S_AXIS_S2MM declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/S_AXIS_S2MM declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXIS_STS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/S_AXIS_STS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/S_AXIS_STS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_cordic/S_AXIS_CARTESIAN declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_cordic/S_AXIS_CARTESIAN declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_cordic/M_AXIS_DOUT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_cordic/M_AXIS_DOUT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_2 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_2 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=256 actual=ERR $__err" }


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
