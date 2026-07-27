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
set_property -dict "CONFIG.C_DEFAULT_VALUE 0xb CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 247 CONFIG.C_SDA_INERTIAL_DELAY 143 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 454.21431471429594 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_0_axi_iic/axi_iic_0]
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


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_1_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_1_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_1_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_1_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite/MII] [get_bd_intf_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_1_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_1_axi_ethernet_lite/clk] [get_bd_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_1_axi_ethernet_lite/reset] [get_bd_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_1_axi_ethernet_lite/irq] [get_bd_pins ip_1_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_2_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_2_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 4800 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Even " [get_bd_cells ip_2_uartlite/uart_0]
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


########## fft ##########
create_bd_cell -type hier ip_3_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_3_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 11 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 16384 " [get_bd_cells ip_3_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_fft/aclk
connect_bd_net [get_bd_pins ip_3_fft/aclk] [get_bd_pins ip_3_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_3_fft/event_frame_started
connect_bd_net [get_bd_pins ip_3_fft/event_frame_started] [get_bd_pins ip_3_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_3_fft/M_AXIS_DATA] [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]


########## uartlite ##########
create_bd_cell -type hier ip_4_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_4_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 38400 CONFIG.C_DATA_BITS 6 CONFIG.PARITY No_Parity " [get_bd_cells ip_4_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_4_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite/UART] [get_bd_intf_pins ip_4_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_4_uartlite/clk
connect_bd_net [get_bd_pins ip_4_uartlite/clk] [get_bd_pins ip_4_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_uartlite/reset
connect_bd_net [get_bd_pins ip_4_uartlite/reset] [get_bd_pins ip_4_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite/AXI] [get_bd_intf_pins ip_4_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_uartlite/irq
connect_bd_net [get_bd_pins ip_4_uartlite/irq] [get_bd_pins ip_4_uartlite/uart_0/interrupt]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 1200 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Odd " [get_bd_cells ip_5_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite/UART] [get_bd_intf_pins ip_5_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_5_uartlite/clk
connect_bd_net [get_bd_pins ip_5_uartlite/clk] [get_bd_pins ip_5_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_uartlite/reset
connect_bd_net [get_bd_pins ip_5_uartlite/reset] [get_bd_pins ip_5_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_5_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_5_uartlite/irq
connect_bd_net [get_bd_pins ip_5_uartlite/irq] [get_bd_pins ip_5_uartlite/uart_0/interrupt]


########## axi_iic ##########
create_bd_cell -type hier ip_6_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_6_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x47 CONFIG.C_GPO_WIDTH 5 CONFIG.C_SCL_INERTIAL_DELAY 27 CONFIG.C_SDA_INERTIAL_DELAY 224 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 380.8042817278015 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_6_axi_iic/axi_iic_0]
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


########## microblaze ##########
create_bd_cell -type hier ip_7_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 52 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 4 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_OPCODE_0x0_ILLEGAL 1 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0x57 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 0 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 0 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MMU 0 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_7_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_microblaze/Clk
connect_bd_net [get_bd_pins ip_7_microblaze/Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_7_microblaze/Reset
connect_bd_net [get_bd_pins ip_7_microblaze/Reset] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_7_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/INTERRUPT] [get_bd_intf_pins ip_7_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/M_AXI_DP] [get_bd_intf_pins ip_7_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_7_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_7_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x3d2e488f3132154 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_7_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_7_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_7_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_7_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x89b870053c67817 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_7_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_7_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_7_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_7_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_7_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_7_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_7_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_7_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_7_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_7_microblaze/mem/BRAM_PORTB]


########## axi_hwicap ##########
create_bd_cell -type hier ip_8_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_8_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 1 " [get_bd_cells ip_8_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_8_axi_hwicap/icap_clk] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_8_axi_hwicap/eos_in] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_8_axi_hwicap/s_axi_aclk] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_8_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_8_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_8_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_8_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap/ICAP] [get_bd_intf_pins ip_8_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_8_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_8_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_9_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_9_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_9_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_9_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_ethernet_lite/MII] [get_bd_intf_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_9_axi_ethernet_lite/clk] [get_bd_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_9_axi_ethernet_lite/reset] [get_bd_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_9_axi_ethernet_lite/irq] [get_bd_pins ip_9_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_10_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_10_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Rotate CONFIG.Input_Width 46 CONFIG.Iterations 26 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour OR_of_TLAST CONFIG.Out_TREADY 0 CONFIG.Output_Width 30 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 38 CONFIG.Round_Mode Truncate " [get_bd_cells ip_10_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_cordic/aclk
connect_bd_net [get_bd_pins ip_10_cordic/aclk] [get_bd_pins ip_10_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_10_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_10_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_10_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_10_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_10_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_10_cordic/cordic_0/M_AXIS_DOUT]


########## dft ##########
create_bd_cell -type hier ip_11_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_11_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 8 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_11_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_dft/CLK
connect_bd_net [get_bd_pins ip_11_dft/CLK] [get_bd_pins ip_11_dft/dft_0/CLK]
create_bd_pin -dir I -from 7 -to 0 ip_11_dft/XN_RE
connect_bd_net [get_bd_pins ip_11_dft/XN_RE] [get_bd_pins ip_11_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 7 -to 0 ip_11_dft/XN_IM
connect_bd_net [get_bd_pins ip_11_dft/XN_IM] [get_bd_pins ip_11_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_11_dft/FD_IN
connect_bd_net [get_bd_pins ip_11_dft/FD_IN] [get_bd_pins ip_11_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_11_dft/FWD_INV
connect_bd_net [get_bd_pins ip_11_dft/FWD_INV] [get_bd_pins ip_11_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_11_dft/SIZE
connect_bd_net [get_bd_pins ip_11_dft/SIZE] [get_bd_pins ip_11_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_11_dft/RFFD
connect_bd_net [get_bd_pins ip_11_dft/RFFD] [get_bd_pins ip_11_dft/dft_0/RFFD]
create_bd_pin -dir O -from 7 -to 0 ip_11_dft/XK_RE
connect_bd_net [get_bd_pins ip_11_dft/XK_RE] [get_bd_pins ip_11_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 7 -to 0 ip_11_dft/XK_IM
connect_bd_net [get_bd_pins ip_11_dft/XK_IM] [get_bd_pins ip_11_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_11_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_11_dft/BLK_EXP] [get_bd_pins ip_11_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_11_dft/FD_OUT
connect_bd_net [get_bd_pins ip_11_dft/FD_OUT] [get_bd_pins ip_11_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_11_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_11_dft/DATA_VALID] [get_bd_pins ip_11_dft/dft_0/DATA_VALID]


########## axi_timer ##########
create_bd_cell -type hier ip_12_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_12_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_12_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_timer/S_AXI] [get_bd_intf_pins ip_12_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_12_axi_timer/capturetrig0] [get_bd_pins ip_12_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/freeze
connect_bd_net [get_bd_pins ip_12_axi_timer/freeze] [get_bd_pins ip_12_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_12_axi_timer/s_axi_aclk] [get_bd_pins ip_12_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_12_axi_timer/s_axi_aresetn] [get_bd_pins ip_12_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_12_axi_timer/generateout0] [get_bd_pins ip_12_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_12_axi_timer/generateout1] [get_bd_pins ip_12_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_12_axi_timer/pwm0] [get_bd_pins ip_12_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_12_axi_timer/interrupt] [get_bd_pins ip_12_axi_timer/axi_timer_0/interrupt]


########## axi_dma ##########
create_bd_cell -type hier ip_13_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_13_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 39 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_13_axi_dma/axi_dma_0]
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


########## complex_multiplier ##########
create_bd_cell -type hier ip_14_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_14_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 51 CONFIG.aresetn 0 CONFIG.bportwidth 52 CONFIG.btuserwidth 252 CONFIG.ctrltuserwidth 59 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 1 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Manual CONFIG.minimumlatency 37 CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 41 CONFIG.outtlastbehv Pass_CTRL_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_14_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_14_complex_multiplier/aclk] [get_bd_pins ip_14_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_14_complex_multiplier/aclken] [get_bd_pins ip_14_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_15_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_15_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_15_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_15_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite/MII] [get_bd_intf_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_15_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_15_axi_ethernet_lite/clk] [get_bd_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_15_axi_ethernet_lite/reset] [get_bd_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_15_axi_ethernet_lite/irq] [get_bd_pins ip_15_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_iic ##########
create_bd_cell -type hier ip_16_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_16_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x47 CONFIG.C_GPO_WIDTH 7 CONFIG.C_SCL_INERTIAL_DELAY 149 CONFIG.C_SDA_INERTIAL_DELAY 140 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 995.9246873959382 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_16_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_16_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_iic/IIC] [get_bd_intf_pins ip_16_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_iic/clk
connect_bd_net [get_bd_pins ip_16_axi_iic/clk] [get_bd_pins ip_16_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_iic/reset
connect_bd_net [get_bd_pins ip_16_axi_iic/reset] [get_bd_pins ip_16_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_iic/AXI] [get_bd_intf_pins ip_16_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_iic/irq
connect_bd_net [get_bd_pins ip_16_axi_iic/irq] [get_bd_pins ip_16_axi_iic/axi_iic_0/iic2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_17_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_17_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x7fff CONFIG.C_GPIO_WIDTH 15 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_17_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/GPIO] [get_bd_intf_pins ip_17_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_17_gpio/clk
connect_bd_net [get_bd_pins ip_17_gpio/clk] [get_bd_pins ip_17_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_gpio/rst
connect_bd_net [get_bd_pins ip_17_gpio/rst] [get_bd_pins ip_17_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio/AXI] [get_bd_intf_pins ip_17_gpio/gpio_0/S_AXI]


########## accumulator ##########
create_bd_cell -type hier ip_18_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_18_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 12 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 30 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_18_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_accumulator/clk
connect_bd_net [get_bd_pins ip_18_accumulator/clk] [get_bd_pins ip_18_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 11 -to 0 ip_18_accumulator/B
connect_bd_net [get_bd_pins ip_18_accumulator/B] [get_bd_pins ip_18_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 29 -to 0 ip_18_accumulator/Q
connect_bd_net [get_bd_pins ip_18_accumulator/Q] [get_bd_pins ip_18_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_18_accumulator/CE
connect_bd_net [get_bd_pins ip_18_accumulator/CE] [get_bd_pins ip_18_accumulator/accumulator_0/CE]


########## uartlite ##########
create_bd_cell -type hier ip_19_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_19_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Odd " [get_bd_cells ip_19_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_19_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_19_uartlite/UART] [get_bd_intf_pins ip_19_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_19_uartlite/clk
connect_bd_net [get_bd_pins ip_19_uartlite/clk] [get_bd_pins ip_19_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_uartlite/reset
connect_bd_net [get_bd_pins ip_19_uartlite/reset] [get_bd_pins ip_19_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_uartlite/AXI] [get_bd_intf_pins ip_19_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_19_uartlite/irq
connect_bd_net [get_bd_pins ip_19_uartlite/irq] [get_bd_pins ip_19_uartlite/uart_0/interrupt]


########## conv_encoder ##########
create_bd_cell -type hier ip_20_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_20_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 9 CONFIG.convolution_code0 150 CONFIG.convolution_code1 133 CONFIG.convolution_code2 427 CONFIG.convolution_code3 330 CONFIG.convolution_code4 321 CONFIG.convolution_code5 87 CONFIG.convolution_code6 57 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 3 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_20_conv_encoder/conv_encoder_0]
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


########## xadc_wiz ##########
create_bd_cell -type hier ip_21_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_21_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING 256 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCA 1 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_21_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_21_xadc_wiz/dclk_in] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_21_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_21_xadc_wiz/convst_in] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_21_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_21_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_21_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_21_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_21_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_21_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_21_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_21_xadc_wiz/ot_out] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_21_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_21_xadc_wiz/eoc_out] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_21_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_21_xadc_wiz/eos_out] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_21_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_21_xadc_wiz/alarm_out] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_21_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_21_xadc_wiz/busy_out] [get_bd_pins ip_21_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_21_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_21_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_21_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## emc ##########
create_bd_cell -type hier ip_22_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_22_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 6 CONFIG.C_TAVDV_PS_MEM_0 13561 CONFIG.C_TAVDV_PS_MEM_1 14527 CONFIG.C_TAVDV_PS_MEM_2 14505 CONFIG.C_TCEDV_PS_MEM_0 13650 CONFIG.C_TCEDV_PS_MEM_1 15752 CONFIG.C_TCEDV_PS_MEM_2 15859 CONFIG.C_THZCE_PS_MEM_0 6958 CONFIG.C_THZCE_PS_MEM_1 7078 CONFIG.C_THZCE_PS_MEM_2 6524 CONFIG.C_THZOE_PS_MEM_0 6943 CONFIG.C_THZOE_PS_MEM_1 6410 CONFIG.C_THZOE_PS_MEM_2 6608 CONFIG.C_TLZWE_PS_MEM_0 7082 CONFIG.C_TLZWE_PS_MEM_1 5231 CONFIG.C_TLZWE_PS_MEM_2 3931 CONFIG.C_TWC_PS_MEM_0 14067 CONFIG.C_TWC_PS_MEM_1 15683 CONFIG.C_TWC_PS_MEM_2 14772 CONFIG.C_TWPH_PS_MEM_0 11872 CONFIG.C_TWPH_PS_MEM_1 11475 CONFIG.C_TWPH_PS_MEM_2 10846 CONFIG.C_TWP_PS_MEM_0 12595 CONFIG.C_TWP_PS_MEM_1 12370 CONFIG.C_TWP_PS_MEM_2 11253 CONFIG.C_WR_REC_TIME_MEM_0 26905 CONFIG.C_WR_REC_TIME_MEM_1 24684 CONFIG.C_WR_REC_TIME_MEM_2 29655 " [get_bd_cells ip_22_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_22_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_22_emc/EMC_INTF] [get_bd_intf_pins ip_22_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_22_emc/clk
connect_bd_net [get_bd_pins ip_22_emc/clk] [get_bd_pins ip_22_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_emc/rdclk
connect_bd_net [get_bd_pins ip_22_emc/rdclk] [get_bd_pins ip_22_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_emc/rst
connect_bd_net [get_bd_pins ip_22_emc/rst] [get_bd_pins ip_22_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_22_emc/AXI] [get_bd_intf_pins ip_22_emc/emc_0/S_AXI_MEM]


########## gpio ##########
create_bd_cell -type hier ip_23_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_23_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x3ffffff CONFIG.C_DOUT_DEFAULT_2 0xf413c7 CONFIG.C_GPIO2_WIDTH 6 CONFIG.C_GPIO_WIDTH 26 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x3ffffff CONFIG.C_TRI_DEFAULT_2 0x3ffffff " [get_bd_cells ip_23_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_23_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_23_gpio/GPIO] [get_bd_intf_pins ip_23_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_23_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_23_gpio/GPIO2] [get_bd_intf_pins ip_23_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_23_gpio/clk
connect_bd_net [get_bd_pins ip_23_gpio/clk] [get_bd_pins ip_23_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_gpio/rst
connect_bd_net [get_bd_pins ip_23_gpio/rst] [get_bd_pins ip_23_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_23_gpio/AXI] [get_bd_intf_pins ip_23_gpio/gpio_0/S_AXI]


########## emc ##########
create_bd_cell -type hier ip_24_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_24_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 16 CONFIG.C_TAVDV_PS_MEM_0 15957 CONFIG.C_TCEDV_PS_MEM_0 15835 CONFIG.C_THZCE_PS_MEM_0 7585 CONFIG.C_THZOE_PS_MEM_0 6523 CONFIG.C_TLZWE_PS_MEM_0 6169 CONFIG.C_TWC_PS_MEM_0 14739 CONFIG.C_TWPH_PS_MEM_0 10925 CONFIG.C_TWP_PS_MEM_0 11377 CONFIG.C_WR_REC_TIME_MEM_0 28977 " [get_bd_cells ip_24_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_24_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_24_emc/EMC_INTF] [get_bd_intf_pins ip_24_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_24_emc/clk
connect_bd_net [get_bd_pins ip_24_emc/clk] [get_bd_pins ip_24_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_emc/rdclk
connect_bd_net [get_bd_pins ip_24_emc/rdclk] [get_bd_pins ip_24_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_emc/rst
connect_bd_net [get_bd_pins ip_24_emc/rst] [get_bd_pins ip_24_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_24_emc/AXI] [get_bd_intf_pins ip_24_emc/emc_0/S_AXI_MEM]


########## axi_iic ##########
create_bd_cell -type hier ip_25_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_25_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x75 CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 194 CONFIG.C_SDA_INERTIAL_DELAY 136 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 721.4215377643835 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_25_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_25_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic/IIC] [get_bd_intf_pins ip_25_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_iic/clk
connect_bd_net [get_bd_pins ip_25_axi_iic/clk] [get_bd_pins ip_25_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axi_iic/reset
connect_bd_net [get_bd_pins ip_25_axi_iic/reset] [get_bd_pins ip_25_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic/AXI] [get_bd_intf_pins ip_25_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_25_axi_iic/irq
connect_bd_net [get_bd_pins ip_25_axi_iic/irq] [get_bd_pins ip_25_axi_iic/axi_iic_0/iic2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_26_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_26_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 2 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 2 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 2 CONFIG.C_TAVDV_PS_MEM_0 15881 CONFIG.C_TAVDV_PS_MEM_1 13769 CONFIG.C_TAVDV_PS_MEM_2 15704 CONFIG.C_TAVDV_PS_MEM_3 13621 CONFIG.C_TCEDV_PS_MEM_0 16193 CONFIG.C_TCEDV_PS_MEM_1 14538 CONFIG.C_TCEDV_PS_MEM_2 14123 CONFIG.C_TCEDV_PS_MEM_3 16344 CONFIG.C_THZCE_PS_MEM_0 7056 CONFIG.C_THZCE_PS_MEM_1 6987 CONFIG.C_THZCE_PS_MEM_2 6784 CONFIG.C_THZCE_PS_MEM_3 7584 CONFIG.C_THZOE_PS_MEM_0 6447 CONFIG.C_THZOE_PS_MEM_1 7544 CONFIG.C_THZOE_PS_MEM_2 7623 CONFIG.C_THZOE_PS_MEM_3 7437 CONFIG.C_TLZWE_PS_MEM_0 1687 CONFIG.C_TLZWE_PS_MEM_1 2152 CONFIG.C_TLZWE_PS_MEM_2 3844 CONFIG.C_TLZWE_PS_MEM_3 7803 CONFIG.C_TWC_PS_MEM_0 13630 CONFIG.C_TWC_PS_MEM_1 16402 CONFIG.C_TWC_PS_MEM_2 14859 CONFIG.C_TWC_PS_MEM_3 13601 CONFIG.C_TWPH_PS_MEM_0 11325 CONFIG.C_TWPH_PS_MEM_1 11553 CONFIG.C_TWPH_PS_MEM_2 11976 CONFIG.C_TWPH_PS_MEM_3 13199 CONFIG.C_TWP_PS_MEM_0 12648 CONFIG.C_TWP_PS_MEM_1 12705 CONFIG.C_TWP_PS_MEM_2 11945 CONFIG.C_TWP_PS_MEM_3 12925 CONFIG.C_WR_REC_TIME_MEM_0 26330 CONFIG.C_WR_REC_TIME_MEM_1 27393 CONFIG.C_WR_REC_TIME_MEM_2 25312 CONFIG.C_WR_REC_TIME_MEM_3 26578 " [get_bd_cells ip_26_emc/emc_0]
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
set_property -dict "CONFIG.NUM_PORTS 15 " [get_bd_cells ip_29_intc/concat_0]
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
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_10
connect_bd_net [get_bd_pins ip_29_intc/irq_10] [get_bd_pins ip_29_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_11
connect_bd_net [get_bd_pins ip_29_intc/irq_11] [get_bd_pins ip_29_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_12
connect_bd_net [get_bd_pins ip_29_intc/irq_12] [get_bd_pins ip_29_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_13
connect_bd_net [get_bd_pins ip_29_intc/irq_13] [get_bd_pins ip_29_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_14
connect_bd_net [get_bd_pins ip_29_intc/irq_14] [get_bd_pins ip_29_intc/concat_0/In14]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_29_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_29_intc/irq] [get_bd_intf_pins ip_29_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_30_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_30_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 2 " [get_bd_cells ip_30_axi/axi_0]
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


########## axi ##########
create_bd_cell -type hier ip_31_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_31_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_31_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi/clk
connect_bd_net [get_bd_pins ip_31_axi/clk] [get_bd_pins ip_31_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi/reset
connect_bd_net [get_bd_pins ip_31_axi/reset] [get_bd_pins ip_31_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_M0] [get_bd_intf_pins ip_31_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S0] [get_bd_intf_pins ip_31_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S1] [get_bd_intf_pins ip_31_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S2] [get_bd_intf_pins ip_31_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S3] [get_bd_intf_pins ip_31_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S4] [get_bd_intf_pins ip_31_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S5] [get_bd_intf_pins ip_31_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S6] [get_bd_intf_pins ip_31_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S7] [get_bd_intf_pins ip_31_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S8] [get_bd_intf_pins ip_31_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S9] [get_bd_intf_pins ip_31_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S10] [get_bd_intf_pins ip_31_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S11] [get_bd_intf_pins ip_31_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S12] [get_bd_intf_pins ip_31_axi/axi_0/M12_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S13] [get_bd_intf_pins ip_31_axi/axi_0/M13_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S14] [get_bd_intf_pins ip_31_axi/axi_0/M14_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_31_axi/AXI_S15] [get_bd_intf_pins ip_31_axi/axi_0/M15_AXI]


########## axi ##########
create_bd_cell -type hier ip_32_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_32_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 1 " [get_bd_cells ip_32_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axi/clk
connect_bd_net [get_bd_pins ip_32_axi/clk] [get_bd_pins ip_32_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axi/reset
connect_bd_net [get_bd_pins ip_32_axi/reset] [get_bd_pins ip_32_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M0] [get_bd_intf_pins ip_32_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S0] [get_bd_intf_pins ip_32_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S1] [get_bd_intf_pins ip_32_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S2] [get_bd_intf_pins ip_32_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S3] [get_bd_intf_pins ip_32_axi/axi_0/M03_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_33_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_33_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_33_axis_broadcaster/axis_broadcaster_0]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_34_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_34_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_34_axis_broadcaster/axis_broadcaster_0]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_35_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_35_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_35_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_36_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_36_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_36_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_36_axis_dwidth_converter/aclk] [get_bd_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_36_axis_dwidth_converter/aresetn] [get_bd_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_37_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_37_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_37_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aclk] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aresetn] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_38_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_38_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 44 " [get_bd_cells ip_38_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_40_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aclk] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aresetn] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_43_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_43_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_43_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 7 -to 0 ip_43_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_1] [get_bd_pins ip_43_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 7 -to 0 ip_43_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_43_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_2] [get_bd_pins ip_43_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/slice_2/dout] [get_bd_pins ip_43_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_44_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_44_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 7 -to 0 ip_44_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_44_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_44_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/slice_0/dout] [get_bd_pins ip_44_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_44_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_44_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_1] [get_bd_pins ip_44_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/slice_1/dout] [get_bd_pins ip_44_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_45_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_45_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_45_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_45_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_45_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/slice_0/dout] [get_bd_pins ip_45_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_1] [get_bd_pins ip_45_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_2] [get_bd_pins ip_45_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_3] [get_bd_pins ip_45_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_4] [get_bd_pins ip_45_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_5] [get_bd_pins ip_45_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 29 -to 0 ip_46_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_46_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 30 " [get_bd_cells ip_46_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_46_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 23 -to 0 ip_47_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_47_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_47_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 29 -to 0 ip_47_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_47_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 30 " [get_bd_cells ip_47_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_47_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/slice_0/dout] [get_bd_pins ip_47_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_47_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_1] [get_bd_pins ip_47_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_47_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_2] [get_bd_pins ip_47_slice_and_concat/concat/In2]


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
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_27_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_28_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic_IIC] [get_bd_intf_pins ip_0_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_1_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite_MII] [get_bd_intf_pins ip_1_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_1_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_1_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite_UART] [get_bd_intf_pins ip_2_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_4_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite_UART] [get_bd_intf_pins ip_4_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_6_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic_IIC] [get_bd_intf_pins ip_6_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_8_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap_ICAP] [get_bd_intf_pins ip_8_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_8_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_8_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_9_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_ethernet_lite_MII] [get_bd_intf_pins ip_9_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_15_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite_MII] [get_bd_intf_pins ip_15_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_15_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_15_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_16_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_iic_IIC] [get_bd_intf_pins ip_16_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_17_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_17_gpio_GPIO] [get_bd_intf_pins ip_17_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_19_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_19_uartlite_UART] [get_bd_intf_pins ip_19_uartlite/UART]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_21_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_21_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_21_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_22_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_22_emc_EMC_INTF] [get_bd_intf_pins ip_22_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_23_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_23_gpio_GPIO] [get_bd_intf_pins ip_23_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_23_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_23_gpio_GPIO2] [get_bd_intf_pins ip_23_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_24_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_24_emc_EMC_INTF] [get_bd_intf_pins ip_24_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_25_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic_IIC] [get_bd_intf_pins ip_25_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_26_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_26_emc_EMC_INTF] [get_bd_intf_pins ip_26_emc/EMC_INTF]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 23 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_47_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_28_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_29_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_iic/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_2_uartlite/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_4_uartlite/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_iic/reset]
connect_bd_net [get_bd_pins ip_27_reset/mb_reset] [get_bd_pins ip_7_microblaze/Reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_16_axi_iic/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_17_gpio/rst]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_19_uartlite/reset]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_20_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_22_emc/rst]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_23_gpio/rst]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_24_emc/rst]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_25_axi_iic/reset]
connect_bd_net [get_bd_pins ip_27_reset/peripheral_areset_n] [get_bd_pins ip_26_emc/rst]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_0_axi_iic/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_1_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_2_uartlite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_3_fft/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_4_uartlite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_6_axi_iic/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_7_microblaze/Clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_8_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_8_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_9_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_10_cordic/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_11_dft/CLK]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_12_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_13_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_14_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_15_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_16_axi_iic/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_17_gpio/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_18_accumulator/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_19_uartlite/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_20_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_21_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_22_emc/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_22_emc/rdclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_23_gpio/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_24_emc/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_24_emc/rdclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_25_axi_iic/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_26_emc/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_26_emc/rdclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_27_reset/clk_in]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_locked] [get_bd_pins ip_27_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_29_intc/irq_0] [get_bd_pins ip_0_axi_iic/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_1] [get_bd_pins ip_1_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_2] [get_bd_pins ip_2_uartlite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_3] [get_bd_pins ip_3_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_29_intc/irq_4] [get_bd_pins ip_4_uartlite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_5] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_6] [get_bd_pins ip_6_axi_iic/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_7] [get_bd_pins ip_8_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_29_intc/irq_8] [get_bd_pins ip_9_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_9] [get_bd_pins ip_12_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_29_intc/irq_10] [get_bd_pins ip_13_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_29_intc/irq_11] [get_bd_pins ip_15_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_12] [get_bd_pins ip_16_axi_iic/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_13] [get_bd_pins ip_19_uartlite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_14] [get_bd_pins ip_25_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_microblaze/INTERRUPT] [get_bd_intf_pins ip_29_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_microblaze/M_AXI_DP] [get_bd_intf_pins ip_30_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_30_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axi/AXI_S0] [get_bd_intf_pins ip_31_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_31_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_31_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_31_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_uartlite/AXI] [get_bd_intf_pins ip_31_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_31_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_iic/AXI] [get_bd_intf_pins ip_31_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_31_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_31_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_timer/S_AXI] [get_bd_intf_pins ip_31_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_31_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_31_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_iic/AXI] [get_bd_intf_pins ip_31_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_gpio/AXI] [get_bd_intf_pins ip_31_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_uartlite/AXI] [get_bd_intf_pins ip_31_axi/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_emc/AXI] [get_bd_intf_pins ip_31_axi/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_gpio/AXI] [get_bd_intf_pins ip_31_axi/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axi/AXI_S1] [get_bd_intf_pins ip_32_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_emc/AXI] [get_bd_intf_pins ip_32_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axi_iic/AXI] [get_bd_intf_pins ip_32_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_emc/AXI] [get_bd_intf_pins ip_32_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_intc/AXI] [get_bd_intf_pins ip_32_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_10_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_18_accumulator/B]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_11_dft/RFFD]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_1] [get_bd_pins ip_11_dft/XK_RE]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_2] [get_bd_pins ip_11_dft/XK_IM]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_11_dft/SIZE]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_11_dft/XK_IM]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_1] [get_bd_pins ip_11_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_11_dft/XN_RE]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_11_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_1] [get_bd_pins ip_11_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_2] [get_bd_pins ip_11_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_3] [get_bd_pins ip_12_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_4] [get_bd_pins ip_12_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_5] [get_bd_pins ip_12_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_11_dft/XN_IM]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_18_accumulator/Q]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_18_accumulator/Q]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_1] [get_bd_pins ip_21_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_2] [get_bd_pins ip_21_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_8_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_21_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_18_accumulator/CE]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_14_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_21_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_20_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_21_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_12_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_21_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_11_dft/FD_IN]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_21_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_11_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_21_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_12_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_21_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_21_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_21_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_30_axi/reset]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_31_axi/reset]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_32_axi/reset]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_29_intc/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_30_axi/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_31_axi/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_32_axi/clk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_33_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_34_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_35_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_36_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_37_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_38_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_28_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 44 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=44 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=44 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_cordic/S_AXIS_CARTESIAN declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_cordic/S_AXIS_CARTESIAN declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/M_AXIS_DOUT declared=96 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=352 actual=ERR $__err" }
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
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }


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
