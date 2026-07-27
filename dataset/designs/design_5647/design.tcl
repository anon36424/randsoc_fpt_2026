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
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 128 " [get_bd_cells ip_0_axi_hwicap/axi_hwicap_0]
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


########## accumulator ##########
create_bd_cell -type hier ip_1_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_1_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Subtract CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 25 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 30 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_1_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/clk
connect_bd_net [get_bd_pins ip_1_accumulator/clk] [get_bd_pins ip_1_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 24 -to 0 ip_1_accumulator/B
connect_bd_net [get_bd_pins ip_1_accumulator/B] [get_bd_pins ip_1_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 29 -to 0 ip_1_accumulator/Q
connect_bd_net [get_bd_pins ip_1_accumulator/Q] [get_bd_pins ip_1_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/CE
connect_bd_net [get_bd_pins ip_1_accumulator/CE] [get_bd_pins ip_1_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/C_IN
connect_bd_net [get_bd_pins ip_1_accumulator/C_IN] [get_bd_pins ip_1_accumulator/accumulator_0/C_IN]


########## accumulator ##########
create_bd_cell -type hier ip_2_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_2_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_Low CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Signed CONFIG.Input_Width 21 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 23 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_2_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/clk
connect_bd_net [get_bd_pins ip_2_accumulator/clk] [get_bd_pins ip_2_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 20 -to 0 ip_2_accumulator/B
connect_bd_net [get_bd_pins ip_2_accumulator/B] [get_bd_pins ip_2_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 22 -to 0 ip_2_accumulator/Q
connect_bd_net [get_bd_pins ip_2_accumulator/Q] [get_bd_pins ip_2_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/ADD
connect_bd_net [get_bd_pins ip_2_accumulator/ADD] [get_bd_pins ip_2_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/CE
connect_bd_net [get_bd_pins ip_2_accumulator/CE] [get_bd_pins ip_2_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_2_accumulator/Bypass
connect_bd_net [get_bd_pins ip_2_accumulator/Bypass] [get_bd_pins ip_2_accumulator/accumulator_0/Bypass]


########## emc ##########
create_bd_cell -type hier ip_3_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_3_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 13 CONFIG.C_TAVDV_PS_MEM_0 16021 CONFIG.C_TCEDV_PS_MEM_0 15558 CONFIG.C_THZCE_PS_MEM_0 6797 CONFIG.C_THZOE_PS_MEM_0 6945 CONFIG.C_TLZWE_PS_MEM_0 8213 CONFIG.C_TWC_PS_MEM_0 16179 CONFIG.C_TWPH_PS_MEM_0 11216 CONFIG.C_TWP_PS_MEM_0 11337 CONFIG.C_WR_REC_TIME_MEM_0 28979 " [get_bd_cells ip_3_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc/EMC_INTF] [get_bd_intf_pins ip_3_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/clk
connect_bd_net [get_bd_pins ip_3_emc/clk] [get_bd_pins ip_3_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/rdclk
connect_bd_net [get_bd_pins ip_3_emc/rdclk] [get_bd_pins ip_3_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_emc/rst
connect_bd_net [get_bd_pins ip_3_emc/rst] [get_bd_pins ip_3_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_3_emc/emc_0/S_AXI_MEM]


########## cordic ##########
create_bd_cell -type hier ip_4_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_4_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling LUT_based CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Sin_and_Cos CONFIG.Input_Width 29 CONFIG.Iterations 25 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 12 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 33 CONFIG.Round_Mode Truncate " [get_bd_cells ip_4_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_cordic/aclk
connect_bd_net [get_bd_pins ip_4_cordic/aclk] [get_bd_pins ip_4_cordic/cordic_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_cordic/aclken
connect_bd_net [get_bd_pins ip_4_cordic/aclken] [get_bd_pins ip_4_cordic/cordic_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_4_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_4_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_4_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_4_cordic/cordic_0/M_AXIS_DOUT]


########## axi_iic ##########
create_bd_cell -type hier ip_5_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_5_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x44 CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 211 CONFIG.C_SDA_INERTIAL_DELAY 254 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 610.2767988177583 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_6_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_6_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 1 CONFIG.C_FIFO_DEPTH 256 CONFIG.C_NUM_TRANSFER_BITS 8 CONFIG.C_SCK_RATIO 4 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 24 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_6_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_6_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/IIC] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/clk] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/reset] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/clk4] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/reset4] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_6_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_6_axi_quad_spi/irq] [get_bd_pins ip_6_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## dft ##########
create_bd_cell -type hier ip_7_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_7_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 17 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_7_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/CLK
connect_bd_net [get_bd_pins ip_7_dft/CLK] [get_bd_pins ip_7_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/SCLR
connect_bd_net [get_bd_pins ip_7_dft/SCLR] [get_bd_pins ip_7_dft/dft_0/SCLR]
create_bd_pin -dir I -from 16 -to 0 ip_7_dft/XN_RE
connect_bd_net [get_bd_pins ip_7_dft/XN_RE] [get_bd_pins ip_7_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 16 -to 0 ip_7_dft/XN_IM
connect_bd_net [get_bd_pins ip_7_dft/XN_IM] [get_bd_pins ip_7_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/FD_IN
connect_bd_net [get_bd_pins ip_7_dft/FD_IN] [get_bd_pins ip_7_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_7_dft/FWD_INV
connect_bd_net [get_bd_pins ip_7_dft/FWD_INV] [get_bd_pins ip_7_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_7_dft/SIZE
connect_bd_net [get_bd_pins ip_7_dft/SIZE] [get_bd_pins ip_7_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/RFFD
connect_bd_net [get_bd_pins ip_7_dft/RFFD] [get_bd_pins ip_7_dft/dft_0/RFFD]
create_bd_pin -dir O -from 16 -to 0 ip_7_dft/XK_RE
connect_bd_net [get_bd_pins ip_7_dft/XK_RE] [get_bd_pins ip_7_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 16 -to 0 ip_7_dft/XK_IM
connect_bd_net [get_bd_pins ip_7_dft/XK_IM] [get_bd_pins ip_7_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_7_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_7_dft/BLK_EXP] [get_bd_pins ip_7_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/FD_OUT
connect_bd_net [get_bd_pins ip_7_dft/FD_OUT] [get_bd_pins ip_7_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_7_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_7_dft/DATA_VALID] [get_bd_pins ip_7_dft/dft_0/DATA_VALID]


########## axi_timer ##########
create_bd_cell -type hier ip_8_axi_timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
move_bd_cells [get_bd_cells ip_8_axi_timer] [get_bd_cells axi_timer_0]
set_property -dict "CONFIG.GEN0_ASSERT Active_High CONFIG.TRIG0_ASSERT Active_Low CONFIG.mode_64bit 1 " [get_bd_cells ip_8_axi_timer/axi_timer_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_timer/S_AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_timer/S_AXI] [get_bd_intf_pins ip_8_axi_timer/axi_timer_0/S_AXI]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_timer/capturetrig0
connect_bd_net [get_bd_pins ip_8_axi_timer/capturetrig0] [get_bd_pins ip_8_axi_timer/axi_timer_0/capturetrig0]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_timer/freeze
connect_bd_net [get_bd_pins ip_8_axi_timer/freeze] [get_bd_pins ip_8_axi_timer/axi_timer_0/freeze]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_timer/s_axi_aclk
connect_bd_net [get_bd_pins ip_8_axi_timer/s_axi_aclk] [get_bd_pins ip_8_axi_timer/axi_timer_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_timer/s_axi_aresetn
connect_bd_net [get_bd_pins ip_8_axi_timer/s_axi_aresetn] [get_bd_pins ip_8_axi_timer/axi_timer_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_timer/generateout0
connect_bd_net [get_bd_pins ip_8_axi_timer/generateout0] [get_bd_pins ip_8_axi_timer/axi_timer_0/generateout0]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_timer/generateout1
connect_bd_net [get_bd_pins ip_8_axi_timer/generateout1] [get_bd_pins ip_8_axi_timer/axi_timer_0/generateout1]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_timer/pwm0
connect_bd_net [get_bd_pins ip_8_axi_timer/pwm0] [get_bd_pins ip_8_axi_timer/axi_timer_0/pwm0]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_timer/interrupt
connect_bd_net [get_bd_pins ip_8_axi_timer/interrupt] [get_bd_pins ip_8_axi_timer/axi_timer_0/interrupt]


########## axi_iic ##########
create_bd_cell -type hier ip_9_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_9_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x77 CONFIG.C_GPO_WIDTH 5 CONFIG.C_SCL_INERTIAL_DELAY 43 CONFIG.C_SDA_INERTIAL_DELAY 143 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 305.4326019741131 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_9_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_9_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic/IIC] [get_bd_intf_pins ip_9_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_iic/clk
connect_bd_net [get_bd_pins ip_9_axi_iic/clk] [get_bd_pins ip_9_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axi_iic/reset
connect_bd_net [get_bd_pins ip_9_axi_iic/reset] [get_bd_pins ip_9_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic/AXI] [get_bd_intf_pins ip_9_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_9_axi_iic/irq
connect_bd_net [get_bd_pins ip_9_axi_iic/irq] [get_bd_pins ip_9_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_ethernet_lite ##########
create_bd_cell -type hier ip_10_axi_ethernet_lite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
move_bd_cells [get_bd_cells ip_10_axi_ethernet_lite] [get_bd_cells axi_ethernetlite_0]
set_property -dict "CONFIG.C_DUPLEX 1 CONFIG.C_INCLUDE_GLOBAL_BUFFERS 1 CONFIG.C_INCLUDE_INTERNAL_LOOPBACK 0 CONFIG.C_INCLUDE_MDIO 1 CONFIG.C_RX_PING_PONG 1 CONFIG.C_S_AXI_PROTOCOL AXI4 CONFIG.C_TX_PING_PONG 0 " [get_bd_cells ip_10_axi_ethernet_lite/axi_ethernetlite_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_10_axi_ethernet_lite/MII
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite/MII] [get_bd_intf_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/MII]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_10_axi_ethernet_lite/MDIO
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite/MDIO] [get_bd_intf_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/MDIO]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_ethernet_lite/clk
connect_bd_net [get_bd_pins ip_10_axi_ethernet_lite/clk] [get_bd_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_ethernet_lite/reset
connect_bd_net [get_bd_pins ip_10_axi_ethernet_lite/reset] [get_bd_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_ethernet_lite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_ethernet_lite/irq
connect_bd_net [get_bd_pins ip_10_axi_ethernet_lite/irq] [get_bd_pins ip_10_axi_ethernet_lite/axi_ethernetlite_0/ip2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_11_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_11_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 45 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 32 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 32 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_11_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_11_axi_dma/axi_resetn] [get_bd_pins ip_11_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_11_axi_dma/mm2s_introut] [get_bd_pins ip_11_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_11_axi_dma/s2mm_introut] [get_bd_pins ip_11_axi_dma/axi_dma_0/s2mm_introut]


########## reset ##########
create_bd_cell -type hier ip_12_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_12_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_reset/clk_in
connect_bd_net [get_bd_pins ip_12_reset/clk_in] [get_bd_pins ip_12_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_12_reset/reset_in
connect_bd_net [get_bd_pins ip_12_reset/reset_in] [get_bd_pins ip_12_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_12_reset/dcm_locked
connect_bd_net [get_bd_pins ip_12_reset/dcm_locked] [get_bd_pins ip_12_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/mb_reset
connect_bd_net [get_bd_pins ip_12_reset/mb_reset] [get_bd_pins ip_12_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_12_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset] [get_bd_pins ip_12_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_12_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_12_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_13_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_13_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_in] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_13_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_13_clk_wiz/reset
connect_bd_net [get_bd_pins ip_13_clk_wiz/reset] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_13_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_locked] [get_bd_pins ip_13_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_14_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_14_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_14_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 8 " [get_bd_cells ip_14_intc/concat_0]
connect_bd_net [get_bd_pins ip_14_intc/concat_0/dout] [get_bd_pins ip_14_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/clk
connect_bd_net [get_bd_pins ip_14_intc/clk] [get_bd_pins ip_14_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/reset
connect_bd_net [get_bd_pins ip_14_intc/reset] [get_bd_pins ip_14_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_intc/AXI] [get_bd_intf_pins ip_14_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_0
connect_bd_net [get_bd_pins ip_14_intc/irq_0] [get_bd_pins ip_14_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_1
connect_bd_net [get_bd_pins ip_14_intc/irq_1] [get_bd_pins ip_14_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_2
connect_bd_net [get_bd_pins ip_14_intc/irq_2] [get_bd_pins ip_14_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_3
connect_bd_net [get_bd_pins ip_14_intc/irq_3] [get_bd_pins ip_14_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_4
connect_bd_net [get_bd_pins ip_14_intc/irq_4] [get_bd_pins ip_14_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_5
connect_bd_net [get_bd_pins ip_14_intc/irq_5] [get_bd_pins ip_14_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_6
connect_bd_net [get_bd_pins ip_14_intc/irq_6] [get_bd_pins ip_14_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_14_intc/irq_7
connect_bd_net [get_bd_pins ip_14_intc/irq_7] [get_bd_pins ip_14_intc/concat_0/In7]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_14_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_14_intc/irq] [get_bd_intf_pins ip_14_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_15_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_15_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 10 CONFIG.NUM_SI 2 " [get_bd_cells ip_15_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_legacy/clk
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_legacy/reset
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M0] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_M1] [get_bd_intf_pins ip_15_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S0] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S1] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S2] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S3] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S4] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S5] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S6] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S7] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S8] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_legacy/AXI_S9] [get_bd_intf_pins ip_15_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_15_axi_legacy/clk] [get_bd_pins ip_15_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_15_axi_legacy/reset] [get_bd_pins ip_15_axi_legacy/axi_0/M09_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_16_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_16_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_16_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aclk] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_16_axis_dwidth_converter/aresetn] [get_bd_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_17_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_17_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_17_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_17_axis_dwidth_converter/aclk] [get_bd_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_17_axis_dwidth_converter/aresetn] [get_bd_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_17_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 29 -to 0 ip_18_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_18_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 30 " [get_bd_cells ip_18_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_18_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 29 -to 0 ip_19_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_19_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 26 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 30 " [get_bd_cells ip_19_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_19_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 20 -to 0 ip_20_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_20_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 29 -to 0 ip_20_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 27 CONFIG.DIN_WIDTH 30 " [get_bd_cells ip_20_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_20_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/slice_0/dout] [get_bd_pins ip_20_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 22 -to 0 ip_20_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_20_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 23 " [get_bd_cells ip_20_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_20_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/slice_1/dout] [get_bd_pins ip_20_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_21_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_21_slice_and_concat/out0
create_bd_pin -dir I -from 22 -to 0 ip_21_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_21_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 18 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 23 " [get_bd_cells ip_21_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_21_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_21_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_22_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_22_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_22_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_22_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 22 -to 0 ip_22_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 22 CONFIG.DIN_TO 19 CONFIG.DIN_WIDTH 23 " [get_bd_cells ip_22_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_22_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/slice_0/dout] [get_bd_pins ip_22_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_22_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_22_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 16 -to 0 ip_22_slice_and_concat/in_2
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_22_slice_and_concat] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_22_slice_and_concat/slice_2]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_22_slice_and_concat/slice_2/din]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/slice_2/dout] [get_bd_pins ip_22_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_23_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_23_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/slice_0/dout] [get_bd_pins ip_23_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 16 -to 0 ip_23_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_23_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_1] [get_bd_pins ip_23_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/slice_1/dout] [get_bd_pins ip_23_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 24 -to 0 ip_24_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_24_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 16 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/slice_0/dout] [get_bd_pins ip_24_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_24_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_1] [get_bd_pins ip_24_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_2] [get_bd_pins ip_24_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_3] [get_bd_pins ip_24_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_4] [get_bd_pins ip_24_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_5] [get_bd_pins ip_24_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_6] [get_bd_pins ip_24_slice_and_concat/concat/In6]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_28_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_28_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_29_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_29_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_31_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_31_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_33_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 5 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 5 -to 0 ip_34_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_34_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 6 " [get_bd_cells ip_34_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/in_0] [get_bd_pins ip_34_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_13_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc_EMC_INTF] [get_bd_intf_pins ip_3_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_6_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_quad_spi_IIC] [get_bd_intf_pins ip_6_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_9_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic_IIC] [get_bd_intf_pins ip_9_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 ip_10_axi_ethernet_lite_MII
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite_MII] [get_bd_intf_pins ip_10_axi_ethernet_lite/MII]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 ip_10_axi_ethernet_lite_MDIO
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_ethernet_lite_MDIO] [get_bd_intf_pins ip_10_axi_ethernet_lite/MDIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_14_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_16_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_4_cordic/M_AXIS_DOUT]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 9 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_18_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 5 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_25_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_28_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_29_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_30_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_31_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_32_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_33_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_13_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_3_emc/rst]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_6_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset] [get_bd_pins ip_7_dft/SCLR]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_8_axi_timer/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_iic/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_10_axi_ethernet_lite/reset]
connect_bd_net [get_bd_pins ip_12_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_0_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_0_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_1_accumulator/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_2_accumulator/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_emc/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_3_emc/rdclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_4_cordic/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_6_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_6_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_6_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_7_dft/CLK]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_8_axi_timer/s_axi_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_9_axi_iic/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_10_axi_ethernet_lite/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_12_reset/clk_in]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_locked] [get_bd_pins ip_12_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_14_intc/irq_0] [get_bd_pins ip_0_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_14_intc/irq_1] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_2] [get_bd_pins ip_6_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_3] [get_bd_pins ip_8_axi_timer/interrupt]
connect_bd_net [get_bd_pins ip_14_intc/irq_4] [get_bd_pins ip_9_axi_iic/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_5] [get_bd_pins ip_10_axi_ethernet_lite/irq]
connect_bd_net [get_bd_pins ip_14_intc/irq_6] [get_bd_pins ip_11_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_14_intc/irq_7] [get_bd_pins ip_11_axi_dma/s2mm_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_15_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_15_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_15_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_timer/S_AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_iic/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_ethernet_lite/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_intc/AXI] [get_bd_intf_pins ip_15_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_16_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_17_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_7_dft/XN_IM]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/B]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/in_1] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/out0] [get_bd_pins ip_0_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_21_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/out0] [get_bd_pins ip_7_dft/SIZE]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_0] [get_bd_pins ip_2_accumulator/Q]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_1] [get_bd_pins ip_7_dft/RFFD]
connect_bd_net [get_bd_pins ip_22_slice_and_concat/in_2] [get_bd_pins ip_7_dft/XK_RE]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_7_dft/XN_RE]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_RE]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_1] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/B]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_7_dft/XK_IM]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_1] [get_bd_pins ip_7_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_2] [get_bd_pins ip_7_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_3] [get_bd_pins ip_7_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_4] [get_bd_pins ip_8_axi_timer/generateout0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_5] [get_bd_pins ip_8_axi_timer/generateout1]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_6] [get_bd_pins ip_8_axi_timer/pwm0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_7_dft/FD_IN]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_8_axi_timer/capturetrig0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/ADD]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_8_axi_timer/freeze]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/CE]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_2_accumulator/CE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_7_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_4_cordic/aclken]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_15_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_16_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_12_reset/interconnect_aresetn] [get_bd_pins ip_17_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_14_intc/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_15_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_16_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_13_clk_wiz/clk_out] [get_bd_pins ip_17_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_cordic/S_AXIS_PHASE declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_cordic/S_AXIS_PHASE declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/M_AXIS_MM2S declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/M_AXIS_MM2S declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_17_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_17_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }


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
