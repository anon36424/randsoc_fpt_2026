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



########## conv_encoder ##########
create_bd_cell -type hier ip_0_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_0_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 4 CONFIG.convolution_code0 11 CONFIG.convolution_code1 10 CONFIG.convolution_code2 15 CONFIG.convolution_code3 13 CONFIG.convolution_code4 7 CONFIG.convolution_code5 1 CONFIG.convolution_code6 15 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 3 CONFIG.output_rate 5 CONFIG.puncture_code0 101 CONFIG.puncture_code1 111 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_0_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_0_conv_encoder/aclk] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_0_conv_encoder/aresetn] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_hwicap ##########
create_bd_cell -type hier ip_1_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_1_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_1_axi_hwicap/axi_hwicap_0]
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


########## axi_dma ##########
create_bd_cell -type hier ip_2_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_2_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 52 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_2_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_2_axi_dma/axi_resetn] [get_bd_pins ip_2_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_2_axi_dma/s2mm_introut] [get_bd_pins ip_2_axi_dma/axi_dma_0/s2mm_introut]


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 106 CONFIG.Latency 30 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 163 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 105 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 162 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/SCLR
connect_bd_net [get_bd_pins ip_3_accumulator/SCLR] [get_bd_pins ip_3_accumulator/accumulator_0/SCLR]


########## accumulator ##########
create_bd_cell -type hier ip_4_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_4_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 5801e88880b7dcb97ef39d6b9d6bd8731d8f4a8d61d91b8591afe267c7ac CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 224 CONFIG.Latency 20 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 239 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_4_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/clk
connect_bd_net [get_bd_pins ip_4_accumulator/clk] [get_bd_pins ip_4_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 223 -to 0 ip_4_accumulator/B
connect_bd_net [get_bd_pins ip_4_accumulator/B] [get_bd_pins ip_4_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 238 -to 0 ip_4_accumulator/Q
connect_bd_net [get_bd_pins ip_4_accumulator/Q] [get_bd_pins ip_4_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/CE
connect_bd_net [get_bd_pins ip_4_accumulator/CE] [get_bd_pins ip_4_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/Bypass
connect_bd_net [get_bd_pins ip_4_accumulator/Bypass] [get_bd_pins ip_4_accumulator/accumulator_0/Bypass]


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
set_property -dict "CONFIG.NUM_MI 3 CONFIG.NUM_SI 1 " [get_bd_cells ip_8_axi_legacy/axi_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_9_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_9_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_9_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_9_axis_dwidth_converter/aclk] [get_bd_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_9_axis_dwidth_converter/aresetn] [get_bd_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_10_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_10_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_10_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aclk] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aresetn] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_11_reduce
create_bd_pin -dir I -from 70 -to 0 ip_11_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_11_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_11_reduce/concat]
connect_bd_net [get_bd_pins ip_11_reduce/out0] [get_bd_pins ip_11_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_0]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_11_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_11_reduce/slice_0/dout] [get_bd_pins ip_11_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_0/Res] [get_bd_pins ip_11_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_1]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_11_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_11_reduce/slice_1/dout] [get_bd_pins ip_11_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_1/Res] [get_bd_pins ip_11_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_2]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_11_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_11_reduce/slice_2/dout] [get_bd_pins ip_11_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_2/Res] [get_bd_pins ip_11_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_3]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_11_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_11_reduce/slice_3/dout] [get_bd_pins ip_11_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_3/Res] [get_bd_pins ip_11_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_4]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_11_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_11_reduce/slice_4/dout] [get_bd_pins ip_11_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_4/Res] [get_bd_pins ip_11_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_5]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_11_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_11_reduce/slice_5/dout] [get_bd_pins ip_11_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_5/Res] [get_bd_pins ip_11_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 20 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_6]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_11_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_11_reduce/slice_6/dout] [get_bd_pins ip_11_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_6/Res] [get_bd_pins ip_11_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 22 CONFIG.DIN_TO 21 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_7]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_11_reduce/slice_7/dout] [get_bd_pins ip_11_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_7/Res] [get_bd_pins ip_11_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 24 CONFIG.DIN_TO 23 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_8]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_11_reduce/slice_8/dout] [get_bd_pins ip_11_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_8/Res] [get_bd_pins ip_11_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 26 CONFIG.DIN_TO 25 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_9]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_11_reduce/slice_9/dout] [get_bd_pins ip_11_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_9/Res] [get_bd_pins ip_11_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 28 CONFIG.DIN_TO 27 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_10]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_11_reduce/slice_10/dout] [get_bd_pins ip_11_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_10/Res] [get_bd_pins ip_11_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 29 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_11]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_11_reduce/slice_11/dout] [get_bd_pins ip_11_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_11/Res] [get_bd_pins ip_11_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_12]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_11_reduce/slice_12/dout] [get_bd_pins ip_11_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_12/Res] [get_bd_pins ip_11_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 34 CONFIG.DIN_TO 33 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_13]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_11_reduce/slice_13/dout] [get_bd_pins ip_11_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_13/Res] [get_bd_pins ip_11_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 36 CONFIG.DIN_TO 35 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_14]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_11_reduce/slice_14/dout] [get_bd_pins ip_11_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_14/Res] [get_bd_pins ip_11_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 38 CONFIG.DIN_TO 37 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_15]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_11_reduce/slice_15/dout] [get_bd_pins ip_11_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_15/Res] [get_bd_pins ip_11_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 40 CONFIG.DIN_TO 39 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_16]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_11_reduce/slice_16/dout] [get_bd_pins ip_11_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_16/Res] [get_bd_pins ip_11_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 42 CONFIG.DIN_TO 41 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_17]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_11_reduce/slice_17/dout] [get_bd_pins ip_11_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_17/Res] [get_bd_pins ip_11_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 43 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_18]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_11_reduce/slice_18/dout] [get_bd_pins ip_11_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_18/Res] [get_bd_pins ip_11_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 46 CONFIG.DIN_TO 45 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_19]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_11_reduce/slice_19/dout] [get_bd_pins ip_11_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_19/Res] [get_bd_pins ip_11_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 48 CONFIG.DIN_TO 47 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_20]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_11_reduce/slice_20/dout] [get_bd_pins ip_11_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_20/Res] [get_bd_pins ip_11_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 50 CONFIG.DIN_TO 49 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_21]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_11_reduce/slice_21/dout] [get_bd_pins ip_11_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_21/Res] [get_bd_pins ip_11_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 52 CONFIG.DIN_TO 51 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_22]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_11_reduce/slice_22/dout] [get_bd_pins ip_11_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_22/Res] [get_bd_pins ip_11_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 54 CONFIG.DIN_TO 53 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_23]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_11_reduce/slice_23/dout] [get_bd_pins ip_11_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_23/Res] [get_bd_pins ip_11_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 56 CONFIG.DIN_TO 55 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_24]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_11_reduce/slice_24/dout] [get_bd_pins ip_11_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_24/Res] [get_bd_pins ip_11_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 58 CONFIG.DIN_TO 57 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_25]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_11_reduce/slice_25/dout] [get_bd_pins ip_11_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_25/Res] [get_bd_pins ip_11_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 60 CONFIG.DIN_TO 59 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_26]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_11_reduce/slice_26/dout] [get_bd_pins ip_11_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_26/Res] [get_bd_pins ip_11_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 62 CONFIG.DIN_TO 61 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_27]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_11_reduce/slice_27/dout] [get_bd_pins ip_11_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_27/Res] [get_bd_pins ip_11_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 64 CONFIG.DIN_TO 63 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_28]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_11_reduce/slice_28/dout] [get_bd_pins ip_11_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_28/Res] [get_bd_pins ip_11_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 66 CONFIG.DIN_TO 65 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_29]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_11_reduce/slice_29/dout] [get_bd_pins ip_11_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_29/Res] [get_bd_pins ip_11_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 68 CONFIG.DIN_TO 67 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_30]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_11_reduce/slice_30/dout] [get_bd_pins ip_11_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_30/Res] [get_bd_pins ip_11_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 70 CONFIG.DIN_TO 69 CONFIG.DIN_WIDTH 71 " [get_bd_cells ip_11_reduce/slice_31]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_11_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_11_reduce/slice_31/dout] [get_bd_pins ip_11_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_31/Res] [get_bd_pins ip_11_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_12_slice_and_concat
create_bd_pin -dir O -from 70 -to 0 ip_12_slice_and_concat/out0
create_bd_pin -dir I -from 162 -to 0 ip_12_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_12_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 70 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 163 " [get_bd_cells ip_12_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_12_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_12_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_13_slice_and_concat
create_bd_pin -dir O -from 105 -to 0 ip_13_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_13_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_13_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 162 -to 0 ip_13_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 162 CONFIG.DIN_TO 71 CONFIG.DIN_WIDTH 163 " [get_bd_cells ip_13_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_13_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/slice_0/dout] [get_bd_pins ip_13_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 238 -to 0 ip_13_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 239 " [get_bd_cells ip_13_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_13_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/slice_1/dout] [get_bd_pins ip_13_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_14_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_14_slice_and_concat/out0
create_bd_pin -dir I -from 238 -to 0 ip_14_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 14 CONFIG.DIN_WIDTH 239 " [get_bd_cells ip_14_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_14_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_14_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 223 -to 0 ip_15_slice_and_concat/out0
create_bd_pin -dir I -from 238 -to 0 ip_15_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 238 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 239 " [get_bd_cells ip_15_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_15_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_16_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_16_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_16_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_5_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_6_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_1_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap_ICAP] [get_bd_intf_pins ip_1_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_1_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_1_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_7_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_9_axis_dwidth_converter/S_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_11_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_16_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_17_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_0_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_0_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_4_accumulator/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_5_reset/clk_in]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_locked] [get_bd_pins ip_5_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_7_intc/irq_0] [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_7_intc/irq_1] [get_bd_pins ip_2_axi_dma/s2mm_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_8_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_intc/AXI] [get_bd_intf_pins ip_8_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_9_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_11_reduce/in0]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_1_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/B]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/CE]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_8_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_9_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_10_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_7_intc/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_8_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_9_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_10_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }


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
