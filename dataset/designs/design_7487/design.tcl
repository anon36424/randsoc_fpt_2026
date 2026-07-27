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



########## emc ##########
create_bd_cell -type hier ip_0_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_0_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 3 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 4 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 5 CONFIG.C_TAVDV_PS_MEM_0 13963 CONFIG.C_TAVDV_PS_MEM_1 15053 CONFIG.C_TAVDV_PS_MEM_2 13625 CONFIG.C_TAVDV_PS_MEM_3 16049 CONFIG.C_TCEDV_PS_MEM_0 15317 CONFIG.C_TCEDV_PS_MEM_1 14022 CONFIG.C_TCEDV_PS_MEM_2 14912 CONFIG.C_TCEDV_PS_MEM_3 14948 CONFIG.C_THZCE_PS_MEM_0 7138 CONFIG.C_THZCE_PS_MEM_1 6543 CONFIG.C_THZCE_PS_MEM_2 7699 CONFIG.C_THZCE_PS_MEM_3 7604 CONFIG.C_THZOE_PS_MEM_0 6589 CONFIG.C_THZOE_PS_MEM_1 6755 CONFIG.C_THZOE_PS_MEM_2 6477 CONFIG.C_THZOE_PS_MEM_3 7556 CONFIG.C_TLZWE_PS_MEM_0 9103 CONFIG.C_TLZWE_PS_MEM_1 1576 CONFIG.C_TLZWE_PS_MEM_2 350 CONFIG.C_TLZWE_PS_MEM_3 8827 CONFIG.C_TWC_PS_MEM_0 13810 CONFIG.C_TWC_PS_MEM_1 15074 CONFIG.C_TWC_PS_MEM_2 15819 CONFIG.C_TWC_PS_MEM_3 15470 CONFIG.C_TWPH_PS_MEM_0 12070 CONFIG.C_TWPH_PS_MEM_1 11538 CONFIG.C_TWPH_PS_MEM_2 13174 CONFIG.C_TWPH_PS_MEM_3 13048 CONFIG.C_TWP_PS_MEM_0 12918 CONFIG.C_TWP_PS_MEM_1 11796 CONFIG.C_TWP_PS_MEM_2 11105 CONFIG.C_TWP_PS_MEM_3 11910 CONFIG.C_WR_REC_TIME_MEM_0 28027 CONFIG.C_WR_REC_TIME_MEM_1 27457 CONFIG.C_WR_REC_TIME_MEM_2 27225 CONFIG.C_WR_REC_TIME_MEM_3 25420 " [get_bd_cells ip_0_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc/EMC_INTF] [get_bd_intf_pins ip_0_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/clk
connect_bd_net [get_bd_pins ip_0_emc/clk] [get_bd_pins ip_0_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/rdclk
connect_bd_net [get_bd_pins ip_0_emc/rdclk] [get_bd_pins ip_0_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/rst
connect_bd_net [get_bd_pins ip_0_emc/rst] [get_bd_pins ip_0_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_0_emc/emc_0/S_AXI_MEM]


########## uartlite ##########
create_bd_cell -type hier ip_1_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_1_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 38400 CONFIG.C_DATA_BITS 5 CONFIG.PARITY No_Parity " [get_bd_cells ip_1_uartlite/uart_0]
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


########## xadc_wiz ##########
create_bd_cell -type hier ip_2_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_2_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCA 1 CONFIG.POWER_DOWN_ADCB 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_2_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_2_xadc_wiz/dclk_in] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_2_xadc_wiz/convst_in] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/ot_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/eoc_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/eos_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/busy_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/jtaglocked_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/jtagmodified_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/jtagbusy_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 187 CONFIG.Latency 29 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 244 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 186 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 243 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/ADD
connect_bd_net [get_bd_pins ip_3_accumulator/ADD] [get_bd_pins ip_3_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/CE
connect_bd_net [get_bd_pins ip_3_accumulator/CE] [get_bd_pins ip_3_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/C_IN
connect_bd_net [get_bd_pins ip_3_accumulator/C_IN] [get_bd_pins ip_3_accumulator/accumulator_0/C_IN]


########## cordic ##########
create_bd_cell -type hier ip_4_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_4_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Sinh_and_Cosh CONFIG.Input_Width 30 CONFIG.Iterations 30 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 33 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 46 CONFIG.Round_Mode Truncate " [get_bd_cells ip_4_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_cordic/aclk
connect_bd_net [get_bd_pins ip_4_cordic/aclk] [get_bd_pins ip_4_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_cordic/aclken
connect_bd_net [get_bd_pins ip_4_cordic/aclken] [get_bd_pins ip_4_cordic/cordic_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_4_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_4_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_4_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_4_cordic/cordic_0/M_AXIS_DOUT]


########## axi_iic ##########
create_bd_cell -type hier ip_5_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_5_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x2f CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 52 CONFIG.C_SDA_INERTIAL_DELAY 73 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 174.88835187788766 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic/IIC] [get_bd_intf_pins ip_5_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_iic/clk
connect_bd_net [get_bd_pins ip_5_axi_iic/clk] [get_bd_pins ip_5_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_iic/reset
connect_bd_net [get_bd_pins ip_5_axi_iic/reset] [get_bd_pins ip_5_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_5_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_iic/irq
connect_bd_net [get_bd_pins ip_5_axi_iic/irq] [get_bd_pins ip_5_axi_iic/axi_iic_0/iic2intc_irpt]


########## dft ##########
create_bd_cell -type hier ip_6_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_6_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 8 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_6_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/CLK
connect_bd_net [get_bd_pins ip_6_dft/CLK] [get_bd_pins ip_6_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/CE
connect_bd_net [get_bd_pins ip_6_dft/CE] [get_bd_pins ip_6_dft/dft_0/CE]
create_bd_pin -dir I -from 7 -to 0 ip_6_dft/XN_RE
connect_bd_net [get_bd_pins ip_6_dft/XN_RE] [get_bd_pins ip_6_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 7 -to 0 ip_6_dft/XN_IM
connect_bd_net [get_bd_pins ip_6_dft/XN_IM] [get_bd_pins ip_6_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FD_IN
connect_bd_net [get_bd_pins ip_6_dft/FD_IN] [get_bd_pins ip_6_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FWD_INV
connect_bd_net [get_bd_pins ip_6_dft/FWD_INV] [get_bd_pins ip_6_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_6_dft/SIZE
connect_bd_net [get_bd_pins ip_6_dft/SIZE] [get_bd_pins ip_6_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/RFFD
connect_bd_net [get_bd_pins ip_6_dft/RFFD] [get_bd_pins ip_6_dft/dft_0/RFFD]
create_bd_pin -dir O -from 7 -to 0 ip_6_dft/XK_RE
connect_bd_net [get_bd_pins ip_6_dft/XK_RE] [get_bd_pins ip_6_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 7 -to 0 ip_6_dft/XK_IM
connect_bd_net [get_bd_pins ip_6_dft/XK_IM] [get_bd_pins ip_6_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_6_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_6_dft/BLK_EXP] [get_bd_pins ip_6_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/FD_OUT
connect_bd_net [get_bd_pins ip_6_dft/FD_OUT] [get_bd_pins ip_6_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_6_dft/DATA_VALID] [get_bd_pins ip_6_dft/dft_0/DATA_VALID]


########## axi_iic ##########
create_bd_cell -type hier ip_7_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_7_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x48 CONFIG.C_GPO_WIDTH 7 CONFIG.C_SCL_INERTIAL_DELAY 117 CONFIG.C_SDA_INERTIAL_DELAY 12 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 155.31501633784305 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_7_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic/IIC] [get_bd_intf_pins ip_7_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_iic/clk
connect_bd_net [get_bd_pins ip_7_axi_iic/clk] [get_bd_pins ip_7_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_iic/reset
connect_bd_net [get_bd_pins ip_7_axi_iic/reset] [get_bd_pins ip_7_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_7_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_iic/irq
connect_bd_net [get_bd_pins ip_7_axi_iic/irq] [get_bd_pins ip_7_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_8_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_8_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_8_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_8_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite/MII] [get_bd_intf_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_8_axi_ethernet_lite/clk] [get_bd_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_8_axi_ethernet_lite/reset] [get_bd_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_8_axi_ethernet_lite/irq] [get_bd_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_9_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_9_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 61 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 256 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 16 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 1 CONFIG.C_SG_LENGTH_WIDTH 18 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_9_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_9_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_9_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_9_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_9_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_9_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_9_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_9_axi_dma/axi_resetn] [get_bd_pins ip_9_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axi_dma/M_AXIS_CNTRL
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_dma/M_AXIS_CNTRL] [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXIS_CNTRL]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_9_axi_dma/mm2s_introut] [get_bd_pins ip_9_axi_dma/axi_dma_0/mm2s_introut]


########## axi_timer ##########
create_bd_cell -type hier ip_10_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_10_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 16 CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_10_axi_timer/axi_timer_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_11_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_11_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Double CONFIG.add_sub_value Both CONFIG.b_tuser_width 86 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_divide_by_zero 0 CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 1 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Divide CONFIG.result_tlast_behv AND_all_TLASTs " [get_bd_cells ip_11_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_floating_point/aclk
connect_bd_net [get_bd_pins ip_11_floating_point/aclk] [get_bd_pins ip_11_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_floating_point/aresetn
connect_bd_net [get_bd_pins ip_11_floating_point/aresetn] [get_bd_pins ip_11_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/S_AXIS_A] [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/S_AXIS_B] [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_11_floating_point/floating_point_0/M_AXIS_RESULT]


########## dft ##########
create_bd_cell -type hier ip_12_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_12_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 9 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_12_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/CLK
connect_bd_net [get_bd_pins ip_12_dft/CLK] [get_bd_pins ip_12_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/CE
connect_bd_net [get_bd_pins ip_12_dft/CE] [get_bd_pins ip_12_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/SCLR
connect_bd_net [get_bd_pins ip_12_dft/SCLR] [get_bd_pins ip_12_dft/dft_0/SCLR]
create_bd_pin -dir I -from 8 -to 0 ip_12_dft/XN_RE
connect_bd_net [get_bd_pins ip_12_dft/XN_RE] [get_bd_pins ip_12_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 8 -to 0 ip_12_dft/XN_IM
connect_bd_net [get_bd_pins ip_12_dft/XN_IM] [get_bd_pins ip_12_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/FD_IN
connect_bd_net [get_bd_pins ip_12_dft/FD_IN] [get_bd_pins ip_12_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/FWD_INV
connect_bd_net [get_bd_pins ip_12_dft/FWD_INV] [get_bd_pins ip_12_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_12_dft/SIZE
connect_bd_net [get_bd_pins ip_12_dft/SIZE] [get_bd_pins ip_12_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_12_dft/RFFD
connect_bd_net [get_bd_pins ip_12_dft/RFFD] [get_bd_pins ip_12_dft/dft_0/RFFD]
create_bd_pin -dir O -from 8 -to 0 ip_12_dft/XK_RE
connect_bd_net [get_bd_pins ip_12_dft/XK_RE] [get_bd_pins ip_12_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 8 -to 0 ip_12_dft/XK_IM
connect_bd_net [get_bd_pins ip_12_dft/XK_IM] [get_bd_pins ip_12_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_12_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_12_dft/BLK_EXP] [get_bd_pins ip_12_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_12_dft/FD_OUT
connect_bd_net [get_bd_pins ip_12_dft/FD_OUT] [get_bd_pins ip_12_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_12_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_12_dft/DATA_VALID] [get_bd_pins ip_12_dft/dft_0/DATA_VALID]


########## axi_dma ##########
create_bd_cell -type hier ip_13_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_13_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 50 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_13_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_13_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_13_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_13_axi_dma/axi_resetn] [get_bd_pins ip_13_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_13_axi_dma/s2mm_introut] [get_bd_pins ip_13_axi_dma/axi_dma_0/s2mm_introut]


########## axi_iic ##########
create_bd_cell -type hier ip_14_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_14_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x29 CONFIG.C_GPO_WIDTH 8 CONFIG.C_SCL_INERTIAL_DELAY 253 CONFIG.C_SDA_INERTIAL_DELAY 97 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 214.6010149151811 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_14_axi_iic/axi_iic_0]
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


########## axi_cdma ##########
create_bd_cell -type hier ip_15_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_15_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 52 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 2 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_15_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_15_axi_cdma/m_axi_aclk] [get_bd_pins ip_15_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_15_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_15_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_15_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_15_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_cdma/M_AXI] [get_bd_intf_pins ip_15_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_15_axi_cdma/cdma_introut] [get_bd_pins ip_15_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_cdma ##########
create_bd_cell -type hier ip_16_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_16_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 58 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 256 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_16_axi_cdma/axi_cdma_0]
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


########## cordic ##########
create_bd_cell -type hier ip_17_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_17_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 33 CONFIG.Iterations 46 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 40 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode No_Pipelining CONFIG.Precision 41 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_17_cordic/cordic_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_17_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_17_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_17_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_17_cordic/cordic_0/M_AXIS_DOUT]


########## dft ##########
create_bd_cell -type hier ip_18_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_18_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 15 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_18_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_dft/CLK
connect_bd_net [get_bd_pins ip_18_dft/CLK] [get_bd_pins ip_18_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_18_dft/CE
connect_bd_net [get_bd_pins ip_18_dft/CE] [get_bd_pins ip_18_dft/dft_0/CE]
create_bd_pin -dir I -from 14 -to 0 ip_18_dft/XN_RE
connect_bd_net [get_bd_pins ip_18_dft/XN_RE] [get_bd_pins ip_18_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 14 -to 0 ip_18_dft/XN_IM
connect_bd_net [get_bd_pins ip_18_dft/XN_IM] [get_bd_pins ip_18_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_18_dft/FD_IN
connect_bd_net [get_bd_pins ip_18_dft/FD_IN] [get_bd_pins ip_18_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_18_dft/FWD_INV
connect_bd_net [get_bd_pins ip_18_dft/FWD_INV] [get_bd_pins ip_18_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_18_dft/SIZE
connect_bd_net [get_bd_pins ip_18_dft/SIZE] [get_bd_pins ip_18_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_18_dft/RFFD
connect_bd_net [get_bd_pins ip_18_dft/RFFD] [get_bd_pins ip_18_dft/dft_0/RFFD]
create_bd_pin -dir O -from 14 -to 0 ip_18_dft/XK_RE
connect_bd_net [get_bd_pins ip_18_dft/XK_RE] [get_bd_pins ip_18_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 14 -to 0 ip_18_dft/XK_IM
connect_bd_net [get_bd_pins ip_18_dft/XK_IM] [get_bd_pins ip_18_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_18_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_18_dft/BLK_EXP] [get_bd_pins ip_18_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_18_dft/FD_OUT
connect_bd_net [get_bd_pins ip_18_dft/FD_OUT] [get_bd_pins ip_18_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_18_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_18_dft/DATA_VALID] [get_bd_pins ip_18_dft/dft_0/DATA_VALID]


########## reset ##########
create_bd_cell -type hier ip_19_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_19_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_reset/clk_in
connect_bd_net [get_bd_pins ip_19_reset/clk_in] [get_bd_pins ip_19_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_19_reset/reset_in
connect_bd_net [get_bd_pins ip_19_reset/reset_in] [get_bd_pins ip_19_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_19_reset/dcm_locked
connect_bd_net [get_bd_pins ip_19_reset/dcm_locked] [get_bd_pins ip_19_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_19_reset/mb_reset
connect_bd_net [get_bd_pins ip_19_reset/mb_reset] [get_bd_pins ip_19_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_19_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_19_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_19_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset] [get_bd_pins ip_19_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_19_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_19_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_20_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_20_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_in] [get_bd_pins ip_20_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_20_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_20_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_20_clk_wiz/reset
connect_bd_net [get_bd_pins ip_20_clk_wiz/reset] [get_bd_pins ip_20_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_20_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_locked] [get_bd_pins ip_20_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_21_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_21_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_21_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 10 " [get_bd_cells ip_21_intc/concat_0]
connect_bd_net [get_bd_pins ip_21_intc/concat_0/dout] [get_bd_pins ip_21_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/clk
connect_bd_net [get_bd_pins ip_21_intc/clk] [get_bd_pins ip_21_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/reset
connect_bd_net [get_bd_pins ip_21_intc/reset] [get_bd_pins ip_21_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_21_intc/AXI] [get_bd_intf_pins ip_21_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_0
connect_bd_net [get_bd_pins ip_21_intc/irq_0] [get_bd_pins ip_21_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_1
connect_bd_net [get_bd_pins ip_21_intc/irq_1] [get_bd_pins ip_21_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_2
connect_bd_net [get_bd_pins ip_21_intc/irq_2] [get_bd_pins ip_21_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_3
connect_bd_net [get_bd_pins ip_21_intc/irq_3] [get_bd_pins ip_21_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_4
connect_bd_net [get_bd_pins ip_21_intc/irq_4] [get_bd_pins ip_21_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_5
connect_bd_net [get_bd_pins ip_21_intc/irq_5] [get_bd_pins ip_21_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_6
connect_bd_net [get_bd_pins ip_21_intc/irq_6] [get_bd_pins ip_21_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_7
connect_bd_net [get_bd_pins ip_21_intc/irq_7] [get_bd_pins ip_21_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_8
connect_bd_net [get_bd_pins ip_21_intc/irq_8] [get_bd_pins ip_21_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_21_intc/irq_9
connect_bd_net [get_bd_pins ip_21_intc/irq_9] [get_bd_pins ip_21_intc/concat_0/In9]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_21_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_21_intc/irq] [get_bd_intf_pins ip_21_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_22_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_22_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 12 CONFIG.NUM_SI 5 " [get_bd_cells ip_22_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi/clk
connect_bd_net [get_bd_pins ip_22_axi/clk] [get_bd_pins ip_22_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi/reset
connect_bd_net [get_bd_pins ip_22_axi/reset] [get_bd_pins ip_22_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_M0] [get_bd_intf_pins ip_22_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_M1] [get_bd_intf_pins ip_22_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_M2] [get_bd_intf_pins ip_22_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_M3] [get_bd_intf_pins ip_22_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_M4] [get_bd_intf_pins ip_22_axi/axi_0/S04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S0] [get_bd_intf_pins ip_22_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S1] [get_bd_intf_pins ip_22_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S2] [get_bd_intf_pins ip_22_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S3] [get_bd_intf_pins ip_22_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S4] [get_bd_intf_pins ip_22_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S5] [get_bd_intf_pins ip_22_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S6] [get_bd_intf_pins ip_22_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S7] [get_bd_intf_pins ip_22_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S8] [get_bd_intf_pins ip_22_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S9] [get_bd_intf_pins ip_22_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S10] [get_bd_intf_pins ip_22_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_22_axi/AXI_S11] [get_bd_intf_pins ip_22_axi/axi_0/M11_AXI]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_23_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_23_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aclk] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aresetn] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_24_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_24_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aclk] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aresetn] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_25_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_25_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 5 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_27_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aclk] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_27_axis_dwidth_converter/aresetn] [get_bd_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_28_reduce
create_bd_pin -dir I -from 68 -to 0 ip_28_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_28_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_28_reduce/concat]
connect_bd_net [get_bd_pins ip_28_reduce/out0] [get_bd_pins ip_28_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_0]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_28_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_28_reduce/slice_0/dout] [get_bd_pins ip_28_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_0/Res] [get_bd_pins ip_28_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_1]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_28_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_28_reduce/slice_1/dout] [get_bd_pins ip_28_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_1/Res] [get_bd_pins ip_28_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_2]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_28_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_28_reduce/slice_2/dout] [get_bd_pins ip_28_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_2/Res] [get_bd_pins ip_28_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_3]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_28_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_28_reduce/slice_3/dout] [get_bd_pins ip_28_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_3/Res] [get_bd_pins ip_28_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_4]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 3 " [get_bd_cells ip_28_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_28_reduce/slice_4/dout] [get_bd_pins ip_28_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_4/Res] [get_bd_pins ip_28_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_5]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_28_reduce/slice_5/dout] [get_bd_pins ip_28_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_5/Res] [get_bd_pins ip_28_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 18 CONFIG.DIN_TO 17 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_6]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_28_reduce/slice_6/dout] [get_bd_pins ip_28_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_6/Res] [get_bd_pins ip_28_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 20 CONFIG.DIN_TO 19 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_7]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_28_reduce/slice_7/dout] [get_bd_pins ip_28_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_7/Res] [get_bd_pins ip_28_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 22 CONFIG.DIN_TO 21 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_8]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_28_reduce/slice_8/dout] [get_bd_pins ip_28_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_8/Res] [get_bd_pins ip_28_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 24 CONFIG.DIN_TO 23 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_9]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_28_reduce/slice_9/dout] [get_bd_pins ip_28_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_9/Res] [get_bd_pins ip_28_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 26 CONFIG.DIN_TO 25 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_10]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_28_reduce/slice_10/dout] [get_bd_pins ip_28_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_10/Res] [get_bd_pins ip_28_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 28 CONFIG.DIN_TO 27 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_11]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_28_reduce/slice_11/dout] [get_bd_pins ip_28_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_11/Res] [get_bd_pins ip_28_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 29 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_12]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_28_reduce/slice_12/dout] [get_bd_pins ip_28_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_12/Res] [get_bd_pins ip_28_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_13]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_28_reduce/slice_13/dout] [get_bd_pins ip_28_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_13/Res] [get_bd_pins ip_28_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 34 CONFIG.DIN_TO 33 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_14]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_28_reduce/slice_14/dout] [get_bd_pins ip_28_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_14/Res] [get_bd_pins ip_28_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 36 CONFIG.DIN_TO 35 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_15]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_28_reduce/slice_15/dout] [get_bd_pins ip_28_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_15/Res] [get_bd_pins ip_28_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 38 CONFIG.DIN_TO 37 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_16]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_28_reduce/slice_16/dout] [get_bd_pins ip_28_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_16/Res] [get_bd_pins ip_28_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 40 CONFIG.DIN_TO 39 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_17]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_28_reduce/slice_17/dout] [get_bd_pins ip_28_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_17/Res] [get_bd_pins ip_28_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 42 CONFIG.DIN_TO 41 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_18]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_28_reduce/slice_18/dout] [get_bd_pins ip_28_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_18/Res] [get_bd_pins ip_28_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 43 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_19]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_28_reduce/slice_19/dout] [get_bd_pins ip_28_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_19/Res] [get_bd_pins ip_28_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 46 CONFIG.DIN_TO 45 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_20]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_28_reduce/slice_20/dout] [get_bd_pins ip_28_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_20/Res] [get_bd_pins ip_28_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 48 CONFIG.DIN_TO 47 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_21]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_28_reduce/slice_21/dout] [get_bd_pins ip_28_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_21/Res] [get_bd_pins ip_28_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 50 CONFIG.DIN_TO 49 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_22]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_28_reduce/slice_22/dout] [get_bd_pins ip_28_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_22/Res] [get_bd_pins ip_28_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 52 CONFIG.DIN_TO 51 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_23]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_28_reduce/slice_23/dout] [get_bd_pins ip_28_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_23/Res] [get_bd_pins ip_28_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 54 CONFIG.DIN_TO 53 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_24]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_28_reduce/slice_24/dout] [get_bd_pins ip_28_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_24/Res] [get_bd_pins ip_28_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 56 CONFIG.DIN_TO 55 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_25]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_28_reduce/slice_25/dout] [get_bd_pins ip_28_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_25/Res] [get_bd_pins ip_28_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 58 CONFIG.DIN_TO 57 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_26]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_28_reduce/slice_26/dout] [get_bd_pins ip_28_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_26/Res] [get_bd_pins ip_28_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 60 CONFIG.DIN_TO 59 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_27]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_28_reduce/slice_27/dout] [get_bd_pins ip_28_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_27/Res] [get_bd_pins ip_28_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 62 CONFIG.DIN_TO 61 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_28]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_28_reduce/slice_28/dout] [get_bd_pins ip_28_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_28/Res] [get_bd_pins ip_28_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 64 CONFIG.DIN_TO 63 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_29]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_28_reduce/slice_29/dout] [get_bd_pins ip_28_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_29/Res] [get_bd_pins ip_28_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 66 CONFIG.DIN_TO 65 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_30]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_28_reduce/slice_30/dout] [get_bd_pins ip_28_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_30/Res] [get_bd_pins ip_28_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 68 CONFIG.DIN_TO 67 CONFIG.DIN_WIDTH 69 " [get_bd_cells ip_28_reduce/slice_31]
connect_bd_net [get_bd_pins ip_28_reduce/in0] [get_bd_pins ip_28_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_28_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_28_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_28_reduce/slice_31/dout] [get_bd_pins ip_28_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_28_reduce/reduce_31/Res] [get_bd_pins ip_28_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_29_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_29_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_29_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_2] [get_bd_pins ip_29_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_3] [get_bd_pins ip_29_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_4] [get_bd_pins ip_29_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_5] [get_bd_pins ip_29_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 243 -to 0 ip_29_slice_and_concat/in_6
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 244 " [get_bd_cells ip_29_slice_and_concat/slice_6]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_6] [get_bd_pins ip_29_slice_and_concat/slice_6/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/slice_6/dout] [get_bd_pins ip_29_slice_and_concat/concat/In6]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 243 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 244 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 243 -to 0 ip_31_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 244 " [get_bd_cells ip_31_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 243 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 24 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 244 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_33_slice_and_concat/out0
create_bd_pin -dir I -from 243 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 25 CONFIG.DIN_WIDTH 244 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 186 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 243 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 217 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 244 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 243 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 226 CONFIG.DIN_TO 218 CONFIG.DIN_WIDTH 244 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 243 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 241 CONFIG.DIN_TO 227 CONFIG.DIN_WIDTH 244 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_37_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_37_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 243 -to 0 ip_37_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 243 CONFIG.DIN_TO 242 CONFIG.DIN_WIDTH 244 " [get_bd_cells ip_37_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/slice_0/dout] [get_bd_pins ip_37_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_1] [get_bd_pins ip_37_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 7 -to 0 ip_37_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_37_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_2] [get_bd_pins ip_37_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/slice_2/dout] [get_bd_pins ip_37_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_38_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_38_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 7 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/slice_0/dout] [get_bd_pins ip_38_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 7 -to 0 ip_38_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_1] [get_bd_pins ip_38_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 3 -to 0 ip_38_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_38_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_2] [get_bd_pins ip_38_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/slice_2/dout] [get_bd_pins ip_38_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 68 -to 0 ip_39_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 18 " [get_bd_cells ip_39_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_39_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_39_slice_and_concat/slice_0]
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
create_bd_pin -dir I -from 8 -to 0 ip_39_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_7] [get_bd_pins ip_39_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 8 -to 0 ip_39_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_8] [get_bd_pins ip_39_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 3 -to 0 ip_39_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_9] [get_bd_pins ip_39_slice_and_concat/concat/In9]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_10
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_10] [get_bd_pins ip_39_slice_and_concat/concat/In10]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_11
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_11] [get_bd_pins ip_39_slice_and_concat/concat/In11]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_12
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_12] [get_bd_pins ip_39_slice_and_concat/concat/In12]
create_bd_pin -dir I -from 14 -to 0 ip_39_slice_and_concat/in_13
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_13] [get_bd_pins ip_39_slice_and_concat/concat/In13]
create_bd_pin -dir I -from 14 -to 0 ip_39_slice_and_concat/in_14
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_14] [get_bd_pins ip_39_slice_and_concat/concat/In14]
create_bd_pin -dir I -from 3 -to 0 ip_39_slice_and_concat/in_15
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_15] [get_bd_pins ip_39_slice_and_concat/concat/In15]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_16
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_16] [get_bd_pins ip_39_slice_and_concat/concat/In16]
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_17
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_17] [get_bd_pins ip_39_slice_and_concat/concat/In17]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_40_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_40_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_40_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_40_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_41_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_41_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_41_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_41_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/slice_0/dout]


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


########## slice_and_concat ##########
create_bd_cell -type hier ip_48_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_48_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_48_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_49_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_49_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_49_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_50_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_50_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_51_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_51_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_51_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_52_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_52_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_53_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_53_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_54_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_55_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_56_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_19_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_20_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc_EMC_INTF] [get_bd_intf_pins ip_0_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_1_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite_UART] [get_bd_intf_pins ip_1_uartlite/UART]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic_IIC] [get_bd_intf_pins ip_7_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_8_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite_MII] [get_bd_intf_pins ip_8_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_14_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_iic_IIC] [get_bd_intf_pins ip_14_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_21_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_28_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_41_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_21_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_0_emc/rst]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_1_uartlite/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_iic/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_11_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset] [get_bd_pins ip_12_dft/SCLR]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_iic/reset]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_0_emc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_0_emc/rdclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_1_uartlite/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_2_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_4_cordic/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_6_dft/CLK]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_7_axi_iic/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_8_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_9_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_9_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_9_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_10_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_11_floating_point/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_12_dft/CLK]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_14_axi_iic/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_15_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_15_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_16_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_16_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_18_dft/CLK]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_19_reset/clk_in]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_locked] [get_bd_pins ip_19_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_21_intc/irq_0] [get_bd_pins ip_1_uartlite/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_1] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_2] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_3] [get_bd_pins ip_8_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_4] [get_bd_pins ip_9_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_21_intc/irq_5] [get_bd_pins ip_10_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_21_intc/irq_6] [get_bd_pins ip_13_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_21_intc/irq_7] [get_bd_pins ip_14_axi_iic/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_8] [get_bd_pins ip_15_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_21_intc/irq_9] [get_bd_pins ip_16_axi_cdma/cdma_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_22_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_22_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_22_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_cdma/M_AXI] [get_bd_intf_pins ip_22_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_cdma/M_AXI] [get_bd_intf_pins ip_22_axi/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_22_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_uartlite/AXI] [get_bd_intf_pins ip_22_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_22_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_22_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_22_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_22_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_timer/S_AXI] [get_bd_intf_pins ip_22_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_22_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_iic/AXI] [get_bd_intf_pins ip_22_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_22_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_22_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_intc/AXI] [get_bd_intf_pins ip_22_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_9_axi_dma/M_AXIS_CNTRL]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_floating_point/S_AXIS_A] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_9_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_floating_point/S_AXIS_B] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_RE]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_2_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_2] [get_bd_pins ip_2_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_3] [get_bd_pins ip_2_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_4] [get_bd_pins ip_2_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_5] [get_bd_pins ip_2_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_6] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_IM]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_6_dft/SIZE]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_12_dft/XN_IM]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_18_dft/SIZE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_12_dft/XN_RE]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_18_dft/XN_IM]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_12_dft/SIZE]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_1] [get_bd_pins ip_6_dft/RFFD]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_2] [get_bd_pins ip_6_dft/XK_RE]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_18_dft/XN_RE]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_6_dft/XK_RE]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_1] [get_bd_pins ip_6_dft/XK_IM]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_2] [get_bd_pins ip_6_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_28_reduce/in0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_6_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_1] [get_bd_pins ip_6_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_2] [get_bd_pins ip_6_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_3] [get_bd_pins ip_10_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_4] [get_bd_pins ip_10_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_5] [get_bd_pins ip_10_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_6] [get_bd_pins ip_12_dft/RFFD]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_7] [get_bd_pins ip_12_dft/XK_RE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_8] [get_bd_pins ip_12_dft/XK_IM]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_9] [get_bd_pins ip_12_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_10] [get_bd_pins ip_12_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_11] [get_bd_pins ip_12_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_12] [get_bd_pins ip_18_dft/RFFD]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_13] [get_bd_pins ip_18_dft/XK_RE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_14] [get_bd_pins ip_18_dft/XK_IM]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_15] [get_bd_pins ip_18_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_16] [get_bd_pins ip_18_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_17] [get_bd_pins ip_18_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_18_dft/FD_IN]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_4_cordic/aclken]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_12_dft/CE]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_18_dft/CE]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_6_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_12_dft/FD_IN]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/ADD]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_12_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_6_dft/CE]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_18_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_2_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_6_dft/FD_IN]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/CE]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_22_axi/reset]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_21_intc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_22_axi/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_cordic/S_AXIS_PHASE declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_cordic/S_AXIS_PHASE declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_cordic/M_AXIS_DOUT declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_cordic/M_AXIS_DOUT declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axi_dma/M_AXIS_MM2S declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axi_dma/M_AXIS_MM2S declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axi_dma/axi_dma_0/M_AXIS_CNTRL]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axi_dma/M_AXIS_CNTRL declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axi_dma/M_AXIS_CNTRL declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_cordic/S_AXIS_PHASE declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_cordic/S_AXIS_PHASE declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_cordic/M_AXIS_DOUT declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_cordic/M_AXIS_DOUT declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }


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
