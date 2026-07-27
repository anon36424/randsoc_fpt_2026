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



########## accumulator ##########
create_bd_cell -type hier ip_0_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_0_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 22 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 44 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_0_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_accumulator/clk
connect_bd_net [get_bd_pins ip_0_accumulator/clk] [get_bd_pins ip_0_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 21 -to 0 ip_0_accumulator/B
connect_bd_net [get_bd_pins ip_0_accumulator/B] [get_bd_pins ip_0_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 43 -to 0 ip_0_accumulator/Q
connect_bd_net [get_bd_pins ip_0_accumulator/Q] [get_bd_pins ip_0_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_0_accumulator/ADD
connect_bd_net [get_bd_pins ip_0_accumulator/ADD] [get_bd_pins ip_0_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_0_accumulator/SCLR
connect_bd_net [get_bd_pins ip_0_accumulator/SCLR] [get_bd_pins ip_0_accumulator/accumulator_0/SCLR]


########## cordic ##########
create_bd_cell -type hier ip_1_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_1_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format UnsignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Square_Root CONFIG.Input_Width 12 CONFIG.Iterations 0 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 39 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode No_Pipelining CONFIG.Precision 0 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_1_cordic/cordic_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_1_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_1_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_1_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_1_cordic/cordic_0/M_AXIS_DOUT]


########## cordic ##########
create_bd_cell -type hier ip_2_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_2_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 46 CONFIG.Iterations 7 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 18 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 38 CONFIG.Round_Mode Truncate " [get_bd_cells ip_2_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_cordic/aclk
connect_bd_net [get_bd_pins ip_2_cordic/aclk] [get_bd_pins ip_2_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]


########## complex_multiplier ##########
create_bd_cell -type hier ip_3_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_3_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 40 CONFIG.aresetn 1 CONFIG.atuserwidth 193 CONFIG.bportwidth 43 CONFIG.btuserwidth 45 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 9 CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 11 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_3_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_3_complex_multiplier/aclk] [get_bd_pins ip_3_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_3_complex_multiplier/aresetn] [get_bd_pins ip_3_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_4_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_4_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_4_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_4_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_ethernet_lite/MII] [get_bd_intf_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_4_axi_ethernet_lite/clk] [get_bd_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_4_axi_ethernet_lite/reset] [get_bd_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_4_axi_ethernet_lite/irq] [get_bd_pins ip_4_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_5_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_5_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 10 CONFIG.aresetn 0 CONFIG.bportwidth 18 CONFIG.btuserwidth 148 CONFIG.ctrltuserwidth 7 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 1 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Manual CONFIG.minimumlatency 36 CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 19 CONFIG.outtlastbehv Pass_CTRL_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_5_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_5_complex_multiplier/aclk] [get_bd_pins ip_5_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_5_complex_multiplier/aclken] [get_bd_pins ip_5_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_hwicap ##########
create_bd_cell -type hier ip_6_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_6_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 128 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_6_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_6_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_6_axi_hwicap/icap_clk] [get_bd_pins ip_6_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_6_axi_hwicap/eos_in] [get_bd_pins ip_6_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_6_axi_hwicap/s_axi_aclk] [get_bd_pins ip_6_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_6_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_6_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_6_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_6_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_7_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_7_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Rotate CONFIG.Input_Width 34 CONFIG.Iterations 43 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour Pass_Phase_TLAST CONFIG.Out_TREADY 0 CONFIG.Output_Width 16 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode No_Pipelining CONFIG.Precision 24 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_7_cordic/cordic_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_7_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_7_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_7_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_7_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_7_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_7_cordic/cordic_0/M_AXIS_DOUT]


########## gpio ##########
create_bd_cell -type hier ip_8_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_8_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x0 CONFIG.C_GPIO2_WIDTH 1 CONFIG.C_GPIO_WIDTH 15 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x0 CONFIG.C_TRI_DEFAULT_2 0x7fff " [get_bd_cells ip_8_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio/GPIO] [get_bd_intf_pins ip_8_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio/GPIO2] [get_bd_intf_pins ip_8_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_8_gpio/clk
connect_bd_net [get_bd_pins ip_8_gpio/clk] [get_bd_pins ip_8_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_gpio/rst
connect_bd_net [get_bd_pins ip_8_gpio/rst] [get_bd_pins ip_8_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio/AXI] [get_bd_intf_pins ip_8_gpio/gpio_0/S_AXI]


########## axi_cdma ##########
create_bd_cell -type hier ip_9_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_9_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 45 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_9_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_9_axi_cdma/m_axi_aclk] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_9_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_9_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_cdma/M_AXI] [get_bd_intf_pins ip_9_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_9_axi_cdma/cdma_introut] [get_bd_pins ip_9_axi_cdma/axi_cdma_0/cdma_introut]


########## conv_encoder ##########
create_bd_cell -type hier ip_10_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_10_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 6 CONFIG.convolution_code0 58 CONFIG.convolution_code1 50 CONFIG.convolution_code2 59 CONFIG.convolution_code3 12 CONFIG.convolution_code4 36 CONFIG.convolution_code5 1 CONFIG.convolution_code6 0 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 5 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_10_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_10_conv_encoder/aclk] [get_bd_pins ip_10_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_10_conv_encoder/aclken] [get_bd_pins ip_10_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_10_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_10_conv_encoder/aresetn] [get_bd_pins ip_10_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## xadc_wiz ##########
create_bd_cell -type hier ip_11_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_11_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_11_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_11_xadc_wiz/dclk_in] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_11_xadc_wiz/reset_in] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_11_xadc_wiz/convst_in] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/ot_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/eoc_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/eos_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/busy_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_11_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_11_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_11_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/jtaglocked_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/jtagmodified_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/jtagbusy_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## axi_cdma ##########
create_bd_cell -type hier ip_12_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_12_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 49 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_12_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_12_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_12_axi_cdma/m_axi_aclk] [get_bd_pins ip_12_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_12_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_12_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_12_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_12_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_cdma/M_AXI] [get_bd_intf_pins ip_12_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_12_axi_cdma/cdma_introut] [get_bd_pins ip_12_axi_cdma/axi_cdma_0/cdma_introut]


########## gpio ##########
create_bd_cell -type hier ip_13_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_13_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 15 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x53ab " [get_bd_cells ip_13_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_13_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_13_gpio/GPIO] [get_bd_intf_pins ip_13_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_13_gpio/clk
connect_bd_net [get_bd_pins ip_13_gpio/clk] [get_bd_pins ip_13_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_gpio/rst
connect_bd_net [get_bd_pins ip_13_gpio/rst] [get_bd_pins ip_13_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_gpio/AXI] [get_bd_intf_pins ip_13_gpio/gpio_0/S_AXI]


########## axi_timer ##########
create_bd_cell -type hier ip_14_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_14_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 16 CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_High CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_14_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_timer/S_AXI] [get_bd_intf_pins ip_14_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_14_axi_timer/capturetrig0] [get_bd_pins ip_14_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_14_axi_timer/capturetrig1] [get_bd_pins ip_14_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/freeze
connect_bd_net [get_bd_pins ip_14_axi_timer/freeze] [get_bd_pins ip_14_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_14_axi_timer/s_axi_aclk] [get_bd_pins ip_14_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_14_axi_timer/s_axi_aresetn] [get_bd_pins ip_14_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_14_axi_timer/generateout0] [get_bd_pins ip_14_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_14_axi_timer/generateout1] [get_bd_pins ip_14_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_14_axi_timer/pwm0] [get_bd_pins ip_14_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_14_axi_timer/interrupt] [get_bd_pins ip_14_axi_timer/axi_timer_0/interrupt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_15_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_15_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_15_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_15_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite/MII] [get_bd_intf_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_15_axi_ethernet_lite/clk] [get_bd_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_15_axi_ethernet_lite/reset] [get_bd_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_15_axi_ethernet_lite/irq] [get_bd_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_cdma ##########
create_bd_cell -type hier ip_16_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_16_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 59 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 128 CONFIG.C_M_AXI_MAX_BURST_LEN 4 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_16_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_16_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_16_axi_cdma/m_axi_aclk] [get_bd_pins ip_16_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_16_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_16_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_16_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_16_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_cdma/M_AXI] [get_bd_intf_pins ip_16_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_16_axi_cdma/cdma_introut] [get_bd_pins ip_16_axi_cdma/axi_cdma_0/cdma_introut]


########## reset ##########
create_bd_cell -type hier ip_17_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_17_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_reset/clk_in
connect_bd_net [get_bd_pins ip_17_reset/clk_in] [get_bd_pins ip_17_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_17_reset/reset_in
connect_bd_net [get_bd_pins ip_17_reset/reset_in] [get_bd_pins ip_17_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_17_reset/dcm_locked
connect_bd_net [get_bd_pins ip_17_reset/dcm_locked] [get_bd_pins ip_17_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_17_reset/mb_reset
connect_bd_net [get_bd_pins ip_17_reset/mb_reset] [get_bd_pins ip_17_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_17_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_17_reset/peripheral_areset_n] [get_bd_pins ip_17_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_17_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_17_reset/peripheral_areset] [get_bd_pins ip_17_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_17_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_17_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_18_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_18_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_in] [get_bd_pins ip_18_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_18_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_18_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_18_clk_wiz/reset
connect_bd_net [get_bd_pins ip_18_clk_wiz/reset] [get_bd_pins ip_18_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_18_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_locked] [get_bd_pins ip_18_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_19_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_19_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_19_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_19_intc/concat_0]
connect_bd_net [get_bd_pins ip_19_intc/concat_0/dout] [get_bd_pins ip_19_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_19_intc/clk
connect_bd_net [get_bd_pins ip_19_intc/clk] [get_bd_pins ip_19_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_intc/reset
connect_bd_net [get_bd_pins ip_19_intc/reset] [get_bd_pins ip_19_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_intc/AXI] [get_bd_intf_pins ip_19_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_19_intc/irq_0
connect_bd_net [get_bd_pins ip_19_intc/irq_0] [get_bd_pins ip_19_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_19_intc/irq_1
connect_bd_net [get_bd_pins ip_19_intc/irq_1] [get_bd_pins ip_19_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_19_intc/irq_2
connect_bd_net [get_bd_pins ip_19_intc/irq_2] [get_bd_pins ip_19_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_19_intc/irq_3
connect_bd_net [get_bd_pins ip_19_intc/irq_3] [get_bd_pins ip_19_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_19_intc/irq_4
connect_bd_net [get_bd_pins ip_19_intc/irq_4] [get_bd_pins ip_19_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_19_intc/irq_5
connect_bd_net [get_bd_pins ip_19_intc/irq_5] [get_bd_pins ip_19_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_19_intc/irq_6
connect_bd_net [get_bd_pins ip_19_intc/irq_6] [get_bd_pins ip_19_intc/concat_0/In6]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_19_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_19_intc/irq] [get_bd_intf_pins ip_19_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_20_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_20_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 10 CONFIG.NUM_SI 3 " [get_bd_cells ip_20_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_legacy/clk
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_legacy/reset
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_M0] [get_bd_intf_pins ip_20_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_M1] [get_bd_intf_pins ip_20_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_M2] [get_bd_intf_pins ip_20_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S0] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S1] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S2] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S3] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S4] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S5] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S6] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S7] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S8] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_legacy/AXI_S9] [get_bd_intf_pins ip_20_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_20_axi_legacy/clk] [get_bd_pins ip_20_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_20_axi_legacy/reset] [get_bd_pins ip_20_axi_legacy/axi_0/M09_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_21_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_21_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_21_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_21_axis_broadcaster/aclk] [get_bd_pins ip_21_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_21_axis_broadcaster/aresetn] [get_bd_pins ip_21_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_22_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_22_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_22_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_22_axis_broadcaster/aclk] [get_bd_pins ip_22_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_22_axis_broadcaster/aresetn] [get_bd_pins ip_22_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_23_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_23_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_23_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_23_axis_broadcaster/aclk] [get_bd_pins ip_23_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_23_axis_broadcaster/aresetn] [get_bd_pins ip_23_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_24_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_24_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_24_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_24_axis_broadcaster/aclk] [get_bd_pins ip_24_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_24_axis_broadcaster/aresetn] [get_bd_pins ip_24_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_25_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_25_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_25_axis_dwidth_converter/aclk] [get_bd_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_25_axis_dwidth_converter/aresetn] [get_bd_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_26_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_26_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aclk] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aresetn] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_27_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_27_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_27_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aclk] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aresetn] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_28_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_28_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 5 CONFIG.S_TDATA_NUM_BYTES 5 " [get_bd_cells ip_28_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aclk] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aresetn] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_29_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_29_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_29_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_31_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aclk] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aresetn] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_33_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_33_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_33_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_33_axis_combiner/aclk] [get_bd_pins ip_33_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_33_axis_combiner/aresetn] [get_bd_pins ip_33_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_33_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_33_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_combiner/M_AXIS] [get_bd_intf_pins ip_33_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_34_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_34_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_34_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aclk] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aresetn] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_35_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_35_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_35_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_35_axis_combiner/aclk] [get_bd_pins ip_35_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_35_axis_combiner/aresetn] [get_bd_pins ip_35_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_combiner/M_AXIS] [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_36_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_36_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_36_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_36_axis_dwidth_converter/aclk] [get_bd_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_36_axis_dwidth_converter/aresetn] [get_bd_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 43 -to 0 ip_37_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 44 " [get_bd_cells ip_37_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 29 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 43 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 44 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 21 -to 0 ip_39_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 10 " [get_bd_cells ip_39_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 43 -to 0 ip_39_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 43 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 44 " [get_bd_cells ip_39_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_39_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/slice_0/dout] [get_bd_pins ip_39_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_1] [get_bd_pins ip_39_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_2] [get_bd_pins ip_39_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_3] [get_bd_pins ip_39_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_4] [get_bd_pins ip_39_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_5] [get_bd_pins ip_39_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_6] [get_bd_pins ip_39_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_7] [get_bd_pins ip_39_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_8] [get_bd_pins ip_39_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_9] [get_bd_pins ip_39_slice_and_concat/concat/In9]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_40_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_41_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_42_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_42_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_43_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_44_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_46_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_47_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_47_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_18_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_4_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_ethernet_lite_MII] [get_bd_intf_pins ip_4_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio_GPIO] [get_bd_intf_pins ip_8_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_8_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_8_gpio_GPIO2] [get_bd_intf_pins ip_8_gpio/GPIO2]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_11_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_11_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_11_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_13_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_13_gpio_GPIO] [get_bd_intf_pins ip_13_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_15_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite_MII] [get_bd_intf_pins ip_15_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_19_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_0]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 29 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_38_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_18_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_19_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_3_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_17_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_17_reset/peripheral_areset_n] [get_bd_pins ip_8_gpio/rst]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_10_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/peripheral_areset] [get_bd_pins ip_11_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_17_reset/peripheral_areset_n] [get_bd_pins ip_13_gpio/rst]
connect_bd_net [get_bd_pins ip_17_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_17_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_0_accumulator/clk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_2_cordic/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_3_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_4_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_5_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_6_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_6_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_8_gpio/clk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_9_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_10_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_11_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_12_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_12_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_13_gpio/clk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_14_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_15_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_16_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_16_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_17_reset/clk_in]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_locked] [get_bd_pins ip_17_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_19_intc/irq_0] [get_bd_pins ip_4_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_19_intc/irq_1] [get_bd_pins ip_6_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_19_intc/irq_2] [get_bd_pins ip_9_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_19_intc/irq_3] [get_bd_pins ip_12_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_19_intc/irq_4] [get_bd_pins ip_14_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_19_intc/irq_5] [get_bd_pins ip_15_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_19_intc/irq_6] [get_bd_pins ip_16_axi_cdma/cdma_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/M_AXI] [get_bd_intf_pins ip_20_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_cdma/M_AXI] [get_bd_intf_pins ip_20_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_cdma/M_AXI] [get_bd_intf_pins ip_20_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_20_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_20_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_gpio/AXI] [get_bd_intf_pins ip_20_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_20_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_20_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_gpio/AXI] [get_bd_intf_pins ip_20_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_timer/S_AXI] [get_bd_intf_pins ip_20_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_20_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_20_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_intc/AXI] [get_bd_intf_pins ip_20_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_21_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_22_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_23_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_24_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_1_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_6_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_0_accumulator/B]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_1] [get_bd_pins ip_11_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_2] [get_bd_pins ip_11_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_3] [get_bd_pins ip_11_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_4] [get_bd_pins ip_11_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_5] [get_bd_pins ip_11_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_6] [get_bd_pins ip_11_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_7] [get_bd_pins ip_14_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_8] [get_bd_pins ip_14_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_9] [get_bd_pins ip_14_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_14_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_0_accumulator/ADD]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_10_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_14_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_14_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_0_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_11_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_5_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_20_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_17_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_19_intc/clk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_20_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_21_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_22_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_23_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_24_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_28_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_29_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_33_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_34_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_35_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_18_clk_wiz/clk_out] [get_bd_pins ip_36_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_cordic/S_AXIS_CARTESIAN declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_cordic/S_AXIS_CARTESIAN declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_cordic/M_AXIS_DOUT declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_cordic/M_AXIS_DOUT declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_A declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_A declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_B declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_B declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_cordic/S_AXIS_CARTESIAN declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_cordic/S_AXIS_CARTESIAN declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_cordic/S_AXIS_PHASE declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_cordic/S_AXIS_PHASE declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_combiner/S_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_combiner/S_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_combiner/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_combiner/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/S_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_combiner/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }


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
