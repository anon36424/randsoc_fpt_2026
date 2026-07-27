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
set_property -dict "CONFIG.C_ADDR_WIDTH 47 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 256 CONFIG.C_M_AXI_MAX_BURST_LEN 8 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_0_axi_cdma/axi_cdma_0]
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
set_property -dict "CONFIG.C_MEM0_TYPE 5 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 15 CONFIG.C_TAVDV_PS_MEM_0 15879 CONFIG.C_TAVDV_PS_MEM_1 14115 CONFIG.C_TCEDV_PS_MEM_0 13884 CONFIG.C_TCEDV_PS_MEM_1 13830 CONFIG.C_THZCE_PS_MEM_0 6532 CONFIG.C_THZCE_PS_MEM_1 7220 CONFIG.C_THZOE_PS_MEM_0 7616 CONFIG.C_THZOE_PS_MEM_1 6769 CONFIG.C_TLZWE_PS_MEM_0 7931 CONFIG.C_TLZWE_PS_MEM_1 1325 CONFIG.C_TWC_PS_MEM_0 15356 CONFIG.C_TWC_PS_MEM_1 15116 CONFIG.C_TWPH_PS_MEM_0 11740 CONFIG.C_TWPH_PS_MEM_1 11012 CONFIG.C_TWP_PS_MEM_0 10862 CONFIG.C_TWP_PS_MEM_1 10915 CONFIG.C_WR_REC_TIME_MEM_0 28144 CONFIG.C_WR_REC_TIME_MEM_1 28509 " [get_bd_cells ip_1_emc/emc_0]
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


########## conv_encoder ##########
create_bd_cell -type hier ip_2_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_2_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 7 CONFIG.convolution_code0 36 CONFIG.convolution_code1 25 CONFIG.convolution_code2 62 CONFIG.convolution_code3 123 CONFIG.convolution_code4 78 CONFIG.convolution_code5 67 CONFIG.convolution_code6 50 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 4 CONFIG.output_rate 5 CONFIG.puncture_code0 0111 CONFIG.puncture_code1 0101 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_2_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_2_conv_encoder/aclk] [get_bd_pins ip_2_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_2_conv_encoder/aclken] [get_bd_pins ip_2_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_2_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_2_conv_encoder/aresetn] [get_bd_pins ip_2_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_2_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_2_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_2_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_2_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## reset ##########
create_bd_cell -type hier ip_3_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_3_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_reset/clk_in
connect_bd_net [get_bd_pins ip_3_reset/clk_in] [get_bd_pins ip_3_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_3_reset/reset_in
connect_bd_net [get_bd_pins ip_3_reset/reset_in] [get_bd_pins ip_3_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_3_reset/dcm_locked
connect_bd_net [get_bd_pins ip_3_reset/dcm_locked] [get_bd_pins ip_3_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_3_reset/mb_reset
connect_bd_net [get_bd_pins ip_3_reset/mb_reset] [get_bd_pins ip_3_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_3_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_3_reset/peripheral_areset_n] [get_bd_pins ip_3_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_3_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_3_reset/peripheral_areset] [get_bd_pins ip_3_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_3_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_3_reset/interconnect_aresetn] [get_bd_pins ip_3_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_4_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_4_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_in] [get_bd_pins ip_4_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_4_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_4_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_4_clk_wiz/reset
connect_bd_net [get_bd_pins ip_4_clk_wiz/reset] [get_bd_pins ip_4_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_4_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_locked] [get_bd_pins ip_4_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_5_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_5_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_5_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 1 " [get_bd_cells ip_5_intc/concat_0]
connect_bd_net [get_bd_pins ip_5_intc/concat_0/dout] [get_bd_pins ip_5_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_5_intc/clk
connect_bd_net [get_bd_pins ip_5_intc/clk] [get_bd_pins ip_5_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_intc/reset
connect_bd_net [get_bd_pins ip_5_intc/reset] [get_bd_pins ip_5_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_intc/AXI] [get_bd_intf_pins ip_5_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_5_intc/irq_0
connect_bd_net [get_bd_pins ip_5_intc/irq_0] [get_bd_pins ip_5_intc/concat_0/In0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_5_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_5_intc/irq] [get_bd_intf_pins ip_5_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_6_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_6_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 3 CONFIG.NUM_SI 1 " [get_bd_cells ip_6_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_legacy/clk
connect_bd_net [get_bd_pins ip_6_axi_legacy/clk] [get_bd_pins ip_6_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_legacy/reset
connect_bd_net [get_bd_pins ip_6_axi_legacy/reset] [get_bd_pins ip_6_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_legacy/AXI_M0] [get_bd_intf_pins ip_6_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_6_axi_legacy/clk] [get_bd_pins ip_6_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_6_axi_legacy/reset] [get_bd_pins ip_6_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_legacy/AXI_S0] [get_bd_intf_pins ip_6_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_6_axi_legacy/clk] [get_bd_pins ip_6_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_6_axi_legacy/reset] [get_bd_pins ip_6_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_legacy/AXI_S1] [get_bd_intf_pins ip_6_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_6_axi_legacy/clk] [get_bd_pins ip_6_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_6_axi_legacy/reset] [get_bd_pins ip_6_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_legacy/AXI_S2] [get_bd_intf_pins ip_6_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_6_axi_legacy/clk] [get_bd_pins ip_6_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_6_axi_legacy/reset] [get_bd_pins ip_6_axi_legacy/axi_0/M02_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_7_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_7_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_7_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_7_axis_dwidth_converter/aclk] [get_bd_pins ip_7_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_7_axis_dwidth_converter/aresetn] [get_bd_pins ip_7_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_7_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_7_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_7_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_7_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_8_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_8_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_8_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_3_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_4_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_1_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_1_emc_EMC_INTF] [get_bd_intf_pins ip_1_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_5_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_7_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_2_conv_encoder/M_AXIS_DATA]

########## Connecting Protocol.DATA ports ##########

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_8_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_4_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_5_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_3_reset/peripheral_areset_n] [get_bd_pins ip_1_emc/rst]
connect_bd_net [get_bd_pins ip_3_reset/interconnect_aresetn] [get_bd_pins ip_2_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_1_emc/clk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_1_emc/rdclk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_2_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_3_reset/clk_in]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_locked] [get_bd_pins ip_3_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_5_intc/irq_0] [get_bd_pins ip_0_axi_cdma/cdma_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/M_AXI] [get_bd_intf_pins ip_6_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_6_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_emc/AXI] [get_bd_intf_pins ip_6_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_intc/AXI] [get_bd_intf_pins ip_6_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_7_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/out0] [get_bd_pins ip_2_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/out0] [get_bd_pins ip_8_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_3_reset/interconnect_aresetn] [get_bd_pins ip_6_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_3_reset/interconnect_aresetn] [get_bd_pins ip_7_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_5_intc/clk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_6_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_7_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
