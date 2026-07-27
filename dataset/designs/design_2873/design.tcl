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
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_0_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/dclk_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/reset_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/convstclk_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_0_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_0_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
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


########## accumulator ##########
create_bd_cell -type hier ip_1_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_1_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 2 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 31 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_1_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/clk
connect_bd_net [get_bd_pins ip_1_accumulator/clk] [get_bd_pins ip_1_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 1 -to 0 ip_1_accumulator/B
connect_bd_net [get_bd_pins ip_1_accumulator/B] [get_bd_pins ip_1_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 30 -to 0 ip_1_accumulator/Q
connect_bd_net [get_bd_pins ip_1_accumulator/Q] [get_bd_pins ip_1_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/ADD
connect_bd_net [get_bd_pins ip_1_accumulator/ADD] [get_bd_pins ip_1_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/SCLR
connect_bd_net [get_bd_pins ip_1_accumulator/SCLR] [get_bd_pins ip_1_accumulator/accumulator_0/SCLR]


########## cordic ##########
create_bd_cell -type hier ip_2_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_2_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 41 CONFIG.Iterations 48 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 28 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 40 CONFIG.Round_Mode Truncate " [get_bd_cells ip_2_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_cordic/aclk
connect_bd_net [get_bd_pins ip_2_cordic/aclk] [get_bd_pins ip_2_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]


########## gpio ##########
create_bd_cell -type hier ip_3_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_3_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 24 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_3_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/GPIO] [get_bd_intf_pins ip_3_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/clk
connect_bd_net [get_bd_pins ip_3_gpio/clk] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/rst
connect_bd_net [get_bd_pins ip_3_gpio/rst] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_3_gpio/gpio_0/S_AXI]


########## uartlite ##########
create_bd_cell -type hier ip_4_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_4_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 115200 CONFIG.C_DATA_BITS 8 CONFIG.PARITY No_Parity " [get_bd_cells ip_4_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_4_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite/UART] [get_bd_intf_pins ip_4_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_4_uartlite/clk
connect_bd_net [get_bd_pins ip_4_uartlite/clk] [get_bd_pins ip_4_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_uartlite/reset
connect_bd_net [get_bd_pins ip_4_uartlite/reset] [get_bd_pins ip_4_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite/AXI] [get_bd_intf_pins ip_4_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_uartlite/irq
connect_bd_net [get_bd_pins ip_4_uartlite/irq] [get_bd_pins ip_4_uartlite/uart_0/interrupt]


########## conv_encoder ##########
create_bd_cell -type hier ip_5_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_5_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 6 CONFIG.convolution_code0 8 CONFIG.convolution_code1 43 CONFIG.convolution_code2 8 CONFIG.convolution_code3 42 CONFIG.convolution_code4 7 CONFIG.convolution_code5 24 CONFIG.convolution_code6 57 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 7 CONFIG.output_rate 9 CONFIG.puncture_code0 1111101 CONFIG.puncture_code1 0010101 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_5_conv_encoder/conv_encoder_0]
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


########## uartlite ##########
create_bd_cell -type hier ip_6_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_6_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Odd " [get_bd_cells ip_6_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_6_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite/UART] [get_bd_intf_pins ip_6_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_6_uartlite/clk
connect_bd_net [get_bd_pins ip_6_uartlite/clk] [get_bd_pins ip_6_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_uartlite/reset
connect_bd_net [get_bd_pins ip_6_uartlite/reset] [get_bd_pins ip_6_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite/AXI] [get_bd_intf_pins ip_6_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_uartlite/irq
connect_bd_net [get_bd_pins ip_6_uartlite/irq] [get_bd_pins ip_6_uartlite/uart_0/interrupt]


########## axi_timer ##########
create_bd_cell -type hier ip_7_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_7_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.mode_64bit 1 " [get_bd_cells ip_7_axi_timer/axi_timer_0]
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


########## emc ##########
create_bd_cell -type hier ip_8_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_8_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 0 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_MEM2_TYPE 0 CONFIG.C_MEM2_WIDTH 64 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_SYNCH_PIPEDELAY_0 1 CONFIG.C_SYNCH_PIPEDELAY_2 1 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 14 CONFIG.C_TAVDV_PS_MEM_1 16087 CONFIG.C_TCEDV_PS_MEM_1 15855 CONFIG.C_THZCE_PS_MEM_1 7606 CONFIG.C_THZOE_PS_MEM_1 7450 CONFIG.C_TLZWE_PS_MEM_1 1724 CONFIG.C_TWC_PS_MEM_1 13673 CONFIG.C_TWPH_PS_MEM_1 11090 CONFIG.C_TWP_PS_MEM_1 10841 CONFIG.C_WR_REC_TIME_MEM_1 29103 " [get_bd_cells ip_8_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_8_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_8_emc/EMC_INTF] [get_bd_intf_pins ip_8_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_8_emc/clk
connect_bd_net [get_bd_pins ip_8_emc/clk] [get_bd_pins ip_8_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_emc/rdclk
connect_bd_net [get_bd_pins ip_8_emc/rdclk] [get_bd_pins ip_8_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_emc/rst
connect_bd_net [get_bd_pins ip_8_emc/rst] [get_bd_pins ip_8_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_emc/AXI] [get_bd_intf_pins ip_8_emc/emc_0/S_AXI_MEM]


########## emc ##########
create_bd_cell -type hier ip_9_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_9_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 5 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 5 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 4 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 1 CONFIG.C_TAVDV_PS_MEM_0 14876 CONFIG.C_TAVDV_PS_MEM_1 14002 CONFIG.C_TAVDV_PS_MEM_2 16093 CONFIG.C_TAVDV_PS_MEM_3 15773 CONFIG.C_TCEDV_PS_MEM_0 15857 CONFIG.C_TCEDV_PS_MEM_1 13818 CONFIG.C_TCEDV_PS_MEM_2 15390 CONFIG.C_TCEDV_PS_MEM_3 15198 CONFIG.C_THZCE_PS_MEM_0 6577 CONFIG.C_THZCE_PS_MEM_1 6894 CONFIG.C_THZCE_PS_MEM_2 7211 CONFIG.C_THZCE_PS_MEM_3 7612 CONFIG.C_THZOE_PS_MEM_0 6837 CONFIG.C_THZOE_PS_MEM_1 7286 CONFIG.C_THZOE_PS_MEM_2 7695 CONFIG.C_THZOE_PS_MEM_3 7203 CONFIG.C_TLZWE_PS_MEM_0 6108 CONFIG.C_TLZWE_PS_MEM_1 8335 CONFIG.C_TLZWE_PS_MEM_2 5883 CONFIG.C_TLZWE_PS_MEM_3 2255 CONFIG.C_TWC_PS_MEM_0 14606 CONFIG.C_TWC_PS_MEM_1 15797 CONFIG.C_TWC_PS_MEM_2 15884 CONFIG.C_TWC_PS_MEM_3 14829 CONFIG.C_TWPH_PS_MEM_0 12797 CONFIG.C_TWPH_PS_MEM_1 12644 CONFIG.C_TWPH_PS_MEM_2 12356 CONFIG.C_TWPH_PS_MEM_3 12758 CONFIG.C_TWP_PS_MEM_0 11397 CONFIG.C_TWP_PS_MEM_1 11140 CONFIG.C_TWP_PS_MEM_2 10880 CONFIG.C_TWP_PS_MEM_3 12786 CONFIG.C_WR_REC_TIME_MEM_0 26768 CONFIG.C_WR_REC_TIME_MEM_1 25000 CONFIG.C_WR_REC_TIME_MEM_2 24778 CONFIG.C_WR_REC_TIME_MEM_3 26467 " [get_bd_cells ip_9_emc/emc_0]
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


########## axi_timer ##########
create_bd_cell -type hier ip_10_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_10_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 8 CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_10_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_timer/S_AXI] [get_bd_intf_pins ip_10_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_10_axi_timer/capturetrig0] [get_bd_pins ip_10_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_10_axi_timer/capturetrig1] [get_bd_pins ip_10_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_timer/freeze
connect_bd_net [get_bd_pins ip_10_axi_timer/freeze] [get_bd_pins ip_10_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_10_axi_timer/s_axi_aclk] [get_bd_pins ip_10_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_10_axi_timer/s_axi_aresetn] [get_bd_pins ip_10_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_10_axi_timer/generateout0] [get_bd_pins ip_10_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_10_axi_timer/generateout1] [get_bd_pins ip_10_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_10_axi_timer/pwm0] [get_bd_pins ip_10_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_10_axi_timer/interrupt] [get_bd_pins ip_10_axi_timer/axi_timer_0/interrupt]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_11_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_11_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 1 CONFIG.C_FIFO_DEPTH 256 CONFIG.C_NUM_TRANSFER_BITS 16 CONFIG.C_SCK_RATIO 8 CONFIG.C_SPI_MEMORY 2 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_11_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/IIC] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/clk] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/reset] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/clk4] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/reset4] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/irq] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_12_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_12_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_12_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_12_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite/MII] [get_bd_intf_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_12_axi_ethernet_lite/clk] [get_bd_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_12_axi_ethernet_lite/reset] [get_bd_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_12_axi_ethernet_lite/irq] [get_bd_pins ip_12_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_13_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_13_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Even " [get_bd_cells ip_13_uartlite/uart_0]
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


########## axi_cdma ##########
create_bd_cell -type hier ip_14_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_14_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 52 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 256 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_14_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_14_axi_cdma/m_axi_aclk] [get_bd_pins ip_14_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_14_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_14_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_14_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_14_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_cdma/M_AXI] [get_bd_intf_pins ip_14_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_14_axi_cdma/cdma_introut] [get_bd_pins ip_14_axi_cdma/axi_cdma_0/cdma_introut]


########## reset ##########
create_bd_cell -type hier ip_15_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_15_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/clk_in
connect_bd_net [get_bd_pins ip_15_reset/clk_in] [get_bd_pins ip_15_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/reset_in
connect_bd_net [get_bd_pins ip_15_reset/reset_in] [get_bd_pins ip_15_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/dcm_locked
connect_bd_net [get_bd_pins ip_15_reset/dcm_locked] [get_bd_pins ip_15_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/mb_reset
connect_bd_net [get_bd_pins ip_15_reset/mb_reset] [get_bd_pins ip_15_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_15_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset] [get_bd_pins ip_15_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_15_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_16_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_16_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_in] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_16_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_16_clk_wiz/reset
connect_bd_net [get_bd_pins ip_16_clk_wiz/reset] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_16_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_locked] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_17_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_17_intc/concat_0]
connect_bd_net [get_bd_pins ip_17_intc/concat_0/dout] [get_bd_pins ip_17_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/clk
connect_bd_net [get_bd_pins ip_17_intc/clk] [get_bd_pins ip_17_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/reset
connect_bd_net [get_bd_pins ip_17_intc/reset] [get_bd_pins ip_17_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_intc/AXI] [get_bd_intf_pins ip_17_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_0
connect_bd_net [get_bd_pins ip_17_intc/irq_0] [get_bd_pins ip_17_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_1
connect_bd_net [get_bd_pins ip_17_intc/irq_1] [get_bd_pins ip_17_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_2
connect_bd_net [get_bd_pins ip_17_intc/irq_2] [get_bd_pins ip_17_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_3
connect_bd_net [get_bd_pins ip_17_intc/irq_3] [get_bd_pins ip_17_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_4
connect_bd_net [get_bd_pins ip_17_intc/irq_4] [get_bd_pins ip_17_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_5
connect_bd_net [get_bd_pins ip_17_intc/irq_5] [get_bd_pins ip_17_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_6
connect_bd_net [get_bd_pins ip_17_intc/irq_6] [get_bd_pins ip_17_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_7
connect_bd_net [get_bd_pins ip_17_intc/irq_7] [get_bd_pins ip_17_intc/concat_0/In7]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_17_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_17_intc/irq] [get_bd_intf_pins ip_17_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_18_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_18_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 13 CONFIG.NUM_SI 1 " [get_bd_cells ip_18_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_legacy/clk
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_legacy/reset
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_M0] [get_bd_intf_pins ip_18_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S0] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S1] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S2] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S3] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S4] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S5] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S6] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S7] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S8] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S9] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S10] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S11] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S12] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M12_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_19_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_19_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aclk] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aresetn] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_21_reduce
create_bd_pin -dir I -from 37 -to 0 ip_21_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_21_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_21_reduce/concat]
connect_bd_net [get_bd_pins ip_21_reduce/out0] [get_bd_pins ip_21_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_0]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_21_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_21_reduce/slice_0/dout] [get_bd_pins ip_21_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_0/Res] [get_bd_pins ip_21_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_1]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_21_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_21_reduce/slice_1/dout] [get_bd_pins ip_21_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_1/Res] [get_bd_pins ip_21_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_2]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_21_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_21_reduce/slice_2/dout] [get_bd_pins ip_21_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_2/Res] [get_bd_pins ip_21_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_3]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_21_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_21_reduce/slice_3/dout] [get_bd_pins ip_21_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_3/Res] [get_bd_pins ip_21_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_4]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_21_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_21_reduce/slice_4/dout] [get_bd_pins ip_21_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_4/Res] [get_bd_pins ip_21_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_5]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_21_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_21_reduce/slice_5/dout] [get_bd_pins ip_21_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_5/Res] [get_bd_pins ip_21_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_6]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_21_reduce/slice_6/dout] [get_bd_pins ip_21_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_6/Res] [get_bd_pins ip_21_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 13 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_7]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_21_reduce/slice_7/dout] [get_bd_pins ip_21_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_7/Res] [get_bd_pins ip_21_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 14 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_8]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_21_reduce/slice_8/dout] [get_bd_pins ip_21_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_8/Res] [get_bd_pins ip_21_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_9]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_21_reduce/slice_9/dout] [get_bd_pins ip_21_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_9/Res] [get_bd_pins ip_21_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_10]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_21_reduce/slice_10/dout] [get_bd_pins ip_21_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_10/Res] [get_bd_pins ip_21_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 17 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_11]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_21_reduce/slice_11/dout] [get_bd_pins ip_21_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_11/Res] [get_bd_pins ip_21_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 18 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_12]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_21_reduce/slice_12/dout] [get_bd_pins ip_21_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_12/Res] [get_bd_pins ip_21_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 19 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_13]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_21_reduce/slice_13/dout] [get_bd_pins ip_21_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_13/Res] [get_bd_pins ip_21_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 20 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_14]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_21_reduce/slice_14/dout] [get_bd_pins ip_21_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_14/Res] [get_bd_pins ip_21_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 21 CONFIG.DIN_TO 21 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_15]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_21_reduce/slice_15/dout] [get_bd_pins ip_21_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_15/Res] [get_bd_pins ip_21_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 22 CONFIG.DIN_TO 22 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_16]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_21_reduce/slice_16/dout] [get_bd_pins ip_21_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_16/Res] [get_bd_pins ip_21_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 23 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_17]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_21_reduce/slice_17/dout] [get_bd_pins ip_21_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_17/Res] [get_bd_pins ip_21_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 24 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_18]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_21_reduce/slice_18/dout] [get_bd_pins ip_21_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_18/Res] [get_bd_pins ip_21_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 25 CONFIG.DIN_TO 25 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_19]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_21_reduce/slice_19/dout] [get_bd_pins ip_21_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_19/Res] [get_bd_pins ip_21_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 26 CONFIG.DIN_TO 26 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_20]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_21_reduce/slice_20/dout] [get_bd_pins ip_21_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_20/Res] [get_bd_pins ip_21_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 27 CONFIG.DIN_TO 27 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_21]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_21_reduce/slice_21/dout] [get_bd_pins ip_21_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_21/Res] [get_bd_pins ip_21_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 28 CONFIG.DIN_TO 28 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_22]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_21_reduce/slice_22/dout] [get_bd_pins ip_21_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_22/Res] [get_bd_pins ip_21_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 29 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_23]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_21_reduce/slice_23/dout] [get_bd_pins ip_21_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_23/Res] [get_bd_pins ip_21_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_24]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_21_reduce/slice_24/dout] [get_bd_pins ip_21_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_24/Res] [get_bd_pins ip_21_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_25]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_21_reduce/slice_25/dout] [get_bd_pins ip_21_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_25/Res] [get_bd_pins ip_21_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_26]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_21_reduce/slice_26/dout] [get_bd_pins ip_21_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_26/Res] [get_bd_pins ip_21_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 33 CONFIG.DIN_TO 33 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_27]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_21_reduce/slice_27/dout] [get_bd_pins ip_21_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_27/Res] [get_bd_pins ip_21_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 34 CONFIG.DIN_TO 34 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_28]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_21_reduce/slice_28/dout] [get_bd_pins ip_21_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_28/Res] [get_bd_pins ip_21_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 35 CONFIG.DIN_TO 35 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_29]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_21_reduce/slice_29/dout] [get_bd_pins ip_21_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_29/Res] [get_bd_pins ip_21_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 36 CONFIG.DIN_TO 36 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_30]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_21_reduce/slice_30/dout] [get_bd_pins ip_21_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_30/Res] [get_bd_pins ip_21_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 37 CONFIG.DIN_TO 37 CONFIG.DIN_WIDTH 38 " [get_bd_cells ip_21_reduce/slice_31]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_21_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_21_reduce/slice_31/dout] [get_bd_pins ip_21_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_31/Res] [get_bd_pins ip_21_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 37 -to 0 ip_22_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_22_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_22_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_22_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 30 -to 0 ip_22_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_3] [get_bd_pins ip_22_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_4] [get_bd_pins ip_22_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_5] [get_bd_pins ip_22_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_6] [get_bd_pins ip_22_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_7] [get_bd_pins ip_22_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 1 -to 0 ip_23_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_23_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_1] [get_bd_pins ip_23_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/slice_0/dout]


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
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_16_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_0_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_0_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_0_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio_GPIO] [get_bd_intf_pins ip_3_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_4_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite_UART] [get_bd_intf_pins ip_4_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_6_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite_UART] [get_bd_intf_pins ip_6_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_8_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_8_emc_EMC_INTF] [get_bd_intf_pins ip_8_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_9_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_9_emc_EMC_INTF] [get_bd_intf_pins ip_9_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi_IIC] [get_bd_intf_pins ip_11_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_12_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_ethernet_lite_MII] [get_bd_intf_pins ip_12_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_13_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_13_uartlite_UART] [get_bd_intf_pins ip_13_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_17_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_21_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset] [get_bd_pins ip_0_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_3_gpio/rst]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_4_uartlite/reset]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_5_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_6_uartlite/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_8_emc/rst]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_9_emc/rst]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_13_uartlite/reset]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_0_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_0_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_1_accumulator/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_2_cordic/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_3_gpio/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_4_uartlite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_5_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_6_uartlite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_7_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_8_emc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_8_emc/rdclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_9_emc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_9_emc/rdclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_10_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_12_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_13_uartlite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_14_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_14_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_15_reset/clk_in]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_locked] [get_bd_pins ip_15_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_17_intc/irq_0] [get_bd_pins ip_4_uartlite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_1] [get_bd_pins ip_6_uartlite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_2] [get_bd_pins ip_7_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_17_intc/irq_3] [get_bd_pins ip_10_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_17_intc/irq_4] [get_bd_pins ip_11_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_5] [get_bd_pins ip_12_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_6] [get_bd_pins ip_13_uartlite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_7] [get_bd_pins ip_14_axi_cdma/cdma_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_cdma/M_AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_uartlite/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_uartlite/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_timer/S_AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_emc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_emc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_timer/S_AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_18_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_18_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_uartlite/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_18_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_intc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_5_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_21_reduce/in0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_0_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_0_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_3] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_4] [get_bd_pins ip_7_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_5] [get_bd_pins ip_7_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_6] [get_bd_pins ip_7_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_7] [get_bd_pins ip_10_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/B]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_10_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_1] [get_bd_pins ip_10_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/ADD]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_7_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_7_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_5_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_18_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_17_intc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_18_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }


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
