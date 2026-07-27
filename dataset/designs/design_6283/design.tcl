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



########## axi_timer ##########
create_bd_cell -type hier ip_0_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_0_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 8 CONFIG.GEN0_ASSERT Active_Low CONFIG.GEN1_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.TRIG1_ASSERT Active_Low CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_0_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_0_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_0_axi_timer/capturetrig0] [get_bd_pins ip_0_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_0_axi_timer/capturetrig1] [get_bd_pins ip_0_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/freeze
connect_bd_net [get_bd_pins ip_0_axi_timer/freeze] [get_bd_pins ip_0_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_0_axi_timer/s_axi_aclk] [get_bd_pins ip_0_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_0_axi_timer/s_axi_aresetn] [get_bd_pins ip_0_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_0_axi_timer/generateout0] [get_bd_pins ip_0_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_0_axi_timer/generateout1] [get_bd_pins ip_0_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_0_axi_timer/pwm0] [get_bd_pins ip_0_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_0_axi_timer/interrupt] [get_bd_pins ip_0_axi_timer/axi_timer_0/interrupt]


########## axi_dma ##########
create_bd_cell -type hier ip_1_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_1_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 54 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 256 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 13 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 16 " [get_bd_cells ip_1_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_1_axi_dma/axi_resetn] [get_bd_pins ip_1_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_1_axi_dma/s2mm_introut] [get_bd_pins ip_1_axi_dma/axi_dma_0/s2mm_introut]


########## gpio ##########
create_bd_cell -type hier ip_2_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_2_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x54bcf371 CONFIG.C_GPIO_WIDTH 31 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 CONFIG.C_TRI_DEFAULT 0x7d102f62 " [get_bd_cells ip_2_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/GPIO] [get_bd_intf_pins ip_2_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/clk
connect_bd_net [get_bd_pins ip_2_gpio/clk] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/rst
connect_bd_net [get_bd_pins ip_2_gpio/rst] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_2_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_gpio/irq
connect_bd_net [get_bd_pins ip_2_gpio/irq] [get_bd_pins ip_2_gpio/gpio_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_3_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_3_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 5 CONFIG.PARITY No_Parity " [get_bd_cells ip_3_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/UART] [get_bd_intf_pins ip_3_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/clk
connect_bd_net [get_bd_pins ip_3_uartlite/clk] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_uartlite/reset
connect_bd_net [get_bd_pins ip_3_uartlite/reset] [get_bd_pins ip_3_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_3_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_uartlite/irq
connect_bd_net [get_bd_pins ip_3_uartlite/irq] [get_bd_pins ip_3_uartlite/uart_0/interrupt]


########## axi_hwicap ##########
create_bd_cell -type hier ip_4_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_4_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 1 CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 128 " [get_bd_cells ip_4_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_4_axi_hwicap/icap_clk] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_4_axi_hwicap/eos_in] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_4_axi_hwicap/s_axi_aclk] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_4_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_4_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_4_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_hwicap/ICAP] [get_bd_intf_pins ip_4_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_4_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_4_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## complex_multiplier ##########
create_bd_cell -type hier ip_5_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_5_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 28 CONFIG.aresetn 0 CONFIG.atuserwidth 75 CONFIG.bportwidth 54 CONFIG.btuserwidth 33 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 1 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 44 CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 58 CONFIG.outtlastbehv AND_all_TLASTs CONFIG.roundmode Random_Rounding " [get_bd_cells ip_5_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_5_complex_multiplier/aclk] [get_bd_pins ip_5_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_5_complex_multiplier/aclken] [get_bd_pins ip_5_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_5_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_iic ##########
create_bd_cell -type hier ip_6_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_6_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x43 CONFIG.C_GPO_WIDTH 8 CONFIG.C_SCL_INERTIAL_DELAY 68 CONFIG.C_SDA_INERTIAL_DELAY 236 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 403.8875090336713 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_6_axi_iic/axi_iic_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_7_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_7_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x3c CONFIG.C_GPO_WIDTH 7 CONFIG.C_SCL_INERTIAL_DELAY 94 CONFIG.C_SDA_INERTIAL_DELAY 99 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 223.46077066470536 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_7_axi_iic/axi_iic_0]
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


########## complex_multiplier ##########
create_bd_cell -type hier ip_8_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_8_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 27 CONFIG.aresetn 0 CONFIG.atuserwidth 217 CONFIG.bportwidth 21 CONFIG.btuserwidth 122 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Performance CONFIG.outputwidth 26 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_8_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_8_complex_multiplier/aclk] [get_bd_pins ip_8_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_8_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## uartlite ##########
create_bd_cell -type hier ip_9_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_9_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 300 CONFIG.C_DATA_BITS 7 CONFIG.PARITY No_Parity " [get_bd_cells ip_9_uartlite/uart_0]
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


########## emc ##########
create_bd_cell -type hier ip_10_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_10_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 32 CONFIG.C_MEM3_TYPE 4 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 4 CONFIG.C_TAVDV_PS_MEM_0 14283 CONFIG.C_TAVDV_PS_MEM_1 15547 CONFIG.C_TAVDV_PS_MEM_2 15484 CONFIG.C_TAVDV_PS_MEM_3 13893 CONFIG.C_TCEDV_PS_MEM_0 15439 CONFIG.C_TCEDV_PS_MEM_1 16187 CONFIG.C_TCEDV_PS_MEM_2 13680 CONFIG.C_TCEDV_PS_MEM_3 16470 CONFIG.C_THZCE_PS_MEM_0 6738 CONFIG.C_THZCE_PS_MEM_1 7517 CONFIG.C_THZCE_PS_MEM_2 6920 CONFIG.C_THZCE_PS_MEM_3 6304 CONFIG.C_THZOE_PS_MEM_0 6798 CONFIG.C_THZOE_PS_MEM_1 6705 CONFIG.C_THZOE_PS_MEM_2 6345 CONFIG.C_THZOE_PS_MEM_3 7662 CONFIG.C_TLZWE_PS_MEM_0 2972 CONFIG.C_TLZWE_PS_MEM_1 8613 CONFIG.C_TLZWE_PS_MEM_2 5441 CONFIG.C_TLZWE_PS_MEM_3 3562 CONFIG.C_TWC_PS_MEM_0 14020 CONFIG.C_TWC_PS_MEM_1 14442 CONFIG.C_TWC_PS_MEM_2 15479 CONFIG.C_TWC_PS_MEM_3 14849 CONFIG.C_TWPH_PS_MEM_0 11079 CONFIG.C_TWPH_PS_MEM_1 10971 CONFIG.C_TWPH_PS_MEM_2 12358 CONFIG.C_TWPH_PS_MEM_3 12735 CONFIG.C_TWP_PS_MEM_0 12643 CONFIG.C_TWP_PS_MEM_1 12012 CONFIG.C_TWP_PS_MEM_2 12739 CONFIG.C_TWP_PS_MEM_3 12659 CONFIG.C_WR_REC_TIME_MEM_0 27908 CONFIG.C_WR_REC_TIME_MEM_1 24662 CONFIG.C_WR_REC_TIME_MEM_2 25167 CONFIG.C_WR_REC_TIME_MEM_3 27800 " [get_bd_cells ip_10_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_10_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_10_emc/EMC_INTF] [get_bd_intf_pins ip_10_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_10_emc/clk
connect_bd_net [get_bd_pins ip_10_emc/clk] [get_bd_pins ip_10_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_emc/rdclk
connect_bd_net [get_bd_pins ip_10_emc/rdclk] [get_bd_pins ip_10_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_emc/rst
connect_bd_net [get_bd_pins ip_10_emc/rst] [get_bd_pins ip_10_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_emc/AXI] [get_bd_intf_pins ip_10_emc/emc_0/S_AXI_MEM]


########## cordic ##########
create_bd_cell -type hier ip_11_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_11_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 1 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Rotate CONFIG.Input_Width 9 CONFIG.Iterations 6 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 10 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 35 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_11_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_cordic/aclk
connect_bd_net [get_bd_pins ip_11_cordic/aclk] [get_bd_pins ip_11_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_11_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_11_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_11_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_11_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_11_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_11_cordic/cordic_0/M_AXIS_DOUT]


########## axi_iic ##########
create_bd_cell -type hier ip_12_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_12_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x5d CONFIG.C_GPO_WIDTH 7 CONFIG.C_SCL_INERTIAL_DELAY 103 CONFIG.C_SDA_INERTIAL_DELAY 122 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 934.6208472988941 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_12_axi_iic/axi_iic_0]
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


########## complex_multiplier ##########
create_bd_cell -type hier ip_13_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_13_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 48 CONFIG.aresetn 1 CONFIG.atuserwidth 186 CONFIG.bportwidth 32 CONFIG.btuserwidth 233 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 19 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_13_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_13_complex_multiplier/aclk] [get_bd_pins ip_13_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_13_complex_multiplier/aclken] [get_bd_pins ip_13_complex_multiplier/cmpy_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_13_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_13_complex_multiplier/aresetn] [get_bd_pins ip_13_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_13_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## floating_point ##########
create_bd_cell -type hier ip_14_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_14_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.a_tuser_width 14 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_divide_by_zero 0 CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage Full_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 1 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Rec_Square_Root CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_14_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_floating_point/aclk
connect_bd_net [get_bd_pins ip_14_floating_point/aclk] [get_bd_pins ip_14_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_14_floating_point/S_AXIS_A] [get_bd_intf_pins ip_14_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_14_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_14_floating_point/floating_point_0/M_AXIS_RESULT]


########## complex_multiplier ##########
create_bd_cell -type hier ip_15_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_15_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 61 CONFIG.aresetn 1 CONFIG.atuserwidth 202 CONFIG.bportwidth 12 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 30 CONFIG.roundmode Truncate " [get_bd_cells ip_15_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_15_complex_multiplier/aclk] [get_bd_pins ip_15_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_15_complex_multiplier/aresetn] [get_bd_pins ip_15_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_15_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_16_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_16_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 0 CONFIG.C_FIFO_DEPTH 16 CONFIG.C_NUM_TRANSFER_BITS 32 CONFIG.C_SCK_RATIO 2 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_16_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_16_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_quad_spi/IIC] [get_bd_intf_pins ip_16_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_16_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_16_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_16_axi_quad_spi/clk] [get_bd_pins ip_16_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_16_axi_quad_spi/reset] [get_bd_pins ip_16_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_16_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_pin -dir O -from 0 -to 0 ip_16_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_16_axi_quad_spi/irq] [get_bd_pins ip_16_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## microblaze ##########
create_bd_cell -type hier ip_17_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_17_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 36 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 2 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_NUMBER_OF_PC_BRK 2 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 0 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 0 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_17_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_MASK 0x1122ea168ff20fe CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_17_microblaze/lmb_ctrl_d]
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
set_property -dict "CONFIG.C_MASK 0x240488801802b1d CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_17_microblaze/lmb_ctrl_i]
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
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 2 " [get_bd_cells ip_17_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_17_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_17_microblaze/microblaze_0/DEBUG]


########## uartlite ##########
create_bd_cell -type hier ip_18_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_18_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Even " [get_bd_cells ip_18_uartlite/uart_0]
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


########## dft ##########
create_bd_cell -type hier ip_19_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_19_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 10 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_19_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_dft/CLK
connect_bd_net [get_bd_pins ip_19_dft/CLK] [get_bd_pins ip_19_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_19_dft/CE
connect_bd_net [get_bd_pins ip_19_dft/CE] [get_bd_pins ip_19_dft/dft_0/CE]
create_bd_pin -dir I -from 9 -to 0 ip_19_dft/XN_RE
connect_bd_net [get_bd_pins ip_19_dft/XN_RE] [get_bd_pins ip_19_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 9 -to 0 ip_19_dft/XN_IM
connect_bd_net [get_bd_pins ip_19_dft/XN_IM] [get_bd_pins ip_19_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_19_dft/FD_IN
connect_bd_net [get_bd_pins ip_19_dft/FD_IN] [get_bd_pins ip_19_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_19_dft/FWD_INV
connect_bd_net [get_bd_pins ip_19_dft/FWD_INV] [get_bd_pins ip_19_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_19_dft/SIZE
connect_bd_net [get_bd_pins ip_19_dft/SIZE] [get_bd_pins ip_19_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_19_dft/RFFD
connect_bd_net [get_bd_pins ip_19_dft/RFFD] [get_bd_pins ip_19_dft/dft_0/RFFD]
create_bd_pin -dir O -from 9 -to 0 ip_19_dft/XK_RE
connect_bd_net [get_bd_pins ip_19_dft/XK_RE] [get_bd_pins ip_19_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 9 -to 0 ip_19_dft/XK_IM
connect_bd_net [get_bd_pins ip_19_dft/XK_IM] [get_bd_pins ip_19_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_19_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_19_dft/BLK_EXP] [get_bd_pins ip_19_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_19_dft/FD_OUT
connect_bd_net [get_bd_pins ip_19_dft/FD_OUT] [get_bd_pins ip_19_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_19_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_19_dft/DATA_VALID] [get_bd_pins ip_19_dft/dft_0/DATA_VALID]


########## dft ##########
create_bd_cell -type hier ip_20_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_20_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 8 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_20_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/CLK
connect_bd_net [get_bd_pins ip_20_dft/CLK] [get_bd_pins ip_20_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/SCLR
connect_bd_net [get_bd_pins ip_20_dft/SCLR] [get_bd_pins ip_20_dft/dft_0/SCLR]
create_bd_pin -dir I -from 7 -to 0 ip_20_dft/XN_RE
connect_bd_net [get_bd_pins ip_20_dft/XN_RE] [get_bd_pins ip_20_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 7 -to 0 ip_20_dft/XN_IM
connect_bd_net [get_bd_pins ip_20_dft/XN_IM] [get_bd_pins ip_20_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/FD_IN
connect_bd_net [get_bd_pins ip_20_dft/FD_IN] [get_bd_pins ip_20_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/FWD_INV
connect_bd_net [get_bd_pins ip_20_dft/FWD_INV] [get_bd_pins ip_20_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_20_dft/SIZE
connect_bd_net [get_bd_pins ip_20_dft/SIZE] [get_bd_pins ip_20_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_20_dft/RFFD
connect_bd_net [get_bd_pins ip_20_dft/RFFD] [get_bd_pins ip_20_dft/dft_0/RFFD]
create_bd_pin -dir O -from 7 -to 0 ip_20_dft/XK_RE
connect_bd_net [get_bd_pins ip_20_dft/XK_RE] [get_bd_pins ip_20_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 7 -to 0 ip_20_dft/XK_IM
connect_bd_net [get_bd_pins ip_20_dft/XK_IM] [get_bd_pins ip_20_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_20_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_20_dft/BLK_EXP] [get_bd_pins ip_20_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_20_dft/FD_OUT
connect_bd_net [get_bd_pins ip_20_dft/FD_OUT] [get_bd_pins ip_20_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_20_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_20_dft/DATA_VALID] [get_bd_pins ip_20_dft/dft_0/DATA_VALID]


########## axi_dma ##########
create_bd_cell -type hier ip_21_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_21_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 47 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 4 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 128 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 14 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_21_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_21_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_21_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_21_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_21_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_21_axi_dma/axi_resetn] [get_bd_pins ip_21_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_21_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_21_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_21_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_21_axi_dma/mm2s_introut] [get_bd_pins ip_21_axi_dma/axi_dma_0/mm2s_introut]


########## xadc_wiz ##########
create_bd_cell -type hier ip_22_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_22_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 16 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_DCLK 1 CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 1 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 1 CONFIG.VCCINT_ALARM 0 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_22_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_22_xadc_wiz/dclk_in] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_22_xadc_wiz/reset_in
connect_bd_net [get_bd_pins ip_22_xadc_wiz/reset_in] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/reset_in]
create_bd_pin -dir O -from 0 -to 0 ip_22_xadc_wiz/vccaux_alarm_out
connect_bd_net [get_bd_pins ip_22_xadc_wiz/vccaux_alarm_out] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/vccaux_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_22_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_22_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_22_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_22_xadc_wiz/eoc_out] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_22_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_22_xadc_wiz/eos_out] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_22_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_22_xadc_wiz/alarm_out] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_22_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_22_xadc_wiz/busy_out] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_22_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_22_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_22_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_22_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_22_xadc_wiz/jtaglocked_out] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_22_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_22_xadc_wiz/jtagmodified_out] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_22_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_22_xadc_wiz/jtagbusy_out] [get_bd_pins ip_22_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## microblaze ##########
create_bd_cell -type hier ip_23_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_23_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 64 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 3 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0xd4 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_23_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_microblaze/Clk
connect_bd_net [get_bd_pins ip_23_microblaze/Clk] [get_bd_pins ip_23_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_23_microblaze/Reset
connect_bd_net [get_bd_pins ip_23_microblaze/Reset] [get_bd_pins ip_23_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_23_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_23_microblaze/INTERRUPT] [get_bd_intf_pins ip_23_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_23_microblaze/M_AXI_DP] [get_bd_intf_pins ip_23_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_23_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_23_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_23_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_23_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_23_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_23_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_23_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_23_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_23_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x76aed11f3adf012 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_23_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_23_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_23_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_23_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_23_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_23_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_23_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_23_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_23_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_23_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_23_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_23_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_23_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_23_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_23_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_23_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xdde60923f4e64a9 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_23_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_23_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_23_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_23_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_23_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_23_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_23_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_23_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_23_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_23_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_23_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_23_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_23_microblaze/mem/BRAM_PORTB]


########## uartlite ##########
create_bd_cell -type hier ip_24_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_24_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 8 CONFIG.PARITY No_Parity " [get_bd_cells ip_24_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_24_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_24_uartlite/UART] [get_bd_intf_pins ip_24_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_24_uartlite/clk
connect_bd_net [get_bd_pins ip_24_uartlite/clk] [get_bd_pins ip_24_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_uartlite/reset
connect_bd_net [get_bd_pins ip_24_uartlite/reset] [get_bd_pins ip_24_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_24_uartlite/AXI] [get_bd_intf_pins ip_24_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_24_uartlite/irq
connect_bd_net [get_bd_pins ip_24_uartlite/irq] [get_bd_pins ip_24_uartlite/uart_0/interrupt]


########## emc ##########
create_bd_cell -type hier ip_25_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_25_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 3 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 4 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 3 CONFIG.C_MEM3_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 12 CONFIG.C_TAVDV_PS_MEM_0 15075 CONFIG.C_TAVDV_PS_MEM_1 15323 CONFIG.C_TAVDV_PS_MEM_2 15166 CONFIG.C_TAVDV_PS_MEM_3 15468 CONFIG.C_TCEDV_PS_MEM_0 14529 CONFIG.C_TCEDV_PS_MEM_1 13769 CONFIG.C_TCEDV_PS_MEM_2 14674 CONFIG.C_TCEDV_PS_MEM_3 16260 CONFIG.C_THZCE_PS_MEM_0 7660 CONFIG.C_THZCE_PS_MEM_1 7654 CONFIG.C_THZCE_PS_MEM_2 7130 CONFIG.C_THZCE_PS_MEM_3 6870 CONFIG.C_THZOE_PS_MEM_0 7412 CONFIG.C_THZOE_PS_MEM_1 7689 CONFIG.C_THZOE_PS_MEM_2 7095 CONFIG.C_THZOE_PS_MEM_3 6401 CONFIG.C_TLZWE_PS_MEM_0 2320 CONFIG.C_TLZWE_PS_MEM_1 6364 CONFIG.C_TLZWE_PS_MEM_2 1464 CONFIG.C_TLZWE_PS_MEM_3 4012 CONFIG.C_TWC_PS_MEM_0 14141 CONFIG.C_TWC_PS_MEM_1 14363 CONFIG.C_TWC_PS_MEM_2 15511 CONFIG.C_TWC_PS_MEM_3 15205 CONFIG.C_TWPH_PS_MEM_0 12551 CONFIG.C_TWPH_PS_MEM_1 10978 CONFIG.C_TWPH_PS_MEM_2 12933 CONFIG.C_TWPH_PS_MEM_3 10932 CONFIG.C_TWP_PS_MEM_0 12337 CONFIG.C_TWP_PS_MEM_1 12548 CONFIG.C_TWP_PS_MEM_2 12101 CONFIG.C_TWP_PS_MEM_3 11296 CONFIG.C_WR_REC_TIME_MEM_0 25234 CONFIG.C_WR_REC_TIME_MEM_1 26434 CONFIG.C_WR_REC_TIME_MEM_2 28195 CONFIG.C_WR_REC_TIME_MEM_3 25181 " [get_bd_cells ip_25_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_25_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_25_emc/EMC_INTF] [get_bd_intf_pins ip_25_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_25_emc/clk
connect_bd_net [get_bd_pins ip_25_emc/clk] [get_bd_pins ip_25_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_emc/rdclk
connect_bd_net [get_bd_pins ip_25_emc/rdclk] [get_bd_pins ip_25_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_emc/rst
connect_bd_net [get_bd_pins ip_25_emc/rst] [get_bd_pins ip_25_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_25_emc/AXI] [get_bd_intf_pins ip_25_emc/emc_0/S_AXI_MEM]


########## axi_iic ##########
create_bd_cell -type hier ip_26_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_26_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x51 CONFIG.C_GPO_WIDTH 3 CONFIG.C_SCL_INERTIAL_DELAY 176 CONFIG.C_SDA_INERTIAL_DELAY 254 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 24.40890759162103 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_26_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_26_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_iic/IIC] [get_bd_intf_pins ip_26_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_iic/clk
connect_bd_net [get_bd_pins ip_26_axi_iic/clk] [get_bd_pins ip_26_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_iic/reset
connect_bd_net [get_bd_pins ip_26_axi_iic/reset] [get_bd_pins ip_26_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_iic/AXI] [get_bd_intf_pins ip_26_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_26_axi_iic/irq
connect_bd_net [get_bd_pins ip_26_axi_iic/irq] [get_bd_pins ip_26_axi_iic/axi_iic_0/iic2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_27_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_27_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tanh CONFIG.Input_Width 40 CONFIG.Iterations 24 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 37 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 39 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_27_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_cordic/aclk
connect_bd_net [get_bd_pins ip_27_cordic/aclk] [get_bd_pins ip_27_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_cordic/aclken
connect_bd_net [get_bd_pins ip_27_cordic/aclken] [get_bd_pins ip_27_cordic/cordic_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_27_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_27_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_27_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_27_cordic/cordic_0/M_AXIS_DOUT]


########## fft ##########
create_bd_cell -type hier ip_28_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_28_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 9 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 2048 " [get_bd_cells ip_28_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_fft/aclk
connect_bd_net [get_bd_pins ip_28_fft/aclk] [get_bd_pins ip_28_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_28_fft/event_frame_started
connect_bd_net [get_bd_pins ip_28_fft/event_frame_started] [get_bd_pins ip_28_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_28_fft/S_AXIS_DATA] [get_bd_intf_pins ip_28_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_28_fft/M_AXIS_DATA] [get_bd_intf_pins ip_28_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_28_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_28_fft/fft_0/S_AXIS_CONFIG]


########## axi_cdma ##########
create_bd_cell -type hier ip_29_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_29_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 45 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 128 CONFIG.C_M_AXI_MAX_BURST_LEN 8 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_29_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_29_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_29_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_29_axi_cdma/m_axi_aclk] [get_bd_pins ip_29_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_29_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_29_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_29_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_29_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_cdma/M_AXI] [get_bd_intf_pins ip_29_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_29_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_29_axi_cdma/cdma_introut] [get_bd_pins ip_29_axi_cdma/axi_cdma_0/cdma_introut]


########## reset ##########
create_bd_cell -type hier ip_30_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_30_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_reset/clk_in
connect_bd_net [get_bd_pins ip_30_reset/clk_in] [get_bd_pins ip_30_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_30_reset/reset_in
connect_bd_net [get_bd_pins ip_30_reset/reset_in] [get_bd_pins ip_30_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_30_reset/dcm_locked
connect_bd_net [get_bd_pins ip_30_reset/dcm_locked] [get_bd_pins ip_30_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_30_reset/mb_reset
connect_bd_net [get_bd_pins ip_30_reset/mb_reset] [get_bd_pins ip_30_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_30_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_30_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_30_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset] [get_bd_pins ip_30_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_30_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_30_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_31_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_31_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_in] [get_bd_pins ip_31_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_31_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_31_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_31_clk_wiz/reset
connect_bd_net [get_bd_pins ip_31_clk_wiz/reset] [get_bd_pins ip_31_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_31_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_locked] [get_bd_pins ip_31_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_32_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_32_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_32_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 16 " [get_bd_cells ip_32_intc/concat_0]
connect_bd_net [get_bd_pins ip_32_intc/concat_0/dout] [get_bd_pins ip_32_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/clk
connect_bd_net [get_bd_pins ip_32_intc/clk] [get_bd_pins ip_32_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/reset
connect_bd_net [get_bd_pins ip_32_intc/reset] [get_bd_pins ip_32_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_32_intc/AXI] [get_bd_intf_pins ip_32_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_0
connect_bd_net [get_bd_pins ip_32_intc/irq_0] [get_bd_pins ip_32_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_1
connect_bd_net [get_bd_pins ip_32_intc/irq_1] [get_bd_pins ip_32_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_2
connect_bd_net [get_bd_pins ip_32_intc/irq_2] [get_bd_pins ip_32_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_3
connect_bd_net [get_bd_pins ip_32_intc/irq_3] [get_bd_pins ip_32_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_4
connect_bd_net [get_bd_pins ip_32_intc/irq_4] [get_bd_pins ip_32_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_5
connect_bd_net [get_bd_pins ip_32_intc/irq_5] [get_bd_pins ip_32_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_6
connect_bd_net [get_bd_pins ip_32_intc/irq_6] [get_bd_pins ip_32_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_7
connect_bd_net [get_bd_pins ip_32_intc/irq_7] [get_bd_pins ip_32_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_8
connect_bd_net [get_bd_pins ip_32_intc/irq_8] [get_bd_pins ip_32_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_9
connect_bd_net [get_bd_pins ip_32_intc/irq_9] [get_bd_pins ip_32_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_10
connect_bd_net [get_bd_pins ip_32_intc/irq_10] [get_bd_pins ip_32_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_11
connect_bd_net [get_bd_pins ip_32_intc/irq_11] [get_bd_pins ip_32_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_12
connect_bd_net [get_bd_pins ip_32_intc/irq_12] [get_bd_pins ip_32_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_13
connect_bd_net [get_bd_pins ip_32_intc/irq_13] [get_bd_pins ip_32_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_14
connect_bd_net [get_bd_pins ip_32_intc/irq_14] [get_bd_pins ip_32_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_32_intc/irq_15
connect_bd_net [get_bd_pins ip_32_intc/irq_15] [get_bd_pins ip_32_intc/concat_0/In15]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_32_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_32_intc/irq] [get_bd_intf_pins ip_32_intc/intc_0/interrupt]


########## intc ##########
create_bd_cell -type hier ip_33_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_33_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_33_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 16 " [get_bd_cells ip_33_intc/concat_0]
connect_bd_net [get_bd_pins ip_33_intc/concat_0/dout] [get_bd_pins ip_33_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/clk
connect_bd_net [get_bd_pins ip_33_intc/clk] [get_bd_pins ip_33_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/reset
connect_bd_net [get_bd_pins ip_33_intc/reset] [get_bd_pins ip_33_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_33_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_33_intc/AXI] [get_bd_intf_pins ip_33_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_0
connect_bd_net [get_bd_pins ip_33_intc/irq_0] [get_bd_pins ip_33_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_1
connect_bd_net [get_bd_pins ip_33_intc/irq_1] [get_bd_pins ip_33_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_2
connect_bd_net [get_bd_pins ip_33_intc/irq_2] [get_bd_pins ip_33_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_3
connect_bd_net [get_bd_pins ip_33_intc/irq_3] [get_bd_pins ip_33_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_4
connect_bd_net [get_bd_pins ip_33_intc/irq_4] [get_bd_pins ip_33_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_5
connect_bd_net [get_bd_pins ip_33_intc/irq_5] [get_bd_pins ip_33_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_6
connect_bd_net [get_bd_pins ip_33_intc/irq_6] [get_bd_pins ip_33_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_7
connect_bd_net [get_bd_pins ip_33_intc/irq_7] [get_bd_pins ip_33_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_8
connect_bd_net [get_bd_pins ip_33_intc/irq_8] [get_bd_pins ip_33_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_9
connect_bd_net [get_bd_pins ip_33_intc/irq_9] [get_bd_pins ip_33_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_10
connect_bd_net [get_bd_pins ip_33_intc/irq_10] [get_bd_pins ip_33_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_11
connect_bd_net [get_bd_pins ip_33_intc/irq_11] [get_bd_pins ip_33_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_12
connect_bd_net [get_bd_pins ip_33_intc/irq_12] [get_bd_pins ip_33_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_13
connect_bd_net [get_bd_pins ip_33_intc/irq_13] [get_bd_pins ip_33_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_14
connect_bd_net [get_bd_pins ip_33_intc/irq_14] [get_bd_pins ip_33_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_33_intc/irq_15
connect_bd_net [get_bd_pins ip_33_intc/irq_15] [get_bd_pins ip_33_intc/concat_0/In15]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_33_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_33_intc/irq] [get_bd_intf_pins ip_33_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_34_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_34_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 6 " [get_bd_cells ip_34_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_34_axi_legacy/clk
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_34_axi_legacy/reset
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M0] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M1] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M2] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M3] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M4] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S04_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S04_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S04_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_M5] [get_bd_intf_pins ip_34_axi_legacy/axi_0/S05_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/S05_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/S05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_S0] [get_bd_intf_pins ip_34_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_34_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_34_axi_legacy/AXI_S1] [get_bd_intf_pins ip_34_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_34_axi_legacy/clk] [get_bd_pins ip_34_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_34_axi_legacy/reset] [get_bd_pins ip_34_axi_legacy/axi_0/M01_ARESETN]


########## axi_legacy ##########
create_bd_cell -type hier ip_35_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_35_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_35_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_35_axi_legacy/clk
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_35_axi_legacy/reset
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_M0] [get_bd_intf_pins ip_35_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S0] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S1] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S2] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S3] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S4] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S5] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S6] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S7] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S8] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S9] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S10] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S11] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S12] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M12_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S13] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M13_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M13_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M13_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S14] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M14_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M14_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M14_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_35_axi_legacy/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_35_axi_legacy/AXI_S15] [get_bd_intf_pins ip_35_axi_legacy/axi_0/M15_AXI]
connect_bd_net [get_bd_pins ip_35_axi_legacy/clk] [get_bd_pins ip_35_axi_legacy/axi_0/M15_ACLK]
connect_bd_net [get_bd_pins ip_35_axi_legacy/reset] [get_bd_pins ip_35_axi_legacy/axi_0/M15_ARESETN]


########## axi_legacy ##########
create_bd_cell -type hier ip_36_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_36_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 3 CONFIG.NUM_SI 1 " [get_bd_cells ip_36_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axi_legacy/clk
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_36_axi_legacy/reset
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_M0] [get_bd_intf_pins ip_36_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S0] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S1] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_36_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_36_axi_legacy/AXI_S2] [get_bd_intf_pins ip_36_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_36_axi_legacy/clk] [get_bd_pins ip_36_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_36_axi_legacy/reset] [get_bd_pins ip_36_axi_legacy/axi_0/M02_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_37_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_37_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_37_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_37_axis_broadcaster/aclk] [get_bd_pins ip_37_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_37_axis_broadcaster/aresetn] [get_bd_pins ip_37_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_38_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_38_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_38_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_38_axis_broadcaster/aclk] [get_bd_pins ip_38_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_38_axis_broadcaster/aresetn] [get_bd_pins ip_38_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_39_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_39_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_39_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_39_axis_broadcaster/aclk] [get_bd_pins ip_39_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_39_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_39_axis_broadcaster/aresetn] [get_bd_pins ip_39_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_39_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_40_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_40_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_40_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_40_axis_broadcaster/aclk] [get_bd_pins ip_40_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_40_axis_broadcaster/aresetn] [get_bd_pins ip_40_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_41_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_41_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_41_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_41_axis_broadcaster/aclk] [get_bd_pins ip_41_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_41_axis_broadcaster/aresetn] [get_bd_pins ip_41_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_42_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_42_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aclk] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_42_axis_dwidth_converter/aresetn] [get_bd_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_43_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_43_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_43_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_43_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_43_axis_dwidth_converter/aclk] [get_bd_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_43_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_43_axis_dwidth_converter/aresetn] [get_bd_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_43_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_43_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_44_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_44_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_44_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aclk] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aresetn] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_45_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_45_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_45_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aclk] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_45_axis_dwidth_converter/aresetn] [get_bd_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_46_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_46_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 36 " [get_bd_cells ip_46_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aclk] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aresetn] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_47_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_47_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_47_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aclk] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aresetn] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_48_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_48_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_48_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_48_axis_dwidth_converter/aclk] [get_bd_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_48_axis_dwidth_converter/aresetn] [get_bd_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_49_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_49_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 5 " [get_bd_cells ip_49_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aclk] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aresetn] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_50_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_50_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_50_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_50_axis_dwidth_converter/aclk] [get_bd_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_50_axis_dwidth_converter/aresetn] [get_bd_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_51_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_51_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_51_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_51_axis_combiner/aclk] [get_bd_pins ip_51_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_51_axis_combiner/aresetn] [get_bd_pins ip_51_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/M_AXIS] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_52_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_52_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_52_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_52_axis_dwidth_converter/aclk] [get_bd_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_52_axis_dwidth_converter/aresetn] [get_bd_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_53_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_53_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_53_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_53_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_53_axis_dwidth_converter/aclk] [get_bd_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_53_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_53_axis_dwidth_converter/aresetn] [get_bd_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_53_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_53_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_54_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_54_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_54_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_54_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_54_axis_combiner/aclk] [get_bd_pins ip_54_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_54_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_54_axis_combiner/aresetn] [get_bd_pins ip_54_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_54_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_54_axis_combiner/M_AXIS] [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_55_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_55_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_55_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_55_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_55_axis_dwidth_converter/aclk] [get_bd_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_55_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_55_axis_dwidth_converter/aresetn] [get_bd_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_55_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_55_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_55_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_55_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_56_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_56_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_56_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_56_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_56_axis_dwidth_converter/aclk] [get_bd_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_56_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_56_axis_dwidth_converter/aresetn] [get_bd_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_56_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_56_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_56_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_56_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_57_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_57_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_57_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_57_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_57_axis_dwidth_converter/aclk] [get_bd_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_57_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_57_axis_dwidth_converter/aresetn] [get_bd_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_58_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_58_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_58_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_58_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_1] [get_bd_pins ip_58_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_58_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_2] [get_bd_pins ip_58_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_58_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_3] [get_bd_pins ip_58_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 9 -to 0 ip_58_slice_and_concat/in_4
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_58_slice_and_concat/slice_4]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_4] [get_bd_pins ip_58_slice_and_concat/slice_4/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/slice_4/dout] [get_bd_pins ip_58_slice_and_concat/concat/In4]


########## slice_and_concat ##########
create_bd_cell -type hier ip_59_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_59_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_59_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_59_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 9 -to 0 ip_59_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_59_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_59_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/slice_0/dout] [get_bd_pins ip_59_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 9 -to 0 ip_59_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_59_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_1] [get_bd_pins ip_59_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/slice_1/dout] [get_bd_pins ip_59_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_60_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_60_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_60_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_60_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 9 -to 0 ip_60_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 10 " [get_bd_cells ip_60_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_60_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/slice_0/dout] [get_bd_pins ip_60_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_60_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_1] [get_bd_pins ip_60_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_61_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_61_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_61_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_61_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_61_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_61_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_61_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_61_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_1] [get_bd_pins ip_61_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_61_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_2] [get_bd_pins ip_61_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 7 -to 0 ip_61_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_61_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_61_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_3] [get_bd_pins ip_61_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/slice_3/dout] [get_bd_pins ip_61_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_62_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_62_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_62_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_62_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_62_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_62_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_62_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_63_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_63_slice_and_concat/out0
create_bd_pin -dir I -from 7 -to 0 ip_63_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_63_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_63_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_63_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_63_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_64_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_64_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_64_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_64_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_64_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 7 -to 0 ip_64_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_64_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 8 " [get_bd_cells ip_64_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_64_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/slice_0/dout] [get_bd_pins ip_64_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_64_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_1] [get_bd_pins ip_64_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_65_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_65_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_65_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_65_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_65_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_65_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_1] [get_bd_pins ip_65_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_2] [get_bd_pins ip_65_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_3] [get_bd_pins ip_65_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_4] [get_bd_pins ip_65_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_5] [get_bd_pins ip_65_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_6] [get_bd_pins ip_65_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_7] [get_bd_pins ip_65_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_66_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_66_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_66_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_66_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_66_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_67_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_67_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_67_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_67_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_67_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_68_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_68_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_68_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_68_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_68_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_68_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_69_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_69_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_69_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_69_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_69_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_69_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_70_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_70_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_70_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_70_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_70_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_70_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_70_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_71_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_71_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_71_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_71_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_71_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_0] [get_bd_pins ip_71_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_71_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_72_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_72_slice_and_concat/out0
create_bd_pin -dir I -from 6 -to 0 ip_72_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_72_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 7 " [get_bd_cells ip_72_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/in_0] [get_bd_pins ip_72_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_72_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_73_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_73_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_73_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_74_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_74_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_74_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_75_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_75_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_75_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_76_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_76_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_76_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_29_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_30_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_31_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio_GPIO] [get_bd_intf_pins ip_2_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_3_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_3_uartlite_UART] [get_bd_intf_pins ip_3_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_4_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_hwicap_ICAP] [get_bd_intf_pins ip_4_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_4_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_4_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_6_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic_IIC] [get_bd_intf_pins ip_6_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic_IIC] [get_bd_intf_pins ip_7_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_9_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_9_uartlite_UART] [get_bd_intf_pins ip_9_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_10_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_10_emc_EMC_INTF] [get_bd_intf_pins ip_10_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_12_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic_IIC] [get_bd_intf_pins ip_12_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_16_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_16_axi_quad_spi_IIC] [get_bd_intf_pins ip_16_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_18_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite_UART] [get_bd_intf_pins ip_18_uartlite/UART]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_22_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_22_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_22_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_24_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_24_uartlite_UART] [get_bd_intf_pins ip_24_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_25_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_25_emc_EMC_INTF] [get_bd_intf_pins ip_25_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_26_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_iic_IIC] [get_bd_intf_pins ip_26_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 9 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_58_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 6 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_66_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_67_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_68_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_69_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_70_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_71_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_72_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_31_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_32_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_33_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_2_gpio/rst]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_3_uartlite/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_iic/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_iic/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_9_uartlite/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_10_emc/rst]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_iic/reset]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_13_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_15_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_16_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_30_reset/mb_reset] [get_bd_pins ip_17_microblaze/Reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_18_uartlite/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset] [get_bd_pins ip_20_dft/SCLR]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_21_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset] [get_bd_pins ip_22_xadc_wiz/reset_in]
connect_bd_net [get_bd_pins ip_30_reset/mb_reset] [get_bd_pins ip_23_microblaze/Reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_24_uartlite/reset]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_25_emc/rst]
connect_bd_net [get_bd_pins ip_30_reset/peripheral_areset_n] [get_bd_pins ip_26_axi_iic/reset]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_0_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_2_gpio/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_3_uartlite/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_4_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_5_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_6_axi_iic/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_7_axi_iic/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_8_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_9_uartlite/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_10_emc/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_10_emc/rdclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_11_cordic/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_12_axi_iic/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_13_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_14_floating_point/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_15_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_16_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_16_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_17_microblaze/Clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_18_uartlite/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_19_dft/CLK]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_20_dft/CLK]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_21_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_21_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_22_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_23_microblaze/Clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_24_uartlite/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_25_emc/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_25_emc/rdclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_26_axi_iic/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_27_cordic/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_28_fft/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_29_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_29_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_30_reset/clk_in]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_locked] [get_bd_pins ip_30_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_32_intc/irq_0] [get_bd_pins ip_0_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_32_intc/irq_1] [get_bd_pins ip_1_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_2] [get_bd_pins ip_2_gpio/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_3] [get_bd_pins ip_3_uartlite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_4] [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_32_intc/irq_5] [get_bd_pins ip_6_axi_iic/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_6] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_7] [get_bd_pins ip_9_uartlite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_8] [get_bd_pins ip_12_axi_iic/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_9] [get_bd_pins ip_16_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_10] [get_bd_pins ip_18_uartlite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_11] [get_bd_pins ip_21_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_32_intc/irq_12] [get_bd_pins ip_24_uartlite/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_13] [get_bd_pins ip_26_axi_iic/irq]
connect_bd_net [get_bd_pins ip_32_intc/irq_14] [get_bd_pins ip_28_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_32_intc/irq_15] [get_bd_pins ip_29_axi_cdma/cdma_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_microblaze/INTERRUPT] [get_bd_intf_pins ip_32_intc/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_0] [get_bd_pins ip_0_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_33_intc/irq_1] [get_bd_pins ip_1_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_2] [get_bd_pins ip_2_gpio/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_3] [get_bd_pins ip_3_uartlite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_4] [get_bd_pins ip_4_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_33_intc/irq_5] [get_bd_pins ip_6_axi_iic/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_6] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_7] [get_bd_pins ip_9_uartlite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_8] [get_bd_pins ip_12_axi_iic/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_9] [get_bd_pins ip_16_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_10] [get_bd_pins ip_18_uartlite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_11] [get_bd_pins ip_21_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_33_intc/irq_12] [get_bd_pins ip_24_uartlite/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_13] [get_bd_pins ip_26_axi_iic/irq]
connect_bd_net [get_bd_pins ip_33_intc/irq_14] [get_bd_pins ip_28_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_33_intc/irq_15] [get_bd_pins ip_29_axi_cdma/cdma_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_microblaze/INTERRUPT] [get_bd_intf_pins ip_33_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_34_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_34_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_microblaze/M_AXI_DP] [get_bd_intf_pins ip_34_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_34_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_microblaze/M_AXI_DP] [get_bd_intf_pins ip_34_axi_legacy/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axi_cdma/M_AXI] [get_bd_intf_pins ip_34_axi_legacy/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axi_legacy/AXI_S0] [get_bd_intf_pins ip_35_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_timer/S_AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_uartlite/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_35_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_iic/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_uartlite/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_emc/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_iic/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_35_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_uartlite/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_35_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_uartlite/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_emc/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axi_iic/AXI] [get_bd_intf_pins ip_35_axi_legacy/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axi_legacy/AXI_S1] [get_bd_intf_pins ip_36_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_36_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_intc/AXI] [get_bd_intf_pins ip_36_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_intc/AXI] [get_bd_intf_pins ip_36_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_38_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_39_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_40_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_41_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_floating_point/S_AXIS_A] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_fft/S_AXIS_DATA] [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_40_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_50_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_52_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_51_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_52_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_53_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_53_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_55_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_54_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_55_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_56_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_56_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_57_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_57_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_39_axis_broadcaster/M_AXIS_3]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_0_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_1] [get_bd_pins ip_0_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_2] [get_bd_pins ip_0_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_3] [get_bd_pins ip_19_dft/RFFD]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_4] [get_bd_pins ip_19_dft/XK_RE]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_19_dft/XN_IM]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_19_dft/XK_RE]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_1] [get_bd_pins ip_19_dft/XK_IM]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_20_dft/XN_IM]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_19_dft/XK_IM]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_1] [get_bd_pins ip_19_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_19_dft/XN_RE]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_19_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_1] [get_bd_pins ip_19_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_2] [get_bd_pins ip_20_dft/RFFD]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_3] [get_bd_pins ip_20_dft/XK_RE]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_4_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_20_dft/XK_RE]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_20_dft/SIZE]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_20_dft/XK_IM]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_19_dft/SIZE]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_20_dft/XK_IM]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_1] [get_bd_pins ip_20_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_20_dft/XN_RE]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_20_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_1] [get_bd_pins ip_20_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_2] [get_bd_pins ip_22_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_3] [get_bd_pins ip_22_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_4] [get_bd_pins ip_22_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_5] [get_bd_pins ip_22_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_6] [get_bd_pins ip_22_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_7] [get_bd_pins ip_22_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_13_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_27_cordic/aclken]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_19_dft/FD_IN]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_5_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_19_dft/CE]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_20_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/in_0] [get_bd_pins ip_22_xadc_wiz/vccaux_alarm_out]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_73_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_20_dft/FD_IN]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/in_0] [get_bd_pins ip_22_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_74_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_0_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/in_0] [get_bd_pins ip_22_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_75_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_19_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/in_0] [get_bd_pins ip_22_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_76_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_34_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_35_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_36_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_48_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_49_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_50_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_51_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_52_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_53_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_54_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_55_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_56_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_30_reset/interconnect_aresetn] [get_bd_pins ip_57_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_32_intc/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_33_intc/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_34_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_35_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_36_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_37_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_38_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_39_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_40_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_41_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_45_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_46_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_47_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_48_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_49_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_50_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_51_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_52_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_53_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_54_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_55_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_56_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_31_clk_wiz/clk_out] [get_bd_pins ip_57_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/S_AXIS_S2MM declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/S_AXIS_S2MM declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/M_AXIS_DOUT declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_complex_multiplier/M_AXIS_DOUT declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_B declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/S_AXIS_B declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_complex_multiplier/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_cordic/S_AXIS_CARTESIAN declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_cordic/S_AXIS_CARTESIAN declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_cordic/S_AXIS_PHASE declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_cordic/S_AXIS_PHASE declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_A declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_A declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_complex_multiplier/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_A declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_A declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_cordic/S_AXIS_CARTESIAN declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_cordic/S_AXIS_CARTESIAN declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_cordic/M_AXIS_DOUT declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_cordic/M_AXIS_DOUT declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_fft/S_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_fft/S_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_fft/M_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_fft/M_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 26 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_fft/S_AXIS_CONFIG declared=26 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_fft/S_AXIS_CONFIG declared=26 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_3 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_broadcaster/M_AXIS_3 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_0 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_0 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_1 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_broadcaster/M_AXIS_1 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_3 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_broadcaster/M_AXIS_3 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
