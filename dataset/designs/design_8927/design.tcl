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
set_property -dict "CONFIG.C_ADDR_WIDTH 44 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 4 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 512 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_NUM_MM2S_CHANNELS 13 CONFIG.C_NUM_S2MM_CHANNELS 9 CONFIG.C_S2MM_BURST_SIZE 2 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 26 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 8 " [get_bd_cells ip_0_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_0_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_0_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_0_axi_dma/axi_resetn] [get_bd_pins ip_0_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_0_axi_dma/mm2s_introut] [get_bd_pins ip_0_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_0_axi_dma/s2mm_introut] [get_bd_pins ip_0_axi_dma/axi_dma_0/s2mm_introut]


########## complex_multiplier ##########
create_bd_cell -type hier ip_1_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_1_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 12 CONFIG.aresetn 0 CONFIG.bportwidth 15 CONFIG.btuserwidth 155 CONFIG.ctrltuserwidth 36 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 21 CONFIG.roundmode Random_Rounding " [get_bd_cells ip_1_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aclk] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aclken] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_cdma ##########
create_bd_cell -type hier ip_2_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_2_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 48 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_2_axi_cdma/axi_cdma_0]
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


########## fft ##########
create_bd_cell -type hier ip_3_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_3_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 8 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 64 " [get_bd_cells ip_3_fft/fft_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_4_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_4_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.a_tuser_width 73 CONFIG.add_sub_value Add CONFIG.axi_optimize_goal Performance CONFIG.c_a_exponent_width 9 CONFIG.c_a_fraction_width 32 CONFIG.c_accum_input_msb 148 CONFIG.c_accum_lsb -260 CONFIG.c_accum_msb 150 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_accum_input_overflow 0 CONFIG.c_has_accum_overflow 1 CONFIG.c_has_invalid_op 1 CONFIG.c_has_overflow 0 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage No_Usage CONFIG.c_optimization Low_Latency CONFIG.flow_control Blocking CONFIG.has_a_tuser 1 CONFIG.has_aclken 0 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 1 CONFIG.maximum_latency 1 CONFIG.operation_type Accumulator " [get_bd_cells ip_4_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aclk
connect_bd_net [get_bd_pins ip_4_floating_point/aclk] [get_bd_pins ip_4_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_floating_point/aresetn
connect_bd_net [get_bd_pins ip_4_floating_point/aresetn] [get_bd_pins ip_4_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_5_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_5_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SPI_MEMORY 2 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_5_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_5_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi/IIC] [get_bd_intf_pins ip_5_axi_quad_spi/axi_quad_spi_0/SPI_0]
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
set_property -dict "CONFIG.COUNT_WIDTH 16 CONFIG.GEN0_ASSERT Active_Low CONFIG.GEN1_ASSERT Active_Low CONFIG.TRIG0_ASSERT Active_High CONFIG.TRIG1_ASSERT Active_High CONFIG.enable_timer2 1 CONFIG.mode_64bit 0 " [get_bd_cells ip_6_axi_timer/axi_timer_0]
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


########## axi_dma ##########
create_bd_cell -type hier ip_7_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_7_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 41 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_7_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_7_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_7_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_7_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_7_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_7_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_7_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_7_axi_dma/axi_resetn] [get_bd_pins ip_7_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_7_axi_dma/s2mm_introut] [get_bd_pins ip_7_axi_dma/axi_dma_0/s2mm_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_8_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_8_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 64 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 16 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 128 CONFIG.C_NUM_MM2S_CHANNELS 10 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 14 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_8_axi_dma/axi_dma_0]
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


########## gpio ##########
create_bd_cell -type hier ip_9_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_9_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 24 CONFIG.C_GPIO_WIDTH 14 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_9_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/GPIO] [get_bd_intf_pins ip_9_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/GPIO2] [get_bd_intf_pins ip_9_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/clk
connect_bd_net [get_bd_pins ip_9_gpio/clk] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_gpio/rst
connect_bd_net [get_bd_pins ip_9_gpio/rst] [get_bd_pins ip_9_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_9_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_gpio/irq
connect_bd_net [get_bd_pins ip_9_gpio/irq] [get_bd_pins ip_9_gpio/gpio_0/ip2intc_irpt]


########## fft ##########
create_bd_cell -type hier ip_10_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_10_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 2 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 2048 " [get_bd_cells ip_10_fft/fft_0]
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


########## fft ##########
create_bd_cell -type hier ip_11_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_11_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 1 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_4_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 8192 " [get_bd_cells ip_11_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_fft/aclk
connect_bd_net [get_bd_pins ip_11_fft/aclk] [get_bd_pins ip_11_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_11_fft/event_frame_started
connect_bd_net [get_bd_pins ip_11_fft/event_frame_started] [get_bd_pins ip_11_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_11_fft/S_AXIS_DATA] [get_bd_intf_pins ip_11_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_11_fft/M_AXIS_DATA] [get_bd_intf_pins ip_11_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_11_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_11_fft/fft_0/S_AXIS_CONFIG]


########## conv_encoder ##########
create_bd_cell -type hier ip_12_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_12_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 9 CONFIG.convolution_code0 408 CONFIG.convolution_code1 97 CONFIG.convolution_code2 212 CONFIG.convolution_code3 130 CONFIG.convolution_code4 493 CONFIG.convolution_code5 135 CONFIG.convolution_code6 449 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 1 CONFIG.input_rate 5 CONFIG.output_rate 8 CONFIG.puncture_code0 10111 CONFIG.puncture_code1 11101 CONFIG.punctured 1 CONFIG.tready 1 " [get_bd_cells ip_12_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_12_conv_encoder/aclk] [get_bd_pins ip_12_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_12_conv_encoder/aresetn] [get_bd_pins ip_12_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_12_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_12_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_12_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_12_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_hwicap ##########
create_bd_cell -type hier ip_13_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_13_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 1 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 0 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 CONFIG.C_SHARED_STARTUP 0 CONFIG.C_WRITE_FIFO_DEPTH 64 " [get_bd_cells ip_13_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_13_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_13_axi_hwicap/icap_clk] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_13_axi_hwicap/eos_in] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_13_axi_hwicap/s_axi_aclk] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_13_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_13_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_13_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_13_axi_hwicap/axi_hwicap_0/ip2intc_irpt]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_13_axi_hwicap/ICAP
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_hwicap/ICAP] [get_bd_intf_pins ip_13_axi_hwicap/axi_hwicap_0/ICAP]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_13_axi_hwicap/ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_hwicap/ICAP_ARBITER] [get_bd_intf_pins ip_13_axi_hwicap/axi_hwicap_0/ICAP_ARBITER]


########## axi_dma ##########
create_bd_cell -type hier ip_14_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_14_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 47 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 256 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_NUM_MM2S_CHANNELS 10 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 9 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_14_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_14_axi_dma/axi_resetn] [get_bd_pins ip_14_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_14_axi_dma/mm2s_introut] [get_bd_pins ip_14_axi_dma/axi_dma_0/mm2s_introut]


########## complex_multiplier ##########
create_bd_cell -type hier ip_15_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_15_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 11 CONFIG.aresetn 0 CONFIG.atuserwidth 38 CONFIG.bportwidth 9 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 36 CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 14 CONFIG.roundmode Random_Rounding " [get_bd_cells ip_15_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_15_complex_multiplier/aclk] [get_bd_pins ip_15_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_15_complex_multiplier/aclken] [get_bd_pins ip_15_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_15_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_15_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## complex_multiplier ##########
create_bd_cell -type hier ip_16_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_16_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 50 CONFIG.aresetn 1 CONFIG.atuserwidth 250 CONFIG.bportwidth 33 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 0 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 46 CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 79 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_16_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_16_complex_multiplier/aclk] [get_bd_pins ip_16_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_16_complex_multiplier/aclken] [get_bd_pins ip_16_complex_multiplier/cmpy_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_16_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_16_complex_multiplier/aresetn] [get_bd_pins ip_16_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_16_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_16_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_16_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_16_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_16_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_16_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## uartlite ##########
create_bd_cell -type hier ip_17_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_17_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 230400 CONFIG.C_DATA_BITS 6 CONFIG.PARITY No_Parity " [get_bd_cells ip_17_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_17_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_17_uartlite/UART] [get_bd_intf_pins ip_17_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_17_uartlite/clk
connect_bd_net [get_bd_pins ip_17_uartlite/clk] [get_bd_pins ip_17_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_uartlite/reset
connect_bd_net [get_bd_pins ip_17_uartlite/reset] [get_bd_pins ip_17_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_uartlite/AXI] [get_bd_intf_pins ip_17_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_17_uartlite/irq
connect_bd_net [get_bd_pins ip_17_uartlite/irq] [get_bd_pins ip_17_uartlite/uart_0/interrupt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_18_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_18_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 0 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_18_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_18_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_ethernet_lite/MII] [get_bd_intf_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_18_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_18_axi_ethernet_lite/clk] [get_bd_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_18_axi_ethernet_lite/reset] [get_bd_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_18_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_18_axi_ethernet_lite/irq] [get_bd_pins ip_18_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## accumulator ##########
create_bd_cell -type hier ip_19_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_19_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 15 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 15 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_19_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_accumulator/clk
connect_bd_net [get_bd_pins ip_19_accumulator/clk] [get_bd_pins ip_19_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 14 -to 0 ip_19_accumulator/B
connect_bd_net [get_bd_pins ip_19_accumulator/B] [get_bd_pins ip_19_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 14 -to 0 ip_19_accumulator/Q
connect_bd_net [get_bd_pins ip_19_accumulator/Q] [get_bd_pins ip_19_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_19_accumulator/ADD
connect_bd_net [get_bd_pins ip_19_accumulator/ADD] [get_bd_pins ip_19_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_19_accumulator/CE
connect_bd_net [get_bd_pins ip_19_accumulator/CE] [get_bd_pins ip_19_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_19_accumulator/C_IN
connect_bd_net [get_bd_pins ip_19_accumulator/C_IN] [get_bd_pins ip_19_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_19_accumulator/Bypass
connect_bd_net [get_bd_pins ip_19_accumulator/Bypass] [get_bd_pins ip_19_accumulator/accumulator_0/Bypass]


########## axi_iic ##########
create_bd_cell -type hier ip_20_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_20_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0xa CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 130 CONFIG.C_SDA_INERTIAL_DELAY 191 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 518.360463435555 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_20_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_20_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_iic/IIC] [get_bd_intf_pins ip_20_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_iic/clk
connect_bd_net [get_bd_pins ip_20_axi_iic/clk] [get_bd_pins ip_20_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axi_iic/reset
connect_bd_net [get_bd_pins ip_20_axi_iic/reset] [get_bd_pins ip_20_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_iic/AXI] [get_bd_intf_pins ip_20_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_20_axi_iic/irq
connect_bd_net [get_bd_pins ip_20_axi_iic/irq] [get_bd_pins ip_20_axi_iic/axi_iic_0/iic2intc_irpt]


########## accumulator ##########
create_bd_cell -type hier ip_21_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_21_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 0 CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 36 CONFIG.Latency 1 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 80 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 CONFIG.Scale 2 " [get_bd_cells ip_21_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/clk
connect_bd_net [get_bd_pins ip_21_accumulator/clk] [get_bd_pins ip_21_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 35 -to 0 ip_21_accumulator/B
connect_bd_net [get_bd_pins ip_21_accumulator/B] [get_bd_pins ip_21_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 79 -to 0 ip_21_accumulator/Q
connect_bd_net [get_bd_pins ip_21_accumulator/Q] [get_bd_pins ip_21_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/ADD
connect_bd_net [get_bd_pins ip_21_accumulator/ADD] [get_bd_pins ip_21_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/CE
connect_bd_net [get_bd_pins ip_21_accumulator/CE] [get_bd_pins ip_21_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/C_IN
connect_bd_net [get_bd_pins ip_21_accumulator/C_IN] [get_bd_pins ip_21_accumulator/accumulator_0/C_IN]
create_bd_pin -dir I -from 0 -to 0 ip_21_accumulator/Bypass
connect_bd_net [get_bd_pins ip_21_accumulator/Bypass] [get_bd_pins ip_21_accumulator/accumulator_0/Bypass]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_22_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_22_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 1 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 0 CONFIG.C_S_AXI_PROTOCOL AXI4LITE CONFIG.C_TX_PING_PONG 1 " [get_bd_cells ip_22_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_22_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_ethernet_lite/MII] [get_bd_intf_pins ip_22_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_22_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_22_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_22_axi_ethernet_lite/clk] [get_bd_pins ip_22_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_22_axi_ethernet_lite/reset] [get_bd_pins ip_22_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_22_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_22_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_22_axi_ethernet_lite/irq] [get_bd_pins ip_22_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## complex_multiplier ##########
create_bd_cell -type hier ip_23_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_23_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 45 CONFIG.aresetn 0 CONFIG.bportwidth 43 CONFIG.btuserwidth 199 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 25 CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 65 CONFIG.outtlastbehv Pass_B_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_23_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_23_complex_multiplier/aclk] [get_bd_pins ip_23_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_23_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_23_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_23_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_23_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_23_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_23_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## conv_encoder ##########
create_bd_cell -type hier ip_24_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_24_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 6 CONFIG.convolution_code0 46 CONFIG.convolution_code1 54 CONFIG.convolution_code2 18 CONFIG.convolution_code3 15 CONFIG.convolution_code4 50 CONFIG.convolution_code5 39 CONFIG.convolution_code6 2 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 3 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_24_conv_encoder/conv_encoder_0]
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


########## floating_point ##########
create_bd_cell -type hier ip_25_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_25_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.a_tuser_width 55 CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Resources CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_divide_by_zero 1 CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage Full_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 1 CONFIG.has_aclken 1 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_type Rec_Square_Root " [get_bd_cells ip_25_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_floating_point/aclk
connect_bd_net [get_bd_pins ip_25_floating_point/aclk] [get_bd_pins ip_25_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_floating_point/aclken
connect_bd_net [get_bd_pins ip_25_floating_point/aclken] [get_bd_pins ip_25_floating_point/floating_point_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_25_floating_point/aresetn
connect_bd_net [get_bd_pins ip_25_floating_point/aresetn] [get_bd_pins ip_25_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_25_floating_point/S_AXIS_A] [get_bd_intf_pins ip_25_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_25_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_25_floating_point/floating_point_0/M_AXIS_RESULT]


########## gpio ##########
create_bd_cell -type hier ip_26_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_26_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0xf CONFIG.C_GPIO_WIDTH 4 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_26_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_26_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_26_gpio/GPIO] [get_bd_intf_pins ip_26_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_26_gpio/clk
connect_bd_net [get_bd_pins ip_26_gpio/clk] [get_bd_pins ip_26_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_gpio/rst
connect_bd_net [get_bd_pins ip_26_gpio/rst] [get_bd_pins ip_26_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_26_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_26_gpio/AXI] [get_bd_intf_pins ip_26_gpio/gpio_0/S_AXI]


########## complex_multiplier ##########
create_bd_cell -type hier ip_27_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_27_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 56 CONFIG.aresetn 1 CONFIG.atuserwidth 205 CONFIG.bportwidth 63 CONFIG.btuserwidth 8 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 1 CONFIG.hasbtlast 1 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Performance CONFIG.outputwidth 77 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Random_Rounding " [get_bd_cells ip_27_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_27_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_27_complex_multiplier/aclk] [get_bd_pins ip_27_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_27_complex_multiplier/aresetn] [get_bd_pins ip_27_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_27_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_27_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_27_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_27_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_27_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_27_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_27_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_27_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_27_complex_multiplier/cmpy_0/M_AXIS_DOUT]


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
set_property -dict "CONFIG.NUM_PORTS 17 " [get_bd_cells ip_30_intc/concat_0]
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
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_13
connect_bd_net [get_bd_pins ip_30_intc/irq_13] [get_bd_pins ip_30_intc/concat_0/In13]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_14
connect_bd_net [get_bd_pins ip_30_intc/irq_14] [get_bd_pins ip_30_intc/concat_0/In14]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_15
connect_bd_net [get_bd_pins ip_30_intc/irq_15] [get_bd_pins ip_30_intc/concat_0/In15]
create_bd_pin -dir I -from 0 -to 0 ip_30_intc/irq_16
connect_bd_net [get_bd_pins ip_30_intc/irq_16] [get_bd_pins ip_30_intc/concat_0/In16]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_30_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_30_intc/irq] [get_bd_intf_pins ip_30_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_31_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_31_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 10 " [get_bd_cells ip_31_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi_legacy/clk
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi_legacy/reset
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M0] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M1] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M2] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M3] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M4] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S04_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S04_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S04_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M5] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S05_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S05_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S05_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M6
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M6] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S06_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S06_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S06_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M7
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M7] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S07_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S07_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S07_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M8
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M8] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S08_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S08_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S08_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M9
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M9] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S09_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S09_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S09_ARESETN]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_32_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_32_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_32_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_32_axis_broadcaster/aclk] [get_bd_pins ip_32_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_32_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_32_axis_broadcaster/aresetn] [get_bd_pins ip_32_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_32_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_36_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_36_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_36_axis_broadcaster/axis_broadcaster_0]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_37_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_37_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_37_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_39_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_39_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_40_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 20 " [get_bd_cells ip_43_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_45_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_46_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 20 " [get_bd_cells ip_47_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_48_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_49_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aclk] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aresetn] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_50_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_50_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_50_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_50_axis_combiner/aclk] [get_bd_pins ip_50_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_50_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_50_axis_combiner/aresetn] [get_bd_pins ip_50_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_50_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_50_axis_combiner/M_AXIS] [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_51_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_51_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 33 " [get_bd_cells ip_51_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_51_axis_dwidth_converter/aclk] [get_bd_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_51_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_51_axis_dwidth_converter/aresetn] [get_bd_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_51_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_51_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_52_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_52_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_52_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_53_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_55_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_56_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_57_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_57_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_57_axis_dwidth_converter/aclk] [get_bd_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_57_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_57_axis_dwidth_converter/aresetn] [get_bd_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_57_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_57_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_58_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_58_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_58_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_58_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_58_axis_dwidth_converter/aclk] [get_bd_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_58_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_58_axis_dwidth_converter/aresetn] [get_bd_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_58_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_58_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_58_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_58_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_59_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_59_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_59_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_59_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_59_axis_combiner/aclk] [get_bd_pins ip_59_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_59_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_59_axis_combiner/aresetn] [get_bd_pins ip_59_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_59_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_59_axis_combiner/M_AXIS] [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_60_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_60_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_60_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_60_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_60_axis_dwidth_converter/aclk] [get_bd_pins ip_60_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_60_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_60_axis_dwidth_converter/aresetn] [get_bd_pins ip_60_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_60_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_60_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_60_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_60_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_60_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_60_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_61_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_61_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_61_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_61_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_61_axis_combiner/aclk] [get_bd_pins ip_61_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_61_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_61_axis_combiner/aresetn] [get_bd_pins ip_61_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_61_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_61_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_61_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_61_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_61_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_61_axis_combiner/M_AXIS] [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_62_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_62_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_62_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_62_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_62_axis_dwidth_converter/aclk] [get_bd_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_62_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_62_axis_dwidth_converter/aresetn] [get_bd_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_62_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_62_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_62_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_62_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_63_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_63_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 2 " [get_bd_cells ip_63_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_63_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_63_axis_dwidth_converter/aclk] [get_bd_pins ip_63_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_63_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_63_axis_dwidth_converter/aresetn] [get_bd_pins ip_63_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_63_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_63_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_63_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_63_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_63_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_63_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_64_reduce
create_bd_pin -dir I -from 45 -to 0 ip_64_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_64_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_64_reduce/concat]
connect_bd_net [get_bd_pins ip_64_reduce/out0] [get_bd_pins ip_64_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_0]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_64_reduce/slice_0/dout] [get_bd_pins ip_64_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_0/Res] [get_bd_pins ip_64_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_1]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_64_reduce/slice_1/dout] [get_bd_pins ip_64_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_1/Res] [get_bd_pins ip_64_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_2]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_64_reduce/slice_2/dout] [get_bd_pins ip_64_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_2/Res] [get_bd_pins ip_64_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_3]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_64_reduce/slice_3/dout] [get_bd_pins ip_64_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_3/Res] [get_bd_pins ip_64_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_4]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_64_reduce/slice_4/dout] [get_bd_pins ip_64_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_4/Res] [get_bd_pins ip_64_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_5]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_64_reduce/slice_5/dout] [get_bd_pins ip_64_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_5/Res] [get_bd_pins ip_64_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_6]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_64_reduce/slice_6/dout] [get_bd_pins ip_64_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_6/Res] [get_bd_pins ip_64_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 14 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_7]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_64_reduce/slice_7/dout] [get_bd_pins ip_64_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_7/Res] [get_bd_pins ip_64_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_8]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_64_reduce/slice_8/dout] [get_bd_pins ip_64_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_8/Res] [get_bd_pins ip_64_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_9]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_64_reduce/slice_9/dout] [get_bd_pins ip_64_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_9/Res] [get_bd_pins ip_64_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 21 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_10]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_64_reduce/slice_10/dout] [get_bd_pins ip_64_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_10/Res] [get_bd_pins ip_64_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 22 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_11]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_64_reduce/slice_11/dout] [get_bd_pins ip_64_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_11/Res] [get_bd_pins ip_64_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 25 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_12]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_64_reduce/slice_12/dout] [get_bd_pins ip_64_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_12/Res] [get_bd_pins ip_64_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 27 CONFIG.DIN_TO 26 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_13]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_64_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_64_reduce/slice_13/dout] [get_bd_pins ip_64_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_13/Res] [get_bd_pins ip_64_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 28 CONFIG.DIN_TO 28 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_14]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_64_reduce/slice_14/dout] [get_bd_pins ip_64_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_14/Res] [get_bd_pins ip_64_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 29 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_15]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_64_reduce/slice_15/dout] [get_bd_pins ip_64_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_15/Res] [get_bd_pins ip_64_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 30 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_16]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_64_reduce/slice_16/dout] [get_bd_pins ip_64_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_16/Res] [get_bd_pins ip_64_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 31 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_17]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_64_reduce/slice_17/dout] [get_bd_pins ip_64_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_17/Res] [get_bd_pins ip_64_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 32 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_18]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_64_reduce/slice_18/dout] [get_bd_pins ip_64_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_18/Res] [get_bd_pins ip_64_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 33 CONFIG.DIN_TO 33 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_19]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_64_reduce/slice_19/dout] [get_bd_pins ip_64_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_19/Res] [get_bd_pins ip_64_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 34 CONFIG.DIN_TO 34 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_20]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_64_reduce/slice_20/dout] [get_bd_pins ip_64_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_20/Res] [get_bd_pins ip_64_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 35 CONFIG.DIN_TO 35 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_21]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_64_reduce/slice_21/dout] [get_bd_pins ip_64_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_21/Res] [get_bd_pins ip_64_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 36 CONFIG.DIN_TO 36 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_22]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_64_reduce/slice_22/dout] [get_bd_pins ip_64_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_22/Res] [get_bd_pins ip_64_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 37 CONFIG.DIN_TO 37 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_23]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_64_reduce/slice_23/dout] [get_bd_pins ip_64_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_23/Res] [get_bd_pins ip_64_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 38 CONFIG.DIN_TO 38 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_24]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_64_reduce/slice_24/dout] [get_bd_pins ip_64_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_24/Res] [get_bd_pins ip_64_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 39 CONFIG.DIN_TO 39 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_25]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_64_reduce/slice_25/dout] [get_bd_pins ip_64_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_25/Res] [get_bd_pins ip_64_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 40 CONFIG.DIN_TO 40 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_26]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_64_reduce/slice_26/dout] [get_bd_pins ip_64_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_26/Res] [get_bd_pins ip_64_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 41 CONFIG.DIN_TO 41 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_27]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_64_reduce/slice_27/dout] [get_bd_pins ip_64_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_27/Res] [get_bd_pins ip_64_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 42 CONFIG.DIN_TO 42 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_28]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_64_reduce/slice_28/dout] [get_bd_pins ip_64_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_28/Res] [get_bd_pins ip_64_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 43 CONFIG.DIN_TO 43 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_29]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_64_reduce/slice_29/dout] [get_bd_pins ip_64_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_29/Res] [get_bd_pins ip_64_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 44 CONFIG.DIN_TO 44 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_30]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_64_reduce/slice_30/dout] [get_bd_pins ip_64_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_30/Res] [get_bd_pins ip_64_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 45 CONFIG.DIN_TO 45 CONFIG.DIN_WIDTH 46 " [get_bd_cells ip_64_reduce/slice_31]
connect_bd_net [get_bd_pins ip_64_reduce/in0] [get_bd_pins ip_64_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_64_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_64_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_64_reduce/slice_31/dout] [get_bd_pins ip_64_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_64_reduce/reduce_31/Res] [get_bd_pins ip_64_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_65_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_65_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_65_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_66_slice_and_concat
create_bd_pin -dir O -from 45 -to 0 ip_66_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_66_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_66_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_66_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_66_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_66_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_1] [get_bd_pins ip_66_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 14 -to 0 ip_66_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_2] [get_bd_pins ip_66_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 79 -to 0 ip_66_slice_and_concat/in_3
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_66_slice_and_concat] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 28 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 80 " [get_bd_cells ip_66_slice_and_concat/slice_3]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_3] [get_bd_pins ip_66_slice_and_concat/slice_3/din]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/slice_3/dout] [get_bd_pins ip_66_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_67_slice_and_concat
create_bd_pin -dir O -from 35 -to 0 ip_67_slice_and_concat/out0
create_bd_pin -dir I -from 79 -to 0 ip_67_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_67_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 64 CONFIG.DIN_TO 29 CONFIG.DIN_WIDTH 80 " [get_bd_cells ip_67_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_67_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_67_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_68_slice_and_concat
create_bd_pin -dir O -from 14 -to 0 ip_68_slice_and_concat/out0
create_bd_pin -dir I -from 79 -to 0 ip_68_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_68_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 79 CONFIG.DIN_TO 65 CONFIG.DIN_WIDTH 80 " [get_bd_cells ip_68_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_68_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_68_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_69_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_69_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_69_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_69_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_69_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/in_0] [get_bd_pins ip_69_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_69_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_70_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_70_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_70_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_70_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_70_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/in_0] [get_bd_pins ip_70_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_70_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_71_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_71_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_71_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_71_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_71_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/in_0] [get_bd_pins ip_71_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_71_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_72_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_72_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_72_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_72_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_72_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/in_0] [get_bd_pins ip_72_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_72_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_73_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_73_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_73_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_73_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_73_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/in_0] [get_bd_pins ip_73_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_73_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_74_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_74_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_74_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_74_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_74_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/in_0] [get_bd_pins ip_74_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_74_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_75_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_75_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_75_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_75_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_75_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/in_0] [get_bd_pins ip_75_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_75_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_76_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_76_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_76_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_76_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_76_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/in_0] [get_bd_pins ip_76_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_76_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_77_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_77_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_77_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_77_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_77_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/in_0] [get_bd_pins ip_77_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_77_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_78_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_78_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_78_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_78_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_78_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/in_0] [get_bd_pins ip_78_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/out0] [get_bd_pins ip_78_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_79_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_79_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_79_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_79_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_79_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/in_0] [get_bd_pins ip_79_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/out0] [get_bd_pins ip_79_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_80_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_80_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_80_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_80_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_80_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/in_0] [get_bd_pins ip_80_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/out0] [get_bd_pins ip_80_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_81_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_81_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_81_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_81_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_81_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/in_0] [get_bd_pins ip_81_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/out0] [get_bd_pins ip_81_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_82_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_82_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_82_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_82_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_82_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/in_0] [get_bd_pins ip_82_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/out0] [get_bd_pins ip_82_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_83_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_83_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_83_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_83_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_83_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_83_slice_and_concat/in_0] [get_bd_pins ip_83_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_83_slice_and_concat/out0] [get_bd_pins ip_83_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_84_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_84_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_84_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_84_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_84_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_84_slice_and_concat/in_0] [get_bd_pins ip_84_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_84_slice_and_concat/out0] [get_bd_pins ip_84_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_28_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_29_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_5_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_quad_spi_IIC] [get_bd_intf_pins ip_5_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO] [get_bd_intf_pins ip_9_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_9_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_9_gpio_GPIO2] [get_bd_intf_pins ip_9_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:icap_rtl:1.0 ip_13_axi_hwicap_ICAP
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_hwicap_ICAP] [get_bd_intf_pins ip_13_axi_hwicap/ICAP]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:arb_rtl:1.0 ip_13_axi_hwicap_ICAP_ARBITER
connect_bd_intf_net [get_bd_intf_pins ip_13_axi_hwicap_ICAP_ARBITER] [get_bd_intf_pins ip_13_axi_hwicap/ICAP_ARBITER]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_17_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_17_uartlite_UART] [get_bd_intf_pins ip_17_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_18_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_ethernet_lite_MII] [get_bd_intf_pins ip_18_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_18_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_18_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_18_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_20_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_20_axi_iic_IIC] [get_bd_intf_pins ip_20_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_22_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_ethernet_lite_MII] [get_bd_intf_pins ip_22_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_22_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_22_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_22_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_26_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_26_gpio_GPIO] [get_bd_intf_pins ip_26_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_30_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_64_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 4 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_69_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_70_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_71_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_72_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_73_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_74_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_75_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_76_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_77_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_78_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_79_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_80_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_81_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_82_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_83_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_84_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_29_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_30_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_4_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_9_gpio/rst]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_12_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_13_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_16_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_17_uartlite/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_18_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_20_axi_iic/reset]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_22_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_24_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_25_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/peripheral_areset_n] [get_bd_pins ip_26_gpio/rst]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_27_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_0_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_1_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_3_fft/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_4_floating_point/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_5_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_6_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_7_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_7_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_7_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_8_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_9_gpio/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_10_fft/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_11_fft/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_12_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_13_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_13_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_15_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_16_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_17_uartlite/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_18_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_19_accumulator/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_20_axi_iic/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_21_accumulator/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_22_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_23_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_24_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_25_floating_point/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_26_gpio/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_27_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_28_reset/clk_in]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_locked] [get_bd_pins ip_28_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_30_intc/irq_0] [get_bd_pins ip_0_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_1] [get_bd_pins ip_0_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_2] [get_bd_pins ip_2_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_3] [get_bd_pins ip_3_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_30_intc/irq_4] [get_bd_pins ip_5_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_5] [get_bd_pins ip_6_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_30_intc/irq_6] [get_bd_pins ip_7_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_7] [get_bd_pins ip_8_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_8] [get_bd_pins ip_9_gpio/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_9] [get_bd_pins ip_10_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_30_intc/irq_10] [get_bd_pins ip_11_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_30_intc/irq_11] [get_bd_pins ip_13_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_30_intc/irq_12] [get_bd_pins ip_14_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_30_intc/irq_13] [get_bd_pins ip_17_uartlite/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_14] [get_bd_pins ip_18_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_15] [get_bd_pins ip_20_axi_iic/irq]
connect_bd_net [get_bd_pins ip_30_intc/irq_16] [get_bd_pins ip_22_axi_ethernet_lite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_31_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_31_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_31_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/M_AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_31_axi_legacy/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_31_axi_legacy/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_31_axi_legacy/AXI_M6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_31_axi_legacy/AXI_M7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_31_axi_legacy/AXI_M8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_31_axi_legacy/AXI_M9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_31_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_timer/S_AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_gpio/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_31_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_uartlite/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axi_iic/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_gpio/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_30_intc/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_32_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/M_AXIS_DATA] [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_38_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_floating_point/S_AXIS_A] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_fft/S_AXIS_DATA] [get_bd_intf_pins ip_15_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_floating_point/S_AXIS_A] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_45_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_47_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_48_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_DATA] [get_bd_intf_pins ip_23_complex_multiplier/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_24_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_50_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_3_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_51_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_50_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_51_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_52_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_52_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_53_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_53_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_DATA] [get_bd_intf_pins ip_38_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_54_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_55_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_54_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_55_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_56_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_56_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_57_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_57_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_58_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_58_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_59_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_60_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_59_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_60_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_61_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_61_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_62_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_61_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_62_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_63_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_63_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_2]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_13_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/in_0] [get_bd_pins ip_6_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_65_slice_and_concat/out0] [get_bd_pins ip_65_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/out0] [get_bd_pins ip_64_reduce/in0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_0] [get_bd_pins ip_6_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_1] [get_bd_pins ip_6_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_2] [get_bd_pins ip_19_accumulator/Q]
connect_bd_net [get_bd_pins ip_66_slice_and_concat/in_3] [get_bd_pins ip_21_accumulator/Q]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/B]
connect_bd_net [get_bd_pins ip_67_slice_and_concat/in_0] [get_bd_pins ip_21_accumulator/Q]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/out0] [get_bd_pins ip_19_accumulator/B]
connect_bd_net [get_bd_pins ip_68_slice_and_concat/in_0] [get_bd_pins ip_21_accumulator/Q]
connect_bd_net [get_bd_pins ip_69_slice_and_concat/out0] [get_bd_pins ip_25_floating_point/aclken]
connect_bd_net [get_bd_pins ip_70_slice_and_concat/out0] [get_bd_pins ip_6_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_71_slice_and_concat/out0] [get_bd_pins ip_24_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_72_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_73_slice_and_concat/out0] [get_bd_pins ip_19_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_74_slice_and_concat/out0] [get_bd_pins ip_1_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_75_slice_and_concat/out0] [get_bd_pins ip_16_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_76_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_77_slice_and_concat/out0] [get_bd_pins ip_15_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_78_slice_and_concat/out0] [get_bd_pins ip_19_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_79_slice_and_concat/out0] [get_bd_pins ip_6_axi_timer/capturetrig1]
connect_bd_net [get_bd_pins ip_80_slice_and_concat/out0] [get_bd_pins ip_19_accumulator/ADD]
connect_bd_net [get_bd_pins ip_81_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/ADD]
connect_bd_net [get_bd_pins ip_82_slice_and_concat/out0] [get_bd_pins ip_19_accumulator/CE]
connect_bd_net [get_bd_pins ip_83_slice_and_concat/out0] [get_bd_pins ip_21_accumulator/CE]
connect_bd_net [get_bd_pins ip_84_slice_and_concat/out0] [get_bd_pins ip_6_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_31_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_48_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_49_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_50_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_51_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_52_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_53_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_54_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_55_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_56_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_57_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_58_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_59_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_60_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_61_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_62_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_28_reset/interconnect_aresetn] [get_bd_pins ip_63_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_30_intc/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_31_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_32_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_33_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_34_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_35_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_36_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_37_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_38_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_45_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_46_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_47_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_48_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_49_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_50_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_51_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_52_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_53_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_54_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_55_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_56_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_57_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_58_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_59_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_60_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_61_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_62_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_29_clk_wiz/clk_out] [get_bd_pins ip_63_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/S_AXIS_S2MM declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_axi_dma/S_AXIS_S2MM declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/M_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 25 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=25 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_fft/S_AXIS_CONFIG declared=25 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_floating_point/M_AXIS_RESULT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_axi_dma/M_AXIS_MM2S declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 29 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=29 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=29 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_fft/S_AXIS_DATA declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_fft/S_AXIS_DATA declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_fft/M_AXIS_DATA declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_fft/M_AXIS_DATA declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 15 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_fft/S_AXIS_CONFIG declared=15 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_fft/S_AXIS_CONFIG declared=15 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_B declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_B declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_15_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_15_complex_multiplier/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_complex_multiplier/S_AXIS_B declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_complex_multiplier/S_AXIS_B declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_complex_multiplier/M_AXIS_DOUT declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_complex_multiplier/M_AXIS_DOUT declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_complex_multiplier/S_AXIS_A declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_complex_multiplier/S_AXIS_A declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 144 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_complex_multiplier/M_AXIS_DOUT declared=144 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_complex_multiplier/M_AXIS_DOUT declared=144 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_complex_multiplier/S_AXIS_A declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_complex_multiplier/S_AXIS_A declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_complex_multiplier/S_AXIS_B declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_complex_multiplier/S_AXIS_B declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_complex_multiplier/M_AXIS_DOUT declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_complex_multiplier/M_AXIS_DOUT declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_3 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_3 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_3 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_3 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_3 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_3 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 29 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=29 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=29 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=160 actual=ERR $__err" }
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
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 160 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=160 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/S_AXIS declared=160 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_1 declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/S_AXIS_1 declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_50_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 264 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/M_AXIS declared=264 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_50_axis_combiner/M_AXIS declared=264 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 264 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/S_AXIS declared=264 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/S_AXIS declared=264 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_51_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_51_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_52_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_52_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_53_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_53_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_54_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_54_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_55_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_55_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_56_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_56_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_57_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_57_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_57_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_58_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_58_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_58_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_58_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_58_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/S_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_59_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_59_axis_combiner/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_60_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_60_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_60_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_60_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_60_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_60_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/S_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/S_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/S_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/S_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_61_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_61_axis_combiner/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_62_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_62_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_62_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_62_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_62_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_63_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_63_axis_dwidth_converter/S_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_63_axis_dwidth_converter/S_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_63_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 25 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_63_axis_dwidth_converter/M_AXIS declared=25 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_63_axis_dwidth_converter/M_AXIS declared=25 actual=ERR $__err" }


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
