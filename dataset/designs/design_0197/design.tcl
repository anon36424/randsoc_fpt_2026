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



########## gpio ##########
create_bd_cell -type hier ip_0_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_0_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 21 CONFIG.C_GPIO_WIDTH 21 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_0_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO2] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/clk
connect_bd_net [get_bd_pins ip_0_gpio/clk] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/rst
connect_bd_net [get_bd_pins ip_0_gpio/rst] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_0_gpio/gpio_0/S_AXI]


########## microblaze ##########
create_bd_cell -type hier ip_1_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 52 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 5 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 0 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 4 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 2 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 2 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0x8 CONFIG.C_PVR_USER2 0x9a35d212 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MMU 1 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_1_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_MASK 0x308b26e4a0f714d CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_1_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_1_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_1_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_1_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xe8b0a081628dd84 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_1_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_1_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_1_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_1_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_1_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_1_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_1_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_1_microblaze/mem]
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
set_property -dict "CONFIG.C_ADDR_WIDTH 45 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_2_axi_cdma/axi_cdma_0]
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


########## accumulator ##########
create_bd_cell -type hier ip_3_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_3_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 66 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 226 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_3_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/clk
connect_bd_net [get_bd_pins ip_3_accumulator/clk] [get_bd_pins ip_3_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 65 -to 0 ip_3_accumulator/B
connect_bd_net [get_bd_pins ip_3_accumulator/B] [get_bd_pins ip_3_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 225 -to 0 ip_3_accumulator/Q
connect_bd_net [get_bd_pins ip_3_accumulator/Q] [get_bd_pins ip_3_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/CE
connect_bd_net [get_bd_pins ip_3_accumulator/CE] [get_bd_pins ip_3_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_3_accumulator/SCLR
connect_bd_net [get_bd_pins ip_3_accumulator/SCLR] [get_bd_pins ip_3_accumulator/accumulator_0/SCLR]


########## accumulator ##########
create_bd_cell -type hier ip_4_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_4_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 32 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 42 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_4_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/clk
connect_bd_net [get_bd_pins ip_4_accumulator/clk] [get_bd_pins ip_4_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 31 -to 0 ip_4_accumulator/B
connect_bd_net [get_bd_pins ip_4_accumulator/B] [get_bd_pins ip_4_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 41 -to 0 ip_4_accumulator/Q
connect_bd_net [get_bd_pins ip_4_accumulator/Q] [get_bd_pins ip_4_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/ADD
connect_bd_net [get_bd_pins ip_4_accumulator/ADD] [get_bd_pins ip_4_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/CE
connect_bd_net [get_bd_pins ip_4_accumulator/CE] [get_bd_pins ip_4_accumulator/accumulator_0/CE]


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 57600 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Odd " [get_bd_cells ip_5_uartlite/uart_0]
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
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x12 CONFIG.C_GPO_WIDTH 4 CONFIG.C_SCL_INERTIAL_DELAY 32 CONFIG.C_SDA_INERTIAL_DELAY 155 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 542.5085672154421 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_6_axi_iic/axi_iic_0]
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


########## accumulator ##########
create_bd_cell -type hier ip_7_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_7_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 47 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 110 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 1 CONFIG.Scale 3 " [get_bd_cells ip_7_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/clk
connect_bd_net [get_bd_pins ip_7_accumulator/clk] [get_bd_pins ip_7_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 46 -to 0 ip_7_accumulator/B
connect_bd_net [get_bd_pins ip_7_accumulator/B] [get_bd_pins ip_7_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 109 -to 0 ip_7_accumulator/Q
connect_bd_net [get_bd_pins ip_7_accumulator/Q] [get_bd_pins ip_7_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/C_IN
connect_bd_net [get_bd_pins ip_7_accumulator/C_IN] [get_bd_pins ip_7_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/SCLR
connect_bd_net [get_bd_pins ip_7_accumulator/SCLR] [get_bd_pins ip_7_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_7_accumulator/SSET
connect_bd_net [get_bd_pins ip_7_accumulator/SSET] [get_bd_pins ip_7_accumulator/accumulator_0/SSET]


########## reset ##########
create_bd_cell -type hier ip_8_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_8_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_reset/clk_in
connect_bd_net [get_bd_pins ip_8_reset/clk_in] [get_bd_pins ip_8_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_8_reset/reset_in
connect_bd_net [get_bd_pins ip_8_reset/reset_in] [get_bd_pins ip_8_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_8_reset/dcm_locked
connect_bd_net [get_bd_pins ip_8_reset/dcm_locked] [get_bd_pins ip_8_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_8_reset/mb_reset
connect_bd_net [get_bd_pins ip_8_reset/mb_reset] [get_bd_pins ip_8_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_8_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_8_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_8_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset] [get_bd_pins ip_8_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_8_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_8_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_9_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_9_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_in] [get_bd_pins ip_9_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_9_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_9_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_9_clk_wiz/reset
connect_bd_net [get_bd_pins ip_9_clk_wiz/reset] [get_bd_pins ip_9_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_9_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_locked] [get_bd_pins ip_9_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_10_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_10_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_10_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_10_intc/concat_0]
connect_bd_net [get_bd_pins ip_10_intc/concat_0/dout] [get_bd_pins ip_10_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/clk
connect_bd_net [get_bd_pins ip_10_intc/clk] [get_bd_pins ip_10_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/reset
connect_bd_net [get_bd_pins ip_10_intc/reset] [get_bd_pins ip_10_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_intc/AXI] [get_bd_intf_pins ip_10_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/irq_0
connect_bd_net [get_bd_pins ip_10_intc/irq_0] [get_bd_pins ip_10_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/irq_1
connect_bd_net [get_bd_pins ip_10_intc/irq_1] [get_bd_pins ip_10_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_10_intc/irq_2
connect_bd_net [get_bd_pins ip_10_intc/irq_2] [get_bd_pins ip_10_intc/concat_0/In2]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_10_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_10_intc/irq] [get_bd_intf_pins ip_10_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_11_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_11_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 5 CONFIG.NUM_SI 2 " [get_bd_cells ip_11_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_legacy/clk
connect_bd_net [get_bd_pins ip_11_axi_legacy/clk] [get_bd_pins ip_11_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_legacy/reset
connect_bd_net [get_bd_pins ip_11_axi_legacy/reset] [get_bd_pins ip_11_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_legacy/AXI_M0] [get_bd_intf_pins ip_11_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_11_axi_legacy/clk] [get_bd_pins ip_11_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_11_axi_legacy/reset] [get_bd_pins ip_11_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_legacy/AXI_M1] [get_bd_intf_pins ip_11_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_11_axi_legacy/clk] [get_bd_pins ip_11_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_11_axi_legacy/reset] [get_bd_pins ip_11_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_legacy/AXI_S0] [get_bd_intf_pins ip_11_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_11_axi_legacy/clk] [get_bd_pins ip_11_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_11_axi_legacy/reset] [get_bd_pins ip_11_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_legacy/AXI_S1] [get_bd_intf_pins ip_11_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_11_axi_legacy/clk] [get_bd_pins ip_11_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_11_axi_legacy/reset] [get_bd_pins ip_11_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_legacy/AXI_S2] [get_bd_intf_pins ip_11_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_11_axi_legacy/clk] [get_bd_pins ip_11_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_11_axi_legacy/reset] [get_bd_pins ip_11_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_legacy/AXI_S3] [get_bd_intf_pins ip_11_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_11_axi_legacy/clk] [get_bd_pins ip_11_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_11_axi_legacy/reset] [get_bd_pins ip_11_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_legacy/AXI_S4] [get_bd_intf_pins ip_11_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_11_axi_legacy/clk] [get_bd_pins ip_11_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_11_axi_legacy/reset] [get_bd_pins ip_11_axi_legacy/axi_0/M04_ARESETN]


########## reduce ##########
create_bd_cell -type hier ip_12_reduce
create_bd_pin -dir I -from 232 -to 0 ip_12_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_12_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_12_reduce/concat]
connect_bd_net [get_bd_pins ip_12_reduce/out0] [get_bd_pins ip_12_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_0]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_12_reduce/slice_0/dout] [get_bd_pins ip_12_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_0/Res] [get_bd_pins ip_12_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_1]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_12_reduce/slice_1/dout] [get_bd_pins ip_12_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_1/Res] [get_bd_pins ip_12_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_2]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_12_reduce/slice_2/dout] [get_bd_pins ip_12_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_2/Res] [get_bd_pins ip_12_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_3]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_12_reduce/slice_3/dout] [get_bd_pins ip_12_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_3/Res] [get_bd_pins ip_12_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 39 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_4]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_12_reduce/slice_4/dout] [get_bd_pins ip_12_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_4/Res] [get_bd_pins ip_12_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 40 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_5]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_12_reduce/slice_5/dout] [get_bd_pins ip_12_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_5/Res] [get_bd_pins ip_12_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 55 CONFIG.DIN_TO 48 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_6]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_12_reduce/slice_6/dout] [get_bd_pins ip_12_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_6/Res] [get_bd_pins ip_12_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 63 CONFIG.DIN_TO 56 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_7]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_12_reduce/slice_7/dout] [get_bd_pins ip_12_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_7/Res] [get_bd_pins ip_12_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 71 CONFIG.DIN_TO 64 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_8]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 8 " [get_bd_cells ip_12_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_12_reduce/slice_8/dout] [get_bd_pins ip_12_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_8/Res] [get_bd_pins ip_12_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 78 CONFIG.DIN_TO 72 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_9]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_12_reduce/slice_9/dout] [get_bd_pins ip_12_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_9/Res] [get_bd_pins ip_12_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 85 CONFIG.DIN_TO 79 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_10]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_12_reduce/slice_10/dout] [get_bd_pins ip_12_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_10/Res] [get_bd_pins ip_12_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 92 CONFIG.DIN_TO 86 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_11]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_12_reduce/slice_11/dout] [get_bd_pins ip_12_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_11/Res] [get_bd_pins ip_12_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 99 CONFIG.DIN_TO 93 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_12]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_12_reduce/slice_12/dout] [get_bd_pins ip_12_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_12/Res] [get_bd_pins ip_12_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 106 CONFIG.DIN_TO 100 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_13]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_12_reduce/slice_13/dout] [get_bd_pins ip_12_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_13/Res] [get_bd_pins ip_12_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 113 CONFIG.DIN_TO 107 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_14]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_12_reduce/slice_14/dout] [get_bd_pins ip_12_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_14/Res] [get_bd_pins ip_12_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 120 CONFIG.DIN_TO 114 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_15]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_12_reduce/slice_15/dout] [get_bd_pins ip_12_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_15/Res] [get_bd_pins ip_12_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 127 CONFIG.DIN_TO 121 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_16]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_12_reduce/slice_16/dout] [get_bd_pins ip_12_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_16/Res] [get_bd_pins ip_12_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 134 CONFIG.DIN_TO 128 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_17]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_12_reduce/slice_17/dout] [get_bd_pins ip_12_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_17/Res] [get_bd_pins ip_12_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 141 CONFIG.DIN_TO 135 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_18]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_12_reduce/slice_18/dout] [get_bd_pins ip_12_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_18/Res] [get_bd_pins ip_12_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 148 CONFIG.DIN_TO 142 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_19]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_12_reduce/slice_19/dout] [get_bd_pins ip_12_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_19/Res] [get_bd_pins ip_12_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 155 CONFIG.DIN_TO 149 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_20]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_12_reduce/slice_20/dout] [get_bd_pins ip_12_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_20/Res] [get_bd_pins ip_12_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 162 CONFIG.DIN_TO 156 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_21]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_12_reduce/slice_21/dout] [get_bd_pins ip_12_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_21/Res] [get_bd_pins ip_12_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 169 CONFIG.DIN_TO 163 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_22]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_12_reduce/slice_22/dout] [get_bd_pins ip_12_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_22/Res] [get_bd_pins ip_12_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 176 CONFIG.DIN_TO 170 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_23]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_12_reduce/slice_23/dout] [get_bd_pins ip_12_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_23/Res] [get_bd_pins ip_12_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 183 CONFIG.DIN_TO 177 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_24]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_12_reduce/slice_24/dout] [get_bd_pins ip_12_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_24/Res] [get_bd_pins ip_12_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 190 CONFIG.DIN_TO 184 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_25]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_12_reduce/slice_25/dout] [get_bd_pins ip_12_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_25/Res] [get_bd_pins ip_12_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 197 CONFIG.DIN_TO 191 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_26]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_12_reduce/slice_26/dout] [get_bd_pins ip_12_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_26/Res] [get_bd_pins ip_12_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 204 CONFIG.DIN_TO 198 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_27]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_12_reduce/slice_27/dout] [get_bd_pins ip_12_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_27/Res] [get_bd_pins ip_12_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 211 CONFIG.DIN_TO 205 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_28]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_12_reduce/slice_28/dout] [get_bd_pins ip_12_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_28/Res] [get_bd_pins ip_12_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 218 CONFIG.DIN_TO 212 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_29]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_12_reduce/slice_29/dout] [get_bd_pins ip_12_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_29/Res] [get_bd_pins ip_12_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 225 CONFIG.DIN_TO 219 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_30]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_12_reduce/slice_30/dout] [get_bd_pins ip_12_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_30/Res] [get_bd_pins ip_12_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 232 CONFIG.DIN_TO 226 CONFIG.DIN_WIDTH 233 " [get_bd_cells ip_12_reduce/slice_31]
connect_bd_net [get_bd_pins ip_12_reduce/in0] [get_bd_pins ip_12_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_12_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 7 " [get_bd_cells ip_12_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_12_reduce/slice_31/dout] [get_bd_pins ip_12_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_12_reduce/reduce_31/Res] [get_bd_pins ip_12_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_13_slice_and_concat
create_bd_pin -dir O -from 31 -to 0 ip_13_slice_and_concat/out0
create_bd_pin -dir I -from 225 -to 0 ip_13_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 226 " [get_bd_cells ip_13_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_13_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_13_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_14_slice_and_concat
create_bd_pin -dir O -from 65 -to 0 ip_14_slice_and_concat/out0
create_bd_pin -dir I -from 225 -to 0 ip_14_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 97 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 226 " [get_bd_cells ip_14_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_14_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_14_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 46 -to 0 ip_15_slice_and_concat/out0
create_bd_pin -dir I -from 225 -to 0 ip_15_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 144 CONFIG.DIN_TO 98 CONFIG.DIN_WIDTH 226 " [get_bd_cells ip_15_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_15_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 232 -to 0 ip_16_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_16_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 225 -to 0 ip_16_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 225 CONFIG.DIN_TO 145 CONFIG.DIN_WIDTH 226 " [get_bd_cells ip_16_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/slice_0/dout] [get_bd_pins ip_16_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 41 -to 0 ip_16_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_16_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 109 -to 0 ip_16_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_16_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_17_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_17_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_17_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_17_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_20_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_20_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_20_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_21_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_21_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_21_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_21_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_22_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_22_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_22_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 3 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 4 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_9_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO] [get_bd_intf_pins ip_0_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO2] [get_bd_intf_pins ip_0_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_6_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_iic_IIC] [get_bd_intf_pins ip_6_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_12_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 3 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_17_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_21_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_22_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_23_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_0_gpio/rst]
connect_bd_net [get_bd_pins ip_8_reset/mb_reset] [get_bd_pins ip_1_microblaze/Reset]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_8_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_iic/reset]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_0_gpio/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_1_microblaze/Clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_3_accumulator/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_4_accumulator/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_6_axi_iic/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_7_accumulator/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_8_reset/clk_in]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_locked] [get_bd_pins ip_8_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_10_intc/irq_0] [get_bd_pins ip_2_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_10_intc/irq_1] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_10_intc/irq_2] [get_bd_pins ip_6_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_microblaze/INTERRUPT] [get_bd_intf_pins ip_10_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_microblaze/M_AXI_DP] [get_bd_intf_pins ip_11_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/M_AXI] [get_bd_intf_pins ip_11_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_11_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_11_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_11_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_iic/AXI] [get_bd_intf_pins ip_11_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_intc/AXI] [get_bd_intf_pins ip_11_axi_legacy/AXI_S4]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/B]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/B]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/B]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_12_reduce/in0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_3_accumulator/Q]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_7_accumulator/Q]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/ADD]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/CE]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/CE]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/SSET]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_7_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_3_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_8_reset/interconnect_aresetn] [get_bd_pins ip_11_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_10_intc/clk]
connect_bd_net [get_bd_pins ip_9_clk_wiz/clk_out] [get_bd_pins ip_11_axi_legacy/clk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).


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
