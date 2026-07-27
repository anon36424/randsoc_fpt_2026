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
set_property -dict "CONFIG.AINIT_Value 0 CONFIG.Accum_Mode Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 215 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 218 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_0_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_accumulator/clk
connect_bd_net [get_bd_pins ip_0_accumulator/clk] [get_bd_pins ip_0_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 214 -to 0 ip_0_accumulator/B
connect_bd_net [get_bd_pins ip_0_accumulator/B] [get_bd_pins ip_0_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 217 -to 0 ip_0_accumulator/Q
connect_bd_net [get_bd_pins ip_0_accumulator/Q] [get_bd_pins ip_0_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_0_accumulator/Bypass
connect_bd_net [get_bd_pins ip_0_accumulator/Bypass] [get_bd_pins ip_0_accumulator/accumulator_0/Bypass]


########## axi_dma ##########
create_bd_cell -type hier ip_1_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_1_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 61 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 8 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 256 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 512 CONFIG.C_NUM_MM2S_CHANNELS 2 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 18 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_1_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_1_axi_dma/axi_resetn] [get_bd_pins ip_1_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_1_axi_dma/mm2s_introut] [get_bd_pins ip_1_axi_dma/axi_dma_0/mm2s_introut]


########## xadc_wiz ##########
create_bd_cell -type hier ip_2_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_2_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_TEMP_BUS 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_2_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_2_xadc_wiz/s_axi_aclk] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_2_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_2_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
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
create_bd_pin -dir O -from 11 -to 0 ip_2_xadc_wiz/temp_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/temp_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/temp_out]


########## dft ##########
create_bd_cell -type hier ip_3_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_3_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 11 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_3_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/CLK
connect_bd_net [get_bd_pins ip_3_dft/CLK] [get_bd_pins ip_3_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/CE
connect_bd_net [get_bd_pins ip_3_dft/CE] [get_bd_pins ip_3_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/SCLR
connect_bd_net [get_bd_pins ip_3_dft/SCLR] [get_bd_pins ip_3_dft/dft_0/SCLR]
create_bd_pin -dir I -from 10 -to 0 ip_3_dft/XN_RE
connect_bd_net [get_bd_pins ip_3_dft/XN_RE] [get_bd_pins ip_3_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 10 -to 0 ip_3_dft/XN_IM
connect_bd_net [get_bd_pins ip_3_dft/XN_IM] [get_bd_pins ip_3_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FD_IN
connect_bd_net [get_bd_pins ip_3_dft/FD_IN] [get_bd_pins ip_3_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FWD_INV
connect_bd_net [get_bd_pins ip_3_dft/FWD_INV] [get_bd_pins ip_3_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_3_dft/SIZE
connect_bd_net [get_bd_pins ip_3_dft/SIZE] [get_bd_pins ip_3_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/RFFD
connect_bd_net [get_bd_pins ip_3_dft/RFFD] [get_bd_pins ip_3_dft/dft_0/RFFD]
create_bd_pin -dir O -from 10 -to 0 ip_3_dft/XK_RE
connect_bd_net [get_bd_pins ip_3_dft/XK_RE] [get_bd_pins ip_3_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 10 -to 0 ip_3_dft/XK_IM
connect_bd_net [get_bd_pins ip_3_dft/XK_IM] [get_bd_pins ip_3_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_3_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_3_dft/BLK_EXP] [get_bd_pins ip_3_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/FD_OUT
connect_bd_net [get_bd_pins ip_3_dft/FD_OUT] [get_bd_pins ip_3_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_3_dft/DATA_VALID] [get_bd_pins ip_3_dft/dft_0/DATA_VALID]


########## dft ##########
create_bd_cell -type hier ip_4_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_4_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 11 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_4_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CLK
connect_bd_net [get_bd_pins ip_4_dft/CLK] [get_bd_pins ip_4_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CE
connect_bd_net [get_bd_pins ip_4_dft/CE] [get_bd_pins ip_4_dft/dft_0/CE]
create_bd_pin -dir I -from 10 -to 0 ip_4_dft/XN_RE
connect_bd_net [get_bd_pins ip_4_dft/XN_RE] [get_bd_pins ip_4_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 10 -to 0 ip_4_dft/XN_IM
connect_bd_net [get_bd_pins ip_4_dft/XN_IM] [get_bd_pins ip_4_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FD_IN
connect_bd_net [get_bd_pins ip_4_dft/FD_IN] [get_bd_pins ip_4_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FWD_INV
connect_bd_net [get_bd_pins ip_4_dft/FWD_INV] [get_bd_pins ip_4_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_4_dft/SIZE
connect_bd_net [get_bd_pins ip_4_dft/SIZE] [get_bd_pins ip_4_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/RFFD
connect_bd_net [get_bd_pins ip_4_dft/RFFD] [get_bd_pins ip_4_dft/dft_0/RFFD]
create_bd_pin -dir O -from 10 -to 0 ip_4_dft/XK_RE
connect_bd_net [get_bd_pins ip_4_dft/XK_RE] [get_bd_pins ip_4_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 10 -to 0 ip_4_dft/XK_IM
connect_bd_net [get_bd_pins ip_4_dft/XK_IM] [get_bd_pins ip_4_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_4_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_4_dft/BLK_EXP] [get_bd_pins ip_4_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/FD_OUT
connect_bd_net [get_bd_pins ip_4_dft/FD_OUT] [get_bd_pins ip_4_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_4_dft/DATA_VALID] [get_bd_pins ip_4_dft/dft_0/DATA_VALID]


########## axi_iic ##########
create_bd_cell -type hier ip_5_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_5_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x7d CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 101 CONFIG.C_SDA_INERTIAL_DELAY 5 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 264.7624782748407 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_6_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_6_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x26 CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 242 CONFIG.C_SDA_INERTIAL_DELAY 37 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 167.79612598793494 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_6_axi_iic/axi_iic_0]
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


########## gpio ##########
create_bd_cell -type hier ip_7_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_7_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x7fff CONFIG.C_DOUT_DEFAULT_2 0x7fff CONFIG.C_GPIO2_WIDTH 27 CONFIG.C_GPIO_WIDTH 15 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_7_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_7_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio/GPIO] [get_bd_intf_pins ip_7_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_7_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio/GPIO2] [get_bd_intf_pins ip_7_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_7_gpio/clk
connect_bd_net [get_bd_pins ip_7_gpio/clk] [get_bd_pins ip_7_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_gpio/rst
connect_bd_net [get_bd_pins ip_7_gpio/rst] [get_bd_pins ip_7_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio/AXI] [get_bd_intf_pins ip_7_gpio/gpio_0/S_AXI]


########## cordic ##########
create_bd_cell -type hier ip_8_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_8_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 33 CONFIG.Iterations 6 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 29 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 48 CONFIG.Round_Mode Truncate " [get_bd_cells ip_8_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_cordic/aclk
connect_bd_net [get_bd_pins ip_8_cordic/aclk] [get_bd_pins ip_8_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_8_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_8_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_8_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_8_cordic/cordic_0/M_AXIS_DOUT]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_9_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_9_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 0 CONFIG.C_NUM_TRANSFER_BITS 16 CONFIG.C_SCK_RATIO 2 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 1 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 0 CONFIG.Master_mode 1 " [get_bd_cells ip_9_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_9_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/IIC] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:display_startup_io:startup_io_rtl:1.0 ip_9_axi_quad_spi/STARTUP_IO
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/STARTUP_IO] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/STARTUP_IO]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/clk4] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/reset4] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/irq] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


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
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_12_intc/concat_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_12_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_12_intc/irq] [get_bd_intf_pins ip_12_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_13_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_13_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 6 CONFIG.NUM_SI 2 " [get_bd_cells ip_13_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi/clk
connect_bd_net [get_bd_pins ip_13_axi/clk] [get_bd_pins ip_13_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi/reset
connect_bd_net [get_bd_pins ip_13_axi/reset] [get_bd_pins ip_13_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_M0] [get_bd_intf_pins ip_13_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_M1] [get_bd_intf_pins ip_13_axi/axi_0/S01_AXI]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_13_axi/AXI_S5] [get_bd_intf_pins ip_13_axi/axi_0/M05_AXI]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_14_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_14_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 5 CONFIG.S_TDATA_NUM_BYTES 32 " [get_bd_cells ip_14_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_14_axis_dwidth_converter/aclk] [get_bd_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_14_axis_dwidth_converter/aresetn] [get_bd_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_15_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_15_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_15_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_15_axis_dwidth_converter/aclk] [get_bd_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_15_axis_dwidth_converter/aresetn] [get_bd_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 19 -to 0 ip_16_slice_and_concat/out0
create_bd_pin -dir I -from 217 -to 0 ip_16_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 218 " [get_bd_cells ip_16_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 217 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 218 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 217 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 41 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 218 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 217 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 42 CONFIG.DIN_WIDTH 218 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_20_slice_and_concat/out0
create_bd_pin -dir I -from 217 -to 0 ip_20_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 58 CONFIG.DIN_TO 48 CONFIG.DIN_WIDTH 218 " [get_bd_cells ip_20_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 214 -to 0 ip_21_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 13 " [get_bd_cells ip_21_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 217 -to 0 ip_21_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 217 CONFIG.DIN_TO 59 CONFIG.DIN_WIDTH 218 " [get_bd_cells ip_21_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_21_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/slice_0/dout] [get_bd_pins ip_21_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_1] [get_bd_pins ip_21_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_2] [get_bd_pins ip_21_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_3] [get_bd_pins ip_21_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 11 -to 0 ip_21_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_4] [get_bd_pins ip_21_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_5] [get_bd_pins ip_21_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 10 -to 0 ip_21_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_6] [get_bd_pins ip_21_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 10 -to 0 ip_21_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_7] [get_bd_pins ip_21_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 3 -to 0 ip_21_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_8] [get_bd_pins ip_21_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_9] [get_bd_pins ip_21_slice_and_concat/concat/In9]
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_10
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_10] [get_bd_pins ip_21_slice_and_concat/concat/In10]
create_bd_pin -dir I -from 0 -to 0 ip_21_slice_and_concat/in_11
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_11] [get_bd_pins ip_21_slice_and_concat/concat/In11]
create_bd_pin -dir I -from 10 -to 0 ip_21_slice_and_concat/in_12
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_12] [get_bd_pins ip_21_slice_and_concat/concat/In12]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_22_slice_and_concat/out0
create_bd_pin -dir I -from 10 -to 0 ip_22_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_22_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_23_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_23_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 10 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/slice_0/dout] [get_bd_pins ip_23_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_23_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_1] [get_bd_pins ip_23_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_2] [get_bd_pins ip_23_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_23_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_3] [get_bd_pins ip_23_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_28_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_30_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_11_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_6_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic_IIC] [get_bd_intf_pins ip_6_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_7_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio_GPIO] [get_bd_intf_pins ip_7_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_7_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio_GPIO2] [get_bd_intf_pins ip_7_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_9_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi_IIC] [get_bd_intf_pins ip_9_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:display_startup_io:startup_io_rtl:1.0 ip_9_axi_quad_spi_STARTUP_IO
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi_STARTUP_IO] [get_bd_intf_pins ip_9_axi_quad_spi/STARTUP_IO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_12_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_15_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 19 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_16_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_11_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_2_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset] [get_bd_pins ip_3_dft/SCLR]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_iic/reset]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_7_gpio/rst]
connect_bd_net [get_bd_pins ip_10_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_0_accumulator/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_2_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_3_dft/CLK]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_4_dft/CLK]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_6_axi_iic/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_7_gpio/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_8_cordic/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_10_reset/clk_in]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_locked] [get_bd_pins ip_10_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_12_intc/irq_0] [get_bd_pins ip_1_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_12_intc/irq_1] [get_bd_pins ip_2_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_12_intc/irq_2] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_12_intc/irq_3] [get_bd_pins ip_6_axi_iic/irq]
connect_bd_net [get_bd_pins ip_12_intc/irq_4] [get_bd_pins ip_9_axi_quad_spi/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_13_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_13_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_13_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_iic/AXI] [get_bd_intf_pins ip_13_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_gpio/AXI] [get_bd_intf_pins ip_13_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_13_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_intc/AXI] [get_bd_intf_pins ip_13_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_1_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_14_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_cordic/M_AXIS_DOUT]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_RE]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_RE]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_4_dft/SIZE]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_IM]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_0_accumulator/B]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_0_accumulator/Q]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_1] [get_bd_pins ip_2_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_2] [get_bd_pins ip_2_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_3] [get_bd_pins ip_2_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_4] [get_bd_pins ip_2_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_5] [get_bd_pins ip_3_dft/RFFD]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_6] [get_bd_pins ip_3_dft/XK_RE]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_7] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_8] [get_bd_pins ip_3_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_9] [get_bd_pins ip_3_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_10] [get_bd_pins ip_3_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_11] [get_bd_pins ip_4_dft/RFFD]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_12] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_3_dft/SIZE]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_IM]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_1] [get_bd_pins ip_4_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_2] [get_bd_pins ip_4_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_3] [get_bd_pins ip_4_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_0_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_4_dft/CE]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_3_dft/CE]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_3_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_3_dft/FD_IN]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_4_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_4_dft/FD_IN]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_13_axi/reset]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_14_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_10_reset/interconnect_aresetn] [get_bd_pins ip_15_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_12_intc/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_13_axi/clk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_14_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_11_clk_wiz/clk_out] [get_bd_pins ip_15_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/M_AXIS_MM2S declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/M_AXIS_MM2S declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_cordic/S_AXIS_PHASE declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_cordic/S_AXIS_PHASE declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/S_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axis_dwidth_converter/M_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
