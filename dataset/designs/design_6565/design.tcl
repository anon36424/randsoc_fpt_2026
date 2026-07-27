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



########## fft ##########
create_bd_cell -type hier ip_0_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_0_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 7 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 32 " [get_bd_cells ip_0_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_fft/aclk
connect_bd_net [get_bd_pins ip_0_fft/aclk] [get_bd_pins ip_0_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_0_fft/event_frame_started
connect_bd_net [get_bd_pins ip_0_fft/event_frame_started] [get_bd_pins ip_0_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_fft/S_AXIS_DATA] [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_fft/M_AXIS_DATA] [get_bd_intf_pins ip_0_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_0_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_CONFIG]


########## dft ##########
create_bd_cell -type hier ip_1_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_1_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 18 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_1_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CLK
connect_bd_net [get_bd_pins ip_1_dft/CLK] [get_bd_pins ip_1_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CE
connect_bd_net [get_bd_pins ip_1_dft/CE] [get_bd_pins ip_1_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/SCLR
connect_bd_net [get_bd_pins ip_1_dft/SCLR] [get_bd_pins ip_1_dft/dft_0/SCLR]
create_bd_pin -dir I -from 17 -to 0 ip_1_dft/XN_RE
connect_bd_net [get_bd_pins ip_1_dft/XN_RE] [get_bd_pins ip_1_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 17 -to 0 ip_1_dft/XN_IM
connect_bd_net [get_bd_pins ip_1_dft/XN_IM] [get_bd_pins ip_1_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FD_IN
connect_bd_net [get_bd_pins ip_1_dft/FD_IN] [get_bd_pins ip_1_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FWD_INV
connect_bd_net [get_bd_pins ip_1_dft/FWD_INV] [get_bd_pins ip_1_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_1_dft/SIZE
connect_bd_net [get_bd_pins ip_1_dft/SIZE] [get_bd_pins ip_1_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/RFFD
connect_bd_net [get_bd_pins ip_1_dft/RFFD] [get_bd_pins ip_1_dft/dft_0/RFFD]
create_bd_pin -dir O -from 17 -to 0 ip_1_dft/XK_RE
connect_bd_net [get_bd_pins ip_1_dft/XK_RE] [get_bd_pins ip_1_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 17 -to 0 ip_1_dft/XK_IM
connect_bd_net [get_bd_pins ip_1_dft/XK_IM] [get_bd_pins ip_1_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_1_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_1_dft/BLK_EXP] [get_bd_pins ip_1_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/FD_OUT
connect_bd_net [get_bd_pins ip_1_dft/FD_OUT] [get_bd_pins ip_1_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_1_dft/DATA_VALID] [get_bd_pins ip_1_dft/dft_0/DATA_VALID]


########## axi_cdma ##########
create_bd_cell -type hier ip_2_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_2_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 62 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_2_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_2_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_2_axi_cdma/m_axi_aclk] [get_bd_pins ip_2_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_2_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_2_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_2_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_2_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_cdma/M_AXI] [get_bd_intf_pins ip_2_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_2_axi_cdma/cdma_introut] [get_bd_pins ip_2_axi_cdma/axi_cdma_0/cdma_introut]


########## gpio ##########
create_bd_cell -type hier ip_3_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_3_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x1 CONFIG.C_GPIO2_WIDTH 31 CONFIG.C_GPIO_WIDTH 3 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_3_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/GPIO] [get_bd_intf_pins ip_3_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/GPIO2] [get_bd_intf_pins ip_3_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/clk
connect_bd_net [get_bd_pins ip_3_gpio/clk] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/rst
connect_bd_net [get_bd_pins ip_3_gpio/rst] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_3_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_gpio/irq
connect_bd_net [get_bd_pins ip_3_gpio/irq] [get_bd_pins ip_3_gpio/gpio_0/ip2intc_irpt]


########## axi_hwicap ##########
create_bd_cell -type hier ip_4_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_4_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 1 CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 128 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 512 " [get_bd_cells ip_4_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_4_axi_hwicap/icap_clk] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_4_axi_hwicap/eos_in] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_4_axi_hwicap/s_axi_aclk] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_4_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_5_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_5_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Rotate CONFIG.Input_Width 44 CONFIG.Iterations 18 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 20 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 45 CONFIG.Round_Mode Truncate " [get_bd_cells ip_5_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_cordic/aclk
connect_bd_net [get_bd_pins ip_5_cordic/aclk] [get_bd_pins ip_5_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_5_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_5_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_5_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_5_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_5_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_5_cordic/cordic_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_6_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_6_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 4 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 4 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 4 CONFIG.C_TAVDV_PS_MEM_0 16261 CONFIG.C_TAVDV_PS_MEM_1 14003 CONFIG.C_TAVDV_PS_MEM_2 14791 CONFIG.C_TAVDV_PS_MEM_3 14010 CONFIG.C_TCEDV_PS_MEM_0 13510 CONFIG.C_TCEDV_PS_MEM_1 14937 CONFIG.C_TCEDV_PS_MEM_2 15200 CONFIG.C_TCEDV_PS_MEM_3 14301 CONFIG.C_THZCE_PS_MEM_0 7139 CONFIG.C_THZCE_PS_MEM_1 6862 CONFIG.C_THZCE_PS_MEM_2 6640 CONFIG.C_THZCE_PS_MEM_3 6803 CONFIG.C_THZOE_PS_MEM_0 7416 CONFIG.C_THZOE_PS_MEM_1 6380 CONFIG.C_THZOE_PS_MEM_2 6790 CONFIG.C_THZOE_PS_MEM_3 7497 CONFIG.C_TLZWE_PS_MEM_0 3724 CONFIG.C_TLZWE_PS_MEM_1 6044 CONFIG.C_TLZWE_PS_MEM_2 2159 CONFIG.C_TLZWE_PS_MEM_3 1170 CONFIG.C_TWC_PS_MEM_0 14958 CONFIG.C_TWC_PS_MEM_1 15911 CONFIG.C_TWC_PS_MEM_2 15233 CONFIG.C_TWC_PS_MEM_3 14924 CONFIG.C_TWPH_PS_MEM_0 12100 CONFIG.C_TWPH_PS_MEM_1 10963 CONFIG.C_TWPH_PS_MEM_2 11565 CONFIG.C_TWPH_PS_MEM_3 12510 CONFIG.C_TWP_PS_MEM_0 12398 CONFIG.C_TWP_PS_MEM_1 12464 CONFIG.C_TWP_PS_MEM_2 12751 CONFIG.C_TWP_PS_MEM_3 11779 CONFIG.C_WR_REC_TIME_MEM_0 26054 CONFIG.C_WR_REC_TIME_MEM_1 25501 CONFIG.C_WR_REC_TIME_MEM_2 27124 CONFIG.C_WR_REC_TIME_MEM_3 26859 " [get_bd_cells ip_6_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_6_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_6_emc/EMC_INTF] [get_bd_intf_pins ip_6_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_6_emc/clk
connect_bd_net [get_bd_pins ip_6_emc/clk] [get_bd_pins ip_6_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_emc/rdclk
connect_bd_net [get_bd_pins ip_6_emc/rdclk] [get_bd_pins ip_6_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_emc/rst
connect_bd_net [get_bd_pins ip_6_emc/rst] [get_bd_pins ip_6_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_emc/AXI] [get_bd_intf_pins ip_6_emc/emc_0/S_AXI_MEM]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_7_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_7_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_7_axi_ethernet_lite/axi_ethernetlite_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_8_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_8_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Half CONFIG.a_tuser_width 26 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_divide_by_zero 0 CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Reciprocal CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_8_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_floating_point/aclk
connect_bd_net [get_bd_pins ip_8_floating_point/aclk] [get_bd_pins ip_8_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_floating_point/aclken
connect_bd_net [get_bd_pins ip_8_floating_point/aclken] [get_bd_pins ip_8_floating_point/floating_point_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_8_floating_point/S_AXIS_A] [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_8_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_8_floating_point/floating_point_0/M_AXIS_RESULT]


########## gpio ##########
create_bd_cell -type hier ip_9_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_9_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x78419d91 CONFIG.C_DOUT_DEFAULT_2 0x7fffffff CONFIG.C_GPIO2_WIDTH 25 CONFIG.C_GPIO_WIDTH 31 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x7c30372e CONFIG.C_TRI_DEFAULT_2 0xd784419 " [get_bd_cells ip_9_gpio/gpio_0]
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


########## xadc_wiz ##########
create_bd_cell -type hier ip_10_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_10_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_10_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_10_xadc_wiz/dclk_in] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_10_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_10_xadc_wiz/convstclk_in] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_10_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_10_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_10_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_10_xadc_wiz/eoc_out] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_10_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_10_xadc_wiz/eos_out] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_10_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_10_xadc_wiz/alarm_out] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_10_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_10_xadc_wiz/busy_out] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_10_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_10_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_10_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_10_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_10_xadc_wiz/jtaglocked_out] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_10_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_10_xadc_wiz/jtagmodified_out] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_10_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_10_xadc_wiz/jtagbusy_out] [get_bd_pins ip_10_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_11_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_11_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_11_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_11_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite/MII] [get_bd_intf_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_11_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_11_axi_ethernet_lite/clk] [get_bd_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_11_axi_ethernet_lite/reset] [get_bd_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_11_axi_ethernet_lite/irq] [get_bd_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_12_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_12_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0xb9d42e CONFIG.C_DOUT_DEFAULT_2 0x72bfed0 CONFIG.C_GPIO2_WIDTH 11 CONFIG.C_GPIO_WIDTH 28 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_12_gpio/gpio_0]
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
set_property -dict "CONFIG.C_ADDR_WIDTH 39 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_13_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_13_axi_dma/axi_resetn] [get_bd_pins ip_13_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_13_axi_dma/mm2s_introut] [get_bd_pins ip_13_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_13_axi_dma/s2mm_introut] [get_bd_pins ip_13_axi_dma/axi_dma_0/s2mm_introut]


########## cordic ##########
create_bd_cell -type hier ip_14_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_14_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Translate CONFIG.Input_Width 19 CONFIG.Iterations 40 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 9 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 32 CONFIG.Round_Mode Truncate " [get_bd_cells ip_14_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_cordic/aclk
connect_bd_net [get_bd_pins ip_14_cordic/aclk] [get_bd_pins ip_14_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_cordic/aclken
connect_bd_net [get_bd_pins ip_14_cordic/aclken] [get_bd_pins ip_14_cordic/cordic_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_14_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_14_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_14_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_14_cordic/cordic_0/M_AXIS_DOUT]


########## microblaze ##########
create_bd_cell -type hier ip_15_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 32 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 1 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 4 CONFIG.C_MMU_ITLB_SIZE 8 CONFIG.C_MMU_PRIVILEGED_INSTR 1 CONFIG.C_MMU_TLB_ACCESS 2 CONFIG.C_MMU_ZONES 9 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MMU 3 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_15_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_microblaze/Clk
connect_bd_net [get_bd_pins ip_15_microblaze/Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_microblaze/Reset
connect_bd_net [get_bd_pins ip_15_microblaze/Reset] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_15_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/INTERRUPT] [get_bd_intf_pins ip_15_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/M_AXI_DP] [get_bd_intf_pins ip_15_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_15_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_15_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xd903b643dc10e2c CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_15_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_15_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_15_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_15_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x37c31a4f09845cd CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_15_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_15_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_15_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_15_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_15_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_15_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_15_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_15_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_15_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_15_microblaze/mem/BRAM_PORTB]


########## uartlite ##########
create_bd_cell -type hier ip_16_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_16_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 230400 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Odd " [get_bd_cells ip_16_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_16_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_16_uartlite/UART] [get_bd_intf_pins ip_16_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_16_uartlite/clk
connect_bd_net [get_bd_pins ip_16_uartlite/clk] [get_bd_pins ip_16_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_uartlite/reset
connect_bd_net [get_bd_pins ip_16_uartlite/reset] [get_bd_pins ip_16_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_uartlite/AXI] [get_bd_intf_pins ip_16_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_uartlite/irq
connect_bd_net [get_bd_pins ip_16_uartlite/irq] [get_bd_pins ip_16_uartlite/uart_0/interrupt]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_17_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_17_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 1 CONFIG.C_FIFO_DEPTH 16 CONFIG.C_NUM_TRANSFER_BITS 16 CONFIG.C_SCK_RATIO 2 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_17_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_17_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_quad_spi/IIC] [get_bd_intf_pins ip_17_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/clk] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/reset] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_17_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_17_axi_quad_spi/irq] [get_bd_pins ip_17_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


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
set_property -dict "CONFIG.NUM_PORTS 10 " [get_bd_cells ip_20_intc/concat_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_20_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_20_intc/irq] [get_bd_intf_pins ip_20_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_21_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_21_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 12 CONFIG.NUM_SI 5 " [get_bd_cells ip_21_axi_legacy/axi_0]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_22_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_22_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_22_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_22_axis_broadcaster/aclk] [get_bd_pins ip_22_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_22_axis_broadcaster/aresetn] [get_bd_pins ip_22_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_23_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_23_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_23_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_23_axis_broadcaster/aclk] [get_bd_pins ip_23_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_23_axis_broadcaster/aresetn] [get_bd_pins ip_23_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_24_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_24_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aclk] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aresetn] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_25_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_25_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_25_axis_dwidth_converter/aclk] [get_bd_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_25_axis_dwidth_converter/aresetn] [get_bd_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_26_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_26_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aclk] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aresetn] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_27_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_27_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 28 " [get_bd_cells ip_27_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aclk] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aresetn] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_28_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_28_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_28_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aclk] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aresetn] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 17 -to 0 ip_30_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 17 -to 0 ip_31_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_32_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_32_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_32_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_32_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_1] [get_bd_pins ip_32_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_32_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_2] [get_bd_pins ip_32_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_33_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_33_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_33_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_2] [get_bd_pins ip_33_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_3] [get_bd_pins ip_33_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_4] [get_bd_pins ip_33_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_5] [get_bd_pins ip_33_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_36_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_18_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_19_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio_GPIO] [get_bd_intf_pins ip_3_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio_GPIO2] [get_bd_intf_pins ip_3_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_6_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_6_emc_EMC_INTF] [get_bd_intf_pins ip_6_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_7_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite_MII] [get_bd_intf_pins ip_7_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_7_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_7_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO] [get_bd_intf_pins ip_9_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO2] [get_bd_intf_pins ip_9_gpio/GPIO2]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_10_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_10_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_10_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_11_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite_MII] [get_bd_intf_pins ip_11_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_11_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_11_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO] [get_bd_intf_pins ip_12_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO2] [get_bd_intf_pins ip_12_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_16_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_16_uartlite_UART] [get_bd_intf_pins ip_16_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_17_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_quad_spi_IIC] [get_bd_intf_pins ip_17_axi_quad_spi/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 5 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_33_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_35_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_19_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset] [get_bd_pins ip_1_dft/SCLR]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_3_gpio/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_6_emc/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_9_gpio/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_12_gpio/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_18_reset/mb_reset] [get_bd_pins ip_15_microblaze/Reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_16_uartlite/reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_0_fft/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_1_dft/CLK]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_3_gpio/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_5_cordic/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_6_emc/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_6_emc/rdclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_7_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_8_floating_point/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_9_gpio/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_10_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_10_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_11_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_12_gpio/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_14_cordic/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_15_microblaze/Clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_16_uartlite/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_17_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_17_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_18_reset/clk_in]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_locked] [get_bd_pins ip_18_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_20_intc/irq_0] [get_bd_pins ip_0_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_20_intc/irq_1] [get_bd_pins ip_2_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_2] [get_bd_pins ip_3_gpio/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_3] [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_20_intc/irq_4] [get_bd_pins ip_7_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_5] [get_bd_pins ip_11_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_6] [get_bd_pins ip_13_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_7] [get_bd_pins ip_13_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_8] [get_bd_pins ip_16_uartlite/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_9] [get_bd_pins ip_17_axi_quad_spi/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_microblaze/INTERRUPT] [get_bd_intf_pins ip_20_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/M_AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_21_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_21_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_21_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_microblaze/M_AXI_DP] [get_bd_intf_pins ip_21_axi_legacy/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_emc/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_uartlite/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_intc/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_22_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_23_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_floating_point/S_AXIS_A] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_fft/S_AXIS_DATA] [get_bd_intf_pins ip_5_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_0_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_4_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_1_dft/RFFD]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_RE]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_IM]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_1_dft/SIZE]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_1_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_1] [get_bd_pins ip_1_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_2] [get_bd_pins ip_1_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_10_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_10_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_2] [get_bd_pins ip_10_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_3] [get_bd_pins ip_10_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_4] [get_bd_pins ip_10_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_5] [get_bd_pins ip_10_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_8_floating_point/aclken]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_1_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_1_dft/FD_IN]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_10_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_1_dft/CE]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_10_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_14_cordic/aclken]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_10_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_21_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_20_intc/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_21_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_22_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_23_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_28_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_fft/M_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_fft/M_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 17 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_CONFIG declared=17 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_CONFIG declared=17 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_cordic/S_AXIS_CARTESIAN declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_cordic/S_AXIS_CARTESIAN declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_cordic/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_cordic/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_cordic/S_AXIS_CARTESIAN declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_cordic/S_AXIS_CARTESIAN declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }


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
