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



########## axi_hwicap ##########
create_bd_cell -type hier ip_0_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_0_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_0_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_0_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_0_axi_hwicap/icap_clk] [get_bd_pins ip_0_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_0_axi_hwicap/eos_in] [get_bd_pins ip_0_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_0_axi_hwicap/s_axi_aclk] [get_bd_pins ip_0_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_0_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_0_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_0_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_0_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## dft ##########
create_bd_cell -type hier ip_1_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_1_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 8 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_1_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/CLK
connect_bd_net [get_bd_pins ip_1_dft/CLK] [get_bd_pins ip_1_dft/dft_0/CLK]
create_bd_pin -dir I -from 7 -to 0 ip_1_dft/XN_RE
connect_bd_net [get_bd_pins ip_1_dft/XN_RE] [get_bd_pins ip_1_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 7 -to 0 ip_1_dft/XN_IM
connect_bd_net [get_bd_pins ip_1_dft/XN_IM] [get_bd_pins ip_1_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FD_IN
connect_bd_net [get_bd_pins ip_1_dft/FD_IN] [get_bd_pins ip_1_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_1_dft/FWD_INV
connect_bd_net [get_bd_pins ip_1_dft/FWD_INV] [get_bd_pins ip_1_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_1_dft/SIZE
connect_bd_net [get_bd_pins ip_1_dft/SIZE] [get_bd_pins ip_1_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/RFFD
connect_bd_net [get_bd_pins ip_1_dft/RFFD] [get_bd_pins ip_1_dft/dft_0/RFFD]
create_bd_pin -dir O -from 7 -to 0 ip_1_dft/XK_RE
connect_bd_net [get_bd_pins ip_1_dft/XK_RE] [get_bd_pins ip_1_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 7 -to 0 ip_1_dft/XK_IM
connect_bd_net [get_bd_pins ip_1_dft/XK_IM] [get_bd_pins ip_1_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_1_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_1_dft/BLK_EXP] [get_bd_pins ip_1_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/FD_OUT
connect_bd_net [get_bd_pins ip_1_dft/FD_OUT] [get_bd_pins ip_1_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_1_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_1_dft/DATA_VALID] [get_bd_pins ip_1_dft/dft_0/DATA_VALID]


########## uartlite ##########
create_bd_cell -type hier ip_2_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_2_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 230400 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Even " [get_bd_cells ip_2_uartlite/uart_0]
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


########## dft ##########
create_bd_cell -type hier ip_3_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_3_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 13 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_3_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/CLK
connect_bd_net [get_bd_pins ip_3_dft/CLK] [get_bd_pins ip_3_dft/dft_0/CLK]
create_bd_pin -dir I -from 12 -to 0 ip_3_dft/XN_RE
connect_bd_net [get_bd_pins ip_3_dft/XN_RE] [get_bd_pins ip_3_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 12 -to 0 ip_3_dft/XN_IM
connect_bd_net [get_bd_pins ip_3_dft/XN_IM] [get_bd_pins ip_3_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FD_IN
connect_bd_net [get_bd_pins ip_3_dft/FD_IN] [get_bd_pins ip_3_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FWD_INV
connect_bd_net [get_bd_pins ip_3_dft/FWD_INV] [get_bd_pins ip_3_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_3_dft/SIZE
connect_bd_net [get_bd_pins ip_3_dft/SIZE] [get_bd_pins ip_3_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/RFFD
connect_bd_net [get_bd_pins ip_3_dft/RFFD] [get_bd_pins ip_3_dft/dft_0/RFFD]
create_bd_pin -dir O -from 12 -to 0 ip_3_dft/XK_RE
connect_bd_net [get_bd_pins ip_3_dft/XK_RE] [get_bd_pins ip_3_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 12 -to 0 ip_3_dft/XK_IM
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
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 16 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_4_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CLK
connect_bd_net [get_bd_pins ip_4_dft/CLK] [get_bd_pins ip_4_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CE
connect_bd_net [get_bd_pins ip_4_dft/CE] [get_bd_pins ip_4_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/SCLR
connect_bd_net [get_bd_pins ip_4_dft/SCLR] [get_bd_pins ip_4_dft/dft_0/SCLR]
create_bd_pin -dir I -from 15 -to 0 ip_4_dft/XN_RE
connect_bd_net [get_bd_pins ip_4_dft/XN_RE] [get_bd_pins ip_4_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 15 -to 0 ip_4_dft/XN_IM
connect_bd_net [get_bd_pins ip_4_dft/XN_IM] [get_bd_pins ip_4_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FD_IN
connect_bd_net [get_bd_pins ip_4_dft/FD_IN] [get_bd_pins ip_4_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FWD_INV
connect_bd_net [get_bd_pins ip_4_dft/FWD_INV] [get_bd_pins ip_4_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_4_dft/SIZE
connect_bd_net [get_bd_pins ip_4_dft/SIZE] [get_bd_pins ip_4_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/RFFD
connect_bd_net [get_bd_pins ip_4_dft/RFFD] [get_bd_pins ip_4_dft/dft_0/RFFD]
create_bd_pin -dir O -from 15 -to 0 ip_4_dft/XK_RE
connect_bd_net [get_bd_pins ip_4_dft/XK_RE] [get_bd_pins ip_4_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 15 -to 0 ip_4_dft/XK_IM
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
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x71 CONFIG.C_GPO_WIDTH 4 CONFIG.C_SCL_INERTIAL_DELAY 80 CONFIG.C_SDA_INERTIAL_DELAY 199 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 854.3548189369286 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
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


########## gpio ##########
create_bd_cell -type hier ip_6_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_6_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0xf CONFIG.C_GPIO_WIDTH 4 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_6_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/GPIO] [get_bd_intf_pins ip_6_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/clk
connect_bd_net [get_bd_pins ip_6_gpio/clk] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/rst
connect_bd_net [get_bd_pins ip_6_gpio/rst] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_6_gpio/gpio_0/S_AXI]


########## axi_cdma ##########
create_bd_cell -type hier ip_7_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_7_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 43 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_7_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_7_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_7_axi_cdma/m_axi_aclk] [get_bd_pins ip_7_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_7_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_7_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_7_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_7_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_cdma/M_AXI] [get_bd_intf_pins ip_7_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_7_axi_cdma/cdma_introut] [get_bd_pins ip_7_axi_cdma/axi_cdma_0/cdma_introut]


########## microblaze ##########
create_bd_cell -type hier ip_8_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 52 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_NUMBER_OF_PC_BRK 1 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 0 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 2 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0xcc CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_8_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_microblaze/Clk
connect_bd_net [get_bd_pins ip_8_microblaze/Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_8_microblaze/Reset
connect_bd_net [get_bd_pins ip_8_microblaze/Reset] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_8_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/INTERRUPT] [get_bd_intf_pins ip_8_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/M_AXI_DP] [get_bd_intf_pins ip_8_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_8_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_8_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x4ed0e00643fa8ba CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_8_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_8_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_8_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_8_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x1b242c563f61a0f CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_8_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_8_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_8_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_8_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_8_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 4 " [get_bd_cells ip_8_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_8_microblaze/microblaze_0/DEBUG]


########## dft ##########
create_bd_cell -type hier ip_9_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_9_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 18 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_9_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/CLK
connect_bd_net [get_bd_pins ip_9_dft/CLK] [get_bd_pins ip_9_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/CE
connect_bd_net [get_bd_pins ip_9_dft/CE] [get_bd_pins ip_9_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/SCLR
connect_bd_net [get_bd_pins ip_9_dft/SCLR] [get_bd_pins ip_9_dft/dft_0/SCLR]
create_bd_pin -dir I -from 17 -to 0 ip_9_dft/XN_RE
connect_bd_net [get_bd_pins ip_9_dft/XN_RE] [get_bd_pins ip_9_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 17 -to 0 ip_9_dft/XN_IM
connect_bd_net [get_bd_pins ip_9_dft/XN_IM] [get_bd_pins ip_9_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/FD_IN
connect_bd_net [get_bd_pins ip_9_dft/FD_IN] [get_bd_pins ip_9_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_9_dft/FWD_INV
connect_bd_net [get_bd_pins ip_9_dft/FWD_INV] [get_bd_pins ip_9_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_9_dft/SIZE
connect_bd_net [get_bd_pins ip_9_dft/SIZE] [get_bd_pins ip_9_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_9_dft/RFFD
connect_bd_net [get_bd_pins ip_9_dft/RFFD] [get_bd_pins ip_9_dft/dft_0/RFFD]
create_bd_pin -dir O -from 17 -to 0 ip_9_dft/XK_RE
connect_bd_net [get_bd_pins ip_9_dft/XK_RE] [get_bd_pins ip_9_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 17 -to 0 ip_9_dft/XK_IM
connect_bd_net [get_bd_pins ip_9_dft/XK_IM] [get_bd_pins ip_9_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_9_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_9_dft/BLK_EXP] [get_bd_pins ip_9_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_9_dft/FD_OUT
connect_bd_net [get_bd_pins ip_9_dft/FD_OUT] [get_bd_pins ip_9_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_9_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_9_dft/DATA_VALID] [get_bd_pins ip_9_dft/dft_0/DATA_VALID]


########## axi_timer ##########
create_bd_cell -type hier ip_10_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_10_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 32 CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.enable_timer2 0 CONFIG.mode_64bit 0 " [get_bd_cells ip_10_axi_timer/axi_timer_0]
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


########## dft ##########
create_bd_cell -type hier ip_11_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_11_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 12 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_11_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_dft/CLK
connect_bd_net [get_bd_pins ip_11_dft/CLK] [get_bd_pins ip_11_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_11_dft/SCLR
connect_bd_net [get_bd_pins ip_11_dft/SCLR] [get_bd_pins ip_11_dft/dft_0/SCLR]
create_bd_pin -dir I -from 11 -to 0 ip_11_dft/XN_RE
connect_bd_net [get_bd_pins ip_11_dft/XN_RE] [get_bd_pins ip_11_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 11 -to 0 ip_11_dft/XN_IM
connect_bd_net [get_bd_pins ip_11_dft/XN_IM] [get_bd_pins ip_11_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_11_dft/FD_IN
connect_bd_net [get_bd_pins ip_11_dft/FD_IN] [get_bd_pins ip_11_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_11_dft/FWD_INV
connect_bd_net [get_bd_pins ip_11_dft/FWD_INV] [get_bd_pins ip_11_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_11_dft/SIZE
connect_bd_net [get_bd_pins ip_11_dft/SIZE] [get_bd_pins ip_11_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_11_dft/RFFD
connect_bd_net [get_bd_pins ip_11_dft/RFFD] [get_bd_pins ip_11_dft/dft_0/RFFD]
create_bd_pin -dir O -from 11 -to 0 ip_11_dft/XK_RE
connect_bd_net [get_bd_pins ip_11_dft/XK_RE] [get_bd_pins ip_11_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 11 -to 0 ip_11_dft/XK_IM
connect_bd_net [get_bd_pins ip_11_dft/XK_IM] [get_bd_pins ip_11_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_11_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_11_dft/BLK_EXP] [get_bd_pins ip_11_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_11_dft/FD_OUT
connect_bd_net [get_bd_pins ip_11_dft/FD_OUT] [get_bd_pins ip_11_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_11_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_11_dft/DATA_VALID] [get_bd_pins ip_11_dft/dft_0/DATA_VALID]


########## conv_encoder ##########
create_bd_cell -type hier ip_12_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_12_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 6 CONFIG.convolution_code0 25 CONFIG.convolution_code1 16 CONFIG.convolution_code2 39 CONFIG.convolution_code3 7 CONFIG.convolution_code4 23 CONFIG.convolution_code5 29 CONFIG.convolution_code6 5 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 6 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_12_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_12_conv_encoder/aclk] [get_bd_pins ip_12_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_12_conv_encoder/aresetn] [get_bd_pins ip_12_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_12_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_12_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_12_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_12_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_cdma ##########
create_bd_cell -type hier ip_13_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_13_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 55 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_13_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_13_axi_cdma/m_axi_aclk] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_13_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_13_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_cdma/M_AXI] [get_bd_intf_pins ip_13_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_13_axi_cdma/cdma_introut] [get_bd_pins ip_13_axi_cdma/axi_cdma_0/cdma_introut]


########## complex_multiplier ##########
create_bd_cell -type hier ip_14_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_14_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 18 CONFIG.aresetn 1 CONFIG.atuserwidth 117 CONFIG.bportwidth 32 CONFIG.btuserwidth 114 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 35 CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 50 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_14_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_14_complex_multiplier/aclk] [get_bd_pins ip_14_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_14_complex_multiplier/aresetn] [get_bd_pins ip_14_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_14_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_cdma ##########
create_bd_cell -type hier ip_15_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_15_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 32 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 4 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_15_axi_cdma/axi_cdma_0]
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
set_property -dict "CONFIG.C_ADDR_WIDTH 32 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 2 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_16_axi_cdma/axi_cdma_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_17_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_17_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x42 CONFIG.C_GPO_WIDTH 7 CONFIG.C_SCL_INERTIAL_DELAY 90 CONFIG.C_SDA_INERTIAL_DELAY 239 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 202.7114992960531 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_17_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_17_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_iic/IIC] [get_bd_intf_pins ip_17_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_iic/clk
connect_bd_net [get_bd_pins ip_17_axi_iic/clk] [get_bd_pins ip_17_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_iic/reset
connect_bd_net [get_bd_pins ip_17_axi_iic/reset] [get_bd_pins ip_17_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_iic/AXI] [get_bd_intf_pins ip_17_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_iic/irq
connect_bd_net [get_bd_pins ip_17_axi_iic/irq] [get_bd_pins ip_17_axi_iic/axi_iic_0/iic2intc_irpt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_18_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_18_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 32 CONFIG.aresetn 1 CONFIG.atuserwidth 26 CONFIG.bportwidth 17 CONFIG.btuserwidth 114 CONFIG.ctrltuserwidth 243 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 32 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_18_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_18_complex_multiplier/aclk] [get_bd_pins ip_18_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_18_complex_multiplier/aresetn] [get_bd_pins ip_18_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_18_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## xadc_wiz ##########
create_bd_cell -type hier ip_19_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_19_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_TEMP_BUS 1 CONFIG.ENABLE_VBRAM_ALARM 1 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION channel_sequencer " [get_bd_cells ip_19_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_19_xadc_wiz/s_axi_aclk] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_19_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_19_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_19_xadc_wiz/convst_in] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_19_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_19_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_19_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_19_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_19_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_19_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_19_xadc_wiz/vbram_alarm_out
connect_bd_net [get_bd_pins ip_19_xadc_wiz/vbram_alarm_out] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/vbram_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_19_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_19_xadc_wiz/eoc_out] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_19_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_19_xadc_wiz/eos_out] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_19_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_19_xadc_wiz/alarm_out] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_19_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_19_xadc_wiz/busy_out] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_19_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_19_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_19_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 11 -to 0 ip_19_xadc_wiz/temp_out
connect_bd_net [get_bd_pins ip_19_xadc_wiz/temp_out] [get_bd_pins ip_19_xadc_wiz/xadc_wiz_0/temp_out]


########## gpio ##########
create_bd_cell -type hier ip_20_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_20_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_GPIO_WIDTH 14 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_20_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_20_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_20_gpio/GPIO] [get_bd_intf_pins ip_20_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_20_gpio/clk
connect_bd_net [get_bd_pins ip_20_gpio/clk] [get_bd_pins ip_20_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_gpio/rst
connect_bd_net [get_bd_pins ip_20_gpio/rst] [get_bd_pins ip_20_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_20_gpio/AXI] [get_bd_intf_pins ip_20_gpio/gpio_0/S_AXI]


########## emc ##########
create_bd_cell -type hier ip_21_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_21_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 2 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 64 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 7 CONFIG.C_TAVDV_PS_MEM_0 16460 CONFIG.C_TAVDV_PS_MEM_1 16330 CONFIG.C_TAVDV_PS_MEM_2 15115 CONFIG.C_TCEDV_PS_MEM_0 14275 CONFIG.C_TCEDV_PS_MEM_1 13860 CONFIG.C_TCEDV_PS_MEM_2 14113 CONFIG.C_THZCE_PS_MEM_0 7216 CONFIG.C_THZCE_PS_MEM_1 7304 CONFIG.C_THZCE_PS_MEM_2 6639 CONFIG.C_THZOE_PS_MEM_0 6846 CONFIG.C_THZOE_PS_MEM_1 7467 CONFIG.C_THZOE_PS_MEM_2 7250 CONFIG.C_TLZWE_PS_MEM_0 8745 CONFIG.C_TLZWE_PS_MEM_1 2359 CONFIG.C_TLZWE_PS_MEM_2 4389 CONFIG.C_TWC_PS_MEM_0 14646 CONFIG.C_TWC_PS_MEM_1 15155 CONFIG.C_TWC_PS_MEM_2 14774 CONFIG.C_TWPH_PS_MEM_0 11909 CONFIG.C_TWPH_PS_MEM_1 11525 CONFIG.C_TWPH_PS_MEM_2 12110 CONFIG.C_TWP_PS_MEM_0 11982 CONFIG.C_TWP_PS_MEM_1 11788 CONFIG.C_TWP_PS_MEM_2 12402 CONFIG.C_WR_REC_TIME_MEM_0 24503 CONFIG.C_WR_REC_TIME_MEM_1 29201 CONFIG.C_WR_REC_TIME_MEM_2 29553 " [get_bd_cells ip_21_emc/emc_0]
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


########## complex_multiplier ##########
create_bd_cell -type hier ip_22_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_22_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 61 CONFIG.aresetn 0 CONFIG.bportwidth 12 CONFIG.btuserwidth 118 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 4 CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 61 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_22_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_22_complex_multiplier/aclk] [get_bd_pins ip_22_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_22_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_22_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_22_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_22_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_22_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_22_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_23_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_23_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_MDIO 0 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_23_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_23_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_ethernet_lite/MII] [get_bd_intf_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_23_axi_ethernet_lite/clk] [get_bd_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_23_axi_ethernet_lite/reset] [get_bd_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_23_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_23_axi_ethernet_lite/irq] [get_bd_pins ip_23_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_24_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_24_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 55 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_24_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_24_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_24_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_24_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_24_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_24_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_24_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_24_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_24_axi_dma/axi_resetn] [get_bd_pins ip_24_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_24_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_24_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_24_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_24_axi_dma/mm2s_introut] [get_bd_pins ip_24_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_24_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_24_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_24_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_24_axi_dma/s2mm_introut] [get_bd_pins ip_24_axi_dma/axi_dma_0/s2mm_introut]


########## complex_multiplier ##########
create_bd_cell -type hier ip_25_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_25_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 53 CONFIG.aresetn 0 CONFIG.atuserwidth 26 CONFIG.bportwidth 54 CONFIG.btuserwidth 127 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 21 CONFIG.roundmode Truncate " [get_bd_cells ip_25_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_25_complex_multiplier/aclk] [get_bd_pins ip_25_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_25_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_25_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_25_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## dft ##########
create_bd_cell -type hier ip_26_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_26_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 17 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_26_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_dft/CLK
connect_bd_net [get_bd_pins ip_26_dft/CLK] [get_bd_pins ip_26_dft/dft_0/CLK]
create_bd_pin -dir I -from 16 -to 0 ip_26_dft/XN_RE
connect_bd_net [get_bd_pins ip_26_dft/XN_RE] [get_bd_pins ip_26_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 16 -to 0 ip_26_dft/XN_IM
connect_bd_net [get_bd_pins ip_26_dft/XN_IM] [get_bd_pins ip_26_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_26_dft/FD_IN
connect_bd_net [get_bd_pins ip_26_dft/FD_IN] [get_bd_pins ip_26_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_26_dft/FWD_INV
connect_bd_net [get_bd_pins ip_26_dft/FWD_INV] [get_bd_pins ip_26_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_26_dft/SIZE
connect_bd_net [get_bd_pins ip_26_dft/SIZE] [get_bd_pins ip_26_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_26_dft/RFFD
connect_bd_net [get_bd_pins ip_26_dft/RFFD] [get_bd_pins ip_26_dft/dft_0/RFFD]
create_bd_pin -dir O -from 16 -to 0 ip_26_dft/XK_RE
connect_bd_net [get_bd_pins ip_26_dft/XK_RE] [get_bd_pins ip_26_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 16 -to 0 ip_26_dft/XK_IM
connect_bd_net [get_bd_pins ip_26_dft/XK_IM] [get_bd_pins ip_26_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_26_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_26_dft/BLK_EXP] [get_bd_pins ip_26_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_26_dft/FD_OUT
connect_bd_net [get_bd_pins ip_26_dft/FD_OUT] [get_bd_pins ip_26_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_26_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_26_dft/DATA_VALID] [get_bd_pins ip_26_dft/dft_0/DATA_VALID]


########## microblaze ##########
create_bd_cell -type hier ip_27_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_27_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 44 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 2 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 1 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0xf3 CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 0 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_27_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_microblaze/Clk
connect_bd_net [get_bd_pins ip_27_microblaze/Clk] [get_bd_pins ip_27_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_27_microblaze/Reset
connect_bd_net [get_bd_pins ip_27_microblaze/Reset] [get_bd_pins ip_27_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_27_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_27_microblaze/INTERRUPT] [get_bd_intf_pins ip_27_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_27_microblaze/M_AXI_DP] [get_bd_intf_pins ip_27_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_27_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_27_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_27_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_27_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_27_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_27_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_27_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_27_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_27_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xb60b84b0014700a CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_27_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_27_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_27_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_27_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_27_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_27_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_27_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_27_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_27_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_27_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_27_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_27_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_27_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_27_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_27_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_27_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xacd2c1605adda59 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_27_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_27_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_27_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_27_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_27_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_27_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_27_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_27_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_27_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_27_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_27_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_27_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_27_microblaze/mem/BRAM_PORTB]


########## reset ##########
create_bd_cell -type hier ip_28_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_28_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_28_reset/clk_in
connect_bd_net [get_bd_pins ip_28_reset/clk_in] [get_bd_pins ip_28_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_28_reset/reset_in
connect_bd_net [get_bd_pins ip_28_reset/reset_in] [get_bd_pins ip_28_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_28_reset/dcm_locked
connect_bd_net [get_bd_pins ip_28_reset/dcm_locked] [get_bd_pins ip_28_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_28_reset/mb_reset
connect_bd_net [get_bd_pins ip_28_reset/mb_reset] [get_bd_pins ip_28_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_28_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_28_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_28_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset] [get_bd_pins ip_28_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_28_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_28_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_29_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_29_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_in] [get_bd_pins ip_29_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_29_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_29_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_29_clk_wiz/reset
connect_bd_net [get_bd_pins ip_29_clk_wiz/reset] [get_bd_pins ip_29_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_29_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_locked] [get_bd_pins ip_29_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_30_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_30_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_30_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 13 " [get_bd_cells ip_30_intc/concat_0]
connect_bd_net [get_bd_pins ip_30_intc/concat_0/dout] [get_bd_pins ip_30_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/clk
connect_bd_net [get_bd_pins ip_30_intc/clk] [get_bd_pins ip_30_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/reset
connect_bd_net [get_bd_pins ip_30_intc/reset] [get_bd_pins ip_30_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_30_intc/AXI] [get_bd_intf_pins ip_30_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_0
connect_bd_net [get_bd_pins ip_30_intc/irq_0] [get_bd_pins ip_30_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_1
connect_bd_net [get_bd_pins ip_30_intc/irq_1] [get_bd_pins ip_30_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_2
connect_bd_net [get_bd_pins ip_30_intc/irq_2] [get_bd_pins ip_30_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_3
connect_bd_net [get_bd_pins ip_30_intc/irq_3] [get_bd_pins ip_30_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_4
connect_bd_net [get_bd_pins ip_30_intc/irq_4] [get_bd_pins ip_30_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_5
connect_bd_net [get_bd_pins ip_30_intc/irq_5] [get_bd_pins ip_30_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_6
connect_bd_net [get_bd_pins ip_30_intc/irq_6] [get_bd_pins ip_30_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_7
connect_bd_net [get_bd_pins ip_30_intc/irq_7] [get_bd_pins ip_30_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_8
connect_bd_net [get_bd_pins ip_30_intc/irq_8] [get_bd_pins ip_30_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_9
connect_bd_net [get_bd_pins ip_30_intc/irq_9] [get_bd_pins ip_30_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_10
connect_bd_net [get_bd_pins ip_30_intc/irq_10] [get_bd_pins ip_30_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_11
connect_bd_net [get_bd_pins ip_30_intc/irq_11] [get_bd_pins ip_30_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_12
connect_bd_net [get_bd_pins ip_30_intc/irq_12] [get_bd_pins ip_30_intc/concat_0/In12]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_30_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_30_intc/irq] [get_bd_intf_pins ip_30_intc/intc_0/interrupt]


########## intc ##########
create_bd_cell -type hier ip_31_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_31_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_31_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 13 " [get_bd_cells ip_31_intc/concat_0]
connect_bd_net [get_bd_pins ip_31_intc/concat_0/dout] [get_bd_pins ip_31_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/clk
connect_bd_net [get_bd_pins ip_31_intc/clk] [get_bd_pins ip_31_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/reset
connect_bd_net [get_bd_pins ip_31_intc/reset] [get_bd_pins ip_31_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_31_intc/AXI] [get_bd_intf_pins ip_31_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_0
connect_bd_net [get_bd_pins ip_31_intc/irq_0] [get_bd_pins ip_31_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_1
connect_bd_net [get_bd_pins ip_31_intc/irq_1] [get_bd_pins ip_31_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_2
connect_bd_net [get_bd_pins ip_31_intc/irq_2] [get_bd_pins ip_31_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_3
connect_bd_net [get_bd_pins ip_31_intc/irq_3] [get_bd_pins ip_31_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_4
connect_bd_net [get_bd_pins ip_31_intc/irq_4] [get_bd_pins ip_31_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_5
connect_bd_net [get_bd_pins ip_31_intc/irq_5] [get_bd_pins ip_31_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_6
connect_bd_net [get_bd_pins ip_31_intc/irq_6] [get_bd_pins ip_31_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_7
connect_bd_net [get_bd_pins ip_31_intc/irq_7] [get_bd_pins ip_31_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_8
connect_bd_net [get_bd_pins ip_31_intc/irq_8] [get_bd_pins ip_31_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_9
connect_bd_net [get_bd_pins ip_31_intc/irq_9] [get_bd_pins ip_31_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_10
connect_bd_net [get_bd_pins ip_31_intc/irq_10] [get_bd_pins ip_31_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_11
connect_bd_net [get_bd_pins ip_31_intc/irq_11] [get_bd_pins ip_31_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_31_intc/irq_12
connect_bd_net [get_bd_pins ip_31_intc/irq_12] [get_bd_pins ip_31_intc/concat_0/In12]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_31_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_31_intc/irq] [get_bd_intf_pins ip_31_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_32_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_32_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 8 " [get_bd_cells ip_32_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axi/clk
connect_bd_net [get_bd_pins ip_32_axi/clk] [get_bd_pins ip_32_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axi/reset
connect_bd_net [get_bd_pins ip_32_axi/reset] [get_bd_pins ip_32_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M0] [get_bd_intf_pins ip_32_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M1] [get_bd_intf_pins ip_32_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M2] [get_bd_intf_pins ip_32_axi/axi_0/S02_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M3] [get_bd_intf_pins ip_32_axi/axi_0/S03_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M4] [get_bd_intf_pins ip_32_axi/axi_0/S04_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M5] [get_bd_intf_pins ip_32_axi/axi_0/S05_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M6
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M6] [get_bd_intf_pins ip_32_axi/axi_0/S06_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_M7
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_M7] [get_bd_intf_pins ip_32_axi/axi_0/S07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S0] [get_bd_intf_pins ip_32_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S1] [get_bd_intf_pins ip_32_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S2] [get_bd_intf_pins ip_32_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S3] [get_bd_intf_pins ip_32_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S4] [get_bd_intf_pins ip_32_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S5] [get_bd_intf_pins ip_32_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S6] [get_bd_intf_pins ip_32_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S7] [get_bd_intf_pins ip_32_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S8] [get_bd_intf_pins ip_32_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S9] [get_bd_intf_pins ip_32_axi/axi_0/M09_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S10] [get_bd_intf_pins ip_32_axi/axi_0/M10_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S11] [get_bd_intf_pins ip_32_axi/axi_0/M11_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S12] [get_bd_intf_pins ip_32_axi/axi_0/M12_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S13] [get_bd_intf_pins ip_32_axi/axi_0/M13_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S14] [get_bd_intf_pins ip_32_axi/axi_0/M14_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_32_axi/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_32_axi/AXI_S15] [get_bd_intf_pins ip_32_axi/axi_0/M15_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_33_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_33_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_33_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_33_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_34_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_34_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_34_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_36_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_36_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_36_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_36_axis_broadcaster/aclk] [get_bd_pins ip_36_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_36_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_36_axis_broadcaster/aresetn] [get_bd_pins ip_36_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_36_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_38_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_38_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_38_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_40_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_44_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_45_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_46_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_47_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aclk] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_47_axis_dwidth_converter/aresetn] [get_bd_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_48_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_48_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_48_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_48_axis_combiner/aclk] [get_bd_pins ip_48_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_48_axis_combiner/aresetn] [get_bd_pins ip_48_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/M_AXIS] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_49_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_49_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_49_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_50_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_51_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_51_axis_combiner/aclk] [get_bd_pins ip_51_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_51_axis_combiner/aresetn] [get_bd_pins ip_51_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_combiner/M_AXIS] [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_52_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_52_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_52_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_52_axis_dwidth_converter/aclk] [get_bd_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_52_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_52_axis_dwidth_converter/aresetn] [get_bd_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_52_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_52_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_53_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_53_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_53_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_53_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 7 -to 0 ip_53_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_1] [get_bd_pins ip_53_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 7 -to 0 ip_53_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_2] [get_bd_pins ip_53_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 3 -to 0 ip_53_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_53_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_3] [get_bd_pins ip_53_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/slice_3/dout] [get_bd_pins ip_53_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 22 -to 0 ip_54_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_54_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_54_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_54_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_54_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/slice_0/dout] [get_bd_pins ip_54_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_1] [get_bd_pins ip_54_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_2] [get_bd_pins ip_54_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_54_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_3] [get_bd_pins ip_54_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 12 -to 0 ip_54_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_4] [get_bd_pins ip_54_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 12 -to 0 ip_54_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_54_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_5] [get_bd_pins ip_54_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/slice_5/dout] [get_bd_pins ip_54_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_55_slice_and_concat/out0
create_bd_pin -dir I -from 12 -to 0 ip_55_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_55_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_55_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_56_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_56_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 12 -to 0 ip_56_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_56_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_56_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/slice_0/dout] [get_bd_pins ip_56_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_56_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_1] [get_bd_pins ip_56_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_56_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_2] [get_bd_pins ip_56_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_57_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_57_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_57_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_57_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_57_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_1] [get_bd_pins ip_57_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 15 -to 0 ip_57_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_57_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_2] [get_bd_pins ip_57_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/slice_2/dout] [get_bd_pins ip_57_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 15 -to 0 ip_58_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_58_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_59_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_59_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_59_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_59_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 15 -to 0 ip_59_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_59_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_59_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/slice_0/dout] [get_bd_pins ip_59_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 15 -to 0 ip_59_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_59_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 8 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_59_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_1] [get_bd_pins ip_59_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/slice_1/dout] [get_bd_pins ip_59_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_60_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_60_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_60_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_60_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 15 -to 0 ip_60_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 9 CONFIG.DIN_WIDTH 16 " [get_bd_cells ip_60_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_60_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/slice_0/dout] [get_bd_pins ip_60_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_60_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_1] [get_bd_pins ip_60_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_60_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_2] [get_bd_pins ip_60_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_60_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_3] [get_bd_pins ip_60_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_60_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_4] [get_bd_pins ip_60_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 17 -to 0 ip_60_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_60_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_60_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_5] [get_bd_pins ip_60_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/slice_5/dout] [get_bd_pins ip_60_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_61_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_61_slice_and_concat/out0
create_bd_pin -dir I -from 17 -to 0 ip_61_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_61_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_61_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_61_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_61_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_62_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_62_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_62_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_62_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_62_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 17 -to 0 ip_62_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_62_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_62_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_62_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/slice_0/dout] [get_bd_pins ip_62_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 17 -to 0 ip_62_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_62_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_62_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_1] [get_bd_pins ip_62_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/slice_1/dout] [get_bd_pins ip_62_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_63_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_63_slice_and_concat/out0
create_bd_pin -dir I -from 17 -to 0 ip_63_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_63_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_63_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_63_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_63_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_64_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_64_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_64_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_64_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_64_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 17 -to 0 ip_64_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_64_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 17 CONFIG.DIN_WIDTH 18 " [get_bd_cells ip_64_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_64_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/slice_0/dout] [get_bd_pins ip_64_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_64_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_1] [get_bd_pins ip_64_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_64_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_2] [get_bd_pins ip_64_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_65_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_65_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_65_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_65_slice_and_concat/concat]
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
create_bd_pin -dir I -from 11 -to 0 ip_65_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_65_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_65_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_5] [get_bd_pins ip_65_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/slice_5/dout] [get_bd_pins ip_65_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_66_slice_and_concat
create_bd_pin -dir O -from 15 -to 0 ip_66_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_66_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_66_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_66_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_66_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/slice_0/dout] [get_bd_pins ip_66_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 11 -to 0 ip_66_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_66_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_1] [get_bd_pins ip_66_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/slice_1/dout] [get_bd_pins ip_66_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_67_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_67_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_67_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_67_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_67_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_67_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/slice_0/dout] [get_bd_pins ip_67_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_67_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_1] [get_bd_pins ip_67_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_67_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_2] [get_bd_pins ip_67_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_67_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_3] [get_bd_pins ip_67_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_67_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_4] [get_bd_pins ip_67_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_67_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_5] [get_bd_pins ip_67_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_67_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_6] [get_bd_pins ip_67_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 11 -to 0 ip_67_slice_and_concat/in_7
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_67_slice_and_concat/slice_7]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_7] [get_bd_pins ip_67_slice_and_concat/slice_7/din]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/slice_7/dout] [get_bd_pins ip_67_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_68_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_68_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_68_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_68_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_68_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_68_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_68_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_68_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/slice_0/dout] [get_bd_pins ip_68_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_68_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_1] [get_bd_pins ip_68_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_69_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_69_slice_and_concat/out0
create_bd_pin -dir I -from 16 -to 0 ip_69_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_69_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_69_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_69_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_70_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_70_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_70_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_70_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_70_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_70_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_70_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_70_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_70_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/slice_0/dout] [get_bd_pins ip_70_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 16 -to 0 ip_70_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_70_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_70_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_1] [get_bd_pins ip_70_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/slice_1/dout] [get_bd_pins ip_70_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_71_slice_and_concat
create_bd_pin -dir O -from 15 -to 0 ip_71_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_71_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_71_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_71_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_71_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_71_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_71_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_0] [get_bd_pins ip_71_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/slice_0/dout] [get_bd_pins ip_71_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_71_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_1] [get_bd_pins ip_71_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_71_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_2] [get_bd_pins ip_71_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_72_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_72_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_72_slice_and_concat/in_0


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


########## slice_and_concat ##########
create_bd_cell -type hier ip_77_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_77_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_77_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_78_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_78_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_78_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_79_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_79_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_79_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_80_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_80_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_80_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_81_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_81_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_81_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_82_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_82_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_82_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_83_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_83_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_83_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_84_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_84_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_84_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_85_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_85_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_85_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_86_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_86_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_86_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_87_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_87_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_87_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_88_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_88_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_88_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_89_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_89_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_89_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_90_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_90_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_90_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_28_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_29_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite_UART] [get_bd_intf_pins ip_2_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio_GPIO] [get_bd_intf_pins ip_6_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_17_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_iic_IIC] [get_bd_intf_pins ip_17_axi_iic/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_19_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_19_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_19_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_20_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_20_gpio_GPIO] [get_bd_intf_pins ip_20_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_21_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_21_emc_EMC_INTF] [get_bd_intf_pins ip_21_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_23_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_ethernet_lite_MII] [get_bd_intf_pins ip_23_axi_ethernet_lite/MII]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 22 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_54_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_29_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_30_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_31_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_2_uartlite/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset] [get_bd_pins ip_4_dft/SCLR]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_6_gpio/rst]
connect_bd_net [get_bd_pins ip_28_reset/mb_reset] [get_bd_pins ip_8_microblaze/Reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset] [get_bd_pins ip_9_dft/SCLR]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset] [get_bd_pins ip_11_dft/SCLR]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_12_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_14_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_iic/reset]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_18_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_19_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_20_gpio/rst]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_21_emc/rst]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_23_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_24_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/mb_reset] [get_bd_pins ip_27_microblaze/Reset]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_0_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_0_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_1_dft/CLK]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_2_uartlite/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_3_dft/CLK]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_4_dft/CLK]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_6_gpio/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_7_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_7_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_8_microblaze/Clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_9_dft/CLK]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_10_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_11_dft/CLK]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_12_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_13_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_13_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_14_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_15_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_15_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_16_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_16_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_17_axi_iic/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_18_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_19_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_20_gpio/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_21_emc/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_21_emc/rdclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_22_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_23_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_24_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_24_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_24_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_25_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_26_dft/CLK]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_27_microblaze/Clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_28_reset/clk_in]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_locked] [get_bd_pins ip_28_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_30_intc/irq_0] [get_bd_pins ip_0_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_30_intc/irq_1] [get_bd_pins ip_2_uartlite/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_2] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_3] [get_bd_pins ip_7_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_4] [get_bd_pins ip_10_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_30_intc/irq_5] [get_bd_pins ip_13_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_6] [get_bd_pins ip_15_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_7] [get_bd_pins ip_16_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_8] [get_bd_pins ip_17_axi_iic/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_9] [get_bd_pins ip_19_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_30_intc/irq_10] [get_bd_pins ip_23_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_11] [get_bd_pins ip_24_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_12] [get_bd_pins ip_24_axi_dma/s2mm_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_microblaze/INTERRUPT] [get_bd_intf_pins ip_30_intc/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_0] [get_bd_pins ip_0_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_31_intc/irq_1] [get_bd_pins ip_2_uartlite/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_2] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_3] [get_bd_pins ip_7_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_31_intc/irq_4] [get_bd_pins ip_10_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_31_intc/irq_5] [get_bd_pins ip_13_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_31_intc/irq_6] [get_bd_pins ip_15_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_31_intc/irq_7] [get_bd_pins ip_16_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_31_intc/irq_8] [get_bd_pins ip_17_axi_iic/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_9] [get_bd_pins ip_19_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_31_intc/irq_10] [get_bd_pins ip_23_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_31_intc/irq_11] [get_bd_pins ip_24_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_31_intc/irq_12] [get_bd_pins ip_24_axi_dma/s2mm_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_microblaze/INTERRUPT] [get_bd_intf_pins ip_31_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_cdma/M_AXI] [get_bd_intf_pins ip_32_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_microblaze/M_AXI_DP] [get_bd_intf_pins ip_32_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_cdma/M_AXI] [get_bd_intf_pins ip_32_axi/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_cdma/M_AXI] [get_bd_intf_pins ip_32_axi/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_cdma/M_AXI] [get_bd_intf_pins ip_32_axi/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_32_axi/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_32_axi/AXI_M6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_microblaze/M_AXI_DP] [get_bd_intf_pins ip_32_axi/AXI_M7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_32_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_32_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_32_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_timer/S_AXI] [get_bd_intf_pins ip_32_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_iic/AXI] [get_bd_intf_pins ip_32_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_gpio/AXI] [get_bd_intf_pins ip_32_axi/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_emc/AXI] [get_bd_intf_pins ip_32_axi/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_32_axi/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_32_axi/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_intc/AXI] [get_bd_intf_pins ip_32_axi/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_intc/AXI] [get_bd_intf_pins ip_32_axi/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_48_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_50_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_52_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_51_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_52_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_9_dft/XN_RE]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_1_dft/RFFD]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_1] [get_bd_pins ip_1_dft/XK_RE]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_2] [get_bd_pins ip_1_dft/XK_IM]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_3] [get_bd_pins ip_1_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_1_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_1] [get_bd_pins ip_1_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_2] [get_bd_pins ip_1_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_3] [get_bd_pins ip_3_dft/RFFD]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_4] [get_bd_pins ip_3_dft/XK_RE]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_5] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_IM]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_9_dft/SIZE]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_1] [get_bd_pins ip_3_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_2] [get_bd_pins ip_3_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_26_dft/SIZE]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_3_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_1] [get_bd_pins ip_4_dft/RFFD]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_2] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_1_dft/XN_RE]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_IM]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_1] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_9_dft/XN_IM]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_1] [get_bd_pins ip_4_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_2] [get_bd_pins ip_4_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_3] [get_bd_pins ip_4_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_4] [get_bd_pins ip_9_dft/RFFD]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_5] [get_bd_pins ip_9_dft/XK_RE]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_11_dft/XN_RE]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_9_dft/XK_RE]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_1_dft/SIZE]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_9_dft/XK_RE]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_1] [get_bd_pins ip_9_dft/XK_IM]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_RE]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_9_dft/XK_IM]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_4_dft/SIZE]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_9_dft/XK_IM]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_1] [get_bd_pins ip_9_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_2] [get_bd_pins ip_9_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_11_dft/SIZE]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_9_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_1] [get_bd_pins ip_10_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_2] [get_bd_pins ip_10_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_3] [get_bd_pins ip_10_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_4] [get_bd_pins ip_11_dft/RFFD]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_5] [get_bd_pins ip_11_dft/XK_RE]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_IM]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_11_dft/XK_RE]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_1] [get_bd_pins ip_11_dft/XK_IM]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_26_dft/XN_RE]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_11_dft/XK_IM]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_1] [get_bd_pins ip_11_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_2] [get_bd_pins ip_11_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_3] [get_bd_pins ip_11_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_4] [get_bd_pins ip_19_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_5] [get_bd_pins ip_19_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_6] [get_bd_pins ip_19_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_7] [get_bd_pins ip_19_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_11_dft/XN_IM]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_1] [get_bd_pins ip_26_dft/RFFD]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_3_dft/SIZE]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_26_dft/XK_RE]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_26_dft/XN_IM]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_26_dft/XK_RE]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_1] [get_bd_pins ip_26_dft/XK_IM]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_RE]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_0] [get_bd_pins ip_26_dft/XK_IM]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_1] [get_bd_pins ip_26_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_2] [get_bd_pins ip_26_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_0_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/in_0] [get_bd_pins ip_26_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_72_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_9_dft/CE]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_73_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_26_dft/FD_IN]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_74_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_75_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_3_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_76_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_11_dft/FD_IN]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_77_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/out0] [get_bd_pins ip_9_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/out0] [get_bd_pins ip_78_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/out0] [get_bd_pins ip_79_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/out0] [get_bd_pins ip_4_dft/CE]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/out0] [get_bd_pins ip_80_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/out0] [get_bd_pins ip_3_dft/FD_IN]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/out0] [get_bd_pins ip_81_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/out0] [get_bd_pins ip_1_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/out0] [get_bd_pins ip_82_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_83_slice_and_concat/out0] [get_bd_pins ip_4_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_83_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_83_slice_and_concat/out0] [get_bd_pins ip_83_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_84_slice_and_concat/out0] [get_bd_pins ip_9_dft/FD_IN]
connect_bd_net [get_bd_pins ip_84_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_84_slice_and_concat/out0] [get_bd_pins ip_84_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_85_slice_and_concat/out0] [get_bd_pins ip_26_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_85_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_85_slice_and_concat/out0] [get_bd_pins ip_85_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_86_slice_and_concat/out0] [get_bd_pins ip_1_dft/FD_IN]
connect_bd_net [get_bd_pins ip_86_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/vbram_alarm_out]
connect_bd_net [get_bd_pins ip_86_slice_and_concat/out0] [get_bd_pins ip_86_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_87_slice_and_concat/out0] [get_bd_pins ip_19_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_87_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_87_slice_and_concat/out0] [get_bd_pins ip_87_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_88_slice_and_concat/out0] [get_bd_pins ip_11_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_88_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_88_slice_and_concat/out0] [get_bd_pins ip_88_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_89_slice_and_concat/out0] [get_bd_pins ip_4_dft/FD_IN]
connect_bd_net [get_bd_pins ip_89_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_89_slice_and_concat/out0] [get_bd_pins ip_89_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_90_slice_and_concat/out0] [get_bd_pins ip_10_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_90_slice_and_concat/in_0] [get_bd_pins ip_19_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_90_slice_and_concat/out0] [get_bd_pins ip_90_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_32_axi/reset]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_48_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_49_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_50_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_51_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_52_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_30_intc/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_31_intc/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_32_axi/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_33_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_34_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_35_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_36_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_37_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_38_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_45_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_46_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_47_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_48_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_49_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_50_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_51_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_52_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_B declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_B declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/M_AXIS_DOUT declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_complex_multiplier/M_AXIS_DOUT declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_B declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_B declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_complex_multiplier/S_AXIS_A declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_complex_multiplier/S_AXIS_A declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_complex_multiplier/M_AXIS_DOUT declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_complex_multiplier/M_AXIS_DOUT declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_complex_multiplier/M_AXIS_DOUT declared=48 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_3 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_3 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
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
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
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
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_2 declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/S_AXIS_2 declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_combiner/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }


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
