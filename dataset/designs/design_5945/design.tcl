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



########## conv_encoder ##########
create_bd_cell -type hier ip_0_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_0_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 9 CONFIG.convolution_code0 101 CONFIG.convolution_code1 412 CONFIG.convolution_code2 60 CONFIG.convolution_code3 317 CONFIG.convolution_code4 234 CONFIG.convolution_code5 270 CONFIG.convolution_code6 418 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 3 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_0_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_0_conv_encoder/aclk] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_0_conv_encoder/aresetn] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## accumulator ##########
create_bd_cell -type hier ip_1_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_1_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 14 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 43 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_1_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/clk
connect_bd_net [get_bd_pins ip_1_accumulator/clk] [get_bd_pins ip_1_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 13 -to 0 ip_1_accumulator/B
connect_bd_net [get_bd_pins ip_1_accumulator/B] [get_bd_pins ip_1_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 42 -to 0 ip_1_accumulator/Q
connect_bd_net [get_bd_pins ip_1_accumulator/Q] [get_bd_pins ip_1_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/CE
connect_bd_net [get_bd_pins ip_1_accumulator/CE] [get_bd_pins ip_1_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/C_IN
connect_bd_net [get_bd_pins ip_1_accumulator/C_IN] [get_bd_pins ip_1_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/Bypass
connect_bd_net [get_bd_pins ip_1_accumulator/Bypass] [get_bd_pins ip_1_accumulator/accumulator_0/Bypass]


########## complex_multiplier ##########
create_bd_cell -type hier ip_2_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_2_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 46 CONFIG.aresetn 1 CONFIG.atuserwidth 30 CONFIG.bportwidth 8 CONFIG.btuserwidth 71 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 52 CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 45 CONFIG.roundmode Random_Rounding " [get_bd_cells ip_2_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_2_complex_multiplier/aclk] [get_bd_pins ip_2_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_2_complex_multiplier/aresetn] [get_bd_pins ip_2_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_2_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## dft ##########
create_bd_cell -type hier ip_3_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_3_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 13 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_3_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/CLK
connect_bd_net [get_bd_pins ip_3_dft/CLK] [get_bd_pins ip_3_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/SCLR
connect_bd_net [get_bd_pins ip_3_dft/SCLR] [get_bd_pins ip_3_dft/dft_0/SCLR]
create_bd_pin -dir I -from 12 -to 0 ip_3_dft/XN_RE
connect_bd_net [get_bd_pins ip_3_dft/XN_RE] [get_bd_pins ip_3_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 12 -to 0 ip_3_dft/XN_IM
connect_bd_net [get_bd_pins ip_3_dft/XN_IM] [get_bd_pins ip_3_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FD_IN
connect_bd_net [get_bd_pins ip_3_dft/FD_IN] [get_bd_pins ip_3_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FWD_INV
connect_bd_net [get_bd_pins ip_3_dft/FWD_INV] [get_bd_pins ip_3_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_3_dft/SIZE
connect_bd_net [get_bd_pins ip_3_dft/SIZE] [get_bd_pins ip_3_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/RFFD
connect_bd_net [get_bd_pins ip_3_dft/RFFD] [get_bd_pins ip_3_dft/dft_0/RFFD]
create_bd_pin -dir O -from 12 -to 0 ip_3_dft/XK_RE
connect_bd_net [get_bd_pins ip_3_dft/XK_RE] [get_bd_pins ip_3_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 12 -to 0 ip_3_dft/XK_IM
connect_bd_net [get_bd_pins ip_3_dft/XK_IM] [get_bd_pins ip_3_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_3_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_3_dft/BLK_EXP] [get_bd_pins ip_3_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/FD_OUT
connect_bd_net [get_bd_pins ip_3_dft/FD_OUT] [get_bd_pins ip_3_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_3_dft/DATA_VALID] [get_bd_pins ip_3_dft/dft_0/DATA_VALID]


########## gpio ##########
create_bd_cell -type hier ip_4_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_4_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x6 CONFIG.C_DOUT_DEFAULT_2 0x7 CONFIG.C_GPIO2_WIDTH 9 CONFIG.C_GPIO_WIDTH 3 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x7 CONFIG.C_TRI_DEFAULT_2 0x7 " [get_bd_cells ip_4_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_4_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio/GPIO] [get_bd_intf_pins ip_4_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_4_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio/GPIO2] [get_bd_intf_pins ip_4_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_4_gpio/clk
connect_bd_net [get_bd_pins ip_4_gpio/clk] [get_bd_pins ip_4_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_gpio/rst
connect_bd_net [get_bd_pins ip_4_gpio/rst] [get_bd_pins ip_4_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio/AXI] [get_bd_intf_pins ip_4_gpio/gpio_0/S_AXI]


########## fft ##########
create_bd_cell -type hier ip_5_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_5_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 12 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 512 " [get_bd_cells ip_5_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_fft/aclk
connect_bd_net [get_bd_pins ip_5_fft/aclk] [get_bd_pins ip_5_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_5_fft/event_frame_started
connect_bd_net [get_bd_pins ip_5_fft/event_frame_started] [get_bd_pins ip_5_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_fft/S_AXIS_DATA] [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_fft/M_AXIS_DATA] [get_bd_intf_pins ip_5_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_5_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_CONFIG]


########## dft ##########
create_bd_cell -type hier ip_6_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_6_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 9 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_6_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/CLK
connect_bd_net [get_bd_pins ip_6_dft/CLK] [get_bd_pins ip_6_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/CE
connect_bd_net [get_bd_pins ip_6_dft/CE] [get_bd_pins ip_6_dft/dft_0/CE]
create_bd_pin -dir I -from 8 -to 0 ip_6_dft/XN_RE
connect_bd_net [get_bd_pins ip_6_dft/XN_RE] [get_bd_pins ip_6_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 8 -to 0 ip_6_dft/XN_IM
connect_bd_net [get_bd_pins ip_6_dft/XN_IM] [get_bd_pins ip_6_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FD_IN
connect_bd_net [get_bd_pins ip_6_dft/FD_IN] [get_bd_pins ip_6_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FWD_INV
connect_bd_net [get_bd_pins ip_6_dft/FWD_INV] [get_bd_pins ip_6_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_6_dft/SIZE
connect_bd_net [get_bd_pins ip_6_dft/SIZE] [get_bd_pins ip_6_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/RFFD
connect_bd_net [get_bd_pins ip_6_dft/RFFD] [get_bd_pins ip_6_dft/dft_0/RFFD]
create_bd_pin -dir O -from 8 -to 0 ip_6_dft/XK_RE
connect_bd_net [get_bd_pins ip_6_dft/XK_RE] [get_bd_pins ip_6_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 8 -to 0 ip_6_dft/XK_IM
connect_bd_net [get_bd_pins ip_6_dft/XK_IM] [get_bd_pins ip_6_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_6_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_6_dft/BLK_EXP] [get_bd_pins ip_6_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/FD_OUT
connect_bd_net [get_bd_pins ip_6_dft/FD_OUT] [get_bd_pins ip_6_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_6_dft/DATA_VALID] [get_bd_pins ip_6_dft/dft_0/DATA_VALID]


########## gpio ##########
create_bd_cell -type hier ip_7_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_7_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_GPIO_WIDTH 7 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_7_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_7_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio/GPIO] [get_bd_intf_pins ip_7_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_7_gpio/clk
connect_bd_net [get_bd_pins ip_7_gpio/clk] [get_bd_pins ip_7_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_gpio/rst
connect_bd_net [get_bd_pins ip_7_gpio/rst] [get_bd_pins ip_7_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio/AXI] [get_bd_intf_pins ip_7_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_gpio/irq
connect_bd_net [get_bd_pins ip_7_gpio/irq] [get_bd_pins ip_7_gpio/gpio_0/ip2intc_irpt]


########## fft ##########
create_bd_cell -type hier ip_8_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_8_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 7 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 64 " [get_bd_cells ip_8_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_fft/aclk
connect_bd_net [get_bd_pins ip_8_fft/aclk] [get_bd_pins ip_8_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_8_fft/event_frame_started
connect_bd_net [get_bd_pins ip_8_fft/event_frame_started] [get_bd_pins ip_8_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_fft/S_AXIS_DATA] [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_8_fft/M_AXIS_DATA] [get_bd_intf_pins ip_8_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_8_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_CONFIG]


########## gpio ##########
create_bd_cell -type hier ip_9_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_9_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x7ff CONFIG.C_GPIO2_WIDTH 3 CONFIG.C_GPIO_WIDTH 11 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x7ff CONFIG.C_TRI_DEFAULT_2 0x28d " [get_bd_cells ip_9_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/GPIO] [get_bd_intf_pins ip_9_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/GPIO2] [get_bd_intf_pins ip_9_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/clk
connect_bd_net [get_bd_pins ip_9_gpio/clk] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/rst
connect_bd_net [get_bd_pins ip_9_gpio/rst] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_9_gpio/gpio_0/S_AXI]


########## gpio ##########
create_bd_cell -type hier ip_10_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_10_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x7ff CONFIG.C_DOUT_DEFAULT_2 0x459 CONFIG.C_GPIO2_WIDTH 10 CONFIG.C_GPIO_WIDTH 11 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x0 CONFIG.C_TRI_DEFAULT_2 0x5d2 " [get_bd_cells ip_10_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_10_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_10_gpio/GPIO] [get_bd_intf_pins ip_10_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_10_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_10_gpio/GPIO2] [get_bd_intf_pins ip_10_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_10_gpio/clk
connect_bd_net [get_bd_pins ip_10_gpio/clk] [get_bd_pins ip_10_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_gpio/rst
connect_bd_net [get_bd_pins ip_10_gpio/rst] [get_bd_pins ip_10_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_gpio/AXI] [get_bd_intf_pins ip_10_gpio/gpio_0/S_AXI]


########## floating_point ##########
create_bd_cell -type hier ip_11_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_11_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.a_tuser_width 30 CONFIG.add_sub_value Both CONFIG.c_a_exponent_width 6 CONFIG.c_a_fraction_width 27 CONFIG.c_accum_input_msb 5 CONFIG.c_accum_lsb -22 CONFIG.c_accum_msb 38 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_accum_input_overflow 1 CONFIG.c_has_accum_overflow 0 CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.c_optimization Speed_Optimized CONFIG.flow_control NonBlocking CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Accumulator " [get_bd_cells ip_11_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_floating_point/aclk
connect_bd_net [get_bd_pins ip_11_floating_point/aclk] [get_bd_pins ip_11_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_floating_point/aclken
connect_bd_net [get_bd_pins ip_11_floating_point/aclken] [get_bd_pins ip_11_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_11_floating_point/aresetn
connect_bd_net [get_bd_pins ip_11_floating_point/aresetn] [get_bd_pins ip_11_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/S_AXIS_A] [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/S_AXIS_OPERATION
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/S_AXIS_OPERATION] [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_OPERATION]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_11_floating_point/floating_point_0/M_AXIS_RESULT]


########## dft ##########
create_bd_cell -type hier ip_12_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_12_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 17 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_12_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/CLK
connect_bd_net [get_bd_pins ip_12_dft/CLK] [get_bd_pins ip_12_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/CE
connect_bd_net [get_bd_pins ip_12_dft/CE] [get_bd_pins ip_12_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/SCLR
connect_bd_net [get_bd_pins ip_12_dft/SCLR] [get_bd_pins ip_12_dft/dft_0/SCLR]
create_bd_pin -dir I -from 16 -to 0 ip_12_dft/XN_RE
connect_bd_net [get_bd_pins ip_12_dft/XN_RE] [get_bd_pins ip_12_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 16 -to 0 ip_12_dft/XN_IM
connect_bd_net [get_bd_pins ip_12_dft/XN_IM] [get_bd_pins ip_12_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/FD_IN
connect_bd_net [get_bd_pins ip_12_dft/FD_IN] [get_bd_pins ip_12_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/FWD_INV
connect_bd_net [get_bd_pins ip_12_dft/FWD_INV] [get_bd_pins ip_12_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_12_dft/SIZE
connect_bd_net [get_bd_pins ip_12_dft/SIZE] [get_bd_pins ip_12_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_12_dft/RFFD
connect_bd_net [get_bd_pins ip_12_dft/RFFD] [get_bd_pins ip_12_dft/dft_0/RFFD]
create_bd_pin -dir O -from 16 -to 0 ip_12_dft/XK_RE
connect_bd_net [get_bd_pins ip_12_dft/XK_RE] [get_bd_pins ip_12_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 16 -to 0 ip_12_dft/XK_IM
connect_bd_net [get_bd_pins ip_12_dft/XK_IM] [get_bd_pins ip_12_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_12_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_12_dft/BLK_EXP] [get_bd_pins ip_12_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_12_dft/FD_OUT
connect_bd_net [get_bd_pins ip_12_dft/FD_OUT] [get_bd_pins ip_12_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_12_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_12_dft/DATA_VALID] [get_bd_pins ip_12_dft/dft_0/DATA_VALID]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_13_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_13_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_13_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_13_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_ethernet_lite/MII] [get_bd_intf_pins ip_13_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_13_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_13_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_13_axi_ethernet_lite/clk] [get_bd_pins ip_13_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_13_axi_ethernet_lite/reset] [get_bd_pins ip_13_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_13_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_13_axi_ethernet_lite/irq] [get_bd_pins ip_13_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_iic ##########
create_bd_cell -type hier ip_14_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_14_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x43 CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 21 CONFIG.C_SDA_INERTIAL_DELAY 122 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 210.25707393178084 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_14_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_14_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_iic/IIC] [get_bd_intf_pins ip_14_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_iic/clk
connect_bd_net [get_bd_pins ip_14_axi_iic/clk] [get_bd_pins ip_14_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_iic/reset
connect_bd_net [get_bd_pins ip_14_axi_iic/reset] [get_bd_pins ip_14_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_iic/AXI] [get_bd_intf_pins ip_14_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_iic/irq
connect_bd_net [get_bd_pins ip_14_axi_iic/irq] [get_bd_pins ip_14_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_15_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_15_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 57 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 2 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 18 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_15_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_15_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_15_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_15_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_15_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_15_axi_dma/axi_resetn] [get_bd_pins ip_15_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_15_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_15_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_15_axi_dma/mm2s_introut] [get_bd_pins ip_15_axi_dma/axi_dma_0/mm2s_introut]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_16_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_16_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_16_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_16_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_ethernet_lite/MII] [get_bd_intf_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_16_axi_ethernet_lite/clk] [get_bd_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_16_axi_ethernet_lite/reset] [get_bd_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_16_axi_ethernet_lite/irq] [get_bd_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_17_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_17_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 46 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 16 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 8 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 128 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 22 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_17_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_17_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_17_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_17_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_17_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_17_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_17_axi_dma/axi_resetn] [get_bd_pins ip_17_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_17_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_17_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_17_axi_dma/mm2s_introut] [get_bd_pins ip_17_axi_dma/axi_dma_0/mm2s_introut]


########## cordic ##########
create_bd_cell -type hier ip_18_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_18_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Arc_Tanh CONFIG.Input_Width 20 CONFIG.Iterations 8 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 30 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 42 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_18_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_cordic/aclk
connect_bd_net [get_bd_pins ip_18_cordic/aclk] [get_bd_pins ip_18_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_18_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_18_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_18_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_18_cordic/cordic_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_19_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_19_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 3 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 14 CONFIG.C_TAVDV_PS_MEM_0 15929 CONFIG.C_TAVDV_PS_MEM_1 13868 CONFIG.C_TAVDV_PS_MEM_2 16227 CONFIG.C_TAVDV_PS_MEM_3 15573 CONFIG.C_TCEDV_PS_MEM_0 15682 CONFIG.C_TCEDV_PS_MEM_1 14049 CONFIG.C_TCEDV_PS_MEM_2 15636 CONFIG.C_TCEDV_PS_MEM_3 13963 CONFIG.C_THZCE_PS_MEM_0 7572 CONFIG.C_THZCE_PS_MEM_1 7608 CONFIG.C_THZCE_PS_MEM_2 7639 CONFIG.C_THZCE_PS_MEM_3 6707 CONFIG.C_THZOE_PS_MEM_0 6380 CONFIG.C_THZOE_PS_MEM_1 7682 CONFIG.C_THZOE_PS_MEM_2 7124 CONFIG.C_THZOE_PS_MEM_3 7202 CONFIG.C_TLZWE_PS_MEM_0 5630 CONFIG.C_TLZWE_PS_MEM_1 447 CONFIG.C_TLZWE_PS_MEM_2 5869 CONFIG.C_TLZWE_PS_MEM_3 2309 CONFIG.C_TWC_PS_MEM_0 14588 CONFIG.C_TWC_PS_MEM_1 14815 CONFIG.C_TWC_PS_MEM_2 15611 CONFIG.C_TWC_PS_MEM_3 15264 CONFIG.C_TWPH_PS_MEM_0 12971 CONFIG.C_TWPH_PS_MEM_1 10860 CONFIG.C_TWPH_PS_MEM_2 12498 CONFIG.C_TWPH_PS_MEM_3 11217 CONFIG.C_TWP_PS_MEM_0 13185 CONFIG.C_TWP_PS_MEM_1 12819 CONFIG.C_TWP_PS_MEM_2 11012 CONFIG.C_TWP_PS_MEM_3 11584 CONFIG.C_WR_REC_TIME_MEM_0 26240 CONFIG.C_WR_REC_TIME_MEM_1 24937 CONFIG.C_WR_REC_TIME_MEM_2 25510 CONFIG.C_WR_REC_TIME_MEM_3 25618 " [get_bd_cells ip_19_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_19_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_19_emc/EMC_INTF] [get_bd_intf_pins ip_19_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_19_emc/clk
connect_bd_net [get_bd_pins ip_19_emc/clk] [get_bd_pins ip_19_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_emc/rdclk
connect_bd_net [get_bd_pins ip_19_emc/rdclk] [get_bd_pins ip_19_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_emc/rst
connect_bd_net [get_bd_pins ip_19_emc/rst] [get_bd_pins ip_19_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_emc/AXI] [get_bd_intf_pins ip_19_emc/emc_0/S_AXI_MEM]


########## conv_encoder ##########
create_bd_cell -type hier ip_20_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_20_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 8 CONFIG.convolution_code0 53 CONFIG.convolution_code1 93 CONFIG.convolution_code2 41 CONFIG.convolution_code3 217 CONFIG.convolution_code4 226 CONFIG.convolution_code5 143 CONFIG.convolution_code6 181 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 5 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_20_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_20_conv_encoder/aclk] [get_bd_pins ip_20_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_20_conv_encoder/aclken] [get_bd_pins ip_20_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_20_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_20_conv_encoder/aresetn] [get_bd_pins ip_20_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_20_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_20_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_20_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_20_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## floating_point ##########
create_bd_cell -type hier ip_21_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_21_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Int64 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.c_result_exponent_width 11 CONFIG.c_result_fraction_width 51 CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Fixed_to_float CONFIG.result_precision_type Custom CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_21_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_floating_point/aclk
connect_bd_net [get_bd_pins ip_21_floating_point/aclk] [get_bd_pins ip_21_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_floating_point/aclken
connect_bd_net [get_bd_pins ip_21_floating_point/aclken] [get_bd_pins ip_21_floating_point/floating_point_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_21_floating_point/S_AXIS_A] [get_bd_intf_pins ip_21_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_21_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_21_floating_point/floating_point_0/M_AXIS_RESULT]


########## cordic ##########
create_bd_cell -type hier ip_22_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_22_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Arc_Tan CONFIG.Input_Width 17 CONFIG.Iterations 0 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 28 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 32 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_22_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_cordic/aclk
connect_bd_net [get_bd_pins ip_22_cordic/aclk] [get_bd_pins ip_22_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_22_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_22_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_22_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_22_cordic/cordic_0/M_AXIS_DOUT]


########## cordic ##########
create_bd_cell -type hier ip_23_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_23_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Translate CONFIG.Input_Width 19 CONFIG.Iterations 31 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 13 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 19 CONFIG.Round_Mode Truncate " [get_bd_cells ip_23_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_cordic/aclk
connect_bd_net [get_bd_pins ip_23_cordic/aclk] [get_bd_pins ip_23_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_cordic/aresetn
connect_bd_net [get_bd_pins ip_23_cordic/aresetn] [get_bd_pins ip_23_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_23_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_23_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_23_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_23_cordic/cordic_0/M_AXIS_DOUT]


########## fft ##########
create_bd_cell -type hier ip_24_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_24_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 6 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 64 " [get_bd_cells ip_24_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_fft/aclk
connect_bd_net [get_bd_pins ip_24_fft/aclk] [get_bd_pins ip_24_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_24_fft/event_frame_started
connect_bd_net [get_bd_pins ip_24_fft/event_frame_started] [get_bd_pins ip_24_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_24_fft/S_AXIS_DATA] [get_bd_intf_pins ip_24_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_24_fft/M_AXIS_DATA] [get_bd_intf_pins ip_24_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_24_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_24_fft/fft_0/S_AXIS_CONFIG]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_25_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_25_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_25_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_25_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_ethernet_lite/MII] [get_bd_intf_pins ip_25_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_25_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_25_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_25_axi_ethernet_lite/clk] [get_bd_pins ip_25_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_25_axi_ethernet_lite/reset] [get_bd_pins ip_25_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_25_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_25_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_25_axi_ethernet_lite/irq] [get_bd_pins ip_25_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_26_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_26_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 64 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 13 CONFIG.C_TAVDV_PS_MEM_0 16351 CONFIG.C_TAVDV_PS_MEM_1 13918 CONFIG.C_TAVDV_PS_MEM_2 16463 CONFIG.C_TCEDV_PS_MEM_0 16252 CONFIG.C_TCEDV_PS_MEM_1 15942 CONFIG.C_TCEDV_PS_MEM_2 16298 CONFIG.C_THZCE_PS_MEM_0 6433 CONFIG.C_THZCE_PS_MEM_1 6595 CONFIG.C_THZCE_PS_MEM_2 6761 CONFIG.C_THZOE_PS_MEM_0 6810 CONFIG.C_THZOE_PS_MEM_1 6975 CONFIG.C_THZOE_PS_MEM_2 6426 CONFIG.C_TLZWE_PS_MEM_0 47 CONFIG.C_TLZWE_PS_MEM_1 9376 CONFIG.C_TLZWE_PS_MEM_2 967 CONFIG.C_TWC_PS_MEM_0 15369 CONFIG.C_TWC_PS_MEM_1 15854 CONFIG.C_TWC_PS_MEM_2 14252 CONFIG.C_TWPH_PS_MEM_0 10901 CONFIG.C_TWPH_PS_MEM_1 12600 CONFIG.C_TWPH_PS_MEM_2 11038 CONFIG.C_TWP_PS_MEM_0 12981 CONFIG.C_TWP_PS_MEM_1 12194 CONFIG.C_TWP_PS_MEM_2 11017 CONFIG.C_WR_REC_TIME_MEM_0 27306 CONFIG.C_WR_REC_TIME_MEM_1 27400 CONFIG.C_WR_REC_TIME_MEM_2 25246 " [get_bd_cells ip_26_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_26_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_26_emc/EMC_INTF] [get_bd_intf_pins ip_26_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_26_emc/clk
connect_bd_net [get_bd_pins ip_26_emc/clk] [get_bd_pins ip_26_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_emc/rdclk
connect_bd_net [get_bd_pins ip_26_emc/rdclk] [get_bd_pins ip_26_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_emc/rst
connect_bd_net [get_bd_pins ip_26_emc/rst] [get_bd_pins ip_26_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_26_emc/AXI] [get_bd_intf_pins ip_26_emc/emc_0/S_AXI_MEM]


########## reset ##########
create_bd_cell -type hier ip_27_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_27_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_reset/clk_in
connect_bd_net [get_bd_pins ip_27_reset/clk_in] [get_bd_pins ip_27_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_27_reset/reset_in
connect_bd_net [get_bd_pins ip_27_reset/reset_in] [get_bd_pins ip_27_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_27_reset/dcm_locked
connect_bd_net [get_bd_pins ip_27_reset/dcm_locked] [get_bd_pins ip_27_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_27_reset/mb_reset
connect_bd_net [get_bd_pins ip_27_reset/mb_reset] [get_bd_pins ip_27_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_27_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_27_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_27_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset] [get_bd_pins ip_27_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_27_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_27_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_28_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_28_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_in] [get_bd_pins ip_28_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_28_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_28_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_28_clk_wiz/reset
connect_bd_net [get_bd_pins ip_28_clk_wiz/reset] [get_bd_pins ip_28_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_28_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_locked] [get_bd_pins ip_28_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_29_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_29_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_29_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 10 " [get_bd_cells ip_29_intc/concat_0]
connect_bd_net [get_bd_pins ip_29_intc/concat_0/dout] [get_bd_pins ip_29_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/clk
connect_bd_net [get_bd_pins ip_29_intc/clk] [get_bd_pins ip_29_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/reset
connect_bd_net [get_bd_pins ip_29_intc/reset] [get_bd_pins ip_29_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_29_intc/AXI] [get_bd_intf_pins ip_29_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_0
connect_bd_net [get_bd_pins ip_29_intc/irq_0] [get_bd_pins ip_29_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_1
connect_bd_net [get_bd_pins ip_29_intc/irq_1] [get_bd_pins ip_29_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_2
connect_bd_net [get_bd_pins ip_29_intc/irq_2] [get_bd_pins ip_29_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_3
connect_bd_net [get_bd_pins ip_29_intc/irq_3] [get_bd_pins ip_29_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_4
connect_bd_net [get_bd_pins ip_29_intc/irq_4] [get_bd_pins ip_29_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_5
connect_bd_net [get_bd_pins ip_29_intc/irq_5] [get_bd_pins ip_29_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_6
connect_bd_net [get_bd_pins ip_29_intc/irq_6] [get_bd_pins ip_29_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_7
connect_bd_net [get_bd_pins ip_29_intc/irq_7] [get_bd_pins ip_29_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_8
connect_bd_net [get_bd_pins ip_29_intc/irq_8] [get_bd_pins ip_29_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_9
connect_bd_net [get_bd_pins ip_29_intc/irq_9] [get_bd_pins ip_29_intc/concat_0/In9]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_29_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_29_intc/irq] [get_bd_intf_pins ip_29_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_30_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_30_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 13 CONFIG.NUM_SI 2 " [get_bd_cells ip_30_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axi/clk
connect_bd_net [get_bd_pins ip_30_axi/clk] [get_bd_pins ip_30_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_axi/reset
connect_bd_net [get_bd_pins ip_30_axi/reset] [get_bd_pins ip_30_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_M0] [get_bd_intf_pins ip_30_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_M1] [get_bd_intf_pins ip_30_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S0] [get_bd_intf_pins ip_30_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S1] [get_bd_intf_pins ip_30_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S2] [get_bd_intf_pins ip_30_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S3] [get_bd_intf_pins ip_30_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S4] [get_bd_intf_pins ip_30_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S5] [get_bd_intf_pins ip_30_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S6] [get_bd_intf_pins ip_30_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S7] [get_bd_intf_pins ip_30_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S8] [get_bd_intf_pins ip_30_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S9] [get_bd_intf_pins ip_30_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S10] [get_bd_intf_pins ip_30_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S11] [get_bd_intf_pins ip_30_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_30_axi/AXI_S12] [get_bd_intf_pins ip_30_axi/axi_0/M12_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_31_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_31_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_31_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_31_axis_broadcaster/aclk] [get_bd_pins ip_31_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_31_axis_broadcaster/aresetn] [get_bd_pins ip_31_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_32_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_32_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_32_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_32_axis_broadcaster/aclk] [get_bd_pins ip_32_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_32_axis_broadcaster/aresetn] [get_bd_pins ip_32_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_33_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_33_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 5 " [get_bd_cells ip_33_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_33_axis_broadcaster/aclk] [get_bd_pins ip_33_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_33_axis_broadcaster/aresetn] [get_bd_pins ip_33_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M03_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_4
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_4] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M04_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_34_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_34_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_34_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_34_axis_broadcaster/aclk] [get_bd_pins ip_34_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_34_axis_broadcaster/aresetn] [get_bd_pins ip_34_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_35_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_35_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_35_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_35_axis_broadcaster/aclk] [get_bd_pins ip_35_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_35_axis_broadcaster/aresetn] [get_bd_pins ip_35_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_36_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_36_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_36_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_36_axis_broadcaster/aclk] [get_bd_pins ip_36_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_36_axis_broadcaster/aresetn] [get_bd_pins ip_36_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_37_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_37_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_37_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_37_axis_broadcaster/aclk] [get_bd_pins ip_37_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_37_axis_broadcaster/aresetn] [get_bd_pins ip_37_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_38_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_38_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_38_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_38_axis_dwidth_converter/aclk] [get_bd_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_38_axis_dwidth_converter/aresetn] [get_bd_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_39_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_39_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aclk] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aresetn] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_40_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_40_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_40_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_40_axis_dwidth_converter/aclk] [get_bd_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_40_axis_dwidth_converter/aresetn] [get_bd_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_41_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_41_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aclk] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aresetn] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_42_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_42_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aclk] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aresetn] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_43_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_43_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_43_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_43_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_43_axis_dwidth_converter/aclk] [get_bd_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_43_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_43_axis_dwidth_converter/aresetn] [get_bd_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_43_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_43_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_44_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_44_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 24 " [get_bd_cells ip_44_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aclk] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aresetn] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_45_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_45_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_45_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aclk] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aresetn] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_46_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_46_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 28 " [get_bd_cells ip_46_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aclk] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aresetn] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_47_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_47_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_47_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_47_axis_combiner/aclk] [get_bd_pins ip_47_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_47_axis_combiner/aresetn] [get_bd_pins ip_47_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_combiner/M_AXIS] [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_48_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_48_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 52 " [get_bd_cells ip_48_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_48_axis_dwidth_converter/aclk] [get_bd_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_48_axis_dwidth_converter/aresetn] [get_bd_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_49_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_49_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_49_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_49_axis_combiner/aclk] [get_bd_pins ip_49_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_49_axis_combiner/aresetn] [get_bd_pins ip_49_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_combiner/M_AXIS] [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_50_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_50_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_50_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_50_axis_dwidth_converter/aclk] [get_bd_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_50_axis_dwidth_converter/aresetn] [get_bd_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_51_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_51_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_51_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_51_axis_combiner/aclk] [get_bd_pins ip_51_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_51_axis_combiner/aresetn] [get_bd_pins ip_51_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/M_AXIS] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_52_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_52_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_52_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_52_axis_dwidth_converter/aclk] [get_bd_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_52_axis_dwidth_converter/aresetn] [get_bd_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_53_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_53_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_53_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_53_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_53_axis_combiner/aclk] [get_bd_pins ip_53_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_53_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_53_axis_combiner/aresetn] [get_bd_pins ip_53_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_53_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_53_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_53_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_combiner/M_AXIS] [get_bd_intf_pins ip_53_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_54_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_54_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_54_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_54_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_54_axis_combiner/aclk] [get_bd_pins ip_54_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_54_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_54_axis_combiner/aresetn] [get_bd_pins ip_54_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_combiner/M_AXIS] [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_55_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_55_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 5 CONFIG.S_TDATA_NUM_BYTES 5 " [get_bd_cells ip_55_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_55_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_55_axis_dwidth_converter/aclk] [get_bd_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_55_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_55_axis_dwidth_converter/aresetn] [get_bd_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_55_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_55_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_55_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_55_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_56_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_56_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_56_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_56_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_56_axis_combiner/aclk] [get_bd_pins ip_56_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_56_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_56_axis_combiner/aresetn] [get_bd_pins ip_56_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_56_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_56_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_56_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_56_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_56_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_56_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_56_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_56_axis_combiner/M_AXIS] [get_bd_intf_pins ip_56_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_57_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_57_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_57_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_57_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_57_axis_combiner/aclk] [get_bd_pins ip_57_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_57_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_57_axis_combiner/aresetn] [get_bd_pins ip_57_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_combiner/M_AXIS] [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 42 -to 0 ip_58_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 43 " [get_bd_cells ip_58_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_59_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_59_slice_and_concat/out0
create_bd_pin -dir I -from 42 -to 0 ip_59_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 43 " [get_bd_cells ip_59_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_59_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_59_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_60_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_60_slice_and_concat/out0
create_bd_pin -dir I -from 42 -to 0 ip_60_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 27 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 43 " [get_bd_cells ip_60_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_60_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_60_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_61_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_61_slice_and_concat/out0
create_bd_pin -dir I -from 42 -to 0 ip_61_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_61_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 40 CONFIG.DIN_TO 28 CONFIG.DIN_WIDTH 43 " [get_bd_cells ip_61_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_61_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_61_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_62_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_62_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_62_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_62_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_62_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 42 -to 0 ip_62_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_62_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 42 CONFIG.DIN_TO 41 CONFIG.DIN_WIDTH 43 " [get_bd_cells ip_62_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_62_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/slice_0/dout] [get_bd_pins ip_62_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_62_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_1] [get_bd_pins ip_62_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 12 -to 0 ip_62_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_62_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_62_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_2] [get_bd_pins ip_62_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/slice_2/dout] [get_bd_pins ip_62_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_63_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_63_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_63_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_63_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_63_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 12 -to 0 ip_63_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_63_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 11 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_63_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_63_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/slice_0/dout] [get_bd_pins ip_63_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 12 -to 0 ip_63_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_1] [get_bd_pins ip_63_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 3 -to 0 ip_63_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_63_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_63_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_2] [get_bd_pins ip_63_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/slice_2/dout] [get_bd_pins ip_63_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_64_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_64_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_64_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_64_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_64_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_64_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_64_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_64_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_64_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/slice_0/dout] [get_bd_pins ip_64_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_64_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_1] [get_bd_pins ip_64_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_64_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_2] [get_bd_pins ip_64_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_64_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_3] [get_bd_pins ip_64_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 8 -to 0 ip_64_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_4] [get_bd_pins ip_64_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 8 -to 0 ip_64_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_64_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_64_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_5] [get_bd_pins ip_64_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/slice_5/dout] [get_bd_pins ip_64_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_65_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_65_slice_and_concat/out0
create_bd_pin -dir I -from 8 -to 0 ip_65_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_65_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_65_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_65_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_65_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_66_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_66_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_66_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_66_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_66_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_66_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_1] [get_bd_pins ip_66_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_66_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_2] [get_bd_pins ip_66_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_66_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_3] [get_bd_pins ip_66_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 16 -to 0 ip_66_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_66_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_4] [get_bd_pins ip_66_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/slice_4/dout] [get_bd_pins ip_66_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_67_slice_and_concat
create_bd_pin -dir O -from 31 -to 0 ip_67_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_67_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_67_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_67_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_67_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/slice_0/dout] [get_bd_pins ip_67_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 16 -to 0 ip_67_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_1] [get_bd_pins ip_67_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_68_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_68_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_68_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_68_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_68_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_68_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_68_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_1] [get_bd_pins ip_68_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_68_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_2] [get_bd_pins ip_68_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_69_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_69_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_69_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_69_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_69_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_69_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_70_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_70_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_70_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_70_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_70_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_70_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_70_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_71_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_71_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_71_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_71_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_71_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_0] [get_bd_pins ip_71_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_71_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_72_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_72_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_72_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_72_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_72_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/in_0] [get_bd_pins ip_72_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_72_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_73_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_73_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_73_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_73_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_73_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/in_0] [get_bd_pins ip_73_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_73_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_74_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_74_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_74_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_74_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_74_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/in_0] [get_bd_pins ip_74_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_74_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_75_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_75_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_75_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_75_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_75_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/in_0] [get_bd_pins ip_75_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_75_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_76_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_76_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_76_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_76_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_76_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/in_0] [get_bd_pins ip_76_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_76_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_77_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_77_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_77_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_77_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_77_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/in_0] [get_bd_pins ip_77_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_77_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_78_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_78_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_78_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_78_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_78_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/in_0] [get_bd_pins ip_78_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/out0] [get_bd_pins ip_78_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_79_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_79_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_79_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_79_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_79_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/in_0] [get_bd_pins ip_79_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/out0] [get_bd_pins ip_79_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_80_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_80_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_80_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_80_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_80_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/in_0] [get_bd_pins ip_80_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/out0] [get_bd_pins ip_80_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_81_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_81_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_81_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_81_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_81_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/in_0] [get_bd_pins ip_81_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/out0] [get_bd_pins ip_81_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_82_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_82_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_82_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_82_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_82_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/in_0] [get_bd_pins ip_82_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/out0] [get_bd_pins ip_82_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_27_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_28_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_4_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio_GPIO] [get_bd_intf_pins ip_4_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_4_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio_GPIO2] [get_bd_intf_pins ip_4_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_7_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio_GPIO] [get_bd_intf_pins ip_7_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO] [get_bd_intf_pins ip_9_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO2] [get_bd_intf_pins ip_9_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_10_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_10_gpio_GPIO] [get_bd_intf_pins ip_10_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_10_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_10_gpio_GPIO2] [get_bd_intf_pins ip_10_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_13_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_ethernet_lite_MII] [get_bd_intf_pins ip_13_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_13_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_13_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_14_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_iic_IIC] [get_bd_intf_pins ip_14_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_16_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_ethernet_lite_MII] [get_bd_intf_pins ip_16_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_19_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_19_emc_EMC_INTF] [get_bd_intf_pins ip_19_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_25_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_ethernet_lite_MII] [get_bd_intf_pins ip_25_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_25_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_25_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_26_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_26_emc_EMC_INTF] [get_bd_intf_pins ip_26_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_29_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_67_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_69_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_70_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_71_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_72_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_73_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_74_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_75_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_76_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_77_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_78_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_79_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_80_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_81_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_82_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_28_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_29_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_0_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_2_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset] [get_bd_pins ip_3_dft/SCLR]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_4_gpio/rst]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_7_gpio/rst]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_9_gpio/rst]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_10_gpio/rst]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_11_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset] [get_bd_pins ip_12_dft/SCLR]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_iic/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_16_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_19_emc/rst]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_20_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_23_cordic/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_25_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_26_emc/rst]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_0_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_1_accumulator/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_2_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_3_dft/CLK]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_4_gpio/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_5_fft/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_6_dft/CLK]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_7_gpio/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_8_fft/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_9_gpio/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_10_gpio/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_11_floating_point/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_12_dft/CLK]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_13_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_14_axi_iic/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_15_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_15_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_16_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_17_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_17_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_18_cordic/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_19_emc/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_19_emc/rdclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_20_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_21_floating_point/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_22_cordic/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_23_cordic/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_24_fft/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_25_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_26_emc/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_26_emc/rdclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_27_reset/clk_in]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_locked] [get_bd_pins ip_27_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_29_intc/irq_0] [get_bd_pins ip_5_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_29_intc/irq_1] [get_bd_pins ip_7_gpio/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_2] [get_bd_pins ip_8_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_29_intc/irq_3] [get_bd_pins ip_13_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_4] [get_bd_pins ip_14_axi_iic/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_5] [get_bd_pins ip_15_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_29_intc/irq_6] [get_bd_pins ip_16_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_7] [get_bd_pins ip_17_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_29_intc/irq_8] [get_bd_pins ip_24_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_29_intc/irq_9] [get_bd_pins ip_25_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_30_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_30_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_gpio/AXI] [get_bd_intf_pins ip_30_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_gpio/AXI] [get_bd_intf_pins ip_30_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_30_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_gpio/AXI] [get_bd_intf_pins ip_30_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_30_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_iic/AXI] [get_bd_intf_pins ip_30_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_30_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_30_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_30_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_emc/AXI] [get_bd_intf_pins ip_30_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_30_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_emc/AXI] [get_bd_intf_pins ip_30_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_intc/AXI] [get_bd_intf_pins ip_30_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_31_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_32_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_fft/M_AXIS_DATA] [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_fft/M_AXIS_DATA] [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_floating_point/S_AXIS_OPERATION] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_11_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_floating_point/S_AXIS_A] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_18_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_5_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_47_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_49_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_50_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_52_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_51_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_52_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_53_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_53_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_53_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_fft/S_AXIS_DATA] [get_bd_intf_pins ip_53_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_55_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_54_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_floating_point/S_AXIS_A] [get_bd_intf_pins ip_55_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_56_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_56_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_fft/S_AXIS_DATA] [get_bd_intf_pins ip_56_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_57_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_DATA] [get_bd_intf_pins ip_57_axis_combiner/M_AXIS]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_RE]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_12_dft/SIZE]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_RE]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_IM]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/B]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_1] [get_bd_pins ip_3_dft/RFFD]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_2] [get_bd_pins ip_3_dft/XK_RE]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_12_dft/XN_RE]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_3_dft/XK_RE]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_1] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_2] [get_bd_pins ip_3_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_12_dft/XN_IM]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_3_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_1] [get_bd_pins ip_3_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_2] [get_bd_pins ip_3_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_3] [get_bd_pins ip_6_dft/RFFD]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_4] [get_bd_pins ip_6_dft/XK_RE]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_5] [get_bd_pins ip_6_dft/XK_IM]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_3_dft/SIZE]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_6_dft/XK_IM]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_IM]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_6_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_1] [get_bd_pins ip_6_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_2] [get_bd_pins ip_6_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_3] [get_bd_pins ip_12_dft/RFFD]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_4] [get_bd_pins ip_12_dft/XK_RE]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_12_dft/XK_RE]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_1] [get_bd_pins ip_12_dft/XK_IM]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_6_dft/SIZE]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_12_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_1] [get_bd_pins ip_12_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_2] [get_bd_pins ip_12_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_20_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_6_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_12_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_11_floating_point/aclken]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_6_dft/FD_IN]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/CE]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_3_dft/FD_IN]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/out0] [get_bd_pins ip_21_floating_point/aclken]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/out0] [get_bd_pins ip_6_dft/CE]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/out0] [get_bd_pins ip_3_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/out0] [get_bd_pins ip_12_dft/CE]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/out0] [get_bd_pins ip_12_dft/FD_IN]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_30_axi/reset]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_48_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_49_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_50_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_51_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_52_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_53_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_54_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_55_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_56_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_57_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_29_intc/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_30_axi/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_31_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_32_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_33_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_34_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_35_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_36_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_37_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_38_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_45_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_46_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_47_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_48_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_49_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_50_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_51_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_52_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_53_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_54_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_55_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_56_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_57_axis_combiner/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_A declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_A declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_B declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_B declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_complex_multiplier/M_AXIS_DOUT declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 30 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=30 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=30 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_fft/M_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_fft/M_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 19 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_CONFIG declared=19 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_CONFIG declared=19 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_A declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_A declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_OPERATION]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_OPERATION declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_OPERATION declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/M_AXIS_RESULT declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/M_AXIS_RESULT declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axi_dma/M_AXIS_MM2S declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axi_dma/M_AXIS_MM2S declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_cordic/S_AXIS_CARTESIAN declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_cordic/S_AXIS_CARTESIAN declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_cordic/S_AXIS_CARTESIAN declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_cordic/S_AXIS_CARTESIAN declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_cordic/S_AXIS_CARTESIAN declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_cordic/S_AXIS_CARTESIAN declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_fft/S_AXIS_DATA declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_fft/S_AXIS_DATA declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_fft/M_AXIS_DATA declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_fft/M_AXIS_DATA declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 23 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_fft/S_AXIS_CONFIG declared=23 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_fft/S_AXIS_CONFIG declared=23 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_3 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_3 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M04_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_4 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_4 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_3 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_3 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 30 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=30 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=30 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_1 declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_1 declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 416 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/M_AXIS declared=416 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/M_AXIS declared=416 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 416 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=416 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=416 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_combiner/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_combiner/S_AXIS_1 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_combiner/S_AXIS_1 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_combiner/S_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_combiner/S_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_combiner/M_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_combiner/M_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/M_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/M_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/S_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/S_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/M_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/M_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_56_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_56_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_56_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_56_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_56_axis_combiner/S_AXIS_1 declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_56_axis_combiner/S_AXIS_1 declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_56_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_56_axis_combiner/M_AXIS declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_56_axis_combiner/M_AXIS declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_1 declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_1 declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/S_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/M_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_combiner/M_AXIS declared=384 actual=ERR $__err" }


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
