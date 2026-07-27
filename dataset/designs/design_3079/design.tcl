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



########## complex_multiplier ##########
create_bd_cell -type hier ip_0_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_0_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 11 CONFIG.aresetn 0 CONFIG.atuserwidth 29 CONFIG.bportwidth 13 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 2 CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 18 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_0_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_0_complex_multiplier/aclk] [get_bd_pins ip_0_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_0_complex_multiplier/aclken] [get_bd_pins ip_0_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_0_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## dft ##########
create_bd_cell -type hier ip_1_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_1_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 9 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_1_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CLK
connect_bd_net [get_bd_pins ip_1_dft/CLK] [get_bd_pins ip_1_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CE
connect_bd_net [get_bd_pins ip_1_dft/CE] [get_bd_pins ip_1_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/SCLR
connect_bd_net [get_bd_pins ip_1_dft/SCLR] [get_bd_pins ip_1_dft/dft_0/SCLR]
create_bd_pin -dir I -from 8 -to 0 ip_1_dft/XN_RE
connect_bd_net [get_bd_pins ip_1_dft/XN_RE] [get_bd_pins ip_1_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 8 -to 0 ip_1_dft/XN_IM
connect_bd_net [get_bd_pins ip_1_dft/XN_IM] [get_bd_pins ip_1_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FD_IN
connect_bd_net [get_bd_pins ip_1_dft/FD_IN] [get_bd_pins ip_1_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FWD_INV
connect_bd_net [get_bd_pins ip_1_dft/FWD_INV] [get_bd_pins ip_1_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_1_dft/SIZE
connect_bd_net [get_bd_pins ip_1_dft/SIZE] [get_bd_pins ip_1_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/RFFD
connect_bd_net [get_bd_pins ip_1_dft/RFFD] [get_bd_pins ip_1_dft/dft_0/RFFD]
create_bd_pin -dir O -from 8 -to 0 ip_1_dft/XK_RE
connect_bd_net [get_bd_pins ip_1_dft/XK_RE] [get_bd_pins ip_1_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 8 -to 0 ip_1_dft/XK_IM
connect_bd_net [get_bd_pins ip_1_dft/XK_IM] [get_bd_pins ip_1_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_1_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_1_dft/BLK_EXP] [get_bd_pins ip_1_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/FD_OUT
connect_bd_net [get_bd_pins ip_1_dft/FD_OUT] [get_bd_pins ip_1_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_1_dft/DATA_VALID] [get_bd_pins ip_1_dft/dft_0/DATA_VALID]


########## accumulator ##########
create_bd_cell -type hier ip_2_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_2_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 16 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 25 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_2_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/clk
connect_bd_net [get_bd_pins ip_2_accumulator/clk] [get_bd_pins ip_2_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 15 -to 0 ip_2_accumulator/B
connect_bd_net [get_bd_pins ip_2_accumulator/B] [get_bd_pins ip_2_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 24 -to 0 ip_2_accumulator/Q
connect_bd_net [get_bd_pins ip_2_accumulator/Q] [get_bd_pins ip_2_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/ADD
connect_bd_net [get_bd_pins ip_2_accumulator/ADD] [get_bd_pins ip_2_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/CE
connect_bd_net [get_bd_pins ip_2_accumulator/CE] [get_bd_pins ip_2_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/C_IN
connect_bd_net [get_bd_pins ip_2_accumulator/C_IN] [get_bd_pins ip_2_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/SCLR
connect_bd_net [get_bd_pins ip_2_accumulator/SCLR] [get_bd_pins ip_2_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/Bypass
connect_bd_net [get_bd_pins ip_2_accumulator/Bypass] [get_bd_pins ip_2_accumulator/accumulator_0/Bypass]


########## emc ##########
create_bd_cell -type hier ip_3_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_3_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 3 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 3 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 10 CONFIG.C_TAVDV_PS_MEM_0 13521 CONFIG.C_TAVDV_PS_MEM_1 15612 CONFIG.C_TAVDV_PS_MEM_2 15743 CONFIG.C_TAVDV_PS_MEM_3 14111 CONFIG.C_TCEDV_PS_MEM_0 14353 CONFIG.C_TCEDV_PS_MEM_1 14966 CONFIG.C_TCEDV_PS_MEM_2 15242 CONFIG.C_TCEDV_PS_MEM_3 14715 CONFIG.C_THZCE_PS_MEM_0 7601 CONFIG.C_THZCE_PS_MEM_1 7256 CONFIG.C_THZCE_PS_MEM_2 6390 CONFIG.C_THZCE_PS_MEM_3 7352 CONFIG.C_THZOE_PS_MEM_0 6801 CONFIG.C_THZOE_PS_MEM_1 6844 CONFIG.C_THZOE_PS_MEM_2 6787 CONFIG.C_THZOE_PS_MEM_3 7501 CONFIG.C_TLZWE_PS_MEM_0 9531 CONFIG.C_TLZWE_PS_MEM_1 3014 CONFIG.C_TLZWE_PS_MEM_2 7857 CONFIG.C_TLZWE_PS_MEM_3 1624 CONFIG.C_TWC_PS_MEM_0 15053 CONFIG.C_TWC_PS_MEM_1 14019 CONFIG.C_TWC_PS_MEM_2 15081 CONFIG.C_TWC_PS_MEM_3 14986 CONFIG.C_TWPH_PS_MEM_0 12192 CONFIG.C_TWPH_PS_MEM_1 12288 CONFIG.C_TWPH_PS_MEM_2 11070 CONFIG.C_TWPH_PS_MEM_3 11678 CONFIG.C_TWP_PS_MEM_0 11214 CONFIG.C_TWP_PS_MEM_1 11439 CONFIG.C_TWP_PS_MEM_2 11664 CONFIG.C_TWP_PS_MEM_3 11645 CONFIG.C_WR_REC_TIME_MEM_0 29149 CONFIG.C_WR_REC_TIME_MEM_1 28027 CONFIG.C_WR_REC_TIME_MEM_2 29049 CONFIG.C_WR_REC_TIME_MEM_3 29462 " [get_bd_cells ip_3_emc/emc_0]
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


########## microblaze ##########
create_bd_cell -type hier ip_4_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 36 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 1 CONFIG.C_NUMBER_OF_PC_BRK 1 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 2 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 1 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0x91 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 0 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_4_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_microblaze/Clk
connect_bd_net [get_bd_pins ip_4_microblaze/Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_4_microblaze/Reset
connect_bd_net [get_bd_pins ip_4_microblaze/Reset] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_4_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/INTERRUPT] [get_bd_intf_pins ip_4_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/M_AXI_DP] [get_bd_intf_pins ip_4_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_4_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_4_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xcab55a8e8e56c76 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_4_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_4_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_4_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x5bfc0f396027616 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_4_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_4_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_4_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_4_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 3 " [get_bd_cells ip_4_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_4_microblaze/microblaze_0/DEBUG]


########## dft ##########
create_bd_cell -type hier ip_5_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_5_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 18 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_5_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_dft/CLK
connect_bd_net [get_bd_pins ip_5_dft/CLK] [get_bd_pins ip_5_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_5_dft/CE
connect_bd_net [get_bd_pins ip_5_dft/CE] [get_bd_pins ip_5_dft/dft_0/CE]
create_bd_pin -dir I -from 17 -to 0 ip_5_dft/XN_RE
connect_bd_net [get_bd_pins ip_5_dft/XN_RE] [get_bd_pins ip_5_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 17 -to 0 ip_5_dft/XN_IM
connect_bd_net [get_bd_pins ip_5_dft/XN_IM] [get_bd_pins ip_5_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_5_dft/FD_IN
connect_bd_net [get_bd_pins ip_5_dft/FD_IN] [get_bd_pins ip_5_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_5_dft/FWD_INV
connect_bd_net [get_bd_pins ip_5_dft/FWD_INV] [get_bd_pins ip_5_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_5_dft/SIZE
connect_bd_net [get_bd_pins ip_5_dft/SIZE] [get_bd_pins ip_5_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_5_dft/RFFD
connect_bd_net [get_bd_pins ip_5_dft/RFFD] [get_bd_pins ip_5_dft/dft_0/RFFD]
create_bd_pin -dir O -from 17 -to 0 ip_5_dft/XK_RE
connect_bd_net [get_bd_pins ip_5_dft/XK_RE] [get_bd_pins ip_5_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 17 -to 0 ip_5_dft/XK_IM
connect_bd_net [get_bd_pins ip_5_dft/XK_IM] [get_bd_pins ip_5_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_5_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_5_dft/BLK_EXP] [get_bd_pins ip_5_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_5_dft/FD_OUT
connect_bd_net [get_bd_pins ip_5_dft/FD_OUT] [get_bd_pins ip_5_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_5_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_5_dft/DATA_VALID] [get_bd_pins ip_5_dft/dft_0/DATA_VALID]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_6_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_6_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_6_axi_ethernet_lite/axi_ethernetlite_0]
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
set_property -dict "CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_TEMP_BUS 0 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_7_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_7_xadc_wiz/s_axi_aclk] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_7_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_7_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_8_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_8_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 1 CONFIG.C_FIFO_DEPTH 256 CONFIG.C_NUM_TRANSFER_BITS 8 CONFIG.C_SCK_RATIO 2 CONFIG.C_SPI_MEMORY 1 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_8_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_8_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_quad_spi/IIC] [get_bd_intf_pins ip_8_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/clk] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/reset] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/clk4] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/reset4] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_8_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_8_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/irq] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_9_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_9_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 110 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Even " [get_bd_cells ip_9_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_9_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_9_uartlite/UART] [get_bd_intf_pins ip_9_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_9_uartlite/clk
connect_bd_net [get_bd_pins ip_9_uartlite/clk] [get_bd_pins ip_9_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_uartlite/reset
connect_bd_net [get_bd_pins ip_9_uartlite/reset] [get_bd_pins ip_9_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_uartlite/AXI] [get_bd_intf_pins ip_9_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_uartlite/irq
connect_bd_net [get_bd_pins ip_9_uartlite/irq] [get_bd_pins ip_9_uartlite/uart_0/interrupt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_10_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_10_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 55 CONFIG.aresetn 1 CONFIG.atuserwidth 166 CONFIG.bportwidth 46 CONFIG.btuserwidth 228 CONFIG.ctrltuserwidth 86 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 1 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Performance CONFIG.outputwidth 28 CONFIG.outtlastbehv AND_all_TLASTs CONFIG.roundmode Random_Rounding " [get_bd_cells ip_10_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_10_complex_multiplier/aclk] [get_bd_pins ip_10_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_10_complex_multiplier/aclken] [get_bd_pins ip_10_complex_multiplier/cmpy_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_10_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_10_complex_multiplier/aresetn] [get_bd_pins ip_10_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## accumulator ##########
create_bd_cell -type hier ip_11_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_11_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 239 CONFIG.Latency 26 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 257 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_11_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_accumulator/clk
connect_bd_net [get_bd_pins ip_11_accumulator/clk] [get_bd_pins ip_11_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 238 -to 0 ip_11_accumulator/B
connect_bd_net [get_bd_pins ip_11_accumulator/B] [get_bd_pins ip_11_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 256 -to 0 ip_11_accumulator/Q
connect_bd_net [get_bd_pins ip_11_accumulator/Q] [get_bd_pins ip_11_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_11_accumulator/ADD
connect_bd_net [get_bd_pins ip_11_accumulator/ADD] [get_bd_pins ip_11_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_11_accumulator/C_IN
connect_bd_net [get_bd_pins ip_11_accumulator/C_IN] [get_bd_pins ip_11_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_11_accumulator/SCLR
connect_bd_net [get_bd_pins ip_11_accumulator/SCLR] [get_bd_pins ip_11_accumulator/accumulator_0/SCLR]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_12_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_12_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 1 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_12_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_12_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_quad_spi/IIC] [get_bd_intf_pins ip_12_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_12_axi_quad_spi/STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_quad_spi/STARTUP_IO_S] [get_bd_intf_pins ip_12_axi_quad_spi/axi_quad_spi_0/STARTUP_IO_S]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_12_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_12_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_12_axi_quad_spi/clk] [get_bd_pins ip_12_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_12_axi_quad_spi/reset] [get_bd_pins ip_12_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_12_axi_quad_spi/clk4] [get_bd_pins ip_12_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_12_axi_quad_spi/reset4] [get_bd_pins ip_12_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_12_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_12_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_12_axi_quad_spi/irq] [get_bd_pins ip_12_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## conv_encoder ##########
create_bd_cell -type hier ip_13_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_13_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 6 CONFIG.convolution_code0 37 CONFIG.convolution_code1 22 CONFIG.convolution_code2 12 CONFIG.convolution_code3 54 CONFIG.convolution_code4 36 CONFIG.convolution_code5 14 CONFIG.convolution_code6 4 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 2 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_13_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_13_conv_encoder/aclk] [get_bd_pins ip_13_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_13_conv_encoder/aclken] [get_bd_pins ip_13_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_13_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_13_conv_encoder/aresetn] [get_bd_pins ip_13_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## emc ##########
create_bd_cell -type hier ip_14_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_14_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 5 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 15 CONFIG.C_TAVDV_PS_MEM_0 16303 CONFIG.C_TAVDV_PS_MEM_1 15221 CONFIG.C_TCEDV_PS_MEM_0 16493 CONFIG.C_TCEDV_PS_MEM_1 15431 CONFIG.C_THZCE_PS_MEM_0 6699 CONFIG.C_THZCE_PS_MEM_1 6319 CONFIG.C_THZOE_PS_MEM_0 7259 CONFIG.C_THZOE_PS_MEM_1 6975 CONFIG.C_TLZWE_PS_MEM_0 4048 CONFIG.C_TLZWE_PS_MEM_1 4215 CONFIG.C_TWC_PS_MEM_0 13601 CONFIG.C_TWC_PS_MEM_1 16294 CONFIG.C_TWPH_PS_MEM_0 10996 CONFIG.C_TWPH_PS_MEM_1 12903 CONFIG.C_TWP_PS_MEM_0 11489 CONFIG.C_TWP_PS_MEM_1 12871 CONFIG.C_WR_REC_TIME_MEM_0 27874 CONFIG.C_WR_REC_TIME_MEM_1 27122 " [get_bd_cells ip_14_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_14_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_14_emc/EMC_INTF] [get_bd_intf_pins ip_14_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_14_emc/clk
connect_bd_net [get_bd_pins ip_14_emc/clk] [get_bd_pins ip_14_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_emc/rdclk
connect_bd_net [get_bd_pins ip_14_emc/rdclk] [get_bd_pins ip_14_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_emc/rst
connect_bd_net [get_bd_pins ip_14_emc/rst] [get_bd_pins ip_14_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_emc/AXI] [get_bd_intf_pins ip_14_emc/emc_0/S_AXI_MEM]


########## reset ##########
create_bd_cell -type hier ip_15_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_15_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/clk_in
connect_bd_net [get_bd_pins ip_15_reset/clk_in] [get_bd_pins ip_15_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/reset_in
connect_bd_net [get_bd_pins ip_15_reset/reset_in] [get_bd_pins ip_15_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/dcm_locked
connect_bd_net [get_bd_pins ip_15_reset/dcm_locked] [get_bd_pins ip_15_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/mb_reset
connect_bd_net [get_bd_pins ip_15_reset/mb_reset] [get_bd_pins ip_15_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_15_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset] [get_bd_pins ip_15_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_15_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_16_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_16_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_in] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_16_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_16_clk_wiz/reset
connect_bd_net [get_bd_pins ip_16_clk_wiz/reset] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_16_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_locked] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_17_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_17_intc/concat_0]
connect_bd_net [get_bd_pins ip_17_intc/concat_0/dout] [get_bd_pins ip_17_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/clk
connect_bd_net [get_bd_pins ip_17_intc/clk] [get_bd_pins ip_17_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/reset
connect_bd_net [get_bd_pins ip_17_intc/reset] [get_bd_pins ip_17_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_intc/AXI] [get_bd_intf_pins ip_17_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_0
connect_bd_net [get_bd_pins ip_17_intc/irq_0] [get_bd_pins ip_17_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_1
connect_bd_net [get_bd_pins ip_17_intc/irq_1] [get_bd_pins ip_17_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_2
connect_bd_net [get_bd_pins ip_17_intc/irq_2] [get_bd_pins ip_17_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_3
connect_bd_net [get_bd_pins ip_17_intc/irq_3] [get_bd_pins ip_17_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_4
connect_bd_net [get_bd_pins ip_17_intc/irq_4] [get_bd_pins ip_17_intc/concat_0/In4]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_17_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_17_intc/irq] [get_bd_intf_pins ip_17_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_18_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_18_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 9 CONFIG.NUM_SI 1 " [get_bd_cells ip_18_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_legacy/clk
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_legacy/reset
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_M0] [get_bd_intf_pins ip_18_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S0] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S1] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S2] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S3] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S4] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S5] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S6] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S7] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S8] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M08_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_19_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_19_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_19_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_19_axis_broadcaster/aclk] [get_bd_pins ip_19_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_19_axis_broadcaster/aresetn] [get_bd_pins ip_19_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_20_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_20_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_20_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_20_axis_broadcaster/aclk] [get_bd_pins ip_20_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_20_axis_broadcaster/aresetn] [get_bd_pins ip_20_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_21_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_21_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_21_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_21_axis_broadcaster/aclk] [get_bd_pins ip_21_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_21_axis_broadcaster/aresetn] [get_bd_pins ip_21_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_22_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_22_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aclk] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aresetn] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_24_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_24_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_27_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aclk] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aresetn] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_28_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_28_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_28_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 8 -to 0 ip_28_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_28_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_1] [get_bd_pins ip_28_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/slice_1/dout] [get_bd_pins ip_28_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_29_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_29_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_29_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_29_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/slice_0/dout] [get_bd_pins ip_29_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 8 -to 0 ip_29_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_29_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_29_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/slice_1/dout] [get_bd_pins ip_29_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_30_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_30_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/slice_0/dout] [get_bd_pins ip_30_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_30_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_30_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_2] [get_bd_pins ip_30_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 238 -to 0 ip_31_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 12 " [get_bd_cells ip_31_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 24 -to 0 ip_31_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_1] [get_bd_pins ip_31_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_2] [get_bd_pins ip_31_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 17 -to 0 ip_31_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_3] [get_bd_pins ip_31_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 17 -to 0 ip_31_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_4] [get_bd_pins ip_31_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 3 -to 0 ip_31_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_5] [get_bd_pins ip_31_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_6] [get_bd_pins ip_31_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_7] [get_bd_pins ip_31_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_8] [get_bd_pins ip_31_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_9] [get_bd_pins ip_31_slice_and_concat/concat/In9]
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_10
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_10] [get_bd_pins ip_31_slice_and_concat/concat/In10]
create_bd_pin -dir I -from 256 -to 0 ip_31_slice_and_concat/in_11
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 166 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 257 " [get_bd_cells ip_31_slice_and_concat/slice_11]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_11] [get_bd_pins ip_31_slice_and_concat/slice_11/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/slice_11/dout] [get_bd_pins ip_31_slice_and_concat/concat/In11]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 256 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 184 CONFIG.DIN_TO 167 CONFIG.DIN_WIDTH 257 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 15 -to 0 ip_33_slice_and_concat/out0
create_bd_pin -dir I -from 256 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 200 CONFIG.DIN_TO 185 CONFIG.DIN_WIDTH 257 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 31 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 256 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 232 CONFIG.DIN_TO 201 CONFIG.DIN_WIDTH 257 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 256 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 250 CONFIG.DIN_TO 233 CONFIG.DIN_WIDTH 257 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 256 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 256 CONFIG.DIN_TO 251 CONFIG.DIN_WIDTH 257 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_37_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_37_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_39_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_39_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_39_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_39_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_40_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_40_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_40_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_40_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_41_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_41_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_41_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_41_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_42_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_42_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_42_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_42_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_43_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_43_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_43_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_43_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_44_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_46_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_47_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_47_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_48_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_48_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_48_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_49_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_49_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_49_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_49_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_49_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_49_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_50_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_50_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_51_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_51_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_52_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_52_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_53_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_53_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_53_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_53_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_16_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc_EMC_INTF] [get_bd_intf_pins ip_3_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite_MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_6_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_6_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_7_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_7_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_7_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_8_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_quad_spi_IIC] [get_bd_intf_pins ip_8_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_9_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_9_uartlite_UART] [get_bd_intf_pins ip_9_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_12_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_quad_spi_IIC] [get_bd_intf_pins ip_12_axi_quad_spi/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_12_axi_quad_spi_STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_quad_spi_STARTUP_IO_S] [get_bd_intf_pins ip_12_axi_quad_spi/STARTUP_IO_S]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_14_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_14_emc_EMC_INTF] [get_bd_intf_pins ip_14_emc/EMC_INTF]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_19_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_34_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 6 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_37_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_38_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_39_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_41_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_42_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_43_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_53_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset] [get_bd_pins ip_1_dft/SCLR]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_3_emc/rst]
connect_bd_net [get_bd_pins ip_15_reset/mb_reset] [get_bd_pins ip_4_microblaze/Reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_7_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_9_uartlite/reset]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_10_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_13_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_14_emc/rst]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_0_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_1_dft/CLK]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_2_accumulator/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_3_emc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_3_emc/rdclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_4_microblaze/Clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_5_dft/CLK]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_6_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_7_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_8_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_8_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_8_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_9_uartlite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_10_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_11_accumulator/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_12_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_12_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_12_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_13_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_14_emc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_14_emc/rdclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_15_reset/clk_in]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_locked] [get_bd_pins ip_15_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_17_intc/irq_0] [get_bd_pins ip_6_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_1] [get_bd_pins ip_7_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_17_intc/irq_2] [get_bd_pins ip_8_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_3] [get_bd_pins ip_9_uartlite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_4] [get_bd_pins ip_12_axi_quad_spi/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/INTERRUPT] [get_bd_intf_pins ip_17_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/M_AXI_DP] [get_bd_intf_pins ip_18_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_18_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_18_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_uartlite/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_18_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_18_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_emc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_intc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_20_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_21_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_IM]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_1_dft/RFFD]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_1] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_RE]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_5_dft/SIZE]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_1_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_2] [get_bd_pins ip_1_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_11_accumulator/B]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_1_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_1] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_2] [get_bd_pins ip_5_dft/RFFD]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_3] [get_bd_pins ip_5_dft/XK_RE]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_4] [get_bd_pins ip_5_dft/XK_IM]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_5] [get_bd_pins ip_5_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_6] [get_bd_pins ip_5_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_7] [get_bd_pins ip_5_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_8] [get_bd_pins ip_7_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_9] [get_bd_pins ip_7_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_10] [get_bd_pins ip_7_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_11] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_5_dft/XN_RE]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/B]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_5_dft/XN_IM]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_1_dft/SIZE]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_11_accumulator/ADD]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_11_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_5_dft/CE]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/ADD]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_1_dft/CE]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_0_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_5_dft/FD_IN]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/CE]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_1_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_5_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_13_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_10_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_1_dft/FD_IN]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_11_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_18_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_17_intc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_18_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_19_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_20_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_21_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }


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
