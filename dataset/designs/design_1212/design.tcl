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



########## axi_timer ##########
create_bd_cell -type hier ip_0_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_0_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_0_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_0_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_0_axi_timer/capturetrig0] [get_bd_pins ip_0_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/freeze
connect_bd_net [get_bd_pins ip_0_axi_timer/freeze] [get_bd_pins ip_0_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_0_axi_timer/s_axi_aclk] [get_bd_pins ip_0_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_0_axi_timer/s_axi_aresetn] [get_bd_pins ip_0_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_0_axi_timer/generateout0] [get_bd_pins ip_0_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_0_axi_timer/generateout1] [get_bd_pins ip_0_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_0_axi_timer/pwm0] [get_bd_pins ip_0_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_0_axi_timer/interrupt] [get_bd_pins ip_0_axi_timer/axi_timer_0/interrupt]


########## xadc_wiz ##########
create_bd_cell -type hier ip_1_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_1_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 16 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 1 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 0 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_1_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_1_xadc_wiz/dclk_in] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_1_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_1_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_1_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
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


########## uartlite ##########
create_bd_cell -type hier ip_2_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_2_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 2400 CONFIG.C_DATA_BITS 6 CONFIG.PARITY No_Parity " [get_bd_cells ip_2_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite/UART] [get_bd_intf_pins ip_2_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_2_uartlite/clk
connect_bd_net [get_bd_pins ip_2_uartlite/clk] [get_bd_pins ip_2_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_uartlite/reset
connect_bd_net [get_bd_pins ip_2_uartlite/reset] [get_bd_pins ip_2_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_2_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_uartlite/irq
connect_bd_net [get_bd_pins ip_2_uartlite/irq] [get_bd_pins ip_2_uartlite/uart_0/interrupt]


########## reset ##########
create_bd_cell -type hier ip_3_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_3_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_reset/clk_in
connect_bd_net [get_bd_pins ip_3_reset/clk_in] [get_bd_pins ip_3_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_3_reset/reset_in
connect_bd_net [get_bd_pins ip_3_reset/reset_in] [get_bd_pins ip_3_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_3_reset/dcm_locked
connect_bd_net [get_bd_pins ip_3_reset/dcm_locked] [get_bd_pins ip_3_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_3_reset/mb_reset
connect_bd_net [get_bd_pins ip_3_reset/mb_reset] [get_bd_pins ip_3_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_3_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_3_reset/peripheral_areset_n] [get_bd_pins ip_3_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_3_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_3_reset/peripheral_areset] [get_bd_pins ip_3_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_3_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_3_reset/interconnect_aresetn] [get_bd_pins ip_3_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_4_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_4_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_in] [get_bd_pins ip_4_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_4_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_4_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_4_clk_wiz/reset
connect_bd_net [get_bd_pins ip_4_clk_wiz/reset] [get_bd_pins ip_4_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_4_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_locked] [get_bd_pins ip_4_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_5_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_5_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_5_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_5_intc/concat_0]
connect_bd_net [get_bd_pins ip_5_intc/concat_0/dout] [get_bd_pins ip_5_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_5_intc/clk
connect_bd_net [get_bd_pins ip_5_intc/clk] [get_bd_pins ip_5_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_intc/reset
connect_bd_net [get_bd_pins ip_5_intc/reset] [get_bd_pins ip_5_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_intc/AXI] [get_bd_intf_pins ip_5_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_5_intc/irq_0
connect_bd_net [get_bd_pins ip_5_intc/irq_0] [get_bd_pins ip_5_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_5_intc/irq_1
connect_bd_net [get_bd_pins ip_5_intc/irq_1] [get_bd_pins ip_5_intc/concat_0/In1]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_5_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_5_intc/irq] [get_bd_intf_pins ip_5_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_6_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_6_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 3 CONFIG.NUM_SI 1 " [get_bd_cells ip_6_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi/clk
connect_bd_net [get_bd_pins ip_6_axi/clk] [get_bd_pins ip_6_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi/reset
connect_bd_net [get_bd_pins ip_6_axi/reset] [get_bd_pins ip_6_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_6_axi/AXI_M0] [get_bd_intf_pins ip_6_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_6_axi/AXI_S0] [get_bd_intf_pins ip_6_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_6_axi/AXI_S1] [get_bd_intf_pins ip_6_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_6_axi/AXI_S2] [get_bd_intf_pins ip_6_axi/axi_0/M02_AXI]


########## slice_and_concat ##########
create_bd_cell -type hier ip_7_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_7_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_7_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 9 " [get_bd_cells ip_7_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/out0] [get_bd_pins ip_7_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_0] [get_bd_pins ip_7_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_1] [get_bd_pins ip_7_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_2] [get_bd_pins ip_7_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_3] [get_bd_pins ip_7_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_4] [get_bd_pins ip_7_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_5] [get_bd_pins ip_7_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_6] [get_bd_pins ip_7_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_7] [get_bd_pins ip_7_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_8] [get_bd_pins ip_7_slice_and_concat/concat/In8]


########## slice_and_concat ##########
create_bd_cell -type hier ip_8_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_8_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_8_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_9_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_9_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_9_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_3_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_4_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_1_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_1_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_1_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite_UART] [get_bd_intf_pins ip_2_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_5_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi_master
set_property -dict "CONFIG.PROTOCOL AXI4LITE " [get_bd_intf_ports axi_master]
connect_bd_intf_net [get_bd_intf_pins axi_master] [get_bd_intf_pins ip_6_axi/AXI_M0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 8 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_7_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_4_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_5_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_3_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_3_reset/peripheral_areset_n] [get_bd_pins ip_2_uartlite/reset]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_0_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_1_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_2_uartlite/clk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_3_reset/clk_in]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_locked] [get_bd_pins ip_3_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_5_intc/irq_0] [get_bd_pins ip_0_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_5_intc/irq_1] [get_bd_pins ip_2_uartlite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_6_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_6_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_intc/AXI] [get_bd_intf_pins ip_6_axi/AXI_S2]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_0] [get_bd_pins ip_0_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_1] [get_bd_pins ip_0_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_2] [get_bd_pins ip_0_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_3] [get_bd_pins ip_1_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_4] [get_bd_pins ip_1_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_5] [get_bd_pins ip_1_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_6] [get_bd_pins ip_1_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_7] [get_bd_pins ip_1_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_8] [get_bd_pins ip_1_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/out0] [get_bd_pins ip_8_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_9_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_9_slice_and_concat/in_0] [get_bd_pins ip_1_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_9_slice_and_concat/out0] [get_bd_pins ip_9_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_3_reset/interconnect_aresetn] [get_bd_pins ip_6_axi/reset]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_5_intc/clk]
connect_bd_net [get_bd_pins ip_4_clk_wiz/clk_out] [get_bd_pins ip_6_axi/clk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).


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
