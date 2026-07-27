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



########## fft ##########
create_bd_cell -type hier ip_0_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_0_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 2 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 16 " [get_bd_cells ip_0_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_fft/aclk
connect_bd_net [get_bd_pins ip_0_fft/aclk] [get_bd_pins ip_0_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_0_fft/event_frame_started
connect_bd_net [get_bd_pins ip_0_fft/event_frame_started] [get_bd_pins ip_0_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_fft/S_AXIS_DATA] [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_fft/M_AXIS_DATA] [get_bd_intf_pins ip_0_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_0_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_CONFIG]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_1_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_1_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_1_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_1_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite/MII] [get_bd_intf_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_1_axi_ethernet_lite/clk] [get_bd_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_1_axi_ethernet_lite/reset] [get_bd_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_1_axi_ethernet_lite/irq] [get_bd_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## xadc_wiz ##########
create_bd_cell -type hier ip_2_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_2_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING 16 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_TEMP_BUS 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_2_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_2_xadc_wiz/s_axi_aclk] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_2_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_2_xadc_wiz/convstclk_in] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_2_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
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


########## microblaze ##########
create_bd_cell -type hier ip_3_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 52 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 4 CONFIG.C_DEBUG_COUNTER_WIDTH 32 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 36 CONFIG.C_DEBUG_EXTERNAL_TRACE 1 CONFIG.C_DEBUG_LATENCY_COUNTERS 3 CONFIG.C_DEBUG_PROFILE_SIZE 131072 CONFIG.C_DEBUG_TRACE_SIZE 32 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 5 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 1 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 0 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_3_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_microblaze/Clk
connect_bd_net [get_bd_pins ip_3_microblaze/Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_3_microblaze/Reset
connect_bd_net [get_bd_pins ip_3_microblaze/Reset] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_3_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/INTERRUPT] [get_bd_intf_pins ip_3_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/M_AXI_DP] [get_bd_intf_pins ip_3_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_3_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_3_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x765dd1c3aec3859 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_3_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_3_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_3_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_3_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xfb72e2675a1a999 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_3_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_3_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_3_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_3_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_3_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 1 " [get_bd_cells ip_3_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_3_microblaze/microblaze_0/DEBUG]


########## floating_point ##########
create_bd_cell -type hier ip_4_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_4_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Double CONFIG.add_sub_value Both CONFIG.b_tuser_width 57 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage Full_Usage CONFIG.c_tuser_width 2 CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 1 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 1 CONFIG.has_c_tuser 1 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type FMA CONFIG.result_tlast_behv OR_all_TLASTs " [get_bd_cells ip_4_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aclk
connect_bd_net [get_bd_pins ip_4_floating_point/aclk] [get_bd_pins ip_4_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aresetn
connect_bd_net [get_bd_pins ip_4_floating_point/aresetn] [get_bd_pins ip_4_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_B] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_C
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_C] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_C]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_OPERATION
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_OPERATION] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_OPERATION]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]


########## conv_encoder ##########
create_bd_cell -type hier ip_5_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_5_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 3 CONFIG.convolution_code0 0 CONFIG.convolution_code1 3 CONFIG.convolution_code2 3 CONFIG.convolution_code3 2 CONFIG.convolution_code4 1 CONFIG.convolution_code5 6 CONFIG.convolution_code6 7 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 10 CONFIG.output_rate 11 CONFIG.puncture_code0 1101110010 CONFIG.puncture_code1 0011011100 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_5_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_5_conv_encoder/aclk] [get_bd_pins ip_5_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_5_conv_encoder/aclken] [get_bd_pins ip_5_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_5_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_5_conv_encoder/aresetn] [get_bd_pins ip_5_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_iic ##########
create_bd_cell -type hier ip_6_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_6_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x4d CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 60 CONFIG.C_SDA_INERTIAL_DELAY 40 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 713.2121468691511 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_6_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_6_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic/IIC] [get_bd_intf_pins ip_6_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_iic/clk
connect_bd_net [get_bd_pins ip_6_axi_iic/clk] [get_bd_pins ip_6_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_iic/reset
connect_bd_net [get_bd_pins ip_6_axi_iic/reset] [get_bd_pins ip_6_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic/AXI] [get_bd_intf_pins ip_6_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_iic/irq
connect_bd_net [get_bd_pins ip_6_axi_iic/irq] [get_bd_pins ip_6_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_timer ##########
create_bd_cell -type hier ip_7_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_7_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_7_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_timer/S_AXI] [get_bd_intf_pins ip_7_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_7_axi_timer/capturetrig0] [get_bd_pins ip_7_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/freeze
connect_bd_net [get_bd_pins ip_7_axi_timer/freeze] [get_bd_pins ip_7_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_7_axi_timer/s_axi_aclk] [get_bd_pins ip_7_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_7_axi_timer/s_axi_aresetn] [get_bd_pins ip_7_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_7_axi_timer/generateout0] [get_bd_pins ip_7_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_7_axi_timer/generateout1] [get_bd_pins ip_7_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_7_axi_timer/pwm0] [get_bd_pins ip_7_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_7_axi_timer/interrupt] [get_bd_pins ip_7_axi_timer/axi_timer_0/interrupt]


########## axi_dma ##########
create_bd_cell -type hier ip_8_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_8_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 49 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 4 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 128 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 256 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 23 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_8_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_8_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_8_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_8_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_8_axi_dma/axi_resetn] [get_bd_pins ip_8_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_8_axi_dma/mm2s_introut] [get_bd_pins ip_8_axi_dma/axi_dma_0/mm2s_introut]


########## accumulator ##########
create_bd_cell -type hier ip_9_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_9_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 182 CONFIG.Latency 13 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 203 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_9_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_accumulator/clk
connect_bd_net [get_bd_pins ip_9_accumulator/clk] [get_bd_pins ip_9_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 181 -to 0 ip_9_accumulator/B
connect_bd_net [get_bd_pins ip_9_accumulator/B] [get_bd_pins ip_9_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 202 -to 0 ip_9_accumulator/Q
connect_bd_net [get_bd_pins ip_9_accumulator/Q] [get_bd_pins ip_9_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_9_accumulator/C_IN
connect_bd_net [get_bd_pins ip_9_accumulator/C_IN] [get_bd_pins ip_9_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_9_accumulator/SCLR
connect_bd_net [get_bd_pins ip_9_accumulator/SCLR] [get_bd_pins ip_9_accumulator/accumulator_0/SCLR]


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
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_12_intc/concat_0]
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
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/irq_4
connect_bd_net [get_bd_pins ip_12_intc/irq_4] [get_bd_pins ip_12_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/irq_5
connect_bd_net [get_bd_pins ip_12_intc/irq_5] [get_bd_pins ip_12_intc/concat_0/In5]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_12_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_12_intc/irq] [get_bd_intf_pins ip_12_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_13_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_13_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 5 CONFIG.NUM_SI 2 " [get_bd_cells ip_13_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_legacy/clk
connect_bd_net [get_bd_pins ip_13_axi_legacy/clk] [get_bd_pins ip_13_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_legacy/reset
connect_bd_net [get_bd_pins ip_13_axi_legacy/reset] [get_bd_pins ip_13_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_legacy/AXI_M0] [get_bd_intf_pins ip_13_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_13_axi_legacy/clk] [get_bd_pins ip_13_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_13_axi_legacy/reset] [get_bd_pins ip_13_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_legacy/AXI_M1] [get_bd_intf_pins ip_13_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_13_axi_legacy/clk] [get_bd_pins ip_13_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_13_axi_legacy/reset] [get_bd_pins ip_13_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_legacy/AXI_S0] [get_bd_intf_pins ip_13_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_13_axi_legacy/clk] [get_bd_pins ip_13_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_13_axi_legacy/reset] [get_bd_pins ip_13_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_legacy/AXI_S1] [get_bd_intf_pins ip_13_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_13_axi_legacy/clk] [get_bd_pins ip_13_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_13_axi_legacy/reset] [get_bd_pins ip_13_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_legacy/AXI_S2] [get_bd_intf_pins ip_13_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_13_axi_legacy/clk] [get_bd_pins ip_13_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_13_axi_legacy/reset] [get_bd_pins ip_13_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_legacy/AXI_S3] [get_bd_intf_pins ip_13_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_13_axi_legacy/clk] [get_bd_pins ip_13_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_13_axi_legacy/reset] [get_bd_pins ip_13_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_legacy/AXI_S4] [get_bd_intf_pins ip_13_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_13_axi_legacy/clk] [get_bd_pins ip_13_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_13_axi_legacy/reset] [get_bd_pins ip_13_axi_legacy/axi_0/M04_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_14_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_14_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_14_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_15_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_15_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_15_axis_broadcaster/axis_broadcaster_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_16_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_16_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_16_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_17_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_18_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 26 -to 0 ip_22_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_22_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_22_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_22_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_3] [get_bd_pins ip_22_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_4] [get_bd_pins ip_22_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_5] [get_bd_pins ip_22_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 202 -to 0 ip_22_slice_and_concat/in_6
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 20 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 203 " [get_bd_cells ip_22_slice_and_concat/slice_6]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_6] [get_bd_pins ip_22_slice_and_concat/slice_6/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/slice_6/dout] [get_bd_pins ip_22_slice_and_concat/concat/In6]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 181 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 202 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 202 CONFIG.DIN_TO 21 CONFIG.DIN_WIDTH 203 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_26_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_28_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_11_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_1_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite_MII] [get_bd_intf_pins ip_1_axi_ethernet_lite/MII]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_6_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic_IIC] [get_bd_intf_pins ip_6_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 26 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_22_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_2_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_10_reset/mb_reset] [get_bd_pins ip_3_microblaze/Reset]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_4_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_5_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_iic/reset]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_0_fft/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_1_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_2_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_2_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_3_microblaze/Clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_4_floating_point/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_5_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_6_axi_iic/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_7_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_9_accumulator/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_10_reset/clk_in]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_locked] [get_bd_pins ip_10_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_12_intc/irq_0] [get_bd_pins ip_0_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_12_intc/irq_1] [get_bd_pins ip_1_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_12_intc/irq_2] [get_bd_pins ip_2_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_12_intc/irq_3] [get_bd_pins ip_6_axi_iic/irq]
connect_bd_net [get_bd_pins ip_12_intc/irq_4] [get_bd_pins ip_7_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_12_intc/irq_5] [get_bd_pins ip_8_axi_dma/mm2s_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_microblaze/INTERRUPT] [get_bd_intf_pins ip_12_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_microblaze/M_AXI_DP] [get_bd_intf_pins ip_13_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_13_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_13_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_iic/AXI] [get_bd_intf_pins ip_13_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_timer/S_AXI] [get_bd_intf_pins ip_13_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_intc/AXI] [get_bd_intf_pins ip_13_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_fft/M_AXIS_DATA] [get_bd_intf_pins ip_14_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_15_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_B] [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_fft/S_AXIS_DATA] [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_C] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_OPERATION] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_2_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_2_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_3] [get_bd_pins ip_7_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_4] [get_bd_pins ip_7_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_5] [get_bd_pins ip_7_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_6] [get_bd_pins ip_9_accumulator/Q]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_9_accumulator/B]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_9_accumulator/Q]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_7_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_9_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_5_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_9_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_7_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_13_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_12_intc/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_13_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_14_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_15_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_16_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_17_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_18_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_DATA declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_DATA declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_fft/M_AXIS_DATA declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_fft/M_AXIS_DATA declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 15 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_CONFIG declared=15 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_fft/S_AXIS_CONFIG declared=15 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_OPERATION]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_OPERATION declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_OPERATION declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 15 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=15 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=15 actual=ERR $__err" }


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
