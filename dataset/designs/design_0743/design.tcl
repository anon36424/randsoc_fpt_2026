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



########## microblaze ##########
create_bd_cell -type hier ip_0_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 48 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 4 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_NUMBER_OF_PC_BRK 8 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 3 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 4 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0xd5 CONFIG.C_PVR_USER2 0x2f09123e CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 0 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_0_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_microblaze/Clk
connect_bd_net [get_bd_pins ip_0_microblaze/Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_0_microblaze/Reset
connect_bd_net [get_bd_pins ip_0_microblaze/Reset] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_0_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/INTERRUPT] [get_bd_intf_pins ip_0_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/M_AXI_DP] [get_bd_intf_pins ip_0_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_0_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_0_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x235fa02b7eead72 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_0_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_0_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_0_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_0_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x253681e500fea85 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_0_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_0_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_0_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_0_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_0_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_0_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_0_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_0_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_0_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 1 " [get_bd_cells ip_0_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_0_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_0_microblaze/microblaze_0/DEBUG]


########## uartlite ##########
create_bd_cell -type hier ip_1_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_1_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 38400 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Even " [get_bd_cells ip_1_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_1_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite/UART] [get_bd_intf_pins ip_1_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_1_uartlite/clk
connect_bd_net [get_bd_pins ip_1_uartlite/clk] [get_bd_pins ip_1_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_uartlite/reset
connect_bd_net [get_bd_pins ip_1_uartlite/reset] [get_bd_pins ip_1_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite/AXI] [get_bd_intf_pins ip_1_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_uartlite/irq
connect_bd_net [get_bd_pins ip_1_uartlite/irq] [get_bd_pins ip_1_uartlite/uart_0/interrupt]


########## accumulator ##########
create_bd_cell -type hier ip_2_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_2_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 29 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 178 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_2_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/clk
connect_bd_net [get_bd_pins ip_2_accumulator/clk] [get_bd_pins ip_2_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 28 -to 0 ip_2_accumulator/B
connect_bd_net [get_bd_pins ip_2_accumulator/B] [get_bd_pins ip_2_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 177 -to 0 ip_2_accumulator/Q
connect_bd_net [get_bd_pins ip_2_accumulator/Q] [get_bd_pins ip_2_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/SCLR
connect_bd_net [get_bd_pins ip_2_accumulator/SCLR] [get_bd_pins ip_2_accumulator/accumulator_0/SCLR]


########## fft ##########
create_bd_cell -type hier ip_3_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_3_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 3 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 64 " [get_bd_cells ip_3_fft/fft_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_4_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_4_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x4a CONFIG.C_GPO_WIDTH 5 CONFIG.C_SCL_INERTIAL_DELAY 140 CONFIG.C_SDA_INERTIAL_DELAY 197 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 313.5101238918043 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_4_axi_iic/axi_iic_0]
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


########## uartlite ##########
create_bd_cell -type hier ip_5_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_5_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Odd " [get_bd_cells ip_5_uartlite/uart_0]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_6_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_6_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_SPI_MEMORY 1 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_6_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_6_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/IIC] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:display_startup_io:startup_io_rtl:1.0 ip_6_axi_quad_spi/STARTUP_IO
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/STARTUP_IO] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/STARTUP_IO]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/clk] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/reset] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/irq] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_7_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_7_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 300 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Odd " [get_bd_cells ip_7_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_7_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite/UART] [get_bd_intf_pins ip_7_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_7_uartlite/clk
connect_bd_net [get_bd_pins ip_7_uartlite/clk] [get_bd_pins ip_7_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_uartlite/reset
connect_bd_net [get_bd_pins ip_7_uartlite/reset] [get_bd_pins ip_7_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite/AXI] [get_bd_intf_pins ip_7_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_uartlite/irq
connect_bd_net [get_bd_pins ip_7_uartlite/irq] [get_bd_pins ip_7_uartlite/uart_0/interrupt]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_8_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_8_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 1 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 1 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_8_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_8_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_quad_spi/IIC] [get_bd_intf_pins ip_8_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/clk4] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/reset4] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_8_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_8_axi_quad_spi/irq] [get_bd_pins ip_8_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## axi_timer ##########
create_bd_cell -type hier ip_9_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_9_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.mode_64bit 1 " [get_bd_cells ip_9_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_timer/S_AXI] [get_bd_intf_pins ip_9_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_9_axi_timer/capturetrig0] [get_bd_pins ip_9_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/freeze
connect_bd_net [get_bd_pins ip_9_axi_timer/freeze] [get_bd_pins ip_9_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_9_axi_timer/s_axi_aclk] [get_bd_pins ip_9_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_9_axi_timer/s_axi_aresetn] [get_bd_pins ip_9_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_9_axi_timer/generateout0] [get_bd_pins ip_9_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_9_axi_timer/generateout1] [get_bd_pins ip_9_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_9_axi_timer/pwm0] [get_bd_pins ip_9_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_9_axi_timer/interrupt] [get_bd_pins ip_9_axi_timer/axi_timer_0/interrupt]


########## dft ##########
create_bd_cell -type hier ip_10_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_10_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 12 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_10_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/CLK
connect_bd_net [get_bd_pins ip_10_dft/CLK] [get_bd_pins ip_10_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/CE
connect_bd_net [get_bd_pins ip_10_dft/CE] [get_bd_pins ip_10_dft/dft_0/CE]
create_bd_pin -dir I -from 11 -to 0 ip_10_dft/XN_RE
connect_bd_net [get_bd_pins ip_10_dft/XN_RE] [get_bd_pins ip_10_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 11 -to 0 ip_10_dft/XN_IM
connect_bd_net [get_bd_pins ip_10_dft/XN_IM] [get_bd_pins ip_10_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/FD_IN
connect_bd_net [get_bd_pins ip_10_dft/FD_IN] [get_bd_pins ip_10_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/FWD_INV
connect_bd_net [get_bd_pins ip_10_dft/FWD_INV] [get_bd_pins ip_10_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_10_dft/SIZE
connect_bd_net [get_bd_pins ip_10_dft/SIZE] [get_bd_pins ip_10_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/RFFD
connect_bd_net [get_bd_pins ip_10_dft/RFFD] [get_bd_pins ip_10_dft/dft_0/RFFD]
create_bd_pin -dir O -from 11 -to 0 ip_10_dft/XK_RE
connect_bd_net [get_bd_pins ip_10_dft/XK_RE] [get_bd_pins ip_10_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 11 -to 0 ip_10_dft/XK_IM
connect_bd_net [get_bd_pins ip_10_dft/XK_IM] [get_bd_pins ip_10_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_10_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_10_dft/BLK_EXP] [get_bd_pins ip_10_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/FD_OUT
connect_bd_net [get_bd_pins ip_10_dft/FD_OUT] [get_bd_pins ip_10_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_10_dft/DATA_VALID] [get_bd_pins ip_10_dft/dft_0/DATA_VALID]


########## accumulator ##########
create_bd_cell -type hier ip_11_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_11_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 6 CONFIG.Latency 2 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 37 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_11_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_accumulator/clk
connect_bd_net [get_bd_pins ip_11_accumulator/clk] [get_bd_pins ip_11_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 5 -to 0 ip_11_accumulator/B
connect_bd_net [get_bd_pins ip_11_accumulator/B] [get_bd_pins ip_11_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 36 -to 0 ip_11_accumulator/Q
connect_bd_net [get_bd_pins ip_11_accumulator/Q] [get_bd_pins ip_11_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_11_accumulator/CE
connect_bd_net [get_bd_pins ip_11_accumulator/CE] [get_bd_pins ip_11_accumulator/accumulator_0/CE]


########## axi_hwicap ##########
create_bd_cell -type hier ip_12_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_12_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 0 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 0 CONFIG.C_READ_FIFO_DEPTH 256 CONFIG.C_WRITE_FIFO_DEPTH 1024 " [get_bd_cells ip_12_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_12_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_12_axi_hwicap/icap_clk] [get_bd_pins ip_12_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_12_axi_hwicap/eos_in] [get_bd_pins ip_12_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_12_axi_hwicap/s_axi_aclk] [get_bd_pins ip_12_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_12_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_12_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_12_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_12_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_13_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_13_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tan CONFIG.Input_Width 18 CONFIG.Iterations 23 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 38 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 39 CONFIG.Round_Mode Truncate " [get_bd_cells ip_13_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_cordic/aclk
connect_bd_net [get_bd_pins ip_13_cordic/aclk] [get_bd_pins ip_13_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_cordic/aresetn
connect_bd_net [get_bd_pins ip_13_cordic/aresetn] [get_bd_pins ip_13_cordic/cordic_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_13_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_13_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_13_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_13_cordic/cordic_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_14_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_14_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 5 CONFIG.C_TAVDV_PS_MEM_0 15208 CONFIG.C_TCEDV_PS_MEM_0 15099 CONFIG.C_THZCE_PS_MEM_0 6596 CONFIG.C_THZOE_PS_MEM_0 7517 CONFIG.C_TLZWE_PS_MEM_0 9527 CONFIG.C_TWC_PS_MEM_0 14979 CONFIG.C_TWPH_PS_MEM_0 12575 CONFIG.C_TWP_PS_MEM_0 12021 CONFIG.C_WR_REC_TIME_MEM_0 25569 " [get_bd_cells ip_14_emc/emc_0]
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


########## reset ##########
create_bd_cell -type hier ip_15_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_15_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/clk_in
connect_bd_net [get_bd_pins ip_15_reset/clk_in] [get_bd_pins ip_15_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/reset_in
connect_bd_net [get_bd_pins ip_15_reset/reset_in] [get_bd_pins ip_15_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_15_reset/dcm_locked
connect_bd_net [get_bd_pins ip_15_reset/dcm_locked] [get_bd_pins ip_15_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/mb_reset
connect_bd_net [get_bd_pins ip_15_reset/mb_reset] [get_bd_pins ip_15_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_15_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset] [get_bd_pins ip_15_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_15_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_16_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_16_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_in] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_16_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_16_clk_wiz/reset
connect_bd_net [get_bd_pins ip_16_clk_wiz/reset] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_16_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_locked] [get_bd_pins ip_16_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_17_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 9 " [get_bd_cells ip_17_intc/concat_0]
connect_bd_net [get_bd_pins ip_17_intc/concat_0/dout] [get_bd_pins ip_17_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/clk
connect_bd_net [get_bd_pins ip_17_intc/clk] [get_bd_pins ip_17_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/reset
connect_bd_net [get_bd_pins ip_17_intc/reset] [get_bd_pins ip_17_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_intc/AXI] [get_bd_intf_pins ip_17_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_0
connect_bd_net [get_bd_pins ip_17_intc/irq_0] [get_bd_pins ip_17_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_1
connect_bd_net [get_bd_pins ip_17_intc/irq_1] [get_bd_pins ip_17_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_2
connect_bd_net [get_bd_pins ip_17_intc/irq_2] [get_bd_pins ip_17_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_3
connect_bd_net [get_bd_pins ip_17_intc/irq_3] [get_bd_pins ip_17_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_4
connect_bd_net [get_bd_pins ip_17_intc/irq_4] [get_bd_pins ip_17_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_5
connect_bd_net [get_bd_pins ip_17_intc/irq_5] [get_bd_pins ip_17_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_6
connect_bd_net [get_bd_pins ip_17_intc/irq_6] [get_bd_pins ip_17_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_7
connect_bd_net [get_bd_pins ip_17_intc/irq_7] [get_bd_pins ip_17_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_17_intc/irq_8
connect_bd_net [get_bd_pins ip_17_intc/irq_8] [get_bd_pins ip_17_intc/concat_0/In8]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_17_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_17_intc/irq] [get_bd_intf_pins ip_17_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_18_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_18_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 10 CONFIG.NUM_SI 1 " [get_bd_cells ip_18_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi/clk
connect_bd_net [get_bd_pins ip_18_axi/clk] [get_bd_pins ip_18_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi/reset
connect_bd_net [get_bd_pins ip_18_axi/reset] [get_bd_pins ip_18_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_M0] [get_bd_intf_pins ip_18_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S0] [get_bd_intf_pins ip_18_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S1] [get_bd_intf_pins ip_18_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S2] [get_bd_intf_pins ip_18_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S3] [get_bd_intf_pins ip_18_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S4] [get_bd_intf_pins ip_18_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S5] [get_bd_intf_pins ip_18_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S6] [get_bd_intf_pins ip_18_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S7] [get_bd_intf_pins ip_18_axi/axi_0/M07_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S8] [get_bd_intf_pins ip_18_axi/axi_0/M08_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_18_axi/AXI_S9] [get_bd_intf_pins ip_18_axi/axi_0/M09_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_19_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_19_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_19_axis_broadcaster/axis_broadcaster_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_20_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_20_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aclk] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aresetn] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_21_reduce
create_bd_pin -dir I -from 182 -to 0 ip_21_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_21_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_21_reduce/concat]
connect_bd_net [get_bd_pins ip_21_reduce/out0] [get_bd_pins ip_21_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_0]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_21_reduce/slice_0/dout] [get_bd_pins ip_21_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_0/Res] [get_bd_pins ip_21_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_1]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_21_reduce/slice_1/dout] [get_bd_pins ip_21_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_1/Res] [get_bd_pins ip_21_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_2]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_21_reduce/slice_2/dout] [get_bd_pins ip_21_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_2/Res] [get_bd_pins ip_21_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_3]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_21_reduce/slice_3/dout] [get_bd_pins ip_21_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_3/Res] [get_bd_pins ip_21_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_4]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_21_reduce/slice_4/dout] [get_bd_pins ip_21_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_4/Res] [get_bd_pins ip_21_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 35 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_5]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_21_reduce/slice_5/dout] [get_bd_pins ip_21_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_5/Res] [get_bd_pins ip_21_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 41 CONFIG.DIN_TO 36 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_6]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_21_reduce/slice_6/dout] [get_bd_pins ip_21_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_6/Res] [get_bd_pins ip_21_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 42 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_7]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_21_reduce/slice_7/dout] [get_bd_pins ip_21_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_7/Res] [get_bd_pins ip_21_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 53 CONFIG.DIN_TO 48 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_8]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_21_reduce/slice_8/dout] [get_bd_pins ip_21_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_8/Res] [get_bd_pins ip_21_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 59 CONFIG.DIN_TO 54 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_9]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_21_reduce/slice_9/dout] [get_bd_pins ip_21_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_9/Res] [get_bd_pins ip_21_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 65 CONFIG.DIN_TO 60 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_10]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_21_reduce/slice_10/dout] [get_bd_pins ip_21_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_10/Res] [get_bd_pins ip_21_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 71 CONFIG.DIN_TO 66 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_11]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_21_reduce/slice_11/dout] [get_bd_pins ip_21_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_11/Res] [get_bd_pins ip_21_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 77 CONFIG.DIN_TO 72 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_12]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_21_reduce/slice_12/dout] [get_bd_pins ip_21_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_12/Res] [get_bd_pins ip_21_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 83 CONFIG.DIN_TO 78 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_13]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_21_reduce/slice_13/dout] [get_bd_pins ip_21_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_13/Res] [get_bd_pins ip_21_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 89 CONFIG.DIN_TO 84 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_14]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_21_reduce/slice_14/dout] [get_bd_pins ip_21_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_14/Res] [get_bd_pins ip_21_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 95 CONFIG.DIN_TO 90 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_15]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_21_reduce/slice_15/dout] [get_bd_pins ip_21_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_15/Res] [get_bd_pins ip_21_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 101 CONFIG.DIN_TO 96 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_16]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_21_reduce/slice_16/dout] [get_bd_pins ip_21_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_16/Res] [get_bd_pins ip_21_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 107 CONFIG.DIN_TO 102 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_17]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_21_reduce/slice_17/dout] [get_bd_pins ip_21_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_17/Res] [get_bd_pins ip_21_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 113 CONFIG.DIN_TO 108 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_18]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_21_reduce/slice_18/dout] [get_bd_pins ip_21_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_18/Res] [get_bd_pins ip_21_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 119 CONFIG.DIN_TO 114 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_19]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_21_reduce/slice_19/dout] [get_bd_pins ip_21_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_19/Res] [get_bd_pins ip_21_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 125 CONFIG.DIN_TO 120 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_20]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_21_reduce/slice_20/dout] [get_bd_pins ip_21_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_20/Res] [get_bd_pins ip_21_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 131 CONFIG.DIN_TO 126 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_21]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_21_reduce/slice_21/dout] [get_bd_pins ip_21_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_21/Res] [get_bd_pins ip_21_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 137 CONFIG.DIN_TO 132 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_22]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 6 " [get_bd_cells ip_21_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_21_reduce/slice_22/dout] [get_bd_pins ip_21_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_22/Res] [get_bd_pins ip_21_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 142 CONFIG.DIN_TO 138 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_23]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_21_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_21_reduce/slice_23/dout] [get_bd_pins ip_21_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_23/Res] [get_bd_pins ip_21_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 147 CONFIG.DIN_TO 143 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_24]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_21_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_21_reduce/slice_24/dout] [get_bd_pins ip_21_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_24/Res] [get_bd_pins ip_21_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 152 CONFIG.DIN_TO 148 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_25]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_21_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_21_reduce/slice_25/dout] [get_bd_pins ip_21_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_25/Res] [get_bd_pins ip_21_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 157 CONFIG.DIN_TO 153 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_26]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_21_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_21_reduce/slice_26/dout] [get_bd_pins ip_21_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_26/Res] [get_bd_pins ip_21_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 162 CONFIG.DIN_TO 158 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_27]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_21_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_21_reduce/slice_27/dout] [get_bd_pins ip_21_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_27/Res] [get_bd_pins ip_21_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 167 CONFIG.DIN_TO 163 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_28]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_21_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_21_reduce/slice_28/dout] [get_bd_pins ip_21_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_28/Res] [get_bd_pins ip_21_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 172 CONFIG.DIN_TO 168 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_29]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_21_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_21_reduce/slice_29/dout] [get_bd_pins ip_21_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_29/Res] [get_bd_pins ip_21_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 177 CONFIG.DIN_TO 173 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_30]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_21_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_21_reduce/slice_30/dout] [get_bd_pins ip_21_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_30/Res] [get_bd_pins ip_21_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 182 CONFIG.DIN_TO 178 CONFIG.DIN_WIDTH 183 " [get_bd_cells ip_21_reduce/slice_31]
connect_bd_net [get_bd_pins ip_21_reduce/in0] [get_bd_pins ip_21_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_21_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 5 " [get_bd_cells ip_21_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_21_reduce/slice_31/dout] [get_bd_pins ip_21_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_21_reduce/reduce_31/Res] [get_bd_pins ip_21_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 182 -to 0 ip_22_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_22_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 177 -to 0 ip_22_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_22_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_22_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_3] [get_bd_pins ip_22_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_4] [get_bd_pins ip_22_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 11 -to 0 ip_22_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_22_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_5] [get_bd_pins ip_22_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/slice_5/dout] [get_bd_pins ip_22_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 11 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 11 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 28 -to 0 ip_25_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_25_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 11 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 12 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/slice_0/dout] [get_bd_pins ip_25_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 11 -to 0 ip_25_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_25_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 3 -to 0 ip_25_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_2] [get_bd_pins ip_25_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_3] [get_bd_pins ip_25_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_4] [get_bd_pins ip_25_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 36 -to 0 ip_25_slice_and_concat/in_5
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 37 " [get_bd_cells ip_25_slice_and_concat/slice_5]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_5] [get_bd_pins ip_25_slice_and_concat/slice_5/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/slice_5/dout] [get_bd_pins ip_25_slice_and_concat/concat/In5]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 36 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 18 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 37 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 11 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 36 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 19 CONFIG.DIN_WIDTH 37 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 36 -to 0 ip_28_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 36 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 37 " [get_bd_cells ip_28_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_29_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_29_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_31_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_31_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_33_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 1 -to 0 ip_35_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_35_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 2 " [get_bd_cells ip_35_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_35_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_16_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_1_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_1_uartlite_UART] [get_bd_intf_pins ip_1_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_4_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_iic_IIC] [get_bd_intf_pins ip_4_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_5_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_5_uartlite_UART] [get_bd_intf_pins ip_5_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_6_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi_IIC] [get_bd_intf_pins ip_6_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:display_startup_io:startup_io_rtl:1.0 ip_6_axi_quad_spi_STARTUP_IO
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi_STARTUP_IO] [get_bd_intf_pins ip_6_axi_quad_spi/STARTUP_IO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_7_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite_UART] [get_bd_intf_pins ip_7_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_8_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_quad_spi_IIC] [get_bd_intf_pins ip_8_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_14_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_14_emc_EMC_INTF] [get_bd_intf_pins ip_14_emc/EMC_INTF]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_3_fft/M_AXIS_DATA]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_21_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 1 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_33_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_35_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_15_reset/mb_reset] [get_bd_pins ip_0_microblaze/Reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_1_uartlite/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_iic/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_5_uartlite/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_7_uartlite/reset]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_13_cordic/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/peripheral_areset_n] [get_bd_pins ip_14_emc/rst]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_0_microblaze/Clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_1_uartlite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_2_accumulator/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_3_fft/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_4_axi_iic/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_5_uartlite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_6_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_6_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_7_uartlite/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_8_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_8_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_9_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_10_dft/CLK]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_11_accumulator/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_12_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_12_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_13_cordic/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_14_emc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_14_emc/rdclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_15_reset/clk_in]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_locked] [get_bd_pins ip_15_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_17_intc/irq_0] [get_bd_pins ip_1_uartlite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_1] [get_bd_pins ip_3_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_17_intc/irq_2] [get_bd_pins ip_4_axi_iic/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_3] [get_bd_pins ip_5_uartlite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_4] [get_bd_pins ip_6_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_5] [get_bd_pins ip_7_uartlite/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_6] [get_bd_pins ip_8_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_7] [get_bd_pins ip_9_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_17_intc/irq_8] [get_bd_pins ip_12_axi_hwicap/ip2intc_irpt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_microblaze/INTERRUPT] [get_bd_intf_pins ip_17_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_microblaze/M_AXI_DP] [get_bd_intf_pins ip_18_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_uartlite/AXI] [get_bd_intf_pins ip_18_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_iic/AXI] [get_bd_intf_pins ip_18_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_uartlite/AXI] [get_bd_intf_pins ip_18_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_18_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_uartlite/AXI] [get_bd_intf_pins ip_18_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_18_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_timer/S_AXI] [get_bd_intf_pins ip_18_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_18_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_emc/AXI] [get_bd_intf_pins ip_18_axi/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_intc/AXI] [get_bd_intf_pins ip_18_axi/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_19_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_19_axis_broadcaster/M_AXIS_1]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_21_reduce/in0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_9_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_9_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_3] [get_bd_pins ip_9_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_4] [get_bd_pins ip_10_dft/RFFD]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_5] [get_bd_pins ip_10_dft/XK_RE]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_10_dft/SIZE]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_10_dft/XK_RE]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_12_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_10_dft/XK_RE]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/B]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_10_dft/XK_RE]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_10_dft/XK_IM]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_2] [get_bd_pins ip_10_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_3] [get_bd_pins ip_10_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_4] [get_bd_pins ip_10_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_5] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_10_dft/XN_IM]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_10_dft/XN_RE]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_11_accumulator/B]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_11_accumulator/Q]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_9_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_10_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_10_dft/FD_IN]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_10_dft/CE]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_9_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_11_accumulator/CE]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_18_axi/reset]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_15_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_17_intc/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_18_axi/clk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_19_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_16_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 9 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=9 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=9 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_cordic/S_AXIS_CARTESIAN declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_cordic/S_AXIS_CARTESIAN declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_cordic/M_AXIS_DOUT declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_cordic/M_AXIS_DOUT declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/S_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_0 declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_broadcaster/M_AXIS_1 declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }


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
