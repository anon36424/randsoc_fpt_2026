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
set_property -dict "CONFIG.C_ADDR_WIDTH 40 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_0_axi_cdma/axi_cdma_0]
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


########## axi_hwicap ##########
create_bd_cell -type hier ip_1_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_1_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 0 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 128 " [get_bd_cells ip_1_axi_hwicap/axi_hwicap_0]
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


########## gpio ##########
create_bd_cell -type hier ip_2_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_2_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x28b594 CONFIG.C_GPIO_WIDTH 22 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_2_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/GPIO] [get_bd_intf_pins ip_2_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/clk
connect_bd_net [get_bd_pins ip_2_gpio/clk] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/rst
connect_bd_net [get_bd_pins ip_2_gpio/rst] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_2_gpio/gpio_0/S_AXI]


########## fft ##########
create_bd_cell -type hier ip_3_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_3_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 5 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 512 " [get_bd_cells ip_3_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_fft/aclk
connect_bd_net [get_bd_pins ip_3_fft/aclk] [get_bd_pins ip_3_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_3_fft/event_frame_started
connect_bd_net [get_bd_pins ip_3_fft/event_frame_started] [get_bd_pins ip_3_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_fft/M_AXIS_DATA] [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]


########## microblaze ##########
create_bd_cell -type hier ip_4_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 44 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_COUNTER_WIDTH 48 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 19 CONFIG.C_DEBUG_EXTERNAL_TRACE 0 CONFIG.C_DEBUG_LATENCY_COUNTERS 5 CONFIG.C_DEBUG_PROFILE_SIZE 65536 CONFIG.C_DEBUG_TRACE_SIZE 32768 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 3 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 0 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 4 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0x32 CONFIG.C_PVR_USER2 0x5b2c0fc6 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_4_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_MASK 0xe317bbffd639199 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_d]
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
set_property -dict "CONFIG.C_MASK 0x56cb84dc3bce724 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_4_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_4_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_4_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_4_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_4_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_4_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_4_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 4 " [get_bd_cells ip_4_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_4_microblaze/microblaze_0/DEBUG]


########## accumulator ##########
create_bd_cell -type hier ip_5_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_5_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 25 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 45 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_5_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/clk
connect_bd_net [get_bd_pins ip_5_accumulator/clk] [get_bd_pins ip_5_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 24 -to 0 ip_5_accumulator/B
connect_bd_net [get_bd_pins ip_5_accumulator/B] [get_bd_pins ip_5_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 44 -to 0 ip_5_accumulator/Q
connect_bd_net [get_bd_pins ip_5_accumulator/Q] [get_bd_pins ip_5_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/CE
connect_bd_net [get_bd_pins ip_5_accumulator/CE] [get_bd_pins ip_5_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/SCLR
connect_bd_net [get_bd_pins ip_5_accumulator/SCLR] [get_bd_pins ip_5_accumulator/accumulator_0/SCLR]


########## axi_dma ##########
create_bd_cell -type hier ip_6_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_6_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 46 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_6_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_6_axi_dma/axi_resetn] [get_bd_pins ip_6_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_6_axi_dma/mm2s_introut] [get_bd_pins ip_6_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_6_axi_dma/s2mm_introut] [get_bd_pins ip_6_axi_dma/axi_dma_0/s2mm_introut]


########## emc ##########
create_bd_cell -type hier ip_7_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_7_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 0 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 2 CONFIG.C_PARITY_TYPE_MEM_1 2 CONFIG.C_SYNCH_PIPEDELAY_0 1 CONFIG.C_SYNCH_PIPEDELAY_1 1 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 4 " [get_bd_cells ip_7_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_7_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_7_emc/EMC_INTF] [get_bd_intf_pins ip_7_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_7_emc/clk
connect_bd_net [get_bd_pins ip_7_emc/clk] [get_bd_pins ip_7_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_emc/rdclk
connect_bd_net [get_bd_pins ip_7_emc/rdclk] [get_bd_pins ip_7_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_emc/rst
connect_bd_net [get_bd_pins ip_7_emc/rst] [get_bd_pins ip_7_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_emc/AXI] [get_bd_intf_pins ip_7_emc/emc_0/S_AXI_MEM]


########## axi_iic ##########
create_bd_cell -type hier ip_8_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_8_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x56 CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 202 CONFIG.C_SDA_INERTIAL_DELAY 6 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 10.964585844217346 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_8_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_8_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_iic/IIC] [get_bd_intf_pins ip_8_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_iic/clk
connect_bd_net [get_bd_pins ip_8_axi_iic/clk] [get_bd_pins ip_8_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_iic/reset
connect_bd_net [get_bd_pins ip_8_axi_iic/reset] [get_bd_pins ip_8_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_iic/AXI] [get_bd_intf_pins ip_8_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_iic/irq
connect_bd_net [get_bd_pins ip_8_axi_iic/irq] [get_bd_pins ip_8_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_cdma ##########
create_bd_cell -type hier ip_9_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_9_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 55 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 128 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_9_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_9_axi_cdma/m_axi_aclk] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_9_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_9_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_cdma/M_AXI] [get_bd_intf_pins ip_9_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_9_axi_cdma/cdma_introut] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/cdma_introut]


########## uartlite ##########
create_bd_cell -type hier ip_10_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_10_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 1200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY No_Parity " [get_bd_cells ip_10_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_10_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_10_uartlite/UART] [get_bd_intf_pins ip_10_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_10_uartlite/clk
connect_bd_net [get_bd_pins ip_10_uartlite/clk] [get_bd_pins ip_10_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_uartlite/reset
connect_bd_net [get_bd_pins ip_10_uartlite/reset] [get_bd_pins ip_10_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_uartlite/AXI] [get_bd_intf_pins ip_10_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_10_uartlite/irq
connect_bd_net [get_bd_pins ip_10_uartlite/irq] [get_bd_pins ip_10_uartlite/uart_0/interrupt]


########## xadc_wiz ##########
create_bd_cell -type hier ip_11_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_11_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_TEMP_BUS 1 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_11_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_11_xadc_wiz/s_axi_aclk] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_11_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_11_xadc_wiz/convstclk_in] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_11_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/eoc_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/eos_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/busy_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_11_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_11_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_11_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 11 -to 0 ip_11_xadc_wiz/temp_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/temp_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/temp_out]


########## emc ##########
create_bd_cell -type hier ip_12_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_12_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_MEM1_TYPE 2 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 14 CONFIG.C_TAVDV_PS_MEM_0 16159 CONFIG.C_TAVDV_PS_MEM_1 15597 CONFIG.C_TCEDV_PS_MEM_0 15708 CONFIG.C_TCEDV_PS_MEM_1 14423 CONFIG.C_THZCE_PS_MEM_0 6816 CONFIG.C_THZCE_PS_MEM_1 7530 CONFIG.C_THZOE_PS_MEM_0 6899 CONFIG.C_THZOE_PS_MEM_1 7199 CONFIG.C_TLZWE_PS_MEM_0 7328 CONFIG.C_TLZWE_PS_MEM_1 7739 CONFIG.C_TWC_PS_MEM_0 15550 CONFIG.C_TWC_PS_MEM_1 16069 CONFIG.C_TWPH_PS_MEM_0 11498 CONFIG.C_TWPH_PS_MEM_1 11592 CONFIG.C_TWP_PS_MEM_0 12852 CONFIG.C_TWP_PS_MEM_1 12731 CONFIG.C_WR_REC_TIME_MEM_0 28779 CONFIG.C_WR_REC_TIME_MEM_1 29158 " [get_bd_cells ip_12_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_12_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_12_emc/EMC_INTF] [get_bd_intf_pins ip_12_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_12_emc/clk
connect_bd_net [get_bd_pins ip_12_emc/clk] [get_bd_pins ip_12_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_emc/rdclk
connect_bd_net [get_bd_pins ip_12_emc/rdclk] [get_bd_pins ip_12_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_emc/rst
connect_bd_net [get_bd_pins ip_12_emc/rst] [get_bd_pins ip_12_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_emc/AXI] [get_bd_intf_pins ip_12_emc/emc_0/S_AXI_MEM]


########## axi_cdma ##########
create_bd_cell -type hier ip_13_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_13_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 36 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 256 CONFIG.C_M_AXI_MAX_BURST_LEN 8 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_13_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_13_axi_cdma/m_axi_aclk] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_13_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_13_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_cdma/M_AXI] [get_bd_intf_pins ip_13_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_13_axi_cdma/cdma_introut] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/cdma_introut]


########## cordic ##########
create_bd_cell -type hier ip_14_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_14_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sinh_and_Cosh CONFIG.Input_Width 47 CONFIG.Iterations 20 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 29 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode No_Pipelining CONFIG.Precision 42 CONFIG.Round_Mode Truncate " [get_bd_cells ip_14_cordic/cordic_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_14_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_14_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_14_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_14_cordic/cordic_0/M_AXIS_DOUT]


########## dft ##########
create_bd_cell -type hier ip_15_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_15_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 9 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_15_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_dft/CLK
connect_bd_net [get_bd_pins ip_15_dft/CLK] [get_bd_pins ip_15_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_15_dft/CE
connect_bd_net [get_bd_pins ip_15_dft/CE] [get_bd_pins ip_15_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_15_dft/SCLR
connect_bd_net [get_bd_pins ip_15_dft/SCLR] [get_bd_pins ip_15_dft/dft_0/SCLR]
create_bd_pin -dir I -from 8 -to 0 ip_15_dft/XN_RE
connect_bd_net [get_bd_pins ip_15_dft/XN_RE] [get_bd_pins ip_15_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 8 -to 0 ip_15_dft/XN_IM
connect_bd_net [get_bd_pins ip_15_dft/XN_IM] [get_bd_pins ip_15_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_15_dft/FD_IN
connect_bd_net [get_bd_pins ip_15_dft/FD_IN] [get_bd_pins ip_15_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_15_dft/FWD_INV
connect_bd_net [get_bd_pins ip_15_dft/FWD_INV] [get_bd_pins ip_15_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_15_dft/SIZE
connect_bd_net [get_bd_pins ip_15_dft/SIZE] [get_bd_pins ip_15_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_15_dft/RFFD
connect_bd_net [get_bd_pins ip_15_dft/RFFD] [get_bd_pins ip_15_dft/dft_0/RFFD]
create_bd_pin -dir O -from 8 -to 0 ip_15_dft/XK_RE
connect_bd_net [get_bd_pins ip_15_dft/XK_RE] [get_bd_pins ip_15_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 8 -to 0 ip_15_dft/XK_IM
connect_bd_net [get_bd_pins ip_15_dft/XK_IM] [get_bd_pins ip_15_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_15_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_15_dft/BLK_EXP] [get_bd_pins ip_15_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_15_dft/FD_OUT
connect_bd_net [get_bd_pins ip_15_dft/FD_OUT] [get_bd_pins ip_15_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_15_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_15_dft/DATA_VALID] [get_bd_pins ip_15_dft/dft_0/DATA_VALID]


########## axi_cdma ##########
create_bd_cell -type hier ip_16_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_16_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 63 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_16_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_16_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_16_axi_cdma/m_axi_aclk] [get_bd_pins ip_16_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_16_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_16_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_16_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_16_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_cdma/M_AXI] [get_bd_intf_pins ip_16_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_16_axi_cdma/cdma_introut] [get_bd_pins ip_16_axi_cdma/axi_cdma_0/cdma_introut]


########## gpio ##########
create_bd_cell -type hier ip_17_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_17_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_GPIO_WIDTH 5 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_17_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/GPIO] [get_bd_intf_pins ip_17_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_17_gpio/clk
connect_bd_net [get_bd_pins ip_17_gpio/clk] [get_bd_pins ip_17_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_gpio/rst
connect_bd_net [get_bd_pins ip_17_gpio/rst] [get_bd_pins ip_17_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/AXI] [get_bd_intf_pins ip_17_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_17_gpio/irq
connect_bd_net [get_bd_pins ip_17_gpio/irq] [get_bd_pins ip_17_gpio/gpio_0/ip2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_18_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_18_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Translate CONFIG.Input_Width 16 CONFIG.Iterations 41 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 8 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 16 CONFIG.Round_Mode Truncate " [get_bd_cells ip_18_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_cordic/aclk
connect_bd_net [get_bd_pins ip_18_cordic/aclk] [get_bd_pins ip_18_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_cordic/aclken
connect_bd_net [get_bd_pins ip_18_cordic/aclken] [get_bd_pins ip_18_cordic/cordic_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_18_cordic/aresetn
connect_bd_net [get_bd_pins ip_18_cordic/aresetn] [get_bd_pins ip_18_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_18_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_18_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_18_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_18_cordic/cordic_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_19_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_19_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 4 CONFIG.C_TAVDV_PS_MEM_0 15659 CONFIG.C_TCEDV_PS_MEM_0 15786 CONFIG.C_THZCE_PS_MEM_0 6667 CONFIG.C_THZOE_PS_MEM_0 7098 CONFIG.C_TLZWE_PS_MEM_0 4225 CONFIG.C_TWC_PS_MEM_0 13668 CONFIG.C_TWPH_PS_MEM_0 12820 CONFIG.C_TWP_PS_MEM_0 12247 CONFIG.C_WR_REC_TIME_MEM_0 29564 " [get_bd_cells ip_19_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_19_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_19_emc/EMC_INTF] [get_bd_intf_pins ip_19_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_19_emc/clk
connect_bd_net [get_bd_pins ip_19_emc/clk] [get_bd_pins ip_19_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_emc/rdclk
connect_bd_net [get_bd_pins ip_19_emc/rdclk] [get_bd_pins ip_19_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_emc/rst
connect_bd_net [get_bd_pins ip_19_emc/rst] [get_bd_pins ip_19_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_emc/AXI] [get_bd_intf_pins ip_19_emc/emc_0/S_AXI_MEM]


########## axi_dma ##########
create_bd_cell -type hier ip_20_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_20_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 45 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_20_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_20_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_20_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_20_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_20_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_20_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_20_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_20_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_20_axi_dma/axi_resetn] [get_bd_pins ip_20_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_20_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_20_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_20_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_20_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_20_axi_dma/mm2s_introut] [get_bd_pins ip_20_axi_dma/axi_dma_0/mm2s_introut]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_21_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_21_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_21_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_21_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_ethernet_lite/MII] [get_bd_intf_pins ip_21_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_21_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_21_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_21_axi_ethernet_lite/clk] [get_bd_pins ip_21_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_21_axi_ethernet_lite/reset] [get_bd_pins ip_21_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_21_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_21_axi_ethernet_lite/irq] [get_bd_pins ip_21_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_22_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_22_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x18ba5a CONFIG.C_DOUT_DEFAULT_2 0x0 CONFIG.C_GPIO2_WIDTH 4 CONFIG.C_GPIO_WIDTH 21 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0xe91e6 CONFIG.C_TRI_DEFAULT_2 0x0 " [get_bd_cells ip_22_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_22_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_22_gpio/GPIO] [get_bd_intf_pins ip_22_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_22_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_22_gpio/GPIO2] [get_bd_intf_pins ip_22_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_22_gpio/clk
connect_bd_net [get_bd_pins ip_22_gpio/clk] [get_bd_pins ip_22_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_gpio/rst
connect_bd_net [get_bd_pins ip_22_gpio/rst] [get_bd_pins ip_22_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_22_gpio/AXI] [get_bd_intf_pins ip_22_gpio/gpio_0/S_AXI]


########## reset ##########
create_bd_cell -type hier ip_23_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_23_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_reset/clk_in
connect_bd_net [get_bd_pins ip_23_reset/clk_in] [get_bd_pins ip_23_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_23_reset/reset_in
connect_bd_net [get_bd_pins ip_23_reset/reset_in] [get_bd_pins ip_23_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_23_reset/dcm_locked
connect_bd_net [get_bd_pins ip_23_reset/dcm_locked] [get_bd_pins ip_23_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_23_reset/mb_reset
connect_bd_net [get_bd_pins ip_23_reset/mb_reset] [get_bd_pins ip_23_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_23_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_23_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_23_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset] [get_bd_pins ip_23_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_23_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_23_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_24_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_24_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_in] [get_bd_pins ip_24_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_24_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_24_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_24_clk_wiz/reset
connect_bd_net [get_bd_pins ip_24_clk_wiz/reset] [get_bd_pins ip_24_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_24_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_locked] [get_bd_pins ip_24_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_25_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_25_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_25_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 14 " [get_bd_cells ip_25_intc/concat_0]
connect_bd_net [get_bd_pins ip_25_intc/concat_0/dout] [get_bd_pins ip_25_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/clk
connect_bd_net [get_bd_pins ip_25_intc/clk] [get_bd_pins ip_25_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/reset
connect_bd_net [get_bd_pins ip_25_intc/reset] [get_bd_pins ip_25_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_25_intc/AXI] [get_bd_intf_pins ip_25_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_0
connect_bd_net [get_bd_pins ip_25_intc/irq_0] [get_bd_pins ip_25_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_1
connect_bd_net [get_bd_pins ip_25_intc/irq_1] [get_bd_pins ip_25_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_2
connect_bd_net [get_bd_pins ip_25_intc/irq_2] [get_bd_pins ip_25_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_3
connect_bd_net [get_bd_pins ip_25_intc/irq_3] [get_bd_pins ip_25_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_4
connect_bd_net [get_bd_pins ip_25_intc/irq_4] [get_bd_pins ip_25_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_5
connect_bd_net [get_bd_pins ip_25_intc/irq_5] [get_bd_pins ip_25_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_6
connect_bd_net [get_bd_pins ip_25_intc/irq_6] [get_bd_pins ip_25_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_7
connect_bd_net [get_bd_pins ip_25_intc/irq_7] [get_bd_pins ip_25_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_8
connect_bd_net [get_bd_pins ip_25_intc/irq_8] [get_bd_pins ip_25_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_9
connect_bd_net [get_bd_pins ip_25_intc/irq_9] [get_bd_pins ip_25_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_10
connect_bd_net [get_bd_pins ip_25_intc/irq_10] [get_bd_pins ip_25_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_11
connect_bd_net [get_bd_pins ip_25_intc/irq_11] [get_bd_pins ip_25_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_12
connect_bd_net [get_bd_pins ip_25_intc/irq_12] [get_bd_pins ip_25_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_13
connect_bd_net [get_bd_pins ip_25_intc/irq_13] [get_bd_pins ip_25_intc/concat_0/In13]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_25_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_25_intc/irq] [get_bd_intf_pins ip_25_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_26_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_26_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 9 " [get_bd_cells ip_26_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi/clk
connect_bd_net [get_bd_pins ip_26_axi/clk] [get_bd_pins ip_26_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi/reset
connect_bd_net [get_bd_pins ip_26_axi/reset] [get_bd_pins ip_26_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M0] [get_bd_intf_pins ip_26_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M1] [get_bd_intf_pins ip_26_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M2] [get_bd_intf_pins ip_26_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M3] [get_bd_intf_pins ip_26_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M4] [get_bd_intf_pins ip_26_axi/axi_0/S04_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M5] [get_bd_intf_pins ip_26_axi/axi_0/S05_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M6
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M6] [get_bd_intf_pins ip_26_axi/axi_0/S06_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M7
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M7] [get_bd_intf_pins ip_26_axi/axi_0/S07_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M8
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M8] [get_bd_intf_pins ip_26_axi/axi_0/S08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S0] [get_bd_intf_pins ip_26_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S1] [get_bd_intf_pins ip_26_axi/axi_0/M01_AXI]


########## axi ##########
create_bd_cell -type hier ip_27_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_27_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_27_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axi/clk
connect_bd_net [get_bd_pins ip_27_axi/clk] [get_bd_pins ip_27_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axi/reset
connect_bd_net [get_bd_pins ip_27_axi/reset] [get_bd_pins ip_27_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_M0] [get_bd_intf_pins ip_27_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S0] [get_bd_intf_pins ip_27_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S1] [get_bd_intf_pins ip_27_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S2] [get_bd_intf_pins ip_27_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S3] [get_bd_intf_pins ip_27_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S4] [get_bd_intf_pins ip_27_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S5] [get_bd_intf_pins ip_27_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S6] [get_bd_intf_pins ip_27_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S7] [get_bd_intf_pins ip_27_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S8] [get_bd_intf_pins ip_27_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S9] [get_bd_intf_pins ip_27_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S10] [get_bd_intf_pins ip_27_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S11] [get_bd_intf_pins ip_27_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S12] [get_bd_intf_pins ip_27_axi/axi_0/M12_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S13] [get_bd_intf_pins ip_27_axi/axi_0/M13_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S14] [get_bd_intf_pins ip_27_axi/axi_0/M14_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S15] [get_bd_intf_pins ip_27_axi/axi_0/M15_AXI]


########## axi ##########
create_bd_cell -type hier ip_28_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_28_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 1 CONFIG.NUM_SI 1 " [get_bd_cells ip_28_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axi/clk
connect_bd_net [get_bd_pins ip_28_axi/clk] [get_bd_pins ip_28_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axi/reset
connect_bd_net [get_bd_pins ip_28_axi/reset] [get_bd_pins ip_28_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_28_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_28_axi/AXI_M0] [get_bd_intf_pins ip_28_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_28_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_28_axi/AXI_S0] [get_bd_intf_pins ip_28_axi/axi_0/M00_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_29_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_29_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_29_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_29_axis_broadcaster/aclk] [get_bd_pins ip_29_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_29_axis_broadcaster/aresetn] [get_bd_pins ip_29_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_30_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_30_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aclk] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aresetn] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_31_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_31_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_31_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aclk] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aresetn] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_32_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_32_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aclk] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aresetn] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_33_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_33_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 20 " [get_bd_cells ip_33_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aclk] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aresetn] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_34_reduce
create_bd_pin -dir I -from 34 -to 0 ip_34_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_34_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_34_reduce/concat]
connect_bd_net [get_bd_pins ip_34_reduce/out0] [get_bd_pins ip_34_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_0]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_34_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_34_reduce/slice_0/dout] [get_bd_pins ip_34_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_0/Res] [get_bd_pins ip_34_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_1]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_34_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_34_reduce/slice_1/dout] [get_bd_pins ip_34_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_1/Res] [get_bd_pins ip_34_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_2]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_34_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_34_reduce/slice_2/dout] [get_bd_pins ip_34_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_2/Res] [get_bd_pins ip_34_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_3]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_34_reduce/slice_3/dout] [get_bd_pins ip_34_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_3/Res] [get_bd_pins ip_34_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_4]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_34_reduce/slice_4/dout] [get_bd_pins ip_34_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_4/Res] [get_bd_pins ip_34_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_5]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_34_reduce/slice_5/dout] [get_bd_pins ip_34_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_5/Res] [get_bd_pins ip_34_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_6]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_34_reduce/slice_6/dout] [get_bd_pins ip_34_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_6/Res] [get_bd_pins ip_34_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_7]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_34_reduce/slice_7/dout] [get_bd_pins ip_34_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_7/Res] [get_bd_pins ip_34_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 11 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_8]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_34_reduce/slice_8/dout] [get_bd_pins ip_34_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_8/Res] [get_bd_pins ip_34_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_9]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_34_reduce/slice_9/dout] [get_bd_pins ip_34_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_9/Res] [get_bd_pins ip_34_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 13 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_10]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_34_reduce/slice_10/dout] [get_bd_pins ip_34_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_10/Res] [get_bd_pins ip_34_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 14 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_11]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_34_reduce/slice_11/dout] [get_bd_pins ip_34_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_11/Res] [get_bd_pins ip_34_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_12]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_34_reduce/slice_12/dout] [get_bd_pins ip_34_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_12/Res] [get_bd_pins ip_34_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_13]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_34_reduce/slice_13/dout] [get_bd_pins ip_34_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_13/Res] [get_bd_pins ip_34_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 17 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_14]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_34_reduce/slice_14/dout] [get_bd_pins ip_34_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_14/Res] [get_bd_pins ip_34_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 18 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_15]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_34_reduce/slice_15/dout] [get_bd_pins ip_34_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_15/Res] [get_bd_pins ip_34_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 19 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_16]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_34_reduce/slice_16/dout] [get_bd_pins ip_34_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_16/Res] [get_bd_pins ip_34_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 20 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_17]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_34_reduce/slice_17/dout] [get_bd_pins ip_34_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_17/Res] [get_bd_pins ip_34_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 21 CONFIG.DIN_TO 21 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_18]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_34_reduce/slice_18/dout] [get_bd_pins ip_34_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_18/Res] [get_bd_pins ip_34_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 22 CONFIG.DIN_TO 22 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_19]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_34_reduce/slice_19/dout] [get_bd_pins ip_34_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_19/Res] [get_bd_pins ip_34_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 23 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_20]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_34_reduce/slice_20/dout] [get_bd_pins ip_34_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_20/Res] [get_bd_pins ip_34_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 24 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_21]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_34_reduce/slice_21/dout] [get_bd_pins ip_34_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_21/Res] [get_bd_pins ip_34_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 25 CONFIG.DIN_TO 25 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_22]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_34_reduce/slice_22/dout] [get_bd_pins ip_34_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_22/Res] [get_bd_pins ip_34_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 26 CONFIG.DIN_TO 26 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_23]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_34_reduce/slice_23/dout] [get_bd_pins ip_34_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_23/Res] [get_bd_pins ip_34_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 27 CONFIG.DIN_TO 27 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_24]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_34_reduce/slice_24/dout] [get_bd_pins ip_34_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_24/Res] [get_bd_pins ip_34_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 28 CONFIG.DIN_TO 28 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_25]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_34_reduce/slice_25/dout] [get_bd_pins ip_34_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_25/Res] [get_bd_pins ip_34_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 29 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_26]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_34_reduce/slice_26/dout] [get_bd_pins ip_34_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_26/Res] [get_bd_pins ip_34_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_27]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_34_reduce/slice_27/dout] [get_bd_pins ip_34_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_27/Res] [get_bd_pins ip_34_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_28]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_34_reduce/slice_28/dout] [get_bd_pins ip_34_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_28/Res] [get_bd_pins ip_34_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_29]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_34_reduce/slice_29/dout] [get_bd_pins ip_34_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_29/Res] [get_bd_pins ip_34_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 33 CONFIG.DIN_TO 33 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_30]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_34_reduce/slice_30/dout] [get_bd_pins ip_34_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_30/Res] [get_bd_pins ip_34_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 34 CONFIG.DIN_TO 34 CONFIG.DIN_WIDTH 35 " [get_bd_cells ip_34_reduce/slice_31]
connect_bd_net [get_bd_pins ip_34_reduce/in0] [get_bd_pins ip_34_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_34_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_34_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_34_reduce/slice_31/dout] [get_bd_pins ip_34_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_34_reduce/reduce_31/Res] [get_bd_pins ip_34_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 44 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 45 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 34 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 44 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 43 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 45 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_37_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_37_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 44 -to 0 ip_37_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 44 CONFIG.DIN_WIDTH 45 " [get_bd_cells ip_37_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/slice_0/dout] [get_bd_pins ip_37_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_1] [get_bd_pins ip_37_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_2] [get_bd_pins ip_37_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_3] [get_bd_pins ip_37_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 11 -to 0 ip_37_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_37_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_4] [get_bd_pins ip_37_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/slice_4/dout] [get_bd_pins ip_37_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 11 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 24 -to 0 ip_39_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_39_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_39_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_39_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_39_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/slice_0/dout] [get_bd_pins ip_39_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_1] [get_bd_pins ip_39_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 8 -to 0 ip_39_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_2] [get_bd_pins ip_39_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 8 -to 0 ip_39_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_39_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_3] [get_bd_pins ip_39_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/slice_3/dout] [get_bd_pins ip_39_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_40_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_40_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_40_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_40_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_40_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/slice_0/dout] [get_bd_pins ip_40_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_40_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_1] [get_bd_pins ip_40_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_2] [get_bd_pins ip_40_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_3] [get_bd_pins ip_40_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_41_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_42_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_42_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_43_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_0


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

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_23_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_24_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_1_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap_ICAP] [get_bd_intf_pins ip_1_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_1_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_1_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio_GPIO] [get_bd_intf_pins ip_2_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_7_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_7_emc_EMC_INTF] [get_bd_intf_pins ip_7_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_8_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_iic_IIC] [get_bd_intf_pins ip_8_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_10_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_10_uartlite_UART] [get_bd_intf_pins ip_10_uartlite/UART]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_11_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_11_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_11_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_12_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_12_emc_EMC_INTF] [get_bd_intf_pins ip_12_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio_GPIO] [get_bd_intf_pins ip_17_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_19_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_19_emc_EMC_INTF] [get_bd_intf_pins ip_19_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_21_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_ethernet_lite_MII] [get_bd_intf_pins ip_21_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_21_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_21_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_22_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_22_gpio_GPIO] [get_bd_intf_pins ip_22_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_22_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_22_gpio_GPIO2] [get_bd_intf_pins ip_22_gpio/GPIO2]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_34_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_41_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_24_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_25_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_2_gpio/rst]
connect_bd_net [get_bd_pins ip_23_reset/mb_reset] [get_bd_pins ip_4_microblaze/Reset]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_7_emc/rst]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_iic/reset]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_10_uartlite/reset]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_11_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_12_emc/rst]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset] [get_bd_pins ip_15_dft/SCLR]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_17_gpio/rst]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_18_cordic/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_19_emc/rst]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_20_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_21_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_22_gpio/rst]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_2_gpio/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_3_fft/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_4_microblaze/Clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_5_accumulator/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_7_emc/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_7_emc/rdclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_8_axi_iic/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_10_uartlite/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_11_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_11_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_12_emc/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_12_emc/rdclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_13_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_13_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_15_dft/CLK]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_16_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_16_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_17_gpio/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_18_cordic/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_19_emc/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_19_emc/rdclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_20_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_20_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_20_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_21_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_22_gpio/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_23_reset/clk_in]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_locked] [get_bd_pins ip_23_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_25_intc/irq_0] [get_bd_pins ip_0_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_25_intc/irq_1] [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_25_intc/irq_2] [get_bd_pins ip_3_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_25_intc/irq_3] [get_bd_pins ip_6_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_25_intc/irq_4] [get_bd_pins ip_6_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_25_intc/irq_5] [get_bd_pins ip_8_axi_iic/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_6] [get_bd_pins ip_9_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_25_intc/irq_7] [get_bd_pins ip_10_uartlite/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_8] [get_bd_pins ip_11_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_25_intc/irq_9] [get_bd_pins ip_13_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_25_intc/irq_10] [get_bd_pins ip_16_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_25_intc/irq_11] [get_bd_pins ip_17_gpio/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_12] [get_bd_pins ip_20_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_25_intc/irq_13] [get_bd_pins ip_21_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/INTERRUPT] [get_bd_intf_pins ip_25_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/M_AXI] [get_bd_intf_pins ip_26_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/M_AXI_DP] [get_bd_intf_pins ip_26_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_26_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_26_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/M_AXI] [get_bd_intf_pins ip_26_axi/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_cdma/M_AXI] [get_bd_intf_pins ip_26_axi/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_cdma/M_AXI] [get_bd_intf_pins ip_26_axi/AXI_M6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_26_axi/AXI_M7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_26_axi/AXI_M8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axi/AXI_S0] [get_bd_intf_pins ip_27_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_27_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_27_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_27_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_27_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_emc/AXI] [get_bd_intf_pins ip_27_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_iic/AXI] [get_bd_intf_pins ip_27_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_27_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_uartlite/AXI] [get_bd_intf_pins ip_27_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_emc/AXI] [get_bd_intf_pins ip_27_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_27_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_27_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_gpio/AXI] [get_bd_intf_pins ip_27_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_emc/AXI] [get_bd_intf_pins ip_27_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_27_axi/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_27_axi/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_gpio/AXI] [get_bd_intf_pins ip_27_axi/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axi/AXI_S1] [get_bd_intf_pins ip_28_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_intc/AXI] [get_bd_intf_pins ip_28_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_29_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_15_dft/XN_IM]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_34_reduce/in0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_15_dft/SIZE]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_1] [get_bd_pins ip_11_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_2] [get_bd_pins ip_11_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_3] [get_bd_pins ip_11_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_4] [get_bd_pins ip_11_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_1_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/B]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_1] [get_bd_pins ip_15_dft/RFFD]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_2] [get_bd_pins ip_15_dft/XK_RE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_3] [get_bd_pins ip_15_dft/XK_IM]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_15_dft/XN_RE]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_15_dft/XK_IM]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_1] [get_bd_pins ip_15_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_2] [get_bd_pins ip_15_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_3] [get_bd_pins ip_15_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_15_dft/CE]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_15_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/CE]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_18_cordic/aclken]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_15_dft/FD_IN]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_26_axi/reset]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_27_axi/reset]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_28_axi/reset]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_25_intc/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_26_axi/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_27_axi/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_28_axi/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_29_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_33_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 23 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=23 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=23 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_cordic/S_AXIS_CARTESIAN declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_cordic/S_AXIS_CARTESIAN declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_cordic/M_AXIS_DOUT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_cordic/M_AXIS_DOUT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
