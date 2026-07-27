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
set_property -dict "CONFIG.C_ADDR_WIDTH 43 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_0_axi_cdma/axi_cdma_0]
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


########## xadc_wiz ##########
create_bd_cell -type hier ip_1_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_1_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_1_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_1_xadc_wiz/dclk_in] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_1_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_1_xadc_wiz/convst_in] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/ot_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/eoc_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/eos_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/alarm_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/busy_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_1_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_1_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_1_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/jtaglocked_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/jtagmodified_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/jtagbusy_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## complex_multiplier ##########
create_bd_cell -type hier ip_2_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_2_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 22 CONFIG.aresetn 0 CONFIG.atuserwidth 161 CONFIG.bportwidth 20 CONFIG.btuserwidth 237 CONFIG.ctrltuserwidth 152 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 1 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Manual CONFIG.minimumlatency 29 CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 37 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_2_complex_multiplier/cmpy_0]
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


########## axi_hwicap ##########
create_bd_cell -type hier ip_3_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_3_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_3_axi_hwicap/axi_hwicap_0]
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


########## dft ##########
create_bd_cell -type hier ip_4_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_4_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 16 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_4_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CLK
connect_bd_net [get_bd_pins ip_4_dft/CLK] [get_bd_pins ip_4_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CE
connect_bd_net [get_bd_pins ip_4_dft/CE] [get_bd_pins ip_4_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/SCLR
connect_bd_net [get_bd_pins ip_4_dft/SCLR] [get_bd_pins ip_4_dft/dft_0/SCLR]
create_bd_pin -dir I -from 15 -to 0 ip_4_dft/XN_RE
connect_bd_net [get_bd_pins ip_4_dft/XN_RE] [get_bd_pins ip_4_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 15 -to 0 ip_4_dft/XN_IM
connect_bd_net [get_bd_pins ip_4_dft/XN_IM] [get_bd_pins ip_4_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FD_IN
connect_bd_net [get_bd_pins ip_4_dft/FD_IN] [get_bd_pins ip_4_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FWD_INV
connect_bd_net [get_bd_pins ip_4_dft/FWD_INV] [get_bd_pins ip_4_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_4_dft/SIZE
connect_bd_net [get_bd_pins ip_4_dft/SIZE] [get_bd_pins ip_4_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/RFFD
connect_bd_net [get_bd_pins ip_4_dft/RFFD] [get_bd_pins ip_4_dft/dft_0/RFFD]
create_bd_pin -dir O -from 15 -to 0 ip_4_dft/XK_RE
connect_bd_net [get_bd_pins ip_4_dft/XK_RE] [get_bd_pins ip_4_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 15 -to 0 ip_4_dft/XK_IM
connect_bd_net [get_bd_pins ip_4_dft/XK_IM] [get_bd_pins ip_4_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_4_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_4_dft/BLK_EXP] [get_bd_pins ip_4_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/FD_OUT
connect_bd_net [get_bd_pins ip_4_dft/FD_OUT] [get_bd_pins ip_4_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_4_dft/DATA_VALID] [get_bd_pins ip_4_dft/dft_0/DATA_VALID]


########## accumulator ##########
create_bd_cell -type hier ip_5_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_5_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 20 CONFIG.Latency 2 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 27 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_5_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/clk
connect_bd_net [get_bd_pins ip_5_accumulator/clk] [get_bd_pins ip_5_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 19 -to 0 ip_5_accumulator/B
connect_bd_net [get_bd_pins ip_5_accumulator/B] [get_bd_pins ip_5_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 26 -to 0 ip_5_accumulator/Q
connect_bd_net [get_bd_pins ip_5_accumulator/Q] [get_bd_pins ip_5_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/ADD
connect_bd_net [get_bd_pins ip_5_accumulator/ADD] [get_bd_pins ip_5_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/CE
connect_bd_net [get_bd_pins ip_5_accumulator/CE] [get_bd_pins ip_5_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/Bypass
connect_bd_net [get_bd_pins ip_5_accumulator/Bypass] [get_bd_pins ip_5_accumulator/accumulator_0/Bypass]


########## axi_iic ##########
create_bd_cell -type hier ip_6_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_6_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x13 CONFIG.C_GPO_WIDTH 3 CONFIG.C_SCL_INERTIAL_DELAY 114 CONFIG.C_SDA_INERTIAL_DELAY 224 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 804.334559629223 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_6_axi_iic/axi_iic_0]
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


########## reset ##########
create_bd_cell -type hier ip_7_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_7_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_reset/clk_in
connect_bd_net [get_bd_pins ip_7_reset/clk_in] [get_bd_pins ip_7_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_7_reset/reset_in
connect_bd_net [get_bd_pins ip_7_reset/reset_in] [get_bd_pins ip_7_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_7_reset/dcm_locked
connect_bd_net [get_bd_pins ip_7_reset/dcm_locked] [get_bd_pins ip_7_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/mb_reset
connect_bd_net [get_bd_pins ip_7_reset/mb_reset] [get_bd_pins ip_7_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_7_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset] [get_bd_pins ip_7_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_7_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_8_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_8_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_in] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_8_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_8_clk_wiz/reset
connect_bd_net [get_bd_pins ip_8_clk_wiz/reset] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_8_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_locked] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_9_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_9_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_9_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_9_intc/concat_0]
connect_bd_net [get_bd_pins ip_9_intc/concat_0/dout] [get_bd_pins ip_9_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/clk
connect_bd_net [get_bd_pins ip_9_intc/clk] [get_bd_pins ip_9_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/reset
connect_bd_net [get_bd_pins ip_9_intc/reset] [get_bd_pins ip_9_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_intc/AXI] [get_bd_intf_pins ip_9_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_0
connect_bd_net [get_bd_pins ip_9_intc/irq_0] [get_bd_pins ip_9_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_1
connect_bd_net [get_bd_pins ip_9_intc/irq_1] [get_bd_pins ip_9_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_2
connect_bd_net [get_bd_pins ip_9_intc/irq_2] [get_bd_pins ip_9_intc/concat_0/In2]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_9_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_9_intc/irq] [get_bd_intf_pins ip_9_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_10_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_10_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 1 " [get_bd_cells ip_10_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_legacy/clk
connect_bd_net [get_bd_pins ip_10_axi_legacy/clk] [get_bd_pins ip_10_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_legacy/reset
connect_bd_net [get_bd_pins ip_10_axi_legacy/reset] [get_bd_pins ip_10_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_legacy/AXI_M0] [get_bd_intf_pins ip_10_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_10_axi_legacy/clk] [get_bd_pins ip_10_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_10_axi_legacy/reset] [get_bd_pins ip_10_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_legacy/AXI_S0] [get_bd_intf_pins ip_10_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_10_axi_legacy/clk] [get_bd_pins ip_10_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_10_axi_legacy/reset] [get_bd_pins ip_10_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_legacy/AXI_S1] [get_bd_intf_pins ip_10_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_10_axi_legacy/clk] [get_bd_pins ip_10_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_10_axi_legacy/reset] [get_bd_pins ip_10_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_legacy/AXI_S2] [get_bd_intf_pins ip_10_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_10_axi_legacy/clk] [get_bd_pins ip_10_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_10_axi_legacy/reset] [get_bd_pins ip_10_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_legacy/AXI_S3] [get_bd_intf_pins ip_10_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_10_axi_legacy/clk] [get_bd_pins ip_10_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_10_axi_legacy/reset] [get_bd_pins ip_10_axi_legacy/axi_0/M03_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_11_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_11_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_11_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_11_axis_broadcaster/aclk] [get_bd_pins ip_11_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_11_axis_broadcaster/aresetn] [get_bd_pins ip_11_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_12_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_12_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_12_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_13_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aclk] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aresetn] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_14_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_14_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_14_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_15_axis_dwidth_converter/axis_dwidth_converter_0]
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
create_bd_pin -dir O -from 0 -to 0 ip_16_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 15 -to 0 ip_17_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_17_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_17_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_2] [get_bd_pins ip_17_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_3] [get_bd_pins ip_17_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_4] [get_bd_pins ip_17_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_5] [get_bd_pins ip_17_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 15 -to 0 ip_17_slice_and_concat/in_6
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_17_slice_and_concat/slice_6]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_6] [get_bd_pins ip_17_slice_and_concat/slice_6/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/slice_6/dout] [get_bd_pins ip_17_slice_and_concat/concat/In6]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 15 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 15 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 15 -to 0 ip_19_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 19 -to 0 ip_20_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_20_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_20_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_20_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_20_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 26 -to 0 ip_20_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 27 " [get_bd_cells ip_20_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_3] [get_bd_pins ip_20_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/slice_3/dout] [get_bd_pins ip_20_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_21_slice_and_concat/out0
create_bd_pin -dir I -from 26 -to 0 ip_21_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 26 CONFIG.DIN_TO 14 CONFIG.DIN_WIDTH 27 " [get_bd_cells ip_21_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_21_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/slice_0/dout]


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


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_8_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_1_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_1_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_1_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_6_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic_IIC] [get_bd_intf_pins ip_6_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_9_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_11_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 12 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_21_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset] [get_bd_pins ip_4_dft/SCLR]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_iic/reset]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_0_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_1_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_2_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_3_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_3_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_4_dft/CLK]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_5_accumulator/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_6_axi_iic/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_7_reset/clk_in]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_locked] [get_bd_pins ip_7_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_9_intc/irq_0] [get_bd_pins ip_0_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_9_intc/irq_1] [get_bd_pins ip_3_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_9_intc/irq_2] [get_bd_pins ip_6_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/M_AXI] [get_bd_intf_pins ip_10_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_iic/AXI] [get_bd_intf_pins ip_10_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_intc/AXI] [get_bd_intf_pins ip_10_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_2_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_3_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_IM]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_1_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_2] [get_bd_pins ip_1_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_3] [get_bd_pins ip_1_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_4] [get_bd_pins ip_1_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_5] [get_bd_pins ip_4_dft/RFFD]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_6] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_4_dft/SIZE]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_RE]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/B]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_4_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_4_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_2] [get_bd_pins ip_4_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_3] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_2_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/ADD]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/CE]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_1_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_4_dft/CE]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_4_dft/FD_IN]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_4_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_10_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_11_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_12_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_13_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_9_intc/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_10_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_11_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_12_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_13_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_14_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_15_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_B declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_B declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/M_AXIS_DOUT declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/M_AXIS_DOUT declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }


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
