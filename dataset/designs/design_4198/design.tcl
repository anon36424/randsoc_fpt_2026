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
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 5 CONFIG.convolution_code0 30 CONFIG.convolution_code1 19 CONFIG.convolution_code2 19 CONFIG.convolution_code3 10 CONFIG.convolution_code4 6 CONFIG.convolution_code5 12 CONFIG.convolution_code6 1 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 4 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_0_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_0_conv_encoder/aclk] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_0_conv_encoder/aresetn] [get_bd_pins ip_0_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_0_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_hwicap ##########
create_bd_cell -type hier ip_1_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_1_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 0 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 CONFIG.C_WRITE_FIFO_DEPTH 512 " [get_bd_cells ip_1_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_1_axi_hwicap/icap_clk] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_1_axi_hwicap/eos_in] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_1_axi_hwicap/s_axi_aclk] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_1_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_2_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_2_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Parallel CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sinh_and_Cosh CONFIG.Input_Width 10 CONFIG.Iterations 47 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 29 CONFIG.PHASE_HAS_TLAST 1 CONFIG.PHASE_HAS_TUSER 1 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode No_Pipelining CONFIG.Precision 35 CONFIG.Round_Mode Truncate " [get_bd_cells ip_2_cordic/cordic_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_2_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]


########## dft ##########
create_bd_cell -type hier ip_3_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_3_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 11 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_3_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/CLK
connect_bd_net [get_bd_pins ip_3_dft/CLK] [get_bd_pins ip_3_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/SCLR
connect_bd_net [get_bd_pins ip_3_dft/SCLR] [get_bd_pins ip_3_dft/dft_0/SCLR]
create_bd_pin -dir I -from 10 -to 0 ip_3_dft/XN_RE
connect_bd_net [get_bd_pins ip_3_dft/XN_RE] [get_bd_pins ip_3_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 10 -to 0 ip_3_dft/XN_IM
connect_bd_net [get_bd_pins ip_3_dft/XN_IM] [get_bd_pins ip_3_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FD_IN
connect_bd_net [get_bd_pins ip_3_dft/FD_IN] [get_bd_pins ip_3_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_3_dft/FWD_INV
connect_bd_net [get_bd_pins ip_3_dft/FWD_INV] [get_bd_pins ip_3_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_3_dft/SIZE
connect_bd_net [get_bd_pins ip_3_dft/SIZE] [get_bd_pins ip_3_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/RFFD
connect_bd_net [get_bd_pins ip_3_dft/RFFD] [get_bd_pins ip_3_dft/dft_0/RFFD]
create_bd_pin -dir O -from 10 -to 0 ip_3_dft/XK_RE
connect_bd_net [get_bd_pins ip_3_dft/XK_RE] [get_bd_pins ip_3_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 10 -to 0 ip_3_dft/XK_IM
connect_bd_net [get_bd_pins ip_3_dft/XK_IM] [get_bd_pins ip_3_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_3_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_3_dft/BLK_EXP] [get_bd_pins ip_3_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/FD_OUT
connect_bd_net [get_bd_pins ip_3_dft/FD_OUT] [get_bd_pins ip_3_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_3_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_3_dft/DATA_VALID] [get_bd_pins ip_3_dft/dft_0/DATA_VALID]


########## emc ##########
create_bd_cell -type hier ip_4_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_4_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 64 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 64 CONFIG.C_MEM2_TYPE 0 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_SYNCH_PIPEDELAY_2 1 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 14 CONFIG.C_TAVDV_PS_MEM_0 14338 CONFIG.C_TAVDV_PS_MEM_1 14992 CONFIG.C_TCEDV_PS_MEM_0 15211 CONFIG.C_TCEDV_PS_MEM_1 15962 CONFIG.C_THZCE_PS_MEM_0 6368 CONFIG.C_THZCE_PS_MEM_1 6729 CONFIG.C_THZOE_PS_MEM_0 6526 CONFIG.C_THZOE_PS_MEM_1 7575 CONFIG.C_TLZWE_PS_MEM_0 2612 CONFIG.C_TLZWE_PS_MEM_1 6300 CONFIG.C_TWC_PS_MEM_0 13543 CONFIG.C_TWC_PS_MEM_1 15145 CONFIG.C_TWPH_PS_MEM_0 11456 CONFIG.C_TWPH_PS_MEM_1 12538 CONFIG.C_TWP_PS_MEM_0 13069 CONFIG.C_TWP_PS_MEM_1 12405 CONFIG.C_WR_REC_TIME_MEM_0 27152 CONFIG.C_WR_REC_TIME_MEM_1 24549 " [get_bd_cells ip_4_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_4_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_4_emc/EMC_INTF] [get_bd_intf_pins ip_4_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_4_emc/clk
connect_bd_net [get_bd_pins ip_4_emc/clk] [get_bd_pins ip_4_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_emc/rdclk
connect_bd_net [get_bd_pins ip_4_emc/rdclk] [get_bd_pins ip_4_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_emc/rst
connect_bd_net [get_bd_pins ip_4_emc/rst] [get_bd_pins ip_4_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_4_emc/AXI] [get_bd_intf_pins ip_4_emc/emc_0/S_AXI_MEM]


########## conv_encoder ##########
create_bd_cell -type hier ip_5_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_5_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 4 CONFIG.convolution_code0 2 CONFIG.convolution_code1 1 CONFIG.convolution_code2 3 CONFIG.convolution_code3 4 CONFIG.convolution_code4 10 CONFIG.convolution_code5 11 CONFIG.convolution_code6 8 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 7 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_5_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_5_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_5_conv_encoder/aclk] [get_bd_pins ip_5_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_5_conv_encoder/aclken] [get_bd_pins ip_5_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_5_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_5_conv_encoder/aresetn] [get_bd_pins ip_5_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_5_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## uartlite ##########
create_bd_cell -type hier ip_6_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_6_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 110 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Even " [get_bd_cells ip_6_uartlite/uart_0]
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
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_9_intc/concat_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_9_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_9_intc/irq] [get_bd_intf_pins ip_9_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_10_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_10_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 4 CONFIG.NUM_SI 1 " [get_bd_cells ip_10_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi/clk
connect_bd_net [get_bd_pins ip_10_axi/clk] [get_bd_pins ip_10_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi/reset
connect_bd_net [get_bd_pins ip_10_axi/reset] [get_bd_pins ip_10_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_M0] [get_bd_intf_pins ip_10_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S0] [get_bd_intf_pins ip_10_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S1] [get_bd_intf_pins ip_10_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S2] [get_bd_intf_pins ip_10_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_10_axi/AXI_S3] [get_bd_intf_pins ip_10_axi/axi_0/M03_AXI]


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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_12_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_12_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_12_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_12_axis_dwidth_converter/aclk] [get_bd_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_12_axis_dwidth_converter/aresetn] [get_bd_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_12_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_13_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_13_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_13_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aclk] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_13_axis_dwidth_converter/aresetn] [get_bd_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_14_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_14_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_14_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_14_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_14_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_14_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 10 -to 0 ip_14_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_14_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_14_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_1] [get_bd_pins ip_14_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/slice_1/dout] [get_bd_pins ip_14_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_15_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_15_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_15_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_15_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 10 -to 0 ip_15_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_15_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_15_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/slice_0/dout] [get_bd_pins ip_15_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 10 -to 0 ip_15_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_15_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 9 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_15_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_1] [get_bd_pins ip_15_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/slice_1/dout] [get_bd_pins ip_15_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_16_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_16_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_16_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_16_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 10 -to 0 ip_16_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_16_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 10 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_16_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_16_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/slice_0/dout] [get_bd_pins ip_16_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_16_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_16_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_16_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_16_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_17_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_17_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_17_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_18_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_18_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_18_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_19_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_19_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_19_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_20_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_20_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_20_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_7_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_8_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_4_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_4_emc_EMC_INTF] [get_bd_intf_pins ip_4_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_6_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_6_uartlite_UART] [get_bd_intf_pins ip_6_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_9_intc/irq]

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi_master
set_property -dict "CONFIG.PROTOCOL AXI4LITE " [get_bd_intf_ports axi_master]
connect_bd_intf_net [get_bd_intf_pins axi_master] [get_bd_intf_pins ip_10_axi/AXI_M0]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_11_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_2_cordic/M_AXIS_DOUT]

########## Connecting Protocol.DATA ports ##########

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 0 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_9_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_0_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset] [get_bd_pins ip_3_dft/SCLR]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_4_emc/rst]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_5_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/peripheral_areset_n] [get_bd_pins ip_6_uartlite/reset]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_0_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_3_dft/CLK]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_4_emc/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_4_emc/rdclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_5_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_6_uartlite/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_7_reset/clk_in]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_locked] [get_bd_pins ip_7_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_9_intc/irq_0] [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_9_intc/irq_1] [get_bd_pins ip_6_uartlite/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_10_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_emc/AXI] [get_bd_intf_pins ip_10_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_uartlite/AXI] [get_bd_intf_pins ip_10_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_intc/AXI] [get_bd_intf_pins ip_10_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_11_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_0_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_12_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_5_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_13_axis_dwidth_converter/M_AXIS]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_IM]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_0] [get_bd_pins ip_3_dft/RFFD]
connect_bd_net [get_bd_pins ip_14_slice_and_concat/in_1] [get_bd_pins ip_3_dft/XK_RE]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/out0] [get_bd_pins ip_3_dft/XN_RE]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_0] [get_bd_pins ip_3_dft/XK_RE]
connect_bd_net [get_bd_pins ip_15_slice_and_concat/in_1] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/out0] [get_bd_pins ip_3_dft/SIZE]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_0] [get_bd_pins ip_3_dft/XK_IM]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_1] [get_bd_pins ip_3_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_16_slice_and_concat/in_2] [get_bd_pins ip_3_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_1_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/in_0] [get_bd_pins ip_3_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_17_slice_and_concat/out0] [get_bd_pins ip_17_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_3_dft/FD_IN]
connect_bd_net [get_bd_pins ip_18_slice_and_concat/out0] [get_bd_pins ip_18_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_3_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_19_slice_and_concat/out0] [get_bd_pins ip_19_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_5_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_20_slice_and_concat/out0] [get_bd_pins ip_20_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_10_axi/reset]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_11_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_12_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_7_reset/interconnect_aresetn] [get_bd_pins ip_13_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_9_intc/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_10_axi/clk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_11_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_12_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_8_clk_wiz/clk_out] [get_bd_pins ip_13_axis_dwidth_converter/aclk]

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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_PHASE declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/S_AXIS_PHASE declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_2_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_2_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
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
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_12_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_12_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }


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
