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



########## axi_dma ##########
create_bd_cell -type hier ip_0_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_0_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 52 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_0_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_0_axi_dma/axi_resetn] [get_bd_pins ip_0_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_0_axi_dma/mm2s_introut] [get_bd_pins ip_0_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_0_axi_dma/s2mm_introut] [get_bd_pins ip_0_axi_dma/axi_dma_0/s2mm_introut]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_1_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_1_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_1_axi_ethernet_lite/axi_ethernetlite_0]
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


########## axi_cdma ##########
create_bd_cell -type hier ip_2_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_2_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 57 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 128 CONFIG.C_M_AXI_MAX_BURST_LEN 2 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_2_axi_cdma/axi_cdma_0]
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


########## uartlite ##########
create_bd_cell -type hier ip_3_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_3_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 2400 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Odd " [get_bd_cells ip_3_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/UART] [get_bd_intf_pins ip_3_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/clk
connect_bd_net [get_bd_pins ip_3_uartlite/clk] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/reset
connect_bd_net [get_bd_pins ip_3_uartlite/reset] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_3_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_uartlite/irq
connect_bd_net [get_bd_pins ip_3_uartlite/irq] [get_bd_pins ip_3_uartlite/uart_0/interrupt]


########## axi_dma ##########
create_bd_cell -type hier ip_4_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_4_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 44 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 32 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_4_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_4_axi_dma/axi_resetn] [get_bd_pins ip_4_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_4_axi_dma/mm2s_introut] [get_bd_pins ip_4_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_4_axi_dma/s2mm_introut] [get_bd_pins ip_4_axi_dma/axi_dma_0/s2mm_introut]


########## microblaze ##########
create_bd_cell -type hier ip_5_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 32 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 1 CONFIG.C_NUMBER_OF_PC_BRK 4 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 2 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 0 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0xa4 CONFIG.C_PVR_USER2 0x26423532 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_5_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_microblaze/Clk
connect_bd_net [get_bd_pins ip_5_microblaze/Clk] [get_bd_pins ip_5_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_5_microblaze/Reset
connect_bd_net [get_bd_pins ip_5_microblaze/Reset] [get_bd_pins ip_5_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_5_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/INTERRUPT] [get_bd_intf_pins ip_5_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/M_AXI_DP] [get_bd_intf_pins ip_5_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_5_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_5_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_5_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_5_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x1fa8f52b6361b3 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_5_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_5_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_5_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_5_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_5_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_5_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_5_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_5_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x1b0ca5a719f0d31 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_5_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_5_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_5_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_5_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_5_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_5_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_5_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 2 " [get_bd_cells ip_5_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_5_microblaze/microblaze_0/DEBUG]


########## gpio ##########
create_bd_cell -type hier ip_6_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_6_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x3ffffff CONFIG.C_GPIO_WIDTH 26 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_6_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/GPIO] [get_bd_intf_pins ip_6_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/clk
connect_bd_net [get_bd_pins ip_6_gpio/clk] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/rst
connect_bd_net [get_bd_pins ip_6_gpio/rst] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_6_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_gpio/irq
connect_bd_net [get_bd_pins ip_6_gpio/irq] [get_bd_pins ip_6_gpio/gpio_0/ip2intc_irpt]


########## axi_timer ##########
create_bd_cell -type hier ip_7_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_7_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_7_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_timer/S_AXI] [get_bd_intf_pins ip_7_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_7_axi_timer/capturetrig0] [get_bd_pins ip_7_axi_timer/axi_timer_0/capturetrig0]
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


########## emc ##########
create_bd_cell -type hier ip_8_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_8_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 3 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 5 CONFIG.C_TAVDV_PS_MEM_0 14365 CONFIG.C_TAVDV_PS_MEM_1 15518 CONFIG.C_TCEDV_PS_MEM_0 15058 CONFIG.C_TCEDV_PS_MEM_1 13550 CONFIG.C_THZCE_PS_MEM_0 6794 CONFIG.C_THZCE_PS_MEM_1 6893 CONFIG.C_THZOE_PS_MEM_0 6688 CONFIG.C_THZOE_PS_MEM_1 7271 CONFIG.C_TLZWE_PS_MEM_0 4203 CONFIG.C_TLZWE_PS_MEM_1 5686 CONFIG.C_TWC_PS_MEM_0 14498 CONFIG.C_TWC_PS_MEM_1 14302 CONFIG.C_TWPH_PS_MEM_0 10985 CONFIG.C_TWPH_PS_MEM_1 11701 CONFIG.C_TWP_PS_MEM_0 12925 CONFIG.C_TWP_PS_MEM_1 12962 CONFIG.C_WR_REC_TIME_MEM_0 25242 CONFIG.C_WR_REC_TIME_MEM_1 28899 " [get_bd_cells ip_8_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_8_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_8_emc/EMC_INTF] [get_bd_intf_pins ip_8_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_8_emc/clk
connect_bd_net [get_bd_pins ip_8_emc/clk] [get_bd_pins ip_8_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_emc/rdclk
connect_bd_net [get_bd_pins ip_8_emc/rdclk] [get_bd_pins ip_8_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_emc/rst
connect_bd_net [get_bd_pins ip_8_emc/rst] [get_bd_pins ip_8_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_emc/AXI] [get_bd_intf_pins ip_8_emc/emc_0/S_AXI_MEM]


########## axi_dma ##########
create_bd_cell -type hier ip_9_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_9_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 50 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_9_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_9_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_9_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_9_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_9_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_9_axi_dma/axi_resetn] [get_bd_pins ip_9_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_9_axi_dma/mm2s_introut] [get_bd_pins ip_9_axi_dma/axi_dma_0/mm2s_introut]


########## fft ##########
create_bd_cell -type hier ip_10_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_10_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 6 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 1024 " [get_bd_cells ip_10_fft/fft_0]
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


########## emc ##########
create_bd_cell -type hier ip_11_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_11_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 2 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 9 CONFIG.C_TAVDV_PS_MEM_0 13947 CONFIG.C_TAVDV_PS_MEM_1 13753 CONFIG.C_TAVDV_PS_MEM_2 13613 CONFIG.C_TCEDV_PS_MEM_0 13508 CONFIG.C_TCEDV_PS_MEM_1 15456 CONFIG.C_TCEDV_PS_MEM_2 15150 CONFIG.C_THZCE_PS_MEM_0 6979 CONFIG.C_THZCE_PS_MEM_1 6488 CONFIG.C_THZCE_PS_MEM_2 7550 CONFIG.C_THZOE_PS_MEM_0 7513 CONFIG.C_THZOE_PS_MEM_1 7596 CONFIG.C_THZOE_PS_MEM_2 6981 CONFIG.C_TLZWE_PS_MEM_0 2992 CONFIG.C_TLZWE_PS_MEM_1 9479 CONFIG.C_TLZWE_PS_MEM_2 6216 CONFIG.C_TWC_PS_MEM_0 14853 CONFIG.C_TWC_PS_MEM_1 14095 CONFIG.C_TWC_PS_MEM_2 14457 CONFIG.C_TWPH_PS_MEM_0 13049 CONFIG.C_TWPH_PS_MEM_1 13077 CONFIG.C_TWPH_PS_MEM_2 11784 CONFIG.C_TWP_PS_MEM_0 12495 CONFIG.C_TWP_PS_MEM_1 11817 CONFIG.C_TWP_PS_MEM_2 12665 CONFIG.C_WR_REC_TIME_MEM_0 27920 CONFIG.C_WR_REC_TIME_MEM_1 29168 CONFIG.C_WR_REC_TIME_MEM_2 28708 " [get_bd_cells ip_11_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_11_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_11_emc/EMC_INTF] [get_bd_intf_pins ip_11_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_11_emc/clk
connect_bd_net [get_bd_pins ip_11_emc/clk] [get_bd_pins ip_11_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_emc/rdclk
connect_bd_net [get_bd_pins ip_11_emc/rdclk] [get_bd_pins ip_11_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_emc/rst
connect_bd_net [get_bd_pins ip_11_emc/rst] [get_bd_pins ip_11_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_emc/AXI] [get_bd_intf_pins ip_11_emc/emc_0/S_AXI_MEM]


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


########## axi_legacy ##########
create_bd_cell -type hier ip_15_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_15_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 11 CONFIG.NUM_SI 7 " [get_bd_cells ip_15_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_legacy/clk
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_legacy/reset
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M0] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M1] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M2] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M3] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M4] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S04_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S04_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S04_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M5] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S05_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S05_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S05_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M6
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M6] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S06_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S06_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S0] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S1] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S2] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S3] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S4] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S5] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S6] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S7] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S8] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S9] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S10] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M10_ARESETN]


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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_17_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_17_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_17_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_17_axis_dwidth_converter/aclk] [get_bd_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_17_axis_dwidth_converter/aresetn] [get_bd_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_18_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_18_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 24 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_18_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 24 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aclk] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aresetn] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 2 -to 0 ip_20_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_20_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_20_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_20_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_21_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_21_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_21_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_21_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_22_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_22_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_22_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_13_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_1_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite_MII] [get_bd_intf_pins ip_1_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_1_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_1_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite_UART] [get_bd_intf_pins ip_3_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio_GPIO] [get_bd_intf_pins ip_6_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_8_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_8_emc_EMC_INTF] [get_bd_intf_pins ip_8_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_11_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_11_emc_EMC_INTF] [get_bd_intf_pins ip_11_emc/EMC_INTF]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 2 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_20_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_3_uartlite/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_12_reset/mb_reset] [get_bd_pins ip_5_microblaze/Reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_6_gpio/rst]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_8_emc/rst]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_11_emc/rst]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_1_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_uartlite/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_5_microblaze/Clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_6_gpio/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_7_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_8_emc/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_8_emc/rdclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_9_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_9_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_10_fft/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_emc/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_emc/rdclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_12_reset/clk_in]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_locked] [get_bd_pins ip_12_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_14_intc/irq_0] [get_bd_pins ip_0_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_1] [get_bd_pins ip_0_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_2] [get_bd_pins ip_1_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_3] [get_bd_pins ip_2_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_4] [get_bd_pins ip_3_uartlite/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_5] [get_bd_pins ip_4_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_6] [get_bd_pins ip_4_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_7] [get_bd_pins ip_6_gpio/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_8] [get_bd_pins ip_7_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_14_intc/irq_9] [get_bd_pins ip_9_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_10] [get_bd_pins ip_10_fft/event_frame_started]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_microblaze/INTERRUPT] [get_bd_intf_pins ip_14_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_15_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_15_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/M_AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_15_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_15_axi_legacy/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_microblaze/M_AXI_DP] [get_bd_intf_pins ip_15_axi_legacy/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_15_axi_legacy/AXI_M6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_timer/S_AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_emc/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_emc/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_intc/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_16_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_9_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_DATA] [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_7_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_7_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_7_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_7_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_7_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_15_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_14_intc/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_15_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_16_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_17_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_18_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=16 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }


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
