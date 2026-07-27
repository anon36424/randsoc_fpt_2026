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
set_property -dict "CONFIG.C_BAUDRATE 57600 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Even " [get_bd_cells ip_0_uartlite/uart_0]
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


########## uartlite ##########
create_bd_cell -type hier ip_1_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_1_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 300 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Even " [get_bd_cells ip_1_uartlite/uart_0]
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


########## axi_hwicap ##########
create_bd_cell -type hier ip_2_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_2_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 " [get_bd_cells ip_2_axi_hwicap/axi_hwicap_0]
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


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_3_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_3_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_3_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_3_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite/MII] [get_bd_intf_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_3_axi_ethernet_lite/clk] [get_bd_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_3_axi_ethernet_lite/reset] [get_bd_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_3_axi_ethernet_lite/irq] [get_bd_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_4_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_4_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tan CONFIG.Input_Width 19 CONFIG.Iterations 28 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 29 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 0 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_4_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_cordic/aclk
connect_bd_net [get_bd_pins ip_4_cordic/aclk] [get_bd_pins ip_4_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_cordic/aclken
connect_bd_net [get_bd_pins ip_4_cordic/aclken] [get_bd_pins ip_4_cordic/cordic_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_4_cordic/aresetn
connect_bd_net [get_bd_pins ip_4_cordic/aresetn] [get_bd_pins ip_4_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_4_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_4_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_4_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_4_cordic/cordic_0/M_AXIS_DOUT]


########## gpio ##########
create_bd_cell -type hier ip_5_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_5_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 5 CONFIG.C_GPIO_WIDTH 2 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_5_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_5_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_5_gpio/GPIO] [get_bd_intf_pins ip_5_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_5_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_5_gpio/GPIO2] [get_bd_intf_pins ip_5_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_5_gpio/clk
connect_bd_net [get_bd_pins ip_5_gpio/clk] [get_bd_pins ip_5_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_gpio/rst
connect_bd_net [get_bd_pins ip_5_gpio/rst] [get_bd_pins ip_5_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_gpio/AXI] [get_bd_intf_pins ip_5_gpio/gpio_0/S_AXI]


########## conv_encoder ##########
create_bd_cell -type hier ip_6_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_6_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 5 CONFIG.convolution_code0 14 CONFIG.convolution_code1 1 CONFIG.convolution_code2 13 CONFIG.convolution_code3 17 CONFIG.convolution_code4 0 CONFIG.convolution_code5 0 CONFIG.convolution_code6 1 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 8 CONFIG.output_rate 14 CONFIG.puncture_code0 11110111 CONFIG.puncture_code1 11111110 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_6_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_6_conv_encoder/aclk] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_6_conv_encoder/aclken] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_6_conv_encoder/aresetn] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_6_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_6_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## floating_point ##########
create_bd_cell -type hier ip_7_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_7_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.add_sub_value Both CONFIG.b_tuser_width 33 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage Max_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 1 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Multiply CONFIG.result_tlast_behv Pass_B_TLAST " [get_bd_cells ip_7_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_floating_point/aclk
connect_bd_net [get_bd_pins ip_7_floating_point/aclk] [get_bd_pins ip_7_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_7_floating_point/S_AXIS_A] [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_7_floating_point/S_AXIS_B] [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_7_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_7_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_cdma ##########
create_bd_cell -type hier ip_8_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_8_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 53 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 8 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_8_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_8_axi_cdma/m_axi_aclk] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_8_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_8_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_cdma/M_AXI] [get_bd_intf_pins ip_8_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_8_axi_cdma/cdma_introut] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/cdma_introut]


########## emc ##########
create_bd_cell -type hier ip_9_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_9_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 8 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 15 CONFIG.C_TAVDV_PS_MEM_0 16484 CONFIG.C_TAVDV_PS_MEM_1 14173 CONFIG.C_TAVDV_PS_MEM_2 15369 CONFIG.C_TCEDV_PS_MEM_0 15368 CONFIG.C_TCEDV_PS_MEM_1 16309 CONFIG.C_TCEDV_PS_MEM_2 15660 CONFIG.C_THZCE_PS_MEM_0 7637 CONFIG.C_THZCE_PS_MEM_1 6875 CONFIG.C_THZCE_PS_MEM_2 7615 CONFIG.C_THZOE_PS_MEM_0 6867 CONFIG.C_THZOE_PS_MEM_1 7512 CONFIG.C_THZOE_PS_MEM_2 7036 CONFIG.C_TLZWE_PS_MEM_0 6630 CONFIG.C_TLZWE_PS_MEM_1 4032 CONFIG.C_TLZWE_PS_MEM_2 526 CONFIG.C_TWC_PS_MEM_0 14548 CONFIG.C_TWC_PS_MEM_1 14461 CONFIG.C_TWC_PS_MEM_2 14042 CONFIG.C_TWPH_PS_MEM_0 12683 CONFIG.C_TWPH_PS_MEM_1 10975 CONFIG.C_TWPH_PS_MEM_2 11041 CONFIG.C_TWP_PS_MEM_0 11021 CONFIG.C_TWP_PS_MEM_1 12100 CONFIG.C_TWP_PS_MEM_2 12688 CONFIG.C_WR_REC_TIME_MEM_0 29315 CONFIG.C_WR_REC_TIME_MEM_1 28152 CONFIG.C_WR_REC_TIME_MEM_2 25012 " [get_bd_cells ip_9_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_9_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_9_emc/EMC_INTF] [get_bd_intf_pins ip_9_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_9_emc/clk
connect_bd_net [get_bd_pins ip_9_emc/clk] [get_bd_pins ip_9_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_emc/rdclk
connect_bd_net [get_bd_pins ip_9_emc/rdclk] [get_bd_pins ip_9_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_emc/rst
connect_bd_net [get_bd_pins ip_9_emc/rst] [get_bd_pins ip_9_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_emc/AXI] [get_bd_intf_pins ip_9_emc/emc_0/S_AXI_MEM]


########## axi_dma ##########
create_bd_cell -type hier ip_10_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_10_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 39 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 16 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 16 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 26 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_10_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_10_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_10_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_10_axi_dma/axi_resetn] [get_bd_pins ip_10_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_10_axi_dma/mm2s_introut] [get_bd_pins ip_10_axi_dma/axi_dma_0/mm2s_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_11_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_11_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 63 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 4 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 256 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 512 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 14 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_11_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_11_axi_dma/axi_resetn] [get_bd_pins ip_11_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_11_axi_dma/mm2s_introut] [get_bd_pins ip_11_axi_dma/axi_dma_0/mm2s_introut]


########## cordic ##########
create_bd_cell -type hier ip_12_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_12_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 34 CONFIG.Iterations 7 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 47 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 0 CONFIG.Round_Mode Truncate " [get_bd_cells ip_12_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_cordic/aclk
connect_bd_net [get_bd_pins ip_12_cordic/aclk] [get_bd_pins ip_12_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_cordic/aclken
connect_bd_net [get_bd_pins ip_12_cordic/aclken] [get_bd_pins ip_12_cordic/cordic_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_12_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_12_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_12_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_12_cordic/cordic_0/M_AXIS_DOUT]


########## uartlite ##########
create_bd_cell -type hier ip_13_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_13_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 8 CONFIG.PARITY No_Parity " [get_bd_cells ip_13_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_13_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_13_uartlite/UART] [get_bd_intf_pins ip_13_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_13_uartlite/clk
connect_bd_net [get_bd_pins ip_13_uartlite/clk] [get_bd_pins ip_13_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_uartlite/reset
connect_bd_net [get_bd_pins ip_13_uartlite/reset] [get_bd_pins ip_13_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_uartlite/AXI] [get_bd_intf_pins ip_13_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_13_uartlite/irq
connect_bd_net [get_bd_pins ip_13_uartlite/irq] [get_bd_pins ip_13_uartlite/uart_0/interrupt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_14_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_14_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 53 CONFIG.aresetn 0 CONFIG.bportwidth 23 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 1 CONFIG.multtype Use_Mults CONFIG.optimizegoal Performance CONFIG.outputwidth 71 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_14_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_14_complex_multiplier/aclk] [get_bd_pins ip_14_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_14_complex_multiplier/aclken] [get_bd_pins ip_14_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_15_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_15_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 5 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 3 CONFIG.C_TAVDV_PS_MEM_0 16089 CONFIG.C_TAVDV_PS_MEM_1 15954 CONFIG.C_TCEDV_PS_MEM_0 16295 CONFIG.C_TCEDV_PS_MEM_1 13698 CONFIG.C_THZCE_PS_MEM_0 7064 CONFIG.C_THZCE_PS_MEM_1 6891 CONFIG.C_THZOE_PS_MEM_0 7223 CONFIG.C_THZOE_PS_MEM_1 6765 CONFIG.C_TLZWE_PS_MEM_0 5403 CONFIG.C_TLZWE_PS_MEM_1 8553 CONFIG.C_TWC_PS_MEM_0 15067 CONFIG.C_TWC_PS_MEM_1 15801 CONFIG.C_TWPH_PS_MEM_0 12667 CONFIG.C_TWPH_PS_MEM_1 10979 CONFIG.C_TWP_PS_MEM_0 12376 CONFIG.C_TWP_PS_MEM_1 11914 CONFIG.C_WR_REC_TIME_MEM_0 28592 CONFIG.C_WR_REC_TIME_MEM_1 26985 " [get_bd_cells ip_15_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_15_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_15_emc/EMC_INTF] [get_bd_intf_pins ip_15_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_15_emc/clk
connect_bd_net [get_bd_pins ip_15_emc/clk] [get_bd_pins ip_15_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_emc/rdclk
connect_bd_net [get_bd_pins ip_15_emc/rdclk] [get_bd_pins ip_15_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_emc/rst
connect_bd_net [get_bd_pins ip_15_emc/rst] [get_bd_pins ip_15_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_emc/AXI] [get_bd_intf_pins ip_15_emc/emc_0/S_AXI_MEM]


########## axi_dma ##########
create_bd_cell -type hier ip_16_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_16_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 48 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 256 CONFIG.C_S2MM_BURST_SIZE 2 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 10 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 256 " [get_bd_cells ip_16_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_16_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_16_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_16_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_16_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_16_axi_dma/axi_resetn] [get_bd_pins ip_16_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_16_axi_dma/s2mm_introut] [get_bd_pins ip_16_axi_dma/axi_dma_0/s2mm_introut]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_17_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_17_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_17_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_17_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_quad_spi/IIC] [get_bd_intf_pins ip_17_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:display_startup_io:startup_io_rtl:1.0 ip_17_axi_quad_spi/STARTUP_IO
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_quad_spi/STARTUP_IO] [get_bd_intf_pins ip_17_axi_quad_spi/axi_quad_spi_0/STARTUP_IO]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/clk] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/reset] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/clk4] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/reset4] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_17_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_17_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/irq] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_18_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_18_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 37 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_18_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_18_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_18_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_18_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_18_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_18_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_18_axi_dma/axi_resetn] [get_bd_pins ip_18_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_18_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_18_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_18_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_18_axi_dma/mm2s_introut] [get_bd_pins ip_18_axi_dma/axi_dma_0/mm2s_introut]


########## emc ##########
create_bd_cell -type hier ip_19_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_19_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 64 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 64 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 4 CONFIG.C_TAVDV_PS_MEM_0 16404 CONFIG.C_TAVDV_PS_MEM_1 14753 CONFIG.C_TAVDV_PS_MEM_2 14652 CONFIG.C_TCEDV_PS_MEM_0 15409 CONFIG.C_TCEDV_PS_MEM_1 15393 CONFIG.C_TCEDV_PS_MEM_2 16044 CONFIG.C_THZCE_PS_MEM_0 6658 CONFIG.C_THZCE_PS_MEM_1 6314 CONFIG.C_THZCE_PS_MEM_2 7179 CONFIG.C_THZOE_PS_MEM_0 7195 CONFIG.C_THZOE_PS_MEM_1 6300 CONFIG.C_THZOE_PS_MEM_2 7433 CONFIG.C_TLZWE_PS_MEM_0 3911 CONFIG.C_TLZWE_PS_MEM_1 3820 CONFIG.C_TLZWE_PS_MEM_2 4761 CONFIG.C_TWC_PS_MEM_0 15309 CONFIG.C_TWC_PS_MEM_1 14814 CONFIG.C_TWC_PS_MEM_2 14845 CONFIG.C_TWPH_PS_MEM_0 11094 CONFIG.C_TWPH_PS_MEM_1 12240 CONFIG.C_TWPH_PS_MEM_2 12449 CONFIG.C_TWP_PS_MEM_0 10971 CONFIG.C_TWP_PS_MEM_1 11055 CONFIG.C_TWP_PS_MEM_2 12115 CONFIG.C_WR_REC_TIME_MEM_0 27667 CONFIG.C_WR_REC_TIME_MEM_1 29535 CONFIG.C_WR_REC_TIME_MEM_2 29620 " [get_bd_cells ip_19_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_19_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_19_emc/EMC_INTF] [get_bd_intf_pins ip_19_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_19_emc/clk
connect_bd_net [get_bd_pins ip_19_emc/clk] [get_bd_pins ip_19_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_emc/rdclk
connect_bd_net [get_bd_pins ip_19_emc/rdclk] [get_bd_pins ip_19_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_emc/rst
connect_bd_net [get_bd_pins ip_19_emc/rst] [get_bd_pins ip_19_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_emc/AXI] [get_bd_intf_pins ip_19_emc/emc_0/S_AXI_MEM]


########## axi_timer ##########
create_bd_cell -type hier ip_20_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_20_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_20_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_timer/S_AXI] [get_bd_intf_pins ip_20_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_20_axi_timer/capturetrig0] [get_bd_pins ip_20_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_timer/freeze
connect_bd_net [get_bd_pins ip_20_axi_timer/freeze] [get_bd_pins ip_20_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_20_axi_timer/s_axi_aclk] [get_bd_pins ip_20_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_20_axi_timer/s_axi_aresetn] [get_bd_pins ip_20_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_20_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_20_axi_timer/generateout0] [get_bd_pins ip_20_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_20_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_20_axi_timer/generateout1] [get_bd_pins ip_20_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_20_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_20_axi_timer/pwm0] [get_bd_pins ip_20_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_20_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_20_axi_timer/interrupt] [get_bd_pins ip_20_axi_timer/axi_timer_0/interrupt]


########## reset ##########
create_bd_cell -type hier ip_21_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_21_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_reset/clk_in
connect_bd_net [get_bd_pins ip_21_reset/clk_in] [get_bd_pins ip_21_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_21_reset/reset_in
connect_bd_net [get_bd_pins ip_21_reset/reset_in] [get_bd_pins ip_21_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_21_reset/dcm_locked
connect_bd_net [get_bd_pins ip_21_reset/dcm_locked] [get_bd_pins ip_21_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_21_reset/mb_reset
connect_bd_net [get_bd_pins ip_21_reset/mb_reset] [get_bd_pins ip_21_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_21_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_21_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_21_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset] [get_bd_pins ip_21_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_21_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_21_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_22_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_22_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_in] [get_bd_pins ip_22_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_22_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_22_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_22_clk_wiz/reset
connect_bd_net [get_bd_pins ip_22_clk_wiz/reset] [get_bd_pins ip_22_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_22_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_locked] [get_bd_pins ip_22_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_23_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_23_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_23_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 12 " [get_bd_cells ip_23_intc/concat_0]
connect_bd_net [get_bd_pins ip_23_intc/concat_0/dout] [get_bd_pins ip_23_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/clk
connect_bd_net [get_bd_pins ip_23_intc/clk] [get_bd_pins ip_23_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/reset
connect_bd_net [get_bd_pins ip_23_intc/reset] [get_bd_pins ip_23_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_23_intc/AXI] [get_bd_intf_pins ip_23_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_0
connect_bd_net [get_bd_pins ip_23_intc/irq_0] [get_bd_pins ip_23_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_1
connect_bd_net [get_bd_pins ip_23_intc/irq_1] [get_bd_pins ip_23_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_2
connect_bd_net [get_bd_pins ip_23_intc/irq_2] [get_bd_pins ip_23_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_3
connect_bd_net [get_bd_pins ip_23_intc/irq_3] [get_bd_pins ip_23_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_4
connect_bd_net [get_bd_pins ip_23_intc/irq_4] [get_bd_pins ip_23_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_5
connect_bd_net [get_bd_pins ip_23_intc/irq_5] [get_bd_pins ip_23_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_6
connect_bd_net [get_bd_pins ip_23_intc/irq_6] [get_bd_pins ip_23_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_7
connect_bd_net [get_bd_pins ip_23_intc/irq_7] [get_bd_pins ip_23_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_8
connect_bd_net [get_bd_pins ip_23_intc/irq_8] [get_bd_pins ip_23_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_9
connect_bd_net [get_bd_pins ip_23_intc/irq_9] [get_bd_pins ip_23_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_10
connect_bd_net [get_bd_pins ip_23_intc/irq_10] [get_bd_pins ip_23_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_11
connect_bd_net [get_bd_pins ip_23_intc/irq_11] [get_bd_pins ip_23_intc/concat_0/In11]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_23_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_23_intc/irq] [get_bd_intf_pins ip_23_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_24_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_24_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 6 " [get_bd_cells ip_24_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi/clk
connect_bd_net [get_bd_pins ip_24_axi/clk] [get_bd_pins ip_24_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi/reset
connect_bd_net [get_bd_pins ip_24_axi/reset] [get_bd_pins ip_24_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M0] [get_bd_intf_pins ip_24_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M1] [get_bd_intf_pins ip_24_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M2] [get_bd_intf_pins ip_24_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M3] [get_bd_intf_pins ip_24_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M4] [get_bd_intf_pins ip_24_axi/axi_0/S04_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M5] [get_bd_intf_pins ip_24_axi/axi_0/S05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S0] [get_bd_intf_pins ip_24_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S1] [get_bd_intf_pins ip_24_axi/axi_0/M01_AXI]


########## axi ##########
create_bd_cell -type hier ip_25_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_25_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_25_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi/clk
connect_bd_net [get_bd_pins ip_25_axi/clk] [get_bd_pins ip_25_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi/reset
connect_bd_net [get_bd_pins ip_25_axi/reset] [get_bd_pins ip_25_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_M0] [get_bd_intf_pins ip_25_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S0] [get_bd_intf_pins ip_25_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S1] [get_bd_intf_pins ip_25_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S2] [get_bd_intf_pins ip_25_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S3] [get_bd_intf_pins ip_25_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S4] [get_bd_intf_pins ip_25_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S5] [get_bd_intf_pins ip_25_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S6] [get_bd_intf_pins ip_25_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S7] [get_bd_intf_pins ip_25_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S8] [get_bd_intf_pins ip_25_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S9] [get_bd_intf_pins ip_25_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S10] [get_bd_intf_pins ip_25_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S11] [get_bd_intf_pins ip_25_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S12] [get_bd_intf_pins ip_25_axi/axi_0/M12_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S13] [get_bd_intf_pins ip_25_axi/axi_0/M13_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S14] [get_bd_intf_pins ip_25_axi/axi_0/M14_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S15] [get_bd_intf_pins ip_25_axi/axi_0/M15_AXI]


########## axi ##########
create_bd_cell -type hier ip_26_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_26_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 1 " [get_bd_cells ip_26_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi/clk
connect_bd_net [get_bd_pins ip_26_axi/clk] [get_bd_pins ip_26_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi/reset
connect_bd_net [get_bd_pins ip_26_axi/reset] [get_bd_pins ip_26_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M0] [get_bd_intf_pins ip_26_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S0] [get_bd_intf_pins ip_26_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S1] [get_bd_intf_pins ip_26_axi/axi_0/M01_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_27_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_27_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_27_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_27_axis_broadcaster/aclk] [get_bd_pins ip_27_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_27_axis_broadcaster/aresetn] [get_bd_pins ip_27_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_28_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_28_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_28_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_28_axis_broadcaster/aclk] [get_bd_pins ip_28_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_28_axis_broadcaster/aresetn] [get_bd_pins ip_28_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_29_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_29_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_29_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_29_axis_broadcaster/aclk] [get_bd_pins ip_29_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_29_axis_broadcaster/aresetn] [get_bd_pins ip_29_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_30_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_30_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aclk] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aresetn] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_31_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_31_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_31_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aclk] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aresetn] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_32_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_32_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 5 CONFIG.S_TDATA_NUM_BYTES 32 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aclk] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aresetn] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_33_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_33_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_33_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aclk] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aresetn] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_34_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_34_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_34_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aclk] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aresetn] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_35_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_35_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_35_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_35_axis_combiner/aclk] [get_bd_pins ip_35_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_35_axis_combiner/aresetn] [get_bd_pins ip_35_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_combiner/M_AXIS] [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_36_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_36_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 32 CONFIG.S_TDATA_NUM_BYTES 34 " [get_bd_cells ip_36_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_36_axis_dwidth_converter/aclk] [get_bd_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_36_axis_dwidth_converter/aresetn] [get_bd_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_37_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_37_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_37_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aclk] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aresetn] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_38_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_38_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_38_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_38_axis_combiner/aclk] [get_bd_pins ip_38_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_38_axis_combiner/aresetn] [get_bd_pins ip_38_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_combiner/M_AXIS] [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_39_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_39_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aclk] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aresetn] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_40_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_40_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_40_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_40_axis_combiner/aclk] [get_bd_pins ip_40_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_40_axis_combiner/aresetn] [get_bd_pins ip_40_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/M_AXIS] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_41_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_41_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aclk] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aresetn] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 1 -to 0 ip_42_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_42_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_42_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_42_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_42_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_1] [get_bd_pins ip_42_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_43_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_44_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_44_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_44_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_45_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_45_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_45_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_46_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_46_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_46_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_46_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_47_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_47_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_47_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_47_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_47_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_48_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_48_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_48_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_48_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_48_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_48_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_49_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_49_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_49_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_49_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_49_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_49_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_21_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_22_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_0_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_0_uartlite_UART] [get_bd_intf_pins ip_0_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_1_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite_UART] [get_bd_intf_pins ip_1_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_3_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite_MII] [get_bd_intf_pins ip_3_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_5_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_5_gpio_GPIO] [get_bd_intf_pins ip_5_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_5_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_5_gpio_GPIO2] [get_bd_intf_pins ip_5_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_9_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_9_emc_EMC_INTF] [get_bd_intf_pins ip_9_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_13_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_13_uartlite_UART] [get_bd_intf_pins ip_13_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_15_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_15_emc_EMC_INTF] [get_bd_intf_pins ip_15_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_17_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_quad_spi_IIC] [get_bd_intf_pins ip_17_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:display_startup_io:startup_io_rtl:1.0 ip_17_axi_quad_spi_STARTUP_IO
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_quad_spi_STARTUP_IO] [get_bd_intf_pins ip_17_axi_quad_spi/STARTUP_IO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_19_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_19_emc_EMC_INTF] [get_bd_intf_pins ip_19_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_23_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 1 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_42_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 5 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_22_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_23_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_0_uartlite/reset]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_1_uartlite/reset]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_4_cordic/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_5_gpio/rst]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_6_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_9_emc/rst]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_13_uartlite/reset]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_15_emc/rst]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_16_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_18_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_19_emc/rst]
connect_bd_net [get_bd_pins ip_21_reset/peripheral_areset_n] [get_bd_pins ip_20_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_0_uartlite/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_1_uartlite/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_3_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_4_cordic/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_5_gpio/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_6_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_7_floating_point/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_9_emc/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_9_emc/rdclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_10_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_12_cordic/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_13_uartlite/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_14_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_15_emc/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_15_emc/rdclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_16_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_16_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_17_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_17_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_17_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_18_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_18_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_19_emc/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_19_emc/rdclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_20_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_21_reset/clk_in]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_locked] [get_bd_pins ip_21_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_23_intc/irq_0] [get_bd_pins ip_0_uartlite/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_1] [get_bd_pins ip_1_uartlite/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_2] [get_bd_pins ip_2_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_23_intc/irq_3] [get_bd_pins ip_3_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_4] [get_bd_pins ip_8_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_23_intc/irq_5] [get_bd_pins ip_10_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_23_intc/irq_6] [get_bd_pins ip_11_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_23_intc/irq_7] [get_bd_pins ip_13_uartlite/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_8] [get_bd_pins ip_16_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_23_intc/irq_9] [get_bd_pins ip_17_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_10] [get_bd_pins ip_18_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_23_intc/irq_11] [get_bd_pins ip_20_axi_timer/interrupt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/M_AXI] [get_bd_intf_pins ip_24_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_24_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_24_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_24_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_24_axi/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_24_axi/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axi/AXI_S0] [get_bd_intf_pins ip_25_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_uartlite/AXI] [get_bd_intf_pins ip_25_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_uartlite/AXI] [get_bd_intf_pins ip_25_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_25_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_25_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_gpio/AXI] [get_bd_intf_pins ip_25_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_25_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_emc/AXI] [get_bd_intf_pins ip_25_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_25_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_25_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_uartlite/AXI] [get_bd_intf_pins ip_25_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_emc/AXI] [get_bd_intf_pins ip_25_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_25_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_25_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_25_axi/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_25_axi/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_emc/AXI] [get_bd_intf_pins ip_25_axi/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axi/AXI_S1] [get_bd_intf_pins ip_26_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_timer/S_AXI] [get_bd_intf_pins ip_26_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_intc/AXI] [get_bd_intf_pins ip_26_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_27_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_29_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_floating_point/S_AXIS_A] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_7_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_14_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_4_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_floating_point/S_AXIS_B] [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_40_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_20_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_1] [get_bd_pins ip_20_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_2_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_20_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_12_cordic/aclken]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_20_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_6_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_14_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_20_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_4_cordic/aclken]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_24_axi/reset]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_25_axi/reset]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_26_axi/reset]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_21_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_23_intc/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_24_axi/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_25_axi/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_26_axi/clk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_27_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_28_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_29_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_33_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_34_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_35_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_36_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_37_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_38_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_40_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_22_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_cordic/S_AXIS_CARTESIAN declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_cordic/S_AXIS_CARTESIAN declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/M_AXIS_MM2S declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axi_dma/M_AXIS_MM2S declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/M_AXIS_MM2S declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/M_AXIS_MM2S declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_cordic/S_AXIS_PHASE declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_cordic/S_AXIS_PHASE declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_cordic/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_cordic/M_AXIS_DOUT declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_B declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_B declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 144 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/M_AXIS_DOUT declared=144 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/M_AXIS_DOUT declared=144 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axi_dma/S_AXIS_S2MM declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axi_dma/S_AXIS_S2MM declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_2 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_1 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_1 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 144 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_1 declared=144 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_1 declared=144 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 272 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/M_AXIS declared=272 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/M_AXIS declared=272 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 272 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=272 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=272 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_1 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_1 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }


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
