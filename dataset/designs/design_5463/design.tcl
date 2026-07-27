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



########## uartlite ##########
create_bd_cell -type hier ip_0_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_0_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 115200 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Odd " [get_bd_cells ip_0_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_0_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_0_uartlite/UART] [get_bd_intf_pins ip_0_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_0_uartlite/clk
connect_bd_net [get_bd_pins ip_0_uartlite/clk] [get_bd_pins ip_0_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_uartlite/reset
connect_bd_net [get_bd_pins ip_0_uartlite/reset] [get_bd_pins ip_0_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_uartlite/AXI] [get_bd_intf_pins ip_0_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_uartlite/irq
connect_bd_net [get_bd_pins ip_0_uartlite/irq] [get_bd_pins ip_0_uartlite/uart_0/interrupt]


########## fft ##########
create_bd_cell -type hier ip_1_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_1_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 11 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 64 " [get_bd_cells ip_1_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_fft/aclk
connect_bd_net [get_bd_pins ip_1_fft/aclk] [get_bd_pins ip_1_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_1_fft/event_frame_started
connect_bd_net [get_bd_pins ip_1_fft/event_frame_started] [get_bd_pins ip_1_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_fft/S_AXIS_DATA] [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_fft/M_AXIS_DATA] [get_bd_intf_pins ip_1_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_1_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_CONFIG]


########## complex_multiplier ##########
create_bd_cell -type hier ip_2_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_2_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 51 CONFIG.aresetn 0 CONFIG.bportwidth 49 CONFIG.btuserwidth 68 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 9 CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 42 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_2_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_2_complex_multiplier/aclk] [get_bd_pins ip_2_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_2_complex_multiplier/aclken] [get_bd_pins ip_2_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_dma ##########
create_bd_cell -type hier ip_3_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_3_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 64 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 32 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 512 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 512 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 17 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_3_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_3_axi_dma/axi_resetn] [get_bd_pins ip_3_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXI] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_3_axi_dma/mm2s_introut] [get_bd_pins ip_3_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_3_axi_dma/s2mm_introut] [get_bd_pins ip_3_axi_dma/axi_dma_0/s2mm_introut]


########## axi_timer ##########
create_bd_cell -type hier ip_4_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_4_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 16 CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_4_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_timer/S_AXI] [get_bd_intf_pins ip_4_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_4_axi_timer/capturetrig0] [get_bd_pins ip_4_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_4_axi_timer/capturetrig1] [get_bd_pins ip_4_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/freeze
connect_bd_net [get_bd_pins ip_4_axi_timer/freeze] [get_bd_pins ip_4_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_4_axi_timer/s_axi_aclk] [get_bd_pins ip_4_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_4_axi_timer/s_axi_aresetn] [get_bd_pins ip_4_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_4_axi_timer/generateout0] [get_bd_pins ip_4_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_4_axi_timer/generateout1] [get_bd_pins ip_4_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_4_axi_timer/pwm0] [get_bd_pins ip_4_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_4_axi_timer/interrupt] [get_bd_pins ip_4_axi_timer/axi_timer_0/interrupt]


########## microblaze ##########
create_bd_cell -type hier ip_5_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 36 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 7 CONFIG.C_DEBUG_COUNTER_WIDTH 64 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 33 CONFIG.C_DEBUG_EXTERNAL_TRACE 0 CONFIG.C_DEBUG_LATENCY_COUNTERS 7 CONFIG.C_DEBUG_PROFILE_SIZE 65536 CONFIG.C_DEBUG_TRACE_SIZE 131072 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 4 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 4 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 0 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0xf5 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_5_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_5_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_5_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_5_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_5_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xa87373aefb5626 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_5_microblaze/lmb_ctrl_d]
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
set_property -dict "CONFIG.C_MASK 0xc0247741f148518 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_5_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_5_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_5_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_5_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_5_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_5_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_5_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_5_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_5_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 2 " [get_bd_cells ip_5_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_5_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_5_microblaze/microblaze_0/DEBUG]


########## floating_point ##########
create_bd_cell -type hier ip_6_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_6_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Resources CONFIG.c_a_exponent_width 11 CONFIG.c_a_fraction_width 15 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_mult_usage No_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_type Absolute CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_6_floating_point/floating_point_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_6_floating_point/S_AXIS_A] [get_bd_intf_pins ip_6_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_6_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_6_floating_point/floating_point_0/M_AXIS_RESULT]


########## microblaze ##########
create_bd_cell -type hier ip_7_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 40 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 4 CONFIG.C_DEBUG_COUNTER_WIDTH 64 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 11 CONFIG.C_DEBUG_EXTERNAL_TRACE 1 CONFIG.C_DEBUG_LATENCY_COUNTERS 5 CONFIG.C_DEBUG_PROFILE_SIZE 65536 CONFIG.C_DEBUG_TRACE_SIZE 256 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_NUMBER_OF_PC_BRK 7 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 1 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 4 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 0 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 0 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MMU 1 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_7_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_microblaze/Clk
connect_bd_net [get_bd_pins ip_7_microblaze/Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_7_microblaze/Reset
connect_bd_net [get_bd_pins ip_7_microblaze/Reset] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_7_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/INTERRUPT] [get_bd_intf_pins ip_7_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/M_AXI_DP] [get_bd_intf_pins ip_7_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_7_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_7_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xe0f5e28b6c960d6 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_7_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_7_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_7_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_7_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x8d900737865f395 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_7_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_7_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_7_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_7_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_7_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 3 " [get_bd_cells ip_7_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_7_microblaze/microblaze_0/DEBUG]


########## axi_timer ##########
create_bd_cell -type hier ip_8_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_8_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 32 CONFIG.GEN0_ASSERT Active_High CONFIG.GEN1_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.TRIG1_ASSERT Active_Low CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_8_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_timer/S_AXI] [get_bd_intf_pins ip_8_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_8_axi_timer/capturetrig0] [get_bd_pins ip_8_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_8_axi_timer/capturetrig1] [get_bd_pins ip_8_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_timer/freeze
connect_bd_net [get_bd_pins ip_8_axi_timer/freeze] [get_bd_pins ip_8_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_8_axi_timer/s_axi_aclk] [get_bd_pins ip_8_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_8_axi_timer/s_axi_aresetn] [get_bd_pins ip_8_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_8_axi_timer/generateout0] [get_bd_pins ip_8_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_8_axi_timer/generateout1] [get_bd_pins ip_8_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_8_axi_timer/pwm0] [get_bd_pins ip_8_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_8_axi_timer/interrupt] [get_bd_pins ip_8_axi_timer/axi_timer_0/interrupt]


########## microblaze ##########
create_bd_cell -type hier ip_9_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 40 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_COUNTER_WIDTH 64 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 26 CONFIG.C_DEBUG_EXTERNAL_TRACE 0 CONFIG.C_DEBUG_LATENCY_COUNTERS 3 CONFIG.C_DEBUG_PROFILE_SIZE 4096 CONFIG.C_DEBUG_TRACE_SIZE 65536 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 1 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 3 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 0 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0xcb CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_9_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_microblaze/Clk
connect_bd_net [get_bd_pins ip_9_microblaze/Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_microblaze/Reset
connect_bd_net [get_bd_pins ip_9_microblaze/Reset] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_9_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/INTERRUPT] [get_bd_intf_pins ip_9_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/M_AXI_DP] [get_bd_intf_pins ip_9_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_9_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_9_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xf477bd82d2b6c5f CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_9_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_9_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_9_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_9_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xd73ec5667be9c41 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_9_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_9_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_9_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_9_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_9_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 4 " [get_bd_cells ip_9_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_9_microblaze/microblaze_0/DEBUG]


########## axi_hwicap ##########
create_bd_cell -type hier ip_10_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_10_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_10_axi_hwicap/axi_hwicap_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_10_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap/ICAP] [get_bd_intf_pins ip_10_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_10_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_10_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## uartlite ##########
create_bd_cell -type hier ip_11_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_11_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 115200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Even " [get_bd_cells ip_11_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_11_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_11_uartlite/UART] [get_bd_intf_pins ip_11_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_11_uartlite/clk
connect_bd_net [get_bd_pins ip_11_uartlite/clk] [get_bd_pins ip_11_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_uartlite/reset
connect_bd_net [get_bd_pins ip_11_uartlite/reset] [get_bd_pins ip_11_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_uartlite/AXI] [get_bd_intf_pins ip_11_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_11_uartlite/irq
connect_bd_net [get_bd_pins ip_11_uartlite/irq] [get_bd_pins ip_11_uartlite/uart_0/interrupt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_12_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_12_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_12_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_12_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite/MII] [get_bd_intf_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_12_axi_ethernet_lite/clk] [get_bd_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_12_axi_ethernet_lite/reset] [get_bd_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_12_axi_ethernet_lite/irq] [get_bd_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## fft ##########
create_bd_cell -type hier ip_13_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_13_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 10 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 4096 " [get_bd_cells ip_13_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_fft/aclk
connect_bd_net [get_bd_pins ip_13_fft/aclk] [get_bd_pins ip_13_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_13_fft/event_frame_started
connect_bd_net [get_bd_pins ip_13_fft/event_frame_started] [get_bd_pins ip_13_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/S_AXIS_DATA] [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/M_AXIS_DATA] [get_bd_intf_pins ip_13_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_CONFIG]


########## axi_timer ##########
create_bd_cell -type hier ip_14_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_14_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 32 CONFIG.GEN0_ASSERT Active_High CONFIG.GEN1_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.TRIG1_ASSERT Active_Low CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_14_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_timer/S_AXI] [get_bd_intf_pins ip_14_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_14_axi_timer/capturetrig0] [get_bd_pins ip_14_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_14_axi_timer/capturetrig1] [get_bd_pins ip_14_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/freeze
connect_bd_net [get_bd_pins ip_14_axi_timer/freeze] [get_bd_pins ip_14_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_14_axi_timer/s_axi_aclk] [get_bd_pins ip_14_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_14_axi_timer/s_axi_aresetn] [get_bd_pins ip_14_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_14_axi_timer/generateout0] [get_bd_pins ip_14_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_14_axi_timer/generateout1] [get_bd_pins ip_14_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_14_axi_timer/pwm0] [get_bd_pins ip_14_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_14_axi_timer/interrupt] [get_bd_pins ip_14_axi_timer/axi_timer_0/interrupt]


########## conv_encoder ##########
create_bd_cell -type hier ip_15_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_15_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 3 CONFIG.convolution_code0 2 CONFIG.convolution_code1 0 CONFIG.convolution_code2 6 CONFIG.convolution_code3 1 CONFIG.convolution_code4 3 CONFIG.convolution_code5 5 CONFIG.convolution_code6 7 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 7 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_15_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_15_conv_encoder/aclk] [get_bd_pins ip_15_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_15_conv_encoder/aresetn] [get_bd_pins ip_15_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_15_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_15_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_15_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_15_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## floating_point ##########
create_bd_cell -type hier ip_16_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_16_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Double CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Resources CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_mult_usage No_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 1 CONFIG.maximum_latency 1 CONFIG.operation_type Absolute CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_16_floating_point/floating_point_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_16_floating_point/S_AXIS_A] [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_16_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_16_floating_point/floating_point_0/M_AXIS_RESULT]


########## floating_point ##########
create_bd_cell -type hier ip_17_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_17_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Half CONFIG.a_tuser_width 20 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Absolute " [get_bd_cells ip_17_floating_point/floating_point_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_17_floating_point/S_AXIS_A] [get_bd_intf_pins ip_17_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_17_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_17_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_18_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_18_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_18_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_18_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_ethernet_lite/MII] [get_bd_intf_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_18_axi_ethernet_lite/clk] [get_bd_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_18_axi_ethernet_lite/reset] [get_bd_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_18_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_18_axi_ethernet_lite/irq] [get_bd_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_19_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_19_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x7ffff CONFIG.C_GPIO2_WIDTH 28 CONFIG.C_GPIO_WIDTH 19 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_19_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_19_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio/GPIO] [get_bd_intf_pins ip_19_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_19_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio/GPIO2] [get_bd_intf_pins ip_19_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_19_gpio/clk
connect_bd_net [get_bd_pins ip_19_gpio/clk] [get_bd_pins ip_19_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_gpio/rst
connect_bd_net [get_bd_pins ip_19_gpio/rst] [get_bd_pins ip_19_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio/AXI] [get_bd_intf_pins ip_19_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_19_gpio/irq
connect_bd_net [get_bd_pins ip_19_gpio/irq] [get_bd_pins ip_19_gpio/gpio_0/ip2intc_irpt]


########## axi_cdma ##########
create_bd_cell -type hier ip_20_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_20_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 41 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_20_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_20_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_20_axi_cdma/m_axi_aclk] [get_bd_pins ip_20_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_20_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_20_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_20_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_20_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_cdma/M_AXI] [get_bd_intf_pins ip_20_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_20_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_20_axi_cdma/cdma_introut] [get_bd_pins ip_20_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_timer ##########
create_bd_cell -type hier ip_21_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_21_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 32 CONFIG.GEN0_ASSERT Active_Low CONFIG.GEN1_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.TRIG1_ASSERT Active_High CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_21_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_timer/S_AXI] [get_bd_intf_pins ip_21_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_21_axi_timer/capturetrig0] [get_bd_pins ip_21_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_21_axi_timer/capturetrig1] [get_bd_pins ip_21_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_timer/freeze
connect_bd_net [get_bd_pins ip_21_axi_timer/freeze] [get_bd_pins ip_21_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_21_axi_timer/s_axi_aclk] [get_bd_pins ip_21_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_21_axi_timer/s_axi_aresetn] [get_bd_pins ip_21_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_21_axi_timer/generateout0] [get_bd_pins ip_21_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_21_axi_timer/generateout1] [get_bd_pins ip_21_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_21_axi_timer/pwm0] [get_bd_pins ip_21_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_21_axi_timer/interrupt] [get_bd_pins ip_21_axi_timer/axi_timer_0/interrupt]


########## axi_dma ##########
create_bd_cell -type hier ip_22_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_22_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 58 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 512 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 18 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 256 " [get_bd_cells ip_22_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_22_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_22_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_22_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_22_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_22_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_22_axi_dma/axi_resetn] [get_bd_pins ip_22_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_22_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_22_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_22_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_22_axi_dma/s2mm_introut] [get_bd_pins ip_22_axi_dma/axi_dma_0/s2mm_introut]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_23_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_23_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_23_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_23_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_ethernet_lite/MII] [get_bd_intf_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_23_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_23_axi_ethernet_lite/clk] [get_bd_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_23_axi_ethernet_lite/reset] [get_bd_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_23_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_23_axi_ethernet_lite/irq] [get_bd_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_iic ##########
create_bd_cell -type hier ip_24_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_24_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x51 CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 56 CONFIG.C_SDA_INERTIAL_DELAY 70 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 349.8668733488366 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_24_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_24_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_iic/IIC] [get_bd_intf_pins ip_24_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi_iic/clk
connect_bd_net [get_bd_pins ip_24_axi_iic/clk] [get_bd_pins ip_24_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi_iic/reset
connect_bd_net [get_bd_pins ip_24_axi_iic/reset] [get_bd_pins ip_24_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_iic/AXI] [get_bd_intf_pins ip_24_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_24_axi_iic/irq
connect_bd_net [get_bd_pins ip_24_axi_iic/irq] [get_bd_pins ip_24_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_iic ##########
create_bd_cell -type hier ip_25_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_25_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x42 CONFIG.C_GPO_WIDTH 8 CONFIG.C_SCL_INERTIAL_DELAY 250 CONFIG.C_SDA_INERTIAL_DELAY 115 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 209.61022808612512 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_25_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_25_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic/IIC] [get_bd_intf_pins ip_25_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_iic/clk
connect_bd_net [get_bd_pins ip_25_axi_iic/clk] [get_bd_pins ip_25_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_iic/reset
connect_bd_net [get_bd_pins ip_25_axi_iic/reset] [get_bd_pins ip_25_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic/AXI] [get_bd_intf_pins ip_25_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_25_axi_iic/irq
connect_bd_net [get_bd_pins ip_25_axi_iic/irq] [get_bd_pins ip_25_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_26_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_26_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_26_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_26_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_quad_spi/IIC] [get_bd_intf_pins ip_26_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_26_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_26_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_26_axi_quad_spi/clk] [get_bd_pins ip_26_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_26_axi_quad_spi/reset] [get_bd_pins ip_26_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_26_axi_quad_spi/clk4] [get_bd_pins ip_26_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_26_axi_quad_spi/reset4] [get_bd_pins ip_26_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_26_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_26_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_26_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_26_axi_quad_spi/irq] [get_bd_pins ip_26_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_27_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_27_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 57600 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Odd " [get_bd_cells ip_27_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_27_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_27_uartlite/UART] [get_bd_intf_pins ip_27_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_27_uartlite/clk
connect_bd_net [get_bd_pins ip_27_uartlite/clk] [get_bd_pins ip_27_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_uartlite/reset
connect_bd_net [get_bd_pins ip_27_uartlite/reset] [get_bd_pins ip_27_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_27_uartlite/AXI] [get_bd_intf_pins ip_27_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_27_uartlite/irq
connect_bd_net [get_bd_pins ip_27_uartlite/irq] [get_bd_pins ip_27_uartlite/uart_0/interrupt]


########## axi_dma ##########
create_bd_cell -type hier ip_28_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_28_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 33 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_28_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_28_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_28_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_28_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_28_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_28_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_28_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_28_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_28_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_28_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_28_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_28_axi_dma/axi_resetn] [get_bd_pins ip_28_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_28_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_28_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_28_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_28_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_28_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_28_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_28_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_28_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_28_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_28_axi_dma/mm2s_introut] [get_bd_pins ip_28_axi_dma/axi_dma_0/mm2s_introut]


########## reset ##########
create_bd_cell -type hier ip_29_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_29_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_reset/clk_in
connect_bd_net [get_bd_pins ip_29_reset/clk_in] [get_bd_pins ip_29_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_29_reset/reset_in
connect_bd_net [get_bd_pins ip_29_reset/reset_in] [get_bd_pins ip_29_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_29_reset/dcm_locked
connect_bd_net [get_bd_pins ip_29_reset/dcm_locked] [get_bd_pins ip_29_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_29_reset/mb_reset
connect_bd_net [get_bd_pins ip_29_reset/mb_reset] [get_bd_pins ip_29_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_29_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_29_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_29_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset] [get_bd_pins ip_29_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_29_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_29_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_30_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_30_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_in] [get_bd_pins ip_30_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_30_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_30_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_30_clk_wiz/reset
connect_bd_net [get_bd_pins ip_30_clk_wiz/reset] [get_bd_pins ip_30_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_30_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_locked] [get_bd_pins ip_30_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_31_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_31_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_31_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 22 " [get_bd_cells ip_31_intc/concat_0]
connect_bd_net [get_bd_pins ip_31_intc/concat_0/dout] [get_bd_pins ip_31_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/clk
connect_bd_net [get_bd_pins ip_31_intc/clk] [get_bd_pins ip_31_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/reset
connect_bd_net [get_bd_pins ip_31_intc/reset] [get_bd_pins ip_31_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_31_intc/AXI] [get_bd_intf_pins ip_31_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_0
connect_bd_net [get_bd_pins ip_31_intc/irq_0] [get_bd_pins ip_31_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_1
connect_bd_net [get_bd_pins ip_31_intc/irq_1] [get_bd_pins ip_31_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_2
connect_bd_net [get_bd_pins ip_31_intc/irq_2] [get_bd_pins ip_31_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_3
connect_bd_net [get_bd_pins ip_31_intc/irq_3] [get_bd_pins ip_31_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_4
connect_bd_net [get_bd_pins ip_31_intc/irq_4] [get_bd_pins ip_31_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_5
connect_bd_net [get_bd_pins ip_31_intc/irq_5] [get_bd_pins ip_31_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_6
connect_bd_net [get_bd_pins ip_31_intc/irq_6] [get_bd_pins ip_31_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_7
connect_bd_net [get_bd_pins ip_31_intc/irq_7] [get_bd_pins ip_31_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_8
connect_bd_net [get_bd_pins ip_31_intc/irq_8] [get_bd_pins ip_31_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_9
connect_bd_net [get_bd_pins ip_31_intc/irq_9] [get_bd_pins ip_31_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_10
connect_bd_net [get_bd_pins ip_31_intc/irq_10] [get_bd_pins ip_31_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_11
connect_bd_net [get_bd_pins ip_31_intc/irq_11] [get_bd_pins ip_31_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_12
connect_bd_net [get_bd_pins ip_31_intc/irq_12] [get_bd_pins ip_31_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_13
connect_bd_net [get_bd_pins ip_31_intc/irq_13] [get_bd_pins ip_31_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_14
connect_bd_net [get_bd_pins ip_31_intc/irq_14] [get_bd_pins ip_31_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_15
connect_bd_net [get_bd_pins ip_31_intc/irq_15] [get_bd_pins ip_31_intc/concat_0/In15]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_16
connect_bd_net [get_bd_pins ip_31_intc/irq_16] [get_bd_pins ip_31_intc/concat_0/In16]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_17
connect_bd_net [get_bd_pins ip_31_intc/irq_17] [get_bd_pins ip_31_intc/concat_0/In17]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_18
connect_bd_net [get_bd_pins ip_31_intc/irq_18] [get_bd_pins ip_31_intc/concat_0/In18]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_19
connect_bd_net [get_bd_pins ip_31_intc/irq_19] [get_bd_pins ip_31_intc/concat_0/In19]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_20
connect_bd_net [get_bd_pins ip_31_intc/irq_20] [get_bd_pins ip_31_intc/concat_0/In20]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_21
connect_bd_net [get_bd_pins ip_31_intc/irq_21] [get_bd_pins ip_31_intc/concat_0/In21]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_31_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_31_intc/irq] [get_bd_intf_pins ip_31_intc/intc_0/interrupt]


########## intc ##########
create_bd_cell -type hier ip_32_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_32_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_32_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 22 " [get_bd_cells ip_32_intc/concat_0]
connect_bd_net [get_bd_pins ip_32_intc/concat_0/dout] [get_bd_pins ip_32_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/clk
connect_bd_net [get_bd_pins ip_32_intc/clk] [get_bd_pins ip_32_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/reset
connect_bd_net [get_bd_pins ip_32_intc/reset] [get_bd_pins ip_32_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_32_intc/AXI] [get_bd_intf_pins ip_32_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_0
connect_bd_net [get_bd_pins ip_32_intc/irq_0] [get_bd_pins ip_32_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_1
connect_bd_net [get_bd_pins ip_32_intc/irq_1] [get_bd_pins ip_32_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_2
connect_bd_net [get_bd_pins ip_32_intc/irq_2] [get_bd_pins ip_32_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_3
connect_bd_net [get_bd_pins ip_32_intc/irq_3] [get_bd_pins ip_32_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_4
connect_bd_net [get_bd_pins ip_32_intc/irq_4] [get_bd_pins ip_32_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_5
connect_bd_net [get_bd_pins ip_32_intc/irq_5] [get_bd_pins ip_32_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_6
connect_bd_net [get_bd_pins ip_32_intc/irq_6] [get_bd_pins ip_32_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_7
connect_bd_net [get_bd_pins ip_32_intc/irq_7] [get_bd_pins ip_32_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_8
connect_bd_net [get_bd_pins ip_32_intc/irq_8] [get_bd_pins ip_32_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_9
connect_bd_net [get_bd_pins ip_32_intc/irq_9] [get_bd_pins ip_32_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_10
connect_bd_net [get_bd_pins ip_32_intc/irq_10] [get_bd_pins ip_32_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_11
connect_bd_net [get_bd_pins ip_32_intc/irq_11] [get_bd_pins ip_32_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_12
connect_bd_net [get_bd_pins ip_32_intc/irq_12] [get_bd_pins ip_32_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_13
connect_bd_net [get_bd_pins ip_32_intc/irq_13] [get_bd_pins ip_32_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_14
connect_bd_net [get_bd_pins ip_32_intc/irq_14] [get_bd_pins ip_32_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_15
connect_bd_net [get_bd_pins ip_32_intc/irq_15] [get_bd_pins ip_32_intc/concat_0/In15]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_16
connect_bd_net [get_bd_pins ip_32_intc/irq_16] [get_bd_pins ip_32_intc/concat_0/In16]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_17
connect_bd_net [get_bd_pins ip_32_intc/irq_17] [get_bd_pins ip_32_intc/concat_0/In17]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_18
connect_bd_net [get_bd_pins ip_32_intc/irq_18] [get_bd_pins ip_32_intc/concat_0/In18]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_19
connect_bd_net [get_bd_pins ip_32_intc/irq_19] [get_bd_pins ip_32_intc/concat_0/In19]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_20
connect_bd_net [get_bd_pins ip_32_intc/irq_20] [get_bd_pins ip_32_intc/concat_0/In20]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_21
connect_bd_net [get_bd_pins ip_32_intc/irq_21] [get_bd_pins ip_32_intc/concat_0/In21]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_32_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_32_intc/irq] [get_bd_intf_pins ip_32_intc/intc_0/interrupt]


########## intc ##########
create_bd_cell -type hier ip_33_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_33_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_33_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 22 " [get_bd_cells ip_33_intc/concat_0]
connect_bd_net [get_bd_pins ip_33_intc/concat_0/dout] [get_bd_pins ip_33_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/clk
connect_bd_net [get_bd_pins ip_33_intc/clk] [get_bd_pins ip_33_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/reset
connect_bd_net [get_bd_pins ip_33_intc/reset] [get_bd_pins ip_33_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_33_intc/AXI] [get_bd_intf_pins ip_33_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_0
connect_bd_net [get_bd_pins ip_33_intc/irq_0] [get_bd_pins ip_33_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_1
connect_bd_net [get_bd_pins ip_33_intc/irq_1] [get_bd_pins ip_33_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_2
connect_bd_net [get_bd_pins ip_33_intc/irq_2] [get_bd_pins ip_33_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_3
connect_bd_net [get_bd_pins ip_33_intc/irq_3] [get_bd_pins ip_33_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_4
connect_bd_net [get_bd_pins ip_33_intc/irq_4] [get_bd_pins ip_33_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_5
connect_bd_net [get_bd_pins ip_33_intc/irq_5] [get_bd_pins ip_33_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_6
connect_bd_net [get_bd_pins ip_33_intc/irq_6] [get_bd_pins ip_33_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_7
connect_bd_net [get_bd_pins ip_33_intc/irq_7] [get_bd_pins ip_33_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_8
connect_bd_net [get_bd_pins ip_33_intc/irq_8] [get_bd_pins ip_33_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_9
connect_bd_net [get_bd_pins ip_33_intc/irq_9] [get_bd_pins ip_33_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_10
connect_bd_net [get_bd_pins ip_33_intc/irq_10] [get_bd_pins ip_33_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_11
connect_bd_net [get_bd_pins ip_33_intc/irq_11] [get_bd_pins ip_33_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_12
connect_bd_net [get_bd_pins ip_33_intc/irq_12] [get_bd_pins ip_33_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_13
connect_bd_net [get_bd_pins ip_33_intc/irq_13] [get_bd_pins ip_33_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_14
connect_bd_net [get_bd_pins ip_33_intc/irq_14] [get_bd_pins ip_33_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_15
connect_bd_net [get_bd_pins ip_33_intc/irq_15] [get_bd_pins ip_33_intc/concat_0/In15]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_16
connect_bd_net [get_bd_pins ip_33_intc/irq_16] [get_bd_pins ip_33_intc/concat_0/In16]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_17
connect_bd_net [get_bd_pins ip_33_intc/irq_17] [get_bd_pins ip_33_intc/concat_0/In17]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_18
connect_bd_net [get_bd_pins ip_33_intc/irq_18] [get_bd_pins ip_33_intc/concat_0/In18]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_19
connect_bd_net [get_bd_pins ip_33_intc/irq_19] [get_bd_pins ip_33_intc/concat_0/In19]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_20
connect_bd_net [get_bd_pins ip_33_intc/irq_20] [get_bd_pins ip_33_intc/concat_0/In20]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_21
connect_bd_net [get_bd_pins ip_33_intc/irq_21] [get_bd_pins ip_33_intc/concat_0/In21]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_33_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_33_intc/irq] [get_bd_intf_pins ip_33_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_34_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_34_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 8 " [get_bd_cells ip_34_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axi_legacy/clk
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_34_axi_legacy/reset
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M0] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M1] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M2] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M3] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M4] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S04_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S04_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S04_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M5] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S05_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S05_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S05_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M6
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M6] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S06_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S06_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S06_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M7
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M7] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S07_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S07_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_S0] [get_bd_intf_pins ip_34_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_S1] [get_bd_intf_pins ip_34_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/M01_ARESETN]


########## axi_legacy ##########
create_bd_cell -type hier ip_35_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_35_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_35_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axi_legacy/clk
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_35_axi_legacy/reset
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_M0] [get_bd_intf_pins ip_35_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S0] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S1] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S2] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S3] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S4] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S5] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S6] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S7] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S8] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S9] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S10] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S11] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S12] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M12_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S13] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M13_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M13_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M13_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S14] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M14_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M14_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M14_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S15] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M15_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M15_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M15_ARESETN]


########## axi_legacy ##########
create_bd_cell -type hier ip_36_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_36_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 7 CONFIG.NUM_SI 1 " [get_bd_cells ip_36_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axi_legacy/clk
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_36_axi_legacy/reset
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_M0] [get_bd_intf_pins ip_36_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S0] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S1] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S2] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S3] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S4] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S5] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S6] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M06_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_37_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_37_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_37_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_38_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_38_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_38_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_38_axis_broadcaster/aclk] [get_bd_pins ip_38_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_38_axis_broadcaster/aresetn] [get_bd_pins ip_38_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_39_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_39_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_39_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_39_axis_broadcaster/aclk] [get_bd_pins ip_39_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_39_axis_broadcaster/aresetn] [get_bd_pins ip_39_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_40_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_40_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_40_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_40_axis_broadcaster/aclk] [get_bd_pins ip_40_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_40_axis_broadcaster/aresetn] [get_bd_pins ip_40_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_41_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_41_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_41_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_41_axis_broadcaster/aclk] [get_bd_pins ip_41_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_41_axis_broadcaster/aresetn] [get_bd_pins ip_41_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_42_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_42_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_44_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_44_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 44 " [get_bd_cells ip_44_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aclk] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aresetn] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_45_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_45_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_45_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aclk] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aresetn] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_46_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_46_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_46_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aclk] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aresetn] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_47_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_47_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 40 " [get_bd_cells ip_47_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aclk] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aresetn] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_48_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_48_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 32 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_48_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_48_axis_dwidth_converter/aclk] [get_bd_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_48_axis_dwidth_converter/aresetn] [get_bd_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_49_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_49_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_49_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_49_axis_combiner/aclk] [get_bd_pins ip_49_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_49_axis_combiner/aresetn] [get_bd_pins ip_49_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_combiner/M_AXIS] [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_50_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_50_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_50_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_50_axis_combiner/aclk] [get_bd_pins ip_50_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_50_axis_combiner/aresetn] [get_bd_pins ip_50_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/M_AXIS] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_51_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_51_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_51_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_51_axis_dwidth_converter/aclk] [get_bd_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_51_axis_dwidth_converter/aresetn] [get_bd_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_52_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_52_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_52_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_52_axis_combiner/aclk] [get_bd_pins ip_52_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_52_axis_combiner/aresetn] [get_bd_pins ip_52_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_combiner/M_AXIS] [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_53_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_53_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_53_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_53_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_53_axis_dwidth_converter/aclk] [get_bd_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_53_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_53_axis_dwidth_converter/aresetn] [get_bd_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_54_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_54_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 40 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_54_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_54_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_54_axis_dwidth_converter/aclk] [get_bd_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_54_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_54_axis_dwidth_converter/aresetn] [get_bd_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_55_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 11 " [get_bd_cells ip_55_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_55_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_1] [get_bd_pins ip_55_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_2] [get_bd_pins ip_55_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_3] [get_bd_pins ip_55_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_4] [get_bd_pins ip_55_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_5] [get_bd_pins ip_55_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_6] [get_bd_pins ip_55_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_7] [get_bd_pins ip_55_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_8] [get_bd_pins ip_55_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_9] [get_bd_pins ip_55_slice_and_concat/concat/In9]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_10
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_10] [get_bd_pins ip_55_slice_and_concat/concat/In10]


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_56_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_57_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_57_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_57_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_57_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_58_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_58_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_59_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_59_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_59_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_59_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_59_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_59_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_60_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_60_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_60_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_60_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_60_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_60_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_61_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_61_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_61_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_61_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_61_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_61_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_61_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_62_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_62_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_62_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_62_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_62_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_62_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_62_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_63_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_63_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_63_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_63_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_63_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_63_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_63_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_64_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_64_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_64_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_64_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_64_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_64_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_64_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_65_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_65_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_65_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_65_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_65_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_65_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_65_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_66_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_66_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_66_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_66_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_66_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_67_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_67_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_67_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_67_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_67_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_68_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_68_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_68_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_68_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_68_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_68_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_69_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_69_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_69_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_69_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_69_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_69_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_29_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_30_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_0_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_0_uartlite_UART] [get_bd_intf_pins ip_0_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_10_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap_ICAP] [get_bd_intf_pins ip_10_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_10_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_10_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_11_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_11_uartlite_UART] [get_bd_intf_pins ip_11_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_12_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite_MII] [get_bd_intf_pins ip_12_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_18_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_ethernet_lite_MII] [get_bd_intf_pins ip_18_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_19_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio_GPIO] [get_bd_intf_pins ip_19_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_19_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio_GPIO2] [get_bd_intf_pins ip_19_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_23_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_ethernet_lite_MII] [get_bd_intf_pins ip_23_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_23_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_23_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_24_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_iic_IIC] [get_bd_intf_pins ip_24_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_25_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic_IIC] [get_bd_intf_pins ip_25_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_26_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_quad_spi_IIC] [get_bd_intf_pins ip_26_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_27_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_27_uartlite_UART] [get_bd_intf_pins ip_27_uartlite/UART]

########## Interrupts ##########

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 10 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_55_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_57_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_58_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_59_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_60_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_61_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_62_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_63_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_64_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_65_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_66_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_67_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_68_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_69_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_30_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_31_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_32_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_33_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_0_uartlite/reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_29_reset/mb_reset] [get_bd_pins ip_5_microblaze/Reset]
connect_bd_net [get_bd_pins ip_29_reset/mb_reset] [get_bd_pins ip_7_microblaze/Reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_29_reset/mb_reset] [get_bd_pins ip_9_microblaze/Reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_11_uartlite/reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_15_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_18_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_19_gpio/rst]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_21_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_22_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_23_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_24_axi_iic/reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_25_axi_iic/reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_26_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_26_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_27_uartlite/reset]
connect_bd_net [get_bd_pins ip_29_reset/peripheral_areset_n] [get_bd_pins ip_28_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_0_uartlite/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_1_fft/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_2_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_4_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_5_microblaze/Clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_7_microblaze/Clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_8_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_9_microblaze/Clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_10_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_10_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_11_uartlite/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_12_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_13_fft/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_14_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_15_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_18_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_19_gpio/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_20_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_20_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_21_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_22_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_22_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_23_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_24_axi_iic/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_25_axi_iic/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_26_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_26_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_26_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_27_uartlite/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_28_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_28_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_28_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_29_reset/clk_in]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_locked] [get_bd_pins ip_29_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_31_intc/irq_0] [get_bd_pins ip_0_uartlite/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_1] [get_bd_pins ip_1_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_31_intc/irq_2] [get_bd_pins ip_3_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_31_intc/irq_3] [get_bd_pins ip_3_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_31_intc/irq_4] [get_bd_pins ip_4_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_31_intc/irq_5] [get_bd_pins ip_8_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_31_intc/irq_6] [get_bd_pins ip_10_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_31_intc/irq_7] [get_bd_pins ip_11_uartlite/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_8] [get_bd_pins ip_12_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_9] [get_bd_pins ip_13_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_31_intc/irq_10] [get_bd_pins ip_14_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_31_intc/irq_11] [get_bd_pins ip_18_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_12] [get_bd_pins ip_19_gpio/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_13] [get_bd_pins ip_20_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_31_intc/irq_14] [get_bd_pins ip_21_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_31_intc/irq_15] [get_bd_pins ip_22_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_31_intc/irq_16] [get_bd_pins ip_23_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_17] [get_bd_pins ip_24_axi_iic/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_18] [get_bd_pins ip_25_axi_iic/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_19] [get_bd_pins ip_26_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_20] [get_bd_pins ip_27_uartlite/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_21] [get_bd_pins ip_28_axi_dma/mm2s_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_microblaze/INTERRUPT] [get_bd_intf_pins ip_31_intc/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_0] [get_bd_pins ip_0_uartlite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_1] [get_bd_pins ip_1_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_32_intc/irq_2] [get_bd_pins ip_3_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_3] [get_bd_pins ip_3_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_4] [get_bd_pins ip_4_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_32_intc/irq_5] [get_bd_pins ip_8_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_32_intc/irq_6] [get_bd_pins ip_10_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_32_intc/irq_7] [get_bd_pins ip_11_uartlite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_8] [get_bd_pins ip_12_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_9] [get_bd_pins ip_13_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_32_intc/irq_10] [get_bd_pins ip_14_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_32_intc/irq_11] [get_bd_pins ip_18_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_12] [get_bd_pins ip_19_gpio/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_13] [get_bd_pins ip_20_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_14] [get_bd_pins ip_21_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_32_intc/irq_15] [get_bd_pins ip_22_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_16] [get_bd_pins ip_23_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_17] [get_bd_pins ip_24_axi_iic/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_18] [get_bd_pins ip_25_axi_iic/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_19] [get_bd_pins ip_26_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_20] [get_bd_pins ip_27_uartlite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_21] [get_bd_pins ip_28_axi_dma/mm2s_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_microblaze/INTERRUPT] [get_bd_intf_pins ip_32_intc/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_0] [get_bd_pins ip_0_uartlite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_1] [get_bd_pins ip_1_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_33_intc/irq_2] [get_bd_pins ip_3_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_3] [get_bd_pins ip_3_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_4] [get_bd_pins ip_4_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_33_intc/irq_5] [get_bd_pins ip_8_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_33_intc/irq_6] [get_bd_pins ip_10_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_33_intc/irq_7] [get_bd_pins ip_11_uartlite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_8] [get_bd_pins ip_12_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_9] [get_bd_pins ip_13_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_33_intc/irq_10] [get_bd_pins ip_14_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_33_intc/irq_11] [get_bd_pins ip_18_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_12] [get_bd_pins ip_19_gpio/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_13] [get_bd_pins ip_20_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_14] [get_bd_pins ip_21_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_33_intc/irq_15] [get_bd_pins ip_22_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_16] [get_bd_pins ip_23_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_17] [get_bd_pins ip_24_axi_iic/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_18] [get_bd_pins ip_25_axi_iic/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_19] [get_bd_pins ip_26_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_20] [get_bd_pins ip_27_uartlite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_21] [get_bd_pins ip_28_axi_dma/mm2s_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_microblaze/INTERRUPT] [get_bd_intf_pins ip_33_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/M_AXI] [get_bd_intf_pins ip_34_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_microblaze/M_AXI_DP] [get_bd_intf_pins ip_34_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_microblaze/M_AXI_DP] [get_bd_intf_pins ip_34_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_microblaze/M_AXI_DP] [get_bd_intf_pins ip_34_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_cdma/M_AXI] [get_bd_intf_pins ip_34_axi_legacy/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_34_axi_legacy/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_34_axi_legacy/AXI_M6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_34_axi_legacy/AXI_M7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axi_legacy/AXI_S0] [get_bd_intf_pins ip_35_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_uartlite/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_timer/S_AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_timer/S_AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_35_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_uartlite/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_timer/S_AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_gpio/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axi_timer/S_AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axi_iic/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axi_iic/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axi_legacy/AXI_S1] [get_bd_intf_pins ip_36_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_36_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_36_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_uartlite/AXI] [get_bd_intf_pins ip_36_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_36_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_intc/AXI] [get_bd_intf_pins ip_36_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_intc/AXI] [get_bd_intf_pins ip_36_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_intc/AXI] [get_bd_intf_pins ip_36_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_38_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_39_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_40_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/M_AXIS_DATA] [get_bd_intf_pins ip_41_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_floating_point/S_AXIS_A] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_6_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_1_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_floating_point/S_AXIS_A] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_floating_point/S_AXIS_A] [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_2_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_fft/S_AXIS_DATA] [get_bd_intf_pins ip_49_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_50_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_51_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_52_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_53_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_52_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_53_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_54_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_DATA] [get_bd_intf_pins ip_54_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_4_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_1] [get_bd_pins ip_4_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_2] [get_bd_pins ip_4_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_3] [get_bd_pins ip_8_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_4] [get_bd_pins ip_8_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_5] [get_bd_pins ip_8_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_6] [get_bd_pins ip_14_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_7] [get_bd_pins ip_14_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_8] [get_bd_pins ip_14_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_9] [get_bd_pins ip_21_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_10] [get_bd_pins ip_21_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_10_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_21_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_4_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_4_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_14_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_14_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_2_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_8_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_21_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_21_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_4_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_14_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_8_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_21_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_8_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_34_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_35_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_36_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_48_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_49_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_50_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_51_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_52_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_53_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_reset/interconnect_aresetn] [get_bd_pins ip_54_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_31_intc/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_32_intc/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_33_intc/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_34_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_35_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_36_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_37_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_38_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_39_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_40_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_41_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_45_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_46_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_47_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_48_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_49_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_50_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_51_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_52_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_53_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_30_clk_wiz/clk_out] [get_bd_pins ip_54_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_DATA declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_DATA declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/M_AXIS_DATA declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/M_AXIS_DATA declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 17 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_CONFIG declared=17 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_CONFIG declared=17 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/M_AXIS_DOUT declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 34 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=34 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=34 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axi_dma/S_AXIS_S2MM declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axi_dma/S_AXIS_S2MM declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_3 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_3 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_2 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/S_AXIS declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/S_AXIS declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_0 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_0 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_1 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_1 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/S_AXIS_1 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/S_AXIS_1 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/M_AXIS declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/M_AXIS declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_2 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/S_AXIS_2 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_dwidth_converter/M_AXIS declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_dwidth_converter/M_AXIS declared=320 actual=ERR $__err" }


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
