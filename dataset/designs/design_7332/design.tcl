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



########## cordic ##########
create_bd_cell -type hier ip_0_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_0_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tanh CONFIG.Input_Width 18 CONFIG.Iterations 5 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 30 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 33 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_0_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aclk
connect_bd_net [get_bd_pins ip_0_cordic/aclk] [get_bd_pins ip_0_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aclken
connect_bd_net [get_bd_pins ip_0_cordic/aclken] [get_bd_pins ip_0_cordic/cordic_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]


########## conv_encoder ##########
create_bd_cell -type hier ip_1_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_1_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 8 CONFIG.convolution_code0 178 CONFIG.convolution_code1 231 CONFIG.convolution_code2 44 CONFIG.convolution_code3 9 CONFIG.convolution_code4 33 CONFIG.convolution_code5 113 CONFIG.convolution_code6 207 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 12 CONFIG.output_rate 15 CONFIG.puncture_code0 011101111100 CONFIG.puncture_code1 101110110001 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_1_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_1_conv_encoder/aclk] [get_bd_pins ip_1_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_1_conv_encoder/aclken] [get_bd_pins ip_1_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_1_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_1_conv_encoder/aresetn] [get_bd_pins ip_1_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_1_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_1_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## xadc_wiz ##########
create_bd_cell -type hier ip_2_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_2_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_TEMP_BUS 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_2_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_2_xadc_wiz/s_axi_aclk] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_2_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_2_xadc_wiz/convst_in] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_2_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/ot_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/eoc_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/eos_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/busy_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 11 -to 0 ip_2_xadc_wiz/temp_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/temp_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/temp_out]


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 5 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 11 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 4 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 10 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/C_IN
connect_bd_net [get_bd_pins ip_3_accumulator/C_IN] [get_bd_pins ip_3_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/SCLR
connect_bd_net [get_bd_pins ip_3_accumulator/SCLR] [get_bd_pins ip_3_accumulator/accumulator_0/SCLR]


########## microblaze ##########
create_bd_cell -type hier ip_4_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 64 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 6 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 0 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 2 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0xf3 CONFIG.C_PVR_USER2 0x9769e9a2 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_4_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_MASK 0x55c88ae1e02efac CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_d]
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
set_property -dict "CONFIG.C_MASK 0xd908b91a11a95c CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_i]
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
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 4 " [get_bd_cells ip_4_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_4_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_4_microblaze/microblaze_0/DEBUG]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_5_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_5_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_5_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_5_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite/MII] [get_bd_intf_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_5_axi_ethernet_lite/clk] [get_bd_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_5_axi_ethernet_lite/reset] [get_bd_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_5_axi_ethernet_lite/irq] [get_bd_pins ip_5_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_6_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_6_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 64 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 16 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 128 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 1 CONFIG.C_SG_LENGTH_WIDTH 12 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_6_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_6_axi_dma/axi_resetn] [get_bd_pins ip_6_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_axi_dma/M_AXIS_CNTRL
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXIS_CNTRL] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXIS_CNTRL]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_6_axi_dma/mm2s_introut] [get_bd_pins ip_6_axi_dma/axi_dma_0/mm2s_introut]


########## uartlite ##########
create_bd_cell -type hier ip_7_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_7_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 9600 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Odd " [get_bd_cells ip_7_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_7_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite/UART] [get_bd_intf_pins ip_7_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_7_uartlite/clk
connect_bd_net [get_bd_pins ip_7_uartlite/clk] [get_bd_pins ip_7_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_uartlite/reset
connect_bd_net [get_bd_pins ip_7_uartlite/reset] [get_bd_pins ip_7_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite/AXI] [get_bd_intf_pins ip_7_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_uartlite/irq
connect_bd_net [get_bd_pins ip_7_uartlite/irq] [get_bd_pins ip_7_uartlite/uart_0/interrupt]


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
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_10_intc/concat_0]
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
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/irq_2
connect_bd_net [get_bd_pins ip_10_intc/irq_2] [get_bd_pins ip_10_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/irq_3
connect_bd_net [get_bd_pins ip_10_intc/irq_3] [get_bd_pins ip_10_intc/concat_0/In3]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_10_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_10_intc/irq] [get_bd_intf_pins ip_10_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_11_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_11_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 3 " [get_bd_cells ip_11_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi/clk
connect_bd_net [get_bd_pins ip_11_axi/clk] [get_bd_pins ip_11_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi/reset
connect_bd_net [get_bd_pins ip_11_axi/reset] [get_bd_pins ip_11_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_M0] [get_bd_intf_pins ip_11_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_M1] [get_bd_intf_pins ip_11_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_M2] [get_bd_intf_pins ip_11_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S0] [get_bd_intf_pins ip_11_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S1] [get_bd_intf_pins ip_11_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S2] [get_bd_intf_pins ip_11_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_11_axi/AXI_S3] [get_bd_intf_pins ip_11_axi/axi_0/M03_AXI]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_12_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_12_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_12_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_12_axis_dwidth_converter/aclk] [get_bd_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_12_axis_dwidth_converter/aresetn] [get_bd_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_13_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_13_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_13_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aclk] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aresetn] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_14_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_14_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_14_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_14_axis_combiner/aclk] [get_bd_pins ip_14_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_14_axis_combiner/aresetn] [get_bd_pins ip_14_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_14_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_14_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_combiner/M_AXIS] [get_bd_intf_pins ip_14_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_15_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_15_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 5 " [get_bd_cells ip_15_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_15_axis_dwidth_converter/aclk] [get_bd_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_15_axis_dwidth_converter/aresetn] [get_bd_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 20 -to 0 ip_16_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_16_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_16_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_16_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 11 -to 0 ip_16_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_3] [get_bd_pins ip_16_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 10 -to 0 ip_16_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_16_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_4] [get_bd_pins ip_16_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/slice_4/dout] [get_bd_pins ip_16_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 4 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 10 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_19_slice_and_concat/slice_0]
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


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_22_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_9_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_5_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_ethernet_lite_MII] [get_bd_intf_pins ip_5_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_7_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite_UART] [get_bd_intf_pins ip_7_uartlite/UART]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 20 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_16_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_1_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_2_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_8_reset/mb_reset] [get_bd_pins ip_4_microblaze/Reset]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_7_uartlite/reset]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_0_cordic/aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_1_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_2_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_4_microblaze/Clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_5_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_7_uartlite/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_8_reset/clk_in]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_locked] [get_bd_pins ip_8_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_10_intc/irq_0] [get_bd_pins ip_2_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_10_intc/irq_1] [get_bd_pins ip_5_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_10_intc/irq_2] [get_bd_pins ip_6_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_10_intc/irq_3] [get_bd_pins ip_7_uartlite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/INTERRUPT] [get_bd_intf_pins ip_10_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/M_AXI_DP] [get_bd_intf_pins ip_11_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_11_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_11_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_11_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_11_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_uartlite/AXI] [get_bd_intf_pins ip_11_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_intc/AXI] [get_bd_intf_pins ip_11_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_axi_dma/M_AXIS_CNTRL]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_1_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_combiner/M_AXIS]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_2_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_2_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_3] [get_bd_pins ip_2_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_4] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_2_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_1_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_0_cordic/aclken]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_11_axi/reset]
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_12_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_13_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_10_intc/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_11_axi/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_12_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_13_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_14_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_15_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXIS_CNTRL]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/M_AXIS_CNTRL declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/M_AXIS_CNTRL declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_combiner/M_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_combiner/M_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
