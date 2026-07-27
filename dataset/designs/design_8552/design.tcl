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



########## axi_iic ##########
create_bd_cell -type hier ip_0_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_0_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x5 CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 236 CONFIG.C_SDA_INERTIAL_DELAY 160 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 126.33931766470482 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_0_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic/IIC] [get_bd_intf_pins ip_0_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_iic/clk
connect_bd_net [get_bd_pins ip_0_axi_iic/clk] [get_bd_pins ip_0_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_iic/reset
connect_bd_net [get_bd_pins ip_0_axi_iic/reset] [get_bd_pins ip_0_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_0_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_iic/irq
connect_bd_net [get_bd_pins ip_0_axi_iic/irq] [get_bd_pins ip_0_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_1_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_1_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 1 CONFIG.C_SPI_MEMORY 1 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_1_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_1_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi/IIC] [get_bd_intf_pins ip_1_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_1_axi_quad_spi/STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi/STARTUP_IO_S] [get_bd_intf_pins ip_1_axi_quad_spi/axi_quad_spi_0/STARTUP_IO_S]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/clk] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/reset] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_1_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_1_axi_quad_spi/irq] [get_bd_pins ip_1_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## accumulator ##########
create_bd_cell -type hier ip_2_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_2_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 9aa9305283b1ac03cbf0fdd04057788a70bb4 CONFIG.Accum_Mode Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 146 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 152 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_2_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/clk
connect_bd_net [get_bd_pins ip_2_accumulator/clk] [get_bd_pins ip_2_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 145 -to 0 ip_2_accumulator/B
connect_bd_net [get_bd_pins ip_2_accumulator/B] [get_bd_pins ip_2_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 151 -to 0 ip_2_accumulator/Q
connect_bd_net [get_bd_pins ip_2_accumulator/Q] [get_bd_pins ip_2_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/C_IN
connect_bd_net [get_bd_pins ip_2_accumulator/C_IN] [get_bd_pins ip_2_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/Bypass
connect_bd_net [get_bd_pins ip_2_accumulator/Bypass] [get_bd_pins ip_2_accumulator/accumulator_0/Bypass]


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 3ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 231 CONFIG.Latency 16 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 250 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 230 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 249 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/ADD
connect_bd_net [get_bd_pins ip_3_accumulator/ADD] [get_bd_pins ip_3_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/CE
connect_bd_net [get_bd_pins ip_3_accumulator/CE] [get_bd_pins ip_3_accumulator/accumulator_0/CE]


########## emc ##########
create_bd_cell -type hier ip_4_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_4_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 0 CONFIG.C_MEM0_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 1 CONFIG.C_SYNCH_PIPEDELAY_0 1 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 15 " [get_bd_cells ip_4_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_4_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_4_emc/EMC_INTF] [get_bd_intf_pins ip_4_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_4_emc/clk
connect_bd_net [get_bd_pins ip_4_emc/clk] [get_bd_pins ip_4_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_emc/rdclk
connect_bd_net [get_bd_pins ip_4_emc/rdclk] [get_bd_pins ip_4_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_emc/rst
connect_bd_net [get_bd_pins ip_4_emc/rst] [get_bd_pins ip_4_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_emc/AXI] [get_bd_intf_pins ip_4_emc/emc_0/S_AXI_MEM]


########## xadc_wiz ##########
create_bd_cell -type hier ip_5_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_5_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_DCLK 1 CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_5_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_5_xadc_wiz/dclk_in] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_5_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_5_xadc_wiz/reset_in] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/eoc_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/eos_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/alarm_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_5_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_5_xadc_wiz/busy_out] [get_bd_pins ip_5_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_5_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_5_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_5_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## dft ##########
create_bd_cell -type hier ip_6_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_6_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 17 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_6_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/CLK
connect_bd_net [get_bd_pins ip_6_dft/CLK] [get_bd_pins ip_6_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/CE
connect_bd_net [get_bd_pins ip_6_dft/CE] [get_bd_pins ip_6_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/SCLR
connect_bd_net [get_bd_pins ip_6_dft/SCLR] [get_bd_pins ip_6_dft/dft_0/SCLR]
create_bd_pin -dir I -from 16 -to 0 ip_6_dft/XN_RE
connect_bd_net [get_bd_pins ip_6_dft/XN_RE] [get_bd_pins ip_6_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 16 -to 0 ip_6_dft/XN_IM
connect_bd_net [get_bd_pins ip_6_dft/XN_IM] [get_bd_pins ip_6_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FD_IN
connect_bd_net [get_bd_pins ip_6_dft/FD_IN] [get_bd_pins ip_6_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FWD_INV
connect_bd_net [get_bd_pins ip_6_dft/FWD_INV] [get_bd_pins ip_6_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_6_dft/SIZE
connect_bd_net [get_bd_pins ip_6_dft/SIZE] [get_bd_pins ip_6_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/RFFD
connect_bd_net [get_bd_pins ip_6_dft/RFFD] [get_bd_pins ip_6_dft/dft_0/RFFD]
create_bd_pin -dir O -from 16 -to 0 ip_6_dft/XK_RE
connect_bd_net [get_bd_pins ip_6_dft/XK_RE] [get_bd_pins ip_6_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 16 -to 0 ip_6_dft/XK_IM
connect_bd_net [get_bd_pins ip_6_dft/XK_IM] [get_bd_pins ip_6_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_6_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_6_dft/BLK_EXP] [get_bd_pins ip_6_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/FD_OUT
connect_bd_net [get_bd_pins ip_6_dft/FD_OUT] [get_bd_pins ip_6_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_6_dft/DATA_VALID] [get_bd_pins ip_6_dft/dft_0/DATA_VALID]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_7_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_7_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_7_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_7_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite/MII] [get_bd_intf_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_7_axi_ethernet_lite/clk] [get_bd_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_7_axi_ethernet_lite/reset] [get_bd_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_7_axi_ethernet_lite/irq] [get_bd_pins ip_7_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_8_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_8_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 53 CONFIG.aresetn 1 CONFIG.bportwidth 44 CONFIG.btuserwidth 41 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Performance CONFIG.outputwidth 90 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_8_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_8_complex_multiplier/aclk] [get_bd_pins ip_8_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_8_complex_multiplier/aresetn] [get_bd_pins ip_8_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_8_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_9_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_9_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 32 CONFIG.C_MEM3_TYPE 2 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 14 CONFIG.C_TAVDV_PS_MEM_0 16003 CONFIG.C_TAVDV_PS_MEM_1 14920 CONFIG.C_TAVDV_PS_MEM_2 14305 CONFIG.C_TAVDV_PS_MEM_3 15415 CONFIG.C_TCEDV_PS_MEM_0 13799 CONFIG.C_TCEDV_PS_MEM_1 13561 CONFIG.C_TCEDV_PS_MEM_2 13892 CONFIG.C_TCEDV_PS_MEM_3 13634 CONFIG.C_THZCE_PS_MEM_0 7423 CONFIG.C_THZCE_PS_MEM_1 6438 CONFIG.C_THZCE_PS_MEM_2 6355 CONFIG.C_THZCE_PS_MEM_3 6770 CONFIG.C_THZOE_PS_MEM_0 6519 CONFIG.C_THZOE_PS_MEM_1 6729 CONFIG.C_THZOE_PS_MEM_2 6365 CONFIG.C_THZOE_PS_MEM_3 7158 CONFIG.C_TLZWE_PS_MEM_0 4597 CONFIG.C_TLZWE_PS_MEM_1 4603 CONFIG.C_TLZWE_PS_MEM_2 2893 CONFIG.C_TLZWE_PS_MEM_3 2070 CONFIG.C_TWC_PS_MEM_0 13838 CONFIG.C_TWC_PS_MEM_1 16180 CONFIG.C_TWC_PS_MEM_2 14111 CONFIG.C_TWC_PS_MEM_3 14969 CONFIG.C_TWPH_PS_MEM_0 11055 CONFIG.C_TWPH_PS_MEM_1 11406 CONFIG.C_TWPH_PS_MEM_2 12534 CONFIG.C_TWPH_PS_MEM_3 11911 CONFIG.C_TWP_PS_MEM_0 12489 CONFIG.C_TWP_PS_MEM_1 10973 CONFIG.C_TWP_PS_MEM_2 11040 CONFIG.C_TWP_PS_MEM_3 11227 CONFIG.C_WR_REC_TIME_MEM_0 29070 CONFIG.C_WR_REC_TIME_MEM_1 29003 CONFIG.C_WR_REC_TIME_MEM_2 25710 CONFIG.C_WR_REC_TIME_MEM_3 25188 " [get_bd_cells ip_9_emc/emc_0]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_10_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_10_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SPI_MEMORY 3 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_10_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_10_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_quad_spi/IIC] [get_bd_intf_pins ip_10_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_10_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_10_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_10_axi_quad_spi/clk] [get_bd_pins ip_10_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_10_axi_quad_spi/reset] [get_bd_pins ip_10_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_10_axi_quad_spi/clk4] [get_bd_pins ip_10_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_10_axi_quad_spi/reset4] [get_bd_pins ip_10_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_10_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_10_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_10_axi_quad_spi/irq] [get_bd_pins ip_10_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## accumulator ##########
create_bd_cell -type hier ip_11_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_11_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 247 CONFIG.Latency 15 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 252 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_11_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_accumulator/clk
connect_bd_net [get_bd_pins ip_11_accumulator/clk] [get_bd_pins ip_11_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 246 -to 0 ip_11_accumulator/B
connect_bd_net [get_bd_pins ip_11_accumulator/B] [get_bd_pins ip_11_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 251 -to 0 ip_11_accumulator/Q
connect_bd_net [get_bd_pins ip_11_accumulator/Q] [get_bd_pins ip_11_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_11_accumulator/SCLR
connect_bd_net [get_bd_pins ip_11_accumulator/SCLR] [get_bd_pins ip_11_accumulator/accumulator_0/SCLR]


########## axi_dma ##########
create_bd_cell -type hier ip_12_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_12_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 52 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 128 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 1 CONFIG.C_SG_LENGTH_WIDTH 24 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_12_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_12_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_12_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_12_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_12_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_12_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_12_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_12_axi_dma/axi_resetn] [get_bd_pins ip_12_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axi_dma/M_AXIS_CNTRL
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_dma/M_AXIS_CNTRL] [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/M_AXIS_CNTRL]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_12_axi_dma/mm2s_introut] [get_bd_pins ip_12_axi_dma/axi_dma_0/mm2s_introut]


########## emc ##########
create_bd_cell -type hier ip_13_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_13_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 3 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 8 CONFIG.C_TAVDV_PS_MEM_0 16175 CONFIG.C_TAVDV_PS_MEM_1 14764 CONFIG.C_TAVDV_PS_MEM_2 14763 CONFIG.C_TCEDV_PS_MEM_0 16435 CONFIG.C_TCEDV_PS_MEM_1 16472 CONFIG.C_TCEDV_PS_MEM_2 14876 CONFIG.C_THZCE_PS_MEM_0 6376 CONFIG.C_THZCE_PS_MEM_1 7582 CONFIG.C_THZCE_PS_MEM_2 7349 CONFIG.C_THZOE_PS_MEM_0 7534 CONFIG.C_THZOE_PS_MEM_1 6373 CONFIG.C_THZOE_PS_MEM_2 7013 CONFIG.C_TLZWE_PS_MEM_0 7413 CONFIG.C_TLZWE_PS_MEM_1 9409 CONFIG.C_TLZWE_PS_MEM_2 5632 CONFIG.C_TWC_PS_MEM_0 15859 CONFIG.C_TWC_PS_MEM_1 13650 CONFIG.C_TWC_PS_MEM_2 13920 CONFIG.C_TWPH_PS_MEM_0 11372 CONFIG.C_TWPH_PS_MEM_1 12863 CONFIG.C_TWPH_PS_MEM_2 10979 CONFIG.C_TWP_PS_MEM_0 12411 CONFIG.C_TWP_PS_MEM_1 12307 CONFIG.C_TWP_PS_MEM_2 12371 CONFIG.C_WR_REC_TIME_MEM_0 27169 CONFIG.C_WR_REC_TIME_MEM_1 27760 CONFIG.C_WR_REC_TIME_MEM_2 29628 " [get_bd_cells ip_13_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_13_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_13_emc/EMC_INTF] [get_bd_intf_pins ip_13_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/clk
connect_bd_net [get_bd_pins ip_13_emc/clk] [get_bd_pins ip_13_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/rdclk
connect_bd_net [get_bd_pins ip_13_emc/rdclk] [get_bd_pins ip_13_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/rst
connect_bd_net [get_bd_pins ip_13_emc/rst] [get_bd_pins ip_13_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_emc/AXI] [get_bd_intf_pins ip_13_emc/emc_0/S_AXI_MEM]


########## emc ##########
create_bd_cell -type hier ip_14_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_14_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 8 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 8 CONFIG.C_TAVDV_PS_MEM_0 15771 CONFIG.C_TAVDV_PS_MEM_1 14789 CONFIG.C_TCEDV_PS_MEM_0 13573 CONFIG.C_TCEDV_PS_MEM_1 14582 CONFIG.C_THZCE_PS_MEM_0 6742 CONFIG.C_THZCE_PS_MEM_1 7587 CONFIG.C_THZOE_PS_MEM_0 7538 CONFIG.C_THZOE_PS_MEM_1 6320 CONFIG.C_TLZWE_PS_MEM_0 4048 CONFIG.C_TLZWE_PS_MEM_1 3492 CONFIG.C_TWC_PS_MEM_0 14868 CONFIG.C_TWC_PS_MEM_1 15322 CONFIG.C_TWPH_PS_MEM_0 11654 CONFIG.C_TWPH_PS_MEM_1 11135 CONFIG.C_TWP_PS_MEM_0 13058 CONFIG.C_TWP_PS_MEM_1 12796 CONFIG.C_WR_REC_TIME_MEM_0 24613 CONFIG.C_WR_REC_TIME_MEM_1 25428 " [get_bd_cells ip_14_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_14_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_14_emc/EMC_INTF] [get_bd_intf_pins ip_14_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_14_emc/clk
connect_bd_net [get_bd_pins ip_14_emc/clk] [get_bd_pins ip_14_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_emc/rdclk
connect_bd_net [get_bd_pins ip_14_emc/rdclk] [get_bd_pins ip_14_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_emc/rst
connect_bd_net [get_bd_pins ip_14_emc/rst] [get_bd_pins ip_14_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_emc/AXI] [get_bd_intf_pins ip_14_emc/emc_0/S_AXI_MEM]


########## dft ##########
create_bd_cell -type hier ip_15_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_15_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 14 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_15_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_dft/CLK
connect_bd_net [get_bd_pins ip_15_dft/CLK] [get_bd_pins ip_15_dft/dft_0/CLK]
create_bd_pin -dir I -from 13 -to 0 ip_15_dft/XN_RE
connect_bd_net [get_bd_pins ip_15_dft/XN_RE] [get_bd_pins ip_15_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 13 -to 0 ip_15_dft/XN_IM
connect_bd_net [get_bd_pins ip_15_dft/XN_IM] [get_bd_pins ip_15_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_15_dft/FD_IN
connect_bd_net [get_bd_pins ip_15_dft/FD_IN] [get_bd_pins ip_15_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_15_dft/FWD_INV
connect_bd_net [get_bd_pins ip_15_dft/FWD_INV] [get_bd_pins ip_15_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_15_dft/SIZE
connect_bd_net [get_bd_pins ip_15_dft/SIZE] [get_bd_pins ip_15_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_15_dft/RFFD
connect_bd_net [get_bd_pins ip_15_dft/RFFD] [get_bd_pins ip_15_dft/dft_0/RFFD]
create_bd_pin -dir O -from 13 -to 0 ip_15_dft/XK_RE
connect_bd_net [get_bd_pins ip_15_dft/XK_RE] [get_bd_pins ip_15_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 13 -to 0 ip_15_dft/XK_IM
connect_bd_net [get_bd_pins ip_15_dft/XK_IM] [get_bd_pins ip_15_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_15_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_15_dft/BLK_EXP] [get_bd_pins ip_15_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_15_dft/FD_OUT
connect_bd_net [get_bd_pins ip_15_dft/FD_OUT] [get_bd_pins ip_15_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_15_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_15_dft/DATA_VALID] [get_bd_pins ip_15_dft/dft_0/DATA_VALID]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_16_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_16_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_16_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_16_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_ethernet_lite/MII] [get_bd_intf_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_16_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_16_axi_ethernet_lite/clk] [get_bd_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_16_axi_ethernet_lite/reset] [get_bd_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_16_axi_ethernet_lite/irq] [get_bd_pins ip_16_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_17_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_17_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 2 CONFIG.C_TAVDV_PS_MEM_0 15701 CONFIG.C_TCEDV_PS_MEM_0 15467 CONFIG.C_THZCE_PS_MEM_0 6447 CONFIG.C_THZOE_PS_MEM_0 6633 CONFIG.C_TLZWE_PS_MEM_0 8741 CONFIG.C_TWC_PS_MEM_0 14318 CONFIG.C_TWPH_PS_MEM_0 11304 CONFIG.C_TWP_PS_MEM_0 11556 CONFIG.C_WR_REC_TIME_MEM_0 26298 " [get_bd_cells ip_17_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_17_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_17_emc/EMC_INTF] [get_bd_intf_pins ip_17_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_17_emc/clk
connect_bd_net [get_bd_pins ip_17_emc/clk] [get_bd_pins ip_17_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_emc/rdclk
connect_bd_net [get_bd_pins ip_17_emc/rdclk] [get_bd_pins ip_17_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_emc/rst
connect_bd_net [get_bd_pins ip_17_emc/rst] [get_bd_pins ip_17_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_emc/AXI] [get_bd_intf_pins ip_17_emc/emc_0/S_AXI_MEM]


########## axi_dma ##########
create_bd_cell -type hier ip_18_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_18_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 40 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 128 CONFIG.C_NUM_S2MM_CHANNELS 12 CONFIG.C_S2MM_BURST_SIZE 256 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 9 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 128 " [get_bd_cells ip_18_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_18_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_18_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_18_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_18_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_18_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_18_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_18_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_18_axi_dma/axi_resetn] [get_bd_pins ip_18_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_18_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_18_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_18_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_18_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_18_axi_dma/s2mm_introut] [get_bd_pins ip_18_axi_dma/axi_dma_0/s2mm_introut]


########## conv_encoder ##########
create_bd_cell -type hier ip_19_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_19_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 3 CONFIG.convolution_code0 3 CONFIG.convolution_code1 6 CONFIG.convolution_code2 3 CONFIG.convolution_code3 4 CONFIG.convolution_code4 2 CONFIG.convolution_code5 0 CONFIG.convolution_code6 1 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 6 CONFIG.output_rate 7 CONFIG.puncture_code0 101100 CONFIG.puncture_code1 111001 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_19_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_19_conv_encoder/aclk] [get_bd_pins ip_19_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_19_conv_encoder/aresetn] [get_bd_pins ip_19_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_19_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_19_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_20_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_20_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_20_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_20_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_ethernet_lite/MII] [get_bd_intf_pins ip_20_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_20_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_20_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_20_axi_ethernet_lite/clk] [get_bd_pins ip_20_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_20_axi_ethernet_lite/reset] [get_bd_pins ip_20_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_20_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_20_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_20_axi_ethernet_lite/irq] [get_bd_pins ip_20_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## accumulator ##########
create_bd_cell -type hier ip_21_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_21_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 0 CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 17 CONFIG.Latency 13 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 214 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_21_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/clk
connect_bd_net [get_bd_pins ip_21_accumulator/clk] [get_bd_pins ip_21_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 16 -to 0 ip_21_accumulator/B
connect_bd_net [get_bd_pins ip_21_accumulator/B] [get_bd_pins ip_21_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 213 -to 0 ip_21_accumulator/Q
connect_bd_net [get_bd_pins ip_21_accumulator/Q] [get_bd_pins ip_21_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/ADD
connect_bd_net [get_bd_pins ip_21_accumulator/ADD] [get_bd_pins ip_21_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/CE
connect_bd_net [get_bd_pins ip_21_accumulator/CE] [get_bd_pins ip_21_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/C_IN
connect_bd_net [get_bd_pins ip_21_accumulator/C_IN] [get_bd_pins ip_21_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/Bypass
connect_bd_net [get_bd_pins ip_21_accumulator/Bypass] [get_bd_pins ip_21_accumulator/accumulator_0/Bypass]


########## reset ##########
create_bd_cell -type hier ip_22_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_22_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_reset/clk_in
connect_bd_net [get_bd_pins ip_22_reset/clk_in] [get_bd_pins ip_22_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_22_reset/reset_in
connect_bd_net [get_bd_pins ip_22_reset/reset_in] [get_bd_pins ip_22_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_22_reset/dcm_locked
connect_bd_net [get_bd_pins ip_22_reset/dcm_locked] [get_bd_pins ip_22_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_22_reset/mb_reset
connect_bd_net [get_bd_pins ip_22_reset/mb_reset] [get_bd_pins ip_22_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_22_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_22_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_22_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset] [get_bd_pins ip_22_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_22_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_22_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_23_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_23_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_in] [get_bd_pins ip_23_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_23_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_23_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_23_clk_wiz/reset
connect_bd_net [get_bd_pins ip_23_clk_wiz/reset] [get_bd_pins ip_23_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_23_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_locked] [get_bd_pins ip_23_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_24_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_24_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_24_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_24_intc/concat_0]
connect_bd_net [get_bd_pins ip_24_intc/concat_0/dout] [get_bd_pins ip_24_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/clk
connect_bd_net [get_bd_pins ip_24_intc/clk] [get_bd_pins ip_24_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/reset
connect_bd_net [get_bd_pins ip_24_intc/reset] [get_bd_pins ip_24_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_24_intc/AXI] [get_bd_intf_pins ip_24_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_0
connect_bd_net [get_bd_pins ip_24_intc/irq_0] [get_bd_pins ip_24_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_1
connect_bd_net [get_bd_pins ip_24_intc/irq_1] [get_bd_pins ip_24_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_2
connect_bd_net [get_bd_pins ip_24_intc/irq_2] [get_bd_pins ip_24_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_3
connect_bd_net [get_bd_pins ip_24_intc/irq_3] [get_bd_pins ip_24_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_4
connect_bd_net [get_bd_pins ip_24_intc/irq_4] [get_bd_pins ip_24_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_5
connect_bd_net [get_bd_pins ip_24_intc/irq_5] [get_bd_pins ip_24_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_6
connect_bd_net [get_bd_pins ip_24_intc/irq_6] [get_bd_pins ip_24_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_24_intc/irq_7
connect_bd_net [get_bd_pins ip_24_intc/irq_7] [get_bd_pins ip_24_intc/concat_0/In7]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_24_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_24_intc/irq] [get_bd_intf_pins ip_24_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_25_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_25_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 15 CONFIG.NUM_SI 4 " [get_bd_cells ip_25_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_legacy/clk
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_legacy/reset
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_M0] [get_bd_intf_pins ip_25_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_M1] [get_bd_intf_pins ip_25_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_M2] [get_bd_intf_pins ip_25_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_M3] [get_bd_intf_pins ip_25_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S0] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S1] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S2] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S3] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S4] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S5] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S6] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S7] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S8] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S9] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S10] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S11] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S12] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M12_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S13] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M13_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M13_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M13_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_legacy/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_legacy/AXI_S14] [get_bd_intf_pins ip_25_axi_legacy/axi_0/M14_AXI]
connect_bd_net [get_bd_pins ip_25_axi_legacy/clk] [get_bd_pins ip_25_axi_legacy/axi_0/M14_ACLK]
connect_bd_net [get_bd_pins ip_25_axi_legacy/reset] [get_bd_pins ip_25_axi_legacy/axi_0/M14_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_26_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_26_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_26_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_26_axis_broadcaster/aclk] [get_bd_pins ip_26_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_26_axis_broadcaster/aresetn] [get_bd_pins ip_26_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_27_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_27_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_27_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_28_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aclk] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aresetn] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_29_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_29_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_29_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_29_axis_combiner/aclk] [get_bd_pins ip_29_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_29_axis_combiner/aresetn] [get_bd_pins ip_29_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_combiner/M_AXIS] [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_30_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_30_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 25 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_31_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aclk] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aresetn] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_33_reduce
create_bd_pin -dir I -from 231 -to 0 ip_33_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_33_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_33_reduce/concat]
connect_bd_net [get_bd_pins ip_33_reduce/out0] [get_bd_pins ip_33_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_0]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_33_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_33_reduce/slice_0/dout] [get_bd_pins ip_33_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_0/Res] [get_bd_pins ip_33_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_1]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_33_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_33_reduce/slice_1/dout] [get_bd_pins ip_33_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_1/Res] [get_bd_pins ip_33_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_2]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_33_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_33_reduce/slice_2/dout] [get_bd_pins ip_33_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_2/Res] [get_bd_pins ip_33_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_3]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_33_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_33_reduce/slice_3/dout] [get_bd_pins ip_33_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_3/Res] [get_bd_pins ip_33_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 39 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_4]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_33_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_33_reduce/slice_4/dout] [get_bd_pins ip_33_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_4/Res] [get_bd_pins ip_33_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 40 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_5]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_33_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_33_reduce/slice_5/dout] [get_bd_pins ip_33_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_5/Res] [get_bd_pins ip_33_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 55 CONFIG.DIN_TO 48 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_6]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_33_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_33_reduce/slice_6/dout] [get_bd_pins ip_33_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_6/Res] [get_bd_pins ip_33_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 63 CONFIG.DIN_TO 56 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_7]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_33_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_33_reduce/slice_7/dout] [get_bd_pins ip_33_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_7/Res] [get_bd_pins ip_33_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 70 CONFIG.DIN_TO 64 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_8]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_33_reduce/slice_8/dout] [get_bd_pins ip_33_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_8/Res] [get_bd_pins ip_33_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 77 CONFIG.DIN_TO 71 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_9]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_33_reduce/slice_9/dout] [get_bd_pins ip_33_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_9/Res] [get_bd_pins ip_33_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 84 CONFIG.DIN_TO 78 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_10]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_33_reduce/slice_10/dout] [get_bd_pins ip_33_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_10/Res] [get_bd_pins ip_33_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 91 CONFIG.DIN_TO 85 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_11]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_33_reduce/slice_11/dout] [get_bd_pins ip_33_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_11/Res] [get_bd_pins ip_33_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 98 CONFIG.DIN_TO 92 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_12]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_33_reduce/slice_12/dout] [get_bd_pins ip_33_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_12/Res] [get_bd_pins ip_33_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 105 CONFIG.DIN_TO 99 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_13]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_33_reduce/slice_13/dout] [get_bd_pins ip_33_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_13/Res] [get_bd_pins ip_33_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 112 CONFIG.DIN_TO 106 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_14]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_33_reduce/slice_14/dout] [get_bd_pins ip_33_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_14/Res] [get_bd_pins ip_33_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 119 CONFIG.DIN_TO 113 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_15]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_33_reduce/slice_15/dout] [get_bd_pins ip_33_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_15/Res] [get_bd_pins ip_33_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 126 CONFIG.DIN_TO 120 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_16]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_33_reduce/slice_16/dout] [get_bd_pins ip_33_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_16/Res] [get_bd_pins ip_33_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 133 CONFIG.DIN_TO 127 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_17]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_33_reduce/slice_17/dout] [get_bd_pins ip_33_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_17/Res] [get_bd_pins ip_33_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 140 CONFIG.DIN_TO 134 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_18]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_33_reduce/slice_18/dout] [get_bd_pins ip_33_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_18/Res] [get_bd_pins ip_33_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 147 CONFIG.DIN_TO 141 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_19]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_33_reduce/slice_19/dout] [get_bd_pins ip_33_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_19/Res] [get_bd_pins ip_33_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 154 CONFIG.DIN_TO 148 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_20]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_33_reduce/slice_20/dout] [get_bd_pins ip_33_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_20/Res] [get_bd_pins ip_33_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 161 CONFIG.DIN_TO 155 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_21]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_33_reduce/slice_21/dout] [get_bd_pins ip_33_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_21/Res] [get_bd_pins ip_33_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 168 CONFIG.DIN_TO 162 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_22]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_33_reduce/slice_22/dout] [get_bd_pins ip_33_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_22/Res] [get_bd_pins ip_33_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 175 CONFIG.DIN_TO 169 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_23]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_33_reduce/slice_23/dout] [get_bd_pins ip_33_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_23/Res] [get_bd_pins ip_33_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 182 CONFIG.DIN_TO 176 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_24]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_33_reduce/slice_24/dout] [get_bd_pins ip_33_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_24/Res] [get_bd_pins ip_33_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 189 CONFIG.DIN_TO 183 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_25]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_33_reduce/slice_25/dout] [get_bd_pins ip_33_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_25/Res] [get_bd_pins ip_33_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 196 CONFIG.DIN_TO 190 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_26]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_33_reduce/slice_26/dout] [get_bd_pins ip_33_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_26/Res] [get_bd_pins ip_33_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 203 CONFIG.DIN_TO 197 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_27]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_33_reduce/slice_27/dout] [get_bd_pins ip_33_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_27/Res] [get_bd_pins ip_33_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 210 CONFIG.DIN_TO 204 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_28]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_33_reduce/slice_28/dout] [get_bd_pins ip_33_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_28/Res] [get_bd_pins ip_33_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 217 CONFIG.DIN_TO 211 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_29]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_33_reduce/slice_29/dout] [get_bd_pins ip_33_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_29/Res] [get_bd_pins ip_33_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 224 CONFIG.DIN_TO 218 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_30]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_33_reduce/slice_30/dout] [get_bd_pins ip_33_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_30/Res] [get_bd_pins ip_33_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 231 CONFIG.DIN_TO 225 CONFIG.DIN_WIDTH 232 " [get_bd_cells ip_33_reduce/slice_31]
connect_bd_net [get_bd_pins ip_33_reduce/in0] [get_bd_pins ip_33_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_33_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_33_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_33_reduce/slice_31/dout] [get_bd_pins ip_33_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_33_reduce/reduce_31/Res] [get_bd_pins ip_33_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 151 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 152 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 231 -to 0 ip_35_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_35_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 151 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 151 CONFIG.DIN_TO 17 CONFIG.DIN_WIDTH 152 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/slice_0/dout] [get_bd_pins ip_35_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 249 -to 0 ip_35_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 96 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 250 " [get_bd_cells ip_35_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_35_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/slice_1/dout] [get_bd_pins ip_35_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 249 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 113 CONFIG.DIN_TO 97 CONFIG.DIN_WIDTH 250 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 249 -to 0 ip_37_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 130 CONFIG.DIN_TO 114 CONFIG.DIN_WIDTH 250 " [get_bd_cells ip_37_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 249 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 136 CONFIG.DIN_TO 131 CONFIG.DIN_WIDTH 250 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_39_slice_and_concat/out0
create_bd_pin -dir I -from 249 -to 0 ip_39_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 150 CONFIG.DIN_TO 137 CONFIG.DIN_WIDTH 250 " [get_bd_cells ip_39_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_39_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_40_slice_and_concat/out0
create_bd_pin -dir I -from 249 -to 0 ip_40_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 156 CONFIG.DIN_TO 151 CONFIG.DIN_WIDTH 250 " [get_bd_cells ip_40_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_40_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 230 -to 0 ip_41_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 11 " [get_bd_cells ip_41_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 249 -to 0 ip_41_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 249 CONFIG.DIN_TO 157 CONFIG.DIN_WIDTH 250 " [get_bd_cells ip_41_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_41_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/slice_0/dout] [get_bd_pins ip_41_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_41_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_2] [get_bd_pins ip_41_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_3] [get_bd_pins ip_41_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_4] [get_bd_pins ip_41_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 16 -to 0 ip_41_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_5] [get_bd_pins ip_41_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 16 -to 0 ip_41_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_6] [get_bd_pins ip_41_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 3 -to 0 ip_41_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_7] [get_bd_pins ip_41_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_8] [get_bd_pins ip_41_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_9] [get_bd_pins ip_41_slice_and_concat/concat/In9]
create_bd_pin -dir I -from 251 -to 0 ip_41_slice_and_concat/in_10
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 93 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 252 " [get_bd_cells ip_41_slice_and_concat/slice_10]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_10] [get_bd_pins ip_41_slice_and_concat/slice_10/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/slice_10/dout] [get_bd_pins ip_41_slice_and_concat/concat/In10]


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 145 -to 0 ip_42_slice_and_concat/out0
create_bd_pin -dir I -from 251 -to 0 ip_42_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 239 CONFIG.DIN_TO 94 CONFIG.DIN_WIDTH 252 " [get_bd_cells ip_42_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_42_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_43_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_43_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 251 -to 0 ip_43_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 251 CONFIG.DIN_TO 240 CONFIG.DIN_WIDTH 252 " [get_bd_cells ip_43_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_43_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/slice_0/dout] [get_bd_pins ip_43_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_1] [get_bd_pins ip_43_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 13 -to 0 ip_43_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_43_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_2] [get_bd_pins ip_43_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/slice_2/dout] [get_bd_pins ip_43_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 246 -to 0 ip_44_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_44_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_44_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_44_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_44_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/slice_0/dout] [get_bd_pins ip_44_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_44_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_1] [get_bd_pins ip_44_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 3 -to 0 ip_44_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_2] [get_bd_pins ip_44_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_44_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_3] [get_bd_pins ip_44_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_44_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_4] [get_bd_pins ip_44_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 213 -to 0 ip_44_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_5] [get_bd_pins ip_44_slice_and_concat/concat/In5]


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


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_57_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_57_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_58_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_22_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_23_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic_IIC] [get_bd_intf_pins ip_0_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_1_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi_IIC] [get_bd_intf_pins ip_1_axi_quad_spi/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_1_axi_quad_spi_STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_quad_spi_STARTUP_IO_S] [get_bd_intf_pins ip_1_axi_quad_spi/STARTUP_IO_S]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_4_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_4_emc_EMC_INTF] [get_bd_intf_pins ip_4_emc/EMC_INTF]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_5_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_5_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_5_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_7_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_ethernet_lite_MII] [get_bd_intf_pins ip_7_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_9_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_9_emc_EMC_INTF] [get_bd_intf_pins ip_9_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_10_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_quad_spi_IIC] [get_bd_intf_pins ip_10_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_13_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_13_emc_EMC_INTF] [get_bd_intf_pins ip_13_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_14_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_14_emc_EMC_INTF] [get_bd_intf_pins ip_14_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_16_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_ethernet_lite_MII] [get_bd_intf_pins ip_16_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_16_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_16_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_17_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_17_emc_EMC_INTF] [get_bd_intf_pins ip_17_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_20_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_ethernet_lite_MII] [get_bd_intf_pins ip_20_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_20_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_20_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_24_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_33_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_23_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_24_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_iic/reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_4_emc/rst]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset] [get_bd_pins ip_5_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset] [get_bd_pins ip_6_dft/SCLR]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_8_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_9_emc/rst]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_13_emc/rst]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_14_emc/rst]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_16_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_17_emc/rst]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_18_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_19_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/peripheral_areset_n] [get_bd_pins ip_20_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_0_axi_iic/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_1_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_1_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_2_accumulator/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_4_emc/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_4_emc/rdclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_5_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_6_dft/CLK]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_7_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_8_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_9_emc/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_9_emc/rdclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_10_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_10_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_10_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_11_accumulator/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_12_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_12_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_12_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_13_emc/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_13_emc/rdclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_14_emc/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_14_emc/rdclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_15_dft/CLK]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_16_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_17_emc/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_17_emc/rdclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_18_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_18_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_18_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_19_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_20_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_21_accumulator/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_22_reset/clk_in]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_locked] [get_bd_pins ip_22_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_24_intc/irq_0] [get_bd_pins ip_0_axi_iic/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_1] [get_bd_pins ip_1_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_2] [get_bd_pins ip_7_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_3] [get_bd_pins ip_10_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_4] [get_bd_pins ip_12_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_24_intc/irq_5] [get_bd_pins ip_16_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_24_intc/irq_6] [get_bd_pins ip_18_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_24_intc/irq_7] [get_bd_pins ip_20_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_25_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_25_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_25_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_25_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_25_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_emc/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_emc/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_25_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_25_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_25_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_emc/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_emc/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_emc/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_25_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_intc/AXI] [get_bd_intf_pins ip_25_axi_legacy/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_26_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_axi_dma/M_AXIS_CNTRL]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_8_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_29_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/B]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_33_reduce/in0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_IM]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_RE]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_6_dft/SIZE]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_15_dft/XN_RE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_15_dft/SIZE]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_5_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_2] [get_bd_pins ip_5_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_3] [get_bd_pins ip_5_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_4] [get_bd_pins ip_6_dft/RFFD]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_5] [get_bd_pins ip_6_dft/XK_RE]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_6] [get_bd_pins ip_6_dft/XK_IM]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_7] [get_bd_pins ip_6_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_8] [get_bd_pins ip_6_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_9] [get_bd_pins ip_6_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_10] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/B]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_15_dft/XN_IM]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_1] [get_bd_pins ip_15_dft/RFFD]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_2] [get_bd_pins ip_15_dft/XK_RE]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_11_accumulator/B]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_15_dft/XK_RE]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_1] [get_bd_pins ip_15_dft/XK_IM]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_2] [get_bd_pins ip_15_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_3] [get_bd_pins ip_15_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_4] [get_bd_pins ip_15_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_5] [get_bd_pins ip_21_accumulator/Q]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_6_dft/CE]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/ADD]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_15_dft/FD_IN]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_15_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_6_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_11_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/ADD]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_6_dft/FD_IN]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/CE]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/CE]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_5_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_25_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_22_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_24_intc/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_25_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_26_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_28_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_29_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_23_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/M_AXIS_DOUT declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/M_AXIS_DOUT declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axi_dma/axi_dma_0/M_AXIS_CNTRL]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axi_dma/M_AXIS_CNTRL declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axi_dma/M_AXIS_CNTRL declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axi_dma/S_AXIS_S2MM declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axi_dma/S_AXIS_S2MM declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_1 declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/S_AXIS_1 declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 200 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/M_AXIS declared=200 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_combiner/M_AXIS declared=200 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 200 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=200 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=200 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }


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
