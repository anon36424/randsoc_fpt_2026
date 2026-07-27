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



########## axi_dma ##########
create_bd_cell -type hier ip_0_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_0_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 57 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_0_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_0_axi_dma/axi_resetn] [get_bd_pins ip_0_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_0_axi_dma/s2mm_introut] [get_bd_pins ip_0_axi_dma/axi_dma_0/s2mm_introut]


########## axi_iic ##########
create_bd_cell -type hier ip_1_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_1_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x5e CONFIG.C_GPO_WIDTH 8 CONFIG.C_SCL_INERTIAL_DELAY 112 CONFIG.C_SDA_INERTIAL_DELAY 242 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 47.764335930294735 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_1_axi_iic/axi_iic_0]
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


########## uartlite ##########
create_bd_cell -type hier ip_2_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_2_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 2400 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Even " [get_bd_cells ip_2_uartlite/uart_0]
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


########## cordic ##########
create_bd_cell -type hier ip_3_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_3_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Translate CONFIG.Input_Width 31 CONFIG.Iterations 7 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 31 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 34 CONFIG.Round_Mode Round_Pos_Inf " [get_bd_cells ip_3_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_cordic/aclk
connect_bd_net [get_bd_pins ip_3_cordic/aclk] [get_bd_pins ip_3_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_cordic/aclken
connect_bd_net [get_bd_pins ip_3_cordic/aclken] [get_bd_pins ip_3_cordic/cordic_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_3_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_3_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_3_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_3_cordic/cordic_0/M_AXIS_DOUT]


########## uartlite ##########
create_bd_cell -type hier ip_4_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_4_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 128000 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Odd " [get_bd_cells ip_4_uartlite/uart_0]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_5_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_5_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SHARED_STARTUP 1 CONFIG.C_SPI_MEMORY 3 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 1 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_5_axi_quad_spi/axi_quad_spi_0]
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


########## axi_timer ##########
create_bd_cell -type hier ip_6_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_6_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.COUNT_WIDTH 16 CONFIG.GEN0_ASSERT Active_High CONFIG.GEN1_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_Low CONFIG.TRIG1_ASSERT Active_Low CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_6_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_timer/S_AXI] [get_bd_intf_pins ip_6_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_6_axi_timer/capturetrig0] [get_bd_pins ip_6_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_timer/capturetrig1
connect_bd_net [get_bd_pins ip_6_axi_timer/capturetrig1] [get_bd_pins ip_6_axi_timer/axi_timer_0/capturetrig1]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_timer/freeze
connect_bd_net [get_bd_pins ip_6_axi_timer/freeze] [get_bd_pins ip_6_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_6_axi_timer/s_axi_aclk] [get_bd_pins ip_6_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_6_axi_timer/s_axi_aresetn] [get_bd_pins ip_6_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_6_axi_timer/generateout0] [get_bd_pins ip_6_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_6_axi_timer/generateout1] [get_bd_pins ip_6_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_6_axi_timer/pwm0] [get_bd_pins ip_6_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_6_axi_timer/interrupt] [get_bd_pins ip_6_axi_timer/axi_timer_0/interrupt]


########## xadc_wiz ##########
create_bd_cell -type hier ip_7_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_7_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.ADC_OFFSET_CALIBRATION 1 CONFIG.CHANNEL_AVERAGING 16 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_JTAG_ARBITER 0 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION ENABLE_DRP CONFIG.OT_ALARM 1 CONFIG.POWER_DOWN_ADCA 0 CONFIG.POWER_DOWN_ADCB 1 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 0 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_7_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/dclk_in
connect_bd_net [get_bd_pins ip_7_xadc_wiz/dclk_in] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/dclk_in]
create_bd_pin -dir I -from 0 -to 0 ip_7_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_7_xadc_wiz/convst_in] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/ot_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/ot_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/ot_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/eoc_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/eos_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/alarm_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_7_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_7_xadc_wiz/busy_out] [get_bd_pins ip_7_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_7_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_7_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_7_xadc_wiz/xadc_wiz_0/Vp_Vn]


########## emc ##########
create_bd_cell -type hier ip_8_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_8_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 8 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 8 CONFIG.C_MEM2_TYPE 5 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 6 CONFIG.C_TAVDV_PS_MEM_0 14894 CONFIG.C_TAVDV_PS_MEM_1 13699 CONFIG.C_TAVDV_PS_MEM_2 16184 CONFIG.C_TCEDV_PS_MEM_0 14312 CONFIG.C_TCEDV_PS_MEM_1 15405 CONFIG.C_TCEDV_PS_MEM_2 15614 CONFIG.C_THZCE_PS_MEM_0 6744 CONFIG.C_THZCE_PS_MEM_1 7006 CONFIG.C_THZCE_PS_MEM_2 7522 CONFIG.C_THZOE_PS_MEM_0 6968 CONFIG.C_THZOE_PS_MEM_1 7553 CONFIG.C_THZOE_PS_MEM_2 6376 CONFIG.C_TLZWE_PS_MEM_0 6643 CONFIG.C_TLZWE_PS_MEM_1 7512 CONFIG.C_TLZWE_PS_MEM_2 1351 CONFIG.C_TWC_PS_MEM_0 14461 CONFIG.C_TWC_PS_MEM_1 16380 CONFIG.C_TWC_PS_MEM_2 15950 CONFIG.C_TWPH_PS_MEM_0 11503 CONFIG.C_TWPH_PS_MEM_1 11376 CONFIG.C_TWPH_PS_MEM_2 11165 CONFIG.C_TWP_PS_MEM_0 11978 CONFIG.C_TWP_PS_MEM_1 11728 CONFIG.C_TWP_PS_MEM_2 11474 CONFIG.C_WR_REC_TIME_MEM_0 24357 CONFIG.C_WR_REC_TIME_MEM_1 26704 CONFIG.C_WR_REC_TIME_MEM_2 24308 " [get_bd_cells ip_8_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_8_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_8_emc/EMC_INTF] [get_bd_intf_pins ip_8_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_8_emc/clk
connect_bd_net [get_bd_pins ip_8_emc/clk] [get_bd_pins ip_8_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_emc/rdclk
connect_bd_net [get_bd_pins ip_8_emc/rdclk] [get_bd_pins ip_8_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_emc/rst
connect_bd_net [get_bd_pins ip_8_emc/rst] [get_bd_pins ip_8_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_emc/AXI] [get_bd_intf_pins ip_8_emc/emc_0/S_AXI_MEM]


########## axi_hwicap ##########
create_bd_cell -type hier ip_9_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_9_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 " [get_bd_cells ip_9_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_9_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_9_axi_hwicap/icap_clk] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_9_axi_hwicap/eos_in] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_9_axi_hwicap/s_axi_aclk] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_9_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_9_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_9_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_10_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_10_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 37 CONFIG.aresetn 0 CONFIG.atuserwidth 154 CONFIG.bportwidth 14 CONFIG.btuserwidth 239 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 10 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_10_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_10_complex_multiplier/aclk] [get_bd_pins ip_10_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_10_complex_multiplier/aclken] [get_bd_pins ip_10_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_10_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_11_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_11_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 0 CONFIG.C_FIFO_DEPTH 256 CONFIG.C_NUM_TRANSFER_BITS 8 CONFIG.C_SCK_RATIO 16 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 1 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 0 CONFIG.Multiples16 20 " [get_bd_cells ip_11_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/IIC] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/clk4] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/reset4] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_11_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_11_axi_quad_spi/irq] [get_bd_pins ip_11_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_12_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_12_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format UnsignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Square_Root CONFIG.Input_Width 42 CONFIG.Iterations 0 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 27 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Maximum CONFIG.Precision 0 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_12_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_cordic/aclk
connect_bd_net [get_bd_pins ip_12_cordic/aclk] [get_bd_pins ip_12_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_12_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_12_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_12_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_12_cordic/cordic_0/M_AXIS_DOUT]


########## conv_encoder ##########
create_bd_cell -type hier ip_13_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_13_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 5 CONFIG.convolution_code0 29 CONFIG.convolution_code1 26 CONFIG.convolution_code2 3 CONFIG.convolution_code3 29 CONFIG.convolution_code4 2 CONFIG.convolution_code5 9 CONFIG.convolution_code6 20 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 2 CONFIG.output_rate 3 CONFIG.puncture_code0 11 CONFIG.puncture_code1 10 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_13_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_13_conv_encoder/aclk] [get_bd_pins ip_13_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_13_conv_encoder/aclken] [get_bd_pins ip_13_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_13_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_13_conv_encoder/aresetn] [get_bd_pins ip_13_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_14_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_14_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 0 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_14_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_14_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite/MII] [get_bd_intf_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_14_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_14_axi_ethernet_lite/clk] [get_bd_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_14_axi_ethernet_lite/reset] [get_bd_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_14_axi_ethernet_lite/irq] [get_bd_pins ip_14_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## conv_encoder ##########
create_bd_cell -type hier ip_15_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_15_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 8 CONFIG.convolution_code0 39 CONFIG.convolution_code1 138 CONFIG.convolution_code2 99 CONFIG.convolution_code3 150 CONFIG.convolution_code4 208 CONFIG.convolution_code5 222 CONFIG.convolution_code6 210 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 5 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_15_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_15_conv_encoder/aclk] [get_bd_pins ip_15_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_15_conv_encoder/aresetn] [get_bd_pins ip_15_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_15_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_15_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_15_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_15_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## dft ##########
create_bd_cell -type hier ip_16_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_16_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 13 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_16_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_dft/CLK
connect_bd_net [get_bd_pins ip_16_dft/CLK] [get_bd_pins ip_16_dft/dft_0/CLK]
create_bd_pin -dir I -from 12 -to 0 ip_16_dft/XN_RE
connect_bd_net [get_bd_pins ip_16_dft/XN_RE] [get_bd_pins ip_16_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 12 -to 0 ip_16_dft/XN_IM
connect_bd_net [get_bd_pins ip_16_dft/XN_IM] [get_bd_pins ip_16_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_16_dft/FD_IN
connect_bd_net [get_bd_pins ip_16_dft/FD_IN] [get_bd_pins ip_16_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_16_dft/FWD_INV
connect_bd_net [get_bd_pins ip_16_dft/FWD_INV] [get_bd_pins ip_16_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_16_dft/SIZE
connect_bd_net [get_bd_pins ip_16_dft/SIZE] [get_bd_pins ip_16_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_16_dft/RFFD
connect_bd_net [get_bd_pins ip_16_dft/RFFD] [get_bd_pins ip_16_dft/dft_0/RFFD]
create_bd_pin -dir O -from 12 -to 0 ip_16_dft/XK_RE
connect_bd_net [get_bd_pins ip_16_dft/XK_RE] [get_bd_pins ip_16_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 12 -to 0 ip_16_dft/XK_IM
connect_bd_net [get_bd_pins ip_16_dft/XK_IM] [get_bd_pins ip_16_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_16_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_16_dft/BLK_EXP] [get_bd_pins ip_16_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_16_dft/FD_OUT
connect_bd_net [get_bd_pins ip_16_dft/FD_OUT] [get_bd_pins ip_16_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_16_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_16_dft/DATA_VALID] [get_bd_pins ip_16_dft/dft_0/DATA_VALID]


########## axi_iic ##########
create_bd_cell -type hier ip_17_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_17_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x42 CONFIG.C_GPO_WIDTH 5 CONFIG.C_SCL_INERTIAL_DELAY 105 CONFIG.C_SDA_INERTIAL_DELAY 192 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 711.7619960847886 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_17_axi_iic/axi_iic_0]
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
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 56 CONFIG.aresetn 1 CONFIG.atuserwidth 198 CONFIG.bportwidth 17 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 1 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 33 CONFIG.outtlastbehv OR_all_TLASTs CONFIG.roundmode Random_Rounding " [get_bd_cells ip_18_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_18_complex_multiplier/aclk] [get_bd_pins ip_18_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_18_complex_multiplier/aclken] [get_bd_pins ip_18_complex_multiplier/cmpy_0/aclken]
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


########## conv_encoder ##########
create_bd_cell -type hier ip_19_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_19_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 5 CONFIG.convolution_code0 4 CONFIG.convolution_code1 8 CONFIG.convolution_code2 23 CONFIG.convolution_code3 25 CONFIG.convolution_code4 10 CONFIG.convolution_code5 0 CONFIG.convolution_code6 2 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 3 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_19_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_19_conv_encoder/aclk] [get_bd_pins ip_19_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_19_conv_encoder/aresetn] [get_bd_pins ip_19_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_19_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_19_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## dft ##########
create_bd_cell -type hier ip_20_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_20_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 13 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_20_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/CLK
connect_bd_net [get_bd_pins ip_20_dft/CLK] [get_bd_pins ip_20_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/CE
connect_bd_net [get_bd_pins ip_20_dft/CE] [get_bd_pins ip_20_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/SCLR
connect_bd_net [get_bd_pins ip_20_dft/SCLR] [get_bd_pins ip_20_dft/dft_0/SCLR]
create_bd_pin -dir I -from 12 -to 0 ip_20_dft/XN_RE
connect_bd_net [get_bd_pins ip_20_dft/XN_RE] [get_bd_pins ip_20_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 12 -to 0 ip_20_dft/XN_IM
connect_bd_net [get_bd_pins ip_20_dft/XN_IM] [get_bd_pins ip_20_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/FD_IN
connect_bd_net [get_bd_pins ip_20_dft/FD_IN] [get_bd_pins ip_20_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_20_dft/FWD_INV
connect_bd_net [get_bd_pins ip_20_dft/FWD_INV] [get_bd_pins ip_20_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_20_dft/SIZE
connect_bd_net [get_bd_pins ip_20_dft/SIZE] [get_bd_pins ip_20_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_20_dft/RFFD
connect_bd_net [get_bd_pins ip_20_dft/RFFD] [get_bd_pins ip_20_dft/dft_0/RFFD]
create_bd_pin -dir O -from 12 -to 0 ip_20_dft/XK_RE
connect_bd_net [get_bd_pins ip_20_dft/XK_RE] [get_bd_pins ip_20_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 12 -to 0 ip_20_dft/XK_IM
connect_bd_net [get_bd_pins ip_20_dft/XK_IM] [get_bd_pins ip_20_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_20_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_20_dft/BLK_EXP] [get_bd_pins ip_20_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_20_dft/FD_OUT
connect_bd_net [get_bd_pins ip_20_dft/FD_OUT] [get_bd_pins ip_20_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_20_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_20_dft/DATA_VALID] [get_bd_pins ip_20_dft/dft_0/DATA_VALID]


########## dft ##########
create_bd_cell -type hier ip_21_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_21_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 14 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_21_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/CLK
connect_bd_net [get_bd_pins ip_21_dft/CLK] [get_bd_pins ip_21_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/CE
connect_bd_net [get_bd_pins ip_21_dft/CE] [get_bd_pins ip_21_dft/dft_0/CE]
create_bd_pin -dir I -from 13 -to 0 ip_21_dft/XN_RE
connect_bd_net [get_bd_pins ip_21_dft/XN_RE] [get_bd_pins ip_21_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 13 -to 0 ip_21_dft/XN_IM
connect_bd_net [get_bd_pins ip_21_dft/XN_IM] [get_bd_pins ip_21_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/FD_IN
connect_bd_net [get_bd_pins ip_21_dft/FD_IN] [get_bd_pins ip_21_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_21_dft/FWD_INV
connect_bd_net [get_bd_pins ip_21_dft/FWD_INV] [get_bd_pins ip_21_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_21_dft/SIZE
connect_bd_net [get_bd_pins ip_21_dft/SIZE] [get_bd_pins ip_21_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_21_dft/RFFD
connect_bd_net [get_bd_pins ip_21_dft/RFFD] [get_bd_pins ip_21_dft/dft_0/RFFD]
create_bd_pin -dir O -from 13 -to 0 ip_21_dft/XK_RE
connect_bd_net [get_bd_pins ip_21_dft/XK_RE] [get_bd_pins ip_21_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 13 -to 0 ip_21_dft/XK_IM
connect_bd_net [get_bd_pins ip_21_dft/XK_IM] [get_bd_pins ip_21_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_21_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_21_dft/BLK_EXP] [get_bd_pins ip_21_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_21_dft/FD_OUT
connect_bd_net [get_bd_pins ip_21_dft/FD_OUT] [get_bd_pins ip_21_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_21_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_21_dft/DATA_VALID] [get_bd_pins ip_21_dft/dft_0/DATA_VALID]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_22_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_22_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 1 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 1 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_22_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_22_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_quad_spi/IIC] [get_bd_intf_pins ip_22_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/clk4] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/reset4] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_22_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_22_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_22_axi_quad_spi/irq] [get_bd_pins ip_22_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## reset ##########
create_bd_cell -type hier ip_23_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_23_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_reset/clk_in
connect_bd_net [get_bd_pins ip_23_reset/clk_in] [get_bd_pins ip_23_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_23_reset/reset_in
connect_bd_net [get_bd_pins ip_23_reset/reset_in] [get_bd_pins ip_23_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_23_reset/dcm_locked
connect_bd_net [get_bd_pins ip_23_reset/dcm_locked] [get_bd_pins ip_23_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_23_reset/mb_reset
connect_bd_net [get_bd_pins ip_23_reset/mb_reset] [get_bd_pins ip_23_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_23_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_23_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_23_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset] [get_bd_pins ip_23_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_23_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_23_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_24_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_24_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_in] [get_bd_pins ip_24_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_24_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_24_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_24_clk_wiz/reset
connect_bd_net [get_bd_pins ip_24_clk_wiz/reset] [get_bd_pins ip_24_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_24_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_locked] [get_bd_pins ip_24_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_25_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_25_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_25_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 11 " [get_bd_cells ip_25_intc/concat_0]
connect_bd_net [get_bd_pins ip_25_intc/concat_0/dout] [get_bd_pins ip_25_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/clk
connect_bd_net [get_bd_pins ip_25_intc/clk] [get_bd_pins ip_25_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/reset
connect_bd_net [get_bd_pins ip_25_intc/reset] [get_bd_pins ip_25_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_25_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_25_intc/AXI] [get_bd_intf_pins ip_25_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_0
connect_bd_net [get_bd_pins ip_25_intc/irq_0] [get_bd_pins ip_25_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_1
connect_bd_net [get_bd_pins ip_25_intc/irq_1] [get_bd_pins ip_25_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_2
connect_bd_net [get_bd_pins ip_25_intc/irq_2] [get_bd_pins ip_25_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_3
connect_bd_net [get_bd_pins ip_25_intc/irq_3] [get_bd_pins ip_25_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_4
connect_bd_net [get_bd_pins ip_25_intc/irq_4] [get_bd_pins ip_25_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_5
connect_bd_net [get_bd_pins ip_25_intc/irq_5] [get_bd_pins ip_25_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_6
connect_bd_net [get_bd_pins ip_25_intc/irq_6] [get_bd_pins ip_25_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_7
connect_bd_net [get_bd_pins ip_25_intc/irq_7] [get_bd_pins ip_25_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_8
connect_bd_net [get_bd_pins ip_25_intc/irq_8] [get_bd_pins ip_25_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_9
connect_bd_net [get_bd_pins ip_25_intc/irq_9] [get_bd_pins ip_25_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_25_intc/irq_10
connect_bd_net [get_bd_pins ip_25_intc/irq_10] [get_bd_pins ip_25_intc/concat_0/In10]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_25_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_25_intc/irq] [get_bd_intf_pins ip_25_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_26_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_26_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 14 CONFIG.NUM_SI 2 " [get_bd_cells ip_26_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_legacy/clk
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_26_axi_legacy/reset
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_M0] [get_bd_intf_pins ip_26_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_M1] [get_bd_intf_pins ip_26_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S0] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S1] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S2] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S3] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S4] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S5] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S6] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S7] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S8] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S9] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S10] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S11] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S12] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M12_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_axi_legacy/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_26_axi_legacy/AXI_S13] [get_bd_intf_pins ip_26_axi_legacy/axi_0/M13_AXI]
connect_bd_net [get_bd_pins ip_26_axi_legacy/clk] [get_bd_pins ip_26_axi_legacy/axi_0/M13_ACLK]
connect_bd_net [get_bd_pins ip_26_axi_legacy/reset] [get_bd_pins ip_26_axi_legacy/axi_0/M13_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_27_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_27_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_27_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_28_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_28_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_28_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_28_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_29_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_29_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_29_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_29_axis_broadcaster/aclk] [get_bd_pins ip_29_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_29_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_29_axis_broadcaster/aresetn] [get_bd_pins ip_29_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_29_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_30_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_30_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_30_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_30_axis_broadcaster/aclk] [get_bd_pins ip_30_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_30_axis_broadcaster/aresetn] [get_bd_pins ip_30_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_31_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_31_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_31_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_31_axis_broadcaster/aclk] [get_bd_pins ip_31_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_31_axis_broadcaster/aresetn] [get_bd_pins ip_31_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_32_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_32_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_33_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_34_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_35_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_36_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_37_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_38_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.NUM_SI 4 " [get_bd_cells ip_40_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_40_axis_combiner/aclk] [get_bd_pins ip_40_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_40_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_40_axis_combiner/aresetn] [get_bd_pins ip_40_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/S_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S03_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_40_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_40_axis_combiner/M_AXIS] [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_41_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_41_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aclk] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_41_axis_dwidth_converter/aresetn] [get_bd_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_42_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_42_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_42_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_42_axis_combiner/aclk] [get_bd_pins ip_42_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_42_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_42_axis_combiner/aresetn] [get_bd_pins ip_42_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_42_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_42_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_42_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_42_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_42_axis_combiner/M_AXIS] [get_bd_intf_pins ip_42_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_43_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_43_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_43_axis_dwidth_converter/axis_dwidth_converter_0]
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


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_45_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_45_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_45_slice_and_concat/concat/In0]
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
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_6] [get_bd_pins ip_45_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 12 -to 0 ip_45_slice_and_concat/in_7
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_45_slice_and_concat] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_45_slice_and_concat/slice_7]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_7] [get_bd_pins ip_45_slice_and_concat/slice_7/din]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/slice_7/dout] [get_bd_pins ip_45_slice_and_concat/concat/In7]


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 12 -to 0 ip_46_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_46_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 6 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_46_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_46_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_47_slice_and_concat/out0
create_bd_pin -dir I -from 12 -to 0 ip_47_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_47_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 12 CONFIG.DIN_TO 7 CONFIG.DIN_WIDTH 13 " [get_bd_cells ip_47_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_47_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_48_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_48_slice_and_concat/out0
create_bd_pin -dir I -from 12 -to 0 ip_48_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_49_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_49_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_49_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_49_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_49_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_49_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_49_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_1] [get_bd_pins ip_49_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_49_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_2] [get_bd_pins ip_49_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_50_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_50_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_50_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_50_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 12 -to 0 ip_50_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_1] [get_bd_pins ip_50_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_51_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_51_slice_and_concat/out0
create_bd_pin -dir I -from 12 -to 0 ip_51_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_52_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_52_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_52_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_52_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_52_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_52_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_1] [get_bd_pins ip_52_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_52_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_2] [get_bd_pins ip_52_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 12 -to 0 ip_53_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_53_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_53_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_53_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_53_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_53_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_1] [get_bd_pins ip_53_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/slice_1/dout] [get_bd_pins ip_53_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 7 -to 0 ip_54_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_54_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_54_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_54_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_54_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/slice_0/dout] [get_bd_pins ip_54_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 13 -to 0 ip_54_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_54_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_1] [get_bd_pins ip_54_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/slice_1/dout] [get_bd_pins ip_54_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_55_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_55_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 13 -to 0 ip_55_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 14 " [get_bd_cells ip_55_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_55_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/slice_0/dout] [get_bd_pins ip_55_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_55_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_1] [get_bd_pins ip_55_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_2] [get_bd_pins ip_55_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_55_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_3] [get_bd_pins ip_55_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_56_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_56_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_56_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_56_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_57_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_57_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_57_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_57_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 2 -to 0 ip_58_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 3 " [get_bd_cells ip_58_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_59_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_59_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_59_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_60_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_60_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_60_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_61_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_61_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_61_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_62_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_62_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_62_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_63_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_63_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_63_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_64_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_64_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_64_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_65_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_65_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_66_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_66_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_66_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_67_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_67_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_67_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_68_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_68_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_68_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_69_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_69_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_69_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_70_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_70_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_70_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_71_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_71_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_71_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_23_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_24_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_1_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_iic_IIC] [get_bd_intf_pins ip_1_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_2_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_2_uartlite_UART] [get_bd_intf_pins ip_2_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_4_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_4_uartlite_UART] [get_bd_intf_pins ip_4_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_5_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi_IIC] [get_bd_intf_pins ip_5_axi_quad_spi/IIC]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:startup_rtl:1.0 ip_5_axi_quad_spi_STARTUP_IO_S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi_STARTUP_IO_S] [get_bd_intf_pins ip_5_axi_quad_spi/STARTUP_IO_S]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_7_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_7_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_7_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_8_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_8_emc_EMC_INTF] [get_bd_intf_pins ip_8_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_11_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_quad_spi_IIC] [get_bd_intf_pins ip_11_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_14_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite_MII] [get_bd_intf_pins ip_14_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_14_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_14_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_17_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_iic_IIC] [get_bd_intf_pins ip_17_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_22_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_quad_spi_IIC] [get_bd_intf_pins ip_22_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_25_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_27_axis_broadcaster/S_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 7 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_54_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 2 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_56_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_57_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_58_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_24_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_25_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_iic/reset]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_2_uartlite/reset]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_4_uartlite/reset]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_8_emc/rst]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_13_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_15_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_iic/reset]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_18_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_19_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset] [get_bd_pins ip_20_dft/SCLR]
connect_bd_net [get_bd_pins ip_23_reset/peripheral_areset_n] [get_bd_pins ip_22_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_1_axi_iic/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_2_uartlite/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_3_cordic/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_4_uartlite/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_6_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_7_xadc_wiz/dclk_in]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_8_emc/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_8_emc/rdclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_9_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_9_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_10_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_11_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_12_cordic/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_13_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_14_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_15_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_16_dft/CLK]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_17_axi_iic/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_18_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_19_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_20_dft/CLK]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_21_dft/CLK]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_22_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_22_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_23_reset/clk_in]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_locked] [get_bd_pins ip_23_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_25_intc/irq_0] [get_bd_pins ip_0_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_25_intc/irq_1] [get_bd_pins ip_1_axi_iic/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_2] [get_bd_pins ip_2_uartlite/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_3] [get_bd_pins ip_4_uartlite/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_4] [get_bd_pins ip_5_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_5] [get_bd_pins ip_6_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_25_intc/irq_6] [get_bd_pins ip_9_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_25_intc/irq_7] [get_bd_pins ip_11_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_8] [get_bd_pins ip_14_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_9] [get_bd_pins ip_17_axi_iic/irq]
connect_bd_net [get_bd_pins ip_25_intc/irq_10] [get_bd_pins ip_22_axi_quad_spi/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_26_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_26_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_26_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_iic/AXI] [get_bd_intf_pins ip_26_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_uartlite/AXI] [get_bd_intf_pins ip_26_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_uartlite/AXI] [get_bd_intf_pins ip_26_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_26_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_26_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_timer/S_AXI] [get_bd_intf_pins ip_26_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_emc/AXI] [get_bd_intf_pins ip_26_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_26_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_26_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_26_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_iic/AXI] [get_bd_intf_pins ip_26_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_26_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_intc/AXI] [get_bd_intf_pins ip_26_axi_legacy/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_29_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_30_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_31_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_15_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_35_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_31_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_40_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_42_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_16_dft/XN_RE]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_6_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_1] [get_bd_pins ip_6_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_2] [get_bd_pins ip_6_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_3] [get_bd_pins ip_7_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_4] [get_bd_pins ip_7_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_5] [get_bd_pins ip_7_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_6] [get_bd_pins ip_16_dft/RFFD]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_7] [get_bd_pins ip_16_dft/XK_RE]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_9_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_16_dft/XK_RE]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_16_dft/SIZE]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_16_dft/XK_RE]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_20_dft/XN_RE]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_16_dft/XK_IM]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_21_dft/SIZE]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_16_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_1] [get_bd_pins ip_16_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_2] [get_bd_pins ip_16_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_21_dft/XN_IM]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_20_dft/RFFD]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_1] [get_bd_pins ip_20_dft/XK_RE]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_20_dft/XN_IM]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_20_dft/XK_IM]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_20_dft/SIZE]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_20_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_1] [get_bd_pins ip_20_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_2] [get_bd_pins ip_20_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_16_dft/XN_IM]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_21_dft/RFFD]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_1] [get_bd_pins ip_21_dft/XK_RE]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_21_dft/XK_RE]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_1] [get_bd_pins ip_21_dft/XK_IM]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_21_dft/XN_RE]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_21_dft/XK_IM]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_1] [get_bd_pins ip_21_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_2] [get_bd_pins ip_21_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_3] [get_bd_pins ip_21_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_21_dft/CE]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_6_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_7_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_20_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_59_slice_and_concat/out0] [get_bd_pins ip_59_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_3_cordic/aclken]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_60_slice_and_concat/out0] [get_bd_pins ip_60_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_10_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_61_slice_and_concat/out0] [get_bd_pins ip_61_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_21_dft/FD_IN]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_62_slice_and_concat/out0] [get_bd_pins ip_62_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_6_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/ot_out]
connect_bd_net [get_bd_pins ip_63_slice_and_concat/out0] [get_bd_pins ip_63_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_13_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_64_slice_and_concat/out0] [get_bd_pins ip_64_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_20_dft/CE]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_65_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_20_dft/FD_IN]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_16_dft/FD_IN]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_18_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_21_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_6_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_70_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_16_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_0] [get_bd_pins ip_7_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_71_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_26_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_23_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_25_intc/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_26_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_27_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_28_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_29_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_30_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_31_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_33_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_34_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_35_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_36_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_37_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_38_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_40_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_42_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_24_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_cordic/S_AXIS_CARTESIAN declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_cordic/S_AXIS_CARTESIAN declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_A declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_A declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_complex_multiplier/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_cordic/S_AXIS_CARTESIAN declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_cordic/S_AXIS_CARTESIAN declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
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
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/M_AXIS_DOUT declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_complex_multiplier/M_AXIS_DOUT declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_29_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_29_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
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
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/S03_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_3 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/S_AXIS_3 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_combiner/S_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_combiner/S_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_combiner/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_combiner/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
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
