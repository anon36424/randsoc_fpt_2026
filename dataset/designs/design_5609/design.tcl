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



########## gpio ##########
create_bd_cell -type hier ip_0_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_0_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 20 CONFIG.C_GPIO_WIDTH 1 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_0_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO2] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/clk
connect_bd_net [get_bd_pins ip_0_gpio/clk] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/rst
connect_bd_net [get_bd_pins ip_0_gpio/rst] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_0_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_gpio/irq
connect_bd_net [get_bd_pins ip_0_gpio/irq] [get_bd_pins ip_0_gpio/gpio_0/ip2intc_irpt]


########## accumulator ##########
create_bd_cell -type hier ip_1_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_1_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 7ffffffffffffffffffffffffffffffffffffffffffffffffffffffff CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 130 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 227 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_1_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/clk
connect_bd_net [get_bd_pins ip_1_accumulator/clk] [get_bd_pins ip_1_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 129 -to 0 ip_1_accumulator/B
connect_bd_net [get_bd_pins ip_1_accumulator/B] [get_bd_pins ip_1_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 226 -to 0 ip_1_accumulator/Q
connect_bd_net [get_bd_pins ip_1_accumulator/Q] [get_bd_pins ip_1_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/ADD
connect_bd_net [get_bd_pins ip_1_accumulator/ADD] [get_bd_pins ip_1_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/C_IN
connect_bd_net [get_bd_pins ip_1_accumulator/C_IN] [get_bd_pins ip_1_accumulator/accumulator_0/C_IN]


########## cordic ##########
create_bd_cell -type hier ip_2_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_2_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 46 CONFIG.Iterations 37 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 32 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 36 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_2_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_cordic/aclk
connect_bd_net [get_bd_pins ip_2_cordic/aclk] [get_bd_pins ip_2_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_cordic/aclken
connect_bd_net [get_bd_pins ip_2_cordic/aclken] [get_bd_pins ip_2_cordic/cordic_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_2_cordic/aresetn
connect_bd_net [get_bd_pins ip_2_cordic/aresetn] [get_bd_pins ip_2_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value fffffffffffffffffffffffffff CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 43 CONFIG.Latency 21 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 108 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 42 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 107 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/ADD
connect_bd_net [get_bd_pins ip_3_accumulator/ADD] [get_bd_pins ip_3_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/CE
connect_bd_net [get_bd_pins ip_3_accumulator/CE] [get_bd_pins ip_3_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/Bypass
connect_bd_net [get_bd_pins ip_3_accumulator/Bypass] [get_bd_pins ip_3_accumulator/accumulator_0/Bypass]


########## dft ##########
create_bd_cell -type hier ip_4_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_4_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 12 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_4_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CLK
connect_bd_net [get_bd_pins ip_4_dft/CLK] [get_bd_pins ip_4_dft/dft_0/CLK]
create_bd_pin -dir I -from 11 -to 0 ip_4_dft/XN_RE
connect_bd_net [get_bd_pins ip_4_dft/XN_RE] [get_bd_pins ip_4_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 11 -to 0 ip_4_dft/XN_IM
connect_bd_net [get_bd_pins ip_4_dft/XN_IM] [get_bd_pins ip_4_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FD_IN
connect_bd_net [get_bd_pins ip_4_dft/FD_IN] [get_bd_pins ip_4_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FWD_INV
connect_bd_net [get_bd_pins ip_4_dft/FWD_INV] [get_bd_pins ip_4_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_4_dft/SIZE
connect_bd_net [get_bd_pins ip_4_dft/SIZE] [get_bd_pins ip_4_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/RFFD
connect_bd_net [get_bd_pins ip_4_dft/RFFD] [get_bd_pins ip_4_dft/dft_0/RFFD]
create_bd_pin -dir O -from 11 -to 0 ip_4_dft/XK_RE
connect_bd_net [get_bd_pins ip_4_dft/XK_RE] [get_bd_pins ip_4_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 11 -to 0 ip_4_dft/XK_IM
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
set_property -dict "CONFIG.AINIT_Value 0 CONFIG.Accum_Mode Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 70 CONFIG.Latency 4 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 140 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_5_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/clk
connect_bd_net [get_bd_pins ip_5_accumulator/clk] [get_bd_pins ip_5_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 69 -to 0 ip_5_accumulator/B
connect_bd_net [get_bd_pins ip_5_accumulator/B] [get_bd_pins ip_5_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 139 -to 0 ip_5_accumulator/Q
connect_bd_net [get_bd_pins ip_5_accumulator/Q] [get_bd_pins ip_5_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_5_accumulator/Bypass
connect_bd_net [get_bd_pins ip_5_accumulator/Bypass] [get_bd_pins ip_5_accumulator/accumulator_0/Bypass]


########## axi_dma ##########
create_bd_cell -type hier ip_6_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_6_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 57 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_6_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_6_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_6_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_6_axi_dma/axi_resetn] [get_bd_pins ip_6_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_6_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_6_axi_dma/s2mm_introut] [get_bd_pins ip_6_axi_dma/axi_dma_0/s2mm_introut]


########## gpio ##########
create_bd_cell -type hier ip_7_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_7_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 21 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_7_gpio/gpio_0]
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


########## accumulator ##########
create_bd_cell -type hier ip_8_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_8_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 12 CONFIG.Latency 2 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 44 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_8_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/clk
connect_bd_net [get_bd_pins ip_8_accumulator/clk] [get_bd_pins ip_8_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 11 -to 0 ip_8_accumulator/B
connect_bd_net [get_bd_pins ip_8_accumulator/B] [get_bd_pins ip_8_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 43 -to 0 ip_8_accumulator/Q
connect_bd_net [get_bd_pins ip_8_accumulator/Q] [get_bd_pins ip_8_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/C_IN
connect_bd_net [get_bd_pins ip_8_accumulator/C_IN] [get_bd_pins ip_8_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/SCLR
connect_bd_net [get_bd_pins ip_8_accumulator/SCLR] [get_bd_pins ip_8_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_8_accumulator/Bypass
connect_bd_net [get_bd_pins ip_8_accumulator/Bypass] [get_bd_pins ip_8_accumulator/accumulator_0/Bypass]


########## axi_hwicap ##########
create_bd_cell -type hier ip_9_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_9_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 0 CONFIG.C_READ_FIFO_DEPTH 128 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 128 " [get_bd_cells ip_9_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_9_axi_hwicap/icap_clk] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_9_axi_hwicap/eos_in] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_9_axi_hwicap/s_axi_aclk] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_9_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_9_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_9_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_hwicap/ICAP] [get_bd_intf_pins ip_9_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_9_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_9_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## conv_encoder ##########
create_bd_cell -type hier ip_10_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_10_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 9 CONFIG.convolution_code0 161 CONFIG.convolution_code1 49 CONFIG.convolution_code2 315 CONFIG.convolution_code3 99 CONFIG.convolution_code4 444 CONFIG.convolution_code5 175 CONFIG.convolution_code6 481 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 8 CONFIG.output_rate 12 CONFIG.puncture_code0 10011111 CONFIG.puncture_code1 11110011 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_10_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_10_conv_encoder/aclk] [get_bd_pins ip_10_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_10_conv_encoder/aresetn] [get_bd_pins ip_10_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_10_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_11_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_11_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 1 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_11_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/IIC] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/clk] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/reset] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/irq] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## reset ##########
create_bd_cell -type hier ip_12_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_12_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_reset/clk_in
connect_bd_net [get_bd_pins ip_12_reset/clk_in] [get_bd_pins ip_12_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_12_reset/reset_in
connect_bd_net [get_bd_pins ip_12_reset/reset_in] [get_bd_pins ip_12_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_12_reset/dcm_locked
connect_bd_net [get_bd_pins ip_12_reset/dcm_locked] [get_bd_pins ip_12_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/mb_reset
connect_bd_net [get_bd_pins ip_12_reset/mb_reset] [get_bd_pins ip_12_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_12_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset] [get_bd_pins ip_12_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_12_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_13_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_13_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_in] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_13_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_13_clk_wiz/reset
connect_bd_net [get_bd_pins ip_13_clk_wiz/reset] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_13_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_locked] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_14_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_14_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_14_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_14_intc/concat_0]
connect_bd_net [get_bd_pins ip_14_intc/concat_0/dout] [get_bd_pins ip_14_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/clk
connect_bd_net [get_bd_pins ip_14_intc/clk] [get_bd_pins ip_14_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/reset
connect_bd_net [get_bd_pins ip_14_intc/reset] [get_bd_pins ip_14_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_intc/AXI] [get_bd_intf_pins ip_14_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_0
connect_bd_net [get_bd_pins ip_14_intc/irq_0] [get_bd_pins ip_14_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_1
connect_bd_net [get_bd_pins ip_14_intc/irq_1] [get_bd_pins ip_14_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_2
connect_bd_net [get_bd_pins ip_14_intc/irq_2] [get_bd_pins ip_14_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_3
connect_bd_net [get_bd_pins ip_14_intc/irq_3] [get_bd_pins ip_14_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_4
connect_bd_net [get_bd_pins ip_14_intc/irq_4] [get_bd_pins ip_14_intc/concat_0/In4]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_14_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_14_intc/irq] [get_bd_intf_pins ip_14_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_15_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_15_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 6 CONFIG.NUM_SI 2 " [get_bd_cells ip_15_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_legacy/clk
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_legacy/reset
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M0] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M1] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S0] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S1] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S2] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S3] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S4] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S5] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M05_ARESETN]


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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_17_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_18_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_18_axis_dwidth_converter/aclk] [get_bd_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_18_axis_dwidth_converter/aresetn] [get_bd_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_19_reduce
create_bd_pin -dir I -from 263 -to 0 ip_19_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_19_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_19_reduce/concat]
connect_bd_net [get_bd_pins ip_19_reduce/out0] [get_bd_pins ip_19_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_0]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 9 " [get_bd_cells ip_19_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_19_reduce/slice_0/dout] [get_bd_pins ip_19_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_0/Res] [get_bd_pins ip_19_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_1]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 9 " [get_bd_cells ip_19_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_19_reduce/slice_1/dout] [get_bd_pins ip_19_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_1/Res] [get_bd_pins ip_19_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 26 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_2]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 9 " [get_bd_cells ip_19_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_19_reduce/slice_2/dout] [get_bd_pins ip_19_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_2/Res] [get_bd_pins ip_19_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 35 CONFIG.DIN_TO 27 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_3]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 9 " [get_bd_cells ip_19_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_19_reduce/slice_3/dout] [get_bd_pins ip_19_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_3/Res] [get_bd_pins ip_19_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 36 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_4]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 9 " [get_bd_cells ip_19_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_19_reduce/slice_4/dout] [get_bd_pins ip_19_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_4/Res] [get_bd_pins ip_19_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 53 CONFIG.DIN_TO 45 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_5]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 9 " [get_bd_cells ip_19_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_19_reduce/slice_5/dout] [get_bd_pins ip_19_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_5/Res] [get_bd_pins ip_19_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 62 CONFIG.DIN_TO 54 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_6]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 9 " [get_bd_cells ip_19_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_19_reduce/slice_6/dout] [get_bd_pins ip_19_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_6/Res] [get_bd_pins ip_19_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 71 CONFIG.DIN_TO 63 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_7]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 9 " [get_bd_cells ip_19_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_19_reduce/slice_7/dout] [get_bd_pins ip_19_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_7/Res] [get_bd_pins ip_19_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 79 CONFIG.DIN_TO 72 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_8]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_19_reduce/slice_8/dout] [get_bd_pins ip_19_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_8/Res] [get_bd_pins ip_19_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 87 CONFIG.DIN_TO 80 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_9]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_19_reduce/slice_9/dout] [get_bd_pins ip_19_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_9/Res] [get_bd_pins ip_19_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 95 CONFIG.DIN_TO 88 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_10]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_19_reduce/slice_10/dout] [get_bd_pins ip_19_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_10/Res] [get_bd_pins ip_19_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 103 CONFIG.DIN_TO 96 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_11]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_19_reduce/slice_11/dout] [get_bd_pins ip_19_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_11/Res] [get_bd_pins ip_19_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 111 CONFIG.DIN_TO 104 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_12]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_19_reduce/slice_12/dout] [get_bd_pins ip_19_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_12/Res] [get_bd_pins ip_19_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 119 CONFIG.DIN_TO 112 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_13]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_19_reduce/slice_13/dout] [get_bd_pins ip_19_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_13/Res] [get_bd_pins ip_19_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 127 CONFIG.DIN_TO 120 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_14]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_19_reduce/slice_14/dout] [get_bd_pins ip_19_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_14/Res] [get_bd_pins ip_19_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 135 CONFIG.DIN_TO 128 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_15]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_19_reduce/slice_15/dout] [get_bd_pins ip_19_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_15/Res] [get_bd_pins ip_19_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 143 CONFIG.DIN_TO 136 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_16]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_19_reduce/slice_16/dout] [get_bd_pins ip_19_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_16/Res] [get_bd_pins ip_19_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 151 CONFIG.DIN_TO 144 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_17]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_19_reduce/slice_17/dout] [get_bd_pins ip_19_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_17/Res] [get_bd_pins ip_19_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 159 CONFIG.DIN_TO 152 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_18]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_19_reduce/slice_18/dout] [get_bd_pins ip_19_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_18/Res] [get_bd_pins ip_19_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 167 CONFIG.DIN_TO 160 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_19]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_19_reduce/slice_19/dout] [get_bd_pins ip_19_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_19/Res] [get_bd_pins ip_19_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 175 CONFIG.DIN_TO 168 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_20]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_19_reduce/slice_20/dout] [get_bd_pins ip_19_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_20/Res] [get_bd_pins ip_19_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 183 CONFIG.DIN_TO 176 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_21]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_19_reduce/slice_21/dout] [get_bd_pins ip_19_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_21/Res] [get_bd_pins ip_19_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 191 CONFIG.DIN_TO 184 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_22]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_19_reduce/slice_22/dout] [get_bd_pins ip_19_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_22/Res] [get_bd_pins ip_19_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 199 CONFIG.DIN_TO 192 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_23]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_19_reduce/slice_23/dout] [get_bd_pins ip_19_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_23/Res] [get_bd_pins ip_19_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 207 CONFIG.DIN_TO 200 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_24]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_19_reduce/slice_24/dout] [get_bd_pins ip_19_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_24/Res] [get_bd_pins ip_19_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 215 CONFIG.DIN_TO 208 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_25]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_19_reduce/slice_25/dout] [get_bd_pins ip_19_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_25/Res] [get_bd_pins ip_19_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 223 CONFIG.DIN_TO 216 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_26]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_19_reduce/slice_26/dout] [get_bd_pins ip_19_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_26/Res] [get_bd_pins ip_19_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 231 CONFIG.DIN_TO 224 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_27]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_19_reduce/slice_27/dout] [get_bd_pins ip_19_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_27/Res] [get_bd_pins ip_19_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 239 CONFIG.DIN_TO 232 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_28]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_19_reduce/slice_28/dout] [get_bd_pins ip_19_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_28/Res] [get_bd_pins ip_19_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 247 CONFIG.DIN_TO 240 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_29]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_19_reduce/slice_29/dout] [get_bd_pins ip_19_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_29/Res] [get_bd_pins ip_19_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 255 CONFIG.DIN_TO 248 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_30]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_19_reduce/slice_30/dout] [get_bd_pins ip_19_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_30/Res] [get_bd_pins ip_19_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 263 CONFIG.DIN_TO 256 CONFIG.DIN_WIDTH 264 " [get_bd_cells ip_19_reduce/slice_31]
connect_bd_net [get_bd_pins ip_19_reduce/in0] [get_bd_pins ip_19_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_19_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_19_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_19_reduce/slice_31/dout] [get_bd_pins ip_19_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_19_reduce/reduce_31/Res] [get_bd_pins ip_19_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 69 -to 0 ip_20_slice_and_concat/out0
create_bd_pin -dir I -from 226 -to 0 ip_20_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 69 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 227 " [get_bd_cells ip_20_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_21_slice_and_concat/out0
create_bd_pin -dir I -from 226 -to 0 ip_21_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 81 CONFIG.DIN_TO 70 CONFIG.DIN_WIDTH 227 " [get_bd_cells ip_21_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_21_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_22_slice_and_concat/out0
create_bd_pin -dir I -from 226 -to 0 ip_22_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 82 CONFIG.DIN_TO 82 CONFIG.DIN_WIDTH 227 " [get_bd_cells ip_22_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 42 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 226 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 125 CONFIG.DIN_TO 83 CONFIG.DIN_WIDTH 227 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 226 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 137 CONFIG.DIN_TO 126 CONFIG.DIN_WIDTH 227 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 226 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 149 CONFIG.DIN_TO 138 CONFIG.DIN_WIDTH 227 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 129 -to 0 ip_26_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_26_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 226 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 226 CONFIG.DIN_TO 150 CONFIG.DIN_WIDTH 227 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/slice_0/dout] [get_bd_pins ip_26_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 107 -to 0 ip_26_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 52 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 108 " [get_bd_cells ip_26_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_1] [get_bd_pins ip_26_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/slice_1/dout] [get_bd_pins ip_26_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 263 -to 0 ip_27_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 9 " [get_bd_cells ip_27_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 107 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 107 CONFIG.DIN_TO 53 CONFIG.DIN_WIDTH 108 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/slice_0/dout] [get_bd_pins ip_27_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_27_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 11 -to 0 ip_27_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_2] [get_bd_pins ip_27_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 11 -to 0 ip_27_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_3] [get_bd_pins ip_27_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 3 -to 0 ip_27_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_4] [get_bd_pins ip_27_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_5] [get_bd_pins ip_27_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_6] [get_bd_pins ip_27_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 139 -to 0 ip_27_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_7] [get_bd_pins ip_27_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 43 -to 0 ip_27_slice_and_concat/in_8
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 37 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 44 " [get_bd_cells ip_27_slice_and_concat/slice_8]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_8] [get_bd_pins ip_27_slice_and_concat/slice_8/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/slice_8/dout] [get_bd_pins ip_27_slice_and_concat/concat/In8]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 43 -to 0 ip_28_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 43 CONFIG.DIN_TO 38 CONFIG.DIN_WIDTH 44 " [get_bd_cells ip_28_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/slice_0/dout]


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


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_32_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_33_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_36_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_39_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_40_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_13_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO] [get_bd_intf_pins ip_0_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO2] [get_bd_intf_pins ip_0_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_7_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio_GPIO] [get_bd_intf_pins ip_7_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_9_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_hwicap_ICAP] [get_bd_intf_pins ip_9_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_9_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_9_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi_IIC] [get_bd_intf_pins ip_11_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_14_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_19_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_33_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_35_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_37_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_38_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_39_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_0_gpio/rst]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_2_cordic/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_7_gpio/rst]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_10_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_0_gpio/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_1_accumulator/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_2_cordic/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_4_dft/CLK]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_5_accumulator/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_6_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_7_gpio/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_8_accumulator/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_9_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_9_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_10_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_12_reset/clk_in]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_locked] [get_bd_pins ip_12_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_14_intc/irq_0] [get_bd_pins ip_0_gpio/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_1] [get_bd_pins ip_6_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_2] [get_bd_pins ip_7_gpio/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_3] [get_bd_pins ip_9_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_14_intc/irq_4] [get_bd_pins ip_11_axi_quad_spi/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_15_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_15_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_gpio/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_intc/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_18_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/B]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_IM]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_9_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/B]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_RE]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/B]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_1] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_19_reduce/in0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_4_dft/RFFD]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_2] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_3] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_4] [get_bd_pins ip_4_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_5] [get_bd_pins ip_4_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_6] [get_bd_pins ip_4_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_7] [get_bd_pins ip_5_accumulator/Q]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_8] [get_bd_pins ip_8_accumulator/Q]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_4_dft/SIZE]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_8_accumulator/Q]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_4_dft/FD_IN]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_2_cordic/aclken]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_4_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/CE]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_5_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_8_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/ADD]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/ADD]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_15_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_14_intc/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_15_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_16_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_17_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_18_axis_dwidth_converter/aclk]

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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_6_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_6_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
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
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }


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
