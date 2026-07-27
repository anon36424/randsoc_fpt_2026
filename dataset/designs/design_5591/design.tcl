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
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 13 CONFIG.C_TAVDV_PS_MEM_0 13697 CONFIG.C_TCEDV_PS_MEM_0 15328 CONFIG.C_THZCE_PS_MEM_0 6821 CONFIG.C_THZOE_PS_MEM_0 6731 CONFIG.C_TLZWE_PS_MEM_0 2105 CONFIG.C_TWC_PS_MEM_0 13651 CONFIG.C_TWPH_PS_MEM_0 11295 CONFIG.C_TWP_PS_MEM_0 12033 CONFIG.C_WR_REC_TIME_MEM_0 27284 " [get_bd_cells ip_0_emc/emc_0]
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


########## microblaze ##########
create_bd_cell -type hier ip_1_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 40 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_COUNTER_WIDTH 48 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 39 CONFIG.C_DEBUG_EXTERNAL_TRACE 0 CONFIG.C_DEBUG_LATENCY_COUNTERS 1 CONFIG.C_DEBUG_PROFILE_SIZE 65536 CONFIG.C_DEBUG_TRACE_SIZE 131072 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_NUMBER_OF_PC_BRK 2 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 1 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 2 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0x26 CONFIG.C_PVR_USER2 0x8577affc CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_1_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_microblaze/Clk
connect_bd_net [get_bd_pins ip_1_microblaze/Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_1_microblaze/Reset
connect_bd_net [get_bd_pins ip_1_microblaze/Reset] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_1_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/INTERRUPT] [get_bd_intf_pins ip_1_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/M_AXI_DP] [get_bd_intf_pins ip_1_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_1_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_1_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xf3b36373e492173 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_1_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_1_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_1_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_1_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x70221d16bb25e64 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_1_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_1_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_1_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_1_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_1_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 2 " [get_bd_cells ip_1_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_1_microblaze/microblaze_0/DEBUG]


########## accumulator ##########
create_bd_cell -type hier ip_2_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_2_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 0 CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 18 CONFIG.Latency 12 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 254 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_2_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/clk
connect_bd_net [get_bd_pins ip_2_accumulator/clk] [get_bd_pins ip_2_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 17 -to 0 ip_2_accumulator/B
connect_bd_net [get_bd_pins ip_2_accumulator/B] [get_bd_pins ip_2_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 253 -to 0 ip_2_accumulator/Q
connect_bd_net [get_bd_pins ip_2_accumulator/Q] [get_bd_pins ip_2_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/ADD
connect_bd_net [get_bd_pins ip_2_accumulator/ADD] [get_bd_pins ip_2_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/CE
connect_bd_net [get_bd_pins ip_2_accumulator/CE] [get_bd_pins ip_2_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/C_IN
connect_bd_net [get_bd_pins ip_2_accumulator/C_IN] [get_bd_pins ip_2_accumulator/accumulator_0/C_IN]


########## emc ##########
create_bd_cell -type hier ip_3_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_3_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 10 CONFIG.C_TAVDV_PS_MEM_0 14432 CONFIG.C_TAVDV_PS_MEM_1 14048 CONFIG.C_TCEDV_PS_MEM_0 14613 CONFIG.C_TCEDV_PS_MEM_1 14614 CONFIG.C_THZCE_PS_MEM_0 7068 CONFIG.C_THZCE_PS_MEM_1 6791 CONFIG.C_THZOE_PS_MEM_0 7595 CONFIG.C_THZOE_PS_MEM_1 7176 CONFIG.C_TLZWE_PS_MEM_0 3865 CONFIG.C_TLZWE_PS_MEM_1 3803 CONFIG.C_TWC_PS_MEM_0 15230 CONFIG.C_TWC_PS_MEM_1 14584 CONFIG.C_TWPH_PS_MEM_0 11564 CONFIG.C_TWPH_PS_MEM_1 12143 CONFIG.C_TWP_PS_MEM_0 12689 CONFIG.C_TWP_PS_MEM_1 12532 CONFIG.C_WR_REC_TIME_MEM_0 26004 CONFIG.C_WR_REC_TIME_MEM_1 29304 " [get_bd_cells ip_3_emc/emc_0]
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


########## axi_hwicap ##########
create_bd_cell -type hier ip_4_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_4_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_WRITE_FIFO_DEPTH 512 " [get_bd_cells ip_4_axi_hwicap/axi_hwicap_0]
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


########## emc ##########
create_bd_cell -type hier ip_5_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_5_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 0 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_SYNCH_PIPEDELAY_0 1 CONFIG.C_SYNCH_PIPEDELAY_1 1 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 8 CONFIG.C_TAVDV_PS_MEM_2 15204 CONFIG.C_TCEDV_PS_MEM_2 16076 CONFIG.C_THZCE_PS_MEM_2 7483 CONFIG.C_THZOE_PS_MEM_2 7439 CONFIG.C_TLZWE_PS_MEM_2 3850 CONFIG.C_TWC_PS_MEM_2 14020 CONFIG.C_TWPH_PS_MEM_2 10879 CONFIG.C_TWP_PS_MEM_2 11102 CONFIG.C_WR_REC_TIME_MEM_2 28576 " [get_bd_cells ip_5_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_5_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_5_emc/EMC_INTF] [get_bd_intf_pins ip_5_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/clk
connect_bd_net [get_bd_pins ip_5_emc/clk] [get_bd_pins ip_5_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/rdclk
connect_bd_net [get_bd_pins ip_5_emc/rdclk] [get_bd_pins ip_5_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/rst
connect_bd_net [get_bd_pins ip_5_emc/rst] [get_bd_pins ip_5_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_emc/AXI] [get_bd_intf_pins ip_5_emc/emc_0/S_AXI_MEM]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_6_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_6_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_6_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_6_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/clk] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/reset] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/irq] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## xadc_wiz ##########
create_bd_cell -type hier ip_7_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_7_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_DCLK 0 CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 0 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_7_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_7_xadc_wiz/reset_in] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/eoc_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/eos_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/busy_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_7_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_7_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_7_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## reset ##########
create_bd_cell -type hier ip_8_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_8_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_reset/clk_in
connect_bd_net [get_bd_pins ip_8_reset/clk_in] [get_bd_pins ip_8_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_8_reset/reset_in
connect_bd_net [get_bd_pins ip_8_reset/reset_in] [get_bd_pins ip_8_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_8_reset/dcm_locked
connect_bd_net [get_bd_pins ip_8_reset/dcm_locked] [get_bd_pins ip_8_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_8_reset/mb_reset
connect_bd_net [get_bd_pins ip_8_reset/mb_reset] [get_bd_pins ip_8_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_8_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_8_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_8_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset] [get_bd_pins ip_8_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_8_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_8_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_9_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_9_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_in] [get_bd_pins ip_9_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_9_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_9_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_9_clk_wiz/reset
connect_bd_net [get_bd_pins ip_9_clk_wiz/reset] [get_bd_pins ip_9_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_9_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_locked] [get_bd_pins ip_9_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_10_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_10_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_10_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_10_intc/concat_0]
connect_bd_net [get_bd_pins ip_10_intc/concat_0/dout] [get_bd_pins ip_10_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/clk
connect_bd_net [get_bd_pins ip_10_intc/clk] [get_bd_pins ip_10_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/reset
connect_bd_net [get_bd_pins ip_10_intc/reset] [get_bd_pins ip_10_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_intc/AXI] [get_bd_intf_pins ip_10_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/irq_0
connect_bd_net [get_bd_pins ip_10_intc/irq_0] [get_bd_pins ip_10_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/irq_1
connect_bd_net [get_bd_pins ip_10_intc/irq_1] [get_bd_pins ip_10_intc/concat_0/In1]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_10_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_10_intc/irq] [get_bd_intf_pins ip_10_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_11_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_11_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 6 CONFIG.NUM_SI 1 " [get_bd_cells ip_11_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi/clk
connect_bd_net [get_bd_pins ip_11_axi/clk] [get_bd_pins ip_11_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi/reset
connect_bd_net [get_bd_pins ip_11_axi/reset] [get_bd_pins ip_11_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_M0] [get_bd_intf_pins ip_11_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S0] [get_bd_intf_pins ip_11_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S1] [get_bd_intf_pins ip_11_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S2] [get_bd_intf_pins ip_11_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S3] [get_bd_intf_pins ip_11_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S4] [get_bd_intf_pins ip_11_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S5] [get_bd_intf_pins ip_11_axi/axi_0/M05_AXI]


########## reduce ##########
create_bd_cell -type hier ip_12_reduce
create_bd_pin -dir I -from 237 -to 0 ip_12_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_12_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_12_reduce/concat]
connect_bd_net [get_bd_pins ip_12_reduce/out0] [get_bd_pins ip_12_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_0]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_12_reduce/slice_0/dout] [get_bd_pins ip_12_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_0/Res] [get_bd_pins ip_12_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_1]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_12_reduce/slice_1/dout] [get_bd_pins ip_12_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_1/Res] [get_bd_pins ip_12_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_2]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_12_reduce/slice_2/dout] [get_bd_pins ip_12_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_2/Res] [get_bd_pins ip_12_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_3]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_12_reduce/slice_3/dout] [get_bd_pins ip_12_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_3/Res] [get_bd_pins ip_12_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 39 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_4]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_12_reduce/slice_4/dout] [get_bd_pins ip_12_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_4/Res] [get_bd_pins ip_12_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 40 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_5]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_12_reduce/slice_5/dout] [get_bd_pins ip_12_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_5/Res] [get_bd_pins ip_12_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 55 CONFIG.DIN_TO 48 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_6]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_12_reduce/slice_6/dout] [get_bd_pins ip_12_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_6/Res] [get_bd_pins ip_12_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 63 CONFIG.DIN_TO 56 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_7]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_12_reduce/slice_7/dout] [get_bd_pins ip_12_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_7/Res] [get_bd_pins ip_12_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 71 CONFIG.DIN_TO 64 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_8]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_12_reduce/slice_8/dout] [get_bd_pins ip_12_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_8/Res] [get_bd_pins ip_12_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 79 CONFIG.DIN_TO 72 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_9]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_12_reduce/slice_9/dout] [get_bd_pins ip_12_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_9/Res] [get_bd_pins ip_12_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 87 CONFIG.DIN_TO 80 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_10]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_12_reduce/slice_10/dout] [get_bd_pins ip_12_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_10/Res] [get_bd_pins ip_12_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 95 CONFIG.DIN_TO 88 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_11]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_12_reduce/slice_11/dout] [get_bd_pins ip_12_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_11/Res] [get_bd_pins ip_12_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 103 CONFIG.DIN_TO 96 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_12]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_12_reduce/slice_12/dout] [get_bd_pins ip_12_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_12/Res] [get_bd_pins ip_12_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 111 CONFIG.DIN_TO 104 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_13]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_12_reduce/slice_13/dout] [get_bd_pins ip_12_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_13/Res] [get_bd_pins ip_12_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 118 CONFIG.DIN_TO 112 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_14]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_12_reduce/slice_14/dout] [get_bd_pins ip_12_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_14/Res] [get_bd_pins ip_12_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 125 CONFIG.DIN_TO 119 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_15]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_12_reduce/slice_15/dout] [get_bd_pins ip_12_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_15/Res] [get_bd_pins ip_12_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 132 CONFIG.DIN_TO 126 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_16]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_12_reduce/slice_16/dout] [get_bd_pins ip_12_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_16/Res] [get_bd_pins ip_12_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 139 CONFIG.DIN_TO 133 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_17]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_12_reduce/slice_17/dout] [get_bd_pins ip_12_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_17/Res] [get_bd_pins ip_12_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 146 CONFIG.DIN_TO 140 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_18]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_12_reduce/slice_18/dout] [get_bd_pins ip_12_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_18/Res] [get_bd_pins ip_12_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 153 CONFIG.DIN_TO 147 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_19]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_12_reduce/slice_19/dout] [get_bd_pins ip_12_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_19/Res] [get_bd_pins ip_12_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 160 CONFIG.DIN_TO 154 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_20]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_12_reduce/slice_20/dout] [get_bd_pins ip_12_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_20/Res] [get_bd_pins ip_12_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 167 CONFIG.DIN_TO 161 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_21]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_12_reduce/slice_21/dout] [get_bd_pins ip_12_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_21/Res] [get_bd_pins ip_12_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 174 CONFIG.DIN_TO 168 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_22]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_12_reduce/slice_22/dout] [get_bd_pins ip_12_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_22/Res] [get_bd_pins ip_12_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 181 CONFIG.DIN_TO 175 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_23]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_12_reduce/slice_23/dout] [get_bd_pins ip_12_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_23/Res] [get_bd_pins ip_12_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 188 CONFIG.DIN_TO 182 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_24]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_12_reduce/slice_24/dout] [get_bd_pins ip_12_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_24/Res] [get_bd_pins ip_12_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 195 CONFIG.DIN_TO 189 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_25]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_12_reduce/slice_25/dout] [get_bd_pins ip_12_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_25/Res] [get_bd_pins ip_12_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 202 CONFIG.DIN_TO 196 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_26]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_12_reduce/slice_26/dout] [get_bd_pins ip_12_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_26/Res] [get_bd_pins ip_12_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 209 CONFIG.DIN_TO 203 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_27]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_12_reduce/slice_27/dout] [get_bd_pins ip_12_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_27/Res] [get_bd_pins ip_12_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 216 CONFIG.DIN_TO 210 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_28]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_12_reduce/slice_28/dout] [get_bd_pins ip_12_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_28/Res] [get_bd_pins ip_12_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 223 CONFIG.DIN_TO 217 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_29]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_12_reduce/slice_29/dout] [get_bd_pins ip_12_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_29/Res] [get_bd_pins ip_12_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 230 CONFIG.DIN_TO 224 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_30]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_12_reduce/slice_30/dout] [get_bd_pins ip_12_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_30/Res] [get_bd_pins ip_12_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 237 CONFIG.DIN_TO 231 CONFIG.DIN_WIDTH 238 " [get_bd_cells ip_12_reduce/slice_31]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_12_reduce/slice_31/dout] [get_bd_pins ip_12_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_31/Res] [get_bd_pins ip_12_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_13_slice_and_concat
create_bd_pin -dir O -from 237 -to 0 ip_13_slice_and_concat/out0
create_bd_pin -dir I -from 253 -to 0 ip_13_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 237 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 254 " [get_bd_cells ip_13_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_13_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_13_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_14_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_14_slice_and_concat/out0
create_bd_pin -dir I -from 253 -to 0 ip_14_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 238 CONFIG.DIN_TO 238 CONFIG.DIN_WIDTH 254 " [get_bd_cells ip_14_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_14_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_14_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_15_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_15_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 253 -to 0 ip_15_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 253 CONFIG.DIN_TO 239 CONFIG.DIN_WIDTH 254 " [get_bd_cells ip_15_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_15_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/slice_0/dout] [get_bd_pins ip_15_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_1] [get_bd_pins ip_15_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_2] [get_bd_pins ip_15_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_15_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_3] [get_bd_pins ip_15_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_16_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_9_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc_EMC_INTF] [get_bd_intf_pins ip_0_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc_EMC_INTF] [get_bd_intf_pins ip_3_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_5_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_5_emc_EMC_INTF] [get_bd_intf_pins ip_5_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite_MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_6_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_6_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_7_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_7_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_7_xadc_wiz/Vp_Vn]

########## Interrupts ##########

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_12_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_16_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_0_emc/rst]
connect_bd_net [get_bd_pins ip_8_reset/mb_reset] [get_bd_pins ip_1_microblaze/Reset]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_3_emc/rst]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_5_emc/rst]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset] [get_bd_pins ip_7_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_0_emc/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_0_emc/rdclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_1_microblaze/Clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_2_accumulator/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_3_emc/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_3_emc/rdclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_5_emc/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_5_emc/rdclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_6_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_8_reset/clk_in]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_locked] [get_bd_pins ip_8_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_10_intc/irq_0] [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_10_intc/irq_1] [get_bd_pins ip_6_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_microblaze/INTERRUPT] [get_bd_intf_pins ip_10_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_microblaze/M_AXI_DP] [get_bd_intf_pins ip_11_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_11_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_11_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_11_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_emc/AXI] [get_bd_intf_pins ip_11_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_11_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_intc/AXI] [get_bd_intf_pins ip_11_axi/AXI_S5]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_12_reduce/in0]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_4_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/B]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_1] [get_bd_pins ip_7_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_2] [get_bd_pins ip_7_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_3] [get_bd_pins ip_7_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/ADD]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/CE]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_11_axi/reset]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_10_intc/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_11_axi/clk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).


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
