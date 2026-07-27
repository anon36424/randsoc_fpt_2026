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



########## conv_encoder ##########
create_bd_cell -type hier ip_0_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_0_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 9 CONFIG.convolution_code0 215 CONFIG.convolution_code1 511 CONFIG.convolution_code2 157 CONFIG.convolution_code3 283 CONFIG.convolution_code4 374 CONFIG.convolution_code5 365 CONFIG.convolution_code6 101 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 8 CONFIG.output_rate 11 CONFIG.puncture_code0 11000011 CONFIG.puncture_code1 10111111 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_0_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_0_conv_encoder/aclk] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_0_conv_encoder/aresetn] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_hwicap ##########
create_bd_cell -type hier ip_1_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_1_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 1 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_1_axi_hwicap/axi_hwicap_0]
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


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_2_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_2_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_2_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_2_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/MII] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/clk] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/reset] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/irq] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 172c30227403c7684b5a856b639d18aa2311be9f4f8ae0164045ed9383502bfa7 CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 184 CONFIG.Latency 26 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 258 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 183 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 257 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/CE
connect_bd_net [get_bd_pins ip_3_accumulator/CE] [get_bd_pins ip_3_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/C_IN
connect_bd_net [get_bd_pins ip_3_accumulator/C_IN] [get_bd_pins ip_3_accumulator/accumulator_0/C_IN]


########## floating_point ##########
create_bd_cell -type hier ip_4_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_4_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.a_tuser_width 23 CONFIG.add_sub_value Both CONFIG.b_tuser_width 8 CONFIG.c_a_exponent_width 5 CONFIG.c_a_fraction_width 8 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_divide_by_zero 0 CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 1 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 1 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Divide CONFIG.result_tlast_behv Pass_B_TLAST " [get_bd_cells ip_4_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aclk
connect_bd_net [get_bd_pins ip_4_floating_point/aclk] [get_bd_pins ip_4_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_B] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]


########## complex_multiplier ##########
create_bd_cell -type hier ip_5_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_5_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 15 CONFIG.aresetn 0 CONFIG.atuserwidth 200 CONFIG.bportwidth 27 CONFIG.btuserwidth 124 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Performance CONFIG.outputwidth 2 CONFIG.roundmode Random_Rounding " [get_bd_cells ip_5_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_5_complex_multiplier/aclk] [get_bd_pins ip_5_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## microblaze ##########
create_bd_cell -type hier ip_6_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 32 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 2 CONFIG.C_DEBUG_COUNTER_WIDTH 64 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 43 CONFIG.C_DEBUG_EXTERNAL_TRACE 0 CONFIG.C_DEBUG_LATENCY_COUNTERS 1 CONFIG.C_DEBUG_PROFILE_SIZE 4096 CONFIG.C_DEBUG_TRACE_SIZE 8192 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 1 CONFIG.C_NUMBER_OF_PC_BRK 0 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 0 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 4 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MMU 1 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_6_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_microblaze/Clk
connect_bd_net [get_bd_pins ip_6_microblaze/Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_6_microblaze/Reset
connect_bd_net [get_bd_pins ip_6_microblaze/Reset] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_6_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/INTERRUPT] [get_bd_intf_pins ip_6_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/M_AXI_DP] [get_bd_intf_pins ip_6_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_6_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_6_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xa97f45a966de237 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_6_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_6_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_6_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_6_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xa151e7a2ed66356 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_6_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_6_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_6_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_6_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_6_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 3 " [get_bd_cells ip_6_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_6_microblaze/microblaze_0/DEBUG]


########## accumulator ##########
create_bd_cell -type hier ip_7_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_7_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 6 CONFIG.Latency 6 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 101 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_7_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/clk
connect_bd_net [get_bd_pins ip_7_accumulator/clk] [get_bd_pins ip_7_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 5 -to 0 ip_7_accumulator/B
connect_bd_net [get_bd_pins ip_7_accumulator/B] [get_bd_pins ip_7_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 100 -to 0 ip_7_accumulator/Q
connect_bd_net [get_bd_pins ip_7_accumulator/Q] [get_bd_pins ip_7_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/ADD
connect_bd_net [get_bd_pins ip_7_accumulator/ADD] [get_bd_pins ip_7_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/CE
connect_bd_net [get_bd_pins ip_7_accumulator/CE] [get_bd_pins ip_7_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/C_IN
connect_bd_net [get_bd_pins ip_7_accumulator/C_IN] [get_bd_pins ip_7_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/SCLR
connect_bd_net [get_bd_pins ip_7_accumulator/SCLR] [get_bd_pins ip_7_accumulator/accumulator_0/SCLR]


########## axi_cdma ##########
create_bd_cell -type hier ip_8_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_8_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 42 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_8_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_8_axi_cdma/m_axi_aclk] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_8_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_8_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_cdma/M_AXI] [get_bd_intf_pins ip_8_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_8_axi_cdma/cdma_introut] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_iic ##########
create_bd_cell -type hier ip_9_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_9_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x4a CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 234 CONFIG.C_SDA_INERTIAL_DELAY 206 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 506.7240435915758 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_9_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_9_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic/IIC] [get_bd_intf_pins ip_9_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_iic/clk
connect_bd_net [get_bd_pins ip_9_axi_iic/clk] [get_bd_pins ip_9_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_iic/reset
connect_bd_net [get_bd_pins ip_9_axi_iic/reset] [get_bd_pins ip_9_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic/AXI] [get_bd_intf_pins ip_9_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_iic/irq
connect_bd_net [get_bd_pins ip_9_axi_iic/irq] [get_bd_pins ip_9_axi_iic/axi_iic_0/iic2intc_irpt]


########## reset ##########
create_bd_cell -type hier ip_10_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_10_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_reset/clk_in
connect_bd_net [get_bd_pins ip_10_reset/clk_in] [get_bd_pins ip_10_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_10_reset/reset_in
connect_bd_net [get_bd_pins ip_10_reset/reset_in] [get_bd_pins ip_10_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_10_reset/dcm_locked
connect_bd_net [get_bd_pins ip_10_reset/dcm_locked] [get_bd_pins ip_10_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_10_reset/mb_reset
connect_bd_net [get_bd_pins ip_10_reset/mb_reset] [get_bd_pins ip_10_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_10_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_10_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_10_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset] [get_bd_pins ip_10_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_10_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_10_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_11_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_11_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_in] [get_bd_pins ip_11_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_11_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_11_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_11_clk_wiz/reset
connect_bd_net [get_bd_pins ip_11_clk_wiz/reset] [get_bd_pins ip_11_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_11_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_locked] [get_bd_pins ip_11_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_12_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_12_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_12_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_12_intc/concat_0]
connect_bd_net [get_bd_pins ip_12_intc/concat_0/dout] [get_bd_pins ip_12_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/clk
connect_bd_net [get_bd_pins ip_12_intc/clk] [get_bd_pins ip_12_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/reset
connect_bd_net [get_bd_pins ip_12_intc/reset] [get_bd_pins ip_12_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_intc/AXI] [get_bd_intf_pins ip_12_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/irq_0
connect_bd_net [get_bd_pins ip_12_intc/irq_0] [get_bd_pins ip_12_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/irq_1
connect_bd_net [get_bd_pins ip_12_intc/irq_1] [get_bd_pins ip_12_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/irq_2
connect_bd_net [get_bd_pins ip_12_intc/irq_2] [get_bd_pins ip_12_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/irq_3
connect_bd_net [get_bd_pins ip_12_intc/irq_3] [get_bd_pins ip_12_intc/concat_0/In3]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_12_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_12_intc/irq] [get_bd_intf_pins ip_12_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_13_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_13_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 5 CONFIG.NUM_SI 2 " [get_bd_cells ip_13_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi/clk
connect_bd_net [get_bd_pins ip_13_axi/clk] [get_bd_pins ip_13_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi/reset
connect_bd_net [get_bd_pins ip_13_axi/reset] [get_bd_pins ip_13_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_M0] [get_bd_intf_pins ip_13_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_M1] [get_bd_intf_pins ip_13_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S0] [get_bd_intf_pins ip_13_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S1] [get_bd_intf_pins ip_13_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S2] [get_bd_intf_pins ip_13_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S3] [get_bd_intf_pins ip_13_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S4] [get_bd_intf_pins ip_13_axi/axi_0/M04_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_14_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_14_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_14_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_14_axis_broadcaster/aclk] [get_bd_pins ip_14_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_14_axis_broadcaster/aresetn] [get_bd_pins ip_14_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_15_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_15_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_15_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_15_axis_broadcaster/aclk] [get_bd_pins ip_15_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_15_axis_broadcaster/aresetn] [get_bd_pins ip_15_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_16_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_16_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_16_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aclk] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aresetn] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_17_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_17_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_17_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_18_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aclk] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aresetn] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_20_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_20_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_20_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_20_axis_combiner/aclk] [get_bd_pins ip_20_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_20_axis_combiner/aresetn] [get_bd_pins ip_20_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/M_AXIS] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_21_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_21_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aclk] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aresetn] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_24_reduce
create_bd_pin -dir I -from 167 -to 0 ip_24_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_24_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_24_reduce/concat]
connect_bd_net [get_bd_pins ip_24_reduce/out0] [get_bd_pins ip_24_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_0]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_24_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_24_reduce/slice_0/dout] [get_bd_pins ip_24_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_0/Res] [get_bd_pins ip_24_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_1]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_24_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_24_reduce/slice_1/dout] [get_bd_pins ip_24_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_1/Res] [get_bd_pins ip_24_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_2]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_24_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_24_reduce/slice_2/dout] [get_bd_pins ip_24_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_2/Res] [get_bd_pins ip_24_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_3]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_24_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_24_reduce/slice_3/dout] [get_bd_pins ip_24_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_3/Res] [get_bd_pins ip_24_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_4]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_24_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_24_reduce/slice_4/dout] [get_bd_pins ip_24_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_4/Res] [get_bd_pins ip_24_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 35 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_5]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_24_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_24_reduce/slice_5/dout] [get_bd_pins ip_24_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_5/Res] [get_bd_pins ip_24_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 41 CONFIG.DIN_TO 36 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_6]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_24_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_24_reduce/slice_6/dout] [get_bd_pins ip_24_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_6/Res] [get_bd_pins ip_24_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 42 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_7]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_24_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_24_reduce/slice_7/dout] [get_bd_pins ip_24_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_7/Res] [get_bd_pins ip_24_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 52 CONFIG.DIN_TO 48 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_8]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_24_reduce/slice_8/dout] [get_bd_pins ip_24_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_8/Res] [get_bd_pins ip_24_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 57 CONFIG.DIN_TO 53 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_9]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_24_reduce/slice_9/dout] [get_bd_pins ip_24_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_9/Res] [get_bd_pins ip_24_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 62 CONFIG.DIN_TO 58 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_10]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_24_reduce/slice_10/dout] [get_bd_pins ip_24_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_10/Res] [get_bd_pins ip_24_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 67 CONFIG.DIN_TO 63 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_11]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_24_reduce/slice_11/dout] [get_bd_pins ip_24_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_11/Res] [get_bd_pins ip_24_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 72 CONFIG.DIN_TO 68 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_12]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_24_reduce/slice_12/dout] [get_bd_pins ip_24_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_12/Res] [get_bd_pins ip_24_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 77 CONFIG.DIN_TO 73 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_13]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_24_reduce/slice_13/dout] [get_bd_pins ip_24_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_13/Res] [get_bd_pins ip_24_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 82 CONFIG.DIN_TO 78 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_14]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_24_reduce/slice_14/dout] [get_bd_pins ip_24_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_14/Res] [get_bd_pins ip_24_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 87 CONFIG.DIN_TO 83 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_15]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_24_reduce/slice_15/dout] [get_bd_pins ip_24_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_15/Res] [get_bd_pins ip_24_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 92 CONFIG.DIN_TO 88 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_16]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_24_reduce/slice_16/dout] [get_bd_pins ip_24_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_16/Res] [get_bd_pins ip_24_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 97 CONFIG.DIN_TO 93 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_17]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_24_reduce/slice_17/dout] [get_bd_pins ip_24_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_17/Res] [get_bd_pins ip_24_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 102 CONFIG.DIN_TO 98 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_18]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_24_reduce/slice_18/dout] [get_bd_pins ip_24_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_18/Res] [get_bd_pins ip_24_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 107 CONFIG.DIN_TO 103 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_19]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_24_reduce/slice_19/dout] [get_bd_pins ip_24_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_19/Res] [get_bd_pins ip_24_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 112 CONFIG.DIN_TO 108 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_20]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_24_reduce/slice_20/dout] [get_bd_pins ip_24_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_20/Res] [get_bd_pins ip_24_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 117 CONFIG.DIN_TO 113 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_21]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_24_reduce/slice_21/dout] [get_bd_pins ip_24_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_21/Res] [get_bd_pins ip_24_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 122 CONFIG.DIN_TO 118 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_22]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_24_reduce/slice_22/dout] [get_bd_pins ip_24_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_22/Res] [get_bd_pins ip_24_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 127 CONFIG.DIN_TO 123 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_23]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_24_reduce/slice_23/dout] [get_bd_pins ip_24_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_23/Res] [get_bd_pins ip_24_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 132 CONFIG.DIN_TO 128 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_24]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_24_reduce/slice_24/dout] [get_bd_pins ip_24_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_24/Res] [get_bd_pins ip_24_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 137 CONFIG.DIN_TO 133 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_25]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_24_reduce/slice_25/dout] [get_bd_pins ip_24_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_25/Res] [get_bd_pins ip_24_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 142 CONFIG.DIN_TO 138 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_26]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_24_reduce/slice_26/dout] [get_bd_pins ip_24_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_26/Res] [get_bd_pins ip_24_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 147 CONFIG.DIN_TO 143 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_27]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_24_reduce/slice_27/dout] [get_bd_pins ip_24_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_27/Res] [get_bd_pins ip_24_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 152 CONFIG.DIN_TO 148 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_28]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_24_reduce/slice_28/dout] [get_bd_pins ip_24_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_28/Res] [get_bd_pins ip_24_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 157 CONFIG.DIN_TO 153 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_29]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_24_reduce/slice_29/dout] [get_bd_pins ip_24_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_29/Res] [get_bd_pins ip_24_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 162 CONFIG.DIN_TO 158 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_30]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_24_reduce/slice_30/dout] [get_bd_pins ip_24_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_30/Res] [get_bd_pins ip_24_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 167 CONFIG.DIN_TO 163 CONFIG.DIN_WIDTH 168 " [get_bd_cells ip_24_reduce/slice_31]
connect_bd_net [get_bd_pins ip_24_reduce/in0] [get_bd_pins ip_24_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_24_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_24_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_24_reduce/slice_31/dout] [get_bd_pins ip_24_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_24_reduce/reduce_31/Res] [get_bd_pins ip_24_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 167 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 257 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 167 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 258 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 183 -to 0 ip_26_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_26_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 257 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 257 CONFIG.DIN_TO 168 CONFIG.DIN_WIDTH 258 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/slice_0/dout] [get_bd_pins ip_26_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 100 -to 0 ip_26_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 93 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 101 " [get_bd_cells ip_26_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_1] [get_bd_pins ip_26_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/slice_1/dout] [get_bd_pins ip_26_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 100 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 99 CONFIG.DIN_TO 94 CONFIG.DIN_WIDTH 101 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 100 -to 0 ip_28_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 100 CONFIG.DIN_TO 100 CONFIG.DIN_WIDTH 101 " [get_bd_cells ip_28_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_29_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_29_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_31_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_31_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_33_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_11_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_1_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap_ICAP] [get_bd_intf_pins ip_1_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_1_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_1_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_2_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite_MII] [get_bd_intf_pins ip_2_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_9_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic_IIC] [get_bd_intf_pins ip_9_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_24_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 3 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_33_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_0_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_10_reset/mb_reset] [get_bd_pins ip_6_microblaze/Reset]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_iic/reset]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_0_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_2_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_4_floating_point/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_5_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_6_microblaze/Clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_7_accumulator/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_9_axi_iic/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_10_reset/clk_in]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_locked] [get_bd_pins ip_10_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_12_intc/irq_0] [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_12_intc/irq_1] [get_bd_pins ip_2_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_12_intc/irq_2] [get_bd_pins ip_8_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_12_intc/irq_3] [get_bd_pins ip_9_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_microblaze/INTERRUPT] [get_bd_intf_pins ip_12_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_microblaze/M_AXI_DP] [get_bd_intf_pins ip_13_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/M_AXI] [get_bd_intf_pins ip_13_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_13_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_13_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_iic/AXI] [get_bd_intf_pins ip_13_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_intc/AXI] [get_bd_intf_pins ip_13_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_14_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_15_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_B] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_24_reduce/in0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_1] [get_bd_pins ip_7_accumulator/Q]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/B]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_7_accumulator/Q]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_1_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_7_accumulator/Q]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/ADD]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/CE]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/CE]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_13_axi/reset]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_12_intc/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_13_axi/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_14_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_15_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_16_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_17_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_18_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_20_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_B declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_B declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/M_AXIS_DOUT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/M_AXIS_DOUT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_2 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_3 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_3 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }


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
