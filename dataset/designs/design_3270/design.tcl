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



########## conv_encoder ##########
create_bd_cell -type hier ip_0_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_0_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 7 CONFIG.convolution_code0 117 CONFIG.convolution_code1 125 CONFIG.convolution_code2 68 CONFIG.convolution_code3 79 CONFIG.convolution_code4 63 CONFIG.convolution_code5 21 CONFIG.convolution_code6 29 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 4 CONFIG.output_rate 5 CONFIG.puncture_code0 1011 CONFIG.puncture_code1 0101 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_0_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_0_conv_encoder/aclk] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_0_conv_encoder/aclken] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_0_conv_encoder/aresetn] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## complex_multiplier ##########
create_bd_cell -type hier ip_1_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_1_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 16 CONFIG.aresetn 0 CONFIG.bportwidth 53 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Performance CONFIG.outputwidth 67 CONFIG.outtlastbehv AND_all_TLASTs CONFIG.roundmode Truncate " [get_bd_cells ip_1_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aclk] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_2_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_2_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_2_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_2_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/MII] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_2_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/clk] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/reset] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_2_axi_ethernet_lite/irq] [get_bd_pins ip_2_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## microblaze ##########
create_bd_cell -type hier ip_3_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 36 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 5 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_NUMBER_OF_PC_BRK 4 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 2 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 1 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_3_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_microblaze/Clk
connect_bd_net [get_bd_pins ip_3_microblaze/Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_3_microblaze/Reset
connect_bd_net [get_bd_pins ip_3_microblaze/Reset] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_3_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/INTERRUPT] [get_bd_intf_pins ip_3_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/M_AXI_DP] [get_bd_intf_pins ip_3_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_3_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_3_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x3cba139ef2d5b98 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_3_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_3_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_3_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_3_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x2c38ced7eef0cf8 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_3_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_3_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_3_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_3_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_3_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 3 " [get_bd_cells ip_3_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_3_microblaze/microblaze_0/DEBUG]


########## fft ##########
create_bd_cell -type hier ip_4_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_4_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 8 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 32 " [get_bd_cells ip_4_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_fft/aclk
connect_bd_net [get_bd_pins ip_4_fft/aclk] [get_bd_pins ip_4_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_4_fft/event_frame_started
connect_bd_net [get_bd_pins ip_4_fft/event_frame_started] [get_bd_pins ip_4_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_fft/S_AXIS_DATA] [get_bd_intf_pins ip_4_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_fft/M_AXIS_DATA] [get_bd_intf_pins ip_4_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_4_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_4_fft/fft_0/S_AXIS_CONFIG]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 8 CONFIG.PARITY No_Parity " [get_bd_cells ip_5_uartlite/uart_0]
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


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_6_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_6_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_6_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_6_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/clk] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/reset] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_6_axi_ethernet_lite/irq] [get_bd_pins ip_6_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_7_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_7_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 10 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x0 " [get_bd_cells ip_7_gpio/gpio_0]
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


########## axi_dma ##########
create_bd_cell -type hier ip_8_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_8_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 57 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 32 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_8_axi_dma/axi_dma_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_9_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_9_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Double CONFIG.add_sub_value Add CONFIG.b_tuser_width 82 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage Full_Usage CONFIG.c_optimization Low_Latency CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 1 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Add_Subtract CONFIG.result_tlast_behv Pass_B_TLAST " [get_bd_cells ip_9_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_floating_point/aclk
connect_bd_net [get_bd_pins ip_9_floating_point/aclk] [get_bd_pins ip_9_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_floating_point/aclken
connect_bd_net [get_bd_pins ip_9_floating_point/aclken] [get_bd_pins ip_9_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_9_floating_point/aresetn
connect_bd_net [get_bd_pins ip_9_floating_point/aresetn] [get_bd_pins ip_9_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_9_floating_point/S_AXIS_A] [get_bd_intf_pins ip_9_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_9_floating_point/S_AXIS_B] [get_bd_intf_pins ip_9_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_9_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_9_floating_point/floating_point_0/M_AXIS_RESULT]


########## dft ##########
create_bd_cell -type hier ip_10_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_10_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 11 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_10_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/CLK
connect_bd_net [get_bd_pins ip_10_dft/CLK] [get_bd_pins ip_10_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/SCLR
connect_bd_net [get_bd_pins ip_10_dft/SCLR] [get_bd_pins ip_10_dft/dft_0/SCLR]
create_bd_pin -dir I -from 10 -to 0 ip_10_dft/XN_RE
connect_bd_net [get_bd_pins ip_10_dft/XN_RE] [get_bd_pins ip_10_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 10 -to 0 ip_10_dft/XN_IM
connect_bd_net [get_bd_pins ip_10_dft/XN_IM] [get_bd_pins ip_10_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/FD_IN
connect_bd_net [get_bd_pins ip_10_dft/FD_IN] [get_bd_pins ip_10_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/FWD_INV
connect_bd_net [get_bd_pins ip_10_dft/FWD_INV] [get_bd_pins ip_10_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_10_dft/SIZE
connect_bd_net [get_bd_pins ip_10_dft/SIZE] [get_bd_pins ip_10_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/RFFD
connect_bd_net [get_bd_pins ip_10_dft/RFFD] [get_bd_pins ip_10_dft/dft_0/RFFD]
create_bd_pin -dir O -from 10 -to 0 ip_10_dft/XK_RE
connect_bd_net [get_bd_pins ip_10_dft/XK_RE] [get_bd_pins ip_10_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 10 -to 0 ip_10_dft/XK_IM
connect_bd_net [get_bd_pins ip_10_dft/XK_IM] [get_bd_pins ip_10_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_10_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_10_dft/BLK_EXP] [get_bd_pins ip_10_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/FD_OUT
connect_bd_net [get_bd_pins ip_10_dft/FD_OUT] [get_bd_pins ip_10_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_10_dft/DATA_VALID] [get_bd_pins ip_10_dft/dft_0/DATA_VALID]


########## xadc_wiz ##########
create_bd_cell -type hier ip_11_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_11_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING None CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST false CONFIG.ENABLE_TEMP_BUS 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_11_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_11_xadc_wiz/s_axi_aclk] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_11_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/convstclk_in
connect_bd_net [get_bd_pins ip_11_xadc_wiz/convstclk_in] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/convstclk_in]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_11_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
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


########## dft ##########
create_bd_cell -type hier ip_12_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_12_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 9 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_12_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_dft/CLK
connect_bd_net [get_bd_pins ip_12_dft/CLK] [get_bd_pins ip_12_dft/dft_0/CLK]
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


########## axi_iic ##########
create_bd_cell -type hier ip_13_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_13_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x19 CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 100 CONFIG.C_SDA_INERTIAL_DELAY 117 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 951.5387698700888 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_13_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_13_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_iic/IIC] [get_bd_intf_pins ip_13_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_iic/clk
connect_bd_net [get_bd_pins ip_13_axi_iic/clk] [get_bd_pins ip_13_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_iic/reset
connect_bd_net [get_bd_pins ip_13_axi_iic/reset] [get_bd_pins ip_13_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_iic/AXI] [get_bd_intf_pins ip_13_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_iic/irq
connect_bd_net [get_bd_pins ip_13_axi_iic/irq] [get_bd_pins ip_13_axi_iic/axi_iic_0/iic2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_14_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_14_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 7 CONFIG.C_TAVDV_PS_MEM_0 15105 CONFIG.C_TAVDV_PS_MEM_1 15754 CONFIG.C_TCEDV_PS_MEM_0 15784 CONFIG.C_TCEDV_PS_MEM_1 13653 CONFIG.C_THZCE_PS_MEM_0 6516 CONFIG.C_THZCE_PS_MEM_1 6782 CONFIG.C_THZOE_PS_MEM_0 7047 CONFIG.C_THZOE_PS_MEM_1 7165 CONFIG.C_TLZWE_PS_MEM_0 9006 CONFIG.C_TLZWE_PS_MEM_1 5238 CONFIG.C_TWC_PS_MEM_0 15843 CONFIG.C_TWC_PS_MEM_1 15622 CONFIG.C_TWPH_PS_MEM_0 11996 CONFIG.C_TWPH_PS_MEM_1 11369 CONFIG.C_TWP_PS_MEM_0 11044 CONFIG.C_TWP_PS_MEM_1 11289 CONFIG.C_WR_REC_TIME_MEM_0 27665 CONFIG.C_WR_REC_TIME_MEM_1 29392 " [get_bd_cells ip_14_emc/emc_0]
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


########## uartlite ##########
create_bd_cell -type hier ip_15_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_15_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 1200 CONFIG.C_DATA_BITS 8 CONFIG.PARITY No_Parity " [get_bd_cells ip_15_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_15_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_15_uartlite/UART] [get_bd_intf_pins ip_15_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_15_uartlite/clk
connect_bd_net [get_bd_pins ip_15_uartlite/clk] [get_bd_pins ip_15_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_uartlite/reset
connect_bd_net [get_bd_pins ip_15_uartlite/reset] [get_bd_pins ip_15_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_uartlite/AXI] [get_bd_intf_pins ip_15_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_15_uartlite/irq
connect_bd_net [get_bd_pins ip_15_uartlite/irq] [get_bd_pins ip_15_uartlite/uart_0/interrupt]


########## floating_point ##########
create_bd_cell -type hier ip_16_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_16_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Performance CONFIG.b_tuser_width 22 CONFIG.c_a_exponent_width 5 CONFIG.c_a_fraction_width 11 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.c_optimization Speed_Optimized CONFIG.flow_control Blocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 1 CONFIG.has_b_tuser 1 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 1 CONFIG.has_operation_tuser 1 CONFIG.has_result_tready 1 CONFIG.maximum_latency 1 CONFIG.operation_tuser_width 13 CONFIG.operation_type Add_Subtract CONFIG.result_tlast_behv Pass_B_TLAST " [get_bd_cells ip_16_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_floating_point/aclk
connect_bd_net [get_bd_pins ip_16_floating_point/aclk] [get_bd_pins ip_16_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_floating_point/aresetn
connect_bd_net [get_bd_pins ip_16_floating_point/aresetn] [get_bd_pins ip_16_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_16_floating_point/S_AXIS_A] [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_16_floating_point/S_AXIS_B] [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_floating_point/S_AXIS_OPERATION
connect_bd_intf_net [get_bd_intf_pins ip_16_floating_point/S_AXIS_OPERATION] [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_OPERATION]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_16_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_16_floating_point/floating_point_0/M_AXIS_RESULT]


########## accumulator ##########
create_bd_cell -type hier ip_17_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_17_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 19 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 24 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_17_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_accumulator/clk
connect_bd_net [get_bd_pins ip_17_accumulator/clk] [get_bd_pins ip_17_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 18 -to 0 ip_17_accumulator/B
connect_bd_net [get_bd_pins ip_17_accumulator/B] [get_bd_pins ip_17_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 23 -to 0 ip_17_accumulator/Q
connect_bd_net [get_bd_pins ip_17_accumulator/Q] [get_bd_pins ip_17_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_17_accumulator/ADD
connect_bd_net [get_bd_pins ip_17_accumulator/ADD] [get_bd_pins ip_17_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_17_accumulator/SCLR
connect_bd_net [get_bd_pins ip_17_accumulator/SCLR] [get_bd_pins ip_17_accumulator/accumulator_0/SCLR]


########## microblaze ##########
create_bd_cell -type hier ip_18_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_18_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 52 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 7 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_OPCODE_0x0_ILLEGAL 1 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0x18 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_18_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_microblaze/Clk
connect_bd_net [get_bd_pins ip_18_microblaze/Clk] [get_bd_pins ip_18_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_18_microblaze/Reset
connect_bd_net [get_bd_pins ip_18_microblaze/Reset] [get_bd_pins ip_18_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_18_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_18_microblaze/INTERRUPT] [get_bd_intf_pins ip_18_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_18_microblaze/M_AXI_DP] [get_bd_intf_pins ip_18_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_18_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_18_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_18_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_18_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_18_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_18_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_18_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_18_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_18_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x5cbd084b6532f7c CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_18_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_18_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_18_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_18_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_18_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_18_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_18_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_18_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_18_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_18_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_18_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_18_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_18_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_18_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_18_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_18_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x9df667601594034 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_18_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_18_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_18_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_18_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_18_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_18_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_18_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_18_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_18_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_18_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_18_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_18_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_18_microblaze/mem/BRAM_PORTB]


########## axi_iic ##########
create_bd_cell -type hier ip_19_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_19_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x76 CONFIG.C_GPO_WIDTH 5 CONFIG.C_SCL_INERTIAL_DELAY 156 CONFIG.C_SDA_INERTIAL_DELAY 164 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 521.0180526782185 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_19_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_19_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_iic/IIC] [get_bd_intf_pins ip_19_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_iic/clk
connect_bd_net [get_bd_pins ip_19_axi_iic/clk] [get_bd_pins ip_19_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_iic/reset
connect_bd_net [get_bd_pins ip_19_axi_iic/reset] [get_bd_pins ip_19_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_iic/AXI] [get_bd_intf_pins ip_19_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_19_axi_iic/irq
connect_bd_net [get_bd_pins ip_19_axi_iic/irq] [get_bd_pins ip_19_axi_iic/axi_iic_0/iic2intc_irpt]


########## reset ##########
create_bd_cell -type hier ip_20_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_20_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_reset/clk_in
connect_bd_net [get_bd_pins ip_20_reset/clk_in] [get_bd_pins ip_20_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_20_reset/reset_in
connect_bd_net [get_bd_pins ip_20_reset/reset_in] [get_bd_pins ip_20_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_20_reset/dcm_locked
connect_bd_net [get_bd_pins ip_20_reset/dcm_locked] [get_bd_pins ip_20_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_20_reset/mb_reset
connect_bd_net [get_bd_pins ip_20_reset/mb_reset] [get_bd_pins ip_20_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_20_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_20_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_20_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset] [get_bd_pins ip_20_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_20_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_20_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_21_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_21_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_in] [get_bd_pins ip_21_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_21_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_21_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_21_clk_wiz/reset
connect_bd_net [get_bd_pins ip_21_clk_wiz/reset] [get_bd_pins ip_21_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_21_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_locked] [get_bd_pins ip_21_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_22_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_22_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_22_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 10 " [get_bd_cells ip_22_intc/concat_0]
connect_bd_net [get_bd_pins ip_22_intc/concat_0/dout] [get_bd_pins ip_22_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/clk
connect_bd_net [get_bd_pins ip_22_intc/clk] [get_bd_pins ip_22_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/reset
connect_bd_net [get_bd_pins ip_22_intc/reset] [get_bd_pins ip_22_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_22_intc/AXI] [get_bd_intf_pins ip_22_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_0
connect_bd_net [get_bd_pins ip_22_intc/irq_0] [get_bd_pins ip_22_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_1
connect_bd_net [get_bd_pins ip_22_intc/irq_1] [get_bd_pins ip_22_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_2
connect_bd_net [get_bd_pins ip_22_intc/irq_2] [get_bd_pins ip_22_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_3
connect_bd_net [get_bd_pins ip_22_intc/irq_3] [get_bd_pins ip_22_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_4
connect_bd_net [get_bd_pins ip_22_intc/irq_4] [get_bd_pins ip_22_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_5
connect_bd_net [get_bd_pins ip_22_intc/irq_5] [get_bd_pins ip_22_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_6
connect_bd_net [get_bd_pins ip_22_intc/irq_6] [get_bd_pins ip_22_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_7
connect_bd_net [get_bd_pins ip_22_intc/irq_7] [get_bd_pins ip_22_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_8
connect_bd_net [get_bd_pins ip_22_intc/irq_8] [get_bd_pins ip_22_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_9
connect_bd_net [get_bd_pins ip_22_intc/irq_9] [get_bd_pins ip_22_intc/concat_0/In9]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_22_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_22_intc/irq] [get_bd_intf_pins ip_22_intc/intc_0/interrupt]


########## intc ##########
create_bd_cell -type hier ip_23_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_23_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_23_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 10 " [get_bd_cells ip_23_intc/concat_0]
connect_bd_net [get_bd_pins ip_23_intc/concat_0/dout] [get_bd_pins ip_23_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/clk
connect_bd_net [get_bd_pins ip_23_intc/clk] [get_bd_pins ip_23_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/reset
connect_bd_net [get_bd_pins ip_23_intc/reset] [get_bd_pins ip_23_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_23_intc/AXI] [get_bd_intf_pins ip_23_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_0
connect_bd_net [get_bd_pins ip_23_intc/irq_0] [get_bd_pins ip_23_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_1
connect_bd_net [get_bd_pins ip_23_intc/irq_1] [get_bd_pins ip_23_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_2
connect_bd_net [get_bd_pins ip_23_intc/irq_2] [get_bd_pins ip_23_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_3
connect_bd_net [get_bd_pins ip_23_intc/irq_3] [get_bd_pins ip_23_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_4
connect_bd_net [get_bd_pins ip_23_intc/irq_4] [get_bd_pins ip_23_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_5
connect_bd_net [get_bd_pins ip_23_intc/irq_5] [get_bd_pins ip_23_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_6
connect_bd_net [get_bd_pins ip_23_intc/irq_6] [get_bd_pins ip_23_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_7
connect_bd_net [get_bd_pins ip_23_intc/irq_7] [get_bd_pins ip_23_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_8
connect_bd_net [get_bd_pins ip_23_intc/irq_8] [get_bd_pins ip_23_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_23_intc/irq_9
connect_bd_net [get_bd_pins ip_23_intc/irq_9] [get_bd_pins ip_23_intc/concat_0/In9]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_23_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_23_intc/irq] [get_bd_intf_pins ip_23_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_24_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_24_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 11 CONFIG.NUM_SI 4 " [get_bd_cells ip_24_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi/clk
connect_bd_net [get_bd_pins ip_24_axi/clk] [get_bd_pins ip_24_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi/reset
connect_bd_net [get_bd_pins ip_24_axi/reset] [get_bd_pins ip_24_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M0] [get_bd_intf_pins ip_24_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M1] [get_bd_intf_pins ip_24_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M2] [get_bd_intf_pins ip_24_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_M3] [get_bd_intf_pins ip_24_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S0] [get_bd_intf_pins ip_24_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S1] [get_bd_intf_pins ip_24_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S2] [get_bd_intf_pins ip_24_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S3] [get_bd_intf_pins ip_24_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S4] [get_bd_intf_pins ip_24_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S5] [get_bd_intf_pins ip_24_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S6] [get_bd_intf_pins ip_24_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S7] [get_bd_intf_pins ip_24_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S8] [get_bd_intf_pins ip_24_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S9] [get_bd_intf_pins ip_24_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_24_axi/AXI_S10] [get_bd_intf_pins ip_24_axi/axi_0/M10_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_25_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_25_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_25_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_27_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_27_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_27_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_27_axis_broadcaster/aclk] [get_bd_pins ip_27_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_27_axis_broadcaster/aresetn] [get_bd_pins ip_27_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_28_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_28_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_28_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_28_axis_broadcaster/aclk] [get_bd_pins ip_28_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_28_axis_broadcaster/aresetn] [get_bd_pins ip_28_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_29_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_29_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_29_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 32 " [get_bd_cells ip_33_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aclk] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_33_axis_dwidth_converter/aresetn] [get_bd_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_34_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_34_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_34_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aclk] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_34_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_34_axis_dwidth_converter/aresetn] [get_bd_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_35_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_35_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_35_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_35_axis_dwidth_converter/aclk] [get_bd_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_35_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_35_axis_dwidth_converter/aresetn] [get_bd_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_36_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_36_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_36_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_37_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aclk] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aresetn] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_38_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_38_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_38_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 10 -to 0 ip_38_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_38_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_38_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_1] [get_bd_pins ip_38_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/slice_1/dout] [get_bd_pins ip_38_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_39_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_39_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 10 -to 0 ip_39_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_39_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_39_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/slice_0/dout] [get_bd_pins ip_39_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 10 -to 0 ip_39_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_39_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_39_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_1] [get_bd_pins ip_39_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/slice_1/dout] [get_bd_pins ip_39_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 18 -to 0 ip_40_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 9 " [get_bd_cells ip_40_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 10 -to 0 ip_40_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_40_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_40_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/slice_0/dout] [get_bd_pins ip_40_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_40_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_1] [get_bd_pins ip_40_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_2] [get_bd_pins ip_40_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_3] [get_bd_pins ip_40_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_4] [get_bd_pins ip_40_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_5] [get_bd_pins ip_40_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_6] [get_bd_pins ip_40_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_7] [get_bd_pins ip_40_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 8 -to 0 ip_40_slice_and_concat/in_8
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_40_slice_and_concat] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_40_slice_and_concat/slice_8]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_8] [get_bd_pins ip_40_slice_and_concat/slice_8/din]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/slice_8/dout] [get_bd_pins ip_40_slice_and_concat/concat/In8]


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_41_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_41_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_41_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_41_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_41_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/slice_0/dout] [get_bd_pins ip_41_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 8 -to 0 ip_41_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_41_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_41_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_41_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/slice_1/dout] [get_bd_pins ip_41_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_42_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_42_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 8 -to 0 ip_42_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_42_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 9 " [get_bd_cells ip_42_slice_and_concat/slice_0]
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
create_bd_pin -dir O -from 5 -to 0 ip_43_slice_and_concat/out0
create_bd_pin -dir I -from 23 -to 0 ip_43_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 24 " [get_bd_cells ip_43_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_43_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 23 -to 0 ip_44_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_44_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 24 " [get_bd_cells ip_44_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_44_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 8 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 23 -to 0 ip_45_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 15 CONFIG.DIN_WIDTH 24 " [get_bd_cells ip_45_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_45_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/slice_0/dout]


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

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_21_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_2_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite_MII] [get_bd_intf_pins ip_2_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_2_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_2_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_6_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite_MII] [get_bd_intf_pins ip_6_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_6_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_6_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_7_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_7_gpio_GPIO] [get_bd_intf_pins ip_7_gpio/GPIO]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_11_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_11_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_11_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_13_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_iic_IIC] [get_bd_intf_pins ip_13_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_14_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_14_emc_EMC_INTF] [get_bd_intf_pins ip_14_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_15_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_15_uartlite_UART] [get_bd_intf_pins ip_15_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_19_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_iic_IIC] [get_bd_intf_pins ip_19_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 9 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_38_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_53_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_21_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_22_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_23_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_0_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_20_reset/mb_reset] [get_bd_pins ip_3_microblaze/Reset]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_7_gpio/rst]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_9_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset] [get_bd_pins ip_10_dft/SCLR]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_11_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset] [get_bd_pins ip_12_dft/SCLR]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_iic/reset]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_14_emc/rst]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_15_uartlite/reset]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_16_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/mb_reset] [get_bd_pins ip_18_microblaze/Reset]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_19_axi_iic/reset]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_0_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_1_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_2_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_3_microblaze/Clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_4_fft/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_6_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_7_gpio/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_9_floating_point/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_10_dft/CLK]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_11_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_11_xadc_wiz/convstclk_in]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_12_dft/CLK]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_13_axi_iic/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_14_emc/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_14_emc/rdclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_15_uartlite/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_16_floating_point/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_17_accumulator/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_18_microblaze/Clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_19_axi_iic/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_20_reset/clk_in]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_locked] [get_bd_pins ip_20_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_22_intc/irq_0] [get_bd_pins ip_2_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_22_intc/irq_1] [get_bd_pins ip_4_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_22_intc/irq_2] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_22_intc/irq_3] [get_bd_pins ip_6_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_22_intc/irq_4] [get_bd_pins ip_7_gpio/irq]
connect_bd_net [get_bd_pins ip_22_intc/irq_5] [get_bd_pins ip_8_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_22_intc/irq_6] [get_bd_pins ip_11_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_22_intc/irq_7] [get_bd_pins ip_13_axi_iic/irq]
connect_bd_net [get_bd_pins ip_22_intc/irq_8] [get_bd_pins ip_15_uartlite/irq]
connect_bd_net [get_bd_pins ip_22_intc/irq_9] [get_bd_pins ip_19_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_microblaze/INTERRUPT] [get_bd_intf_pins ip_22_intc/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_0] [get_bd_pins ip_2_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_1] [get_bd_pins ip_4_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_23_intc/irq_2] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_3] [get_bd_pins ip_6_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_4] [get_bd_pins ip_7_gpio/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_5] [get_bd_pins ip_8_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_23_intc/irq_6] [get_bd_pins ip_11_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_23_intc/irq_7] [get_bd_pins ip_13_axi_iic/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_8] [get_bd_pins ip_15_uartlite/irq]
connect_bd_net [get_bd_pins ip_23_intc/irq_9] [get_bd_pins ip_19_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_microblaze/INTERRUPT] [get_bd_intf_pins ip_23_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_microblaze/M_AXI_DP] [get_bd_intf_pins ip_24_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_24_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_24_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_microblaze/M_AXI_DP] [get_bd_intf_pins ip_24_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_24_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_24_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_24_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_gpio/AXI] [get_bd_intf_pins ip_24_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_24_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_iic/AXI] [get_bd_intf_pins ip_24_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_emc/AXI] [get_bd_intf_pins ip_24_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_uartlite/AXI] [get_bd_intf_pins ip_24_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axi_iic/AXI] [get_bd_intf_pins ip_24_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_intc/AXI] [get_bd_intf_pins ip_24_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_intc/AXI] [get_bd_intf_pins ip_24_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_25_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_26_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_27_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_floating_point/S_AXIS_A] [get_bd_intf_pins ip_29_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_floating_point/S_AXIS_OPERATION] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_floating_point/S_AXIS_B] [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_floating_point/S_AXIS_B] [get_bd_intf_pins ip_35_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_floating_point/S_AXIS_A] [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_fft/S_AXIS_DATA] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_10_dft/RFFD]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_1] [get_bd_pins ip_10_dft/XK_RE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_10_dft/SIZE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_10_dft/XK_RE]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_1] [get_bd_pins ip_10_dft/XK_IM]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_17_accumulator/B]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_10_dft/XK_IM]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_1] [get_bd_pins ip_10_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_2] [get_bd_pins ip_10_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_3] [get_bd_pins ip_10_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_4] [get_bd_pins ip_11_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_5] [get_bd_pins ip_11_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_6] [get_bd_pins ip_11_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_7] [get_bd_pins ip_12_dft/RFFD]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_8] [get_bd_pins ip_12_dft/XK_RE]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_10_dft/XN_IM]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_0] [get_bd_pins ip_12_dft/XK_RE]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/in_1] [get_bd_pins ip_12_dft/XK_IM]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_10_dft/XN_RE]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_0] [get_bd_pins ip_12_dft/XK_IM]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_1] [get_bd_pins ip_12_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_2] [get_bd_pins ip_12_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/in_3] [get_bd_pins ip_12_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_12_dft/SIZE]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_17_accumulator/Q]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_12_dft/XN_RE]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_17_accumulator/Q]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_12_dft/XN_IM]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_17_accumulator/Q]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_9_floating_point/aclken]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_10_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_17_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_10_dft/FD_IN]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_12_dft/FD_IN]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_17_accumulator/ADD]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_0_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_12_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_24_axi/reset]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_22_intc/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_23_intc/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_24_axi/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_25_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_26_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_27_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_28_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_29_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_33_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_34_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_35_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_36_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_37_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 144 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=144 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=144 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_fft/S_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_fft/S_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_fft/M_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_fft/M_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 18 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_fft/S_AXIS_CONFIG declared=18 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_fft/S_AXIS_CONFIG declared=18 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_A declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_A declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_B declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_B declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_OPERATION]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_OPERATION declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_OPERATION declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/M_AXIS_RESULT declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/M_AXIS_RESULT declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
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
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }


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
