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



########## dft ##########
create_bd_cell -type hier ip_0_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_0_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 9 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_0_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/CLK
connect_bd_net [get_bd_pins ip_0_dft/CLK] [get_bd_pins ip_0_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/CE
connect_bd_net [get_bd_pins ip_0_dft/CE] [get_bd_pins ip_0_dft/dft_0/CE]
create_bd_pin -dir I -from 8 -to 0 ip_0_dft/XN_RE
connect_bd_net [get_bd_pins ip_0_dft/XN_RE] [get_bd_pins ip_0_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 8 -to 0 ip_0_dft/XN_IM
connect_bd_net [get_bd_pins ip_0_dft/XN_IM] [get_bd_pins ip_0_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/FD_IN
connect_bd_net [get_bd_pins ip_0_dft/FD_IN] [get_bd_pins ip_0_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_0_dft/FWD_INV
connect_bd_net [get_bd_pins ip_0_dft/FWD_INV] [get_bd_pins ip_0_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_0_dft/SIZE
connect_bd_net [get_bd_pins ip_0_dft/SIZE] [get_bd_pins ip_0_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_0_dft/RFFD
connect_bd_net [get_bd_pins ip_0_dft/RFFD] [get_bd_pins ip_0_dft/dft_0/RFFD]
create_bd_pin -dir O -from 8 -to 0 ip_0_dft/XK_RE
connect_bd_net [get_bd_pins ip_0_dft/XK_RE] [get_bd_pins ip_0_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 8 -to 0 ip_0_dft/XK_IM
connect_bd_net [get_bd_pins ip_0_dft/XK_IM] [get_bd_pins ip_0_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_0_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_0_dft/BLK_EXP] [get_bd_pins ip_0_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_0_dft/FD_OUT
connect_bd_net [get_bd_pins ip_0_dft/FD_OUT] [get_bd_pins ip_0_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_0_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_0_dft/DATA_VALID] [get_bd_pins ip_0_dft/dft_0/DATA_VALID]


########## uartlite ##########
create_bd_cell -type hier ip_1_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_1_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 9600 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Odd " [get_bd_cells ip_1_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_1_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite/UART] [get_bd_intf_pins ip_1_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_1_uartlite/clk
connect_bd_net [get_bd_pins ip_1_uartlite/clk] [get_bd_pins ip_1_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_uartlite/reset
connect_bd_net [get_bd_pins ip_1_uartlite/reset] [get_bd_pins ip_1_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite/AXI] [get_bd_intf_pins ip_1_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_uartlite/irq
connect_bd_net [get_bd_pins ip_1_uartlite/irq] [get_bd_pins ip_1_uartlite/uart_0/interrupt]


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


########## axi_legacy ##########
create_bd_cell -type hier ip_5_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_5_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 1 " [get_bd_cells ip_5_axi_legacy/axi_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_legacy/AXI_S1] [get_bd_intf_pins ip_5_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_5_axi_legacy/clk] [get_bd_pins ip_5_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_5_axi_legacy/reset] [get_bd_pins ip_5_axi_legacy/axi_0/M01_ARESETN]


########## slice_and_concat ##########
create_bd_cell -type hier ip_6_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_6_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_6_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_6_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/out0] [get_bd_pins ip_6_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_6_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_0] [get_bd_pins ip_6_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 8 -to 0 ip_6_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_6_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_6_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_1] [get_bd_pins ip_6_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/slice_1/dout] [get_bd_pins ip_6_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_7_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_7_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_7_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_7_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/out0] [get_bd_pins ip_7_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_7_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_7_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_7_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_0] [get_bd_pins ip_7_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/slice_0/dout] [get_bd_pins ip_7_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 8 -to 0 ip_7_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_7_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_7_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_1] [get_bd_pins ip_7_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/slice_1/dout] [get_bd_pins ip_7_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_8_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_8_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_8_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_8_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/out0] [get_bd_pins ip_8_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_8_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_8_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_8_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/in_0] [get_bd_pins ip_8_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/slice_0/dout] [get_bd_pins ip_8_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_8_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_8_slice_and_concat/in_1] [get_bd_pins ip_8_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_8_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_8_slice_and_concat/in_2] [get_bd_pins ip_8_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_9_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_9_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_9_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_10_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_10_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_10_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_10_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_10_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/in_0] [get_bd_pins ip_10_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/out0] [get_bd_pins ip_10_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_11_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_11_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_11_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_11_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_11_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/in_0] [get_bd_pins ip_11_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/out0] [get_bd_pins ip_11_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_12_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_12_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_12_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_12_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_12_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_12_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_12_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_3_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_1_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite_UART] [get_bd_intf_pins ip_1_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_4_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi_master
set_property -dict "CONFIG.PROTOCOL AXI4LITE " [get_bd_intf_ports axi_master]
connect_bd_intf_net [get_bd_intf_pins axi_master] [get_bd_intf_pins ip_5_axi_legacy/AXI_M0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 0 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_9_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_10_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_11_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_12_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_3_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_4_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_2_reset/peripheral_areset_n] [get_bd_pins ip_1_uartlite/reset]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_0_dft/CLK]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_1_uartlite/clk]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_2_reset/clk_in]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_locked] [get_bd_pins ip_2_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_4_intc/irq_0] [get_bd_pins ip_1_uartlite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_uartlite/AXI] [get_bd_intf_pins ip_5_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_intc/AXI] [get_bd_intf_pins ip_5_axi_legacy/AXI_S1]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/out0] [get_bd_pins ip_0_dft/XN_RE]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_0] [get_bd_pins ip_0_dft/RFFD]
connect_bd_net [get_bd_pins ip_6_slice_and_concat/in_1] [get_bd_pins ip_0_dft/XK_RE]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/out0] [get_bd_pins ip_0_dft/XN_IM]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_0] [get_bd_pins ip_0_dft/XK_RE]
connect_bd_net [get_bd_pins ip_7_slice_and_concat/in_1] [get_bd_pins ip_0_dft/XK_IM]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/out0] [get_bd_pins ip_0_dft/SIZE]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/in_0] [get_bd_pins ip_0_dft/XK_IM]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/in_1] [get_bd_pins ip_0_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_8_slice_and_concat/in_2] [get_bd_pins ip_0_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_9_slice_and_concat/in_0] [get_bd_pins ip_0_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_9_slice_and_concat/out0] [get_bd_pins ip_9_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_10_slice_and_concat/out0] [get_bd_pins ip_0_dft/CE]
connect_bd_net [get_bd_pins ip_11_slice_and_concat/out0] [get_bd_pins ip_0_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_0_dft/FD_IN]
connect_bd_net [get_bd_pins ip_2_reset/interconnect_aresetn] [get_bd_pins ip_5_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_3_clk_wiz/clk_out] [get_bd_pins ip_4_intc/clk]
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
