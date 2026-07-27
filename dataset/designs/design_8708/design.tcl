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



########## emc ##########
create_bd_cell -type hier ip_0_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_0_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 10 CONFIG.C_TAVDV_PS_MEM_0 14858 CONFIG.C_TCEDV_PS_MEM_0 14822 CONFIG.C_THZCE_PS_MEM_0 7251 CONFIG.C_THZOE_PS_MEM_0 7317 CONFIG.C_TLZWE_PS_MEM_0 9290 CONFIG.C_TWC_PS_MEM_0 15651 CONFIG.C_TWPH_PS_MEM_0 12883 CONFIG.C_TWP_PS_MEM_0 11316 CONFIG.C_WR_REC_TIME_MEM_0 25758 " [get_bd_cells ip_0_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc/EMC_INTF] [get_bd_intf_pins ip_0_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/clk
connect_bd_net [get_bd_pins ip_0_emc/clk] [get_bd_pins ip_0_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/rdclk
connect_bd_net [get_bd_pins ip_0_emc/rdclk] [get_bd_pins ip_0_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/rst
connect_bd_net [get_bd_pins ip_0_emc/rst] [get_bd_pins ip_0_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_0_emc/emc_0/S_AXI_MEM]


########## xadc_wiz ##########
create_bd_cell -type hier ip_1_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_1_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCA 1 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 0 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_1_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_1_xadc_wiz/dclk_in] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_1_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_1_xadc_wiz/reset_in] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/ot_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/eoc_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/eos_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/alarm_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/busy_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_1_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_1_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_1_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_2_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_2_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_2_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_2_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/MII] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_2_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/clk] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/reset] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/irq] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_cdma ##########
create_bd_cell -type hier ip_3_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_3_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 51 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_3_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_3_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_3_axi_cdma/m_axi_aclk] [get_bd_pins ip_3_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_3_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_3_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_3_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_3_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_cdma/M_AXI] [get_bd_intf_pins ip_3_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_3_axi_cdma/cdma_introut] [get_bd_pins ip_3_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_4_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_4_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_4_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_4_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_ethernet_lite/MII] [get_bd_intf_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_4_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_4_axi_ethernet_lite/clk] [get_bd_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_4_axi_ethernet_lite/reset] [get_bd_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_4_axi_ethernet_lite/irq] [get_bd_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_5_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_5_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 56 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 8 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 8 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 128 CONFIG.C_NUM_MM2S_CHANNELS 16 CONFIG.C_NUM_S2MM_CHANNELS 13 CONFIG.C_S2MM_BURST_SIZE 256 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 14 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 16 " [get_bd_cells ip_5_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_5_axi_dma/axi_resetn] [get_bd_pins ip_5_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_5_axi_dma/mm2s_introut] [get_bd_pins ip_5_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_5_axi_dma/s2mm_introut] [get_bd_pins ip_5_axi_dma/axi_dma_0/s2mm_introut]


########## cordic ##########
create_bd_cell -type hier ip_6_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_6_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 12 CONFIG.Iterations 14 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 10 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode No_Pipelining CONFIG.Precision 21 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_6_cordic/cordic_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_6_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_6_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_6_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_6_cordic/cordic_0/M_AXIS_DOUT]


########## axi_timer ##########
create_bd_cell -type hier ip_7_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_7_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 32 CONFIG.GEN0_ASSERT Active_Low CONFIG.GEN1_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.TRIG1_ASSERT Active_High CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_7_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_timer/S_AXI] [get_bd_intf_pins ip_7_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_7_axi_timer/capturetrig0] [get_bd_pins ip_7_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_7_axi_timer/capturetrig1] [get_bd_pins ip_7_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/freeze
connect_bd_net [get_bd_pins ip_7_axi_timer/freeze] [get_bd_pins ip_7_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_7_axi_timer/s_axi_aclk] [get_bd_pins ip_7_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_7_axi_timer/s_axi_aresetn] [get_bd_pins ip_7_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_7_axi_timer/generateout0] [get_bd_pins ip_7_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_7_axi_timer/generateout1] [get_bd_pins ip_7_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_7_axi_timer/pwm0] [get_bd_pins ip_7_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_7_axi_timer/interrupt] [get_bd_pins ip_7_axi_timer/axi_timer_0/interrupt]


########## accumulator ##########
create_bd_cell -type hier ip_8_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_8_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 18 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 32 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_8_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/clk
connect_bd_net [get_bd_pins ip_8_accumulator/clk] [get_bd_pins ip_8_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 17 -to 0 ip_8_accumulator/B
connect_bd_net [get_bd_pins ip_8_accumulator/B] [get_bd_pins ip_8_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 31 -to 0 ip_8_accumulator/Q
connect_bd_net [get_bd_pins ip_8_accumulator/Q] [get_bd_pins ip_8_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/C_IN
connect_bd_net [get_bd_pins ip_8_accumulator/C_IN] [get_bd_pins ip_8_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/SCLR
connect_bd_net [get_bd_pins ip_8_accumulator/SCLR] [get_bd_pins ip_8_accumulator/accumulator_0/SCLR]


########## reset ##########
create_bd_cell -type hier ip_9_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_9_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_reset/clk_in
connect_bd_net [get_bd_pins ip_9_reset/clk_in] [get_bd_pins ip_9_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_reset/reset_in
connect_bd_net [get_bd_pins ip_9_reset/reset_in] [get_bd_pins ip_9_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_9_reset/dcm_locked
connect_bd_net [get_bd_pins ip_9_reset/dcm_locked] [get_bd_pins ip_9_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/mb_reset
connect_bd_net [get_bd_pins ip_9_reset/mb_reset] [get_bd_pins ip_9_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_9_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset] [get_bd_pins ip_9_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_9_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_10_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_10_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_in] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_10_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_10_clk_wiz/reset
connect_bd_net [get_bd_pins ip_10_clk_wiz/reset] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_10_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_locked] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_11_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_11_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_11_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_11_intc/concat_0]
connect_bd_net [get_bd_pins ip_11_intc/concat_0/dout] [get_bd_pins ip_11_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/clk
connect_bd_net [get_bd_pins ip_11_intc/clk] [get_bd_pins ip_11_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/reset
connect_bd_net [get_bd_pins ip_11_intc/reset] [get_bd_pins ip_11_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_intc/AXI] [get_bd_intf_pins ip_11_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_0
connect_bd_net [get_bd_pins ip_11_intc/irq_0] [get_bd_pins ip_11_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_1
connect_bd_net [get_bd_pins ip_11_intc/irq_1] [get_bd_pins ip_11_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_2
connect_bd_net [get_bd_pins ip_11_intc/irq_2] [get_bd_pins ip_11_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_3
connect_bd_net [get_bd_pins ip_11_intc/irq_3] [get_bd_pins ip_11_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_4
connect_bd_net [get_bd_pins ip_11_intc/irq_4] [get_bd_pins ip_11_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_5
connect_bd_net [get_bd_pins ip_11_intc/irq_5] [get_bd_pins ip_11_intc/concat_0/In5]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_11_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_11_intc/irq] [get_bd_intf_pins ip_11_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_12_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_12_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 7 CONFIG.NUM_SI 4 " [get_bd_cells ip_12_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_legacy/clk
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_legacy/reset
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_M0] [get_bd_intf_pins ip_12_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_M1] [get_bd_intf_pins ip_12_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_M2] [get_bd_intf_pins ip_12_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_M3] [get_bd_intf_pins ip_12_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S0] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S1] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S2] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S3] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S4] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S5] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S6] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M06_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_13_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_13_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_13_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aclk] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aresetn] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_14_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_14_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_14_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_14_axis_dwidth_converter/aclk] [get_bd_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_14_axis_dwidth_converter/aresetn] [get_bd_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_15_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_15_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_15_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_1] [get_bd_pins ip_15_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_2] [get_bd_pins ip_15_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_3] [get_bd_pins ip_15_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_4] [get_bd_pins ip_15_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_5] [get_bd_pins ip_15_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 31 -to 0 ip_15_slice_and_concat/in_6
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 32 " [get_bd_cells ip_15_slice_and_concat/slice_6]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_6] [get_bd_pins ip_15_slice_and_concat/slice_6/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/slice_6/dout] [get_bd_pins ip_15_slice_and_concat/concat/In6]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 19 -to 0 ip_16_slice_and_concat/out0
create_bd_pin -dir I -from 31 -to 0 ip_16_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 32 " [get_bd_cells ip_16_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_20_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_21_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_3_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_10_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc_EMC_INTF] [get_bd_intf_pins ip_0_emc/EMC_INTF]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_1_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_1_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_1_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_2_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite_MII] [get_bd_intf_pins ip_2_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_2_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_2_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_4_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_ethernet_lite_MII] [get_bd_intf_pins ip_4_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_4_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_4_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_11_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_5_axi_dma/M_AXIS_MM2S]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 19 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_16_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_17_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_0_emc/rst]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset] [get_bd_pins ip_1_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_0_emc/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_0_emc/rdclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_1_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_2_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_3_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_3_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_4_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_7_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_8_accumulator/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_9_reset/clk_in]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_locked] [get_bd_pins ip_9_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_11_intc/irq_0] [get_bd_pins ip_2_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_11_intc/irq_1] [get_bd_pins ip_3_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_11_intc/irq_2] [get_bd_pins ip_4_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_11_intc/irq_3] [get_bd_pins ip_5_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_11_intc/irq_4] [get_bd_pins ip_5_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_11_intc/irq_5] [get_bd_pins ip_7_axi_timer/interrupt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_cdma/M_AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_12_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_12_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_12_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_12_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_12_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_timer/S_AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_intc/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/B]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_1] [get_bd_pins ip_1_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_2] [get_bd_pins ip_1_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_3] [get_bd_pins ip_7_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_4] [get_bd_pins ip_7_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_5] [get_bd_pins ip_7_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_6] [get_bd_pins ip_8_accumulator/Q]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_8_accumulator/Q]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_7_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_7_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_7_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_12_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_13_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_11_intc/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_12_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_13_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_14_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_MM2S declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_MM2S declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/S_AXIS_S2MM declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/S_AXIS_S2MM declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_cordic/S_AXIS_PHASE declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_cordic/S_AXIS_PHASE declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }


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
