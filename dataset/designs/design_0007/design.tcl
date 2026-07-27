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



########## gpio ##########
create_bd_cell -type hier ip_0_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_0_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 3 CONFIG.C_GPIO_WIDTH 21 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_0_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO2] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/clk
connect_bd_net [get_bd_pins ip_0_gpio/clk] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/rst
connect_bd_net [get_bd_pins ip_0_gpio/rst] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_0_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_gpio/irq
connect_bd_net [get_bd_pins ip_0_gpio/irq] [get_bd_pins ip_0_gpio/gpio_0/ip2intc_irpt]


########## conv_encoder ##########
create_bd_cell -type hier ip_1_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_1_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 7 CONFIG.convolution_code0 13 CONFIG.convolution_code1 15 CONFIG.convolution_code2 44 CONFIG.convolution_code3 1 CONFIG.convolution_code4 2 CONFIG.convolution_code5 40 CONFIG.convolution_code6 117 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 10 CONFIG.output_rate 17 CONFIG.puncture_code0 0111111110 CONFIG.puncture_code1 0111111111 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_1_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_1_conv_encoder/aclk] [get_bd_pins ip_1_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_1_conv_encoder/aresetn] [get_bd_pins ip_1_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_1_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_1_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## cordic ##########
create_bd_cell -type hier ip_2_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_2_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Translate CONFIG.Input_Width 45 CONFIG.Iterations 25 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 16 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 24 CONFIG.Round_Mode Truncate " [get_bd_cells ip_2_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_cordic/aclk
connect_bd_net [get_bd_pins ip_2_cordic/aclk] [get_bd_pins ip_2_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]


########## conv_encoder ##########
create_bd_cell -type hier ip_3_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_3_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 9 CONFIG.convolution_code0 205 CONFIG.convolution_code1 454 CONFIG.convolution_code2 488 CONFIG.convolution_code3 448 CONFIG.convolution_code4 32 CONFIG.convolution_code5 115 CONFIG.convolution_code6 289 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 7 CONFIG.output_rate 13 CONFIG.puncture_code0 1111110 CONFIG.puncture_code1 1111111 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_3_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_3_conv_encoder/aclk] [get_bd_pins ip_3_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_3_conv_encoder/aresetn] [get_bd_pins ip_3_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## microblaze ##########
create_bd_cell -type hier ip_4_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 32 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 2 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 0 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 1 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 0 CONFIG.C_OPCODE_0x0_ILLEGAL 1 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0xe9 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 0 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 0 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_4_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_MASK 0x6d777d6f83dd0ef CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_d]
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
set_property -dict "CONFIG.C_MASK 0x2d6ec35f189cc08 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_i]
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
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 2 " [get_bd_cells ip_4_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_4_microblaze/microblaze_0/DEBUG]


########## axi_dma ##########
create_bd_cell -type hier ip_5_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_5_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 62 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_5_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_5_axi_dma/axi_resetn] [get_bd_pins ip_5_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_5_axi_dma/mm2s_introut] [get_bd_pins ip_5_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_5_axi_dma/s2mm_introut] [get_bd_pins ip_5_axi_dma/axi_dma_0/s2mm_introut]


########## xadc_wiz ##########
create_bd_cell -type hier ip_6_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_6_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_TEMP_BUS 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_6_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_6_xadc_wiz/s_axi_aclk] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_6_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_6_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/ot_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/eoc_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/eos_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/alarm_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/busy_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_6_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_6_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_6_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 11 -to 0 ip_6_xadc_wiz/temp_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/temp_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/temp_out]


########## axi_iic ##########
create_bd_cell -type hier ip_7_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_7_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x17 CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 117 CONFIG.C_SDA_INERTIAL_DELAY 248 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 93.98852555824728 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_7_axi_iic/axi_iic_0]
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


########## conv_encoder ##########
create_bd_cell -type hier ip_8_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_8_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 5 CONFIG.convolution_code0 27 CONFIG.convolution_code1 21 CONFIG.convolution_code2 3 CONFIG.convolution_code3 17 CONFIG.convolution_code4 0 CONFIG.convolution_code5 10 CONFIG.convolution_code6 22 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 5 CONFIG.output_rate 6 CONFIG.puncture_code0 01101 CONFIG.puncture_code1 10101 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_8_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_8_conv_encoder/aclk] [get_bd_pins ip_8_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_8_conv_encoder/aclken] [get_bd_pins ip_8_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_8_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_8_conv_encoder/aresetn] [get_bd_pins ip_8_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## emc ##########
create_bd_cell -type hier ip_9_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_9_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 8 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 7 CONFIG.C_TAVDV_PS_MEM_0 16446 CONFIG.C_TAVDV_PS_MEM_1 14683 CONFIG.C_TCEDV_PS_MEM_0 14545 CONFIG.C_TCEDV_PS_MEM_1 14674 CONFIG.C_THZCE_PS_MEM_0 7297 CONFIG.C_THZCE_PS_MEM_1 6836 CONFIG.C_THZOE_PS_MEM_0 7462 CONFIG.C_THZOE_PS_MEM_1 7473 CONFIG.C_TLZWE_PS_MEM_0 6808 CONFIG.C_TLZWE_PS_MEM_1 9801 CONFIG.C_TWC_PS_MEM_0 13581 CONFIG.C_TWC_PS_MEM_1 14391 CONFIG.C_TWPH_PS_MEM_0 11505 CONFIG.C_TWPH_PS_MEM_1 11350 CONFIG.C_TWP_PS_MEM_0 12849 CONFIG.C_TWP_PS_MEM_1 13129 CONFIG.C_WR_REC_TIME_MEM_0 27054 CONFIG.C_WR_REC_TIME_MEM_1 25351 " [get_bd_cells ip_9_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_9_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_9_emc/EMC_INTF] [get_bd_intf_pins ip_9_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_9_emc/clk
connect_bd_net [get_bd_pins ip_9_emc/clk] [get_bd_pins ip_9_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_emc/rdclk
connect_bd_net [get_bd_pins ip_9_emc/rdclk] [get_bd_pins ip_9_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_emc/rst
connect_bd_net [get_bd_pins ip_9_emc/rst] [get_bd_pins ip_9_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_emc/AXI] [get_bd_intf_pins ip_9_emc/emc_0/S_AXI_MEM]


########## axi_cdma ##########
create_bd_cell -type hier ip_10_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_10_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 40 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 256 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_10_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_10_axi_cdma/m_axi_aclk] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_10_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_10_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_cdma/M_AXI] [get_bd_intf_pins ip_10_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_10_axi_cdma/cdma_introut] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_11_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_11_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_11_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_11_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite/MII] [get_bd_intf_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_11_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_11_axi_ethernet_lite/clk] [get_bd_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_11_axi_ethernet_lite/reset] [get_bd_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_11_axi_ethernet_lite/irq] [get_bd_pins ip_11_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_12_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_12_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x5 CONFIG.C_DOUT_DEFAULT_2 0x1 CONFIG.C_GPIO2_WIDTH 13 CONFIG.C_GPIO_WIDTH 3 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_12_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/GPIO] [get_bd_intf_pins ip_12_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/GPIO2] [get_bd_intf_pins ip_12_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/clk
connect_bd_net [get_bd_pins ip_12_gpio/clk] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/rst
connect_bd_net [get_bd_pins ip_12_gpio/rst] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_12_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_gpio/irq
connect_bd_net [get_bd_pins ip_12_gpio/irq] [get_bd_pins ip_12_gpio/gpio_0/ip2intc_irpt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_13_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_13_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 16 CONFIG.aresetn 1 CONFIG.bportwidth 47 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Performance CONFIG.outputwidth 57 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_13_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_13_complex_multiplier/aclk] [get_bd_pins ip_13_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_13_complex_multiplier/aresetn] [get_bd_pins ip_13_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_iic ##########
create_bd_cell -type hier ip_14_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_14_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x10 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 195 CONFIG.C_SDA_INERTIAL_DELAY 130 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 906.1146418327631 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_14_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_14_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_iic/IIC] [get_bd_intf_pins ip_14_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_iic/clk
connect_bd_net [get_bd_pins ip_14_axi_iic/clk] [get_bd_pins ip_14_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_iic/reset
connect_bd_net [get_bd_pins ip_14_axi_iic/reset] [get_bd_pins ip_14_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_iic/AXI] [get_bd_intf_pins ip_14_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_iic/irq
connect_bd_net [get_bd_pins ip_14_axi_iic/irq] [get_bd_pins ip_14_axi_iic/axi_iic_0/iic2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_15_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_15_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Sinh_and_Cosh CONFIG.Input_Width 21 CONFIG.Iterations 11 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 47 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 48 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_15_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_cordic/aclk
connect_bd_net [get_bd_pins ip_15_cordic/aclk] [get_bd_pins ip_15_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_15_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_15_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_15_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_15_cordic/cordic_0/M_AXIS_DOUT]


########## reset ##########
create_bd_cell -type hier ip_16_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_16_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_reset/clk_in
connect_bd_net [get_bd_pins ip_16_reset/clk_in] [get_bd_pins ip_16_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_16_reset/reset_in
connect_bd_net [get_bd_pins ip_16_reset/reset_in] [get_bd_pins ip_16_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_16_reset/dcm_locked
connect_bd_net [get_bd_pins ip_16_reset/dcm_locked] [get_bd_pins ip_16_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_16_reset/mb_reset
connect_bd_net [get_bd_pins ip_16_reset/mb_reset] [get_bd_pins ip_16_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_16_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_16_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_16_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset] [get_bd_pins ip_16_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_16_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_16_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_17_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_17_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_in] [get_bd_pins ip_17_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_17_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_17_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_17_clk_wiz/reset
connect_bd_net [get_bd_pins ip_17_clk_wiz/reset] [get_bd_pins ip_17_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_17_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_locked] [get_bd_pins ip_17_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_18_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_18_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_18_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 9 " [get_bd_cells ip_18_intc/concat_0]
connect_bd_net [get_bd_pins ip_18_intc/concat_0/dout] [get_bd_pins ip_18_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/clk
connect_bd_net [get_bd_pins ip_18_intc/clk] [get_bd_pins ip_18_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/reset
connect_bd_net [get_bd_pins ip_18_intc/reset] [get_bd_pins ip_18_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_intc/AXI] [get_bd_intf_pins ip_18_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_0
connect_bd_net [get_bd_pins ip_18_intc/irq_0] [get_bd_pins ip_18_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_1
connect_bd_net [get_bd_pins ip_18_intc/irq_1] [get_bd_pins ip_18_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_2
connect_bd_net [get_bd_pins ip_18_intc/irq_2] [get_bd_pins ip_18_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_3
connect_bd_net [get_bd_pins ip_18_intc/irq_3] [get_bd_pins ip_18_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_4
connect_bd_net [get_bd_pins ip_18_intc/irq_4] [get_bd_pins ip_18_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_5
connect_bd_net [get_bd_pins ip_18_intc/irq_5] [get_bd_pins ip_18_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_6
connect_bd_net [get_bd_pins ip_18_intc/irq_6] [get_bd_pins ip_18_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_7
connect_bd_net [get_bd_pins ip_18_intc/irq_7] [get_bd_pins ip_18_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_8
connect_bd_net [get_bd_pins ip_18_intc/irq_8] [get_bd_pins ip_18_intc/concat_0/In8]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_18_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_18_intc/irq] [get_bd_intf_pins ip_18_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_19_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_19_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 9 CONFIG.NUM_SI 3 " [get_bd_cells ip_19_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi/clk
connect_bd_net [get_bd_pins ip_19_axi/clk] [get_bd_pins ip_19_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi/reset
connect_bd_net [get_bd_pins ip_19_axi/reset] [get_bd_pins ip_19_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_M0] [get_bd_intf_pins ip_19_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_M1] [get_bd_intf_pins ip_19_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_M2] [get_bd_intf_pins ip_19_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S0] [get_bd_intf_pins ip_19_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S1] [get_bd_intf_pins ip_19_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S2] [get_bd_intf_pins ip_19_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S3] [get_bd_intf_pins ip_19_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S4] [get_bd_intf_pins ip_19_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S5] [get_bd_intf_pins ip_19_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S6] [get_bd_intf_pins ip_19_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S7] [get_bd_intf_pins ip_19_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_19_axi/AXI_S8] [get_bd_intf_pins ip_19_axi/axi_0/M08_AXI]


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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_21_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_21_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 3 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_27_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aclk] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aresetn] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_28_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_28_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_28_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aclk] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aresetn] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_29_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_29_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_29_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_29_axis_dwidth_converter/aclk] [get_bd_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_29_axis_dwidth_converter/aresetn] [get_bd_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_30_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_30_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_30_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_2] [get_bd_pins ip_30_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 11 -to 0 ip_30_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_3] [get_bd_pins ip_30_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_32_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_17_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO] [get_bd_intf_pins ip_0_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO2] [get_bd_intf_pins ip_0_gpio/GPIO2]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_6_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_6_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_6_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic_IIC] [get_bd_intf_pins ip_7_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_9_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_9_emc_EMC_INTF] [get_bd_intf_pins ip_9_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_11_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite_MII] [get_bd_intf_pins ip_11_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_11_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_11_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO] [get_bd_intf_pins ip_12_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO2] [get_bd_intf_pins ip_12_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_14_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_iic_IIC] [get_bd_intf_pins ip_14_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 14 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_30_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir O -from 0 -to 0 control_O
connect_bd_net [get_bd_pins control_O] [get_bd_pins ip_32_slice_and_concat/out0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_18_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_0_gpio/rst]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_1_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_3_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/mb_reset] [get_bd_pins ip_4_microblaze/Reset]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_6_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_iic/reset]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_8_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_9_emc/rst]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_12_gpio/rst]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_13_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_iic/reset]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_0_gpio/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_1_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_2_cordic/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_3_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_4_microblaze/Clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_6_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_7_axi_iic/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_8_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_9_emc/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_9_emc/rdclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_10_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_10_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_11_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_12_gpio/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_13_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_14_axi_iic/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_15_cordic/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_16_reset/clk_in]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_locked] [get_bd_pins ip_16_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_18_intc/irq_0] [get_bd_pins ip_0_gpio/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_1] [get_bd_pins ip_5_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_18_intc/irq_2] [get_bd_pins ip_5_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_18_intc/irq_3] [get_bd_pins ip_6_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_18_intc/irq_4] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_5] [get_bd_pins ip_10_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_18_intc/irq_6] [get_bd_pins ip_11_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_7] [get_bd_pins ip_12_gpio/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_8] [get_bd_pins ip_14_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/INTERRUPT] [get_bd_intf_pins ip_18_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/M_AXI_DP] [get_bd_intf_pins ip_19_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI] [get_bd_intf_pins ip_19_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_cdma/M_AXI] [get_bd_intf_pins ip_19_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_19_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_19_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_19_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_emc/AXI] [get_bd_intf_pins ip_19_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_19_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_19_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_19_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_iic/AXI] [get_bd_intf_pins ip_19_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_intc/AXI] [get_bd_intf_pins ip_19_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_20_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_1_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_5_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_6_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_2] [get_bd_pins ip_6_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_3] [get_bd_pins ip_6_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_8_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_19_axi/reset]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_18_intc/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_19_axi/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_20_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_28_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_29_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_CARTESIAN declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_CARTESIAN declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/M_AXIS_DOUT declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/M_AXIS_DOUT declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_cordic/S_AXIS_PHASE declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_cordic/S_AXIS_PHASE declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_cordic/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_cordic/M_AXIS_DOUT declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
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
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }


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
