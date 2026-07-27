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
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 5 CONFIG.convolution_code0 2 CONFIG.convolution_code1 2 CONFIG.convolution_code2 27 CONFIG.convolution_code3 12 CONFIG.convolution_code4 15 CONFIG.convolution_code5 4 CONFIG.convolution_code6 7 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 6 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 0 " [get_bd_cells ip_0_conv_encoder/conv_encoder_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_1_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_1_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x52 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 74 CONFIG.C_SDA_INERTIAL_DELAY 58 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 942.8109463907325 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_1_axi_iic/axi_iic_0]
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


########## axi_timer ##########
create_bd_cell -type hier ip_2_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_2_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.mode_64bit 1 " [get_bd_cells ip_2_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_timer/S_AXI] [get_bd_intf_pins ip_2_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_2_axi_timer/capturetrig0] [get_bd_pins ip_2_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_timer/freeze
connect_bd_net [get_bd_pins ip_2_axi_timer/freeze] [get_bd_pins ip_2_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_2_axi_timer/s_axi_aclk] [get_bd_pins ip_2_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_2_axi_timer/s_axi_aresetn] [get_bd_pins ip_2_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_2_axi_timer/generateout0] [get_bd_pins ip_2_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_2_axi_timer/generateout1] [get_bd_pins ip_2_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_2_axi_timer/pwm0] [get_bd_pins ip_2_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_2_axi_timer/interrupt] [get_bd_pins ip_2_axi_timer/axi_timer_0/interrupt]


########## microblaze ##########
create_bd_cell -type hier ip_3_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 64 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_3_microblaze/microblaze_0]
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
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_3_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_3_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x1ded335ff8492c CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_3_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_3_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_3_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_3_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xfc706e5a006584a CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_3_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_3_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_3_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_3_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_3_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_3_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_3_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_3_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_3_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_3_microblaze/mem/BRAM_PORTB]


########## axi_cdma ##########
create_bd_cell -type hier ip_4_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_4_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 47 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 4 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_4_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_4_axi_cdma/m_axi_aclk] [get_bd_pins ip_4_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_4_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_4_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_4_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_4_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_cdma/M_AXI] [get_bd_intf_pins ip_4_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_4_axi_cdma/cdma_introut] [get_bd_pins ip_4_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_5_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_5_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SHARED_STARTUP 1 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_5_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_5_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/IIC] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_5_axi_quad_spi/STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/STARTUP_IO_S] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/STARTUP_IO_S]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/clk] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/reset] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/clk4] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/reset4] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_5_axi_quad_spi/irq] [get_bd_pins ip_5_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_6_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_6_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 2400 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Odd " [get_bd_cells ip_6_uartlite/uart_0]
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


########## reset ##########
create_bd_cell -type hier ip_7_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_7_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_reset/clk_in
connect_bd_net [get_bd_pins ip_7_reset/clk_in] [get_bd_pins ip_7_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_7_reset/reset_in
connect_bd_net [get_bd_pins ip_7_reset/reset_in] [get_bd_pins ip_7_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_7_reset/dcm_locked
connect_bd_net [get_bd_pins ip_7_reset/dcm_locked] [get_bd_pins ip_7_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/mb_reset
connect_bd_net [get_bd_pins ip_7_reset/mb_reset] [get_bd_pins ip_7_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_7_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset] [get_bd_pins ip_7_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_7_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_7_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_8_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_8_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_in] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_8_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_8_clk_wiz/reset
connect_bd_net [get_bd_pins ip_8_clk_wiz/reset] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_8_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_locked] [get_bd_pins ip_8_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_9_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_9_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_9_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 5 " [get_bd_cells ip_9_intc/concat_0]
connect_bd_net [get_bd_pins ip_9_intc/concat_0/dout] [get_bd_pins ip_9_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/clk
connect_bd_net [get_bd_pins ip_9_intc/clk] [get_bd_pins ip_9_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/reset
connect_bd_net [get_bd_pins ip_9_intc/reset] [get_bd_pins ip_9_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_intc/AXI] [get_bd_intf_pins ip_9_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_0
connect_bd_net [get_bd_pins ip_9_intc/irq_0] [get_bd_pins ip_9_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_1
connect_bd_net [get_bd_pins ip_9_intc/irq_1] [get_bd_pins ip_9_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_2
connect_bd_net [get_bd_pins ip_9_intc/irq_2] [get_bd_pins ip_9_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_3
connect_bd_net [get_bd_pins ip_9_intc/irq_3] [get_bd_pins ip_9_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_9_intc/irq_4
connect_bd_net [get_bd_pins ip_9_intc/irq_4] [get_bd_pins ip_9_intc/concat_0/In4]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_9_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_9_intc/irq] [get_bd_intf_pins ip_9_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_10_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_10_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 7 CONFIG.NUM_SI 2 " [get_bd_cells ip_10_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi/clk
connect_bd_net [get_bd_pins ip_10_axi/clk] [get_bd_pins ip_10_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi/reset
connect_bd_net [get_bd_pins ip_10_axi/reset] [get_bd_pins ip_10_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_M0] [get_bd_intf_pins ip_10_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_M1] [get_bd_intf_pins ip_10_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S0] [get_bd_intf_pins ip_10_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S1] [get_bd_intf_pins ip_10_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S2] [get_bd_intf_pins ip_10_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S3] [get_bd_intf_pins ip_10_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S4] [get_bd_intf_pins ip_10_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S5] [get_bd_intf_pins ip_10_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S6] [get_bd_intf_pins ip_10_axi/axi_0/M06_AXI]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_11_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_11_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_11_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aclk] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aresetn] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_12_slice_and_concat
create_bd_pin -dir O -from 2 -to 0 ip_12_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_12_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_12_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/out0] [get_bd_pins ip_12_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_12_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_1] [get_bd_pins ip_12_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_12_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_2] [get_bd_pins ip_12_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_13_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_13_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_13_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_13_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_13_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/in_0] [get_bd_pins ip_13_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_13_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_14_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_14_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_14_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_14_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_14_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_14_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_15_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_15_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_15_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_15_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_4_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_8_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_1_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_iic_IIC] [get_bd_intf_pins ip_1_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_5_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi_IIC] [get_bd_intf_pins ip_5_axi_quad_spi/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_5_axi_quad_spi_STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi_STARTUP_IO_S] [get_bd_intf_pins ip_5_axi_quad_spi/STARTUP_IO_S]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_6_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite_UART] [get_bd_intf_pins ip_6_uartlite/UART]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 2 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_12_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_13_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_14_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_15_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_0_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_iic/reset]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_7_reset/mb_reset] [get_bd_pins ip_3_microblaze/Reset]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_6_uartlite/reset]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_0_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_1_axi_iic/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_2_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_3_microblaze/Clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_4_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_4_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_6_uartlite/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_7_reset/clk_in]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_locked] [get_bd_pins ip_7_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_9_intc/irq_0] [get_bd_pins ip_1_axi_iic/irq]
connect_bd_net [get_bd_pins ip_9_intc/irq_1] [get_bd_pins ip_2_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_9_intc/irq_2] [get_bd_pins ip_4_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_9_intc/irq_3] [get_bd_pins ip_5_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_9_intc/irq_4] [get_bd_pins ip_6_uartlite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_microblaze/INTERRUPT] [get_bd_intf_pins ip_9_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_microblaze/M_AXI_DP] [get_bd_intf_pins ip_10_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_cdma/M_AXI] [get_bd_intf_pins ip_10_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_iic/AXI] [get_bd_intf_pins ip_10_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_timer/S_AXI] [get_bd_intf_pins ip_10_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_10_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_10_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_uartlite/AXI] [get_bd_intf_pins ip_10_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_intc/AXI] [get_bd_intf_pins ip_10_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_0] [get_bd_pins ip_2_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_1] [get_bd_pins ip_2_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_12_slice_and_concat/in_2] [get_bd_pins ip_2_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_13_slice_and_concat/out0] [get_bd_pins ip_0_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_2_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_2_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_10_axi/reset]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_11_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_9_intc/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_10_axi/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_11_axis_dwidth_converter/aclk]

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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
