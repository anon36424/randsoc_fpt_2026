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
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tan CONFIG.Input_Width 40 CONFIG.Iterations 22 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 28 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 32 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_0_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aclk
connect_bd_net [get_bd_pins ip_0_cordic/aclk] [get_bd_pins ip_0_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]


########## conv_encoder ##########
create_bd_cell -type hier ip_1_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_1_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 5 CONFIG.convolution_code0 12 CONFIG.convolution_code1 13 CONFIG.convolution_code2 29 CONFIG.convolution_code3 31 CONFIG.convolution_code4 5 CONFIG.convolution_code5 26 CONFIG.convolution_code6 27 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 3 CONFIG.output_rate 4 CONFIG.puncture_code0 111 CONFIG.puncture_code1 001 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_1_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_1_conv_encoder/aclk] [get_bd_pins ip_1_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_1_conv_encoder/aresetn] [get_bd_pins ip_1_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_1_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_1_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## floating_point ##########
create_bd_cell -type hier ip_2_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_2_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.a_tuser_width 8 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Float_to_float CONFIG.result_precision_type Double CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_2_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_floating_point/aclk
connect_bd_net [get_bd_pins ip_2_floating_point/aclk] [get_bd_pins ip_2_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_floating_point/aclken
connect_bd_net [get_bd_pins ip_2_floating_point/aclken] [get_bd_pins ip_2_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_2_floating_point/aresetn
connect_bd_net [get_bd_pins ip_2_floating_point/aresetn] [get_bd_pins ip_2_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_2_floating_point/S_AXIS_A] [get_bd_intf_pins ip_2_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_2_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_2_floating_point/floating_point_0/M_AXIS_RESULT]


########## uartlite ##########
create_bd_cell -type hier ip_3_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_3_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Odd " [get_bd_cells ip_3_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/UART] [get_bd_intf_pins ip_3_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/clk
connect_bd_net [get_bd_pins ip_3_uartlite/clk] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/reset
connect_bd_net [get_bd_pins ip_3_uartlite/reset] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_3_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_uartlite/irq
connect_bd_net [get_bd_pins ip_3_uartlite/irq] [get_bd_pins ip_3_uartlite/uart_0/interrupt]


########## conv_encoder ##########
create_bd_cell -type hier ip_4_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_4_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 6 CONFIG.convolution_code0 5 CONFIG.convolution_code1 36 CONFIG.convolution_code2 33 CONFIG.convolution_code3 59 CONFIG.convolution_code4 37 CONFIG.convolution_code5 40 CONFIG.convolution_code6 38 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 9 CONFIG.output_rate 17 CONFIG.puncture_code0 111110111 CONFIG.puncture_code1 111111111 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_4_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_4_conv_encoder/aclk] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_4_conv_encoder/aclken] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_4_conv_encoder/aresetn] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## xadc_wiz ##########
create_bd_cell -type hier ip_5_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_5_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_TEMP_BUS 1 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_5_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_5_xadc_wiz/s_axi_aclk] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_5_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_5_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/ot_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/eoc_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/eos_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/alarm_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/busy_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_5_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_5_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_5_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 11 -to 0 ip_5_xadc_wiz/temp_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/temp_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/temp_out]


########## complex_multiplier ##########
create_bd_cell -type hier ip_6_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_6_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 62 CONFIG.aresetn 1 CONFIG.bportwidth 45 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Performance CONFIG.outputwidth 66 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_6_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_6_complex_multiplier/aclk] [get_bd_pins ip_6_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_6_complex_multiplier/aresetn] [get_bd_pins ip_6_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_6_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_6_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_6_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_6_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_6_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_6_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## uartlite ##########
create_bd_cell -type hier ip_7_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_7_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 115200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Even " [get_bd_cells ip_7_uartlite/uart_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_8_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_8_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x2e CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 193 CONFIG.C_SDA_INERTIAL_DELAY 36 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 343.3092956722617 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_8_axi_iic/axi_iic_0]
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


########## dft ##########
create_bd_cell -type hier ip_9_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_9_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 17 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_9_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/CLK
connect_bd_net [get_bd_pins ip_9_dft/CLK] [get_bd_pins ip_9_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/SCLR
connect_bd_net [get_bd_pins ip_9_dft/SCLR] [get_bd_pins ip_9_dft/dft_0/SCLR]
create_bd_pin -dir I -from 16 -to 0 ip_9_dft/XN_RE
connect_bd_net [get_bd_pins ip_9_dft/XN_RE] [get_bd_pins ip_9_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 16 -to 0 ip_9_dft/XN_IM
connect_bd_net [get_bd_pins ip_9_dft/XN_IM] [get_bd_pins ip_9_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/FD_IN
connect_bd_net [get_bd_pins ip_9_dft/FD_IN] [get_bd_pins ip_9_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/FWD_INV
connect_bd_net [get_bd_pins ip_9_dft/FWD_INV] [get_bd_pins ip_9_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_9_dft/SIZE
connect_bd_net [get_bd_pins ip_9_dft/SIZE] [get_bd_pins ip_9_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_9_dft/RFFD
connect_bd_net [get_bd_pins ip_9_dft/RFFD] [get_bd_pins ip_9_dft/dft_0/RFFD]
create_bd_pin -dir O -from 16 -to 0 ip_9_dft/XK_RE
connect_bd_net [get_bd_pins ip_9_dft/XK_RE] [get_bd_pins ip_9_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 16 -to 0 ip_9_dft/XK_IM
connect_bd_net [get_bd_pins ip_9_dft/XK_IM] [get_bd_pins ip_9_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_9_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_9_dft/BLK_EXP] [get_bd_pins ip_9_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_9_dft/FD_OUT
connect_bd_net [get_bd_pins ip_9_dft/FD_OUT] [get_bd_pins ip_9_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_9_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_9_dft/DATA_VALID] [get_bd_pins ip_9_dft/dft_0/DATA_VALID]


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
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 1 " [get_bd_cells ip_13_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi/clk
connect_bd_net [get_bd_pins ip_13_axi/clk] [get_bd_pins ip_13_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi/reset
connect_bd_net [get_bd_pins ip_13_axi/reset] [get_bd_pins ip_13_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_M0] [get_bd_intf_pins ip_13_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S0] [get_bd_intf_pins ip_13_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S1] [get_bd_intf_pins ip_13_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S2] [get_bd_intf_pins ip_13_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S3] [get_bd_intf_pins ip_13_axi/axi_0/M03_AXI]


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
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_15_axis_broadcaster/axis_broadcaster_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_18_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 18 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_22_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_22_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_22_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_22_axis_combiner/aclk] [get_bd_pins ip_22_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_22_axis_combiner/aresetn] [get_bd_pins ip_22_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_combiner/M_AXIS] [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_23_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_23_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aclk] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aresetn] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_24_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_24_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_1] [get_bd_pins ip_24_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_2] [get_bd_pins ip_24_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 11 -to 0 ip_24_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_24_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_3] [get_bd_pins ip_24_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/slice_3/dout] [get_bd_pins ip_24_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_25_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_25_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/slice_0/dout] [get_bd_pins ip_25_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_25_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 16 -to 0 ip_25_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_25_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_2] [get_bd_pins ip_25_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/slice_2/dout] [get_bd_pins ip_25_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_26_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_26_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/slice_0/dout] [get_bd_pins ip_26_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 16 -to 0 ip_26_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_26_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_1] [get_bd_pins ip_26_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/slice_1/dout] [get_bd_pins ip_26_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 15 -to 0 ip_27_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_27_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/slice_0/dout] [get_bd_pins ip_27_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_27_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_27_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_2] [get_bd_pins ip_27_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_3] [get_bd_pins ip_27_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_28_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_31_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_11_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite_UART] [get_bd_intf_pins ip_3_uartlite/UART]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_5_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_5_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_5_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_7_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite_UART] [get_bd_intf_pins ip_7_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_8_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_iic_IIC] [get_bd_intf_pins ip_8_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_12_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi_master
set_property -dict "CONFIG.PROTOCOL AXI4LITE " [get_bd_intf_ports axi_master]
connect_bd_intf_net [get_bd_intf_pins axi_master] [get_bd_intf_pins ip_13_axi/AXI_M0]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 15 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_27_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_1_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_2_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_3_uartlite/reset]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_4_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_5_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_6_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_7_uartlite/reset]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_iic/reset]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset] [get_bd_pins ip_9_dft/SCLR]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_0_cordic/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_1_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_2_floating_point/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_3_uartlite/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_4_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_5_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_6_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_7_uartlite/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_8_axi_iic/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_9_dft/CLK]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_10_reset/clk_in]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_locked] [get_bd_pins ip_10_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_12_intc/irq_0] [get_bd_pins ip_3_uartlite/irq]
connect_bd_net [get_bd_pins ip_12_intc/irq_1] [get_bd_pins ip_5_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_12_intc/irq_2] [get_bd_pins ip_7_uartlite/irq]
connect_bd_net [get_bd_pins ip_12_intc/irq_3] [get_bd_pins ip_8_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_13_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_uartlite/AXI] [get_bd_intf_pins ip_13_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_iic/AXI] [get_bd_intf_pins ip_13_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_intc/AXI] [get_bd_intf_pins ip_13_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_14_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_15_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_1_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_6_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_floating_point/S_AXIS_A] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_9_dft/SIZE]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_1] [get_bd_pins ip_5_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_2] [get_bd_pins ip_5_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_3] [get_bd_pins ip_5_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_9_dft/XN_RE]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_9_dft/RFFD]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_2] [get_bd_pins ip_9_dft/XK_RE]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_9_dft/XN_IM]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_9_dft/XK_RE]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_1] [get_bd_pins ip_9_dft/XK_IM]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_9_dft/XK_IM]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_9_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_2] [get_bd_pins ip_9_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_3] [get_bd_pins ip_9_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_2_floating_point/aclken]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_9_dft/FD_IN]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_9_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_4_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_13_axi/reset]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_12_intc/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_13_axi/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_14_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_15_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_16_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_17_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_18_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_22_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=80 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_complex_multiplier/S_AXIS_A declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_complex_multiplier/S_AXIS_A declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 144 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_complex_multiplier/M_AXIS_DOUT declared=144 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_complex_multiplier/M_AXIS_DOUT declared=144 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
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
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 144 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=144 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=144 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_combiner/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }


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
