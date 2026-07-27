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
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_DCLK 1 CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_0_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/dclk_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/reset_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
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


########## dft ##########
create_bd_cell -type hier ip_1_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_1_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 16 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_1_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CLK
connect_bd_net [get_bd_pins ip_1_dft/CLK] [get_bd_pins ip_1_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/SCLR
connect_bd_net [get_bd_pins ip_1_dft/SCLR] [get_bd_pins ip_1_dft/dft_0/SCLR]
create_bd_pin -dir I -from 15 -to 0 ip_1_dft/XN_RE
connect_bd_net [get_bd_pins ip_1_dft/XN_RE] [get_bd_pins ip_1_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 15 -to 0 ip_1_dft/XN_IM
connect_bd_net [get_bd_pins ip_1_dft/XN_IM] [get_bd_pins ip_1_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FD_IN
connect_bd_net [get_bd_pins ip_1_dft/FD_IN] [get_bd_pins ip_1_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FWD_INV
connect_bd_net [get_bd_pins ip_1_dft/FWD_INV] [get_bd_pins ip_1_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_1_dft/SIZE
connect_bd_net [get_bd_pins ip_1_dft/SIZE] [get_bd_pins ip_1_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/RFFD
connect_bd_net [get_bd_pins ip_1_dft/RFFD] [get_bd_pins ip_1_dft/dft_0/RFFD]
create_bd_pin -dir O -from 15 -to 0 ip_1_dft/XK_RE
connect_bd_net [get_bd_pins ip_1_dft/XK_RE] [get_bd_pins ip_1_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 15 -to 0 ip_1_dft/XK_IM
connect_bd_net [get_bd_pins ip_1_dft/XK_IM] [get_bd_pins ip_1_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_1_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_1_dft/BLK_EXP] [get_bd_pins ip_1_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/FD_OUT
connect_bd_net [get_bd_pins ip_1_dft/FD_OUT] [get_bd_pins ip_1_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_1_dft/DATA_VALID] [get_bd_pins ip_1_dft/dft_0/DATA_VALID]


########## accumulator ##########
create_bd_cell -type hier ip_2_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_2_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 6 CONFIG.Latency 2 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 34 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_2_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/clk
connect_bd_net [get_bd_pins ip_2_accumulator/clk] [get_bd_pins ip_2_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 5 -to 0 ip_2_accumulator/B
connect_bd_net [get_bd_pins ip_2_accumulator/B] [get_bd_pins ip_2_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 33 -to 0 ip_2_accumulator/Q
connect_bd_net [get_bd_pins ip_2_accumulator/Q] [get_bd_pins ip_2_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/SCLR
connect_bd_net [get_bd_pins ip_2_accumulator/SCLR] [get_bd_pins ip_2_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/Bypass
connect_bd_net [get_bd_pins ip_2_accumulator/Bypass] [get_bd_pins ip_2_accumulator/accumulator_0/Bypass]


########## axi_timer ##########
create_bd_cell -type hier ip_3_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_3_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_3_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_timer/S_AXI] [get_bd_intf_pins ip_3_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_3_axi_timer/capturetrig0] [get_bd_pins ip_3_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_timer/freeze
connect_bd_net [get_bd_pins ip_3_axi_timer/freeze] [get_bd_pins ip_3_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_3_axi_timer/s_axi_aclk] [get_bd_pins ip_3_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_3_axi_timer/s_axi_aresetn] [get_bd_pins ip_3_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_3_axi_timer/generateout0] [get_bd_pins ip_3_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_3_axi_timer/generateout1] [get_bd_pins ip_3_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_3_axi_timer/pwm0] [get_bd_pins ip_3_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_3_axi_timer/interrupt] [get_bd_pins ip_3_axi_timer/axi_timer_0/interrupt]


########## microblaze ##########
create_bd_cell -type hier ip_4_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_4_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 52 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 5 CONFIG.C_DEBUG_COUNTER_WIDTH 48 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 20 CONFIG.C_DEBUG_EXTERNAL_TRACE 1 CONFIG.C_DEBUG_LATENCY_COUNTERS 6 CONFIG.C_DEBUG_PROFILE_SIZE 16384 CONFIG.C_DEBUG_TRACE_SIZE 128 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 1 CONFIG.C_MMU_ITLB_SIZE 1 CONFIG.C_MMU_PRIVILEGED_INSTR 0 CONFIG.C_MMU_TLB_ACCESS 3 CONFIG.C_MMU_ZONES 7 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 6 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 1 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 1 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0x9 CONFIG.C_PVR_USER2 0x597d757d CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MMU 3 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_4_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_MASK 0x90cd93d6ea2ae42 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_d]
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
set_property -dict "CONFIG.C_MASK 0x9157fcb253bf58b CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_4_microblaze/lmb_ctrl_i]
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


########## axi_iic ##########
create_bd_cell -type hier ip_5_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_5_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x19 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 38 CONFIG.C_SDA_INERTIAL_DELAY 111 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 755.5540695833872 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic/IIC] [get_bd_intf_pins ip_5_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_iic/clk
connect_bd_net [get_bd_pins ip_5_axi_iic/clk] [get_bd_pins ip_5_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_iic/reset
connect_bd_net [get_bd_pins ip_5_axi_iic/reset] [get_bd_pins ip_5_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_5_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_iic/irq
connect_bd_net [get_bd_pins ip_5_axi_iic/irq] [get_bd_pins ip_5_axi_iic/axi_iic_0/iic2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_6_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_6_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x0 CONFIG.C_GPIO2_WIDTH 14 CONFIG.C_GPIO_WIDTH 17 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_6_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/GPIO] [get_bd_intf_pins ip_6_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/GPIO2] [get_bd_intf_pins ip_6_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/clk
connect_bd_net [get_bd_pins ip_6_gpio/clk] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/rst
connect_bd_net [get_bd_pins ip_6_gpio/rst] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_6_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_gpio/irq
connect_bd_net [get_bd_pins ip_6_gpio/irq] [get_bd_pins ip_6_gpio/gpio_0/ip2intc_irpt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_7_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_7_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 11 CONFIG.aresetn 1 CONFIG.atuserwidth 191 CONFIG.bportwidth 12 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 7 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_7_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_7_complex_multiplier/aclk] [get_bd_pins ip_7_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_7_complex_multiplier/aclken] [get_bd_pins ip_7_complex_multiplier/cmpy_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_7_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_7_complex_multiplier/aresetn] [get_bd_pins ip_7_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_7_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_iic ##########
create_bd_cell -type hier ip_8_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_8_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x29 CONFIG.C_GPO_WIDTH 5 CONFIG.C_SCL_INERTIAL_DELAY 50 CONFIG.C_SDA_INERTIAL_DELAY 221 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 391.57060734737234 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_8_axi_iic/axi_iic_0]
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


########## axi_timer ##########
create_bd_cell -type hier ip_9_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_9_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.mode_64bit 1 " [get_bd_cells ip_9_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_timer/S_AXI] [get_bd_intf_pins ip_9_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_9_axi_timer/capturetrig0] [get_bd_pins ip_9_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/freeze
connect_bd_net [get_bd_pins ip_9_axi_timer/freeze] [get_bd_pins ip_9_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_9_axi_timer/s_axi_aclk] [get_bd_pins ip_9_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_9_axi_timer/s_axi_aresetn] [get_bd_pins ip_9_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_9_axi_timer/generateout0] [get_bd_pins ip_9_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_9_axi_timer/generateout1] [get_bd_pins ip_9_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_9_axi_timer/pwm0] [get_bd_pins ip_9_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_9_axi_timer/interrupt] [get_bd_pins ip_9_axi_timer/axi_timer_0/interrupt]


########## axi_hwicap ##########
create_bd_cell -type hier ip_10_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_10_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_10_axi_hwicap/axi_hwicap_0]
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


########## axi_timer ##########
create_bd_cell -type hier ip_11_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_11_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_11_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_timer/S_AXI] [get_bd_intf_pins ip_11_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_11_axi_timer/capturetrig0] [get_bd_pins ip_11_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_timer/freeze
connect_bd_net [get_bd_pins ip_11_axi_timer/freeze] [get_bd_pins ip_11_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_11_axi_timer/s_axi_aclk] [get_bd_pins ip_11_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_11_axi_timer/s_axi_aresetn] [get_bd_pins ip_11_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_11_axi_timer/generateout0] [get_bd_pins ip_11_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_11_axi_timer/generateout1] [get_bd_pins ip_11_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_11_axi_timer/pwm0] [get_bd_pins ip_11_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_11_axi_timer/interrupt] [get_bd_pins ip_11_axi_timer/axi_timer_0/interrupt]


########## axi_timer ##########
create_bd_cell -type hier ip_12_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_12_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 16 CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_12_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_timer/S_AXI] [get_bd_intf_pins ip_12_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_12_axi_timer/capturetrig0] [get_bd_pins ip_12_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_12_axi_timer/capturetrig1] [get_bd_pins ip_12_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/freeze
connect_bd_net [get_bd_pins ip_12_axi_timer/freeze] [get_bd_pins ip_12_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_12_axi_timer/s_axi_aclk] [get_bd_pins ip_12_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_12_axi_timer/s_axi_aresetn] [get_bd_pins ip_12_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_12_axi_timer/generateout0] [get_bd_pins ip_12_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_12_axi_timer/generateout1] [get_bd_pins ip_12_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_12_axi_timer/pwm0] [get_bd_pins ip_12_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_12_axi_timer/interrupt] [get_bd_pins ip_12_axi_timer/axi_timer_0/interrupt]


########## uartlite ##########
create_bd_cell -type hier ip_13_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_13_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 230400 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Odd " [get_bd_cells ip_13_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_13_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_13_uartlite/UART] [get_bd_intf_pins ip_13_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_13_uartlite/clk
connect_bd_net [get_bd_pins ip_13_uartlite/clk] [get_bd_pins ip_13_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_uartlite/reset
connect_bd_net [get_bd_pins ip_13_uartlite/reset] [get_bd_pins ip_13_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_uartlite/AXI] [get_bd_intf_pins ip_13_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_13_uartlite/irq
connect_bd_net [get_bd_pins ip_13_uartlite/irq] [get_bd_pins ip_13_uartlite/uart_0/interrupt]


########## axi_dma ##########
create_bd_cell -type hier ip_14_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_14_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 51 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_14_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_14_axi_dma/axi_resetn] [get_bd_pins ip_14_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/M_AXI] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_14_axi_dma/mm2s_introut] [get_bd_pins ip_14_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_14_axi_dma/s2mm_introut] [get_bd_pins ip_14_axi_dma/axi_dma_0/s2mm_introut]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_15_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_15_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 0 CONFIG.C_NUM_TRANSFER_BITS 8 CONFIG.C_SCK_RATIO 4 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 1 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 0 CONFIG.Master_mode 1 " [get_bd_cells ip_15_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_15_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi/IIC] [get_bd_intf_pins ip_15_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/clk4] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/reset4] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_15_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/irq] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## axi_iic ##########
create_bd_cell -type hier ip_16_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_16_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x68 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 13 CONFIG.C_SDA_INERTIAL_DELAY 105 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 632.5535509246822 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_16_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_16_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_iic/IIC] [get_bd_intf_pins ip_16_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_iic/clk
connect_bd_net [get_bd_pins ip_16_axi_iic/clk] [get_bd_pins ip_16_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_iic/reset
connect_bd_net [get_bd_pins ip_16_axi_iic/reset] [get_bd_pins ip_16_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_iic/AXI] [get_bd_intf_pins ip_16_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_iic/irq
connect_bd_net [get_bd_pins ip_16_axi_iic/irq] [get_bd_pins ip_16_axi_iic/axi_iic_0/iic2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_17_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_17_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 31 CONFIG.Iterations 27 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 43 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 44 CONFIG.Round_Mode Round_Pos_Inf " [get_bd_cells ip_17_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_cordic/aclk
connect_bd_net [get_bd_pins ip_17_cordic/aclk] [get_bd_pins ip_17_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_17_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_17_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_17_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_17_cordic/cordic_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_18_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_18_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 5 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 32 CONFIG.C_MEM3_TYPE 5 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 11 CONFIG.C_TAVDV_PS_MEM_0 16336 CONFIG.C_TAVDV_PS_MEM_1 13503 CONFIG.C_TAVDV_PS_MEM_2 16149 CONFIG.C_TAVDV_PS_MEM_3 16243 CONFIG.C_TCEDV_PS_MEM_0 14630 CONFIG.C_TCEDV_PS_MEM_1 15461 CONFIG.C_TCEDV_PS_MEM_2 16163 CONFIG.C_TCEDV_PS_MEM_3 15173 CONFIG.C_THZCE_PS_MEM_0 6783 CONFIG.C_THZCE_PS_MEM_1 6765 CONFIG.C_THZCE_PS_MEM_2 7096 CONFIG.C_THZCE_PS_MEM_3 6416 CONFIG.C_THZOE_PS_MEM_0 6532 CONFIG.C_THZOE_PS_MEM_1 7162 CONFIG.C_THZOE_PS_MEM_2 7275 CONFIG.C_THZOE_PS_MEM_3 7559 CONFIG.C_TLZWE_PS_MEM_0 3021 CONFIG.C_TLZWE_PS_MEM_1 8940 CONFIG.C_TLZWE_PS_MEM_2 3821 CONFIG.C_TLZWE_PS_MEM_3 7338 CONFIG.C_TWC_PS_MEM_0 14181 CONFIG.C_TWC_PS_MEM_1 16497 CONFIG.C_TWC_PS_MEM_2 13955 CONFIG.C_TWC_PS_MEM_3 14562 CONFIG.C_TWPH_PS_MEM_0 12535 CONFIG.C_TWPH_PS_MEM_1 11421 CONFIG.C_TWPH_PS_MEM_2 12385 CONFIG.C_TWPH_PS_MEM_3 11166 CONFIG.C_TWP_PS_MEM_0 11243 CONFIG.C_TWP_PS_MEM_1 12607 CONFIG.C_TWP_PS_MEM_2 11374 CONFIG.C_TWP_PS_MEM_3 11665 CONFIG.C_WR_REC_TIME_MEM_0 25032 CONFIG.C_WR_REC_TIME_MEM_1 27142 CONFIG.C_WR_REC_TIME_MEM_2 25444 CONFIG.C_WR_REC_TIME_MEM_3 28290 " [get_bd_cells ip_18_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_18_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_18_emc/EMC_INTF] [get_bd_intf_pins ip_18_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_18_emc/clk
connect_bd_net [get_bd_pins ip_18_emc/clk] [get_bd_pins ip_18_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_emc/rdclk
connect_bd_net [get_bd_pins ip_18_emc/rdclk] [get_bd_pins ip_18_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_emc/rst
connect_bd_net [get_bd_pins ip_18_emc/rst] [get_bd_pins ip_18_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_emc/AXI] [get_bd_intf_pins ip_18_emc/emc_0/S_AXI_MEM]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_19_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_19_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 1 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_19_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_19_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_quad_spi/IIC] [get_bd_intf_pins ip_19_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_19_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_19_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_19_axi_quad_spi/clk] [get_bd_pins ip_19_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_19_axi_quad_spi/reset] [get_bd_pins ip_19_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_19_axi_quad_spi/clk4] [get_bd_pins ip_19_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_19_axi_quad_spi/reset4] [get_bd_pins ip_19_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_19_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_19_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_19_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_19_axi_quad_spi/irq] [get_bd_pins ip_19_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_20_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_20_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Even " [get_bd_cells ip_20_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_20_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_20_uartlite/UART] [get_bd_intf_pins ip_20_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_20_uartlite/clk
connect_bd_net [get_bd_pins ip_20_uartlite/clk] [get_bd_pins ip_20_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_uartlite/reset
connect_bd_net [get_bd_pins ip_20_uartlite/reset] [get_bd_pins ip_20_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_20_uartlite/AXI] [get_bd_intf_pins ip_20_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_20_uartlite/irq
connect_bd_net [get_bd_pins ip_20_uartlite/irq] [get_bd_pins ip_20_uartlite/uart_0/interrupt]


########## dft ##########
create_bd_cell -type hier ip_21_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_21_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 13 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_21_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/CLK
connect_bd_net [get_bd_pins ip_21_dft/CLK] [get_bd_pins ip_21_dft/dft_0/CLK]
create_bd_pin -dir I -from 12 -to 0 ip_21_dft/XN_RE
connect_bd_net [get_bd_pins ip_21_dft/XN_RE] [get_bd_pins ip_21_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 12 -to 0 ip_21_dft/XN_IM
connect_bd_net [get_bd_pins ip_21_dft/XN_IM] [get_bd_pins ip_21_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/FD_IN
connect_bd_net [get_bd_pins ip_21_dft/FD_IN] [get_bd_pins ip_21_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/FWD_INV
connect_bd_net [get_bd_pins ip_21_dft/FWD_INV] [get_bd_pins ip_21_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_21_dft/SIZE
connect_bd_net [get_bd_pins ip_21_dft/SIZE] [get_bd_pins ip_21_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_21_dft/RFFD
connect_bd_net [get_bd_pins ip_21_dft/RFFD] [get_bd_pins ip_21_dft/dft_0/RFFD]
create_bd_pin -dir O -from 12 -to 0 ip_21_dft/XK_RE
connect_bd_net [get_bd_pins ip_21_dft/XK_RE] [get_bd_pins ip_21_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 12 -to 0 ip_21_dft/XK_IM
connect_bd_net [get_bd_pins ip_21_dft/XK_IM] [get_bd_pins ip_21_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_21_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_21_dft/BLK_EXP] [get_bd_pins ip_21_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_21_dft/FD_OUT
connect_bd_net [get_bd_pins ip_21_dft/FD_OUT] [get_bd_pins ip_21_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_21_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_21_dft/DATA_VALID] [get_bd_pins ip_21_dft/dft_0/DATA_VALID]


########## reset ##########
create_bd_cell -type hier ip_22_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_22_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_reset/clk_in
connect_bd_net [get_bd_pins ip_22_reset/clk_in] [get_bd_pins ip_22_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_22_reset/reset_in
connect_bd_net [get_bd_pins ip_22_reset/reset_in] [get_bd_pins ip_22_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_22_reset/dcm_locked
connect_bd_net [get_bd_pins ip_22_reset/dcm_locked] [get_bd_pins ip_22_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_22_reset/mb_reset
connect_bd_net [get_bd_pins ip_22_reset/mb_reset] [get_bd_pins ip_22_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_22_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_22_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_22_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset] [get_bd_pins ip_22_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_22_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_22_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_23_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_23_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_in] [get_bd_pins ip_23_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_23_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_23_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_23_clk_wiz/reset
connect_bd_net [get_bd_pins ip_23_clk_wiz/reset] [get_bd_pins ip_23_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_23_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_locked] [get_bd_pins ip_23_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_24_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_24_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_24_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 15 " [get_bd_cells ip_24_intc/concat_0]
connect_bd_net [get_bd_pins ip_24_intc/concat_0/dout] [get_bd_pins ip_24_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/clk
connect_bd_net [get_bd_pins ip_24_intc/clk] [get_bd_pins ip_24_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/reset
connect_bd_net [get_bd_pins ip_24_intc/reset] [get_bd_pins ip_24_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_24_intc/AXI] [get_bd_intf_pins ip_24_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_0
connect_bd_net [get_bd_pins ip_24_intc/irq_0] [get_bd_pins ip_24_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_1
connect_bd_net [get_bd_pins ip_24_intc/irq_1] [get_bd_pins ip_24_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_2
connect_bd_net [get_bd_pins ip_24_intc/irq_2] [get_bd_pins ip_24_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_3
connect_bd_net [get_bd_pins ip_24_intc/irq_3] [get_bd_pins ip_24_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_4
connect_bd_net [get_bd_pins ip_24_intc/irq_4] [get_bd_pins ip_24_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_5
connect_bd_net [get_bd_pins ip_24_intc/irq_5] [get_bd_pins ip_24_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_6
connect_bd_net [get_bd_pins ip_24_intc/irq_6] [get_bd_pins ip_24_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_7
connect_bd_net [get_bd_pins ip_24_intc/irq_7] [get_bd_pins ip_24_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_8
connect_bd_net [get_bd_pins ip_24_intc/irq_8] [get_bd_pins ip_24_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_9
connect_bd_net [get_bd_pins ip_24_intc/irq_9] [get_bd_pins ip_24_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_10
connect_bd_net [get_bd_pins ip_24_intc/irq_10] [get_bd_pins ip_24_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_11
connect_bd_net [get_bd_pins ip_24_intc/irq_11] [get_bd_pins ip_24_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_12
connect_bd_net [get_bd_pins ip_24_intc/irq_12] [get_bd_pins ip_24_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_13
connect_bd_net [get_bd_pins ip_24_intc/irq_13] [get_bd_pins ip_24_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_14
connect_bd_net [get_bd_pins ip_24_intc/irq_14] [get_bd_pins ip_24_intc/concat_0/In14]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_24_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_24_intc/irq] [get_bd_intf_pins ip_24_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_25_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_25_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 2 " [get_bd_cells ip_25_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi/clk
connect_bd_net [get_bd_pins ip_25_axi/clk] [get_bd_pins ip_25_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi/reset
connect_bd_net [get_bd_pins ip_25_axi/reset] [get_bd_pins ip_25_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_M0] [get_bd_intf_pins ip_25_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_M1] [get_bd_intf_pins ip_25_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S0] [get_bd_intf_pins ip_25_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_25_axi/AXI_S1] [get_bd_intf_pins ip_25_axi/axi_0/M01_AXI]


########## axi ##########
create_bd_cell -type hier ip_26_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_26_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_26_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi/clk
connect_bd_net [get_bd_pins ip_26_axi/clk] [get_bd_pins ip_26_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi/reset
connect_bd_net [get_bd_pins ip_26_axi/reset] [get_bd_pins ip_26_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_M0] [get_bd_intf_pins ip_26_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S0] [get_bd_intf_pins ip_26_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S1] [get_bd_intf_pins ip_26_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S2] [get_bd_intf_pins ip_26_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S3] [get_bd_intf_pins ip_26_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S4] [get_bd_intf_pins ip_26_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S5] [get_bd_intf_pins ip_26_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S6] [get_bd_intf_pins ip_26_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S7] [get_bd_intf_pins ip_26_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S8] [get_bd_intf_pins ip_26_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S9] [get_bd_intf_pins ip_26_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S10] [get_bd_intf_pins ip_26_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S11] [get_bd_intf_pins ip_26_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S12] [get_bd_intf_pins ip_26_axi/axi_0/M12_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S13] [get_bd_intf_pins ip_26_axi/axi_0/M13_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S14] [get_bd_intf_pins ip_26_axi/axi_0/M14_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_26_axi/AXI_S15] [get_bd_intf_pins ip_26_axi/axi_0/M15_AXI]


########## axi ##########
create_bd_cell -type hier ip_27_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_27_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 1 CONFIG.NUM_SI 1 " [get_bd_cells ip_27_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axi/clk
connect_bd_net [get_bd_pins ip_27_axi/clk] [get_bd_pins ip_27_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axi/reset
connect_bd_net [get_bd_pins ip_27_axi/reset] [get_bd_pins ip_27_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_M0] [get_bd_intf_pins ip_27_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_27_axi/AXI_S0] [get_bd_intf_pins ip_27_axi/axi_0/M00_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_28_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_28_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_28_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_28_axis_broadcaster/aclk] [get_bd_pins ip_28_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_28_axis_broadcaster/aresetn] [get_bd_pins ip_28_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_29_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_29_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_29_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_29_axis_dwidth_converter/aclk] [get_bd_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_29_axis_dwidth_converter/aresetn] [get_bd_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_30_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_30_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_31_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aclk] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aresetn] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_33_reduce
create_bd_pin -dir I -from 46 -to 0 ip_33_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_33_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_33_reduce/concat]
connect_bd_net [get_bd_pins ip_33_reduce/out0] [get_bd_pins ip_33_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_0]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_33_reduce/slice_0/dout] [get_bd_pins ip_33_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_0/Res] [get_bd_pins ip_33_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_1]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_33_reduce/slice_1/dout] [get_bd_pins ip_33_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_1/Res] [get_bd_pins ip_33_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_2]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_33_reduce/slice_2/dout] [get_bd_pins ip_33_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_2/Res] [get_bd_pins ip_33_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_3]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_33_reduce/slice_3/dout] [get_bd_pins ip_33_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_3/Res] [get_bd_pins ip_33_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_4]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_33_reduce/slice_4/dout] [get_bd_pins ip_33_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_4/Res] [get_bd_pins ip_33_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_5]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_33_reduce/slice_5/dout] [get_bd_pins ip_33_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_5/Res] [get_bd_pins ip_33_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_6]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_33_reduce/slice_6/dout] [get_bd_pins ip_33_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_6/Res] [get_bd_pins ip_33_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 14 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_7]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_33_reduce/slice_7/dout] [get_bd_pins ip_33_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_7/Res] [get_bd_pins ip_33_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_8]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_33_reduce/slice_8/dout] [get_bd_pins ip_33_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_8/Res] [get_bd_pins ip_33_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_9]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_33_reduce/slice_9/dout] [get_bd_pins ip_33_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_9/Res] [get_bd_pins ip_33_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 21 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_10]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_33_reduce/slice_10/dout] [get_bd_pins ip_33_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_10/Res] [get_bd_pins ip_33_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 22 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_11]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_33_reduce/slice_11/dout] [get_bd_pins ip_33_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_11/Res] [get_bd_pins ip_33_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 25 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_12]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_33_reduce/slice_12/dout] [get_bd_pins ip_33_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_12/Res] [get_bd_pins ip_33_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 27 CONFIG.DIN_TO 26 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_13]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_33_reduce/slice_13/dout] [get_bd_pins ip_33_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_13/Res] [get_bd_pins ip_33_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 28 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_14]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_33_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_33_reduce/slice_14/dout] [get_bd_pins ip_33_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_14/Res] [get_bd_pins ip_33_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_15]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_33_reduce/slice_15/dout] [get_bd_pins ip_33_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_15/Res] [get_bd_pins ip_33_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_16]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_33_reduce/slice_16/dout] [get_bd_pins ip_33_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_16/Res] [get_bd_pins ip_33_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_17]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_33_reduce/slice_17/dout] [get_bd_pins ip_33_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_17/Res] [get_bd_pins ip_33_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 33 CONFIG.DIN_TO 33 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_18]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_33_reduce/slice_18/dout] [get_bd_pins ip_33_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_18/Res] [get_bd_pins ip_33_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 34 CONFIG.DIN_TO 34 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_19]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_33_reduce/slice_19/dout] [get_bd_pins ip_33_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_19/Res] [get_bd_pins ip_33_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 35 CONFIG.DIN_TO 35 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_20]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_33_reduce/slice_20/dout] [get_bd_pins ip_33_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_20/Res] [get_bd_pins ip_33_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 36 CONFIG.DIN_TO 36 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_21]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_33_reduce/slice_21/dout] [get_bd_pins ip_33_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_21/Res] [get_bd_pins ip_33_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 37 CONFIG.DIN_TO 37 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_22]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_33_reduce/slice_22/dout] [get_bd_pins ip_33_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_22/Res] [get_bd_pins ip_33_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 38 CONFIG.DIN_TO 38 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_23]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_33_reduce/slice_23/dout] [get_bd_pins ip_33_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_23/Res] [get_bd_pins ip_33_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 39 CONFIG.DIN_TO 39 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_24]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_33_reduce/slice_24/dout] [get_bd_pins ip_33_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_24/Res] [get_bd_pins ip_33_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 40 CONFIG.DIN_TO 40 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_25]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_33_reduce/slice_25/dout] [get_bd_pins ip_33_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_25/Res] [get_bd_pins ip_33_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 41 CONFIG.DIN_TO 41 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_26]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_33_reduce/slice_26/dout] [get_bd_pins ip_33_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_26/Res] [get_bd_pins ip_33_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 42 CONFIG.DIN_TO 42 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_27]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_33_reduce/slice_27/dout] [get_bd_pins ip_33_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_27/Res] [get_bd_pins ip_33_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 43 CONFIG.DIN_TO 43 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_28]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_33_reduce/slice_28/dout] [get_bd_pins ip_33_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_28/Res] [get_bd_pins ip_33_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 44 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_29]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_33_reduce/slice_29/dout] [get_bd_pins ip_33_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_29/Res] [get_bd_pins ip_33_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 45 CONFIG.DIN_TO 45 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_30]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_33_reduce/slice_30/dout] [get_bd_pins ip_33_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_30/Res] [get_bd_pins ip_33_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 46 CONFIG.DIN_TO 46 CONFIG.DIN_WIDTH 47 " [get_bd_cells ip_33_reduce/slice_31]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_33_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_33_reduce/slice_31/dout] [get_bd_pins ip_33_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_31/Res] [get_bd_pins ip_33_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_34_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_34_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_1] [get_bd_pins ip_34_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_2] [get_bd_pins ip_34_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_3] [get_bd_pins ip_34_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_4] [get_bd_pins ip_34_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_5] [get_bd_pins ip_34_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_6] [get_bd_pins ip_34_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 15 -to 0 ip_34_slice_and_concat/in_7
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_34_slice_and_concat/slice_7]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_7] [get_bd_pins ip_34_slice_and_concat/slice_7/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/slice_7/dout] [get_bd_pins ip_34_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 15 -to 0 ip_35_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_35_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 15 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/slice_0/dout] [get_bd_pins ip_35_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 15 -to 0 ip_35_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_35_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_35_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/slice_1/dout] [get_bd_pins ip_35_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 46 -to 0 ip_36_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_36_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 15 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/slice_0/dout] [get_bd_pins ip_36_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_36_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_1] [get_bd_pins ip_36_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_36_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_2] [get_bd_pins ip_36_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_36_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_3] [get_bd_pins ip_36_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 33 -to 0 ip_36_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_36_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_4] [get_bd_pins ip_36_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/slice_4/dout] [get_bd_pins ip_36_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 33 -to 0 ip_37_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_37_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_38_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 12 " [get_bd_cells ip_38_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 33 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 33 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 34 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/slice_0/dout] [get_bd_pins ip_38_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_1] [get_bd_pins ip_38_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_2] [get_bd_pins ip_38_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_3] [get_bd_pins ip_38_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_4] [get_bd_pins ip_38_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_5] [get_bd_pins ip_38_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_6] [get_bd_pins ip_38_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_7] [get_bd_pins ip_38_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_8] [get_bd_pins ip_38_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_9] [get_bd_pins ip_38_slice_and_concat/concat/In9]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_10
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_10] [get_bd_pins ip_38_slice_and_concat/concat/In10]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_11
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_11] [get_bd_pins ip_38_slice_and_concat/concat/In11]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_39_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_39_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_39_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_1] [get_bd_pins ip_39_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 12 -to 0 ip_39_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_39_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_2] [get_bd_pins ip_39_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/slice_2/dout] [get_bd_pins ip_39_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_40_slice_and_concat/out0
create_bd_pin -dir I -from 12 -to 0 ip_40_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_40_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_40_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 15 -to 0 ip_41_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_41_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 12 -to 0 ip_41_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_41_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_41_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/slice_0/dout] [get_bd_pins ip_41_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 12 -to 0 ip_41_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_41_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_42_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_42_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_42_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_42_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_42_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_1] [get_bd_pins ip_42_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_42_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_2] [get_bd_pins ip_42_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_43_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_43_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_43_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_43_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_44_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_44_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_44_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_45_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_45_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_45_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_46_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_46_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_46_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_46_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_47_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_47_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_47_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_47_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_47_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_48_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_48_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_48_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_48_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_48_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_48_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_49_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_49_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_49_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_49_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_49_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_49_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_50_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_50_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_50_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_50_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_51_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_51_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_52_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_52_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_53_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_53_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_54_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_54_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_54_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_54_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_55_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_56_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_57_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_57_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_57_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_57_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_58_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_22_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_23_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_0_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_0_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_0_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio_GPIO] [get_bd_intf_pins ip_6_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio_GPIO2] [get_bd_intf_pins ip_6_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_8_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_iic_IIC] [get_bd_intf_pins ip_8_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_10_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap_ICAP] [get_bd_intf_pins ip_10_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_10_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_10_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_13_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_13_uartlite_UART] [get_bd_intf_pins ip_13_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_15_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi_IIC] [get_bd_intf_pins ip_15_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_16_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_iic_IIC] [get_bd_intf_pins ip_16_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_18_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_18_emc_EMC_INTF] [get_bd_intf_pins ip_18_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_19_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_quad_spi_IIC] [get_bd_intf_pins ip_19_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_20_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_20_uartlite_UART] [get_bd_intf_pins ip_20_uartlite/UART]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_33_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 7 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_43_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_54_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_57_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_23_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_24_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset] [get_bd_pins ip_0_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset] [get_bd_pins ip_1_dft/SCLR]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_22_reset/mb_reset] [get_bd_pins ip_4_microblaze/Reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_6_gpio/rst]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_7_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_iic/reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_13_uartlite/reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_16_axi_iic/reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_18_emc/rst]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_19_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_19_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_20_uartlite/reset]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_0_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_1_dft/CLK]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_2_accumulator/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_3_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_4_microblaze/Clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_6_gpio/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_7_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_8_axi_iic/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_9_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_10_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_10_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_11_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_12_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_13_uartlite/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_15_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_15_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_16_axi_iic/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_17_cordic/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_18_emc/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_18_emc/rdclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_19_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_19_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_19_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_20_uartlite/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_21_dft/CLK]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_22_reset/clk_in]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_locked] [get_bd_pins ip_22_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_24_intc/irq_0] [get_bd_pins ip_3_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_24_intc/irq_1] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_2] [get_bd_pins ip_6_gpio/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_3] [get_bd_pins ip_8_axi_iic/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_4] [get_bd_pins ip_9_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_24_intc/irq_5] [get_bd_pins ip_10_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_24_intc/irq_6] [get_bd_pins ip_11_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_24_intc/irq_7] [get_bd_pins ip_12_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_24_intc/irq_8] [get_bd_pins ip_13_uartlite/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_9] [get_bd_pins ip_14_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_24_intc/irq_10] [get_bd_pins ip_14_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_24_intc/irq_11] [get_bd_pins ip_15_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_12] [get_bd_pins ip_16_axi_iic/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_13] [get_bd_pins ip_19_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_14] [get_bd_pins ip_20_uartlite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/INTERRUPT] [get_bd_intf_pins ip_24_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_microblaze/M_AXI_DP] [get_bd_intf_pins ip_25_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/M_AXI] [get_bd_intf_pins ip_25_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axi/AXI_S0] [get_bd_intf_pins ip_26_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_timer/S_AXI] [get_bd_intf_pins ip_26_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_26_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_26_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_iic/AXI] [get_bd_intf_pins ip_26_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_timer/S_AXI] [get_bd_intf_pins ip_26_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_26_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_timer/S_AXI] [get_bd_intf_pins ip_26_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_timer/S_AXI] [get_bd_intf_pins ip_26_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_uartlite/AXI] [get_bd_intf_pins ip_26_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_26_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_26_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_iic/AXI] [get_bd_intf_pins ip_26_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_emc/AXI] [get_bd_intf_pins ip_26_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_26_axi/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_26_axi/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_uartlite/AXI] [get_bd_intf_pins ip_26_axi/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axi/AXI_S1] [get_bd_intf_pins ip_27_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_intc/AXI] [get_bd_intf_pins ip_27_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_7_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_21_dft/XN_RE]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_1] [get_bd_pins ip_0_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_2] [get_bd_pins ip_0_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_3] [get_bd_pins ip_0_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_4] [get_bd_pins ip_0_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_5] [get_bd_pins ip_0_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_6] [get_bd_pins ip_1_dft/RFFD]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_7] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_RE]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_33_reduce/in0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_1] [get_bd_pins ip_1_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_2] [get_bd_pins ip_1_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_3] [get_bd_pins ip_1_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_4] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_10_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_21_dft/XN_IM]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_1] [get_bd_pins ip_3_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_2] [get_bd_pins ip_3_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_3] [get_bd_pins ip_3_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_4] [get_bd_pins ip_9_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_5] [get_bd_pins ip_9_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_6] [get_bd_pins ip_9_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_7] [get_bd_pins ip_11_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_8] [get_bd_pins ip_11_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_9] [get_bd_pins ip_11_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_10] [get_bd_pins ip_12_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_11] [get_bd_pins ip_12_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_1_dft/SIZE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_12_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_1] [get_bd_pins ip_21_dft/RFFD]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_2] [get_bd_pins ip_21_dft/XK_RE]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_21_dft/SIZE]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_21_dft/XK_RE]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_IM]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_21_dft/XK_RE]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_21_dft/XK_IM]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/B]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_21_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_1] [get_bd_pins ip_21_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_2] [get_bd_pins ip_21_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_3_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_1_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_12_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_11_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_9_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_21_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_12_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_11_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_9_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_12_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_1_dft/FD_IN]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_21_dft/FD_IN]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_7_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_3_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_25_axi/reset]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_26_axi/reset]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_27_axi/reset]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_24_intc/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_25_axi/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_26_axi/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_27_axi/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_28_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_29_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/M_AXIS_DOUT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_complex_multiplier/M_AXIS_DOUT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_cordic/S_AXIS_PHASE declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_cordic/S_AXIS_PHASE declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_cordic/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_cordic/M_AXIS_DOUT declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }


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
