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
set_property -dict "CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.mode_64bit 1 " [get_bd_cells ip_0_axi_timer/axi_timer_0]
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


########## accumulator ##########
create_bd_cell -type hier ip_1_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_1_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 7ffffffffffffffffffffffffffffffffffffffffffffffffffffff CONFIG.Accum_Mode Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 207 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 219 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_1_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/clk
connect_bd_net [get_bd_pins ip_1_accumulator/clk] [get_bd_pins ip_1_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 206 -to 0 ip_1_accumulator/B
connect_bd_net [get_bd_pins ip_1_accumulator/B] [get_bd_pins ip_1_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 218 -to 0 ip_1_accumulator/Q
connect_bd_net [get_bd_pins ip_1_accumulator/Q] [get_bd_pins ip_1_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/CE
connect_bd_net [get_bd_pins ip_1_accumulator/CE] [get_bd_pins ip_1_accumulator/accumulator_0/CE]


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


########## intc ##########
create_bd_cell -type hier ip_4_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_4_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_4_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 1 " [get_bd_cells ip_4_intc/concat_0]
connect_bd_net [get_bd_pins ip_4_intc/concat_0/dout] [get_bd_pins ip_4_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_4_intc/clk
connect_bd_net [get_bd_pins ip_4_intc/clk] [get_bd_pins ip_4_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_intc/reset
connect_bd_net [get_bd_pins ip_4_intc/reset] [get_bd_pins ip_4_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_intc/AXI] [get_bd_intf_pins ip_4_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_4_intc/irq_0
connect_bd_net [get_bd_pins ip_4_intc/irq_0] [get_bd_pins ip_4_intc/concat_0/In0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_4_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_4_intc/irq] [get_bd_intf_pins ip_4_intc/intc_0/interrupt]


########## jtag_axi ##########
create_bd_cell -type hier ip_5_jtag_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0
move_bd_cells [get_bd_cells ip_5_jtag_axi] [get_bd_cells jtag_axi_0]
set_property -dict "CONFIG.PROTOCOL AXI4 " [get_bd_cells ip_5_jtag_axi/jtag_axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_jtag_axi/aclk
connect_bd_net [get_bd_pins ip_5_jtag_axi/aclk] [get_bd_pins ip_5_jtag_axi/jtag_axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_jtag_axi/aresetn
connect_bd_net [get_bd_pins ip_5_jtag_axi/aresetn] [get_bd_pins ip_5_jtag_axi/jtag_axi_0/aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_jtag_axi/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_jtag_axi/M_AXI] [get_bd_intf_pins ip_5_jtag_axi/jtag_axi_0/M_AXI]


########## axi ##########
create_bd_cell -type hier ip_6_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_6_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 1 " [get_bd_cells ip_6_axi/axi_0]
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


########## slice_and_concat ##########
create_bd_cell -type hier ip_7_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_7_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_7_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_7_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/out0] [get_bd_pins ip_7_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_0] [get_bd_pins ip_7_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_1] [get_bd_pins ip_7_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_7_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_2] [get_bd_pins ip_7_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 218 -to 0 ip_7_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_7_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 219 " [get_bd_cells ip_7_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_3] [get_bd_pins ip_7_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/slice_3/dout] [get_bd_pins ip_7_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_8_slice_and_concat
create_bd_pin -dir O -from 206 -to 0 ip_8_slice_and_concat/out0
create_bd_pin -dir I -from 218 -to 0 ip_8_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_8_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 218 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 219 " [get_bd_cells ip_8_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/in_0] [get_bd_pins ip_8_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/out0] [get_bd_pins ip_8_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_9_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_9_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_9_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_9_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_9_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_9_slice_and_concat/in_0] [get_bd_pins ip_9_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_9_slice_and_concat/out0] [get_bd_pins ip_9_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_10_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_10_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_10_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_10_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_10_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/in_0] [get_bd_pins ip_10_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/out0] [get_bd_pins ip_10_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_11_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_11_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_11_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_11_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_11_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/in_0] [get_bd_pins ip_11_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/out0] [get_bd_pins ip_11_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_3_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_4_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 14 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_7_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_9_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_10_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_11_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_3_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_4_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_2_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_0_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_1_accumulator/clk]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_2_reset/clk_in]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_locked] [get_bd_pins ip_2_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_4_intc/irq_0] [get_bd_pins ip_0_axi_timer/interrupt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_jtag_axi/M_AXI] [get_bd_intf_pins ip_6_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_6_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_intc/AXI] [get_bd_intf_pins ip_6_axi/AXI_S1]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_0] [get_bd_pins ip_0_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_1] [get_bd_pins ip_0_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_2] [get_bd_pins ip_0_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_3] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/B]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_9_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/CE]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_2_reset/interconnect_aresetn] [get_bd_pins ip_5_jtag_axi/aresetn]
connect_bd_net [get_bd_pins ip_2_reset/interconnect_aresetn] [get_bd_pins ip_6_axi/reset]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_4_intc/clk]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_5_jtag_axi/aclk]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_6_axi/clk]

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
