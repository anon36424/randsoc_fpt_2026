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
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_GPIO_WIDTH 23 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_0_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/clk
connect_bd_net [get_bd_pins ip_0_gpio/clk] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/rst
connect_bd_net [get_bd_pins ip_0_gpio/rst] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_0_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_gpio/irq
connect_bd_net [get_bd_pins ip_0_gpio/irq] [get_bd_pins ip_0_gpio/gpio_0/ip2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_1_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_1_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_1_axi_ethernet_lite/axi_ethernetlite_0]
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


########## gpio ##########
create_bd_cell -type hier ip_2_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_2_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_GPIO_WIDTH 6 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_2_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/GPIO] [get_bd_intf_pins ip_2_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/clk
connect_bd_net [get_bd_pins ip_2_gpio/clk] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/rst
connect_bd_net [get_bd_pins ip_2_gpio/rst] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_2_gpio/gpio_0/S_AXI]


########## conv_encoder ##########
create_bd_cell -type hier ip_3_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_3_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 6 CONFIG.convolution_code0 4 CONFIG.convolution_code1 48 CONFIG.convolution_code2 2 CONFIG.convolution_code3 61 CONFIG.convolution_code4 41 CONFIG.convolution_code5 59 CONFIG.convolution_code6 12 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 6 CONFIG.output_rate 8 CONFIG.puncture_code0 101111 CONFIG.puncture_code1 100110 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_3_conv_encoder/conv_encoder_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_4_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_4_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.a_tuser_width 31 CONFIG.add_sub_value Both CONFIG.b_tuser_width 19 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage Full_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 1 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Multiply CONFIG.result_tlast_behv OR_all_TLASTs " [get_bd_cells ip_4_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aclk
connect_bd_net [get_bd_pins ip_4_floating_point/aclk] [get_bd_pins ip_4_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aclken
connect_bd_net [get_bd_pins ip_4_floating_point/aclken] [get_bd_pins ip_4_floating_point/floating_point_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_B] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_iic ##########
create_bd_cell -type hier ip_5_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_5_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x3b CONFIG.C_GPO_WIDTH 3 CONFIG.C_SCL_INERTIAL_DELAY 14 CONFIG.C_SDA_INERTIAL_DELAY 66 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 169.80159959995515 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
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


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_6_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_6_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_6_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/clk] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/reset] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/irq] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_hwicap ##########
create_bd_cell -type hier ip_7_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_7_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 0 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 1024 " [get_bd_cells ip_7_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_7_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_7_axi_hwicap/icap_clk] [get_bd_pins ip_7_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_7_axi_hwicap/eos_in] [get_bd_pins ip_7_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_7_axi_hwicap/s_axi_aclk] [get_bd_pins ip_7_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_7_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_7_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_7_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_7_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_8_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_8_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_GPIO_WIDTH 10 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_8_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio/GPIO] [get_bd_intf_pins ip_8_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_8_gpio/clk
connect_bd_net [get_bd_pins ip_8_gpio/clk] [get_bd_pins ip_8_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_gpio/rst
connect_bd_net [get_bd_pins ip_8_gpio/rst] [get_bd_pins ip_8_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio/AXI] [get_bd_intf_pins ip_8_gpio/gpio_0/S_AXI]


########## conv_encoder ##########
create_bd_cell -type hier ip_9_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_9_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 4 CONFIG.convolution_code0 13 CONFIG.convolution_code1 7 CONFIG.convolution_code2 4 CONFIG.convolution_code3 12 CONFIG.convolution_code4 11 CONFIG.convolution_code5 6 CONFIG.convolution_code6 12 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 4 CONFIG.output_rate 6 CONFIG.puncture_code0 1110 CONFIG.puncture_code1 1101 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_9_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_9_conv_encoder/aclk] [get_bd_pins ip_9_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_9_conv_encoder/aclken] [get_bd_pins ip_9_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_9_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_9_conv_encoder/aresetn] [get_bd_pins ip_9_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_9_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_9_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_9_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_9_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## emc ##########
create_bd_cell -type hier ip_10_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_10_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 0 CONFIG.C_MEM0_WIDTH 64 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 64 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 64 CONFIG.C_MEM3_TYPE 0 CONFIG.C_MEM3_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_SYNCH_PIPEDELAY_0 1 CONFIG.C_SYNCH_PIPEDELAY_3 1 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 3 CONFIG.C_TAVDV_PS_MEM_1 13799 CONFIG.C_TAVDV_PS_MEM_2 15048 CONFIG.C_TCEDV_PS_MEM_1 14290 CONFIG.C_TCEDV_PS_MEM_2 16425 CONFIG.C_THZCE_PS_MEM_1 7247 CONFIG.C_THZCE_PS_MEM_2 7343 CONFIG.C_THZOE_PS_MEM_1 7187 CONFIG.C_THZOE_PS_MEM_2 7304 CONFIG.C_TLZWE_PS_MEM_1 9860 CONFIG.C_TLZWE_PS_MEM_2 7276 CONFIG.C_TWC_PS_MEM_1 14990 CONFIG.C_TWC_PS_MEM_2 16196 CONFIG.C_TWPH_PS_MEM_1 12468 CONFIG.C_TWPH_PS_MEM_2 11127 CONFIG.C_TWP_PS_MEM_1 10870 CONFIG.C_TWP_PS_MEM_2 12307 CONFIG.C_WR_REC_TIME_MEM_1 27930 CONFIG.C_WR_REC_TIME_MEM_2 27107 " [get_bd_cells ip_10_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_10_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_10_emc/EMC_INTF] [get_bd_intf_pins ip_10_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_10_emc/clk
connect_bd_net [get_bd_pins ip_10_emc/clk] [get_bd_pins ip_10_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_emc/rdclk
connect_bd_net [get_bd_pins ip_10_emc/rdclk] [get_bd_pins ip_10_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_emc/rst
connect_bd_net [get_bd_pins ip_10_emc/rst] [get_bd_pins ip_10_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_emc/AXI] [get_bd_intf_pins ip_10_emc/emc_0/S_AXI_MEM]


########## xadc_wiz ##########
create_bd_cell -type hier ip_11_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_11_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 16 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 1 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_11_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_11_xadc_wiz/dclk_in] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_11_xadc_wiz/reset_in] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_11_xadc_wiz/convstclk_in] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/eoc_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/eos_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/busy_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_11_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_11_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_11_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## gpio ##########
create_bd_cell -type hier ip_12_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_12_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x152eb CONFIG.C_DOUT_DEFAULT_2 0x0 CONFIG.C_GPIO2_WIDTH 31 CONFIG.C_GPIO_WIDTH 17 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_12_gpio/gpio_0]
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
create_bd_pin -dir O -from 0 -to 0 ip_12_gpio/irq
connect_bd_net [get_bd_pins ip_12_gpio/irq] [get_bd_pins ip_12_gpio/gpio_0/ip2intc_irpt]


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


########## jtag_axi ##########
create_bd_cell -type hier ip_16_jtag_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0
move_bd_cells [get_bd_cells ip_16_jtag_axi] [get_bd_cells jtag_axi_0]
set_property -dict "CONFIG.PROTOCOL AXI4 " [get_bd_cells ip_16_jtag_axi/jtag_axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_jtag_axi/aclk
connect_bd_net [get_bd_pins ip_16_jtag_axi/aclk] [get_bd_pins ip_16_jtag_axi/jtag_axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_jtag_axi/aresetn
connect_bd_net [get_bd_pins ip_16_jtag_axi/aresetn] [get_bd_pins ip_16_jtag_axi/jtag_axi_0/aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_jtag_axi/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_jtag_axi/M_AXI] [get_bd_intf_pins ip_16_jtag_axi/jtag_axi_0/M_AXI]


########## axi ##########
create_bd_cell -type hier ip_17_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_17_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 10 CONFIG.NUM_SI 1 " [get_bd_cells ip_17_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi/clk
connect_bd_net [get_bd_pins ip_17_axi/clk] [get_bd_pins ip_17_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi/reset
connect_bd_net [get_bd_pins ip_17_axi/reset] [get_bd_pins ip_17_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_M0] [get_bd_intf_pins ip_17_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S0] [get_bd_intf_pins ip_17_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S1] [get_bd_intf_pins ip_17_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S2] [get_bd_intf_pins ip_17_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S3] [get_bd_intf_pins ip_17_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S4] [get_bd_intf_pins ip_17_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S5] [get_bd_intf_pins ip_17_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S6] [get_bd_intf_pins ip_17_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S7] [get_bd_intf_pins ip_17_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S8] [get_bd_intf_pins ip_17_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S9] [get_bd_intf_pins ip_17_axi/axi_0/M09_AXI]


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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aclk] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aresetn] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_0


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
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_14_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO] [get_bd_intf_pins ip_0_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_1_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite_MII] [get_bd_intf_pins ip_1_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_1_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_1_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio_GPIO] [get_bd_intf_pins ip_2_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite_MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio_GPIO] [get_bd_intf_pins ip_8_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_10_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_10_emc_EMC_INTF] [get_bd_intf_pins ip_10_emc/EMC_INTF]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_11_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_11_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_11_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO] [get_bd_intf_pins ip_12_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO2] [get_bd_intf_pins ip_12_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_15_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 1 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_25_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir O -from 0 -to 0 control_O
connect_bd_net [get_bd_pins control_O] [get_bd_pins ip_26_slice_and_concat/out0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_0_gpio/rst]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_2_gpio/rst]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_3_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_8_gpio/rst]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_9_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_10_emc/rst]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset] [get_bd_pins ip_11_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_13_reset/peripheral_areset_n] [get_bd_pins ip_12_gpio/rst]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_0_gpio/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_1_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_2_gpio/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_3_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_4_floating_point/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_6_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_7_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_7_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_8_gpio/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_9_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_10_emc/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_10_emc/rdclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_11_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_11_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_12_gpio/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_13_reset/clk_in]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_locked] [get_bd_pins ip_13_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_15_intc/irq_0] [get_bd_pins ip_0_gpio/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_1] [get_bd_pins ip_1_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_2] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_3] [get_bd_pins ip_6_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_15_intc/irq_4] [get_bd_pins ip_7_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_15_intc/irq_5] [get_bd_pins ip_12_gpio/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_jtag_axi/M_AXI] [get_bd_intf_pins ip_17_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_17_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_17_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_17_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_17_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_17_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_17_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_gpio/AXI] [get_bd_intf_pins ip_17_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_emc/AXI] [get_bd_intf_pins ip_17_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_17_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_intc/AXI] [get_bd_intf_pins ip_17_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_18_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_B] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_7_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_11_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_4_floating_point/aclken]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_9_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_3_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_16_jtag_axi/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_17_axi/reset]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_15_intc/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_16_jtag_axi/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_17_axi/clk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_18_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_14_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }


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
