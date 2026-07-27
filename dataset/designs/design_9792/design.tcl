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
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x1 CONFIG.C_GPO_WIDTH 8 CONFIG.C_SCL_INERTIAL_DELAY 101 CONFIG.C_SDA_INERTIAL_DELAY 239 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 992.9619789703227 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_0_axi_iic/axi_iic_0]
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


########## emc ##########
create_bd_cell -type hier ip_1_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_1_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 15 CONFIG.C_TAVDV_PS_MEM_0 15477 CONFIG.C_TCEDV_PS_MEM_0 14126 CONFIG.C_THZCE_PS_MEM_0 6860 CONFIG.C_THZOE_PS_MEM_0 7313 CONFIG.C_TLZWE_PS_MEM_0 4462 CONFIG.C_TWC_PS_MEM_0 14577 CONFIG.C_TWPH_PS_MEM_0 11997 CONFIG.C_TWP_PS_MEM_0 12250 CONFIG.C_WR_REC_TIME_MEM_0 26780 " [get_bd_cells ip_1_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_1_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_1_emc/EMC_INTF] [get_bd_intf_pins ip_1_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_1_emc/clk
connect_bd_net [get_bd_pins ip_1_emc/clk] [get_bd_pins ip_1_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_emc/rdclk
connect_bd_net [get_bd_pins ip_1_emc/rdclk] [get_bd_pins ip_1_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_emc/rst
connect_bd_net [get_bd_pins ip_1_emc/rst] [get_bd_pins ip_1_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_emc/AXI] [get_bd_intf_pins ip_1_emc/emc_0/S_AXI_MEM]


########## uartlite ##########
create_bd_cell -type hier ip_2_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_2_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 38400 CONFIG.C_DATA_BITS 7 CONFIG.PARITY No_Parity " [get_bd_cells ip_2_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite/UART] [get_bd_intf_pins ip_2_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_2_uartlite/clk
connect_bd_net [get_bd_pins ip_2_uartlite/clk] [get_bd_pins ip_2_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_uartlite/reset
connect_bd_net [get_bd_pins ip_2_uartlite/reset] [get_bd_pins ip_2_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_2_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_uartlite/irq
connect_bd_net [get_bd_pins ip_2_uartlite/irq] [get_bd_pins ip_2_uartlite/uart_0/interrupt]


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 30 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 33 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 29 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 32 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/C_IN
connect_bd_net [get_bd_pins ip_3_accumulator/C_IN] [get_bd_pins ip_3_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/Bypass
connect_bd_net [get_bd_pins ip_3_accumulator/Bypass] [get_bd_pins ip_3_accumulator/accumulator_0/Bypass]


########## emc ##########
create_bd_cell -type hier ip_4_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_4_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 64 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 6 CONFIG.C_TAVDV_PS_MEM_0 15953 CONFIG.C_TAVDV_PS_MEM_1 15051 CONFIG.C_TAVDV_PS_MEM_2 15839 CONFIG.C_TCEDV_PS_MEM_0 16058 CONFIG.C_TCEDV_PS_MEM_1 14216 CONFIG.C_TCEDV_PS_MEM_2 14184 CONFIG.C_THZCE_PS_MEM_0 6554 CONFIG.C_THZCE_PS_MEM_1 6649 CONFIG.C_THZCE_PS_MEM_2 7346 CONFIG.C_THZOE_PS_MEM_0 6793 CONFIG.C_THZOE_PS_MEM_1 7360 CONFIG.C_THZOE_PS_MEM_2 7429 CONFIG.C_TLZWE_PS_MEM_0 7294 CONFIG.C_TLZWE_PS_MEM_1 8004 CONFIG.C_TLZWE_PS_MEM_2 974 CONFIG.C_TWC_PS_MEM_0 15065 CONFIG.C_TWC_PS_MEM_1 14402 CONFIG.C_TWC_PS_MEM_2 14000 CONFIG.C_TWPH_PS_MEM_0 11494 CONFIG.C_TWPH_PS_MEM_1 12996 CONFIG.C_TWPH_PS_MEM_2 11811 CONFIG.C_TWP_PS_MEM_0 12983 CONFIG.C_TWP_PS_MEM_1 11697 CONFIG.C_TWP_PS_MEM_2 10981 CONFIG.C_WR_REC_TIME_MEM_0 25924 CONFIG.C_WR_REC_TIME_MEM_1 29411 CONFIG.C_WR_REC_TIME_MEM_2 28932 " [get_bd_cells ip_4_emc/emc_0]
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


########## fft ##########
create_bd_cell -type hier ip_5_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_5_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 4 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 8 " [get_bd_cells ip_5_fft/fft_0]
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


########## axi_cdma ##########
create_bd_cell -type hier ip_6_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_6_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 60 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_6_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_6_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_6_axi_cdma/m_axi_aclk] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_6_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_6_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_cdma/M_AXI] [get_bd_intf_pins ip_6_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_6_axi_cdma/cdma_introut] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/cdma_introut]


########## dft ##########
create_bd_cell -type hier ip_7_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_7_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 14 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_7_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/CLK
connect_bd_net [get_bd_pins ip_7_dft/CLK] [get_bd_pins ip_7_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/CE
connect_bd_net [get_bd_pins ip_7_dft/CE] [get_bd_pins ip_7_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/SCLR
connect_bd_net [get_bd_pins ip_7_dft/SCLR] [get_bd_pins ip_7_dft/dft_0/SCLR]
create_bd_pin -dir I -from 13 -to 0 ip_7_dft/XN_RE
connect_bd_net [get_bd_pins ip_7_dft/XN_RE] [get_bd_pins ip_7_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 13 -to 0 ip_7_dft/XN_IM
connect_bd_net [get_bd_pins ip_7_dft/XN_IM] [get_bd_pins ip_7_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/FD_IN
connect_bd_net [get_bd_pins ip_7_dft/FD_IN] [get_bd_pins ip_7_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/FWD_INV
connect_bd_net [get_bd_pins ip_7_dft/FWD_INV] [get_bd_pins ip_7_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_7_dft/SIZE
connect_bd_net [get_bd_pins ip_7_dft/SIZE] [get_bd_pins ip_7_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/RFFD
connect_bd_net [get_bd_pins ip_7_dft/RFFD] [get_bd_pins ip_7_dft/dft_0/RFFD]
create_bd_pin -dir O -from 13 -to 0 ip_7_dft/XK_RE
connect_bd_net [get_bd_pins ip_7_dft/XK_RE] [get_bd_pins ip_7_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 13 -to 0 ip_7_dft/XK_IM
connect_bd_net [get_bd_pins ip_7_dft/XK_IM] [get_bd_pins ip_7_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_7_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_7_dft/BLK_EXP] [get_bd_pins ip_7_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/FD_OUT
connect_bd_net [get_bd_pins ip_7_dft/FD_OUT] [get_bd_pins ip_7_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_7_dft/DATA_VALID] [get_bd_pins ip_7_dft/dft_0/DATA_VALID]


########## axi_cdma ##########
create_bd_cell -type hier ip_8_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_8_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 32 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 128 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_8_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_8_axi_cdma/m_axi_aclk] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_8_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_8_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_cdma/M_AXI] [get_bd_intf_pins ip_8_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_8_axi_cdma/cdma_introut] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/cdma_introut]


########## uartlite ##########
create_bd_cell -type hier ip_9_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_9_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 2400 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Odd " [get_bd_cells ip_9_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_9_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_9_uartlite/UART] [get_bd_intf_pins ip_9_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_9_uartlite/clk
connect_bd_net [get_bd_pins ip_9_uartlite/clk] [get_bd_pins ip_9_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_uartlite/reset
connect_bd_net [get_bd_pins ip_9_uartlite/reset] [get_bd_pins ip_9_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_uartlite/AXI] [get_bd_intf_pins ip_9_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_uartlite/irq
connect_bd_net [get_bd_pins ip_9_uartlite/irq] [get_bd_pins ip_9_uartlite/uart_0/interrupt]


########## microblaze ##########
create_bd_cell -type hier ip_10_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 36 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 4 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 1 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 4 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0xca CONFIG.C_PVR_USER2 0xf3399a1b CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 0 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_10_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_microblaze/Clk
connect_bd_net [get_bd_pins ip_10_microblaze/Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_10_microblaze/Reset
connect_bd_net [get_bd_pins ip_10_microblaze/Reset] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_10_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/INTERRUPT] [get_bd_intf_pins ip_10_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/M_AXI_DP] [get_bd_intf_pins ip_10_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_10_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_10_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xc10f39a65999529 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_10_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_10_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_10_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_10_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x2e0521f54761c85 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_10_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_10_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_10_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_10_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_10_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_10_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_10_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_10_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_10_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 3 " [get_bd_cells ip_10_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_10_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_10_microblaze/microblaze_0/DEBUG]


########## complex_multiplier ##########
create_bd_cell -type hier ip_11_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_11_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 57 CONFIG.aresetn 0 CONFIG.bportwidth 32 CONFIG.btuserwidth 208 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 82 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_11_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_11_complex_multiplier/aclk] [get_bd_pins ip_11_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_11_complex_multiplier/aclken] [get_bd_pins ip_11_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_11_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_11_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_11_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## cordic ##########
create_bd_cell -type hier ip_12_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_12_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 32 CONFIG.Iterations 44 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 38 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode No_Pipelining CONFIG.Precision 45 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_12_cordic/cordic_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_12_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_12_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_12_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_12_cordic/cordic_0/M_AXIS_DOUT]


########## axi_hwicap ##########
create_bd_cell -type hier ip_13_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_13_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 " [get_bd_cells ip_13_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_13_axi_hwicap/icap_clk] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_13_axi_hwicap/eos_in] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_13_axi_hwicap/s_axi_aclk] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_13_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_13_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## fft ##########
create_bd_cell -type hier ip_14_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_14_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 5 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 65536 " [get_bd_cells ip_14_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_fft/aclk
connect_bd_net [get_bd_pins ip_14_fft/aclk] [get_bd_pins ip_14_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_14_fft/event_frame_started
connect_bd_net [get_bd_pins ip_14_fft/event_frame_started] [get_bd_pins ip_14_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_14_fft/S_AXIS_DATA] [get_bd_intf_pins ip_14_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_14_fft/M_AXIS_DATA] [get_bd_intf_pins ip_14_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_14_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_14_fft/fft_0/S_AXIS_CONFIG]


########## floating_point ##########
create_bd_cell -type hier ip_15_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_15_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.a_tuser_width 28 CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Resources CONFIG.c_a_exponent_width 5 CONFIG.c_a_fraction_width 13 CONFIG.c_accum_input_msb 7 CONFIG.c_accum_lsb -22 CONFIG.c_accum_msb 10 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_accum_input_overflow 0 CONFIG.c_has_accum_overflow 0 CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage Medium_Usage CONFIG.c_optimization Low_Latency CONFIG.flow_control Blocking CONFIG.has_a_tuser 1 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 1 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_tuser_width 14 CONFIG.operation_type Accumulator " [get_bd_cells ip_15_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_floating_point/aclk
connect_bd_net [get_bd_pins ip_15_floating_point/aclk] [get_bd_pins ip_15_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_15_floating_point/S_AXIS_A] [get_bd_intf_pins ip_15_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_floating_point/S_AXIS_OPERATION
connect_bd_intf_net [get_bd_intf_pins ip_15_floating_point/S_AXIS_OPERATION] [get_bd_intf_pins ip_15_floating_point/floating_point_0/S_AXIS_OPERATION]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_15_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_15_floating_point/floating_point_0/M_AXIS_RESULT]


########## gpio ##########
create_bd_cell -type hier ip_16_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_16_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 30 CONFIG.C_GPIO_WIDTH 6 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_16_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_16_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio/GPIO] [get_bd_intf_pins ip_16_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_16_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio/GPIO2] [get_bd_intf_pins ip_16_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_16_gpio/clk
connect_bd_net [get_bd_pins ip_16_gpio/clk] [get_bd_pins ip_16_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_gpio/rst
connect_bd_net [get_bd_pins ip_16_gpio/rst] [get_bd_pins ip_16_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio/AXI] [get_bd_intf_pins ip_16_gpio/gpio_0/S_AXI]


########## gpio ##########
create_bd_cell -type hier ip_17_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_17_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 30 CONFIG.C_GPIO_WIDTH 4 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_17_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/GPIO] [get_bd_intf_pins ip_17_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/GPIO2] [get_bd_intf_pins ip_17_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_17_gpio/clk
connect_bd_net [get_bd_pins ip_17_gpio/clk] [get_bd_pins ip_17_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_gpio/rst
connect_bd_net [get_bd_pins ip_17_gpio/rst] [get_bd_pins ip_17_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/AXI] [get_bd_intf_pins ip_17_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_17_gpio/irq
connect_bd_net [get_bd_pins ip_17_gpio/irq] [get_bd_pins ip_17_gpio/gpio_0/ip2intc_irpt]


########## dft ##########
create_bd_cell -type hier ip_18_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_18_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 17 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_18_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_dft/CLK
connect_bd_net [get_bd_pins ip_18_dft/CLK] [get_bd_pins ip_18_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_18_dft/SCLR
connect_bd_net [get_bd_pins ip_18_dft/SCLR] [get_bd_pins ip_18_dft/dft_0/SCLR]
create_bd_pin -dir I -from 16 -to 0 ip_18_dft/XN_RE
connect_bd_net [get_bd_pins ip_18_dft/XN_RE] [get_bd_pins ip_18_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 16 -to 0 ip_18_dft/XN_IM
connect_bd_net [get_bd_pins ip_18_dft/XN_IM] [get_bd_pins ip_18_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_18_dft/FD_IN
connect_bd_net [get_bd_pins ip_18_dft/FD_IN] [get_bd_pins ip_18_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_18_dft/FWD_INV
connect_bd_net [get_bd_pins ip_18_dft/FWD_INV] [get_bd_pins ip_18_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_18_dft/SIZE
connect_bd_net [get_bd_pins ip_18_dft/SIZE] [get_bd_pins ip_18_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_18_dft/RFFD
connect_bd_net [get_bd_pins ip_18_dft/RFFD] [get_bd_pins ip_18_dft/dft_0/RFFD]
create_bd_pin -dir O -from 16 -to 0 ip_18_dft/XK_RE
connect_bd_net [get_bd_pins ip_18_dft/XK_RE] [get_bd_pins ip_18_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 16 -to 0 ip_18_dft/XK_IM
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
set_property -dict "CONFIG.NUM_PORTS 9 " [get_bd_cells ip_21_intc/concat_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_21_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_21_intc/irq] [get_bd_intf_pins ip_21_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_22_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_22_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 11 CONFIG.NUM_SI 3 " [get_bd_cells ip_22_axi/axi_0]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_23_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_23_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_23_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_25_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_25_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_25_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_25_axis_broadcaster/aclk] [get_bd_pins ip_25_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_25_axis_broadcaster/aresetn] [get_bd_pins ip_25_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_26_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_26_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_26_axis_broadcaster/axis_broadcaster_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_28_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 20 " [get_bd_cells ip_29_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aclk] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aresetn] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_31_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_31_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_31_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_31_axis_combiner/aclk] [get_bd_pins ip_31_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_31_axis_combiner/aresetn] [get_bd_pins ip_31_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_31_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_31_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_31_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_combiner/M_AXIS] [get_bd_intf_pins ip_31_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_32_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_32_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 3 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aclk] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_32_axis_dwidth_converter/aresetn] [get_bd_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_33_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_33_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_33_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aclk] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aresetn] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 32 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 33 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 32 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 33 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 32 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 33 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_37_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_37_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 32 -to 0 ip_37_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 33 " [get_bd_cells ip_37_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/slice_0/dout] [get_bd_pins ip_37_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_1] [get_bd_pins ip_37_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 13 -to 0 ip_37_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_2] [get_bd_pins ip_37_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 13 -to 0 ip_37_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_37_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_3] [get_bd_pins ip_37_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/slice_3/dout] [get_bd_pins ip_37_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 3 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 13 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_39_slice_and_concat/out0
create_bd_pin -dir I -from 13 -to 0 ip_39_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_39_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_39_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_40_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_40_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_40_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 11 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_40_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_40_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/slice_0/dout] [get_bd_pins ip_40_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_40_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_40_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_1] [get_bd_pins ip_40_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/slice_1/dout] [get_bd_pins ip_40_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 29 -to 0 ip_41_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_41_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_41_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_41_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_41_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/slice_0/dout] [get_bd_pins ip_41_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_41_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_2] [get_bd_pins ip_41_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_3] [get_bd_pins ip_41_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 16 -to 0 ip_41_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_4] [get_bd_pins ip_41_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 16 -to 0 ip_41_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_41_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_5] [get_bd_pins ip_41_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/slice_5/dout] [get_bd_pins ip_41_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_42_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_42_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_42_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_42_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_42_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/slice_0/dout] [get_bd_pins ip_42_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_42_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_1] [get_bd_pins ip_42_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_42_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_2] [get_bd_pins ip_42_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_42_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_3] [get_bd_pins ip_42_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_43_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_43_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_43_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_43_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_44_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_44_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_44_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_45_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_45_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_45_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_46_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_46_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_46_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_46_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_47_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_47_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_47_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_47_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_47_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_48_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_48_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_48_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_48_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_48_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_48_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_49_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_49_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_49_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_49_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_49_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_49_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_50_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_50_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_50_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_50_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_19_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_20_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic_IIC] [get_bd_intf_pins ip_0_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_1_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_1_emc_EMC_INTF] [get_bd_intf_pins ip_1_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite_UART] [get_bd_intf_pins ip_2_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_4_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_4_emc_EMC_INTF] [get_bd_intf_pins ip_4_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_9_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_9_uartlite_UART] [get_bd_intf_pins ip_9_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_16_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio_GPIO] [get_bd_intf_pins ip_16_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_16_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_16_gpio_GPIO2] [get_bd_intf_pins ip_16_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio_GPIO] [get_bd_intf_pins ip_17_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio_GPIO2] [get_bd_intf_pins ip_17_gpio/GPIO2]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_23_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 3 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_38_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_43_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_21_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_iic/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_1_emc/rst]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_2_uartlite/reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_4_emc/rst]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset] [get_bd_pins ip_7_dft/SCLR]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_9_uartlite/reset]
connect_bd_net [get_bd_pins ip_19_reset/mb_reset] [get_bd_pins ip_10_microblaze/Reset]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_16_gpio/rst]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset_n] [get_bd_pins ip_17_gpio/rst]
connect_bd_net [get_bd_pins ip_19_reset/peripheral_areset] [get_bd_pins ip_18_dft/SCLR]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_0_axi_iic/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_1_emc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_1_emc/rdclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_2_uartlite/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_4_emc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_4_emc/rdclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_5_fft/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_6_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_6_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_7_dft/CLK]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_9_uartlite/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_10_microblaze/Clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_11_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_13_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_13_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_14_fft/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_15_floating_point/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_16_gpio/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_17_gpio/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_18_dft/CLK]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_19_reset/clk_in]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_locked] [get_bd_pins ip_19_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_21_intc/irq_0] [get_bd_pins ip_0_axi_iic/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_1] [get_bd_pins ip_2_uartlite/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_2] [get_bd_pins ip_5_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_21_intc/irq_3] [get_bd_pins ip_6_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_21_intc/irq_4] [get_bd_pins ip_8_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_21_intc/irq_5] [get_bd_pins ip_9_uartlite/irq]
connect_bd_net [get_bd_pins ip_21_intc/irq_6] [get_bd_pins ip_13_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_21_intc/irq_7] [get_bd_pins ip_14_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_21_intc/irq_8] [get_bd_pins ip_17_gpio/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_microblaze/INTERRUPT] [get_bd_intf_pins ip_21_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_cdma/M_AXI] [get_bd_intf_pins ip_22_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/M_AXI] [get_bd_intf_pins ip_22_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_microblaze/M_AXI_DP] [get_bd_intf_pins ip_22_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_22_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_emc/AXI] [get_bd_intf_pins ip_22_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_22_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_emc/AXI] [get_bd_intf_pins ip_22_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_22_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_22_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_uartlite/AXI] [get_bd_intf_pins ip_22_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_22_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_gpio/AXI] [get_bd_intf_pins ip_22_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_gpio/AXI] [get_bd_intf_pins ip_22_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_intc/AXI] [get_bd_intf_pins ip_22_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_24_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/M_AXIS_DATA] [get_bd_intf_pins ip_25_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_26_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_floating_point/S_AXIS_OPERATION] [get_bd_intf_pins ip_27_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_11_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_14_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_fft/S_AXIS_DATA] [get_bd_intf_pins ip_31_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_floating_point/S_AXIS_A] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_fft/S_AXIS_DATA] [get_bd_intf_pins ip_23_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_13_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_7_dft/XN_RE]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_18_dft/XN_RE]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_18_dft/XN_IM]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_1] [get_bd_pins ip_7_dft/RFFD]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_2] [get_bd_pins ip_7_dft/XK_RE]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_3] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_7_dft/SIZE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_18_dft/SIZE]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_1] [get_bd_pins ip_7_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_7_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_7_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_2] [get_bd_pins ip_7_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_3] [get_bd_pins ip_18_dft/RFFD]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_4] [get_bd_pins ip_18_dft/XK_RE]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_5] [get_bd_pins ip_18_dft/XK_IM]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_7_dft/XN_IM]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_18_dft/XK_IM]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_1] [get_bd_pins ip_18_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_2] [get_bd_pins ip_18_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_3] [get_bd_pins ip_18_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_7_dft/FD_IN]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_18_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_7_dft/CE]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_11_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_18_dft/FD_IN]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_7_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_22_axi/reset]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_21_intc/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_22_axi/clk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_23_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_24_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_25_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_26_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_27_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_28_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_29_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_31_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_20_clk_wiz/clk_out] [get_bd_pins ip_33_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_DATA declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/M_AXIS_DATA declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 10 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=10 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_fft/S_AXIS_CONFIG declared=10 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/S_AXIS_A declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/S_AXIS_A declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 176 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/M_AXIS_DOUT declared=176 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/M_AXIS_DOUT declared=176 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_cordic/S_AXIS_PHASE declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_cordic/S_AXIS_PHASE declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_cordic/M_AXIS_DOUT declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_cordic/M_AXIS_DOUT declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_fft/S_AXIS_DATA declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_fft/S_AXIS_DATA declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_fft/M_AXIS_DATA declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_fft/M_AXIS_DATA declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 26 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_fft/S_AXIS_CONFIG declared=26 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_fft/S_AXIS_CONFIG declared=26 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_floating_point/S_AXIS_A declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_floating_point/S_AXIS_A declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_floating_point/floating_point_0/S_AXIS_OPERATION]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_floating_point/S_AXIS_OPERATION declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_floating_point/S_AXIS_OPERATION declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_floating_point/M_AXIS_RESULT declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_floating_point/M_AXIS_RESULT declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_3 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_broadcaster/M_AXIS_3 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/S_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/S_AXIS declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_0 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_0 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_1 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_1 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_0 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_0 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_1 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_1 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=80 actual=ERR $__err" }
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
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_combiner/S_AXIS_1 declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_combiner/S_AXIS_1 declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_combiner/S_AXIS_2 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_combiner/S_AXIS_2 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_combiner/M_AXIS declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_combiner/M_AXIS declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }


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
