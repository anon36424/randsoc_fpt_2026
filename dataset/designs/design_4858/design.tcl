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



########## microblaze ##########
create_bd_cell -type hier ip_0_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 36 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 2 CONFIG.C_DEBUG_COUNTER_WIDTH 32 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 39 CONFIG.C_DEBUG_EXTERNAL_TRACE 0 CONFIG.C_DEBUG_LATENCY_COUNTERS 6 CONFIG.C_DEBUG_PROFILE_SIZE 8192 CONFIG.C_DEBUG_TRACE_SIZE 16384 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 4 CONFIG.C_MMU_ITLB_SIZE 8 CONFIG.C_MMU_PRIVILEGED_INSTR 1 CONFIG.C_MMU_TLB_ACCESS 2 CONFIG.C_MMU_ZONES 11 CONFIG.C_NUMBER_OF_PC_BRK 8 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 1 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 0 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0x81 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 0 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MMU 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_0_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_microblaze/Clk
connect_bd_net [get_bd_pins ip_0_microblaze/Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_0_microblaze/Reset
connect_bd_net [get_bd_pins ip_0_microblaze/Reset] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_0_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/INTERRUPT] [get_bd_intf_pins ip_0_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/M_AXI_DP] [get_bd_intf_pins ip_0_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_0_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_0_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xadfb0123b8ce663 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_0_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_0_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_0_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_0_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x59e4d1780ed1c57 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_0_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_0_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_0_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_0_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_0_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 2 " [get_bd_cells ip_0_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_0_microblaze/microblaze_0/DEBUG]


########## axi_cdma ##########
create_bd_cell -type hier ip_1_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_1_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 58 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_1_axi_cdma/axi_cdma_0]
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


########## axi_hwicap ##########
create_bd_cell -type hier ip_2_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_2_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 128 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 512 " [get_bd_cells ip_2_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_2_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_2_axi_hwicap/icap_clk] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_2_axi_hwicap/eos_in] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_2_axi_hwicap/s_axi_aclk] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_2_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_2_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_2_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_2_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap/ICAP] [get_bd_intf_pins ip_2_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_2_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_2_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## floating_point ##########
create_bd_cell -type hier ip_3_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_3_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Half CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Square_root " [get_bd_cells ip_3_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_floating_point/aclk
connect_bd_net [get_bd_pins ip_3_floating_point/aclk] [get_bd_pins ip_3_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_3_floating_point/S_AXIS_A] [get_bd_intf_pins ip_3_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_3_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_3_floating_point/floating_point_0/M_AXIS_RESULT]


########## floating_point ##########
create_bd_cell -type hier ip_4_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_4_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Performance CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.c_result_exponent_width 11 CONFIG.c_result_fraction_width 63 CONFIG.flow_control Blocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_type Float_to_float CONFIG.result_precision_type Custom " [get_bd_cells ip_4_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aclk
connect_bd_net [get_bd_pins ip_4_floating_point/aclk] [get_bd_pins ip_4_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aresetn
connect_bd_net [get_bd_pins ip_4_floating_point/aresetn] [get_bd_pins ip_4_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]


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


########## axi ##########
create_bd_cell -type hier ip_8_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_8_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 3 CONFIG.NUM_SI 2 " [get_bd_cells ip_8_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi/clk
connect_bd_net [get_bd_pins ip_8_axi/clk] [get_bd_pins ip_8_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi/reset
connect_bd_net [get_bd_pins ip_8_axi/reset] [get_bd_pins ip_8_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_M0] [get_bd_intf_pins ip_8_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_M1] [get_bd_intf_pins ip_8_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_S0] [get_bd_intf_pins ip_8_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_S1] [get_bd_intf_pins ip_8_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_S2] [get_bd_intf_pins ip_8_axi/axi_0/M02_AXI]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_9_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_9_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_9_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_10_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aclk] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aresetn] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_11_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_11_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_11_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aclk] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aresetn] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_12_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_12_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_1_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_5_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_6_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_2_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap_ICAP] [get_bd_intf_pins ip_2_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_2_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_2_axi_hwicap/ICAP_ARBITER]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_9_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir I -from 0 -to 0 data_I
connect_bd_net [get_bd_pins data_I] [get_bd_pins ip_12_slice_and_concat/in_0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_5_reset/mb_reset] [get_bd_pins ip_0_microblaze/Reset]
connect_bd_net [get_bd_pins ip_5_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_4_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_0_microblaze/Clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_1_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_1_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_2_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_3_floating_point/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_4_floating_point/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_5_reset/clk_in]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_locked] [get_bd_pins ip_5_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_7_intc/irq_0] [get_bd_pins ip_1_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_7_intc/irq_1] [get_bd_pins ip_2_axi_hwicap/ip2intc_irpt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_microblaze/INTERRUPT] [get_bd_intf_pins ip_7_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_microblaze/M_AXI_DP] [get_bd_intf_pins ip_8_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_cdma/M_AXI] [get_bd_intf_pins ip_8_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_8_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_intc/AXI] [get_bd_intf_pins ip_8_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_floating_point/S_AXIS_A] [get_bd_intf_pins ip_9_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_2_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_12_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_8_axi/reset]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_9_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_10_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_5_reset/interconnect_aresetn] [get_bd_pins ip_11_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_7_intc/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_8_axi/clk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_9_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_10_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_6_clk_wiz/clk_out] [get_bd_pins ip_11_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
