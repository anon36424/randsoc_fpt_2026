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



########## dft ##########
create_bd_cell -type hier ip_0_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_0_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 14 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_0_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/CLK
connect_bd_net [get_bd_pins ip_0_dft/CLK] [get_bd_pins ip_0_dft/dft_0/CLK]
create_bd_pin -dir I -from 13 -to 0 ip_0_dft/XN_RE
connect_bd_net [get_bd_pins ip_0_dft/XN_RE] [get_bd_pins ip_0_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 13 -to 0 ip_0_dft/XN_IM
connect_bd_net [get_bd_pins ip_0_dft/XN_IM] [get_bd_pins ip_0_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/FD_IN
connect_bd_net [get_bd_pins ip_0_dft/FD_IN] [get_bd_pins ip_0_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/FWD_INV
connect_bd_net [get_bd_pins ip_0_dft/FWD_INV] [get_bd_pins ip_0_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_0_dft/SIZE
connect_bd_net [get_bd_pins ip_0_dft/SIZE] [get_bd_pins ip_0_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_0_dft/RFFD
connect_bd_net [get_bd_pins ip_0_dft/RFFD] [get_bd_pins ip_0_dft/dft_0/RFFD]
create_bd_pin -dir O -from 13 -to 0 ip_0_dft/XK_RE
connect_bd_net [get_bd_pins ip_0_dft/XK_RE] [get_bd_pins ip_0_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 13 -to 0 ip_0_dft/XK_IM
connect_bd_net [get_bd_pins ip_0_dft/XK_IM] [get_bd_pins ip_0_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_0_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_0_dft/BLK_EXP] [get_bd_pins ip_0_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_0_dft/FD_OUT
connect_bd_net [get_bd_pins ip_0_dft/FD_OUT] [get_bd_pins ip_0_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_0_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_0_dft/DATA_VALID] [get_bd_pins ip_0_dft/dft_0/DATA_VALID]


########## axi_timer ##########
create_bd_cell -type hier ip_1_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_1_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 8 CONFIG.GEN0_ASSERT Active_High CONFIG.GEN1_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.TRIG1_ASSERT Active_High CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_1_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_timer/S_AXI] [get_bd_intf_pins ip_1_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_1_axi_timer/capturetrig0] [get_bd_pins ip_1_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_1_axi_timer/capturetrig1] [get_bd_pins ip_1_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_timer/freeze
connect_bd_net [get_bd_pins ip_1_axi_timer/freeze] [get_bd_pins ip_1_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_1_axi_timer/s_axi_aclk] [get_bd_pins ip_1_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_1_axi_timer/s_axi_aresetn] [get_bd_pins ip_1_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_1_axi_timer/generateout0] [get_bd_pins ip_1_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_1_axi_timer/generateout1] [get_bd_pins ip_1_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_1_axi_timer/pwm0] [get_bd_pins ip_1_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_1_axi_timer/interrupt] [get_bd_pins ip_1_axi_timer/axi_timer_0/interrupt]


########## axi_dma ##########
create_bd_cell -type hier ip_2_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_2_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 46 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_2_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_2_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_2_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_2_axi_dma/axi_resetn] [get_bd_pins ip_2_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_2_axi_dma/mm2s_introut] [get_bd_pins ip_2_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_2_axi_dma/s2mm_introut] [get_bd_pins ip_2_axi_dma/axi_dma_0/s2mm_introut]


########## emc ##########
create_bd_cell -type hier ip_3_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_3_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 5 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 32 CONFIG.C_MEM3_TYPE 1 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 11 CONFIG.C_TAVDV_PS_MEM_0 13742 CONFIG.C_TAVDV_PS_MEM_1 15367 CONFIG.C_TAVDV_PS_MEM_2 15718 CONFIG.C_TAVDV_PS_MEM_3 14881 CONFIG.C_TCEDV_PS_MEM_0 14844 CONFIG.C_TCEDV_PS_MEM_1 14055 CONFIG.C_TCEDV_PS_MEM_2 13973 CONFIG.C_TCEDV_PS_MEM_3 14607 CONFIG.C_THZCE_PS_MEM_0 7527 CONFIG.C_THZCE_PS_MEM_1 7677 CONFIG.C_THZCE_PS_MEM_2 6703 CONFIG.C_THZCE_PS_MEM_3 6901 CONFIG.C_THZOE_PS_MEM_0 6553 CONFIG.C_THZOE_PS_MEM_1 6356 CONFIG.C_THZOE_PS_MEM_2 6988 CONFIG.C_THZOE_PS_MEM_3 7626 CONFIG.C_TLZWE_PS_MEM_0 8548 CONFIG.C_TLZWE_PS_MEM_1 6327 CONFIG.C_TLZWE_PS_MEM_2 3051 CONFIG.C_TLZWE_PS_MEM_3 5328 CONFIG.C_TWC_PS_MEM_0 15400 CONFIG.C_TWC_PS_MEM_1 15130 CONFIG.C_TWC_PS_MEM_2 15667 CONFIG.C_TWC_PS_MEM_3 13508 CONFIG.C_TWPH_PS_MEM_0 12360 CONFIG.C_TWPH_PS_MEM_1 11769 CONFIG.C_TWPH_PS_MEM_2 11769 CONFIG.C_TWPH_PS_MEM_3 10949 CONFIG.C_TWP_PS_MEM_0 13143 CONFIG.C_TWP_PS_MEM_1 13190 CONFIG.C_TWP_PS_MEM_2 12985 CONFIG.C_TWP_PS_MEM_3 11448 CONFIG.C_WR_REC_TIME_MEM_0 24603 CONFIG.C_WR_REC_TIME_MEM_1 26798 CONFIG.C_WR_REC_TIME_MEM_2 26696 CONFIG.C_WR_REC_TIME_MEM_3 28551 " [get_bd_cells ip_3_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc/EMC_INTF] [get_bd_intf_pins ip_3_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/clk
connect_bd_net [get_bd_pins ip_3_emc/clk] [get_bd_pins ip_3_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/rdclk
connect_bd_net [get_bd_pins ip_3_emc/rdclk] [get_bd_pins ip_3_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/rst
connect_bd_net [get_bd_pins ip_3_emc/rst] [get_bd_pins ip_3_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_3_emc/emc_0/S_AXI_MEM]


########## axi_dma ##########
create_bd_cell -type hier ip_4_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_4_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 64 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_4_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_4_axi_dma/axi_resetn] [get_bd_pins ip_4_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_4_axi_dma/mm2s_introut] [get_bd_pins ip_4_axi_dma/axi_dma_0/mm2s_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_5_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_5_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 59 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_5_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_5_axi_dma/axi_resetn] [get_bd_pins ip_5_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_5_axi_dma/s2mm_introut] [get_bd_pins ip_5_axi_dma/axi_dma_0/s2mm_introut]


########## emc ##########
create_bd_cell -type hier ip_6_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_6_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 9 CONFIG.C_TAVDV_PS_MEM_0 16146 CONFIG.C_TCEDV_PS_MEM_0 15112 CONFIG.C_THZCE_PS_MEM_0 7486 CONFIG.C_THZOE_PS_MEM_0 7010 CONFIG.C_TLZWE_PS_MEM_0 5973 CONFIG.C_TWC_PS_MEM_0 14317 CONFIG.C_TWPH_PS_MEM_0 13173 CONFIG.C_TWP_PS_MEM_0 11113 CONFIG.C_WR_REC_TIME_MEM_0 25251 " [get_bd_cells ip_6_emc/emc_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_7_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_7_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x10 CONFIG.C_GPO_WIDTH 4 CONFIG.C_SCL_INERTIAL_DELAY 133 CONFIG.C_SDA_INERTIAL_DELAY 37 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 78.97612189074916 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_7_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic/IIC] [get_bd_intf_pins ip_7_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_iic/clk
connect_bd_net [get_bd_pins ip_7_axi_iic/clk] [get_bd_pins ip_7_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_iic/reset
connect_bd_net [get_bd_pins ip_7_axi_iic/reset] [get_bd_pins ip_7_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_7_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_iic/irq
connect_bd_net [get_bd_pins ip_7_axi_iic/irq] [get_bd_pins ip_7_axi_iic/axi_iic_0/iic2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_8_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_8_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 9600 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Odd " [get_bd_cells ip_8_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_8_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_8_uartlite/UART] [get_bd_intf_pins ip_8_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_8_uartlite/clk
connect_bd_net [get_bd_pins ip_8_uartlite/clk] [get_bd_pins ip_8_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_uartlite/reset
connect_bd_net [get_bd_pins ip_8_uartlite/reset] [get_bd_pins ip_8_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_uartlite/AXI] [get_bd_intf_pins ip_8_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_uartlite/irq
connect_bd_net [get_bd_pins ip_8_uartlite/irq] [get_bd_pins ip_8_uartlite/uart_0/interrupt]


########## gpio ##########
create_bd_cell -type hier ip_9_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_9_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 21 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_9_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/GPIO] [get_bd_intf_pins ip_9_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/clk
connect_bd_net [get_bd_pins ip_9_gpio/clk] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/rst
connect_bd_net [get_bd_pins ip_9_gpio/rst] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_9_gpio/gpio_0/S_AXI]


########## axi_hwicap ##########
create_bd_cell -type hier ip_10_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_10_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_10_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_10_axi_hwicap/icap_clk] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_10_axi_hwicap/eos_in] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_10_axi_hwicap/s_axi_aclk] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_10_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_10_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_10_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## axi_cdma ##########
create_bd_cell -type hier ip_11_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_11_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 54 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_11_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_11_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_11_axi_cdma/m_axi_aclk] [get_bd_pins ip_11_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_11_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_11_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_11_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_11_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_cdma/M_AXI] [get_bd_intf_pins ip_11_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_11_axi_cdma/cdma_introut] [get_bd_pins ip_11_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_12_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_12_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 63 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 1 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 256 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 16 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 256 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 16 " [get_bd_cells ip_12_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_12_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_12_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_12_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_12_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_12_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_12_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_12_axi_dma/axi_resetn] [get_bd_pins ip_12_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_dma/M_AXI] [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_12_axi_dma/mm2s_introut] [get_bd_pins ip_12_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_12_axi_dma/s2mm_introut] [get_bd_pins ip_12_axi_dma/axi_dma_0/s2mm_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_13_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_13_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 45 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_13_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_13_axi_dma/axi_resetn] [get_bd_pins ip_13_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_13_axi_dma/s2mm_introut] [get_bd_pins ip_13_axi_dma/axi_dma_0/s2mm_introut]


########## xadc_wiz ##########
create_bd_cell -type hier ip_14_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_14_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_14_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_14_xadc_wiz/dclk_in] [get_bd_pins ip_14_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_14_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_14_xadc_wiz/reset_in] [get_bd_pins ip_14_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir O -from 0 -to 0 ip_14_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_14_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_14_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_14_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_14_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_14_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_14_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_14_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_14_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_14_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_14_xadc_wiz/eoc_out] [get_bd_pins ip_14_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_14_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_14_xadc_wiz/eos_out] [get_bd_pins ip_14_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_14_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_14_xadc_wiz/alarm_out] [get_bd_pins ip_14_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_14_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_14_xadc_wiz/busy_out] [get_bd_pins ip_14_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_14_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_14_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_14_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## uartlite ##########
create_bd_cell -type hier ip_15_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_15_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 230400 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Even " [get_bd_cells ip_15_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_15_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_15_uartlite/UART] [get_bd_intf_pins ip_15_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_15_uartlite/clk
connect_bd_net [get_bd_pins ip_15_uartlite/clk] [get_bd_pins ip_15_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_uartlite/reset
connect_bd_net [get_bd_pins ip_15_uartlite/reset] [get_bd_pins ip_15_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_uartlite/AXI] [get_bd_intf_pins ip_15_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_15_uartlite/irq
connect_bd_net [get_bd_pins ip_15_uartlite/irq] [get_bd_pins ip_15_uartlite/uart_0/interrupt]


########## gpio ##########
create_bd_cell -type hier ip_16_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_16_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x38ef CONFIG.C_GPIO2_WIDTH 4 CONFIG.C_GPIO_WIDTH 14 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_16_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_16_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio/GPIO] [get_bd_intf_pins ip_16_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_16_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio/GPIO2] [get_bd_intf_pins ip_16_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_16_gpio/clk
connect_bd_net [get_bd_pins ip_16_gpio/clk] [get_bd_pins ip_16_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_gpio/rst
connect_bd_net [get_bd_pins ip_16_gpio/rst] [get_bd_pins ip_16_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio/AXI] [get_bd_intf_pins ip_16_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_gpio/irq
connect_bd_net [get_bd_pins ip_16_gpio/irq] [get_bd_pins ip_16_gpio/gpio_0/ip2intc_irpt]


########## axi_timer ##########
create_bd_cell -type hier ip_17_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_17_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_17_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_timer/S_AXI] [get_bd_intf_pins ip_17_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_17_axi_timer/capturetrig0] [get_bd_pins ip_17_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_timer/freeze
connect_bd_net [get_bd_pins ip_17_axi_timer/freeze] [get_bd_pins ip_17_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_17_axi_timer/s_axi_aclk] [get_bd_pins ip_17_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_17_axi_timer/s_axi_aresetn] [get_bd_pins ip_17_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_17_axi_timer/generateout0] [get_bd_pins ip_17_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_17_axi_timer/generateout1] [get_bd_pins ip_17_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_17_axi_timer/pwm0] [get_bd_pins ip_17_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_17_axi_timer/interrupt] [get_bd_pins ip_17_axi_timer/axi_timer_0/interrupt]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_18_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_18_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 1 CONFIG.C_FIFO_DEPTH 16 CONFIG.C_NUM_TRANSFER_BITS 32 CONFIG.C_SCK_RATIO 8 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_18_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_18_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_quad_spi/IIC] [get_bd_intf_pins ip_18_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_18_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_18_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_18_axi_quad_spi/clk] [get_bd_pins ip_18_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_18_axi_quad_spi/reset] [get_bd_pins ip_18_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_18_axi_quad_spi/clk4] [get_bd_pins ip_18_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_18_axi_quad_spi/reset4] [get_bd_pins ip_18_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_18_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_18_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_18_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_18_axi_quad_spi/irq] [get_bd_pins ip_18_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## floating_point ##########
create_bd_cell -type hier ip_19_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_19_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.a_tuser_width 28 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage Medium_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Exponential CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_19_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_floating_point/aclk
connect_bd_net [get_bd_pins ip_19_floating_point/aclk] [get_bd_pins ip_19_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_floating_point/aclken
connect_bd_net [get_bd_pins ip_19_floating_point/aclken] [get_bd_pins ip_19_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_19_floating_point/aresetn
connect_bd_net [get_bd_pins ip_19_floating_point/aresetn] [get_bd_pins ip_19_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_19_floating_point/S_AXIS_A] [get_bd_intf_pins ip_19_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_19_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_19_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_timer ##########
create_bd_cell -type hier ip_20_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_20_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.mode_64bit 1 " [get_bd_cells ip_20_axi_timer/axi_timer_0]
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


########## accumulator ##########
create_bd_cell -type hier ip_21_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_21_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 159 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 159 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_21_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/clk
connect_bd_net [get_bd_pins ip_21_accumulator/clk] [get_bd_pins ip_21_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 158 -to 0 ip_21_accumulator/B
connect_bd_net [get_bd_pins ip_21_accumulator/B] [get_bd_pins ip_21_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 158 -to 0 ip_21_accumulator/Q
connect_bd_net [get_bd_pins ip_21_accumulator/Q] [get_bd_pins ip_21_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/CE
connect_bd_net [get_bd_pins ip_21_accumulator/CE] [get_bd_pins ip_21_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/SCLR
connect_bd_net [get_bd_pins ip_21_accumulator/SCLR] [get_bd_pins ip_21_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/Bypass
connect_bd_net [get_bd_pins ip_21_accumulator/Bypass] [get_bd_pins ip_21_accumulator/accumulator_0/Bypass]


########## axi_timer ##########
create_bd_cell -type hier ip_22_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_22_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.mode_64bit 1 " [get_bd_cells ip_22_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_timer/S_AXI] [get_bd_intf_pins ip_22_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_22_axi_timer/capturetrig0] [get_bd_pins ip_22_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_timer/freeze
connect_bd_net [get_bd_pins ip_22_axi_timer/freeze] [get_bd_pins ip_22_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_22_axi_timer/s_axi_aclk] [get_bd_pins ip_22_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_22_axi_timer/s_axi_aresetn] [get_bd_pins ip_22_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_22_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_22_axi_timer/generateout0] [get_bd_pins ip_22_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_22_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_22_axi_timer/generateout1] [get_bd_pins ip_22_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_22_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_22_axi_timer/pwm0] [get_bd_pins ip_22_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_22_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_22_axi_timer/interrupt] [get_bd_pins ip_22_axi_timer/axi_timer_0/interrupt]


########## axi_timer ##########
create_bd_cell -type hier ip_23_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_23_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_23_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_timer/S_AXI] [get_bd_intf_pins ip_23_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_23_axi_timer/capturetrig0] [get_bd_pins ip_23_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_timer/freeze
connect_bd_net [get_bd_pins ip_23_axi_timer/freeze] [get_bd_pins ip_23_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_23_axi_timer/s_axi_aclk] [get_bd_pins ip_23_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_23_axi_timer/s_axi_aresetn] [get_bd_pins ip_23_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_23_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_23_axi_timer/generateout0] [get_bd_pins ip_23_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_23_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_23_axi_timer/generateout1] [get_bd_pins ip_23_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_23_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_23_axi_timer/pwm0] [get_bd_pins ip_23_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_23_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_23_axi_timer/interrupt] [get_bd_pins ip_23_axi_timer/axi_timer_0/interrupt]


########## accumulator ##########
create_bd_cell -type hier ip_24_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_24_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 33 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 45 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_24_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_accumulator/clk
connect_bd_net [get_bd_pins ip_24_accumulator/clk] [get_bd_pins ip_24_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 32 -to 0 ip_24_accumulator/B
connect_bd_net [get_bd_pins ip_24_accumulator/B] [get_bd_pins ip_24_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 44 -to 0 ip_24_accumulator/Q
connect_bd_net [get_bd_pins ip_24_accumulator/Q] [get_bd_pins ip_24_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_24_accumulator/ADD
connect_bd_net [get_bd_pins ip_24_accumulator/ADD] [get_bd_pins ip_24_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_24_accumulator/C_IN
connect_bd_net [get_bd_pins ip_24_accumulator/C_IN] [get_bd_pins ip_24_accumulator/accumulator_0/C_IN]


########## complex_multiplier ##########
create_bd_cell -type hier ip_25_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_25_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 53 CONFIG.aresetn 0 CONFIG.bportwidth 49 CONFIG.btuserwidth 14 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 1 CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 9 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_25_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_25_complex_multiplier/aclk] [get_bd_pins ip_25_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_25_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_25_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_25_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## floating_point ##########
create_bd_cell -type hier ip_26_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_26_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.a_tuser_width 37 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 0 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Square_root CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_26_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_floating_point/aclk
connect_bd_net [get_bd_pins ip_26_floating_point/aclk] [get_bd_pins ip_26_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_floating_point/aresetn
connect_bd_net [get_bd_pins ip_26_floating_point/aresetn] [get_bd_pins ip_26_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_26_floating_point/S_AXIS_A] [get_bd_intf_pins ip_26_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_26_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_26_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_cdma ##########
create_bd_cell -type hier ip_27_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_27_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 46 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_27_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_27_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_27_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_27_axi_cdma/m_axi_aclk] [get_bd_pins ip_27_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_27_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_27_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_27_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_27_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_27_axi_cdma/M_AXI] [get_bd_intf_pins ip_27_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_27_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_27_axi_cdma/cdma_introut] [get_bd_pins ip_27_axi_cdma/axi_cdma_0/cdma_introut]


########## reset ##########
create_bd_cell -type hier ip_28_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_28_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_reset/clk_in
connect_bd_net [get_bd_pins ip_28_reset/clk_in] [get_bd_pins ip_28_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_28_reset/reset_in
connect_bd_net [get_bd_pins ip_28_reset/reset_in] [get_bd_pins ip_28_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_28_reset/dcm_locked
connect_bd_net [get_bd_pins ip_28_reset/dcm_locked] [get_bd_pins ip_28_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_28_reset/mb_reset
connect_bd_net [get_bd_pins ip_28_reset/mb_reset] [get_bd_pins ip_28_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_28_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_28_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_28_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset] [get_bd_pins ip_28_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_28_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_28_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_29_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_29_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_in] [get_bd_pins ip_29_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_29_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_29_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_29_clk_wiz/reset
connect_bd_net [get_bd_pins ip_29_clk_wiz/reset] [get_bd_pins ip_29_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_29_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_locked] [get_bd_pins ip_29_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_30_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_30_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_30_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 20 " [get_bd_cells ip_30_intc/concat_0]
connect_bd_net [get_bd_pins ip_30_intc/concat_0/dout] [get_bd_pins ip_30_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/clk
connect_bd_net [get_bd_pins ip_30_intc/clk] [get_bd_pins ip_30_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/reset
connect_bd_net [get_bd_pins ip_30_intc/reset] [get_bd_pins ip_30_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_30_intc/AXI] [get_bd_intf_pins ip_30_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_0
connect_bd_net [get_bd_pins ip_30_intc/irq_0] [get_bd_pins ip_30_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_1
connect_bd_net [get_bd_pins ip_30_intc/irq_1] [get_bd_pins ip_30_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_2
connect_bd_net [get_bd_pins ip_30_intc/irq_2] [get_bd_pins ip_30_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_3
connect_bd_net [get_bd_pins ip_30_intc/irq_3] [get_bd_pins ip_30_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_4
connect_bd_net [get_bd_pins ip_30_intc/irq_4] [get_bd_pins ip_30_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_5
connect_bd_net [get_bd_pins ip_30_intc/irq_5] [get_bd_pins ip_30_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_6
connect_bd_net [get_bd_pins ip_30_intc/irq_6] [get_bd_pins ip_30_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_7
connect_bd_net [get_bd_pins ip_30_intc/irq_7] [get_bd_pins ip_30_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_8
connect_bd_net [get_bd_pins ip_30_intc/irq_8] [get_bd_pins ip_30_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_9
connect_bd_net [get_bd_pins ip_30_intc/irq_9] [get_bd_pins ip_30_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_10
connect_bd_net [get_bd_pins ip_30_intc/irq_10] [get_bd_pins ip_30_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_11
connect_bd_net [get_bd_pins ip_30_intc/irq_11] [get_bd_pins ip_30_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_12
connect_bd_net [get_bd_pins ip_30_intc/irq_12] [get_bd_pins ip_30_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_13
connect_bd_net [get_bd_pins ip_30_intc/irq_13] [get_bd_pins ip_30_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_14
connect_bd_net [get_bd_pins ip_30_intc/irq_14] [get_bd_pins ip_30_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_15
connect_bd_net [get_bd_pins ip_30_intc/irq_15] [get_bd_pins ip_30_intc/concat_0/In15]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_16
connect_bd_net [get_bd_pins ip_30_intc/irq_16] [get_bd_pins ip_30_intc/concat_0/In16]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_17
connect_bd_net [get_bd_pins ip_30_intc/irq_17] [get_bd_pins ip_30_intc/concat_0/In17]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_18
connect_bd_net [get_bd_pins ip_30_intc/irq_18] [get_bd_pins ip_30_intc/concat_0/In18]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_19
connect_bd_net [get_bd_pins ip_30_intc/irq_19] [get_bd_pins ip_30_intc/concat_0/In19]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_30_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_30_intc/irq] [get_bd_intf_pins ip_30_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_31_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_31_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 11 " [get_bd_cells ip_31_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi/clk
connect_bd_net [get_bd_pins ip_31_axi/clk] [get_bd_pins ip_31_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi/reset
connect_bd_net [get_bd_pins ip_31_axi/reset] [get_bd_pins ip_31_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M0] [get_bd_intf_pins ip_31_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M1] [get_bd_intf_pins ip_31_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M2] [get_bd_intf_pins ip_31_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M3] [get_bd_intf_pins ip_31_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M4] [get_bd_intf_pins ip_31_axi/axi_0/S04_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M5] [get_bd_intf_pins ip_31_axi/axi_0/S05_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M6
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M6] [get_bd_intf_pins ip_31_axi/axi_0/S06_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M7
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M7] [get_bd_intf_pins ip_31_axi/axi_0/S07_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M8
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M8] [get_bd_intf_pins ip_31_axi/axi_0/S08_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M9
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M9] [get_bd_intf_pins ip_31_axi/axi_0/S09_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M10
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M10] [get_bd_intf_pins ip_31_axi/axi_0/S10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S0] [get_bd_intf_pins ip_31_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S1] [get_bd_intf_pins ip_31_axi/axi_0/M01_AXI]


########## axi ##########
create_bd_cell -type hier ip_32_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_32_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_32_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axi/clk
connect_bd_net [get_bd_pins ip_32_axi/clk] [get_bd_pins ip_32_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axi/reset
connect_bd_net [get_bd_pins ip_32_axi/reset] [get_bd_pins ip_32_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M0] [get_bd_intf_pins ip_32_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S0] [get_bd_intf_pins ip_32_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S1] [get_bd_intf_pins ip_32_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S2] [get_bd_intf_pins ip_32_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S3] [get_bd_intf_pins ip_32_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S4] [get_bd_intf_pins ip_32_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S5] [get_bd_intf_pins ip_32_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S6] [get_bd_intf_pins ip_32_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S7] [get_bd_intf_pins ip_32_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S8] [get_bd_intf_pins ip_32_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S9] [get_bd_intf_pins ip_32_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S10] [get_bd_intf_pins ip_32_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S11] [get_bd_intf_pins ip_32_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S12] [get_bd_intf_pins ip_32_axi/axi_0/M12_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S13] [get_bd_intf_pins ip_32_axi/axi_0/M13_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S14] [get_bd_intf_pins ip_32_axi/axi_0/M14_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S15] [get_bd_intf_pins ip_32_axi/axi_0/M15_AXI]


########## axi ##########
create_bd_cell -type hier ip_33_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_33_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 7 CONFIG.NUM_SI 1 " [get_bd_cells ip_33_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axi/clk
connect_bd_net [get_bd_pins ip_33_axi/clk] [get_bd_pins ip_33_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axi/reset
connect_bd_net [get_bd_pins ip_33_axi/reset] [get_bd_pins ip_33_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_33_axi/AXI_M0] [get_bd_intf_pins ip_33_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_33_axi/AXI_S0] [get_bd_intf_pins ip_33_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_33_axi/AXI_S1] [get_bd_intf_pins ip_33_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_33_axi/AXI_S2] [get_bd_intf_pins ip_33_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_33_axi/AXI_S3] [get_bd_intf_pins ip_33_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_33_axi/AXI_S4] [get_bd_intf_pins ip_33_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_33_axi/AXI_S5] [get_bd_intf_pins ip_33_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_33_axi/AXI_S6] [get_bd_intf_pins ip_33_axi/axi_0/M06_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_34_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_34_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_34_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_34_axis_broadcaster/aclk] [get_bd_pins ip_34_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_34_axis_broadcaster/aresetn] [get_bd_pins ip_34_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_35_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_35_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_35_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_35_axis_broadcaster/aclk] [get_bd_pins ip_35_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_35_axis_broadcaster/aresetn] [get_bd_pins ip_35_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_36_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_36_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_36_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_36_axis_broadcaster/aclk] [get_bd_pins ip_36_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_36_axis_broadcaster/aresetn] [get_bd_pins ip_36_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_37_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_37_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_37_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_37_axis_broadcaster/aclk] [get_bd_pins ip_37_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_37_axis_broadcaster/aresetn] [get_bd_pins ip_37_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_38_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_38_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_38_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_38_axis_dwidth_converter/aclk] [get_bd_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_38_axis_dwidth_converter/aresetn] [get_bd_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_39_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_39_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aclk] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aresetn] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_40_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_40_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_40_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_40_axis_dwidth_converter/aclk] [get_bd_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_40_axis_dwidth_converter/aresetn] [get_bd_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_41_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_41_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aclk] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aresetn] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_42_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_42_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aclk] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aresetn] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_43_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_43_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_43_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_43_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_43_axis_dwidth_converter/aclk] [get_bd_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_43_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_43_axis_dwidth_converter/aresetn] [get_bd_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_43_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_43_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_44_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_44_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_44_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_44_axis_combiner/aclk] [get_bd_pins ip_44_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_44_axis_combiner/aresetn] [get_bd_pins ip_44_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_combiner/M_AXIS] [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_45_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_45_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_45_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aclk] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aresetn] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_46_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_46_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 4 " [get_bd_cells ip_46_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_46_axis_combiner/aclk] [get_bd_pins ip_46_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_46_axis_combiner/aresetn] [get_bd_pins ip_46_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_combiner/S_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/S03_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_combiner/M_AXIS] [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_47_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_47_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_47_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aclk] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aresetn] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_48_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_48_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_48_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_48_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_48_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_48_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_48_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_48_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_48_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_1] [get_bd_pins ip_48_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/slice_1/dout] [get_bd_pins ip_48_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_49_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_49_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_49_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_49_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_49_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_49_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 13 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_49_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_49_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/slice_0/dout] [get_bd_pins ip_49_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_49_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_49_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_49_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_1] [get_bd_pins ip_49_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/slice_1/dout] [get_bd_pins ip_49_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_50_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_50_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_50_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_50_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_50_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/slice_0/dout] [get_bd_pins ip_50_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_50_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_1] [get_bd_pins ip_50_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_50_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_2] [get_bd_pins ip_50_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_51_slice_and_concat
create_bd_pin -dir O -from 32 -to 0 ip_51_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_51_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 14 " [get_bd_cells ip_51_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_51_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_1] [get_bd_pins ip_51_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_2] [get_bd_pins ip_51_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_3] [get_bd_pins ip_51_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_4] [get_bd_pins ip_51_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_5] [get_bd_pins ip_51_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_6] [get_bd_pins ip_51_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_7] [get_bd_pins ip_51_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_8] [get_bd_pins ip_51_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_9] [get_bd_pins ip_51_slice_and_concat/concat/In9]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_10
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_10] [get_bd_pins ip_51_slice_and_concat/concat/In10]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_11
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_11] [get_bd_pins ip_51_slice_and_concat/concat/In11]
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_12
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_12] [get_bd_pins ip_51_slice_and_concat/concat/In12]
create_bd_pin -dir I -from 158 -to 0 ip_51_slice_and_concat/in_13
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_51_slice_and_concat] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 159 " [get_bd_cells ip_51_slice_and_concat/slice_13]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_13] [get_bd_pins ip_51_slice_and_concat/slice_13/din]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/slice_13/dout] [get_bd_pins ip_51_slice_and_concat/concat/In13]


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_52_slice_and_concat/out0
create_bd_pin -dir I -from 158 -to 0 ip_52_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_52_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 20 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 159 " [get_bd_cells ip_52_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_52_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 29 -to 0 ip_53_slice_and_concat/out0
create_bd_pin -dir I -from 158 -to 0 ip_53_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 50 CONFIG.DIN_TO 21 CONFIG.DIN_WIDTH 159 " [get_bd_cells ip_53_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_53_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 158 -to 0 ip_54_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_54_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 158 -to 0 ip_54_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 158 CONFIG.DIN_TO 51 CONFIG.DIN_WIDTH 159 " [get_bd_cells ip_54_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_54_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/slice_0/dout] [get_bd_pins ip_54_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_1] [get_bd_pins ip_54_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_2] [get_bd_pins ip_54_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_3] [get_bd_pins ip_54_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_4] [get_bd_pins ip_54_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_5] [get_bd_pins ip_54_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_6] [get_bd_pins ip_54_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 44 -to 0 ip_54_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_7] [get_bd_pins ip_54_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_55_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_55_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_55_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_55_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_56_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_56_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_56_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_56_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_57_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_57_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_57_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_57_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_58_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_58_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_59_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_59_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_59_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_60_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_60_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_60_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_61_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_61_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_61_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_62_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_62_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_62_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_63_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_63_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_63_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_64_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_64_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_64_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_65_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_65_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_66_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_66_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_66_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_67_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_67_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_67_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_67_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_67_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_68_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_68_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_68_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_69_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_69_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_69_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_69_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_69_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_69_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_70_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_70_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_70_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_71_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_71_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_71_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_72_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_72_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_72_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_73_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_73_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_73_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_27_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_28_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_29_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc_EMC_INTF] [get_bd_intf_pins ip_3_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_6_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_6_emc_EMC_INTF] [get_bd_intf_pins ip_6_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic_IIC] [get_bd_intf_pins ip_7_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_8_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_8_uartlite_UART] [get_bd_intf_pins ip_8_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO] [get_bd_intf_pins ip_9_gpio/GPIO]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_14_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_14_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_14_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_15_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_15_uartlite_UART] [get_bd_intf_pins ip_15_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_16_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio_GPIO] [get_bd_intf_pins ip_16_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_16_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio_GPIO2] [get_bd_intf_pins ip_16_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_18_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_quad_spi_IIC] [get_bd_intf_pins ip_18_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_30_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 29 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_53_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 3 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_55_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_56_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_57_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_58_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_67_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_69_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_29_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_30_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_3_emc/rst]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_6_emc/rst]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_iic/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_8_uartlite/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_9_gpio/rst]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset] [get_bd_pins ip_14_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_15_uartlite/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_16_gpio/rst]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_18_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_18_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_19_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_20_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_22_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_23_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_26_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_0_dft/CLK]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_1_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_2_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_3_emc/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_3_emc/rdclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_6_emc/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_6_emc/rdclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_7_axi_iic/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_8_uartlite/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_9_gpio/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_10_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_10_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_11_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_11_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_12_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_12_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_12_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_14_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_15_uartlite/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_16_gpio/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_17_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_18_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_18_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_18_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_19_floating_point/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_20_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_21_accumulator/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_22_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_23_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_24_accumulator/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_25_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_26_floating_point/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_27_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_27_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_28_reset/clk_in]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_locked] [get_bd_pins ip_28_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_30_intc/irq_0] [get_bd_pins ip_1_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_30_intc/irq_1] [get_bd_pins ip_2_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_2] [get_bd_pins ip_2_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_3] [get_bd_pins ip_4_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_4] [get_bd_pins ip_5_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_5] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_6] [get_bd_pins ip_8_uartlite/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_7] [get_bd_pins ip_10_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_30_intc/irq_8] [get_bd_pins ip_11_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_9] [get_bd_pins ip_12_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_10] [get_bd_pins ip_12_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_11] [get_bd_pins ip_13_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_12] [get_bd_pins ip_15_uartlite/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_13] [get_bd_pins ip_16_gpio/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_14] [get_bd_pins ip_17_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_30_intc/irq_15] [get_bd_pins ip_18_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_16] [get_bd_pins ip_20_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_30_intc/irq_17] [get_bd_pins ip_22_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_30_intc/irq_18] [get_bd_pins ip_23_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_30_intc/irq_19] [get_bd_pins ip_27_axi_cdma/cdma_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_31_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_31_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_31_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_31_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_31_axi/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_31_axi/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_cdma/M_AXI] [get_bd_intf_pins ip_31_axi/AXI_M6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_dma/M_AXI] [get_bd_intf_pins ip_31_axi/AXI_M7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_31_axi/AXI_M8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_31_axi/AXI_M9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axi_cdma/M_AXI] [get_bd_intf_pins ip_31_axi/AXI_M10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axi/AXI_S0] [get_bd_intf_pins ip_32_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_timer/S_AXI] [get_bd_intf_pins ip_32_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_32_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_emc/AXI] [get_bd_intf_pins ip_32_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_32_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_uartlite/AXI] [get_bd_intf_pins ip_32_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_32_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_uartlite/AXI] [get_bd_intf_pins ip_32_axi/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_gpio/AXI] [get_bd_intf_pins ip_32_axi/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_timer/S_AXI] [get_bd_intf_pins ip_32_axi/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axi/AXI_S1] [get_bd_intf_pins ip_33_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_33_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_33_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_timer/S_AXI] [get_bd_intf_pins ip_33_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axi_timer/S_AXI] [get_bd_intf_pins ip_33_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axi_timer/S_AXI] [get_bd_intf_pins ip_33_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_33_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_intc/AXI] [get_bd_intf_pins ip_33_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_floating_point/S_AXIS_A] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_floating_point/S_AXIS_A] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_44_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_46_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_0_dft/XN_IM]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_0_dft/RFFD]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_1] [get_bd_pins ip_0_dft/XK_RE]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_0_dft/SIZE]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_0_dft/XK_RE]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_1] [get_bd_pins ip_0_dft/XK_IM]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_0_dft/XN_RE]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_0_dft/XK_IM]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_1] [get_bd_pins ip_0_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_2] [get_bd_pins ip_0_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_24_accumulator/B]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_0_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_1] [get_bd_pins ip_1_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_2] [get_bd_pins ip_1_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_3] [get_bd_pins ip_1_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_4] [get_bd_pins ip_14_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_5] [get_bd_pins ip_14_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_6] [get_bd_pins ip_14_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_7] [get_bd_pins ip_17_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_8] [get_bd_pins ip_17_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_9] [get_bd_pins ip_17_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_10] [get_bd_pins ip_20_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_11] [get_bd_pins ip_20_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_12] [get_bd_pins ip_20_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_13] [get_bd_pins ip_21_accumulator/Q]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_10_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_21_accumulator/Q]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_21_accumulator/Q]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/B]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_21_accumulator/Q]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_1] [get_bd_pins ip_22_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_2] [get_bd_pins ip_22_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_3] [get_bd_pins ip_22_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_4] [get_bd_pins ip_23_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_5] [get_bd_pins ip_23_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_6] [get_bd_pins ip_23_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_7] [get_bd_pins ip_24_accumulator/Q]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_1_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_1_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_0_dft/FD_IN]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_20_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_59_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_17_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_60_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_23_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_61_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_1_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_62_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/CE]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_63_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_24_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_64_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_23_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_65_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_22_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_24_accumulator/ADD]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_17_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_20_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_70_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_22_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_71_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_19_floating_point/aclken]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_72_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_0_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/in_0] [get_bd_pins ip_14_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_73_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_31_axi/reset]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_32_axi/reset]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_33_axi/reset]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_30_intc/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_31_axi/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_32_axi/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_33_axi/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_34_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_35_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_36_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_37_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_38_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_44_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_45_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_46_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_47_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axi_dma/M_AXIS_MM2S declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axi_dma/M_AXIS_MM2S declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axi_dma/S_AXIS_S2MM declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axi_dma/S_AXIS_S2MM declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/S_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/S_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/S03_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/S_AXIS_3 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/S_AXIS_3 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }


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
