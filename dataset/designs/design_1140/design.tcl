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
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Translate CONFIG.Input_Width 25 CONFIG.Iterations 29 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 28 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 35 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_0_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aclk
connect_bd_net [get_bd_pins ip_0_cordic/aclk] [get_bd_pins ip_0_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aresetn
connect_bd_net [get_bd_pins ip_0_cordic/aresetn] [get_bd_pins ip_0_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]


########## xadc_wiz ##########
create_bd_cell -type hier ip_1_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_1_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_1_xadc_wiz/xadc_wiz_0]
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


########## dft ##########
create_bd_cell -type hier ip_2_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_2_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 10 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_2_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/CLK
connect_bd_net [get_bd_pins ip_2_dft/CLK] [get_bd_pins ip_2_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/SCLR
connect_bd_net [get_bd_pins ip_2_dft/SCLR] [get_bd_pins ip_2_dft/dft_0/SCLR]
create_bd_pin -dir I -from 9 -to 0 ip_2_dft/XN_RE
connect_bd_net [get_bd_pins ip_2_dft/XN_RE] [get_bd_pins ip_2_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 9 -to 0 ip_2_dft/XN_IM
connect_bd_net [get_bd_pins ip_2_dft/XN_IM] [get_bd_pins ip_2_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/FD_IN
connect_bd_net [get_bd_pins ip_2_dft/FD_IN] [get_bd_pins ip_2_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/FWD_INV
connect_bd_net [get_bd_pins ip_2_dft/FWD_INV] [get_bd_pins ip_2_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_2_dft/SIZE
connect_bd_net [get_bd_pins ip_2_dft/SIZE] [get_bd_pins ip_2_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_2_dft/RFFD
connect_bd_net [get_bd_pins ip_2_dft/RFFD] [get_bd_pins ip_2_dft/dft_0/RFFD]
create_bd_pin -dir O -from 9 -to 0 ip_2_dft/XK_RE
connect_bd_net [get_bd_pins ip_2_dft/XK_RE] [get_bd_pins ip_2_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 9 -to 0 ip_2_dft/XK_IM
connect_bd_net [get_bd_pins ip_2_dft/XK_IM] [get_bd_pins ip_2_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_2_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_2_dft/BLK_EXP] [get_bd_pins ip_2_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_2_dft/FD_OUT
connect_bd_net [get_bd_pins ip_2_dft/FD_OUT] [get_bd_pins ip_2_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_2_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_2_dft/DATA_VALID] [get_bd_pins ip_2_dft/dft_0/DATA_VALID]


########## conv_encoder ##########
create_bd_cell -type hier ip_3_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_3_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 8 CONFIG.convolution_code0 149 CONFIG.convolution_code1 149 CONFIG.convolution_code2 154 CONFIG.convolution_code3 78 CONFIG.convolution_code4 227 CONFIG.convolution_code5 4 CONFIG.convolution_code6 205 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 2 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_3_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_3_conv_encoder/aclk] [get_bd_pins ip_3_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_3_conv_encoder/aclken] [get_bd_pins ip_3_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_3_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_3_conv_encoder/aresetn] [get_bd_pins ip_3_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_3_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## accumulator ##########
create_bd_cell -type hier ip_4_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_4_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 50 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 212 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 1 CONFIG.Scale 0 " [get_bd_cells ip_4_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/clk
connect_bd_net [get_bd_pins ip_4_accumulator/clk] [get_bd_pins ip_4_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 49 -to 0 ip_4_accumulator/B
connect_bd_net [get_bd_pins ip_4_accumulator/B] [get_bd_pins ip_4_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 211 -to 0 ip_4_accumulator/Q
connect_bd_net [get_bd_pins ip_4_accumulator/Q] [get_bd_pins ip_4_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/C_IN
connect_bd_net [get_bd_pins ip_4_accumulator/C_IN] [get_bd_pins ip_4_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/SCLR
connect_bd_net [get_bd_pins ip_4_accumulator/SCLR] [get_bd_pins ip_4_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/SSET
connect_bd_net [get_bd_pins ip_4_accumulator/SSET] [get_bd_pins ip_4_accumulator/accumulator_0/SSET]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/Bypass
connect_bd_net [get_bd_pins ip_4_accumulator/Bypass] [get_bd_pins ip_4_accumulator/accumulator_0/Bypass]


########## accumulator ##########
create_bd_cell -type hier ip_5_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_5_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 42 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 43 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_5_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/clk
connect_bd_net [get_bd_pins ip_5_accumulator/clk] [get_bd_pins ip_5_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 41 -to 0 ip_5_accumulator/B
connect_bd_net [get_bd_pins ip_5_accumulator/B] [get_bd_pins ip_5_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 42 -to 0 ip_5_accumulator/Q
connect_bd_net [get_bd_pins ip_5_accumulator/Q] [get_bd_pins ip_5_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/Bypass
connect_bd_net [get_bd_pins ip_5_accumulator/Bypass] [get_bd_pins ip_5_accumulator/accumulator_0/Bypass]


########## reset ##########
create_bd_cell -type hier ip_6_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_6_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_reset/clk_in
connect_bd_net [get_bd_pins ip_6_reset/clk_in] [get_bd_pins ip_6_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_6_reset/reset_in
connect_bd_net [get_bd_pins ip_6_reset/reset_in] [get_bd_pins ip_6_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_6_reset/dcm_locked
connect_bd_net [get_bd_pins ip_6_reset/dcm_locked] [get_bd_pins ip_6_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_6_reset/mb_reset
connect_bd_net [get_bd_pins ip_6_reset/mb_reset] [get_bd_pins ip_6_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_6_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_6_reset/peripheral_areset_n] [get_bd_pins ip_6_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_6_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_6_reset/peripheral_areset] [get_bd_pins ip_6_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_6_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_6_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_7_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_7_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_in] [get_bd_pins ip_7_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_7_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_7_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_7_clk_wiz/reset
connect_bd_net [get_bd_pins ip_7_clk_wiz/reset] [get_bd_pins ip_7_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_7_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_locked] [get_bd_pins ip_7_clk_wiz/clk_wiz_0/locked]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_8_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_8_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_8_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_8_axis_dwidth_converter/aclk] [get_bd_pins ip_8_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_8_axis_dwidth_converter/aresetn] [get_bd_pins ip_8_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_8_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_8_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_8_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_9_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_9_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_9_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_9_axis_dwidth_converter/aclk] [get_bd_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_9_axis_dwidth_converter/aresetn] [get_bd_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_10_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_10_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_10_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aclk] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aresetn] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_11_reduce
create_bd_pin -dir I -from 169 -to 0 ip_11_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_11_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_11_reduce/concat]
connect_bd_net [get_bd_pins ip_11_reduce/out0] [get_bd_pins ip_11_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_0]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_11_reduce/slice_0/dout] [get_bd_pins ip_11_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_0/Res] [get_bd_pins ip_11_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_1]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_11_reduce/slice_1/dout] [get_bd_pins ip_11_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_1/Res] [get_bd_pins ip_11_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_2]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_11_reduce/slice_2/dout] [get_bd_pins ip_11_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_2/Res] [get_bd_pins ip_11_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_3]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_11_reduce/slice_3/dout] [get_bd_pins ip_11_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_3/Res] [get_bd_pins ip_11_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_4]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_11_reduce/slice_4/dout] [get_bd_pins ip_11_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_4/Res] [get_bd_pins ip_11_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 35 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_5]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_11_reduce/slice_5/dout] [get_bd_pins ip_11_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_5/Res] [get_bd_pins ip_11_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 41 CONFIG.DIN_TO 36 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_6]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_11_reduce/slice_6/dout] [get_bd_pins ip_11_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_6/Res] [get_bd_pins ip_11_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 42 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_7]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_11_reduce/slice_7/dout] [get_bd_pins ip_11_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_7/Res] [get_bd_pins ip_11_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 53 CONFIG.DIN_TO 48 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_8]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_11_reduce/slice_8/dout] [get_bd_pins ip_11_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_8/Res] [get_bd_pins ip_11_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 59 CONFIG.DIN_TO 54 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_9]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_11_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_11_reduce/slice_9/dout] [get_bd_pins ip_11_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_9/Res] [get_bd_pins ip_11_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 64 CONFIG.DIN_TO 60 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_10]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_11_reduce/slice_10/dout] [get_bd_pins ip_11_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_10/Res] [get_bd_pins ip_11_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 69 CONFIG.DIN_TO 65 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_11]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_11_reduce/slice_11/dout] [get_bd_pins ip_11_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_11/Res] [get_bd_pins ip_11_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 74 CONFIG.DIN_TO 70 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_12]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_11_reduce/slice_12/dout] [get_bd_pins ip_11_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_12/Res] [get_bd_pins ip_11_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 79 CONFIG.DIN_TO 75 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_13]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_11_reduce/slice_13/dout] [get_bd_pins ip_11_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_13/Res] [get_bd_pins ip_11_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 84 CONFIG.DIN_TO 80 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_14]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_11_reduce/slice_14/dout] [get_bd_pins ip_11_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_14/Res] [get_bd_pins ip_11_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 89 CONFIG.DIN_TO 85 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_15]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_11_reduce/slice_15/dout] [get_bd_pins ip_11_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_15/Res] [get_bd_pins ip_11_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 94 CONFIG.DIN_TO 90 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_16]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_11_reduce/slice_16/dout] [get_bd_pins ip_11_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_16/Res] [get_bd_pins ip_11_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 99 CONFIG.DIN_TO 95 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_17]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_11_reduce/slice_17/dout] [get_bd_pins ip_11_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_17/Res] [get_bd_pins ip_11_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 104 CONFIG.DIN_TO 100 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_18]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_11_reduce/slice_18/dout] [get_bd_pins ip_11_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_18/Res] [get_bd_pins ip_11_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 109 CONFIG.DIN_TO 105 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_19]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_11_reduce/slice_19/dout] [get_bd_pins ip_11_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_19/Res] [get_bd_pins ip_11_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 114 CONFIG.DIN_TO 110 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_20]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_11_reduce/slice_20/dout] [get_bd_pins ip_11_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_20/Res] [get_bd_pins ip_11_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 119 CONFIG.DIN_TO 115 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_21]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_11_reduce/slice_21/dout] [get_bd_pins ip_11_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_21/Res] [get_bd_pins ip_11_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 124 CONFIG.DIN_TO 120 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_22]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_11_reduce/slice_22/dout] [get_bd_pins ip_11_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_22/Res] [get_bd_pins ip_11_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 129 CONFIG.DIN_TO 125 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_23]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_11_reduce/slice_23/dout] [get_bd_pins ip_11_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_23/Res] [get_bd_pins ip_11_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 134 CONFIG.DIN_TO 130 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_24]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_11_reduce/slice_24/dout] [get_bd_pins ip_11_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_24/Res] [get_bd_pins ip_11_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 139 CONFIG.DIN_TO 135 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_25]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_11_reduce/slice_25/dout] [get_bd_pins ip_11_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_25/Res] [get_bd_pins ip_11_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 144 CONFIG.DIN_TO 140 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_26]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_11_reduce/slice_26/dout] [get_bd_pins ip_11_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_26/Res] [get_bd_pins ip_11_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 149 CONFIG.DIN_TO 145 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_27]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_11_reduce/slice_27/dout] [get_bd_pins ip_11_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_27/Res] [get_bd_pins ip_11_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 154 CONFIG.DIN_TO 150 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_28]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_11_reduce/slice_28/dout] [get_bd_pins ip_11_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_28/Res] [get_bd_pins ip_11_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 159 CONFIG.DIN_TO 155 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_29]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_11_reduce/slice_29/dout] [get_bd_pins ip_11_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_29/Res] [get_bd_pins ip_11_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 164 CONFIG.DIN_TO 160 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_30]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_11_reduce/slice_30/dout] [get_bd_pins ip_11_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_30/Res] [get_bd_pins ip_11_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 169 CONFIG.DIN_TO 165 CONFIG.DIN_WIDTH 170 " [get_bd_cells ip_11_reduce/slice_31]
connect_bd_net [get_bd_pins ip_11_reduce/in0] [get_bd_pins ip_11_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_11_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_11_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_11_reduce/slice_31/dout] [get_bd_pins ip_11_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_11_reduce/reduce_31/Res] [get_bd_pins ip_11_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_12_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_12_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_12_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_12_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_12_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_12_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_1] [get_bd_pins ip_12_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_2] [get_bd_pins ip_12_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_3] [get_bd_pins ip_12_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_4] [get_bd_pins ip_12_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_5] [get_bd_pins ip_12_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_6] [get_bd_pins ip_12_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 9 -to 0 ip_12_slice_and_concat/in_7
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_12_slice_and_concat] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_12_slice_and_concat/slice_7]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_7] [get_bd_pins ip_12_slice_and_concat/slice_7/din]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/slice_7/dout] [get_bd_pins ip_12_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_13_slice_and_concat
create_bd_pin -dir O -from 41 -to 0 ip_13_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_13_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_13_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 9 -to 0 ip_13_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_13_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_13_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/slice_0/dout] [get_bd_pins ip_13_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 9 -to 0 ip_13_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_13_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 3 -to 0 ip_13_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_2] [get_bd_pins ip_13_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_3] [get_bd_pins ip_13_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_13_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_4] [get_bd_pins ip_13_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 211 -to 0 ip_13_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 18 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 212 " [get_bd_cells ip_13_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_5] [get_bd_pins ip_13_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/slice_5/dout] [get_bd_pins ip_13_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_14_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_14_slice_and_concat/out0
create_bd_pin -dir I -from 211 -to 0 ip_14_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 24 CONFIG.DIN_TO 19 CONFIG.DIN_WIDTH 212 " [get_bd_cells ip_14_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_14_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_14_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 49 -to 0 ip_15_slice_and_concat/out0
create_bd_pin -dir I -from 211 -to 0 ip_15_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 74 CONFIG.DIN_TO 25 CONFIG.DIN_WIDTH 212 " [get_bd_cells ip_15_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_15_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_16_slice_and_concat/out0
create_bd_pin -dir I -from 211 -to 0 ip_16_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 84 CONFIG.DIN_TO 75 CONFIG.DIN_WIDTH 212 " [get_bd_cells ip_16_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 169 -to 0 ip_17_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_17_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 211 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 211 CONFIG.DIN_TO 85 CONFIG.DIN_WIDTH 212 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/slice_0/dout] [get_bd_pins ip_17_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 42 -to 0 ip_17_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_17_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_20_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_20_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_20_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/slice_0/dout]


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


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_26_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_7_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_1_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_1_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_1_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_8_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_11_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_clk_wiz/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_0_cordic/aresetn]
connect_bd_net [get_bd_pins ip_6_reset/peripheral_areset] [get_bd_pins ip_2_dft/SCLR]
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_3_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_0_cordic/aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_1_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_2_dft/CLK]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_3_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_4_accumulator/clk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_5_accumulator/clk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_6_reset/clk_in]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_locked] [get_bd_pins ip_6_reset/dcm_locked]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_8_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_9_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_2_dft/XN_IM]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_1] [get_bd_pins ip_1_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_2] [get_bd_pins ip_1_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_3] [get_bd_pins ip_1_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_4] [get_bd_pins ip_1_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_5] [get_bd_pins ip_1_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_6] [get_bd_pins ip_2_dft/RFFD]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_7] [get_bd_pins ip_2_dft/XK_RE]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/B]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_2_dft/XK_RE]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_1] [get_bd_pins ip_2_dft/XK_IM]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_2] [get_bd_pins ip_2_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_3] [get_bd_pins ip_2_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_4] [get_bd_pins ip_2_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_5] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_2_dft/SIZE]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/B]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_2_dft/XN_RE]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_11_reduce/in0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_1] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_2_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_1_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/SSET]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_2_dft/FD_IN]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_3_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_8_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_9_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_6_reset/interconnect_aresetn] [get_bd_pins ip_10_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_8_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_9_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_7_clk_wiz/clk_out] [get_bd_pins ip_10_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
