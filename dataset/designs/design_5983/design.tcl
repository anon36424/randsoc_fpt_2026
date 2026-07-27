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
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_0_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/dclk_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_0_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_0_xadc_wiz/reset_in] [get_bd_pins ip_0_xadc_wiz/xadc_wiz_0/reset_in]
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


########## gpio ##########
create_bd_cell -type hier ip_1_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_1_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x0 CONFIG.C_GPIO2_WIDTH 20 CONFIG.C_GPIO_WIDTH 2 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x3 CONFIG.C_TRI_DEFAULT_2 0x3 " [get_bd_cells ip_1_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio/GPIO] [get_bd_intf_pins ip_1_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio/GPIO2] [get_bd_intf_pins ip_1_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_1_gpio/clk
connect_bd_net [get_bd_pins ip_1_gpio/clk] [get_bd_pins ip_1_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_gpio/rst
connect_bd_net [get_bd_pins ip_1_gpio/rst] [get_bd_pins ip_1_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio/AXI] [get_bd_intf_pins ip_1_gpio/gpio_0/S_AXI]


########## reset ##########
create_bd_cell -type hier ip_2_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_2_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_reset/clk_in
connect_bd_net [get_bd_pins ip_2_reset/clk_in] [get_bd_pins ip_2_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_2_reset/reset_in
connect_bd_net [get_bd_pins ip_2_reset/reset_in] [get_bd_pins ip_2_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_2_reset/dcm_locked
connect_bd_net [get_bd_pins ip_2_reset/dcm_locked] [get_bd_pins ip_2_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_2_reset/mb_reset
connect_bd_net [get_bd_pins ip_2_reset/mb_reset] [get_bd_pins ip_2_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_2_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_2_reset/peripheral_areset_n] [get_bd_pins ip_2_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_2_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_2_reset/peripheral_areset] [get_bd_pins ip_2_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_2_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_2_reset/interconnect_aresetn] [get_bd_pins ip_2_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_3_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_3_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_in] [get_bd_pins ip_3_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_3_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_3_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_3_clk_wiz/reset
connect_bd_net [get_bd_pins ip_3_clk_wiz/reset] [get_bd_pins ip_3_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_3_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_locked] [get_bd_pins ip_3_clk_wiz/clk_wiz_0/locked]


########## jtag_axi ##########
create_bd_cell -type hier ip_4_jtag_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0
move_bd_cells [get_bd_cells ip_4_jtag_axi] [get_bd_cells jtag_axi_0]
set_property -dict "CONFIG.PROTOCOL AXI4LITE " [get_bd_cells ip_4_jtag_axi/jtag_axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_jtag_axi/aclk
connect_bd_net [get_bd_pins ip_4_jtag_axi/aclk] [get_bd_pins ip_4_jtag_axi/jtag_axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_jtag_axi/aresetn
connect_bd_net [get_bd_pins ip_4_jtag_axi/aresetn] [get_bd_pins ip_4_jtag_axi/jtag_axi_0/aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_jtag_axi/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_jtag_axi/M_AXI] [get_bd_intf_pins ip_4_jtag_axi/jtag_axi_0/M_AXI]


########## axi_legacy ##########
create_bd_cell -type hier ip_5_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_5_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 1 CONFIG.NUM_SI 1 " [get_bd_cells ip_5_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_legacy/clk
connect_bd_net [get_bd_pins ip_5_axi_legacy/clk] [get_bd_pins ip_5_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_legacy/reset
connect_bd_net [get_bd_pins ip_5_axi_legacy/reset] [get_bd_pins ip_5_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_legacy/AXI_M0] [get_bd_intf_pins ip_5_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_5_axi_legacy/clk] [get_bd_pins ip_5_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_5_axi_legacy/reset] [get_bd_pins ip_5_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_legacy/AXI_S0] [get_bd_intf_pins ip_5_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_5_axi_legacy/clk] [get_bd_pins ip_5_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_5_axi_legacy/reset] [get_bd_pins ip_5_axi_legacy/axi_0/M00_ARESETN]


########## slice_and_concat ##########
create_bd_cell -type hier ip_6_slice_and_concat
create_bd_pin -dir O -from 2 -to 0 ip_6_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_6_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_6_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/out0] [get_bd_pins ip_6_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_6_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_0] [get_bd_pins ip_6_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_6_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_1] [get_bd_pins ip_6_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_6_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_2] [get_bd_pins ip_6_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_7_slice_and_concat
create_bd_pin -dir O -from 1 -to 0 ip_7_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_7_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_7_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/out0] [get_bd_pins ip_7_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_0] [get_bd_pins ip_7_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_1] [get_bd_pins ip_7_slice_and_concat/concat/In1]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_3_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_0_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_0_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_0_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio_GPIO] [get_bd_intf_pins ip_1_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_1_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_1_gpio_GPIO2] [get_bd_intf_pins ip_1_gpio/GPIO2]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 2 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_6_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir O -from 1 -to 0 control_O
connect_bd_net [get_bd_pins control_O] [get_bd_pins ip_7_slice_and_concat/out0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_3_clk_wiz/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_2_reset/peripheral_areset] [get_bd_pins ip_0_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_2_reset/peripheral_areset_n] [get_bd_pins ip_1_gpio/rst]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_0_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_1_gpio/clk]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_2_reset/clk_in]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_locked] [get_bd_pins ip_2_reset/dcm_locked]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_jtag_axi/M_AXI] [get_bd_intf_pins ip_5_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_gpio/AXI] [get_bd_intf_pins ip_5_axi_legacy/AXI_S0]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_1] [get_bd_pins ip_0_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_2] [get_bd_pins ip_0_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_0] [get_bd_pins ip_0_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_1] [get_bd_pins ip_0_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_2_reset/interconnect_aresetn] [get_bd_pins ip_4_jtag_axi/aresetn]
connect_bd_net [get_bd_pins ip_2_reset/interconnect_aresetn] [get_bd_pins ip_5_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_4_jtag_axi/aclk]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_5_axi_legacy/clk]

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
