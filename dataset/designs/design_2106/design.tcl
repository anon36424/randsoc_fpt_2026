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



########## emc ##########
create_bd_cell -type hier ip_0_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_0_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 2 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 7 CONFIG.C_TAVDV_PS_MEM_0 16070 CONFIG.C_TAVDV_PS_MEM_1 16332 CONFIG.C_TAVDV_PS_MEM_2 16010 CONFIG.C_TCEDV_PS_MEM_0 16198 CONFIG.C_TCEDV_PS_MEM_1 15099 CONFIG.C_TCEDV_PS_MEM_2 14372 CONFIG.C_THZCE_PS_MEM_0 7625 CONFIG.C_THZCE_PS_MEM_1 6413 CONFIG.C_THZCE_PS_MEM_2 7455 CONFIG.C_THZOE_PS_MEM_0 7217 CONFIG.C_THZOE_PS_MEM_1 6369 CONFIG.C_THZOE_PS_MEM_2 7007 CONFIG.C_TLZWE_PS_MEM_0 1126 CONFIG.C_TLZWE_PS_MEM_1 7929 CONFIG.C_TLZWE_PS_MEM_2 9237 CONFIG.C_TWC_PS_MEM_0 16460 CONFIG.C_TWC_PS_MEM_1 14859 CONFIG.C_TWC_PS_MEM_2 16162 CONFIG.C_TWPH_PS_MEM_0 12806 CONFIG.C_TWPH_PS_MEM_1 11675 CONFIG.C_TWPH_PS_MEM_2 10895 CONFIG.C_TWP_PS_MEM_0 11771 CONFIG.C_TWP_PS_MEM_1 11625 CONFIG.C_TWP_PS_MEM_2 12893 CONFIG.C_WR_REC_TIME_MEM_0 25213 CONFIG.C_WR_REC_TIME_MEM_1 27625 CONFIG.C_WR_REC_TIME_MEM_2 25827 " [get_bd_cells ip_0_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc/EMC_INTF] [get_bd_intf_pins ip_0_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/clk
connect_bd_net [get_bd_pins ip_0_emc/clk] [get_bd_pins ip_0_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/rdclk
connect_bd_net [get_bd_pins ip_0_emc/rdclk] [get_bd_pins ip_0_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_emc/rst
connect_bd_net [get_bd_pins ip_0_emc/rst] [get_bd_pins ip_0_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_0_emc/emc_0/S_AXI_MEM]


########## complex_multiplier ##########
create_bd_cell -type hier ip_1_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_1_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 23 CONFIG.aresetn 0 CONFIG.bportwidth 52 CONFIG.btuserwidth 98 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 31 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_1_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aclk] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## emc ##########
create_bd_cell -type hier ip_2_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_2_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 2 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 9 CONFIG.C_TAVDV_PS_MEM_0 13784 CONFIG.C_TAVDV_PS_MEM_1 14697 CONFIG.C_TAVDV_PS_MEM_2 15550 CONFIG.C_TCEDV_PS_MEM_0 16496 CONFIG.C_TCEDV_PS_MEM_1 15714 CONFIG.C_TCEDV_PS_MEM_2 15485 CONFIG.C_THZCE_PS_MEM_0 7093 CONFIG.C_THZCE_PS_MEM_1 6411 CONFIG.C_THZCE_PS_MEM_2 7095 CONFIG.C_THZOE_PS_MEM_0 7259 CONFIG.C_THZOE_PS_MEM_1 6679 CONFIG.C_THZOE_PS_MEM_2 6677 CONFIG.C_TLZWE_PS_MEM_0 1231 CONFIG.C_TLZWE_PS_MEM_1 4827 CONFIG.C_TLZWE_PS_MEM_2 6161 CONFIG.C_TWC_PS_MEM_0 14205 CONFIG.C_TWC_PS_MEM_1 14293 CONFIG.C_TWC_PS_MEM_2 15792 CONFIG.C_TWPH_PS_MEM_0 11772 CONFIG.C_TWPH_PS_MEM_1 10923 CONFIG.C_TWPH_PS_MEM_2 12099 CONFIG.C_TWP_PS_MEM_0 13188 CONFIG.C_TWP_PS_MEM_1 11429 CONFIG.C_TWP_PS_MEM_2 12454 CONFIG.C_WR_REC_TIME_MEM_0 25206 CONFIG.C_WR_REC_TIME_MEM_1 27994 CONFIG.C_WR_REC_TIME_MEM_2 24879 " [get_bd_cells ip_2_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_2_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_2_emc/EMC_INTF] [get_bd_intf_pins ip_2_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_2_emc/clk
connect_bd_net [get_bd_pins ip_2_emc/clk] [get_bd_pins ip_2_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_emc/rdclk
connect_bd_net [get_bd_pins ip_2_emc/rdclk] [get_bd_pins ip_2_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_emc/rst
connect_bd_net [get_bd_pins ip_2_emc/rst] [get_bd_pins ip_2_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_emc/AXI] [get_bd_intf_pins ip_2_emc/emc_0/S_AXI_MEM]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_3_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_3_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_BYTE_LEVEL_INTERRUPT_EN 1 CONFIG.C_FIFO_DEPTH 256 CONFIG.C_NUM_TRANSFER_BITS 32 CONFIG.C_SCK_RATIO 4 CONFIG.C_SPI_MODE 0 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 0 " [get_bd_cells ip_3_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_3_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_quad_spi/IIC] [get_bd_intf_pins ip_3_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_3_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_3_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_3_axi_quad_spi/clk] [get_bd_pins ip_3_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_3_axi_quad_spi/reset] [get_bd_pins ip_3_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_3_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_3_axi_quad_spi/irq] [get_bd_pins ip_3_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## reset ##########
create_bd_cell -type hier ip_4_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_4_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_reset/clk_in
connect_bd_net [get_bd_pins ip_4_reset/clk_in] [get_bd_pins ip_4_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_4_reset/reset_in
connect_bd_net [get_bd_pins ip_4_reset/reset_in] [get_bd_pins ip_4_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_4_reset/dcm_locked
connect_bd_net [get_bd_pins ip_4_reset/dcm_locked] [get_bd_pins ip_4_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_4_reset/mb_reset
connect_bd_net [get_bd_pins ip_4_reset/mb_reset] [get_bd_pins ip_4_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_4_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_4_reset/peripheral_areset_n] [get_bd_pins ip_4_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_4_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_4_reset/peripheral_areset] [get_bd_pins ip_4_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_4_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_4_reset/interconnect_aresetn] [get_bd_pins ip_4_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_5_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_5_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_in] [get_bd_pins ip_5_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_5_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_5_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_5_clk_wiz/reset
connect_bd_net [get_bd_pins ip_5_clk_wiz/reset] [get_bd_pins ip_5_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_5_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_locked] [get_bd_pins ip_5_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_6_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_6_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_6_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 1 " [get_bd_cells ip_6_intc/concat_0]
connect_bd_net [get_bd_pins ip_6_intc/concat_0/dout] [get_bd_pins ip_6_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_6_intc/clk
connect_bd_net [get_bd_pins ip_6_intc/clk] [get_bd_pins ip_6_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_intc/reset
connect_bd_net [get_bd_pins ip_6_intc/reset] [get_bd_pins ip_6_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_intc/AXI] [get_bd_intf_pins ip_6_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_6_intc/irq_0
connect_bd_net [get_bd_pins ip_6_intc/irq_0] [get_bd_pins ip_6_intc/concat_0/In0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_6_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_6_intc/irq] [get_bd_intf_pins ip_6_intc/intc_0/interrupt]


########## jtag_axi ##########
create_bd_cell -type hier ip_7_jtag_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0
move_bd_cells [get_bd_cells ip_7_jtag_axi] [get_bd_cells jtag_axi_0]
set_property -dict "CONFIG.PROTOCOL AXI4LITE " [get_bd_cells ip_7_jtag_axi/jtag_axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_jtag_axi/aclk
connect_bd_net [get_bd_pins ip_7_jtag_axi/aclk] [get_bd_pins ip_7_jtag_axi/jtag_axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_jtag_axi/aresetn
connect_bd_net [get_bd_pins ip_7_jtag_axi/aresetn] [get_bd_pins ip_7_jtag_axi/jtag_axi_0/aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_jtag_axi/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_jtag_axi/M_AXI] [get_bd_intf_pins ip_7_jtag_axi/jtag_axi_0/M_AXI]


########## axi ##########
create_bd_cell -type hier ip_8_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_8_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 1 " [get_bd_cells ip_8_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi/clk
connect_bd_net [get_bd_pins ip_8_axi/clk] [get_bd_pins ip_8_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi/reset
connect_bd_net [get_bd_pins ip_8_axi/reset] [get_bd_pins ip_8_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_M0] [get_bd_intf_pins ip_8_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_S0] [get_bd_intf_pins ip_8_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_S1] [get_bd_intf_pins ip_8_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_S2] [get_bd_intf_pins ip_8_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_8_axi/AXI_S3] [get_bd_intf_pins ip_8_axi/axi_0/M03_AXI]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_9_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_9_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_9_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_9_axis_broadcaster/aclk] [get_bd_pins ip_9_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_9_axis_broadcaster/aresetn] [get_bd_pins ip_9_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_9_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_10_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_10_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_10_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aclk] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_10_axis_dwidth_converter/aresetn] [get_bd_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_10_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_11_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_11_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_11_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aclk] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_11_axis_dwidth_converter/aresetn] [get_bd_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_4_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_5_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_0_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_0_emc_EMC_INTF] [get_bd_intf_pins ip_0_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_2_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_2_emc_EMC_INTF] [get_bd_intf_pins ip_2_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_3_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_quad_spi_IIC] [get_bd_intf_pins ip_3_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_6_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_9_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT]

########## Connecting Protocol.DATA ports ##########

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_5_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_4_reset/peripheral_areset_n] [get_bd_pins ip_0_emc/rst]
connect_bd_net [get_bd_pins ip_4_reset/peripheral_areset_n] [get_bd_pins ip_2_emc/rst]
connect_bd_net [get_bd_pins ip_4_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_0_emc/clk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_0_emc/rdclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_1_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_2_emc/clk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_2_emc/rdclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_3_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_3_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_4_reset/clk_in]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_locked] [get_bd_pins ip_4_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_6_intc/irq_0] [get_bd_pins ip_3_axi_quad_spi/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_jtag_axi/M_AXI] [get_bd_intf_pins ip_8_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_emc/AXI] [get_bd_intf_pins ip_8_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_emc/AXI] [get_bd_intf_pins ip_8_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_8_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_intc/AXI] [get_bd_intf_pins ip_8_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_9_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_10_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_9_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_4_reset/interconnect_aresetn] [get_bd_pins ip_7_jtag_axi/aresetn]
connect_bd_net [get_bd_pins ip_4_reset/interconnect_aresetn] [get_bd_pins ip_8_axi/reset]
connect_bd_net [get_bd_pins ip_4_reset/interconnect_aresetn] [get_bd_pins ip_9_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_4_reset/interconnect_aresetn] [get_bd_pins ip_10_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_4_reset/interconnect_aresetn] [get_bd_pins ip_11_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_6_intc/clk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_7_jtag_axi/aclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_8_axi/clk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_9_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_10_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_11_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }


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
