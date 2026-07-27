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
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 43 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 45 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_0_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_accumulator/clk
connect_bd_net [get_bd_pins ip_0_accumulator/clk] [get_bd_pins ip_0_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 42 -to 0 ip_0_accumulator/B
connect_bd_net [get_bd_pins ip_0_accumulator/B] [get_bd_pins ip_0_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 44 -to 0 ip_0_accumulator/Q
connect_bd_net [get_bd_pins ip_0_accumulator/Q] [get_bd_pins ip_0_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_0_accumulator/CE
connect_bd_net [get_bd_pins ip_0_accumulator/CE] [get_bd_pins ip_0_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_0_accumulator/C_IN
connect_bd_net [get_bd_pins ip_0_accumulator/C_IN] [get_bd_pins ip_0_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_0_accumulator/Bypass
connect_bd_net [get_bd_pins ip_0_accumulator/Bypass] [get_bd_pins ip_0_accumulator/accumulator_0/Bypass]


########## fft ##########
create_bd_cell -type hier ip_1_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_1_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 10 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 32 " [get_bd_cells ip_1_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_fft/aclk
connect_bd_net [get_bd_pins ip_1_fft/aclk] [get_bd_pins ip_1_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_1_fft/event_frame_started
connect_bd_net [get_bd_pins ip_1_fft/event_frame_started] [get_bd_pins ip_1_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_fft/S_AXIS_DATA] [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_1_fft/M_AXIS_DATA] [get_bd_intf_pins ip_1_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_1_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_CONFIG]


########## fft ##########
create_bd_cell -type hier ip_2_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_2_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 3 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 65536 " [get_bd_cells ip_2_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_fft/aclk
connect_bd_net [get_bd_pins ip_2_fft/aclk] [get_bd_pins ip_2_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_2_fft/event_frame_started
connect_bd_net [get_bd_pins ip_2_fft/event_frame_started] [get_bd_pins ip_2_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_2_fft/S_AXIS_DATA] [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_2_fft/M_AXIS_DATA] [get_bd_intf_pins ip_2_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_2_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_CONFIG]


########## dft ##########
create_bd_cell -type hier ip_3_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_3_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 15 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_3_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/CLK
connect_bd_net [get_bd_pins ip_3_dft/CLK] [get_bd_pins ip_3_dft/dft_0/CLK]
create_bd_pin -dir I -from 14 -to 0 ip_3_dft/XN_RE
connect_bd_net [get_bd_pins ip_3_dft/XN_RE] [get_bd_pins ip_3_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 14 -to 0 ip_3_dft/XN_IM
connect_bd_net [get_bd_pins ip_3_dft/XN_IM] [get_bd_pins ip_3_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FD_IN
connect_bd_net [get_bd_pins ip_3_dft/FD_IN] [get_bd_pins ip_3_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FWD_INV
connect_bd_net [get_bd_pins ip_3_dft/FWD_INV] [get_bd_pins ip_3_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_3_dft/SIZE
connect_bd_net [get_bd_pins ip_3_dft/SIZE] [get_bd_pins ip_3_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/RFFD
connect_bd_net [get_bd_pins ip_3_dft/RFFD] [get_bd_pins ip_3_dft/dft_0/RFFD]
create_bd_pin -dir O -from 14 -to 0 ip_3_dft/XK_RE
connect_bd_net [get_bd_pins ip_3_dft/XK_RE] [get_bd_pins ip_3_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 14 -to 0 ip_3_dft/XK_IM
connect_bd_net [get_bd_pins ip_3_dft/XK_IM] [get_bd_pins ip_3_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_3_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_3_dft/BLK_EXP] [get_bd_pins ip_3_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/FD_OUT
connect_bd_net [get_bd_pins ip_3_dft/FD_OUT] [get_bd_pins ip_3_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_3_dft/DATA_VALID] [get_bd_pins ip_3_dft/dft_0/DATA_VALID]


########## cordic ##########
create_bd_cell -type hier ip_4_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_4_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Arc_Tanh CONFIG.Input_Width 28 CONFIG.Iterations 8 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 29 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 35 CONFIG.Round_Mode Round_Pos_Inf " [get_bd_cells ip_4_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_cordic/aclk
connect_bd_net [get_bd_pins ip_4_cordic/aclk] [get_bd_pins ip_4_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_4_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_4_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_4_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_4_cordic/cordic_0/M_AXIS_DOUT]


########## axi_dma ##########
create_bd_cell -type hier ip_5_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_5_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 48 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 1 CONFIG.C_SG_LENGTH_WIDTH 20 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_5_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_5_axi_dma/axi_resetn] [get_bd_pins ip_5_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_axi_dma/M_AXIS_CNTRL
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXIS_CNTRL] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_CNTRL]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_5_axi_dma/mm2s_introut] [get_bd_pins ip_5_axi_dma/axi_dma_0/mm2s_introut]


########## axi_iic ##########
create_bd_cell -type hier ip_6_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_6_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x2f CONFIG.C_GPO_WIDTH 3 CONFIG.C_SCL_INERTIAL_DELAY 142 CONFIG.C_SDA_INERTIAL_DELAY 115 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 769.9907026089787 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_6_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_6_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic/IIC] [get_bd_intf_pins ip_6_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_iic/clk
connect_bd_net [get_bd_pins ip_6_axi_iic/clk] [get_bd_pins ip_6_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_iic/reset
connect_bd_net [get_bd_pins ip_6_axi_iic/reset] [get_bd_pins ip_6_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic/AXI] [get_bd_intf_pins ip_6_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_iic/irq
connect_bd_net [get_bd_pins ip_6_axi_iic/irq] [get_bd_pins ip_6_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_7_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_7_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_7_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_7_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite/MII] [get_bd_intf_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_7_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_7_axi_ethernet_lite/clk] [get_bd_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_7_axi_ethernet_lite/reset] [get_bd_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_7_axi_ethernet_lite/irq] [get_bd_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_8_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_8_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 33 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 256 CONFIG.C_S2MM_BURST_SIZE 128 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 11 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_8_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_8_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_8_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_8_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_8_axi_dma/axi_resetn] [get_bd_pins ip_8_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_8_axi_dma/s2mm_introut] [get_bd_pins ip_8_axi_dma/axi_dma_0/s2mm_introut]


########## dft ##########
create_bd_cell -type hier ip_9_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_9_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 10 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_9_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/CLK
connect_bd_net [get_bd_pins ip_9_dft/CLK] [get_bd_pins ip_9_dft/dft_0/CLK]
create_bd_pin -dir I -from 9 -to 0 ip_9_dft/XN_RE
connect_bd_net [get_bd_pins ip_9_dft/XN_RE] [get_bd_pins ip_9_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 9 -to 0 ip_9_dft/XN_IM
connect_bd_net [get_bd_pins ip_9_dft/XN_IM] [get_bd_pins ip_9_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/FD_IN
connect_bd_net [get_bd_pins ip_9_dft/FD_IN] [get_bd_pins ip_9_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/FWD_INV
connect_bd_net [get_bd_pins ip_9_dft/FWD_INV] [get_bd_pins ip_9_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_9_dft/SIZE
connect_bd_net [get_bd_pins ip_9_dft/SIZE] [get_bd_pins ip_9_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_9_dft/RFFD
connect_bd_net [get_bd_pins ip_9_dft/RFFD] [get_bd_pins ip_9_dft/dft_0/RFFD]
create_bd_pin -dir O -from 9 -to 0 ip_9_dft/XK_RE
connect_bd_net [get_bd_pins ip_9_dft/XK_RE] [get_bd_pins ip_9_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 9 -to 0 ip_9_dft/XK_IM
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
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_12_intc/concat_0]
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
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/irq_4
connect_bd_net [get_bd_pins ip_12_intc/irq_4] [get_bd_pins ip_12_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_12_intc/irq_5
connect_bd_net [get_bd_pins ip_12_intc/irq_5] [get_bd_pins ip_12_intc/concat_0/In5]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_12_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_12_intc/irq] [get_bd_intf_pins ip_12_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_13_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_13_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 5 CONFIG.NUM_SI 3 " [get_bd_cells ip_13_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi/clk
connect_bd_net [get_bd_pins ip_13_axi/clk] [get_bd_pins ip_13_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi/reset
connect_bd_net [get_bd_pins ip_13_axi/reset] [get_bd_pins ip_13_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_M0] [get_bd_intf_pins ip_13_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_M1] [get_bd_intf_pins ip_13_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_M2] [get_bd_intf_pins ip_13_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S0] [get_bd_intf_pins ip_13_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S1] [get_bd_intf_pins ip_13_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S2] [get_bd_intf_pins ip_13_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S3] [get_bd_intf_pins ip_13_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S4] [get_bd_intf_pins ip_13_axi/axi_0/M04_AXI]


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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_16_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_16_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_16_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_16_axis_broadcaster/aclk] [get_bd_pins ip_16_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_16_axis_broadcaster/aresetn] [get_bd_pins ip_16_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_17_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_17_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_17_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_17_axis_dwidth_converter/aclk] [get_bd_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_17_axis_dwidth_converter/aresetn] [get_bd_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_18_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_18_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_18_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_18_axis_combiner/aclk] [get_bd_pins ip_18_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_18_axis_combiner/aresetn] [get_bd_pins ip_18_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_18_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_18_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_combiner/M_AXIS] [get_bd_intf_pins ip_18_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_19_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_19_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 44 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aclk] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aresetn] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_20_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_20_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_20_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_20_axis_combiner/aclk] [get_bd_pins ip_20_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_20_axis_combiner/aresetn] [get_bd_pins ip_20_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_combiner/M_AXIS] [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_21_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_21_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_22_slice_and_concat/out0
create_bd_pin -dir I -from 44 -to 0 ip_22_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 45 " [get_bd_cells ip_22_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 3 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 44 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 45 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 44 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 45 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 44 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 45 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 42 -to 0 ip_26_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_26_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 44 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 45 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/slice_0/dout] [get_bd_pins ip_26_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_26_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_1] [get_bd_pins ip_26_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 14 -to 0 ip_26_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_2] [get_bd_pins ip_26_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 14 -to 0 ip_26_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 15 " [get_bd_cells ip_26_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_3] [get_bd_pins ip_26_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/slice_3/dout] [get_bd_pins ip_26_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_27_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_27_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 14 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 13 CONFIG.DIN_WIDTH 15 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/slice_0/dout] [get_bd_pins ip_27_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_27_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_27_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_2] [get_bd_pins ip_27_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_3] [get_bd_pins ip_27_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_4] [get_bd_pins ip_27_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 9 -to 0 ip_27_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_27_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_5] [get_bd_pins ip_27_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/slice_5/dout] [get_bd_pins ip_27_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_28_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_28_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 9 -to 0 ip_28_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_28_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/slice_0/dout] [get_bd_pins ip_28_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 9 -to 0 ip_28_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_28_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_1] [get_bd_pins ip_28_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/slice_1/dout] [get_bd_pins ip_28_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_29_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_29_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 9 -to 0 ip_29_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_29_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/slice_0/dout] [get_bd_pins ip_29_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_29_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_29_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_2] [get_bd_pins ip_29_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_3] [get_bd_pins ip_29_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_31_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_31_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_33_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_11_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_6_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic_IIC] [get_bd_intf_pins ip_6_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_7_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite_MII] [get_bd_intf_pins ip_7_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_7_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_7_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_12_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 3 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_23_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_33_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_35_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_iic/reset]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_0_accumulator/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_1_fft/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_2_fft/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_3_dft/CLK]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_4_cordic/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_6_axi_iic/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_7_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_9_dft/CLK]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_10_reset/clk_in]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_locked] [get_bd_pins ip_10_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_12_intc/irq_0] [get_bd_pins ip_1_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_12_intc/irq_1] [get_bd_pins ip_2_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_12_intc/irq_2] [get_bd_pins ip_5_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_12_intc/irq_3] [get_bd_pins ip_6_axi_iic/irq]
connect_bd_net [get_bd_pins ip_12_intc/irq_4] [get_bd_pins ip_7_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_12_intc/irq_5] [get_bd_pins ip_8_axi_dma/s2mm_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_13_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_13_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_13_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_iic/AXI] [get_bd_intf_pins ip_13_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_13_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_intc/AXI] [get_bd_intf_pins ip_13_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_14_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXIS_CNTRL] [get_bd_intf_pins ip_15_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_16_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_fft/S_AXIS_DATA] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_2_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_1_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_14_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_15_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_fft/S_AXIS_DATA] [get_bd_intf_pins ip_20_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_3_dft/SIZE]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_9_dft/SIZE]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_IM]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_0_accumulator/B]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_1] [get_bd_pins ip_3_dft/RFFD]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_2] [get_bd_pins ip_3_dft/XK_RE]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_3] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_RE]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_1] [get_bd_pins ip_3_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_2] [get_bd_pins ip_3_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_3] [get_bd_pins ip_3_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_4] [get_bd_pins ip_9_dft/RFFD]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_5] [get_bd_pins ip_9_dft/XK_RE]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_9_dft/XN_RE]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_9_dft/XK_RE]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_1] [get_bd_pins ip_9_dft/XK_IM]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_9_dft/XN_IM]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_9_dft/XK_IM]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_9_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_2] [get_bd_pins ip_9_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_3] [get_bd_pins ip_9_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_0_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_3_dft/FD_IN]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_0_accumulator/CE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_3_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_9_dft/FD_IN]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_0_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_9_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_13_axi/reset]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_12_intc/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_13_axi/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_14_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_15_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_16_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_17_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_18_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_20_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_DATA declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_DATA declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/M_AXIS_DATA declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/M_AXIS_DATA declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 25 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_CONFIG declared=25 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_CONFIG declared=25 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_DATA declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_DATA declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_fft/M_AXIS_DATA declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_fft/M_AXIS_DATA declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 35 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_CONFIG declared=35 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_CONFIG declared=35 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_cordic/S_AXIS_CARTESIAN declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_cordic/S_AXIS_CARTESIAN declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_CNTRL]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_CNTRL declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_CNTRL declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
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
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_combiner/S_AXIS_0 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_combiner/S_AXIS_0 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_combiner/M_AXIS declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_combiner/M_AXIS declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/S_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_combiner/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 25 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=25 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=25 actual=ERR $__err" }


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
