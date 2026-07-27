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
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 7 CONFIG.C_TAVDV_PS_MEM_0 15687 CONFIG.C_TCEDV_PS_MEM_0 15464 CONFIG.C_THZCE_PS_MEM_0 6470 CONFIG.C_THZOE_PS_MEM_0 6538 CONFIG.C_TLZWE_PS_MEM_0 6938 CONFIG.C_TWC_PS_MEM_0 16454 CONFIG.C_TWPH_PS_MEM_0 13125 CONFIG.C_TWP_PS_MEM_0 12942 CONFIG.C_WR_REC_TIME_MEM_0 27251 " [get_bd_cells ip_0_emc/emc_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_1_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_1_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x71 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 95 CONFIG.C_SDA_INERTIAL_DELAY 185 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 561.1175737351867 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_1_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_1_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_iic/IIC] [get_bd_intf_pins ip_1_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_iic/clk
connect_bd_net [get_bd_pins ip_1_axi_iic/clk] [get_bd_pins ip_1_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_iic/reset
connect_bd_net [get_bd_pins ip_1_axi_iic/reset] [get_bd_pins ip_1_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_iic/AXI] [get_bd_intf_pins ip_1_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_iic/irq
connect_bd_net [get_bd_pins ip_1_axi_iic/irq] [get_bd_pins ip_1_axi_iic/axi_iic_0/iic2intc_irpt]


########## xadc_wiz ##########
create_bd_cell -type hier ip_2_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_2_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_DCLK 0 CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_2_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_2_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_2_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
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


########## emc ##########
create_bd_cell -type hier ip_3_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_3_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 4 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 10 CONFIG.C_TAVDV_PS_MEM_0 16356 CONFIG.C_TAVDV_PS_MEM_1 15048 CONFIG.C_TAVDV_PS_MEM_2 15272 CONFIG.C_TCEDV_PS_MEM_0 13964 CONFIG.C_TCEDV_PS_MEM_1 15449 CONFIG.C_TCEDV_PS_MEM_2 16232 CONFIG.C_THZCE_PS_MEM_0 6723 CONFIG.C_THZCE_PS_MEM_1 7117 CONFIG.C_THZCE_PS_MEM_2 6351 CONFIG.C_THZOE_PS_MEM_0 7200 CONFIG.C_THZOE_PS_MEM_1 6557 CONFIG.C_THZOE_PS_MEM_2 6414 CONFIG.C_TLZWE_PS_MEM_0 2877 CONFIG.C_TLZWE_PS_MEM_1 6968 CONFIG.C_TLZWE_PS_MEM_2 3292 CONFIG.C_TWC_PS_MEM_0 14328 CONFIG.C_TWC_PS_MEM_1 14029 CONFIG.C_TWC_PS_MEM_2 16139 CONFIG.C_TWPH_PS_MEM_0 12563 CONFIG.C_TWPH_PS_MEM_1 12392 CONFIG.C_TWPH_PS_MEM_2 10855 CONFIG.C_TWP_PS_MEM_0 11333 CONFIG.C_TWP_PS_MEM_1 12176 CONFIG.C_TWP_PS_MEM_2 12850 CONFIG.C_WR_REC_TIME_MEM_0 27012 CONFIG.C_WR_REC_TIME_MEM_1 25319 CONFIG.C_WR_REC_TIME_MEM_2 24560 " [get_bd_cells ip_3_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc/EMC_INTF] [get_bd_intf_pins ip_3_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/clk
connect_bd_net [get_bd_pins ip_3_emc/clk] [get_bd_pins ip_3_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/rdclk
connect_bd_net [get_bd_pins ip_3_emc/rdclk] [get_bd_pins ip_3_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/rst
connect_bd_net [get_bd_pins ip_3_emc/rst] [get_bd_pins ip_3_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_3_emc/emc_0/S_AXI_MEM]


########## axi_iic ##########
create_bd_cell -type hier ip_4_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_4_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x7e CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 194 CONFIG.C_SDA_INERTIAL_DELAY 175 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 401.1219296801902 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_4_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_4_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic/IIC] [get_bd_intf_pins ip_4_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_iic/clk
connect_bd_net [get_bd_pins ip_4_axi_iic/clk] [get_bd_pins ip_4_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_iic/reset
connect_bd_net [get_bd_pins ip_4_axi_iic/reset] [get_bd_pins ip_4_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic/AXI] [get_bd_intf_pins ip_4_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_iic/irq
connect_bd_net [get_bd_pins ip_4_axi_iic/irq] [get_bd_pins ip_4_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_iic ##########
create_bd_cell -type hier ip_5_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_5_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x7b CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 171 CONFIG.C_SDA_INERTIAL_DELAY 198 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 898.8354514217892 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
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
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 15 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_6_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/CLK
connect_bd_net [get_bd_pins ip_6_dft/CLK] [get_bd_pins ip_6_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/CE
connect_bd_net [get_bd_pins ip_6_dft/CE] [get_bd_pins ip_6_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/SCLR
connect_bd_net [get_bd_pins ip_6_dft/SCLR] [get_bd_pins ip_6_dft/dft_0/SCLR]
create_bd_pin -dir I -from 14 -to 0 ip_6_dft/XN_RE
connect_bd_net [get_bd_pins ip_6_dft/XN_RE] [get_bd_pins ip_6_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 14 -to 0 ip_6_dft/XN_IM
connect_bd_net [get_bd_pins ip_6_dft/XN_IM] [get_bd_pins ip_6_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FD_IN
connect_bd_net [get_bd_pins ip_6_dft/FD_IN] [get_bd_pins ip_6_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_6_dft/FWD_INV
connect_bd_net [get_bd_pins ip_6_dft/FWD_INV] [get_bd_pins ip_6_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_6_dft/SIZE
connect_bd_net [get_bd_pins ip_6_dft/SIZE] [get_bd_pins ip_6_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_6_dft/RFFD
connect_bd_net [get_bd_pins ip_6_dft/RFFD] [get_bd_pins ip_6_dft/dft_0/RFFD]
create_bd_pin -dir O -from 14 -to 0 ip_6_dft/XK_RE
connect_bd_net [get_bd_pins ip_6_dft/XK_RE] [get_bd_pins ip_6_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 14 -to 0 ip_6_dft/XK_IM
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
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x52 CONFIG.C_GPO_WIDTH 8 CONFIG.C_SCL_INERTIAL_DELAY 85 CONFIG.C_SDA_INERTIAL_DELAY 254 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 468.9352924741392 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_7_axi_iic/axi_iic_0]
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


########## axi_dma ##########
create_bd_cell -type hier ip_8_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_8_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 59 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 32 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 16 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_NUM_MM2S_CHANNELS 3 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 26 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_8_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_8_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_8_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_8_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_8_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_8_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_8_axi_dma/axi_resetn] [get_bd_pins ip_8_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_8_axi_dma/mm2s_introut] [get_bd_pins ip_8_axi_dma/axi_dma_0/mm2s_introut]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_9_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_9_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_SPI_MEMORY 0 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_9_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_9_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/IIC] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:display_startup_io:startup_io_rtl:1.0 ip_9_axi_quad_spi/STARTUP_IO
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/STARTUP_IO] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/STARTUP_IO]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/clk] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/reset] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/irq] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## floating_point ##########
create_bd_cell -type hier ip_10_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_10_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Int64 CONFIG.a_tuser_width 117 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Fixed_to_float CONFIG.result_precision_type Single CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_10_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_floating_point/aclk
connect_bd_net [get_bd_pins ip_10_floating_point/aclk] [get_bd_pins ip_10_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_10_floating_point/S_AXIS_A] [get_bd_intf_pins ip_10_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_10_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_10_floating_point/floating_point_0/M_AXIS_RESULT]


########## floating_point ##########
create_bd_cell -type hier ip_11_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_11_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Half CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_divide_by_zero 1 CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Divide " [get_bd_cells ip_11_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_floating_point/aclk
connect_bd_net [get_bd_pins ip_11_floating_point/aclk] [get_bd_pins ip_11_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/S_AXIS_A] [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/S_AXIS_B] [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_11_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_11_floating_point/floating_point_0/M_AXIS_RESULT]


########## gpio ##########
create_bd_cell -type hier ip_12_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_12_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 22 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x237ec9 " [get_bd_cells ip_12_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/GPIO] [get_bd_intf_pins ip_12_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/clk
connect_bd_net [get_bd_pins ip_12_gpio/clk] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/rst
connect_bd_net [get_bd_pins ip_12_gpio/rst] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_12_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_gpio/irq
connect_bd_net [get_bd_pins ip_12_gpio/irq] [get_bd_pins ip_12_gpio/gpio_0/ip2intc_irpt]


########## conv_encoder ##########
create_bd_cell -type hier ip_13_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_13_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 6 CONFIG.convolution_code0 52 CONFIG.convolution_code1 50 CONFIG.convolution_code2 50 CONFIG.convolution_code3 30 CONFIG.convolution_code4 0 CONFIG.convolution_code5 21 CONFIG.convolution_code6 58 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 9 CONFIG.output_rate 14 CONFIG.puncture_code0 110111011 CONFIG.puncture_code1 110101111 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_13_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_13_conv_encoder/aclk] [get_bd_pins ip_13_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_13_conv_encoder/aresetn] [get_bd_pins ip_13_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## conv_encoder ##########
create_bd_cell -type hier ip_14_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_14_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 4 CONFIG.convolution_code0 12 CONFIG.convolution_code1 5 CONFIG.convolution_code2 13 CONFIG.convolution_code3 15 CONFIG.convolution_code4 0 CONFIG.convolution_code5 7 CONFIG.convolution_code6 14 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 6 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_14_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_14_conv_encoder/aclk] [get_bd_pins ip_14_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_14_conv_encoder/aresetn] [get_bd_pins ip_14_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_14_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_14_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_14_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_14_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_iic ##########
create_bd_cell -type hier ip_15_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_15_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x1 CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 172 CONFIG.C_SDA_INERTIAL_DELAY 176 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 141.79196058789225 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_15_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_15_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_iic/IIC] [get_bd_intf_pins ip_15_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_iic/clk
connect_bd_net [get_bd_pins ip_15_axi_iic/clk] [get_bd_pins ip_15_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_iic/reset
connect_bd_net [get_bd_pins ip_15_axi_iic/reset] [get_bd_pins ip_15_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_iic/AXI] [get_bd_intf_pins ip_15_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_iic/irq
connect_bd_net [get_bd_pins ip_15_axi_iic/irq] [get_bd_pins ip_15_axi_iic/axi_iic_0/iic2intc_irpt]


########## dft ##########
create_bd_cell -type hier ip_16_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_16_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 11 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_16_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_dft/CLK
connect_bd_net [get_bd_pins ip_16_dft/CLK] [get_bd_pins ip_16_dft/dft_0/CLK]
create_bd_pin -dir I -from 10 -to 0 ip_16_dft/XN_RE
connect_bd_net [get_bd_pins ip_16_dft/XN_RE] [get_bd_pins ip_16_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 10 -to 0 ip_16_dft/XN_IM
connect_bd_net [get_bd_pins ip_16_dft/XN_IM] [get_bd_pins ip_16_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_16_dft/FD_IN
connect_bd_net [get_bd_pins ip_16_dft/FD_IN] [get_bd_pins ip_16_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_16_dft/FWD_INV
connect_bd_net [get_bd_pins ip_16_dft/FWD_INV] [get_bd_pins ip_16_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_16_dft/SIZE
connect_bd_net [get_bd_pins ip_16_dft/SIZE] [get_bd_pins ip_16_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_16_dft/RFFD
connect_bd_net [get_bd_pins ip_16_dft/RFFD] [get_bd_pins ip_16_dft/dft_0/RFFD]
create_bd_pin -dir O -from 10 -to 0 ip_16_dft/XK_RE
connect_bd_net [get_bd_pins ip_16_dft/XK_RE] [get_bd_pins ip_16_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 10 -to 0 ip_16_dft/XK_IM
connect_bd_net [get_bd_pins ip_16_dft/XK_IM] [get_bd_pins ip_16_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_16_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_16_dft/BLK_EXP] [get_bd_pins ip_16_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_16_dft/FD_OUT
connect_bd_net [get_bd_pins ip_16_dft/FD_OUT] [get_bd_pins ip_16_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_16_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_16_dft/DATA_VALID] [get_bd_pins ip_16_dft/dft_0/DATA_VALID]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_17_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_17_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_17_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_17_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_ethernet_lite/MII] [get_bd_intf_pins ip_17_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_17_axi_ethernet_lite/clk] [get_bd_pins ip_17_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_17_axi_ethernet_lite/reset] [get_bd_pins ip_17_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_17_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_17_axi_ethernet_lite/irq] [get_bd_pins ip_17_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_18_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_18_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 230400 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Odd " [get_bd_cells ip_18_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_18_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite/UART] [get_bd_intf_pins ip_18_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_18_uartlite/clk
connect_bd_net [get_bd_pins ip_18_uartlite/clk] [get_bd_pins ip_18_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_uartlite/reset
connect_bd_net [get_bd_pins ip_18_uartlite/reset] [get_bd_pins ip_18_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite/AXI] [get_bd_intf_pins ip_18_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_18_uartlite/irq
connect_bd_net [get_bd_pins ip_18_uartlite/irq] [get_bd_pins ip_18_uartlite/uart_0/interrupt]


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


########## axi_legacy ##########
create_bd_cell -type hier ip_22_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_22_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 13 CONFIG.NUM_SI 2 " [get_bd_cells ip_22_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_legacy/clk
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_legacy/reset
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_M0] [get_bd_intf_pins ip_22_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_M1] [get_bd_intf_pins ip_22_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S0] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S1] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S2] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S3] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S4] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S5] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S6] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S7] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S8] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S9] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S10] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S11] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_legacy/AXI_S12] [get_bd_intf_pins ip_22_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_22_axi_legacy/clk] [get_bd_pins ip_22_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_22_axi_legacy/reset] [get_bd_pins ip_22_axi_legacy/axi_0/M12_ARESETN]


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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_24_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_24_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_27_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_28_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aclk] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_28_axis_dwidth_converter/aresetn] [get_bd_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_29_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_29_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_29_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_2] [get_bd_pins ip_29_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_29_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_3] [get_bd_pins ip_29_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 14 -to 0 ip_29_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 15 " [get_bd_cells ip_29_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_4] [get_bd_pins ip_29_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/slice_4/dout] [get_bd_pins ip_29_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 4 -to 0 ip_30_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_30_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 14 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 11 CONFIG.DIN_WIDTH 15 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/slice_0/dout] [get_bd_pins ip_30_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 14 -to 0 ip_30_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 15 " [get_bd_cells ip_30_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_30_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/slice_1/dout] [get_bd_pins ip_30_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 14 -to 0 ip_31_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 15 " [get_bd_cells ip_31_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_32_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_32_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 14 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 15 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/slice_0/dout] [get_bd_pins ip_32_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_32_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_32_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_1] [get_bd_pins ip_32_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/slice_1/dout] [get_bd_pins ip_32_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_33_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_33_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/slice_0/dout] [get_bd_pins ip_33_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_33_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_2] [get_bd_pins ip_33_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_3] [get_bd_pins ip_33_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 10 -to 0 ip_33_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_33_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_4] [get_bd_pins ip_33_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/slice_4/dout] [get_bd_pins ip_33_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_34_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_34_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 10 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/slice_0/dout] [get_bd_pins ip_34_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 10 -to 0 ip_34_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_34_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_1] [get_bd_pins ip_34_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/slice_1/dout] [get_bd_pins ip_34_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_35_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_35_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 10 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/slice_0/dout] [get_bd_pins ip_35_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_35_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_35_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_2] [get_bd_pins ip_35_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_3] [get_bd_pins ip_35_slice_and_concat/concat/In3]


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
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_19_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_20_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc_EMC_INTF] [get_bd_intf_pins ip_0_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_1_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_iic_IIC] [get_bd_intf_pins ip_1_axi_iic/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_2_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_2_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_2_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc_EMC_INTF] [get_bd_intf_pins ip_3_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_4_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic_IIC] [get_bd_intf_pins ip_4_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic_IIC] [get_bd_intf_pins ip_7_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_9_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi_IIC] [get_bd_intf_pins ip_9_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:display_startup_io:startup_io_rtl:1.0 ip_9_axi_quad_spi_STARTUP_IO
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi_STARTUP_IO] [get_bd_intf_pins ip_9_axi_quad_spi/STARTUP_IO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO] [get_bd_intf_pins ip_12_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_15_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_iic_IIC] [get_bd_intf_pins ip_15_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_17_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_ethernet_lite_MII] [get_bd_intf_pins ip_17_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_18_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite_UART] [get_bd_intf_pins ip_18_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_21_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_14_conv_encoder/M_AXIS_DATA]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 4 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_30_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_21_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_0_emc/rst]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_iic/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_3_emc/rst]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_iic/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset] [get_bd_pins ip_6_dft/SCLR]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_iic/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_12_gpio/rst]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_13_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_14_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_iic/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_18_uartlite/reset]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_0_emc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_0_emc/rdclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_1_axi_iic/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_3_emc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_3_emc/rdclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_4_axi_iic/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_6_dft/CLK]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_7_axi_iic/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_10_floating_point/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_11_floating_point/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_12_gpio/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_13_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_14_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_15_axi_iic/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_16_dft/CLK]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_17_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_18_uartlite/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_19_reset/clk_in]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_locked] [get_bd_pins ip_19_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_21_intc/irq_0] [get_bd_pins ip_1_axi_iic/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_1] [get_bd_pins ip_4_axi_iic/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_2] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_3] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_4] [get_bd_pins ip_8_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_21_intc/irq_5] [get_bd_pins ip_9_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_6] [get_bd_pins ip_12_gpio/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_7] [get_bd_pins ip_15_axi_iic/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_8] [get_bd_pins ip_17_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_9] [get_bd_pins ip_18_uartlite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_22_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_22_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_iic/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_iic/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_22_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_22_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_iic/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_uartlite/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_intc/AXI] [get_bd_intf_pins ip_22_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_23_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_floating_point/S_AXIS_A] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_floating_point/S_AXIS_A] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_floating_point/S_AXIS_B] [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_IM]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_1] [get_bd_pins ip_2_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_2] [get_bd_pins ip_2_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_3] [get_bd_pins ip_6_dft/RFFD]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_4] [get_bd_pins ip_6_dft/XK_RE]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_6_dft/XK_RE]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_1] [get_bd_pins ip_6_dft/XK_IM]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_16_dft/XN_IM]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_6_dft/XK_IM]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_6_dft/SIZE]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_6_dft/XK_IM]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_1] [get_bd_pins ip_6_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_16_dft/SIZE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_6_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_6_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_2] [get_bd_pins ip_6_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_3] [get_bd_pins ip_16_dft/RFFD]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_4] [get_bd_pins ip_16_dft/XK_RE]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_6_dft/XN_RE]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_16_dft/XK_RE]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_1] [get_bd_pins ip_16_dft/XK_IM]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_16_dft/XN_RE]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_16_dft/XK_IM]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_16_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_2] [get_bd_pins ip_16_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_3] [get_bd_pins ip_16_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_16_dft/FD_IN]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_6_dft/CE]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_6_dft/FD_IN]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_6_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_2_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_16_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_22_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_21_intc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_22_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_23_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_28_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_B declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/S_AXIS_B declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }


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
