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



########## cordic ##########
create_bd_cell -type hier ip_0_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_0_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Rotate CONFIG.Input_Width 41 CONFIG.Iterations 20 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 21 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 36 CONFIG.Round_Mode Round_Pos_Inf " [get_bd_cells ip_0_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aclk
connect_bd_net [get_bd_pins ip_0_cordic/aclk] [get_bd_pins ip_0_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]


########## microblaze ##########
create_bd_cell -type hier ip_1_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 44 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 6 CONFIG.C_DEBUG_COUNTER_WIDTH 32 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 40 CONFIG.C_DEBUG_EXTERNAL_TRACE 1 CONFIG.C_DEBUG_LATENCY_COUNTERS 1 CONFIG.C_DEBUG_PROFILE_SIZE 0 CONFIG.C_DEBUG_TRACE_SIZE 64 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 7 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 3 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 1 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_1_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_microblaze/Clk
connect_bd_net [get_bd_pins ip_1_microblaze/Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_1_microblaze/Reset
connect_bd_net [get_bd_pins ip_1_microblaze/Reset] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_1_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/INTERRUPT] [get_bd_intf_pins ip_1_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/M_AXI_DP] [get_bd_intf_pins ip_1_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_1_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_1_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xcc4340e7de1265b CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_1_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_1_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_1_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_1_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x9226b59dedb9fe1 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_1_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_1_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_1_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_1_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_1_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 2 " [get_bd_cells ip_1_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_1_microblaze/microblaze_0/DEBUG]


########## axi_cdma ##########
create_bd_cell -type hier ip_2_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_2_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 47 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_2_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_2_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_2_axi_cdma/m_axi_aclk] [get_bd_pins ip_2_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_2_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_2_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_2_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_2_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_cdma/M_AXI] [get_bd_intf_pins ip_2_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_2_axi_cdma/cdma_introut] [get_bd_pins ip_2_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_3_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_3_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_3_axi_ethernet_lite/axi_ethernetlite_0]
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


########## gpio ##########
create_bd_cell -type hier ip_4_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_4_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x0 CONFIG.C_GPIO2_WIDTH 11 CONFIG.C_GPIO_WIDTH 8 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x0 CONFIG.C_TRI_DEFAULT_2 0x78 " [get_bd_cells ip_4_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_4_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio/GPIO] [get_bd_intf_pins ip_4_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_4_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio/GPIO2] [get_bd_intf_pins ip_4_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_4_gpio/clk
connect_bd_net [get_bd_pins ip_4_gpio/clk] [get_bd_pins ip_4_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_gpio/rst
connect_bd_net [get_bd_pins ip_4_gpio/rst] [get_bd_pins ip_4_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio/AXI] [get_bd_intf_pins ip_4_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_gpio/irq
connect_bd_net [get_bd_pins ip_4_gpio/irq] [get_bd_pins ip_4_gpio/gpio_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 38400 CONFIG.C_DATA_BITS 8 CONFIG.PARITY No_Parity " [get_bd_cells ip_5_uartlite/uart_0]
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


########## xadc_wiz ##########
create_bd_cell -type hier ip_6_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_6_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_6_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_6_xadc_wiz/dclk_in] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_6_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_6_xadc_wiz/convst_in] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/eoc_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/eos_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/alarm_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/busy_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_6_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_6_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_6_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/jtaglocked_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/jtagmodified_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_6_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_6_xadc_wiz/jtagbusy_out] [get_bd_pins ip_6_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## conv_encoder ##########
create_bd_cell -type hier ip_7_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_7_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 4 CONFIG.convolution_code0 3 CONFIG.convolution_code1 11 CONFIG.convolution_code2 1 CONFIG.convolution_code3 6 CONFIG.convolution_code4 9 CONFIG.convolution_code5 15 CONFIG.convolution_code6 10 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 2 CONFIG.output_rate 3 CONFIG.puncture_code0 10 CONFIG.puncture_code1 11 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_7_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_7_conv_encoder/aclk] [get_bd_pins ip_7_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_7_conv_encoder/aresetn] [get_bd_pins ip_7_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_7_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_7_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_7_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_7_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_8_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_8_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_8_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_8_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite/MII] [get_bd_intf_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_8_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_8_axi_ethernet_lite/clk] [get_bd_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_8_axi_ethernet_lite/reset] [get_bd_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_8_axi_ethernet_lite/irq] [get_bd_pins ip_8_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_9_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_9_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 3 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_9_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_9_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/IIC] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/clk] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/reset] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/clk4] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/reset4] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_9_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_9_axi_quad_spi/irq] [get_bd_pins ip_9_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## fft ##########
create_bd_cell -type hier ip_10_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_10_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 7 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 8192 " [get_bd_cells ip_10_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_fft/aclk
connect_bd_net [get_bd_pins ip_10_fft/aclk] [get_bd_pins ip_10_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_10_fft/event_frame_started
connect_bd_net [get_bd_pins ip_10_fft/event_frame_started] [get_bd_pins ip_10_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_fft/S_AXIS_DATA] [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_10_fft/M_AXIS_DATA] [get_bd_intf_pins ip_10_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_10_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_CONFIG]


########## gpio ##########
create_bd_cell -type hier ip_11_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_11_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x92 CONFIG.C_DOUT_DEFAULT_2 0x9f CONFIG.C_GPIO2_WIDTH 16 CONFIG.C_GPIO_WIDTH 8 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0xff CONFIG.C_TRI_DEFAULT_2 0x0 " [get_bd_cells ip_11_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_11_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_11_gpio/GPIO] [get_bd_intf_pins ip_11_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_11_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_11_gpio/GPIO2] [get_bd_intf_pins ip_11_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_11_gpio/clk
connect_bd_net [get_bd_pins ip_11_gpio/clk] [get_bd_pins ip_11_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_gpio/rst
connect_bd_net [get_bd_pins ip_11_gpio/rst] [get_bd_pins ip_11_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_11_gpio/AXI] [get_bd_intf_pins ip_11_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_11_gpio/irq
connect_bd_net [get_bd_pins ip_11_gpio/irq] [get_bd_pins ip_11_gpio/gpio_0/ip2intc_irpt]


########## axi_iic ##########
create_bd_cell -type hier ip_12_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_12_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x6 CONFIG.C_GPO_WIDTH 3 CONFIG.C_SCL_INERTIAL_DELAY 128 CONFIG.C_SDA_INERTIAL_DELAY 8 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 390.8863984005597 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_12_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_12_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic/IIC] [get_bd_intf_pins ip_12_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_iic/clk
connect_bd_net [get_bd_pins ip_12_axi_iic/clk] [get_bd_pins ip_12_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_iic/reset
connect_bd_net [get_bd_pins ip_12_axi_iic/reset] [get_bd_pins ip_12_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic/AXI] [get_bd_intf_pins ip_12_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_iic/irq
connect_bd_net [get_bd_pins ip_12_axi_iic/irq] [get_bd_pins ip_12_axi_iic/axi_iic_0/iic2intc_irpt]


########## fft ##########
create_bd_cell -type hier ip_13_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_13_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 11 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 2048 " [get_bd_cells ip_13_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_fft/aclk
connect_bd_net [get_bd_pins ip_13_fft/aclk] [get_bd_pins ip_13_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_13_fft/event_frame_started
connect_bd_net [get_bd_pins ip_13_fft/event_frame_started] [get_bd_pins ip_13_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/S_AXIS_DATA] [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/M_AXIS_DATA] [get_bd_intf_pins ip_13_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_CONFIG]


########## dft ##########
create_bd_cell -type hier ip_14_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_14_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 15 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_14_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_dft/CLK
connect_bd_net [get_bd_pins ip_14_dft/CLK] [get_bd_pins ip_14_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_14_dft/CE
connect_bd_net [get_bd_pins ip_14_dft/CE] [get_bd_pins ip_14_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_14_dft/SCLR
connect_bd_net [get_bd_pins ip_14_dft/SCLR] [get_bd_pins ip_14_dft/dft_0/SCLR]
create_bd_pin -dir I -from 14 -to 0 ip_14_dft/XN_RE
connect_bd_net [get_bd_pins ip_14_dft/XN_RE] [get_bd_pins ip_14_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 14 -to 0 ip_14_dft/XN_IM
connect_bd_net [get_bd_pins ip_14_dft/XN_IM] [get_bd_pins ip_14_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_14_dft/FD_IN
connect_bd_net [get_bd_pins ip_14_dft/FD_IN] [get_bd_pins ip_14_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_14_dft/FWD_INV
connect_bd_net [get_bd_pins ip_14_dft/FWD_INV] [get_bd_pins ip_14_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_14_dft/SIZE
connect_bd_net [get_bd_pins ip_14_dft/SIZE] [get_bd_pins ip_14_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_14_dft/RFFD
connect_bd_net [get_bd_pins ip_14_dft/RFFD] [get_bd_pins ip_14_dft/dft_0/RFFD]
create_bd_pin -dir O -from 14 -to 0 ip_14_dft/XK_RE
connect_bd_net [get_bd_pins ip_14_dft/XK_RE] [get_bd_pins ip_14_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 14 -to 0 ip_14_dft/XK_IM
connect_bd_net [get_bd_pins ip_14_dft/XK_IM] [get_bd_pins ip_14_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_14_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_14_dft/BLK_EXP] [get_bd_pins ip_14_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_14_dft/FD_OUT
connect_bd_net [get_bd_pins ip_14_dft/FD_OUT] [get_bd_pins ip_14_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_14_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_14_dft/DATA_VALID] [get_bd_pins ip_14_dft/dft_0/DATA_VALID]


########## fft ##########
create_bd_cell -type hier ip_15_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_15_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 7 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 1024 " [get_bd_cells ip_15_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_fft/aclk
connect_bd_net [get_bd_pins ip_15_fft/aclk] [get_bd_pins ip_15_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_15_fft/event_frame_started
connect_bd_net [get_bd_pins ip_15_fft/event_frame_started] [get_bd_pins ip_15_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_15_fft/S_AXIS_DATA] [get_bd_intf_pins ip_15_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_15_fft/M_AXIS_DATA] [get_bd_intf_pins ip_15_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_15_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_15_fft/fft_0/S_AXIS_CONFIG]


########## axi_dma ##########
create_bd_cell -type hier ip_16_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_16_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 50 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 16 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 22 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 16 " [get_bd_cells ip_16_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_16_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_16_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_16_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_16_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_16_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_16_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_16_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_16_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_16_axi_dma/axi_resetn] [get_bd_pins ip_16_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_dma/M_AXI] [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_16_axi_dma/mm2s_introut] [get_bd_pins ip_16_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_16_axi_dma/s2mm_introut] [get_bd_pins ip_16_axi_dma/axi_dma_0/s2mm_introut]


########## microblaze ##########
create_bd_cell -type hier ip_17_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_17_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 52 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 7 CONFIG.C_DEBUG_COUNTER_WIDTH 32 CONFIG.C_DEBUG_ENABLED 2 CONFIG.C_DEBUG_EVENT_COUNTERS 28 CONFIG.C_DEBUG_EXTERNAL_TRACE 1 CONFIG.C_DEBUG_LATENCY_COUNTERS 0 CONFIG.C_DEBUG_PROFILE_SIZE 8192 CONFIG.C_DEBUG_TRACE_SIZE 128 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 1 CONFIG.C_MMU_ITLB_SIZE 1 CONFIG.C_MMU_PRIVILEGED_INSTR 1 CONFIG.C_MMU_TLB_ACCESS 2 CONFIG.C_MMU_ZONES 0 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 0 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 3 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 1 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0xbe CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MMU 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_17_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_microblaze/Clk
connect_bd_net [get_bd_pins ip_17_microblaze/Clk] [get_bd_pins ip_17_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_17_microblaze/Reset
connect_bd_net [get_bd_pins ip_17_microblaze/Reset] [get_bd_pins ip_17_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_17_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/INTERRUPT] [get_bd_intf_pins ip_17_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/M_AXI_DP] [get_bd_intf_pins ip_17_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_17_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_17_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_17_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_17_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_17_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_17_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_17_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_17_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x7f9104ab28415c CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_17_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_17_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_17_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_17_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_17_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_17_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_17_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_17_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_17_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_17_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_17_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_17_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_17_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_17_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x105539d2dd52b71 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_17_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_17_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_17_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_17_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_17_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_17_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_17_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_17_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_17_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_17_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_17_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 3 " [get_bd_cells ip_17_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_17_microblaze/microblaze_0/DEBUG]


########## gpio ##########
create_bd_cell -type hier ip_18_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_18_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 13 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_18_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_18_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_18_gpio/GPIO] [get_bd_intf_pins ip_18_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_18_gpio/clk
connect_bd_net [get_bd_pins ip_18_gpio/clk] [get_bd_pins ip_18_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_gpio/rst
connect_bd_net [get_bd_pins ip_18_gpio/rst] [get_bd_pins ip_18_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_gpio/AXI] [get_bd_intf_pins ip_18_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_18_gpio/irq
connect_bd_net [get_bd_pins ip_18_gpio/irq] [get_bd_pins ip_18_gpio/gpio_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_19_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_19_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x1bcc CONFIG.C_GPIO_WIDTH 13 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x1f87 " [get_bd_cells ip_19_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_19_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio/GPIO] [get_bd_intf_pins ip_19_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_19_gpio/clk
connect_bd_net [get_bd_pins ip_19_gpio/clk] [get_bd_pins ip_19_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_gpio/rst
connect_bd_net [get_bd_pins ip_19_gpio/rst] [get_bd_pins ip_19_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio/AXI] [get_bd_intf_pins ip_19_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_19_gpio/irq
connect_bd_net [get_bd_pins ip_19_gpio/irq] [get_bd_pins ip_19_gpio/gpio_0/ip2intc_irpt]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_20_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_20_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_20_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_20_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_quad_spi/IIC] [get_bd_intf_pins ip_20_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_20_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_20_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_20_axi_quad_spi/clk] [get_bd_pins ip_20_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_20_axi_quad_spi/reset] [get_bd_pins ip_20_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_20_axi_quad_spi/clk4] [get_bd_pins ip_20_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_20_axi_quad_spi/reset4] [get_bd_pins ip_20_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_20_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_20_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_20_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_20_axi_quad_spi/irq] [get_bd_pins ip_20_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_21_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_21_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 4 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 14 CONFIG.C_TAVDV_PS_MEM_0 15147 CONFIG.C_TAVDV_PS_MEM_1 15448 CONFIG.C_TAVDV_PS_MEM_2 15139 CONFIG.C_TAVDV_PS_MEM_3 15070 CONFIG.C_TCEDV_PS_MEM_0 14883 CONFIG.C_TCEDV_PS_MEM_1 14596 CONFIG.C_TCEDV_PS_MEM_2 16113 CONFIG.C_TCEDV_PS_MEM_3 15441 CONFIG.C_THZCE_PS_MEM_0 6819 CONFIG.C_THZCE_PS_MEM_1 6387 CONFIG.C_THZCE_PS_MEM_2 6836 CONFIG.C_THZCE_PS_MEM_3 7063 CONFIG.C_THZOE_PS_MEM_0 6939 CONFIG.C_THZOE_PS_MEM_1 7197 CONFIG.C_THZOE_PS_MEM_2 6476 CONFIG.C_THZOE_PS_MEM_3 6617 CONFIG.C_TLZWE_PS_MEM_0 2725 CONFIG.C_TLZWE_PS_MEM_1 5398 CONFIG.C_TLZWE_PS_MEM_2 5570 CONFIG.C_TLZWE_PS_MEM_3 3934 CONFIG.C_TWC_PS_MEM_0 15287 CONFIG.C_TWC_PS_MEM_1 15214 CONFIG.C_TWC_PS_MEM_2 16196 CONFIG.C_TWC_PS_MEM_3 13986 CONFIG.C_TWPH_PS_MEM_0 13193 CONFIG.C_TWPH_PS_MEM_1 11906 CONFIG.C_TWPH_PS_MEM_2 11308 CONFIG.C_TWPH_PS_MEM_3 13026 CONFIG.C_TWP_PS_MEM_0 12995 CONFIG.C_TWP_PS_MEM_1 11274 CONFIG.C_TWP_PS_MEM_2 11236 CONFIG.C_TWP_PS_MEM_3 11209 CONFIG.C_WR_REC_TIME_MEM_0 25994 CONFIG.C_WR_REC_TIME_MEM_1 25876 CONFIG.C_WR_REC_TIME_MEM_2 28827 CONFIG.C_WR_REC_TIME_MEM_3 24491 " [get_bd_cells ip_21_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_21_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_21_emc/EMC_INTF] [get_bd_intf_pins ip_21_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_21_emc/clk
connect_bd_net [get_bd_pins ip_21_emc/clk] [get_bd_pins ip_21_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_emc/rdclk
connect_bd_net [get_bd_pins ip_21_emc/rdclk] [get_bd_pins ip_21_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_emc/rst
connect_bd_net [get_bd_pins ip_21_emc/rst] [get_bd_pins ip_21_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_21_emc/AXI] [get_bd_intf_pins ip_21_emc/emc_0/S_AXI_MEM]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_22_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_22_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SHARED_STARTUP 1 CONFIG.C_SPI_MEMORY 2 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_22_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_22_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_quad_spi/IIC] [get_bd_intf_pins ip_22_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_22_axi_quad_spi/STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_quad_spi/STARTUP_IO_S] [get_bd_intf_pins ip_22_axi_quad_spi/axi_quad_spi_0/STARTUP_IO_S]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/clk] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/reset] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/clk4] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/reset4] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_22_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_22_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_22_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/irq] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_23_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_23_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 0 CONFIG.C_MEM0_WIDTH 8 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 0 CONFIG.C_MEM2_WIDTH 32 CONFIG.C_MEM3_TYPE 0 CONFIG.C_MEM3_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_SYNCH_PIPEDELAY_0 1 CONFIG.C_SYNCH_PIPEDELAY_2 1 CONFIG.C_SYNCH_PIPEDELAY_3 2 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 11 CONFIG.C_TAVDV_PS_MEM_1 16068 CONFIG.C_TCEDV_PS_MEM_1 14835 CONFIG.C_THZCE_PS_MEM_1 7230 CONFIG.C_THZOE_PS_MEM_1 7053 CONFIG.C_TLZWE_PS_MEM_1 214 CONFIG.C_TWC_PS_MEM_1 13763 CONFIG.C_TWPH_PS_MEM_1 12121 CONFIG.C_TWP_PS_MEM_1 12791 CONFIG.C_WR_REC_TIME_MEM_1 24969 " [get_bd_cells ip_23_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_23_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_23_emc/EMC_INTF] [get_bd_intf_pins ip_23_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_23_emc/clk
connect_bd_net [get_bd_pins ip_23_emc/clk] [get_bd_pins ip_23_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_emc/rdclk
connect_bd_net [get_bd_pins ip_23_emc/rdclk] [get_bd_pins ip_23_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_emc/rst
connect_bd_net [get_bd_pins ip_23_emc/rst] [get_bd_pins ip_23_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_23_emc/AXI] [get_bd_intf_pins ip_23_emc/emc_0/S_AXI_MEM]


########## conv_encoder ##########
create_bd_cell -type hier ip_24_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_24_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 4 CONFIG.convolution_code0 7 CONFIG.convolution_code1 3 CONFIG.convolution_code2 10 CONFIG.convolution_code3 1 CONFIG.convolution_code4 1 CONFIG.convolution_code5 10 CONFIG.convolution_code6 6 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 2 CONFIG.output_rate 3 CONFIG.puncture_code0 10 CONFIG.puncture_code1 11 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_24_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_24_conv_encoder/aclk] [get_bd_pins ip_24_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_24_conv_encoder/aclken] [get_bd_pins ip_24_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_24_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_24_conv_encoder/aresetn] [get_bd_pins ip_24_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_24_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_24_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_24_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_24_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_iic ##########
create_bd_cell -type hier ip_25_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_25_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x69 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 26 CONFIG.C_SDA_INERTIAL_DELAY 120 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 218.631455614645 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_25_axi_iic/axi_iic_0]
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


########## reset ##########
create_bd_cell -type hier ip_26_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_26_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_reset/clk_in
connect_bd_net [get_bd_pins ip_26_reset/clk_in] [get_bd_pins ip_26_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_26_reset/reset_in
connect_bd_net [get_bd_pins ip_26_reset/reset_in] [get_bd_pins ip_26_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_26_reset/dcm_locked
connect_bd_net [get_bd_pins ip_26_reset/dcm_locked] [get_bd_pins ip_26_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_26_reset/mb_reset
connect_bd_net [get_bd_pins ip_26_reset/mb_reset] [get_bd_pins ip_26_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_26_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_26_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_26_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset] [get_bd_pins ip_26_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_26_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_26_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_27_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_27_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_in] [get_bd_pins ip_27_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_27_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_27_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_27_clk_wiz/reset
connect_bd_net [get_bd_pins ip_27_clk_wiz/reset] [get_bd_pins ip_27_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_27_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_locked] [get_bd_pins ip_27_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_28_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_28_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_28_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 18 " [get_bd_cells ip_28_intc/concat_0]
connect_bd_net [get_bd_pins ip_28_intc/concat_0/dout] [get_bd_pins ip_28_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/clk
connect_bd_net [get_bd_pins ip_28_intc/clk] [get_bd_pins ip_28_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/reset
connect_bd_net [get_bd_pins ip_28_intc/reset] [get_bd_pins ip_28_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_28_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_28_intc/AXI] [get_bd_intf_pins ip_28_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_0
connect_bd_net [get_bd_pins ip_28_intc/irq_0] [get_bd_pins ip_28_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_1
connect_bd_net [get_bd_pins ip_28_intc/irq_1] [get_bd_pins ip_28_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_2
connect_bd_net [get_bd_pins ip_28_intc/irq_2] [get_bd_pins ip_28_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_3
connect_bd_net [get_bd_pins ip_28_intc/irq_3] [get_bd_pins ip_28_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_4
connect_bd_net [get_bd_pins ip_28_intc/irq_4] [get_bd_pins ip_28_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_5
connect_bd_net [get_bd_pins ip_28_intc/irq_5] [get_bd_pins ip_28_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_6
connect_bd_net [get_bd_pins ip_28_intc/irq_6] [get_bd_pins ip_28_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_7
connect_bd_net [get_bd_pins ip_28_intc/irq_7] [get_bd_pins ip_28_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_8
connect_bd_net [get_bd_pins ip_28_intc/irq_8] [get_bd_pins ip_28_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_9
connect_bd_net [get_bd_pins ip_28_intc/irq_9] [get_bd_pins ip_28_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_10
connect_bd_net [get_bd_pins ip_28_intc/irq_10] [get_bd_pins ip_28_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_11
connect_bd_net [get_bd_pins ip_28_intc/irq_11] [get_bd_pins ip_28_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_12
connect_bd_net [get_bd_pins ip_28_intc/irq_12] [get_bd_pins ip_28_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_13
connect_bd_net [get_bd_pins ip_28_intc/irq_13] [get_bd_pins ip_28_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_14
connect_bd_net [get_bd_pins ip_28_intc/irq_14] [get_bd_pins ip_28_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_15
connect_bd_net [get_bd_pins ip_28_intc/irq_15] [get_bd_pins ip_28_intc/concat_0/In15]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_16
connect_bd_net [get_bd_pins ip_28_intc/irq_16] [get_bd_pins ip_28_intc/concat_0/In16]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_17
connect_bd_net [get_bd_pins ip_28_intc/irq_17] [get_bd_pins ip_28_intc/concat_0/In17]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_28_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_28_intc/irq] [get_bd_intf_pins ip_28_intc/intc_0/interrupt]


########## intc ##########
create_bd_cell -type hier ip_29_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_29_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_29_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 18 " [get_bd_cells ip_29_intc/concat_0]
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
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_15
connect_bd_net [get_bd_pins ip_29_intc/irq_15] [get_bd_pins ip_29_intc/concat_0/In15]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_16
connect_bd_net [get_bd_pins ip_29_intc/irq_16] [get_bd_pins ip_29_intc/concat_0/In16]
create_bd_pin -dir I -from 0 -to 0 ip_29_intc/irq_17
connect_bd_net [get_bd_pins ip_29_intc/irq_17] [get_bd_pins ip_29_intc/concat_0/In17]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_29_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_29_intc/irq] [get_bd_intf_pins ip_29_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_30_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_30_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 5 " [get_bd_cells ip_30_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axi_legacy/clk
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_30_axi_legacy/reset
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_M0] [get_bd_intf_pins ip_30_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_M1] [get_bd_intf_pins ip_30_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_M2] [get_bd_intf_pins ip_30_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_M3] [get_bd_intf_pins ip_30_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_M4] [get_bd_intf_pins ip_30_axi_legacy/axi_0/S04_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/S04_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/S04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S0] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S1] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M01_ARESETN]


########## axi_legacy ##########
create_bd_cell -type hier ip_31_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_31_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_31_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi_legacy/clk
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi_legacy/reset
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M0] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S0] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S1] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S2] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S3] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S4] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S5] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S6] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S7] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S8] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S9] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S10] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S11] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S12] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M12_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S13] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M13_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M13_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M13_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S14] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M14_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M14_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M14_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S15] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M15_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M15_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M15_ARESETN]


########## axi_legacy ##########
create_bd_cell -type hier ip_32_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_32_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 5 CONFIG.NUM_SI 1 " [get_bd_cells ip_32_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axi_legacy/clk
connect_bd_net [get_bd_pins ip_32_axi_legacy/clk] [get_bd_pins ip_32_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_32_axi_legacy/reset
connect_bd_net [get_bd_pins ip_32_axi_legacy/reset] [get_bd_pins ip_32_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_32_axi_legacy/AXI_M0] [get_bd_intf_pins ip_32_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_32_axi_legacy/clk] [get_bd_pins ip_32_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_32_axi_legacy/reset] [get_bd_pins ip_32_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_32_axi_legacy/AXI_S0] [get_bd_intf_pins ip_32_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_32_axi_legacy/clk] [get_bd_pins ip_32_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_32_axi_legacy/reset] [get_bd_pins ip_32_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_32_axi_legacy/AXI_S1] [get_bd_intf_pins ip_32_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_32_axi_legacy/clk] [get_bd_pins ip_32_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_32_axi_legacy/reset] [get_bd_pins ip_32_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_32_axi_legacy/AXI_S2] [get_bd_intf_pins ip_32_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_32_axi_legacy/clk] [get_bd_pins ip_32_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_32_axi_legacy/reset] [get_bd_pins ip_32_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_32_axi_legacy/AXI_S3] [get_bd_intf_pins ip_32_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_32_axi_legacy/clk] [get_bd_pins ip_32_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_32_axi_legacy/reset] [get_bd_pins ip_32_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_32_axi_legacy/AXI_S4] [get_bd_intf_pins ip_32_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_32_axi_legacy/clk] [get_bd_pins ip_32_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_32_axi_legacy/reset] [get_bd_pins ip_32_axi_legacy/axi_0/M04_ARESETN]


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
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_35_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_35_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_37_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 44 " [get_bd_cells ip_38_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aclk] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_39_axis_dwidth_converter/aresetn] [get_bd_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_40_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_40_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_40_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_40_axis_combiner/aclk] [get_bd_pins ip_40_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_40_axis_combiner/aresetn] [get_bd_pins ip_40_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/M_AXIS] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_41_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_41_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 3 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
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
create_bd_pin -dir O -from 6 -to 0 ip_43_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_43_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_43_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_43_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_1] [get_bd_pins ip_43_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_2] [get_bd_pins ip_43_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_3] [get_bd_pins ip_43_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_4] [get_bd_pins ip_43_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_5] [get_bd_pins ip_43_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_6] [get_bd_pins ip_43_slice_and_concat/concat/In6]


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 14 -to 0 ip_44_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 14 -to 0 ip_45_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 15 " [get_bd_cells ip_45_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_45_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_46_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_46_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_46_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 14 -to 0 ip_46_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_46_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 14 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 15 " [get_bd_cells ip_46_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_46_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/slice_0/dout] [get_bd_pins ip_46_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_46_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_1] [get_bd_pins ip_46_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_46_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_2] [get_bd_pins ip_46_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_46_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_3] [get_bd_pins ip_46_slice_and_concat/concat/In3]


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

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_26_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_27_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_3_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite_MII] [get_bd_intf_pins ip_3_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_3_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_3_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_4_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio_GPIO] [get_bd_intf_pins ip_4_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_4_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_4_gpio_GPIO2] [get_bd_intf_pins ip_4_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_6_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_6_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_6_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_8_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite_MII] [get_bd_intf_pins ip_8_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_8_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_8_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_9_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_quad_spi_IIC] [get_bd_intf_pins ip_9_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_11_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_11_gpio_GPIO] [get_bd_intf_pins ip_11_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_11_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_11_gpio_GPIO2] [get_bd_intf_pins ip_11_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_12_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic_IIC] [get_bd_intf_pins ip_12_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_18_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_18_gpio_GPIO] [get_bd_intf_pins ip_18_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_19_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_19_gpio_GPIO] [get_bd_intf_pins ip_19_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_20_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_quad_spi_IIC] [get_bd_intf_pins ip_20_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_21_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_21_emc_EMC_INTF] [get_bd_intf_pins ip_21_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_22_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_quad_spi_IIC] [get_bd_intf_pins ip_22_axi_quad_spi/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_22_axi_quad_spi_STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_quad_spi_STARTUP_IO_S] [get_bd_intf_pins ip_22_axi_quad_spi/STARTUP_IO_S]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_23_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_23_emc_EMC_INTF] [get_bd_intf_pins ip_23_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_25_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_25_axi_iic_IIC] [get_bd_intf_pins ip_25_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 6 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_43_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_27_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_28_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_29_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_26_reset/mb_reset] [get_bd_pins ip_1_microblaze/Reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_4_gpio/rst]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_7_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_11_gpio/rst]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_iic/reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset] [get_bd_pins ip_14_dft/SCLR]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_16_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_26_reset/mb_reset] [get_bd_pins ip_17_microblaze/Reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_18_gpio/rst]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_19_gpio/rst]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_20_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_20_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_21_emc/rst]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_22_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_22_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_23_emc/rst]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_24_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/peripheral_areset_n] [get_bd_pins ip_25_axi_iic/reset]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_0_cordic/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_1_microblaze/Clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_3_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_4_gpio/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_6_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_7_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_8_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_9_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_10_fft/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_11_gpio/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_12_axi_iic/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_13_fft/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_14_dft/CLK]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_15_fft/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_16_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_16_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_16_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_16_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_17_microblaze/Clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_18_gpio/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_19_gpio/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_20_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_20_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_20_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_21_emc/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_21_emc/rdclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_22_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_22_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_22_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_23_emc/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_23_emc/rdclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_24_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_25_axi_iic/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_26_reset/clk_in]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_locked] [get_bd_pins ip_26_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_28_intc/irq_0] [get_bd_pins ip_2_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_28_intc/irq_1] [get_bd_pins ip_3_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_2] [get_bd_pins ip_4_gpio/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_3] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_4] [get_bd_pins ip_8_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_5] [get_bd_pins ip_9_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_6] [get_bd_pins ip_10_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_28_intc/irq_7] [get_bd_pins ip_11_gpio/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_8] [get_bd_pins ip_12_axi_iic/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_9] [get_bd_pins ip_13_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_28_intc/irq_10] [get_bd_pins ip_15_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_28_intc/irq_11] [get_bd_pins ip_16_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_28_intc/irq_12] [get_bd_pins ip_16_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_28_intc/irq_13] [get_bd_pins ip_18_gpio/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_14] [get_bd_pins ip_19_gpio/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_15] [get_bd_pins ip_20_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_16] [get_bd_pins ip_22_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_17] [get_bd_pins ip_25_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_microblaze/INTERRUPT] [get_bd_intf_pins ip_28_intc/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_0] [get_bd_pins ip_2_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_29_intc/irq_1] [get_bd_pins ip_3_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_2] [get_bd_pins ip_4_gpio/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_3] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_4] [get_bd_pins ip_8_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_5] [get_bd_pins ip_9_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_6] [get_bd_pins ip_10_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_29_intc/irq_7] [get_bd_pins ip_11_gpio/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_8] [get_bd_pins ip_12_axi_iic/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_9] [get_bd_pins ip_13_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_29_intc/irq_10] [get_bd_pins ip_15_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_29_intc/irq_11] [get_bd_pins ip_16_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_29_intc/irq_12] [get_bd_pins ip_16_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_29_intc/irq_13] [get_bd_pins ip_18_gpio/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_14] [get_bd_pins ip_19_gpio/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_15] [get_bd_pins ip_20_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_16] [get_bd_pins ip_22_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_29_intc/irq_17] [get_bd_pins ip_25_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_microblaze/INTERRUPT] [get_bd_intf_pins ip_29_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_microblaze/M_AXI_DP] [get_bd_intf_pins ip_30_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/M_AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_30_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_dma/M_AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_microblaze/M_AXI_DP] [get_bd_intf_pins ip_30_axi_legacy/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axi_legacy/AXI_S0] [get_bd_intf_pins ip_31_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_gpio/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_31_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_gpio/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_iic/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_gpio/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_gpio/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_31_axi_legacy/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_emc/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_axi_legacy/AXI_S1] [get_bd_intf_pins ip_32_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_32_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_emc/AXI] [get_bd_intf_pins ip_32_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axi_iic/AXI] [get_bd_intf_pins ip_32_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_intc/AXI] [get_bd_intf_pins ip_32_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_intc/AXI] [get_bd_intf_pins ip_32_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/M_AXIS_DATA] [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_7_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_fft/S_AXIS_DATA] [get_bd_intf_pins ip_24_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_DATA] [get_bd_intf_pins ip_15_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_DATA] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_40_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_1] [get_bd_pins ip_6_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_2] [get_bd_pins ip_6_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_3] [get_bd_pins ip_6_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_4] [get_bd_pins ip_6_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_5] [get_bd_pins ip_6_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_6] [get_bd_pins ip_14_dft/RFFD]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_14_dft/XN_RE]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_14_dft/XK_RE]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_14_dft/SIZE]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_14_dft/XK_IM]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_14_dft/XN_IM]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_14_dft/XK_IM]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_1] [get_bd_pins ip_14_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_2] [get_bd_pins ip_14_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_3] [get_bd_pins ip_14_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_14_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_6_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_24_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_14_dft/CE]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_14_dft/FD_IN]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_6_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_30_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_31_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_32_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_28_intc/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_29_intc/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_30_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_31_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_32_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_33_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_34_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_35_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_36_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_37_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_38_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_40_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_27_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 21 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=21 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=21 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 33 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=33 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=33 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_fft/S_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_fft/S_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_fft/M_AXIS_DATA declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_fft/M_AXIS_DATA declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_fft/S_AXIS_CONFIG declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_fft/S_AXIS_CONFIG declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axi_dma/M_AXIS_MM2S declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axi_dma/M_AXIS_MM2S declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axi_dma/S_AXIS_S2MM declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axi_dma/S_AXIS_S2MM declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
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
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 224 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=224 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=224 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_3 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_3 declared=16 actual=ERR $__err" }
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
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 352 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=352 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=352 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 21 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=21 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=21 actual=ERR $__err" }


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
