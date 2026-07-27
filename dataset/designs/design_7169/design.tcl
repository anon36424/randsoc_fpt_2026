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



########## complex_multiplier ##########
create_bd_cell -type hier ip_0_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_0_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 41 CONFIG.aresetn 1 CONFIG.bportwidth 48 CONFIG.btuserwidth 2 CONFIG.ctrltuserwidth 248 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 1 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 15 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_0_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_0_complex_multiplier/aclk] [get_bd_pins ip_0_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_0_complex_multiplier/aresetn] [get_bd_pins ip_0_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_0_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## fft ##########
create_bd_cell -type hier ip_1_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_1_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 4 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 8 " [get_bd_cells ip_1_fft/fft_0]
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
set_property -dict "CONFIG.channels 10 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 8192 " [get_bd_cells ip_2_fft/fft_0]
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


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_3_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_3_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_3_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_3_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite/MII] [get_bd_intf_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_3_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_3_axi_ethernet_lite/clk] [get_bd_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_3_axi_ethernet_lite/reset] [get_bd_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_3_axi_ethernet_lite/irq] [get_bd_pins ip_3_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## dft ##########
create_bd_cell -type hier ip_4_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_4_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 14 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_4_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CLK
connect_bd_net [get_bd_pins ip_4_dft/CLK] [get_bd_pins ip_4_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CE
connect_bd_net [get_bd_pins ip_4_dft/CE] [get_bd_pins ip_4_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/SCLR
connect_bd_net [get_bd_pins ip_4_dft/SCLR] [get_bd_pins ip_4_dft/dft_0/SCLR]
create_bd_pin -dir I -from 13 -to 0 ip_4_dft/XN_RE
connect_bd_net [get_bd_pins ip_4_dft/XN_RE] [get_bd_pins ip_4_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 13 -to 0 ip_4_dft/XN_IM
connect_bd_net [get_bd_pins ip_4_dft/XN_IM] [get_bd_pins ip_4_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FD_IN
connect_bd_net [get_bd_pins ip_4_dft/FD_IN] [get_bd_pins ip_4_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FWD_INV
connect_bd_net [get_bd_pins ip_4_dft/FWD_INV] [get_bd_pins ip_4_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_4_dft/SIZE
connect_bd_net [get_bd_pins ip_4_dft/SIZE] [get_bd_pins ip_4_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/RFFD
connect_bd_net [get_bd_pins ip_4_dft/RFFD] [get_bd_pins ip_4_dft/dft_0/RFFD]
create_bd_pin -dir O -from 13 -to 0 ip_4_dft/XK_RE
connect_bd_net [get_bd_pins ip_4_dft/XK_RE] [get_bd_pins ip_4_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 13 -to 0 ip_4_dft/XK_IM
connect_bd_net [get_bd_pins ip_4_dft/XK_IM] [get_bd_pins ip_4_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_4_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_4_dft/BLK_EXP] [get_bd_pins ip_4_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/FD_OUT
connect_bd_net [get_bd_pins ip_4_dft/FD_OUT] [get_bd_pins ip_4_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_4_dft/DATA_VALID] [get_bd_pins ip_4_dft/dft_0/DATA_VALID]


########## emc ##########
create_bd_cell -type hier ip_5_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_5_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 1 CONFIG.C_MEM3_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_SYNCH_PIPEDELAY_1 1 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 6 CONFIG.C_TAVDV_PS_MEM_0 13960 CONFIG.C_TAVDV_PS_MEM_2 14409 CONFIG.C_TAVDV_PS_MEM_3 14185 CONFIG.C_TCEDV_PS_MEM_0 16394 CONFIG.C_TCEDV_PS_MEM_2 15660 CONFIG.C_TCEDV_PS_MEM_3 16334 CONFIG.C_THZCE_PS_MEM_0 6484 CONFIG.C_THZCE_PS_MEM_2 6518 CONFIG.C_THZCE_PS_MEM_3 6538 CONFIG.C_THZOE_PS_MEM_0 6460 CONFIG.C_THZOE_PS_MEM_2 7344 CONFIG.C_THZOE_PS_MEM_3 6599 CONFIG.C_TLZWE_PS_MEM_0 1265 CONFIG.C_TLZWE_PS_MEM_2 7176 CONFIG.C_TLZWE_PS_MEM_3 888 CONFIG.C_TWC_PS_MEM_0 13754 CONFIG.C_TWC_PS_MEM_2 13572 CONFIG.C_TWC_PS_MEM_3 15140 CONFIG.C_TWPH_PS_MEM_0 11137 CONFIG.C_TWPH_PS_MEM_2 11185 CONFIG.C_TWPH_PS_MEM_3 10961 CONFIG.C_TWP_PS_MEM_0 11056 CONFIG.C_TWP_PS_MEM_2 12832 CONFIG.C_TWP_PS_MEM_3 12483 CONFIG.C_WR_REC_TIME_MEM_0 27914 CONFIG.C_WR_REC_TIME_MEM_2 29512 CONFIG.C_WR_REC_TIME_MEM_3 26097 " [get_bd_cells ip_5_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_5_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_5_emc/EMC_INTF] [get_bd_intf_pins ip_5_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/clk
connect_bd_net [get_bd_pins ip_5_emc/clk] [get_bd_pins ip_5_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/rdclk
connect_bd_net [get_bd_pins ip_5_emc/rdclk] [get_bd_pins ip_5_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/rst
connect_bd_net [get_bd_pins ip_5_emc/rst] [get_bd_pins ip_5_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_emc/AXI] [get_bd_intf_pins ip_5_emc/emc_0/S_AXI_MEM]


########## uartlite ##########
create_bd_cell -type hier ip_6_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_6_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 4800 CONFIG.C_DATA_BITS 8 CONFIG.PARITY No_Parity " [get_bd_cells ip_6_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_6_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite/UART] [get_bd_intf_pins ip_6_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_6_uartlite/clk
connect_bd_net [get_bd_pins ip_6_uartlite/clk] [get_bd_pins ip_6_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_uartlite/reset
connect_bd_net [get_bd_pins ip_6_uartlite/reset] [get_bd_pins ip_6_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite/AXI] [get_bd_intf_pins ip_6_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_uartlite/irq
connect_bd_net [get_bd_pins ip_6_uartlite/irq] [get_bd_pins ip_6_uartlite/uart_0/interrupt]


########## emc ##########
create_bd_cell -type hier ip_7_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_7_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 6 CONFIG.C_TAVDV_PS_MEM_0 16274 CONFIG.C_TAVDV_PS_MEM_1 14271 CONFIG.C_TCEDV_PS_MEM_0 13656 CONFIG.C_TCEDV_PS_MEM_1 15373 CONFIG.C_THZCE_PS_MEM_0 6930 CONFIG.C_THZCE_PS_MEM_1 7094 CONFIG.C_THZOE_PS_MEM_0 7270 CONFIG.C_THZOE_PS_MEM_1 7547 CONFIG.C_TLZWE_PS_MEM_0 1026 CONFIG.C_TLZWE_PS_MEM_1 1220 CONFIG.C_TWC_PS_MEM_0 16301 CONFIG.C_TWC_PS_MEM_1 14037 CONFIG.C_TWPH_PS_MEM_0 13152 CONFIG.C_TWPH_PS_MEM_1 12386 CONFIG.C_TWP_PS_MEM_0 11473 CONFIG.C_TWP_PS_MEM_1 13009 CONFIG.C_WR_REC_TIME_MEM_0 27109 CONFIG.C_WR_REC_TIME_MEM_1 24667 " [get_bd_cells ip_7_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_7_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_7_emc/EMC_INTF] [get_bd_intf_pins ip_7_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_7_emc/clk
connect_bd_net [get_bd_pins ip_7_emc/clk] [get_bd_pins ip_7_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_emc/rdclk
connect_bd_net [get_bd_pins ip_7_emc/rdclk] [get_bd_pins ip_7_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_emc/rst
connect_bd_net [get_bd_pins ip_7_emc/rst] [get_bd_pins ip_7_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_emc/AXI] [get_bd_intf_pins ip_7_emc/emc_0/S_AXI_MEM]


########## fft ##########
create_bd_cell -type hier ip_8_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_8_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 2 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 256 " [get_bd_cells ip_8_fft/fft_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_9_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_9_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x64 CONFIG.C_GPO_WIDTH 5 CONFIG.C_SCL_INERTIAL_DELAY 235 CONFIG.C_SDA_INERTIAL_DELAY 138 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 406.0361264063276 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_9_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_9_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic/IIC] [get_bd_intf_pins ip_9_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_iic/clk
connect_bd_net [get_bd_pins ip_9_axi_iic/clk] [get_bd_pins ip_9_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_iic/reset
connect_bd_net [get_bd_pins ip_9_axi_iic/reset] [get_bd_pins ip_9_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic/AXI] [get_bd_intf_pins ip_9_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_iic/irq
connect_bd_net [get_bd_pins ip_9_axi_iic/irq] [get_bd_pins ip_9_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_timer ##########
create_bd_cell -type hier ip_10_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_10_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 16 CONFIG.GEN0_ASSERT Active_Low CONFIG.GEN1_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.TRIG1_ASSERT Active_High CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_10_axi_timer/axi_timer_0]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_11_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_11_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 2 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_11_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/IIC] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/clk] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/reset] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/clk4] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/reset4] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/irq] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_12_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_12_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 1 CONFIG.C_TAVDV_PS_MEM_0 16468 CONFIG.C_TCEDV_PS_MEM_0 14786 CONFIG.C_THZCE_PS_MEM_0 7147 CONFIG.C_THZOE_PS_MEM_0 6455 CONFIG.C_TLZWE_PS_MEM_0 8763 CONFIG.C_TWC_PS_MEM_0 14193 CONFIG.C_TWPH_PS_MEM_0 12234 CONFIG.C_TWP_PS_MEM_0 12244 CONFIG.C_WR_REC_TIME_MEM_0 25995 " [get_bd_cells ip_12_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_12_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_12_emc/EMC_INTF] [get_bd_intf_pins ip_12_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_12_emc/clk
connect_bd_net [get_bd_pins ip_12_emc/clk] [get_bd_pins ip_12_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_emc/rdclk
connect_bd_net [get_bd_pins ip_12_emc/rdclk] [get_bd_pins ip_12_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_emc/rst
connect_bd_net [get_bd_pins ip_12_emc/rst] [get_bd_pins ip_12_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_emc/AXI] [get_bd_intf_pins ip_12_emc/emc_0/S_AXI_MEM]


########## complex_multiplier ##########
create_bd_cell -type hier ip_13_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_13_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 51 CONFIG.aresetn 0 CONFIG.atuserwidth 53 CONFIG.bportwidth 58 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 90 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_13_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_13_complex_multiplier/aclk] [get_bd_pins ip_13_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## reset ##########
create_bd_cell -type hier ip_14_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_14_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_reset/clk_in
connect_bd_net [get_bd_pins ip_14_reset/clk_in] [get_bd_pins ip_14_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_14_reset/reset_in
connect_bd_net [get_bd_pins ip_14_reset/reset_in] [get_bd_pins ip_14_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_14_reset/dcm_locked
connect_bd_net [get_bd_pins ip_14_reset/dcm_locked] [get_bd_pins ip_14_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/mb_reset
connect_bd_net [get_bd_pins ip_14_reset/mb_reset] [get_bd_pins ip_14_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_14_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset] [get_bd_pins ip_14_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_14_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_15_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_15_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_in] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_15_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_15_clk_wiz/reset
connect_bd_net [get_bd_pins ip_15_clk_wiz/reset] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_locked] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_16_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_16_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_16_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_16_intc/concat_0]
connect_bd_net [get_bd_pins ip_16_intc/concat_0/dout] [get_bd_pins ip_16_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/clk
connect_bd_net [get_bd_pins ip_16_intc/clk] [get_bd_pins ip_16_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/reset
connect_bd_net [get_bd_pins ip_16_intc/reset] [get_bd_pins ip_16_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_intc/AXI] [get_bd_intf_pins ip_16_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_0
connect_bd_net [get_bd_pins ip_16_intc/irq_0] [get_bd_pins ip_16_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_1
connect_bd_net [get_bd_pins ip_16_intc/irq_1] [get_bd_pins ip_16_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_2
connect_bd_net [get_bd_pins ip_16_intc/irq_2] [get_bd_pins ip_16_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_3
connect_bd_net [get_bd_pins ip_16_intc/irq_3] [get_bd_pins ip_16_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_4
connect_bd_net [get_bd_pins ip_16_intc/irq_4] [get_bd_pins ip_16_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_5
connect_bd_net [get_bd_pins ip_16_intc/irq_5] [get_bd_pins ip_16_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_6
connect_bd_net [get_bd_pins ip_16_intc/irq_6] [get_bd_pins ip_16_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_7
connect_bd_net [get_bd_pins ip_16_intc/irq_7] [get_bd_pins ip_16_intc/concat_0/In7]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_16_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_16_intc/irq] [get_bd_intf_pins ip_16_intc/intc_0/interrupt]


########## jtag_axi ##########
create_bd_cell -type hier ip_17_jtag_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0
move_bd_cells [get_bd_cells ip_17_jtag_axi] [get_bd_cells jtag_axi_0]
set_property -dict "CONFIG.PROTOCOL AXI4 " [get_bd_cells ip_17_jtag_axi/jtag_axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_jtag_axi/aclk
connect_bd_net [get_bd_pins ip_17_jtag_axi/aclk] [get_bd_pins ip_17_jtag_axi/jtag_axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_jtag_axi/aresetn
connect_bd_net [get_bd_pins ip_17_jtag_axi/aresetn] [get_bd_pins ip_17_jtag_axi/jtag_axi_0/aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_jtag_axi/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_jtag_axi/M_AXI] [get_bd_intf_pins ip_17_jtag_axi/jtag_axi_0/M_AXI]


########## axi_legacy ##########
create_bd_cell -type hier ip_18_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_18_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 10 CONFIG.NUM_SI 1 " [get_bd_cells ip_18_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_legacy/clk
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_legacy/reset
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_M0] [get_bd_intf_pins ip_18_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S0] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S1] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S2] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S3] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S4] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S5] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S6] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S7] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S8] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_legacy/AXI_S9] [get_bd_intf_pins ip_18_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_18_axi_legacy/clk] [get_bd_pins ip_18_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_18_axi_legacy/reset] [get_bd_pins ip_18_axi_legacy/axi_0/M09_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_19_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_19_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_19_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_19_axis_broadcaster/aclk] [get_bd_pins ip_19_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_19_axis_broadcaster/aresetn] [get_bd_pins ip_19_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_20_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_20_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_20_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_20_axis_broadcaster/aclk] [get_bd_pins ip_20_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_20_axis_broadcaster/aresetn] [get_bd_pins ip_20_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


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
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_22_axis_broadcaster/axis_broadcaster_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_23_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_23_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 24 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aclk] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aresetn] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_27_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_27_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_27_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_27_axis_combiner/aclk] [get_bd_pins ip_27_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_27_axis_combiner/aresetn] [get_bd_pins ip_27_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_27_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_27_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_combiner/M_AXIS] [get_bd_intf_pins ip_27_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_28_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_28_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_28_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 40 " [get_bd_cells ip_29_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 40 " [get_bd_cells ip_31_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aclk] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aresetn] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_32_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_32_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_32_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_32_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_32_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_1] [get_bd_pins ip_32_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/slice_1/dout] [get_bd_pins ip_32_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_33_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_33_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 13 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/slice_0/dout] [get_bd_pins ip_33_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_33_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_33_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_33_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/slice_1/dout] [get_bd_pins ip_33_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_34_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_34_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/slice_0/dout] [get_bd_pins ip_34_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_34_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_1] [get_bd_pins ip_34_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_2] [get_bd_pins ip_34_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 3 -to 0 ip_35_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_35_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_35_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_2] [get_bd_pins ip_35_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_3] [get_bd_pins ip_35_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_36_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_36_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_36_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_36_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_37_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_37_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_37_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_37_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_38_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_38_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_39_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_39_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_39_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_39_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_40_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_40_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_40_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_40_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_41_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_41_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_41_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_41_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_15_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_3_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite_MII] [get_bd_intf_pins ip_3_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_3_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_3_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_5_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_5_emc_EMC_INTF] [get_bd_intf_pins ip_5_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_6_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite_UART] [get_bd_intf_pins ip_6_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_7_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_7_emc_EMC_INTF] [get_bd_intf_pins ip_7_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_9_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic_IIC] [get_bd_intf_pins ip_9_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi_IIC] [get_bd_intf_pins ip_11_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_12_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_12_emc_EMC_INTF] [get_bd_intf_pins ip_12_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_16_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 3 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_35_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 5 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_37_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_38_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_39_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_41_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_0_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset] [get_bd_pins ip_4_dft/SCLR]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_5_emc/rst]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_6_uartlite/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_7_emc/rst]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_iic/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_12_emc/rst]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_0_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_1_fft/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_2_fft/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_3_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_4_dft/CLK]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_5_emc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_5_emc/rdclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_6_uartlite/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_7_emc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_7_emc/rdclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_8_fft/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_9_axi_iic/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_10_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_12_emc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_12_emc/rdclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_13_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_14_reset/clk_in]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_locked] [get_bd_pins ip_14_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_16_intc/irq_0] [get_bd_pins ip_1_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_16_intc/irq_1] [get_bd_pins ip_2_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_16_intc/irq_2] [get_bd_pins ip_3_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_3] [get_bd_pins ip_6_uartlite/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_4] [get_bd_pins ip_8_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_16_intc/irq_5] [get_bd_pins ip_9_axi_iic/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_6] [get_bd_pins ip_10_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_16_intc/irq_7] [get_bd_pins ip_11_axi_quad_spi/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_jtag_axi/M_AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_emc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_uartlite/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_emc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_iic/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_timer/S_AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_18_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_18_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_emc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_intc/AXI] [get_bd_intf_pins ip_18_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_19_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_fft/M_AXIS_DATA] [get_bd_intf_pins ip_20_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_fft/M_AXIS_DATA] [get_bd_intf_pins ip_21_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_22_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_fft/S_AXIS_DATA] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_fft/S_AXIS_DATA] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_22_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_fft/S_AXIS_DATA] [get_bd_intf_pins ip_27_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_28_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_2]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_RE]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_4_dft/RFFD]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_1] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_4_dft/SIZE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_IM]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_1] [get_bd_pins ip_4_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_2] [get_bd_pins ip_4_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_4_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_1] [get_bd_pins ip_10_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_2] [get_bd_pins ip_10_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_3] [get_bd_pins ip_10_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_4_dft/FD_IN]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_4_dft/CE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_4_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_17_jtag_axi/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_18_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_16_intc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_17_jtag_axi/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_18_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_19_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_20_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_21_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_22_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_27_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_28_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_29_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_A declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_A declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_complex_multiplier/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_DATA declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_DATA declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/M_AXIS_DATA declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/M_AXIS_DATA declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 10 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_CONFIG declared=10 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_fft/S_AXIS_CONFIG declared=10 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_DATA declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_DATA declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_fft/M_AXIS_DATA declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_fft/M_AXIS_DATA declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 24 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_CONFIG declared=24 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_fft/S_AXIS_CONFIG declared=24 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_DATA declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_DATA declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_fft/M_AXIS_DATA declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_fft/M_AXIS_DATA declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 15 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_CONFIG declared=15 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_fft/S_AXIS_CONFIG declared=15 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_B declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_B declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/M_AXIS_DOUT declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/M_AXIS_DOUT declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/S_AXIS declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_0 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_1 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_2 declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_broadcaster/M_AXIS_2 declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_0 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_0 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_1 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_1 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_2 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_broadcaster/M_AXIS_2 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/S_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/S_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_0 declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_0 declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_1 declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_broadcaster/M_AXIS_1 declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_combiner/S_AXIS_0 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_combiner/S_AXIS_0 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 192 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_combiner/S_AXIS_1 declared=192 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_combiner/S_AXIS_1 declared=192 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_combiner/M_AXIS declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_combiner/M_AXIS declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 15 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=15 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=15 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 320 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=320 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=320 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }


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
