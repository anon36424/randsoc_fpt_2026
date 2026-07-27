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
set_property -dict "CONFIG.C_ADDR_WIDTH 53 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 2 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_0_axi_cdma/axi_cdma_0]
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


########## emc ##########
create_bd_cell -type hier ip_1_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_1_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 5 CONFIG.C_TAVDV_PS_MEM_0 15719 CONFIG.C_TAVDV_PS_MEM_1 14384 CONFIG.C_TCEDV_PS_MEM_0 14940 CONFIG.C_TCEDV_PS_MEM_1 14155 CONFIG.C_THZCE_PS_MEM_0 7197 CONFIG.C_THZCE_PS_MEM_1 6709 CONFIG.C_THZOE_PS_MEM_0 7193 CONFIG.C_THZOE_PS_MEM_1 7619 CONFIG.C_TLZWE_PS_MEM_0 1080 CONFIG.C_TLZWE_PS_MEM_1 3414 CONFIG.C_TWC_PS_MEM_0 14577 CONFIG.C_TWC_PS_MEM_1 16082 CONFIG.C_TWPH_PS_MEM_0 12081 CONFIG.C_TWPH_PS_MEM_1 11100 CONFIG.C_TWP_PS_MEM_0 12061 CONFIG.C_TWP_PS_MEM_1 12451 CONFIG.C_WR_REC_TIME_MEM_0 24678 CONFIG.C_WR_REC_TIME_MEM_1 26561 " [get_bd_cells ip_1_emc/emc_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_2_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_2_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Int64 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Fixed_to_float CONFIG.result_precision_type Double " [get_bd_cells ip_2_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_floating_point/aclk
connect_bd_net [get_bd_pins ip_2_floating_point/aclk] [get_bd_pins ip_2_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_floating_point/aclken
connect_bd_net [get_bd_pins ip_2_floating_point/aclken] [get_bd_pins ip_2_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_2_floating_point/aresetn
connect_bd_net [get_bd_pins ip_2_floating_point/aresetn] [get_bd_pins ip_2_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_2_floating_point/S_AXIS_A] [get_bd_intf_pins ip_2_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_2_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_2_floating_point/floating_point_0/M_AXIS_RESULT]


########## dft ##########
create_bd_cell -type hier ip_3_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_3_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 8 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_3_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/CLK
connect_bd_net [get_bd_pins ip_3_dft/CLK] [get_bd_pins ip_3_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/CE
connect_bd_net [get_bd_pins ip_3_dft/CE] [get_bd_pins ip_3_dft/dft_0/CE]
create_bd_pin -dir I -from 7 -to 0 ip_3_dft/XN_RE
connect_bd_net [get_bd_pins ip_3_dft/XN_RE] [get_bd_pins ip_3_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 7 -to 0 ip_3_dft/XN_IM
connect_bd_net [get_bd_pins ip_3_dft/XN_IM] [get_bd_pins ip_3_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FD_IN
connect_bd_net [get_bd_pins ip_3_dft/FD_IN] [get_bd_pins ip_3_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FWD_INV
connect_bd_net [get_bd_pins ip_3_dft/FWD_INV] [get_bd_pins ip_3_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_3_dft/SIZE
connect_bd_net [get_bd_pins ip_3_dft/SIZE] [get_bd_pins ip_3_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/RFFD
connect_bd_net [get_bd_pins ip_3_dft/RFFD] [get_bd_pins ip_3_dft/dft_0/RFFD]
create_bd_pin -dir O -from 7 -to 0 ip_3_dft/XK_RE
connect_bd_net [get_bd_pins ip_3_dft/XK_RE] [get_bd_pins ip_3_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 7 -to 0 ip_3_dft/XK_IM
connect_bd_net [get_bd_pins ip_3_dft/XK_IM] [get_bd_pins ip_3_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_3_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_3_dft/BLK_EXP] [get_bd_pins ip_3_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/FD_OUT
connect_bd_net [get_bd_pins ip_3_dft/FD_OUT] [get_bd_pins ip_3_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_3_dft/DATA_VALID] [get_bd_pins ip_3_dft/dft_0/DATA_VALID]


########## axi_hwicap ##########
create_bd_cell -type hier ip_4_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_4_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 1 CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 128 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_4_axi_hwicap/axi_hwicap_0]
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


########## reset ##########
create_bd_cell -type hier ip_5_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_5_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_reset/clk_in
connect_bd_net [get_bd_pins ip_5_reset/clk_in] [get_bd_pins ip_5_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_5_reset/reset_in
connect_bd_net [get_bd_pins ip_5_reset/reset_in] [get_bd_pins ip_5_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_5_reset/dcm_locked
connect_bd_net [get_bd_pins ip_5_reset/dcm_locked] [get_bd_pins ip_5_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_5_reset/mb_reset
connect_bd_net [get_bd_pins ip_5_reset/mb_reset] [get_bd_pins ip_5_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_5_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_5_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_5_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset] [get_bd_pins ip_5_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_5_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_5_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_6_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_6_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_in] [get_bd_pins ip_6_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_6_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_6_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_6_clk_wiz/reset
connect_bd_net [get_bd_pins ip_6_clk_wiz/reset] [get_bd_pins ip_6_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_6_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_locked] [get_bd_pins ip_6_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_7_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_7_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_7_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_7_intc/concat_0]
connect_bd_net [get_bd_pins ip_7_intc/concat_0/dout] [get_bd_pins ip_7_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/clk
connect_bd_net [get_bd_pins ip_7_intc/clk] [get_bd_pins ip_7_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/reset
connect_bd_net [get_bd_pins ip_7_intc/reset] [get_bd_pins ip_7_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_intc/AXI] [get_bd_intf_pins ip_7_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/irq_0
connect_bd_net [get_bd_pins ip_7_intc/irq_0] [get_bd_pins ip_7_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_7_intc/irq_1
connect_bd_net [get_bd_pins ip_7_intc/irq_1] [get_bd_pins ip_7_intc/concat_0/In1]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_7_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_7_intc/irq] [get_bd_intf_pins ip_7_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_8_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_8_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 1 " [get_bd_cells ip_8_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_legacy/clk
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_legacy/reset
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_M0] [get_bd_intf_pins ip_8_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_S0] [get_bd_intf_pins ip_8_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_S1] [get_bd_intf_pins ip_8_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_S2] [get_bd_intf_pins ip_8_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_legacy/AXI_S3] [get_bd_intf_pins ip_8_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_8_axi_legacy/clk] [get_bd_pins ip_8_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_8_axi_legacy/reset] [get_bd_pins ip_8_axi_legacy/axi_0/M03_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_9_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_9_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_9_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_9_axis_dwidth_converter/aclk] [get_bd_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_9_axis_dwidth_converter/aresetn] [get_bd_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_10_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_10_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_10_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_10_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/out0] [get_bd_pins ip_10_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_10_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_10_slice_and_concat/in_0] [get_bd_pins ip_10_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 7 -to 0 ip_10_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_10_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_10_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/in_1] [get_bd_pins ip_10_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/slice_1/dout] [get_bd_pins ip_10_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_11_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_11_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_11_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_11_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/out0] [get_bd_pins ip_11_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 7 -to 0 ip_11_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_11_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_11_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/in_0] [get_bd_pins ip_11_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/slice_0/dout] [get_bd_pins ip_11_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 7 -to 0 ip_11_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_11_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_11_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/in_1] [get_bd_pins ip_11_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/slice_1/dout] [get_bd_pins ip_11_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_12_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_12_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_12_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_12_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_12_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_12_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_12_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_13_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_13_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_13_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_13_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 7 -to 0 ip_13_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_13_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_13_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/slice_0/dout] [get_bd_pins ip_13_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_13_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_13_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_2] [get_bd_pins ip_13_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_3] [get_bd_pins ip_13_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_14_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_14_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_14_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_14_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_14_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_14_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_15_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_15_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_15_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_15_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_16_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_16_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_16_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_5_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_6_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_1_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_1_emc_EMC_INTF] [get_bd_intf_pins ip_1_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_7_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_9_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_2_floating_point/M_AXIS_RESULT]

########## Connecting Protocol.DATA ports ##########

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_14_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_15_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_16_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_17_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_1_emc/rst]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_2_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_1_emc/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_1_emc/rdclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_2_floating_point/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_3_dft/CLK]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_5_reset/clk_in]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_locked] [get_bd_pins ip_5_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_7_intc/irq_0] [get_bd_pins ip_0_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_7_intc/irq_1] [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/M_AXI] [get_bd_intf_pins ip_8_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_emc/AXI] [get_bd_intf_pins ip_8_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_intc/AXI] [get_bd_intf_pins ip_8_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_floating_point/S_AXIS_A] [get_bd_intf_pins ip_9_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_IM]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/in_0] [get_bd_pins ip_3_dft/RFFD]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/in_1] [get_bd_pins ip_3_dft/XK_RE]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/out0] [get_bd_pins ip_3_dft/SIZE]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/in_0] [get_bd_pins ip_3_dft/XK_RE]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/in_1] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_4_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_RE]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_3_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_2] [get_bd_pins ip_3_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_3] [get_bd_pins ip_3_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_3_dft/CE]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_3_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_3_dft/FD_IN]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_2_floating_point/aclken]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_8_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_9_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_7_intc/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_8_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_9_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }


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
