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
set_property -dict "CONFIG.C_ADDR_SIZE 64 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 1 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0x17 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_0_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_0_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_0_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x6964eb8b9fcc467 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_0_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_0_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_0_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_0_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x3a5097e1951bc6c CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_0_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_0_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_0_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_0_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_0_microblaze/mem/BRAM_PORTB]


########## complex_multiplier ##########
create_bd_cell -type hier ip_1_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_1_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 55 CONFIG.aresetn 1 CONFIG.bportwidth 28 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 14 CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 47 CONFIG.outtlastbehv OR_all_TLASTs CONFIG.roundmode Truncate " [get_bd_cells ip_1_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aclk] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aclken] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aresetn] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_2_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_2_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_2_axi_ethernet_lite/axi_ethernetlite_0]
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


########## gpio ##########
create_bd_cell -type hier ip_3_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_3_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x4209c2 CONFIG.C_GPIO_WIDTH 23 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x0 " [get_bd_cells ip_3_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/GPIO] [get_bd_intf_pins ip_3_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/clk
connect_bd_net [get_bd_pins ip_3_gpio/clk] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/rst
connect_bd_net [get_bd_pins ip_3_gpio/rst] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_3_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_gpio/irq
connect_bd_net [get_bd_pins ip_3_gpio/irq] [get_bd_pins ip_3_gpio/gpio_0/ip2intc_irpt]


########## xadc_wiz ##########
create_bd_cell -type hier ip_4_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_4_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING 16 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 1 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_4_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_4_xadc_wiz/dclk_in] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_4_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_4_xadc_wiz/reset_in] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/eoc_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/eos_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/alarm_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_4_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_4_xadc_wiz/busy_out] [get_bd_pins ip_4_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_4_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_4_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_4_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## accumulator ##########
create_bd_cell -type hier ip_5_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_5_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 15 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 22 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_5_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/clk
connect_bd_net [get_bd_pins ip_5_accumulator/clk] [get_bd_pins ip_5_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 14 -to 0 ip_5_accumulator/B
connect_bd_net [get_bd_pins ip_5_accumulator/B] [get_bd_pins ip_5_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 21 -to 0 ip_5_accumulator/Q
connect_bd_net [get_bd_pins ip_5_accumulator/Q] [get_bd_pins ip_5_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/SCLR
connect_bd_net [get_bd_pins ip_5_accumulator/SCLR] [get_bd_pins ip_5_accumulator/accumulator_0/SCLR]


########## emc ##########
create_bd_cell -type hier ip_6_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_6_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_MEM2_TYPE 0 CONFIG.C_MEM2_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_SYNCH_PIPEDELAY_1 1 CONFIG.C_SYNCH_PIPEDELAY_2 2 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 5 CONFIG.C_TAVDV_PS_MEM_0 13980 CONFIG.C_TCEDV_PS_MEM_0 14360 CONFIG.C_THZCE_PS_MEM_0 6625 CONFIG.C_THZOE_PS_MEM_0 6749 CONFIG.C_TLZWE_PS_MEM_0 1919 CONFIG.C_TWC_PS_MEM_0 15491 CONFIG.C_TWPH_PS_MEM_0 13018 CONFIG.C_TWP_PS_MEM_0 12925 CONFIG.C_WR_REC_TIME_MEM_0 26544 " [get_bd_cells ip_6_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_6_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_6_emc/EMC_INTF] [get_bd_intf_pins ip_6_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_6_emc/clk
connect_bd_net [get_bd_pins ip_6_emc/clk] [get_bd_pins ip_6_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_emc/rdclk
connect_bd_net [get_bd_pins ip_6_emc/rdclk] [get_bd_pins ip_6_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_emc/rst
connect_bd_net [get_bd_pins ip_6_emc/rst] [get_bd_pins ip_6_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_emc/AXI] [get_bd_intf_pins ip_6_emc/emc_0/S_AXI_MEM]


########## floating_point ##########
create_bd_cell -type hier ip_7_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_7_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Performance CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 1 CONFIG.maximum_latency 1 CONFIG.operation_type Float_to_float CONFIG.result_precision_type Half CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_7_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_floating_point/aclk
connect_bd_net [get_bd_pins ip_7_floating_point/aclk] [get_bd_pins ip_7_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_floating_point/aclken
connect_bd_net [get_bd_pins ip_7_floating_point/aclken] [get_bd_pins ip_7_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_7_floating_point/aresetn
connect_bd_net [get_bd_pins ip_7_floating_point/aresetn] [get_bd_pins ip_7_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_7_floating_point/S_AXIS_A] [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_7_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_7_floating_point/floating_point_0/M_AXIS_RESULT]


########## accumulator ##########
create_bd_cell -type hier ip_8_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_8_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 8 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 8 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_8_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/clk
connect_bd_net [get_bd_pins ip_8_accumulator/clk] [get_bd_pins ip_8_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 7 -to 0 ip_8_accumulator/B
connect_bd_net [get_bd_pins ip_8_accumulator/B] [get_bd_pins ip_8_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 7 -to 0 ip_8_accumulator/Q
connect_bd_net [get_bd_pins ip_8_accumulator/Q] [get_bd_pins ip_8_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/CE
connect_bd_net [get_bd_pins ip_8_accumulator/CE] [get_bd_pins ip_8_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/SCLR
connect_bd_net [get_bd_pins ip_8_accumulator/SCLR] [get_bd_pins ip_8_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/Bypass
connect_bd_net [get_bd_pins ip_8_accumulator/Bypass] [get_bd_pins ip_8_accumulator/accumulator_0/Bypass]


########## reset ##########
create_bd_cell -type hier ip_9_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_9_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_reset/clk_in
connect_bd_net [get_bd_pins ip_9_reset/clk_in] [get_bd_pins ip_9_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_reset/reset_in
connect_bd_net [get_bd_pins ip_9_reset/reset_in] [get_bd_pins ip_9_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_9_reset/dcm_locked
connect_bd_net [get_bd_pins ip_9_reset/dcm_locked] [get_bd_pins ip_9_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/mb_reset
connect_bd_net [get_bd_pins ip_9_reset/mb_reset] [get_bd_pins ip_9_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_9_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset] [get_bd_pins ip_9_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_9_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_9_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_10_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_10_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_in] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_10_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_10_clk_wiz/reset
connect_bd_net [get_bd_pins ip_10_clk_wiz/reset] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_10_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_locked] [get_bd_pins ip_10_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_11_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_11_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_11_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_11_intc/concat_0]
connect_bd_net [get_bd_pins ip_11_intc/concat_0/dout] [get_bd_pins ip_11_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/clk
connect_bd_net [get_bd_pins ip_11_intc/clk] [get_bd_pins ip_11_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/reset
connect_bd_net [get_bd_pins ip_11_intc/reset] [get_bd_pins ip_11_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_intc/AXI] [get_bd_intf_pins ip_11_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_0
connect_bd_net [get_bd_pins ip_11_intc/irq_0] [get_bd_pins ip_11_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_11_intc/irq_1
connect_bd_net [get_bd_pins ip_11_intc/irq_1] [get_bd_pins ip_11_intc/concat_0/In1]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_11_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_11_intc/irq] [get_bd_intf_pins ip_11_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_12_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_12_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 1 " [get_bd_cells ip_12_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_legacy/clk
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_legacy/reset
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_M0] [get_bd_intf_pins ip_12_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S0] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S1] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S2] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_legacy/AXI_S3] [get_bd_intf_pins ip_12_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_12_axi_legacy/clk] [get_bd_pins ip_12_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_12_axi_legacy/reset] [get_bd_pins ip_12_axi_legacy/axi_0/M03_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_13_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_13_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_13_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_13_axis_broadcaster/aclk] [get_bd_pins ip_13_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_13_axis_broadcaster/aresetn] [get_bd_pins ip_13_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_13_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_13_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_13_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_14_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_14_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_14_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_14_axis_dwidth_converter/aclk] [get_bd_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_14_axis_dwidth_converter/aresetn] [get_bd_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_15_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_15_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_15_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_15_axis_dwidth_converter/aclk] [get_bd_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_15_axis_dwidth_converter/aresetn] [get_bd_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_16_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_16_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_16_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aclk] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aresetn] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_17_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_17_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_17_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_2] [get_bd_pins ip_17_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 21 -to 0 ip_17_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 22 " [get_bd_cells ip_17_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_3] [get_bd_pins ip_17_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/slice_3/dout] [get_bd_pins ip_17_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 21 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 22 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_19_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_19_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 21 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 21 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 22 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/slice_0/dout] [get_bd_pins ip_19_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 7 -to 0 ip_19_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_1] [get_bd_pins ip_19_slice_and_concat/concat/In1]


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


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_10_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_2_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite_MII] [get_bd_intf_pins ip_2_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio_GPIO] [get_bd_intf_pins ip_3_gpio/GPIO]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_4_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_4_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_4_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_6_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_6_emc_EMC_INTF] [get_bd_intf_pins ip_6_emc/EMC_INTF]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_13_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 9 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_19_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_9_reset/mb_reset] [get_bd_pins ip_0_microblaze/Reset]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_1_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_3_gpio/rst]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset] [get_bd_pins ip_4_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_9_reset/peripheral_areset_n] [get_bd_pins ip_6_emc/rst]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_7_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_0_microblaze/Clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_1_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_2_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_3_gpio/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_4_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_5_accumulator/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_6_emc/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_6_emc/rdclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_7_floating_point/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_8_accumulator/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_9_reset/clk_in]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_locked] [get_bd_pins ip_9_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_11_intc/irq_0] [get_bd_pins ip_2_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_11_intc/irq_1] [get_bd_pins ip_3_gpio/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_microblaze/INTERRUPT] [get_bd_intf_pins ip_11_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_microblaze/M_AXI_DP] [get_bd_intf_pins ip_12_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_emc/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_intc/AXI] [get_bd_intf_pins ip_12_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_13_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_floating_point/S_AXIS_A] [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/B]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_4_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_2] [get_bd_pins ip_4_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_3] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/B]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_1] [get_bd_pins ip_8_accumulator/Q]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/CE]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_7_floating_point/aclken]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_1_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_4_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_12_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_13_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_9_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_11_intc/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_12_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_13_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_14_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_15_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_10_clk_wiz/clk_out] [get_bd_pins ip_16_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }


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
