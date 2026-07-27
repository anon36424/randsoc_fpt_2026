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
set_property -dict "CONFIG.C_ALL_INPUTS 1 CONFIG.C_ALL_INPUTS_2 1 CONFIG.C_GPIO2_WIDTH 25 CONFIG.C_GPIO_WIDTH 27 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_0_gpio/gpio_0]
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
create_bd_pin -dir O -from 0 -to 0 ip_0_gpio/irq
connect_bd_net [get_bd_pins ip_0_gpio/irq] [get_bd_pins ip_0_gpio/gpio_0/ip2intc_irpt]


########## accumulator ##########
create_bd_cell -type hier ip_1_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_1_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.AINIT_Value 0 CONFIG.Accum_Mode Add CONFIG.Bypass 0 CONFIG.CE 1 CONFIG.C_In 1 CONFIG.Implementation Fabric CONFIG.Input_Type Signed CONFIG.Input_Width 247 CONFIG.Latency 12 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 258 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_1_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/clk
connect_bd_net [get_bd_pins ip_1_accumulator/clk] [get_bd_pins ip_1_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 246 -to 0 ip_1_accumulator/B
connect_bd_net [get_bd_pins ip_1_accumulator/B] [get_bd_pins ip_1_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 257 -to 0 ip_1_accumulator/Q
connect_bd_net [get_bd_pins ip_1_accumulator/Q] [get_bd_pins ip_1_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/CE
connect_bd_net [get_bd_pins ip_1_accumulator/CE] [get_bd_pins ip_1_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_1_accumulator/C_IN
connect_bd_net [get_bd_pins ip_1_accumulator/C_IN] [get_bd_pins ip_1_accumulator/accumulator_0/C_IN]


########## axi_iic ##########
create_bd_cell -type hier ip_2_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_2_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x5a CONFIG.C_GPO_WIDTH 3 CONFIG.C_SCL_INERTIAL_DELAY 250 CONFIG.C_SDA_INERTIAL_DELAY 214 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 559.3666934927406 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_2_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_2_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_iic/IIC] [get_bd_intf_pins ip_2_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_iic/clk
connect_bd_net [get_bd_pins ip_2_axi_iic/clk] [get_bd_pins ip_2_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_axi_iic/reset
connect_bd_net [get_bd_pins ip_2_axi_iic/reset] [get_bd_pins ip_2_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_iic/AXI] [get_bd_intf_pins ip_2_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_2_axi_iic/irq
connect_bd_net [get_bd_pins ip_2_axi_iic/irq] [get_bd_pins ip_2_axi_iic/axi_iic_0/iic2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_3_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_3_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 3 CONFIG.C_TAVDV_PS_MEM_0 14423 CONFIG.C_TCEDV_PS_MEM_0 16317 CONFIG.C_THZCE_PS_MEM_0 6922 CONFIG.C_THZOE_PS_MEM_0 7249 CONFIG.C_TLZWE_PS_MEM_0 2133 CONFIG.C_TWC_PS_MEM_0 14116 CONFIG.C_TWPH_PS_MEM_0 12487 CONFIG.C_TWP_PS_MEM_0 11158 CONFIG.C_WR_REC_TIME_MEM_0 24482 " [get_bd_cells ip_3_emc/emc_0]
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


########## accumulator ##########
create_bd_cell -type hier ip_4_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_4_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 1 CONFIG.Bypass_Sense Active_High CONFIG.CE 1 CONFIG.C_In 0 CONFIG.Implementation Fabric CONFIG.Input_Type Unsigned CONFIG.Input_Width 248 CONFIG.Latency 23 CONFIG.Latency_Configuration Manual CONFIG.Output_Width 255 CONFIG.SCLR 1 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_4_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/clk
connect_bd_net [get_bd_pins ip_4_accumulator/clk] [get_bd_pins ip_4_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 247 -to 0 ip_4_accumulator/B
connect_bd_net [get_bd_pins ip_4_accumulator/B] [get_bd_pins ip_4_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 254 -to 0 ip_4_accumulator/Q
connect_bd_net [get_bd_pins ip_4_accumulator/Q] [get_bd_pins ip_4_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/ADD
connect_bd_net [get_bd_pins ip_4_accumulator/ADD] [get_bd_pins ip_4_accumulator/accumulator_0/ADD]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/CE
connect_bd_net [get_bd_pins ip_4_accumulator/CE] [get_bd_pins ip_4_accumulator/accumulator_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/SCLR
connect_bd_net [get_bd_pins ip_4_accumulator/SCLR] [get_bd_pins ip_4_accumulator/accumulator_0/SCLR]
create_bd_pin -dir I -from 0 -to 0 ip_4_accumulator/Bypass
connect_bd_net [get_bd_pins ip_4_accumulator/Bypass] [get_bd_pins ip_4_accumulator/accumulator_0/Bypass]


########## axi_iic ##########
create_bd_cell -type hier ip_5_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_5_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x47 CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 220 CONFIG.C_SDA_INERTIAL_DELAY 63 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 936.7557121397986 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
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


########## accumulator ##########
create_bd_cell -type hier ip_6_accumulator
create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 accumulator_0
move_bd_cells [get_bd_cells ip_6_accumulator] [get_bd_cells accumulator_0]
set_property -dict "CONFIG.Accum_Mode Add_Subtract CONFIG.Bypass 0 CONFIG.CE 0 CONFIG.C_In 0 CONFIG.Implementation DSP48 CONFIG.Input_Type Unsigned CONFIG.Input_Width 11 CONFIG.Latency_Configuration Automatic CONFIG.Output_Width 41 CONFIG.SCLR 0 CONFIG.SINIT 0 CONFIG.SSET 0 " [get_bd_cells ip_6_accumulator/accumulator_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_accumulator/clk
connect_bd_net [get_bd_pins ip_6_accumulator/clk] [get_bd_pins ip_6_accumulator/accumulator_0/CLK]
create_bd_pin -dir I -from 10 -to 0 ip_6_accumulator/B
connect_bd_net [get_bd_pins ip_6_accumulator/B] [get_bd_pins ip_6_accumulator/accumulator_0/B]
create_bd_pin -dir O -from 40 -to 0 ip_6_accumulator/Q
connect_bd_net [get_bd_pins ip_6_accumulator/Q] [get_bd_pins ip_6_accumulator/accumulator_0/Q]
create_bd_pin -dir I -from 0 -to 0 ip_6_accumulator/ADD
connect_bd_net [get_bd_pins ip_6_accumulator/ADD] [get_bd_pins ip_6_accumulator/accumulator_0/ADD]


########## axi_cdma ##########
create_bd_cell -type hier ip_7_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_7_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 64 CONFIG.C_INCLUDE_DRE 0 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_7_axi_cdma/axi_cdma_0]
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


########## dft ##########
create_bd_cell -type hier ip_8_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_8_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 18 CONFIG.Speed_Optimization Area CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_8_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_dft/CLK
connect_bd_net [get_bd_pins ip_8_dft/CLK] [get_bd_pins ip_8_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_8_dft/CE
connect_bd_net [get_bd_pins ip_8_dft/CE] [get_bd_pins ip_8_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_8_dft/SCLR
connect_bd_net [get_bd_pins ip_8_dft/SCLR] [get_bd_pins ip_8_dft/dft_0/SCLR]
create_bd_pin -dir I -from 17 -to 0 ip_8_dft/XN_RE
connect_bd_net [get_bd_pins ip_8_dft/XN_RE] [get_bd_pins ip_8_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 17 -to 0 ip_8_dft/XN_IM
connect_bd_net [get_bd_pins ip_8_dft/XN_IM] [get_bd_pins ip_8_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_8_dft/FD_IN
connect_bd_net [get_bd_pins ip_8_dft/FD_IN] [get_bd_pins ip_8_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_8_dft/FWD_INV
connect_bd_net [get_bd_pins ip_8_dft/FWD_INV] [get_bd_pins ip_8_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_8_dft/SIZE
connect_bd_net [get_bd_pins ip_8_dft/SIZE] [get_bd_pins ip_8_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_8_dft/RFFD
connect_bd_net [get_bd_pins ip_8_dft/RFFD] [get_bd_pins ip_8_dft/dft_0/RFFD]
create_bd_pin -dir O -from 17 -to 0 ip_8_dft/XK_RE
connect_bd_net [get_bd_pins ip_8_dft/XK_RE] [get_bd_pins ip_8_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 17 -to 0 ip_8_dft/XK_IM
connect_bd_net [get_bd_pins ip_8_dft/XK_IM] [get_bd_pins ip_8_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_8_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_8_dft/BLK_EXP] [get_bd_pins ip_8_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_8_dft/FD_OUT
connect_bd_net [get_bd_pins ip_8_dft/FD_OUT] [get_bd_pins ip_8_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_8_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_8_dft/DATA_VALID] [get_bd_pins ip_8_dft/dft_0/DATA_VALID]


########## floating_point ##########
create_bd_cell -type hier ip_9_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_9_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Custom CONFIG.add_sub_value Subtract CONFIG.axi_optimize_goal Performance CONFIG.c_a_exponent_width 7 CONFIG.c_a_fraction_width 55 CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage Full_Usage CONFIG.flow_control Blocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 1 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_type FMA CONFIG.result_tlast_behv AND_all_TLASTs " [get_bd_cells ip_9_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_floating_point/aclk
connect_bd_net [get_bd_pins ip_9_floating_point/aclk] [get_bd_pins ip_9_floating_point/floating_point_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_9_floating_point/S_AXIS_A] [get_bd_intf_pins ip_9_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_floating_point/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_9_floating_point/S_AXIS_B] [get_bd_intf_pins ip_9_floating_point/floating_point_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_floating_point/S_AXIS_C
connect_bd_intf_net [get_bd_intf_pins ip_9_floating_point/S_AXIS_C] [get_bd_intf_pins ip_9_floating_point/floating_point_0/S_AXIS_C]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_9_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_9_floating_point/floating_point_0/M_AXIS_RESULT]


########## dft ##########
create_bd_cell -type hier ip_10_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_10_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 10 CONFIG.Speed_Optimization Area CONFIG.Support_Size_1536 1 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_10_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/CLK
connect_bd_net [get_bd_pins ip_10_dft/CLK] [get_bd_pins ip_10_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/SCLR
connect_bd_net [get_bd_pins ip_10_dft/SCLR] [get_bd_pins ip_10_dft/dft_0/SCLR]
create_bd_pin -dir I -from 9 -to 0 ip_10_dft/XN_RE
connect_bd_net [get_bd_pins ip_10_dft/XN_RE] [get_bd_pins ip_10_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 9 -to 0 ip_10_dft/XN_IM
connect_bd_net [get_bd_pins ip_10_dft/XN_IM] [get_bd_pins ip_10_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/FD_IN
connect_bd_net [get_bd_pins ip_10_dft/FD_IN] [get_bd_pins ip_10_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_10_dft/FWD_INV
connect_bd_net [get_bd_pins ip_10_dft/FWD_INV] [get_bd_pins ip_10_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_10_dft/SIZE
connect_bd_net [get_bd_pins ip_10_dft/SIZE] [get_bd_pins ip_10_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/RFFD
connect_bd_net [get_bd_pins ip_10_dft/RFFD] [get_bd_pins ip_10_dft/dft_0/RFFD]
create_bd_pin -dir O -from 9 -to 0 ip_10_dft/XK_RE
connect_bd_net [get_bd_pins ip_10_dft/XK_RE] [get_bd_pins ip_10_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 9 -to 0 ip_10_dft/XK_IM
connect_bd_net [get_bd_pins ip_10_dft/XK_IM] [get_bd_pins ip_10_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_10_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_10_dft/BLK_EXP] [get_bd_pins ip_10_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/FD_OUT
connect_bd_net [get_bd_pins ip_10_dft/FD_OUT] [get_bd_pins ip_10_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_10_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_10_dft/DATA_VALID] [get_bd_pins ip_10_dft/dft_0/DATA_VALID]


########## axi_hwicap ##########
create_bd_cell -type hier ip_11_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_11_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 1 CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 256 " [get_bd_cells ip_11_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_11_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_11_axi_hwicap/icap_clk] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_11_axi_hwicap/eos_in] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_11_axi_hwicap/s_axi_aclk] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_11_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_11_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_11_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## gpio ##########
create_bd_cell -type hier ip_12_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_12_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x0 CONFIG.C_GPIO2_WIDTH 13 CONFIG.C_GPIO_WIDTH 32 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_12_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/GPIO] [get_bd_intf_pins ip_12_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/GPIO2] [get_bd_intf_pins ip_12_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/clk
connect_bd_net [get_bd_pins ip_12_gpio/clk] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/rst
connect_bd_net [get_bd_pins ip_12_gpio/rst] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_12_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_gpio/irq
connect_bd_net [get_bd_pins ip_12_gpio/irq] [get_bd_pins ip_12_gpio/gpio_0/ip2intc_irpt]


########## xadc_wiz ##########
create_bd_cell -type hier ip_13_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_13_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.ADC_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.ADC_OFFSET_CALIBRATION 0 CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 1 CONFIG.ENABLE_DCLK 0 CONFIG.ENABLE_JTAG_ARBITER 1 CONFIG.ENABLE_RESET 0 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION None CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.SENSOR_OFFSET_AND_GAIN_CALIBRATION 1 CONFIG.SENSOR_OFFSET_CALIBRATION 1 CONFIG.TIMING_MODE Continuous CONFIG.USER_TEMP_ALARM 1 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION single_channel " [get_bd_cells ip_13_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir O -from 0 -to 0 ip_13_xadc_wiz/user_temp_alarm_out
connect_bd_net [get_bd_pins ip_13_xadc_wiz/user_temp_alarm_out] [get_bd_pins ip_13_xadc_wiz/xadc_wiz_0/user_temp_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_13_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_13_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_13_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_13_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_13_xadc_wiz/eoc_out] [get_bd_pins ip_13_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_13_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_13_xadc_wiz/eos_out] [get_bd_pins ip_13_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_13_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_13_xadc_wiz/alarm_out] [get_bd_pins ip_13_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_13_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_13_xadc_wiz/busy_out] [get_bd_pins ip_13_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_13_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_13_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_13_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 0 -to 0 ip_13_xadc_wiz/jtaglocked_out
connect_bd_net [get_bd_pins ip_13_xadc_wiz/jtaglocked_out] [get_bd_pins ip_13_xadc_wiz/xadc_wiz_0/jtaglocked_out]
create_bd_pin -dir O -from 0 -to 0 ip_13_xadc_wiz/jtagmodified_out
connect_bd_net [get_bd_pins ip_13_xadc_wiz/jtagmodified_out] [get_bd_pins ip_13_xadc_wiz/xadc_wiz_0/jtagmodified_out]
create_bd_pin -dir O -from 0 -to 0 ip_13_xadc_wiz/jtagbusy_out
connect_bd_net [get_bd_pins ip_13_xadc_wiz/jtagbusy_out] [get_bd_pins ip_13_xadc_wiz/xadc_wiz_0/jtagbusy_out]


########## reset ##########
create_bd_cell -type hier ip_14_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_14_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_reset/clk_in
connect_bd_net [get_bd_pins ip_14_reset/clk_in] [get_bd_pins ip_14_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_14_reset/reset_in
connect_bd_net [get_bd_pins ip_14_reset/reset_in] [get_bd_pins ip_14_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_14_reset/dcm_locked
connect_bd_net [get_bd_pins ip_14_reset/dcm_locked] [get_bd_pins ip_14_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/mb_reset
connect_bd_net [get_bd_pins ip_14_reset/mb_reset] [get_bd_pins ip_14_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_14_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset] [get_bd_pins ip_14_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_14_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_14_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_15_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_15_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_in] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_15_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_15_clk_wiz/reset
connect_bd_net [get_bd_pins ip_15_clk_wiz/reset] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_15_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_locked] [get_bd_pins ip_15_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_16_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_16_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_16_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_16_intc/concat_0]
connect_bd_net [get_bd_pins ip_16_intc/concat_0/dout] [get_bd_pins ip_16_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/clk
connect_bd_net [get_bd_pins ip_16_intc/clk] [get_bd_pins ip_16_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/reset
connect_bd_net [get_bd_pins ip_16_intc/reset] [get_bd_pins ip_16_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_intc/AXI] [get_bd_intf_pins ip_16_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_0
connect_bd_net [get_bd_pins ip_16_intc/irq_0] [get_bd_pins ip_16_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_1
connect_bd_net [get_bd_pins ip_16_intc/irq_1] [get_bd_pins ip_16_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_2
connect_bd_net [get_bd_pins ip_16_intc/irq_2] [get_bd_pins ip_16_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_3
connect_bd_net [get_bd_pins ip_16_intc/irq_3] [get_bd_pins ip_16_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_4
connect_bd_net [get_bd_pins ip_16_intc/irq_4] [get_bd_pins ip_16_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_16_intc/irq_5
connect_bd_net [get_bd_pins ip_16_intc/irq_5] [get_bd_pins ip_16_intc/concat_0/In5]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_16_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_16_intc/irq] [get_bd_intf_pins ip_16_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_17_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_17_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 8 CONFIG.NUM_SI 1 " [get_bd_cells ip_17_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi/clk
connect_bd_net [get_bd_pins ip_17_axi/clk] [get_bd_pins ip_17_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi/reset
connect_bd_net [get_bd_pins ip_17_axi/reset] [get_bd_pins ip_17_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_M0] [get_bd_intf_pins ip_17_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S0] [get_bd_intf_pins ip_17_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S1] [get_bd_intf_pins ip_17_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S2] [get_bd_intf_pins ip_17_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S3] [get_bd_intf_pins ip_17_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S4] [get_bd_intf_pins ip_17_axi/axi_0/M04_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S5] [get_bd_intf_pins ip_17_axi/axi_0/M05_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S6] [get_bd_intf_pins ip_17_axi/axi_0/M06_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_17_axi/AXI_S7] [get_bd_intf_pins ip_17_axi/axi_0/M07_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_18_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_18_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_18_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_18_axis_broadcaster/aclk] [get_bd_pins ip_18_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_18_axis_broadcaster/aresetn] [get_bd_pins ip_18_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_18_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_19_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_19_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_19_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aclk] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_19_axis_dwidth_converter/aresetn] [get_bd_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_20_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_20_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aclk] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_20_axis_dwidth_converter/aresetn] [get_bd_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_21_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_21_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## reduce ##########
create_bd_cell -type hier ip_22_reduce
create_bd_pin -dir I -from 54 -to 0 ip_22_reduce/in0
create_bd_pin -dir O -from 31 -to 0 ip_22_reduce/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 32 " [get_bd_cells ip_22_reduce/concat]
connect_bd_net [get_bd_pins ip_22_reduce/out0] [get_bd_pins ip_22_reduce/concat/dout]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_0]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_0/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_0
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_0]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_0]
connect_bd_net [get_bd_pins ip_22_reduce/slice_0/dout] [get_bd_pins ip_22_reduce/reduce_0/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_0/Res] [get_bd_pins ip_22_reduce/concat/In0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_1]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_1/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_1
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_1]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_1]
connect_bd_net [get_bd_pins ip_22_reduce/slice_1/dout] [get_bd_pins ip_22_reduce/reduce_1/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_1/Res] [get_bd_pins ip_22_reduce/concat/In1]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_2
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_2]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_2]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_2/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_2
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_2]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_2]
connect_bd_net [get_bd_pins ip_22_reduce/slice_2/dout] [get_bd_pins ip_22_reduce/reduce_2/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_2/Res] [get_bd_pins ip_22_reduce/concat/In2]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_3
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_3]
set_property -dict "CONFIG.DIN_FROM 7 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_3]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_3/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_3
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_3]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_3]
connect_bd_net [get_bd_pins ip_22_reduce/slice_3/dout] [get_bd_pins ip_22_reduce/reduce_3/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_3/Res] [get_bd_pins ip_22_reduce/concat/In3]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_4
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_4]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 8 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_4]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_4/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_4
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_4]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_4]
connect_bd_net [get_bd_pins ip_22_reduce/slice_4/dout] [get_bd_pins ip_22_reduce/reduce_4/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_4/Res] [get_bd_pins ip_22_reduce/concat/In4]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_5
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_5]
set_property -dict "CONFIG.DIN_FROM 11 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_5]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_5/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_5
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_5]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_5]
connect_bd_net [get_bd_pins ip_22_reduce/slice_5/dout] [get_bd_pins ip_22_reduce/reduce_5/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_5/Res] [get_bd_pins ip_22_reduce/concat/In5]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_6
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_6]
set_property -dict "CONFIG.DIN_FROM 13 CONFIG.DIN_TO 12 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_6]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_6/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_6
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_6]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_6]
connect_bd_net [get_bd_pins ip_22_reduce/slice_6/dout] [get_bd_pins ip_22_reduce/reduce_6/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_6/Res] [get_bd_pins ip_22_reduce/concat/In6]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_7
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_7]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 14 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_7]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_7/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_7
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_7]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_7]
connect_bd_net [get_bd_pins ip_22_reduce/slice_7/dout] [get_bd_pins ip_22_reduce/reduce_7/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_7/Res] [get_bd_pins ip_22_reduce/concat/In7]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_8
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_8]
set_property -dict "CONFIG.DIN_FROM 17 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_8]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_8/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_8
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_8]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_8]
connect_bd_net [get_bd_pins ip_22_reduce/slice_8/dout] [get_bd_pins ip_22_reduce/reduce_8/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_8/Res] [get_bd_pins ip_22_reduce/concat/In8]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_9
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_9]
set_property -dict "CONFIG.DIN_FROM 19 CONFIG.DIN_TO 18 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_9]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_9/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_9
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_9]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_9]
connect_bd_net [get_bd_pins ip_22_reduce/slice_9/dout] [get_bd_pins ip_22_reduce/reduce_9/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_9/Res] [get_bd_pins ip_22_reduce/concat/In9]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_10
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_10]
set_property -dict "CONFIG.DIN_FROM 21 CONFIG.DIN_TO 20 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_10]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_10/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_10
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_10]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_10]
connect_bd_net [get_bd_pins ip_22_reduce/slice_10/dout] [get_bd_pins ip_22_reduce/reduce_10/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_10/Res] [get_bd_pins ip_22_reduce/concat/In10]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_11
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_11]
set_property -dict "CONFIG.DIN_FROM 23 CONFIG.DIN_TO 22 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_11]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_11/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_11
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_11]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_11]
connect_bd_net [get_bd_pins ip_22_reduce/slice_11/dout] [get_bd_pins ip_22_reduce/reduce_11/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_11/Res] [get_bd_pins ip_22_reduce/concat/In11]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_12
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_12]
set_property -dict "CONFIG.DIN_FROM 25 CONFIG.DIN_TO 24 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_12]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_12/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_12
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_12]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_12]
connect_bd_net [get_bd_pins ip_22_reduce/slice_12/dout] [get_bd_pins ip_22_reduce/reduce_12/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_12/Res] [get_bd_pins ip_22_reduce/concat/In12]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_13
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_13]
set_property -dict "CONFIG.DIN_FROM 27 CONFIG.DIN_TO 26 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_13]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_13/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_13
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_13]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_13]
connect_bd_net [get_bd_pins ip_22_reduce/slice_13/dout] [get_bd_pins ip_22_reduce/reduce_13/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_13/Res] [get_bd_pins ip_22_reduce/concat/In13]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_14
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_14]
set_property -dict "CONFIG.DIN_FROM 29 CONFIG.DIN_TO 28 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_14]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_14/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_14
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_14]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_14]
connect_bd_net [get_bd_pins ip_22_reduce/slice_14/dout] [get_bd_pins ip_22_reduce/reduce_14/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_14/Res] [get_bd_pins ip_22_reduce/concat/In14]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_15
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_15]
set_property -dict "CONFIG.DIN_FROM 31 CONFIG.DIN_TO 30 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_15]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_15/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_15
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_15]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_15]
connect_bd_net [get_bd_pins ip_22_reduce/slice_15/dout] [get_bd_pins ip_22_reduce/reduce_15/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_15/Res] [get_bd_pins ip_22_reduce/concat/In15]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_16
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_16]
set_property -dict "CONFIG.DIN_FROM 33 CONFIG.DIN_TO 32 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_16]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_16/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_16
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_16]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_16]
connect_bd_net [get_bd_pins ip_22_reduce/slice_16/dout] [get_bd_pins ip_22_reduce/reduce_16/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_16/Res] [get_bd_pins ip_22_reduce/concat/In16]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_17
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_17]
set_property -dict "CONFIG.DIN_FROM 35 CONFIG.DIN_TO 34 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_17]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_17/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_17
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_17]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_17]
connect_bd_net [get_bd_pins ip_22_reduce/slice_17/dout] [get_bd_pins ip_22_reduce/reduce_17/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_17/Res] [get_bd_pins ip_22_reduce/concat/In17]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_18
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_18]
set_property -dict "CONFIG.DIN_FROM 37 CONFIG.DIN_TO 36 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_18]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_18/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_18
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_18]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_18]
connect_bd_net [get_bd_pins ip_22_reduce/slice_18/dout] [get_bd_pins ip_22_reduce/reduce_18/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_18/Res] [get_bd_pins ip_22_reduce/concat/In18]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_19
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_19]
set_property -dict "CONFIG.DIN_FROM 39 CONFIG.DIN_TO 38 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_19]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_19/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_19
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_19]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_19]
connect_bd_net [get_bd_pins ip_22_reduce/slice_19/dout] [get_bd_pins ip_22_reduce/reduce_19/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_19/Res] [get_bd_pins ip_22_reduce/concat/In19]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_20
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_20]
set_property -dict "CONFIG.DIN_FROM 41 CONFIG.DIN_TO 40 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_20]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_20/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_20
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_20]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_20]
connect_bd_net [get_bd_pins ip_22_reduce/slice_20/dout] [get_bd_pins ip_22_reduce/reduce_20/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_20/Res] [get_bd_pins ip_22_reduce/concat/In20]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_21
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_21]
set_property -dict "CONFIG.DIN_FROM 43 CONFIG.DIN_TO 42 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_21]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_21/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_21
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_21]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_21]
connect_bd_net [get_bd_pins ip_22_reduce/slice_21/dout] [get_bd_pins ip_22_reduce/reduce_21/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_21/Res] [get_bd_pins ip_22_reduce/concat/In21]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_22
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_22]
set_property -dict "CONFIG.DIN_FROM 45 CONFIG.DIN_TO 44 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_22]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_22/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_22
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_22]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 2 " [get_bd_cells ip_22_reduce/reduce_22]
connect_bd_net [get_bd_pins ip_22_reduce/slice_22/dout] [get_bd_pins ip_22_reduce/reduce_22/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_22/Res] [get_bd_pins ip_22_reduce/concat/In22]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_23
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_23]
set_property -dict "CONFIG.DIN_FROM 46 CONFIG.DIN_TO 46 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_23]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_23/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_23
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_23]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_22_reduce/reduce_23]
connect_bd_net [get_bd_pins ip_22_reduce/slice_23/dout] [get_bd_pins ip_22_reduce/reduce_23/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_23/Res] [get_bd_pins ip_22_reduce/concat/In23]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_24
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_24]
set_property -dict "CONFIG.DIN_FROM 47 CONFIG.DIN_TO 47 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_24]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_24/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_24
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_24]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_22_reduce/reduce_24]
connect_bd_net [get_bd_pins ip_22_reduce/slice_24/dout] [get_bd_pins ip_22_reduce/reduce_24/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_24/Res] [get_bd_pins ip_22_reduce/concat/In24]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_25
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_25]
set_property -dict "CONFIG.DIN_FROM 48 CONFIG.DIN_TO 48 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_25]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_25/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_25
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_25]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_22_reduce/reduce_25]
connect_bd_net [get_bd_pins ip_22_reduce/slice_25/dout] [get_bd_pins ip_22_reduce/reduce_25/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_25/Res] [get_bd_pins ip_22_reduce/concat/In25]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_26
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_26]
set_property -dict "CONFIG.DIN_FROM 49 CONFIG.DIN_TO 49 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_26]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_26/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_26
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_26]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_22_reduce/reduce_26]
connect_bd_net [get_bd_pins ip_22_reduce/slice_26/dout] [get_bd_pins ip_22_reduce/reduce_26/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_26/Res] [get_bd_pins ip_22_reduce/concat/In26]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_27
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_27]
set_property -dict "CONFIG.DIN_FROM 50 CONFIG.DIN_TO 50 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_27]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_27/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_27
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_27]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_22_reduce/reduce_27]
connect_bd_net [get_bd_pins ip_22_reduce/slice_27/dout] [get_bd_pins ip_22_reduce/reduce_27/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_27/Res] [get_bd_pins ip_22_reduce/concat/In27]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_28
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_28]
set_property -dict "CONFIG.DIN_FROM 51 CONFIG.DIN_TO 51 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_28]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_28/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_28
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_28]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_22_reduce/reduce_28]
connect_bd_net [get_bd_pins ip_22_reduce/slice_28/dout] [get_bd_pins ip_22_reduce/reduce_28/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_28/Res] [get_bd_pins ip_22_reduce/concat/In28]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_29
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_29]
set_property -dict "CONFIG.DIN_FROM 52 CONFIG.DIN_TO 52 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_29]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_29/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_29
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_29]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_22_reduce/reduce_29]
connect_bd_net [get_bd_pins ip_22_reduce/slice_29/dout] [get_bd_pins ip_22_reduce/reduce_29/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_29/Res] [get_bd_pins ip_22_reduce/concat/In29]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_30
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_30]
set_property -dict "CONFIG.DIN_FROM 53 CONFIG.DIN_TO 53 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_30]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_30/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_30
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_30]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_22_reduce/reduce_30]
connect_bd_net [get_bd_pins ip_22_reduce/slice_30/dout] [get_bd_pins ip_22_reduce/reduce_30/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_30/Res] [get_bd_pins ip_22_reduce/concat/In30]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_31
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells slice_31]
set_property -dict "CONFIG.DIN_FROM 54 CONFIG.DIN_TO 54 CONFIG.DIN_WIDTH 55 " [get_bd_cells ip_22_reduce/slice_31]
connect_bd_net [get_bd_pins ip_22_reduce/in0] [get_bd_pins ip_22_reduce/slice_31/din]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 reduce_31
move_bd_cells [get_bd_cells ip_22_reduce] [get_bd_cells reduce_31]
set_property -dict "CONFIG.C_OPERATION XOR CONFIG.C_SIZE 1 " [get_bd_cells ip_22_reduce/reduce_31]
connect_bd_net [get_bd_pins ip_22_reduce/slice_31/dout] [get_bd_pins ip_22_reduce/reduce_31/Op1]
connect_bd_net [get_bd_pins ip_22_reduce/reduce_31/Res] [get_bd_pins ip_22_reduce/concat/In31]


########## slice_and_concat ##########
create_bd_cell -type hier ip_23_slice_and_concat
create_bd_pin -dir O -from 246 -to 0 ip_23_slice_and_concat/out0
create_bd_pin -dir I -from 257 -to 0 ip_23_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_23_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 246 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 258 " [get_bd_cells ip_23_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_23_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_23_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 257 -to 0 ip_24_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_24_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 247 CONFIG.DIN_TO 247 CONFIG.DIN_WIDTH 258 " [get_bd_cells ip_24_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_24_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_25_slice_and_concat/out0
create_bd_pin -dir I -from 257 -to 0 ip_25_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 257 CONFIG.DIN_TO 248 CONFIG.DIN_WIDTH 258 " [get_bd_cells ip_25_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 254 -to 0 ip_26_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_26_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 255 " [get_bd_cells ip_26_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_26_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 54 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 254 -to 0 ip_27_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_27_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 60 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 255 " [get_bd_cells ip_27_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_27_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_28_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_28_slice_and_concat/out0
create_bd_pin -dir I -from 254 -to 0 ip_28_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_28_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 78 CONFIG.DIN_TO 61 CONFIG.DIN_WIDTH 255 " [get_bd_cells ip_28_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_28_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_28_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_29_slice_and_concat
create_bd_pin -dir O -from 17 -to 0 ip_29_slice_and_concat/out0
create_bd_pin -dir I -from 254 -to 0 ip_29_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_29_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 96 CONFIG.DIN_TO 79 CONFIG.DIN_WIDTH 255 " [get_bd_cells ip_29_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_29_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_29_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_30_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_30_slice_and_concat/out0
create_bd_pin -dir I -from 254 -to 0 ip_30_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_30_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 107 CONFIG.DIN_TO 97 CONFIG.DIN_WIDTH 255 " [get_bd_cells ip_30_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_30_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_30_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_31_slice_and_concat
create_bd_pin -dir O -from 9 -to 0 ip_31_slice_and_concat/out0
create_bd_pin -dir I -from 254 -to 0 ip_31_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_31_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 117 CONFIG.DIN_TO 108 CONFIG.DIN_WIDTH 255 " [get_bd_cells ip_31_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_31_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_31_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_32_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_32_slice_and_concat/out0
create_bd_pin -dir I -from 254 -to 0 ip_32_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_32_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 123 CONFIG.DIN_TO 118 CONFIG.DIN_WIDTH 255 " [get_bd_cells ip_32_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_32_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_32_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_33_slice_and_concat
create_bd_pin -dir O -from 247 -to 0 ip_33_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 20 " [get_bd_cells ip_33_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_33_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 254 -to 0 ip_33_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_33_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 254 CONFIG.DIN_TO 124 CONFIG.DIN_WIDTH 255 " [get_bd_cells ip_33_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_33_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/slice_0/dout] [get_bd_pins ip_33_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 40 -to 0 ip_33_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_33_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_2] [get_bd_pins ip_33_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 17 -to 0 ip_33_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_3] [get_bd_pins ip_33_slice_and_concat/concat/In3]
create_bd_pin -dir I -from 17 -to 0 ip_33_slice_and_concat/in_4
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_4] [get_bd_pins ip_33_slice_and_concat/concat/In4]
create_bd_pin -dir I -from 3 -to 0 ip_33_slice_and_concat/in_5
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_5] [get_bd_pins ip_33_slice_and_concat/concat/In5]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_6
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_6] [get_bd_pins ip_33_slice_and_concat/concat/In6]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_7
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_7] [get_bd_pins ip_33_slice_and_concat/concat/In7]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_8
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_8] [get_bd_pins ip_33_slice_and_concat/concat/In8]
create_bd_pin -dir I -from 9 -to 0 ip_33_slice_and_concat/in_9
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_9] [get_bd_pins ip_33_slice_and_concat/concat/In9]
create_bd_pin -dir I -from 9 -to 0 ip_33_slice_and_concat/in_10
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_10] [get_bd_pins ip_33_slice_and_concat/concat/In10]
create_bd_pin -dir I -from 3 -to 0 ip_33_slice_and_concat/in_11
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_11] [get_bd_pins ip_33_slice_and_concat/concat/In11]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_12
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_12] [get_bd_pins ip_33_slice_and_concat/concat/In12]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_13
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_13] [get_bd_pins ip_33_slice_and_concat/concat/In13]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_14
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_14] [get_bd_pins ip_33_slice_and_concat/concat/In14]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_15
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_15] [get_bd_pins ip_33_slice_and_concat/concat/In15]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_16
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_16] [get_bd_pins ip_33_slice_and_concat/concat/In16]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_17
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_17] [get_bd_pins ip_33_slice_and_concat/concat/In17]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_18
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_18] [get_bd_pins ip_33_slice_and_concat/concat/In18]
create_bd_pin -dir I -from 0 -to 0 ip_33_slice_and_concat/in_19
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_19] [get_bd_pins ip_33_slice_and_concat/concat/In19]


########## slice_and_concat ##########
create_bd_cell -type hier ip_34_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_34_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_34_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_35_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_35_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_35_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_36_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_36_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_36_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_37_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_37_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_37_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_38_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_38_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_38_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_39_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_39_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_39_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_40_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_40_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_40_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_41_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_41_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_41_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_42_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_42_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_42_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_43_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_43_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_43_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_44_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_44_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_44_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_15_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO] [get_bd_intf_pins ip_0_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO2] [get_bd_intf_pins ip_0_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_2_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_2_axi_iic_IIC] [get_bd_intf_pins ip_2_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc_EMC_INTF] [get_bd_intf_pins ip_3_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO] [get_bd_intf_pins ip_12_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO2] [get_bd_intf_pins ip_12_gpio/GPIO2]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_13_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_13_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_13_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_16_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_18_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_9_floating_point/M_AXIS_RESULT]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 31 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_22_reduce/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_41_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_42_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_0_gpio/rst]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_2_axi_iic/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_3_emc/rst]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset] [get_bd_pins ip_8_dft/SCLR]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset] [get_bd_pins ip_10_dft/SCLR]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_12_gpio/rst]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_0_gpio/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_1_accumulator/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_2_axi_iic/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_3_emc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_3_emc/rdclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_4_accumulator/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_6_accumulator/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_7_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_7_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_8_dft/CLK]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_9_floating_point/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_10_dft/CLK]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_11_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_11_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_12_gpio/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_14_reset/clk_in]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_locked] [get_bd_pins ip_14_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_16_intc/irq_0] [get_bd_pins ip_0_gpio/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_1] [get_bd_pins ip_2_axi_iic/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_2] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_3] [get_bd_pins ip_7_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_16_intc/irq_4] [get_bd_pins ip_11_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_16_intc/irq_5] [get_bd_pins ip_12_gpio/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_cdma/M_AXI] [get_bd_intf_pins ip_17_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_17_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_iic/AXI] [get_bd_intf_pins ip_17_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_17_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_17_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_17_axi/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_17_axi/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_17_axi/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_intc/AXI] [get_bd_intf_pins ip_17_axi/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_floating_point/S_AXIS_B] [get_bd_intf_pins ip_19_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_floating_point/S_AXIS_A] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_18_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_floating_point/S_AXIS_C] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/B]
connect_bd_net [get_bd_pins ip_23_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_11_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_10_dft/XN_RE]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_1_accumulator/Q]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_8_dft/SIZE]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_22_reduce/in0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/out0] [get_bd_pins ip_8_dft/XN_RE]
connect_bd_net [get_bd_pins ip_28_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/out0] [get_bd_pins ip_8_dft/XN_IM]
connect_bd_net [get_bd_pins ip_29_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/out0] [get_bd_pins ip_6_accumulator/B]
connect_bd_net [get_bd_pins ip_30_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/out0] [get_bd_pins ip_10_dft/XN_IM]
connect_bd_net [get_bd_pins ip_31_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/out0] [get_bd_pins ip_10_dft/SIZE]
connect_bd_net [get_bd_pins ip_32_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/B]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_0] [get_bd_pins ip_4_accumulator/Q]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_1] [get_bd_pins ip_6_accumulator/Q]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_2] [get_bd_pins ip_8_dft/RFFD]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_3] [get_bd_pins ip_8_dft/XK_RE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_4] [get_bd_pins ip_8_dft/XK_IM]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_5] [get_bd_pins ip_8_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_6] [get_bd_pins ip_8_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_7] [get_bd_pins ip_8_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_8] [get_bd_pins ip_10_dft/RFFD]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_9] [get_bd_pins ip_10_dft/XK_RE]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_10] [get_bd_pins ip_10_dft/XK_IM]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_11] [get_bd_pins ip_10_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_12] [get_bd_pins ip_10_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_13] [get_bd_pins ip_10_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_14] [get_bd_pins ip_13_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_15] [get_bd_pins ip_13_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_16] [get_bd_pins ip_13_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_17] [get_bd_pins ip_13_xadc_wiz/jtaglocked_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_18] [get_bd_pins ip_13_xadc_wiz/jtagmodified_out]
connect_bd_net [get_bd_pins ip_33_slice_and_concat/in_19] [get_bd_pins ip_13_xadc_wiz/jtagbusy_out]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/CE]
connect_bd_net [get_bd_pins ip_34_slice_and_concat/out0] [get_bd_pins ip_34_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/Bypass]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/in_0] [get_bd_pins ip_13_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_35_slice_and_concat/out0] [get_bd_pins ip_35_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/C_IN]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/in_0] [get_bd_pins ip_13_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_36_slice_and_concat/out0] [get_bd_pins ip_36_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_8_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/in_0] [get_bd_pins ip_13_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_37_slice_and_concat/out0] [get_bd_pins ip_37_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/ADD]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/in_0] [get_bd_pins ip_13_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_38_slice_and_concat/out0] [get_bd_pins ip_38_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_4_accumulator/SCLR]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/in_0] [get_bd_pins ip_13_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_39_slice_and_concat/out0] [get_bd_pins ip_39_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_8_dft/CE]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/in_0] [get_bd_pins ip_13_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_40_slice_and_concat/out0] [get_bd_pins ip_40_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_10_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_41_slice_and_concat/out0] [get_bd_pins ip_41_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_10_dft/FD_IN]
connect_bd_net [get_bd_pins ip_42_slice_and_concat/out0] [get_bd_pins ip_42_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_6_accumulator/ADD]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/in_0] [get_bd_pins ip_13_xadc_wiz/user_temp_alarm_out]
connect_bd_net [get_bd_pins ip_43_slice_and_concat/out0] [get_bd_pins ip_43_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_8_dft/FD_IN]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/in_0] [get_bd_pins ip_13_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_44_slice_and_concat/out0] [get_bd_pins ip_44_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_1_accumulator/CE]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_17_axi/reset]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_18_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_19_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_16_intc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_17_axi/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_18_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_19_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_floating_point/floating_point_0/S_AXIS_C]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/S_AXIS_C declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/S_AXIS_C declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_18_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_18_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }


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
