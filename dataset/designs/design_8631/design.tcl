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
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Sinh_and_Cosh CONFIG.Input_Width 41 CONFIG.Iterations 42 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 31 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 47 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_0_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aclk
connect_bd_net [get_bd_pins ip_0_cordic/aclk] [get_bd_pins ip_0_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aclken
connect_bd_net [get_bd_pins ip_0_cordic/aclken] [get_bd_pins ip_0_cordic/cordic_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aresetn
connect_bd_net [get_bd_pins ip_0_cordic/aresetn] [get_bd_pins ip_0_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]


########## cordic ##########
create_bd_cell -type hier ip_1_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_1_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 47 CONFIG.Iterations 4 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 41 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 48 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_1_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_cordic/aclk
connect_bd_net [get_bd_pins ip_1_cordic/aclk] [get_bd_pins ip_1_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_1_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_1_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_1_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_1_cordic/cordic_0/M_AXIS_DOUT]


########## axi_cdma ##########
create_bd_cell -type hier ip_2_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_2_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 58 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_2_axi_cdma/axi_cdma_0]
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


########## axi_hwicap ##########
create_bd_cell -type hier ip_3_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_3_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 1 CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 0 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_3_axi_hwicap/axi_hwicap_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_4_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_4_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.add_sub_value Add CONFIG.b_tuser_width 105 CONFIG.c_a_exponent_width 9 CONFIG.c_a_fraction_width 49 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage Full_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 1 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type FMA CONFIG.result_tlast_behv Pass_B_TLAST " [get_bd_cells ip_4_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aclk
connect_bd_net [get_bd_pins ip_4_floating_point/aclk] [get_bd_pins ip_4_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aclken
connect_bd_net [get_bd_pins ip_4_floating_point/aclken] [get_bd_pins ip_4_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aresetn
connect_bd_net [get_bd_pins ip_4_floating_point/aresetn] [get_bd_pins ip_4_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_B] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_C
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_C] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_C]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]


########## accumulator ##########
create_bd_cell -type hier ip_5_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_5_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 4 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 29 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_5_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/clk
connect_bd_net [get_bd_pins ip_5_accumulator/clk] [get_bd_pins ip_5_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 3 -to 0 ip_5_accumulator/B
connect_bd_net [get_bd_pins ip_5_accumulator/B] [get_bd_pins ip_5_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 28 -to 0 ip_5_accumulator/Q
connect_bd_net [get_bd_pins ip_5_accumulator/Q] [get_bd_pins ip_5_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/CE
connect_bd_net [get_bd_pins ip_5_accumulator/CE] [get_bd_pins ip_5_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/SCLR
connect_bd_net [get_bd_pins ip_5_accumulator/SCLR] [get_bd_pins ip_5_accumulator/accumulator_0/SCLR]


########## conv_encoder ##########
create_bd_cell -type hier ip_6_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_6_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 5 CONFIG.convolution_code0 17 CONFIG.convolution_code1 15 CONFIG.convolution_code2 16 CONFIG.convolution_code3 22 CONFIG.convolution_code4 6 CONFIG.convolution_code5 14 CONFIG.convolution_code6 29 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 6 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_6_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_6_conv_encoder/aclk] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_6_conv_encoder/aclken] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_6_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_6_conv_encoder/aresetn] [get_bd_pins ip_6_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_6_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_6_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## microblaze ##########
create_bd_cell -type hier ip_7_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 64 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 0 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_OPCODE_0x0_ILLEGAL 1 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_7_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_7_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_7_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xb9adafc7016ae7 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_7_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_7_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_7_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_7_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xf0d41f3e8be0ce0 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_7_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_7_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_7_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_7_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_7_microblaze/mem/BRAM_PORTB]


########## gpio ##########
create_bd_cell -type hier ip_8_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_8_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0xfffffff CONFIG.C_GPIO_WIDTH 28 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x802aab0 " [get_bd_cells ip_8_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio/GPIO] [get_bd_intf_pins ip_8_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_8_gpio/clk
connect_bd_net [get_bd_pins ip_8_gpio/clk] [get_bd_pins ip_8_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_gpio/rst
connect_bd_net [get_bd_pins ip_8_gpio/rst] [get_bd_pins ip_8_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio/AXI] [get_bd_intf_pins ip_8_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_gpio/irq
connect_bd_net [get_bd_pins ip_8_gpio/irq] [get_bd_pins ip_8_gpio/gpio_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_9_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_9_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 18 CONFIG.C_GPIO_WIDTH 24 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_9_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/GPIO] [get_bd_intf_pins ip_9_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/GPIO2] [get_bd_intf_pins ip_9_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/clk
connect_bd_net [get_bd_pins ip_9_gpio/clk] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/rst
connect_bd_net [get_bd_pins ip_9_gpio/rst] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_9_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_gpio/irq
connect_bd_net [get_bd_pins ip_9_gpio/irq] [get_bd_pins ip_9_gpio/gpio_0/ip2intc_irpt]


########## axi_iic ##########
create_bd_cell -type hier ip_10_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_10_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x30 CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 64 CONFIG.C_SDA_INERTIAL_DELAY 135 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 192.00003405921544 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_10_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_10_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_iic/IIC] [get_bd_intf_pins ip_10_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_iic/clk
connect_bd_net [get_bd_pins ip_10_axi_iic/clk] [get_bd_pins ip_10_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_iic/reset
connect_bd_net [get_bd_pins ip_10_axi_iic/reset] [get_bd_pins ip_10_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_iic/AXI] [get_bd_intf_pins ip_10_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_iic/irq
connect_bd_net [get_bd_pins ip_10_axi_iic/irq] [get_bd_pins ip_10_axi_iic/axi_iic_0/iic2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_11_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_11_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_SYNCH_PIPEDELAY_1 2 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 7 CONFIG.C_TAVDV_PS_MEM_0 14029 CONFIG.C_TCEDV_PS_MEM_0 13832 CONFIG.C_THZCE_PS_MEM_0 7403 CONFIG.C_THZOE_PS_MEM_0 7140 CONFIG.C_TLZWE_PS_MEM_0 6539 CONFIG.C_TWC_PS_MEM_0 14523 CONFIG.C_TWPH_PS_MEM_0 12639 CONFIG.C_TWP_PS_MEM_0 11482 CONFIG.C_WR_REC_TIME_MEM_0 26892 " [get_bd_cells ip_11_emc/emc_0]
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


########## gpio ##########
create_bd_cell -type hier ip_12_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_12_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x4 CONFIG.C_DOUT_DEFAULT_2 0xc CONFIG.C_GPIO2_WIDTH 20 CONFIG.C_GPIO_WIDTH 4 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0xb CONFIG.C_TRI_DEFAULT_2 0x0 " [get_bd_cells ip_12_gpio/gpio_0]
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


########## emc ##########
create_bd_cell -type hier ip_13_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_13_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 2 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 4 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 11 CONFIG.C_TAVDV_PS_MEM_0 16050 CONFIG.C_TAVDV_PS_MEM_1 13876 CONFIG.C_TAVDV_PS_MEM_2 13555 CONFIG.C_TCEDV_PS_MEM_0 14427 CONFIG.C_TCEDV_PS_MEM_1 16300 CONFIG.C_TCEDV_PS_MEM_2 15370 CONFIG.C_THZCE_PS_MEM_0 6783 CONFIG.C_THZCE_PS_MEM_1 7157 CONFIG.C_THZCE_PS_MEM_2 7181 CONFIG.C_THZOE_PS_MEM_0 6791 CONFIG.C_THZOE_PS_MEM_1 7346 CONFIG.C_THZOE_PS_MEM_2 6403 CONFIG.C_TLZWE_PS_MEM_0 5500 CONFIG.C_TLZWE_PS_MEM_1 5082 CONFIG.C_TLZWE_PS_MEM_2 6957 CONFIG.C_TWC_PS_MEM_0 13882 CONFIG.C_TWC_PS_MEM_1 16462 CONFIG.C_TWC_PS_MEM_2 13918 CONFIG.C_TWPH_PS_MEM_0 12838 CONFIG.C_TWPH_PS_MEM_1 11520 CONFIG.C_TWPH_PS_MEM_2 10986 CONFIG.C_TWP_PS_MEM_0 11058 CONFIG.C_TWP_PS_MEM_1 12107 CONFIG.C_TWP_PS_MEM_2 11405 CONFIG.C_WR_REC_TIME_MEM_0 27475 CONFIG.C_WR_REC_TIME_MEM_1 26265 CONFIG.C_WR_REC_TIME_MEM_2 26608 " [get_bd_cells ip_13_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_13_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_13_emc/EMC_INTF] [get_bd_intf_pins ip_13_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/clk
connect_bd_net [get_bd_pins ip_13_emc/clk] [get_bd_pins ip_13_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/rdclk
connect_bd_net [get_bd_pins ip_13_emc/rdclk] [get_bd_pins ip_13_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/rst
connect_bd_net [get_bd_pins ip_13_emc/rst] [get_bd_pins ip_13_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_emc/AXI] [get_bd_intf_pins ip_13_emc/emc_0/S_AXI_MEM]


########## axi_dma ##########
create_bd_cell -type hier ip_14_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_14_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 54 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_14_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_14_axi_dma/axi_resetn] [get_bd_pins ip_14_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_14_axi_dma/s2mm_introut] [get_bd_pins ip_14_axi_dma/axi_dma_0/s2mm_introut]


########## axi_timer ##########
create_bd_cell -type hier ip_15_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_15_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 32 CONFIG.GEN0_ASSERT Active_High CONFIG.GEN1_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.TRIG1_ASSERT Active_Low CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_15_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_timer/S_AXI] [get_bd_intf_pins ip_15_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_15_axi_timer/capturetrig0] [get_bd_pins ip_15_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_15_axi_timer/capturetrig1] [get_bd_pins ip_15_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_timer/freeze
connect_bd_net [get_bd_pins ip_15_axi_timer/freeze] [get_bd_pins ip_15_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_15_axi_timer/s_axi_aclk] [get_bd_pins ip_15_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_15_axi_timer/s_axi_aresetn] [get_bd_pins ip_15_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_15_axi_timer/generateout0] [get_bd_pins ip_15_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_15_axi_timer/generateout1] [get_bd_pins ip_15_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_15_axi_timer/pwm0] [get_bd_pins ip_15_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_15_axi_timer/interrupt] [get_bd_pins ip_15_axi_timer/axi_timer_0/interrupt]


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
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_18_intc/concat_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_18_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_18_intc/irq] [get_bd_intf_pins ip_18_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_19_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_19_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 11 CONFIG.NUM_SI 3 " [get_bd_cells ip_19_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_legacy/clk
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_legacy/reset
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_M0] [get_bd_intf_pins ip_19_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_M1] [get_bd_intf_pins ip_19_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_M2] [get_bd_intf_pins ip_19_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S0] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S1] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S2] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S3] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S4] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S5] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S6] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S7] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S8] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S9] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S10] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M10_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_20_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_20_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_20_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_27_axis_dwidth_converter/axis_dwidth_converter_0]
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
create_bd_pin -dir O -from 0 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 28 -to 0 ip_28_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 29 " [get_bd_cells ip_28_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 26 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 28 -to 0 ip_29_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 27 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 29 " [get_bd_cells ip_29_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 3 -to 0 ip_30_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_30_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 28 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 28 CONFIG.DIN_TO 28 CONFIG.DIN_WIDTH 29 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/slice_0/dout] [get_bd_pins ip_30_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_30_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_2] [get_bd_pins ip_30_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_3] [get_bd_pins ip_30_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_31_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_31_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_33_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_37_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_37_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_17_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_3_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_hwicap_ICAP] [get_bd_intf_pins ip_3_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_3_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_3_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio_GPIO] [get_bd_intf_pins ip_8_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO] [get_bd_intf_pins ip_9_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO2] [get_bd_intf_pins ip_9_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_10_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_iic_IIC] [get_bd_intf_pins ip_10_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_11_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_11_emc_EMC_INTF] [get_bd_intf_pins ip_11_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO] [get_bd_intf_pins ip_12_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO2] [get_bd_intf_pins ip_12_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_13_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_13_emc_EMC_INTF] [get_bd_intf_pins ip_13_emc/EMC_INTF]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 26 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_29_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 6 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_33_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_35_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_37_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_38_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_18_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_0_cordic/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_4_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_6_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/mb_reset] [get_bd_pins ip_7_microblaze/Reset]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_8_gpio/rst]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_9_gpio/rst]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_iic/reset]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_11_emc/rst]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_12_gpio/rst]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_13_emc/rst]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_16_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_0_cordic/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_1_cordic/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_3_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_3_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_4_floating_point/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_5_accumulator/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_6_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_7_microblaze/Clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_8_gpio/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_9_gpio/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_10_axi_iic/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_11_emc/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_11_emc/rdclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_12_gpio/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_13_emc/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_13_emc/rdclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_15_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_16_reset/clk_in]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_locked] [get_bd_pins ip_16_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_18_intc/irq_0] [get_bd_pins ip_2_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_18_intc/irq_1] [get_bd_pins ip_3_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_18_intc/irq_2] [get_bd_pins ip_8_gpio/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_3] [get_bd_pins ip_9_gpio/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_4] [get_bd_pins ip_10_axi_iic/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_5] [get_bd_pins ip_12_gpio/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_6] [get_bd_pins ip_14_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_18_intc/irq_7] [get_bd_pins ip_15_axi_timer/interrupt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_microblaze/INTERRUPT] [get_bd_intf_pins ip_18_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/M_AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_microblaze/M_AXI_DP] [get_bd_intf_pins ip_19_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_19_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_19_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_19_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_gpio/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_iic/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_emc/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_emc/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_19_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_timer/S_AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_intc/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_20_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_1_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_B] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_C] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_3_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/B]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_15_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_2] [get_bd_pins ip_15_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_3] [get_bd_pins ip_15_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_6_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_4_floating_point/aclken]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_15_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_15_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_0_cordic/aclken]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/CE]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_15_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_19_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_18_intc/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_19_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_20_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_17_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_cordic/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_cordic/M_AXIS_DOUT declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_C]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_C declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_C declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
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
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }


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
