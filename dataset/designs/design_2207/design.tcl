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



########## xadc_wiz ##########
create_bd_cell -type hier ip_0_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_0_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_DCLK 1 CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 0 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_0_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/dclk_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/eoc_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/eos_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/alarm_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/busy_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_0_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_0_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_0_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/jtaglocked_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/jtagmodified_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/jtagbusy_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## axi_cdma ##########
create_bd_cell -type hier ip_1_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_1_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 39 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_1_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_1_axi_cdma/m_axi_aclk] [get_bd_pins ip_1_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_1_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_1_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_1_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_1_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_cdma/M_AXI] [get_bd_intf_pins ip_1_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_1_axi_cdma/cdma_introut] [get_bd_pins ip_1_axi_cdma/axi_cdma_0/cdma_introut]


########## dft ##########
create_bd_cell -type hier ip_2_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_2_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 18 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_2_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/CLK
connect_bd_net [get_bd_pins ip_2_dft/CLK] [get_bd_pins ip_2_dft/dft_0/CLK]
create_bd_pin -dir I -from 17 -to 0 ip_2_dft/XN_RE
connect_bd_net [get_bd_pins ip_2_dft/XN_RE] [get_bd_pins ip_2_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 17 -to 0 ip_2_dft/XN_IM
connect_bd_net [get_bd_pins ip_2_dft/XN_IM] [get_bd_pins ip_2_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/FD_IN
connect_bd_net [get_bd_pins ip_2_dft/FD_IN] [get_bd_pins ip_2_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/FWD_INV
connect_bd_net [get_bd_pins ip_2_dft/FWD_INV] [get_bd_pins ip_2_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_2_dft/SIZE
connect_bd_net [get_bd_pins ip_2_dft/SIZE] [get_bd_pins ip_2_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_2_dft/RFFD
connect_bd_net [get_bd_pins ip_2_dft/RFFD] [get_bd_pins ip_2_dft/dft_0/RFFD]
create_bd_pin -dir O -from 17 -to 0 ip_2_dft/XK_RE
connect_bd_net [get_bd_pins ip_2_dft/XK_RE] [get_bd_pins ip_2_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 17 -to 0 ip_2_dft/XK_IM
connect_bd_net [get_bd_pins ip_2_dft/XK_IM] [get_bd_pins ip_2_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_2_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_2_dft/BLK_EXP] [get_bd_pins ip_2_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_2_dft/FD_OUT
connect_bd_net [get_bd_pins ip_2_dft/FD_OUT] [get_bd_pins ip_2_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_2_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_2_dft/DATA_VALID] [get_bd_pins ip_2_dft/dft_0/DATA_VALID]


########## axi_hwicap ##########
create_bd_cell -type hier ip_3_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_3_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 1 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 256 " [get_bd_cells ip_3_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_3_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_3_axi_hwicap/icap_clk] [get_bd_pins ip_3_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_3_axi_hwicap/eos_in] [get_bd_pins ip_3_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_3_axi_hwicap/s_axi_aclk] [get_bd_pins ip_3_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_3_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_3_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_3_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_3_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_3_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_hwicap/ICAP] [get_bd_intf_pins ip_3_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_3_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_3_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## microblaze ##########
create_bd_cell -type hier ip_4_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 48 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 6 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 7 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 2 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 3 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MMU 1 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_4_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_4_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_4_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x8a0597aa9569bbb CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_4_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_4_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_4_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x8b20a6f108a951 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_4_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_4_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_4_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_4_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 1 " [get_bd_cells ip_4_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_4_microblaze/microblaze_0/DEBUG]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 2400 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Even " [get_bd_cells ip_5_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite/UART] [get_bd_intf_pins ip_5_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_5_uartlite/clk
connect_bd_net [get_bd_pins ip_5_uartlite/clk] [get_bd_pins ip_5_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_uartlite/reset
connect_bd_net [get_bd_pins ip_5_uartlite/reset] [get_bd_pins ip_5_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_5_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_5_uartlite/irq
connect_bd_net [get_bd_pins ip_5_uartlite/irq] [get_bd_pins ip_5_uartlite/uart_0/interrupt]


########## uartlite ##########
create_bd_cell -type hier ip_6_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_6_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 230400 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Odd " [get_bd_cells ip_6_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_6_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite/UART] [get_bd_intf_pins ip_6_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_6_uartlite/clk
connect_bd_net [get_bd_pins ip_6_uartlite/clk] [get_bd_pins ip_6_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_uartlite/reset
connect_bd_net [get_bd_pins ip_6_uartlite/reset] [get_bd_pins ip_6_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite/AXI] [get_bd_intf_pins ip_6_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_uartlite/irq
connect_bd_net [get_bd_pins ip_6_uartlite/irq] [get_bd_pins ip_6_uartlite/uart_0/interrupt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_7_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_7_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 57 CONFIG.aresetn 0 CONFIG.bportwidth 15 CONFIG.btuserwidth 90 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 1 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 3 CONFIG.outtlastbehv Pass_CTRL_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_7_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_7_complex_multiplier/aclk] [get_bd_pins ip_7_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_7_complex_multiplier/aclken] [get_bd_pins ip_7_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_7_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_8_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_8_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 5 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 5 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 4 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 15 CONFIG.C_TAVDV_PS_MEM_0 15752 CONFIG.C_TAVDV_PS_MEM_1 15695 CONFIG.C_TAVDV_PS_MEM_2 15771 CONFIG.C_TCEDV_PS_MEM_0 16398 CONFIG.C_TCEDV_PS_MEM_1 16331 CONFIG.C_TCEDV_PS_MEM_2 14413 CONFIG.C_THZCE_PS_MEM_0 7433 CONFIG.C_THZCE_PS_MEM_1 6712 CONFIG.C_THZCE_PS_MEM_2 6536 CONFIG.C_THZOE_PS_MEM_0 6376 CONFIG.C_THZOE_PS_MEM_1 6679 CONFIG.C_THZOE_PS_MEM_2 7387 CONFIG.C_TLZWE_PS_MEM_0 1125 CONFIG.C_TLZWE_PS_MEM_1 8873 CONFIG.C_TLZWE_PS_MEM_2 17 CONFIG.C_TWC_PS_MEM_0 13926 CONFIG.C_TWC_PS_MEM_1 14988 CONFIG.C_TWC_PS_MEM_2 15833 CONFIG.C_TWPH_PS_MEM_0 12970 CONFIG.C_TWPH_PS_MEM_1 12936 CONFIG.C_TWPH_PS_MEM_2 12817 CONFIG.C_TWP_PS_MEM_0 12326 CONFIG.C_TWP_PS_MEM_1 11980 CONFIG.C_TWP_PS_MEM_2 12940 CONFIG.C_WR_REC_TIME_MEM_0 27330 CONFIG.C_WR_REC_TIME_MEM_1 26998 CONFIG.C_WR_REC_TIME_MEM_2 26623 " [get_bd_cells ip_8_emc/emc_0]
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


########## conv_encoder ##########
create_bd_cell -type hier ip_9_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_9_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 7 CONFIG.convolution_code0 24 CONFIG.convolution_code1 17 CONFIG.convolution_code2 88 CONFIG.convolution_code3 11 CONFIG.convolution_code4 127 CONFIG.convolution_code5 64 CONFIG.convolution_code6 6 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 12 CONFIG.output_rate 13 CONFIG.puncture_code0 010011111011 CONFIG.puncture_code1 001010110010 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_9_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_9_conv_encoder/aclk] [get_bd_pins ip_9_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_9_conv_encoder/aclken] [get_bd_pins ip_9_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_9_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_9_conv_encoder/aresetn] [get_bd_pins ip_9_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_9_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_9_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_9_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_9_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## floating_point ##########
create_bd_cell -type hier ip_10_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_10_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Half CONFIG.a_tuser_width 9 CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Performance CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 1 CONFIG.maximum_latency 1 CONFIG.operation_type Square_root CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_10_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_floating_point/aclk
connect_bd_net [get_bd_pins ip_10_floating_point/aclk] [get_bd_pins ip_10_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_floating_point/aclken
connect_bd_net [get_bd_pins ip_10_floating_point/aclken] [get_bd_pins ip_10_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_10_floating_point/aresetn
connect_bd_net [get_bd_pins ip_10_floating_point/aresetn] [get_bd_pins ip_10_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_10_floating_point/S_AXIS_A] [get_bd_intf_pins ip_10_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_10_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_10_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_iic ##########
create_bd_cell -type hier ip_11_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_11_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x31 CONFIG.C_GPO_WIDTH 7 CONFIG.C_SCL_INERTIAL_DELAY 30 CONFIG.C_SDA_INERTIAL_DELAY 238 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 693.1357810080673 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_11_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_11_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_iic/IIC] [get_bd_intf_pins ip_11_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_iic/clk
connect_bd_net [get_bd_pins ip_11_axi_iic/clk] [get_bd_pins ip_11_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_iic/reset
connect_bd_net [get_bd_pins ip_11_axi_iic/reset] [get_bd_pins ip_11_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_iic/AXI] [get_bd_intf_pins ip_11_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_iic/irq
connect_bd_net [get_bd_pins ip_11_axi_iic/irq] [get_bd_pins ip_11_axi_iic/axi_iic_0/iic2intc_irpt]


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
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_14_intc/concat_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_14_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_14_intc/irq] [get_bd_intf_pins ip_14_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_15_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_15_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 7 CONFIG.NUM_SI 2 " [get_bd_cells ip_15_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi/clk
connect_bd_net [get_bd_pins ip_15_axi/clk] [get_bd_pins ip_15_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi/reset
connect_bd_net [get_bd_pins ip_15_axi/reset] [get_bd_pins ip_15_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_M0] [get_bd_intf_pins ip_15_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_M1] [get_bd_intf_pins ip_15_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S0] [get_bd_intf_pins ip_15_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S1] [get_bd_intf_pins ip_15_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S2] [get_bd_intf_pins ip_15_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S3] [get_bd_intf_pins ip_15_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S4] [get_bd_intf_pins ip_15_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S5] [get_bd_intf_pins ip_15_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_15_axi/AXI_S6] [get_bd_intf_pins ip_15_axi/axi_0/M06_AXI]


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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_17_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_17_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_17_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_17_axis_broadcaster/aclk] [get_bd_pins ip_17_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_17_axis_broadcaster/aresetn] [get_bd_pins ip_17_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_18_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_18_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_18_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_18_axis_broadcaster/aclk] [get_bd_pins ip_18_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_18_axis_broadcaster/aresetn] [get_bd_pins ip_18_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_19_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_19_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aclk] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aresetn] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_20_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_20_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aclk] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aresetn] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_21_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_21_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_22_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_22_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_22_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_22_axis_combiner/aclk] [get_bd_pins ip_22_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_22_axis_combiner/aresetn] [get_bd_pins ip_22_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/M_AXIS] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_23_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_23_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aclk] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aresetn] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_25_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_25_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_25_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_2] [get_bd_pins ip_25_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_3] [get_bd_pins ip_25_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_4] [get_bd_pins ip_25_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_5] [get_bd_pins ip_25_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_6] [get_bd_pins ip_25_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 17 -to 0 ip_25_slice_and_concat/in_7
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_25_slice_and_concat/slice_7]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_7] [get_bd_pins ip_25_slice_and_concat/slice_7/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/slice_7/dout] [get_bd_pins ip_25_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 17 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 11 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 17 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 17 -to 0 ip_28_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_29_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_29_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_29_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_29_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_2] [get_bd_pins ip_29_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_31_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_31_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_33_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_1_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_13_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_0_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_0_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_0_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_3_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_hwicap_ICAP] [get_bd_intf_pins ip_3_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_3_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_3_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_6_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite_UART] [get_bd_intf_pins ip_6_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_8_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_8_emc_EMC_INTF] [get_bd_intf_pins ip_8_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_11_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_iic_IIC] [get_bd_intf_pins ip_11_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_16_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 5 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_27_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_12_reset/mb_reset] [get_bd_pins ip_4_microblaze/Reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_6_uartlite/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_8_emc/rst]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_9_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_10_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_iic/reset]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_0_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_1_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_1_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_2_dft/CLK]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_4_microblaze/Clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_6_uartlite/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_7_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_8_emc/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_8_emc/rdclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_9_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_10_floating_point/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_axi_iic/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_12_reset/clk_in]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_locked] [get_bd_pins ip_12_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_14_intc/irq_0] [get_bd_pins ip_1_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_1] [get_bd_pins ip_3_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_14_intc/irq_2] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_3] [get_bd_pins ip_6_uartlite/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_4] [get_bd_pins ip_11_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/INTERRUPT] [get_bd_intf_pins ip_14_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_cdma/M_AXI] [get_bd_intf_pins ip_15_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/M_AXI_DP] [get_bd_intf_pins ip_15_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_15_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_15_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_uartlite/AXI] [get_bd_intf_pins ip_15_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_emc/AXI] [get_bd_intf_pins ip_15_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_iic/AXI] [get_bd_intf_pins ip_15_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_intc/AXI] [get_bd_intf_pins ip_15_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_17_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_18_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_7_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_floating_point/S_AXIS_A] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_2_dft/XN_RE]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_0_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_2] [get_bd_pins ip_0_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_3] [get_bd_pins ip_0_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_4] [get_bd_pins ip_0_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_5] [get_bd_pins ip_0_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_6] [get_bd_pins ip_2_dft/RFFD]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_7] [get_bd_pins ip_2_dft/XK_RE]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_3_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_2_dft/XK_RE]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_2_dft/XK_RE]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_2_dft/XN_IM]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_2_dft/XK_IM]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_2_dft/SIZE]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_2_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_2_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_2] [get_bd_pins ip_2_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_9_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_10_floating_point/aclken]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_7_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_2_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_2_dft/FD_IN]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_15_axi/reset]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_14_intc/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_15_axi/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_16_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_17_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_18_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_22_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_A declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_A declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/M_AXIS_DOUT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/M_AXIS_DOUT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_broadcaster/M_AXIS_2 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }


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
