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



########## cordic ##########
create_bd_cell -type hier ip_0_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_0_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tanh CONFIG.Input_Width 29 CONFIG.Iterations 41 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 26 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 0 CONFIG.Round_Mode Round_Pos_Neg_Inf " [get_bd_cells ip_0_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_cordic/aclk
connect_bd_net [get_bd_pins ip_0_cordic/aclk] [get_bd_pins ip_0_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]


########## complex_multiplier ##########
create_bd_cell -type hier ip_1_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_1_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 16 CONFIG.aresetn 0 CONFIG.bportwidth 13 CONFIG.btuserwidth 247 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Manual CONFIG.minimumlatency 5 CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 27 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_1_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aclk] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_1_complex_multiplier/aclken] [get_bd_pins ip_1_complex_multiplier/cmpy_0/aclken]
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
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_SYNCH_PIPEDELAY_1 1 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 4 CONFIG.C_TAVDV_PS_MEM_0 14477 CONFIG.C_TCEDV_PS_MEM_0 13633 CONFIG.C_THZCE_PS_MEM_0 6485 CONFIG.C_THZOE_PS_MEM_0 7227 CONFIG.C_TLZWE_PS_MEM_0 7265 CONFIG.C_TWC_PS_MEM_0 14784 CONFIG.C_TWPH_PS_MEM_0 11909 CONFIG.C_TWP_PS_MEM_0 13033 CONFIG.C_WR_REC_TIME_MEM_0 26271 " [get_bd_cells ip_2_emc/emc_0]
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


########## complex_multiplier ##########
create_bd_cell -type hier ip_3_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_3_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 59 CONFIG.aresetn 1 CONFIG.bportwidth 35 CONFIG.btuserwidth 138 CONFIG.datatype Integer CONFIG.flowcontrol Blocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 20 CONFIG.roundmode Truncate " [get_bd_cells ip_3_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_3_complex_multiplier/aclk] [get_bd_pins ip_3_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_3_complex_multiplier/aclken] [get_bd_pins ip_3_complex_multiplier/cmpy_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_3_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_3_complex_multiplier/aresetn] [get_bd_pins ip_3_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_3_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## dft ##########
create_bd_cell -type hier ip_4_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_4_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 1 CONFIG.Data_Width 11 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_5G 1 CONFIG.Synchronous_Clear 1 " [get_bd_cells ip_4_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CLK
connect_bd_net [get_bd_pins ip_4_dft/CLK] [get_bd_pins ip_4_dft/dft_0/CLK]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/CE
connect_bd_net [get_bd_pins ip_4_dft/CE] [get_bd_pins ip_4_dft/dft_0/CE]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/SCLR
connect_bd_net [get_bd_pins ip_4_dft/SCLR] [get_bd_pins ip_4_dft/dft_0/SCLR]
create_bd_pin -dir I -from 10 -to 0 ip_4_dft/XN_RE
connect_bd_net [get_bd_pins ip_4_dft/XN_RE] [get_bd_pins ip_4_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 10 -to 0 ip_4_dft/XN_IM
connect_bd_net [get_bd_pins ip_4_dft/XN_IM] [get_bd_pins ip_4_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FD_IN
connect_bd_net [get_bd_pins ip_4_dft/FD_IN] [get_bd_pins ip_4_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_4_dft/FWD_INV
connect_bd_net [get_bd_pins ip_4_dft/FWD_INV] [get_bd_pins ip_4_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_4_dft/SIZE
connect_bd_net [get_bd_pins ip_4_dft/SIZE] [get_bd_pins ip_4_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/RFFD
connect_bd_net [get_bd_pins ip_4_dft/RFFD] [get_bd_pins ip_4_dft/dft_0/RFFD]
create_bd_pin -dir O -from 10 -to 0 ip_4_dft/XK_RE
connect_bd_net [get_bd_pins ip_4_dft/XK_RE] [get_bd_pins ip_4_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 10 -to 0 ip_4_dft/XK_IM
connect_bd_net [get_bd_pins ip_4_dft/XK_IM] [get_bd_pins ip_4_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_4_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_4_dft/BLK_EXP] [get_bd_pins ip_4_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/FD_OUT
connect_bd_net [get_bd_pins ip_4_dft/FD_OUT] [get_bd_pins ip_4_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_4_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_4_dft/DATA_VALID] [get_bd_pins ip_4_dft/dft_0/DATA_VALID]


########## emc ##########
create_bd_cell -type hier ip_5_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_5_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 3 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 3 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 3 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 13 CONFIG.C_TAVDV_PS_MEM_0 15157 CONFIG.C_TAVDV_PS_MEM_1 14514 CONFIG.C_TAVDV_PS_MEM_2 15684 CONFIG.C_TCEDV_PS_MEM_0 14623 CONFIG.C_TCEDV_PS_MEM_1 15655 CONFIG.C_TCEDV_PS_MEM_2 15398 CONFIG.C_THZCE_PS_MEM_0 6816 CONFIG.C_THZCE_PS_MEM_1 6412 CONFIG.C_THZCE_PS_MEM_2 7639 CONFIG.C_THZOE_PS_MEM_0 7428 CONFIG.C_THZOE_PS_MEM_1 7061 CONFIG.C_THZOE_PS_MEM_2 7694 CONFIG.C_TLZWE_PS_MEM_0 5643 CONFIG.C_TLZWE_PS_MEM_1 2245 CONFIG.C_TLZWE_PS_MEM_2 4944 CONFIG.C_TWC_PS_MEM_0 15470 CONFIG.C_TWC_PS_MEM_1 14179 CONFIG.C_TWC_PS_MEM_2 16141 CONFIG.C_TWPH_PS_MEM_0 11212 CONFIG.C_TWPH_PS_MEM_1 11410 CONFIG.C_TWPH_PS_MEM_2 11878 CONFIG.C_TWP_PS_MEM_0 12599 CONFIG.C_TWP_PS_MEM_1 12483 CONFIG.C_TWP_PS_MEM_2 11300 CONFIG.C_WR_REC_TIME_MEM_0 28114 CONFIG.C_WR_REC_TIME_MEM_1 24701 CONFIG.C_WR_REC_TIME_MEM_2 25055 " [get_bd_cells ip_5_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_5_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_5_emc/EMC_INTF] [get_bd_intf_pins ip_5_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/clk
connect_bd_net [get_bd_pins ip_5_emc/clk] [get_bd_pins ip_5_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/rdclk
connect_bd_net [get_bd_pins ip_5_emc/rdclk] [get_bd_pins ip_5_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_emc/rst
connect_bd_net [get_bd_pins ip_5_emc/rst] [get_bd_pins ip_5_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_5_emc/AXI] [get_bd_intf_pins ip_5_emc/emc_0/S_AXI_MEM]


########## axi_cdma ##########
create_bd_cell -type hier ip_6_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_6_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 47 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 512 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_6_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_6_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_6_axi_cdma/m_axi_aclk] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_6_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_6_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_axi_cdma/M_AXI] [get_bd_intf_pins ip_6_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_6_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_6_axi_cdma/cdma_introut] [get_bd_pins ip_6_axi_cdma/axi_cdma_0/cdma_introut]


########## fft ##########
create_bd_cell -type hier ip_7_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_7_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 12 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 1024 " [get_bd_cells ip_7_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_fft/aclk
connect_bd_net [get_bd_pins ip_7_fft/aclk] [get_bd_pins ip_7_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_7_fft/event_frame_started
connect_bd_net [get_bd_pins ip_7_fft/event_frame_started] [get_bd_pins ip_7_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_7_fft/S_AXIS_DATA] [get_bd_intf_pins ip_7_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_7_fft/M_AXIS_DATA] [get_bd_intf_pins ip_7_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_7_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_7_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_7_fft/fft_0/S_AXIS_CONFIG]


########## floating_point ##########
create_bd_cell -type hier ip_8_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_8_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.a_tuser_width 52 CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 1 CONFIG.c_mult_usage Full_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 1 CONFIG.has_aclken 0 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Exponential " [get_bd_cells ip_8_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_floating_point/aclk
connect_bd_net [get_bd_pins ip_8_floating_point/aclk] [get_bd_pins ip_8_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_floating_point/aresetn
connect_bd_net [get_bd_pins ip_8_floating_point/aresetn] [get_bd_pins ip_8_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_8_floating_point/S_AXIS_A] [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_8_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_8_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_8_floating_point/floating_point_0/M_AXIS_RESULT]


########## complex_multiplier ##########
create_bd_cell -type hier ip_9_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_9_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 23 CONFIG.aresetn 1 CONFIG.bportwidth 48 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Performance CONFIG.outputwidth 39 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_9_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_9_complex_multiplier/aclk] [get_bd_pins ip_9_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_9_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_9_complex_multiplier/aclken] [get_bd_pins ip_9_complex_multiplier/cmpy_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_9_complex_multiplier/aresetn
connect_bd_net [get_bd_pins ip_9_complex_multiplier/aresetn] [get_bd_pins ip_9_complex_multiplier/cmpy_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_9_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_9_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_9_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_9_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_9_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_9_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_cdma ##########
create_bd_cell -type hier ip_10_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_10_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 50 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_10_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_10_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_10_axi_cdma/m_axi_aclk] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_10_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_10_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_axi_cdma/M_AXI] [get_bd_intf_pins ip_10_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_10_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_10_axi_cdma/cdma_introut] [get_bd_pins ip_10_axi_cdma/axi_cdma_0/cdma_introut]


########## microblaze ##########
create_bd_cell -type hier ip_11_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 52 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 1 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_DIV_ZERO_EXCEPTION 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 8 CONFIG.C_MMU_ITLB_SIZE 8 CONFIG.C_MMU_PRIVILEGED_INSTR 0 CONFIG.C_MMU_TLB_ACCESS 1 CONFIG.C_MMU_ZONES 3 CONFIG.C_NUMBER_OF_PC_BRK 2 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 0 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 1 CONFIG.C_OPCODE_0x0_ILLEGAL 1 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0x73 CONFIG.C_PVR_USER2 0x87edb42e CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 0 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MMU 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_11_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_microblaze/Clk
connect_bd_net [get_bd_pins ip_11_microblaze/Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_11_microblaze/Reset
connect_bd_net [get_bd_pins ip_11_microblaze/Reset] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_11_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/INTERRUPT] [get_bd_intf_pins ip_11_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/M_AXI_DP] [get_bd_intf_pins ip_11_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_11_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_11_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x5157ba7bf67cb95 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_11_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_11_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_11_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_11_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x703d2d711592d6b CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_11_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_11_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_11_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_11_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_11_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_11_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_11_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_11_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_11_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 3 " [get_bd_cells ip_11_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_11_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_11_microblaze/microblaze_0/DEBUG]


########## axi_iic ##########
create_bd_cell -type hier ip_12_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_12_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x15 CONFIG.C_GPO_WIDTH 4 CONFIG.C_SCL_INERTIAL_DELAY 40 CONFIG.C_SDA_INERTIAL_DELAY 82 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 925.713038453177 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_12_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_12_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic/IIC] [get_bd_intf_pins ip_12_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_iic/clk
connect_bd_net [get_bd_pins ip_12_axi_iic/clk] [get_bd_pins ip_12_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_iic/reset
connect_bd_net [get_bd_pins ip_12_axi_iic/reset] [get_bd_pins ip_12_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic/AXI] [get_bd_intf_pins ip_12_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_iic/irq
connect_bd_net [get_bd_pins ip_12_axi_iic/irq] [get_bd_pins ip_12_axi_iic/axi_iic_0/iic2intc_irpt]


########## fft ##########
create_bd_cell -type hier ip_13_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_13_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 3 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 4096 " [get_bd_cells ip_13_fft/fft_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_fft/aclk
connect_bd_net [get_bd_pins ip_13_fft/aclk] [get_bd_pins ip_13_fft/fft_0/aclk]
create_bd_pin -dir O -from 0 -to 0 ip_13_fft/event_frame_started
connect_bd_net [get_bd_pins ip_13_fft/event_frame_started] [get_bd_pins ip_13_fft/fft_0/event_frame_started]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/S_AXIS_DATA] [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/M_AXIS_DATA] [get_bd_intf_pins ip_13_fft/fft_0/M_AXIS_DATA]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_fft/S_AXIS_CONFIG
connect_bd_intf_net [get_bd_intf_pins ip_13_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_CONFIG]


########## uartlite ##########
create_bd_cell -type hier ip_14_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_14_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Odd " [get_bd_cells ip_14_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_14_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_14_uartlite/UART] [get_bd_intf_pins ip_14_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_14_uartlite/clk
connect_bd_net [get_bd_pins ip_14_uartlite/clk] [get_bd_pins ip_14_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_uartlite/reset
connect_bd_net [get_bd_pins ip_14_uartlite/reset] [get_bd_pins ip_14_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_14_uartlite/AXI] [get_bd_intf_pins ip_14_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_14_uartlite/irq
connect_bd_net [get_bd_pins ip_14_uartlite/irq] [get_bd_pins ip_14_uartlite/uart_0/interrupt]


########## gpio ##########
create_bd_cell -type hier ip_15_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_15_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x1ffff CONFIG.C_GPIO2_WIDTH 26 CONFIG.C_GPIO_WIDTH 17 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x1ffff CONFIG.C_TRI_DEFAULT_2 0x1ffff " [get_bd_cells ip_15_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_15_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_15_gpio/GPIO] [get_bd_intf_pins ip_15_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_15_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_15_gpio/GPIO2] [get_bd_intf_pins ip_15_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_15_gpio/clk
connect_bd_net [get_bd_pins ip_15_gpio/clk] [get_bd_pins ip_15_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_gpio/rst
connect_bd_net [get_bd_pins ip_15_gpio/rst] [get_bd_pins ip_15_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_15_gpio/AXI] [get_bd_intf_pins ip_15_gpio/gpio_0/S_AXI]


########## emc ##########
create_bd_cell -type hier ip_16_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_16_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 5 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 1 CONFIG.C_MEM1_WIDTH 32 CONFIG.C_MEM2_TYPE 4 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_MEM3_TYPE 1 CONFIG.C_MEM3_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 5 CONFIG.C_TAVDV_PS_MEM_0 15432 CONFIG.C_TAVDV_PS_MEM_1 14735 CONFIG.C_TAVDV_PS_MEM_2 14982 CONFIG.C_TAVDV_PS_MEM_3 14614 CONFIG.C_TCEDV_PS_MEM_0 15206 CONFIG.C_TCEDV_PS_MEM_1 15796 CONFIG.C_TCEDV_PS_MEM_2 16329 CONFIG.C_TCEDV_PS_MEM_3 13909 CONFIG.C_THZCE_PS_MEM_0 7595 CONFIG.C_THZCE_PS_MEM_1 7560 CONFIG.C_THZCE_PS_MEM_2 7400 CONFIG.C_THZCE_PS_MEM_3 7186 CONFIG.C_THZOE_PS_MEM_0 7240 CONFIG.C_THZOE_PS_MEM_1 6590 CONFIG.C_THZOE_PS_MEM_2 7417 CONFIG.C_THZOE_PS_MEM_3 6442 CONFIG.C_TLZWE_PS_MEM_0 6993 CONFIG.C_TLZWE_PS_MEM_1 7742 CONFIG.C_TLZWE_PS_MEM_2 7941 CONFIG.C_TLZWE_PS_MEM_3 8537 CONFIG.C_TWC_PS_MEM_0 15729 CONFIG.C_TWC_PS_MEM_1 15000 CONFIG.C_TWC_PS_MEM_2 14522 CONFIG.C_TWC_PS_MEM_3 16499 CONFIG.C_TWPH_PS_MEM_0 10912 CONFIG.C_TWPH_PS_MEM_1 12861 CONFIG.C_TWPH_PS_MEM_2 11254 CONFIG.C_TWPH_PS_MEM_3 11451 CONFIG.C_TWP_PS_MEM_0 11544 CONFIG.C_TWP_PS_MEM_1 12284 CONFIG.C_TWP_PS_MEM_2 11546 CONFIG.C_TWP_PS_MEM_3 12130 CONFIG.C_WR_REC_TIME_MEM_0 27040 CONFIG.C_WR_REC_TIME_MEM_1 27265 CONFIG.C_WR_REC_TIME_MEM_2 26971 CONFIG.C_WR_REC_TIME_MEM_3 25018 " [get_bd_cells ip_16_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_16_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_16_emc/EMC_INTF] [get_bd_intf_pins ip_16_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_16_emc/clk
connect_bd_net [get_bd_pins ip_16_emc/clk] [get_bd_pins ip_16_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_emc/rdclk
connect_bd_net [get_bd_pins ip_16_emc/rdclk] [get_bd_pins ip_16_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_emc/rst
connect_bd_net [get_bd_pins ip_16_emc/rst] [get_bd_pins ip_16_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_emc/AXI] [get_bd_intf_pins ip_16_emc/emc_0/S_AXI_MEM]


########## axi_hwicap ##########
create_bd_cell -type hier ip_17_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_17_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_BRAM_SRL_FIFO_TYPE 0 CONFIG.C_ICAP_DWIDTH 8 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 0 CONFIG.C_OPERATION 1 CONFIG.C_READ_FIFO_DEPTH 256 " [get_bd_cells ip_17_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_17_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_17_axi_hwicap/icap_clk] [get_bd_pins ip_17_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_17_axi_hwicap/eos_in] [get_bd_pins ip_17_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_17_axi_hwicap/s_axi_aclk] [get_bd_pins ip_17_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_17_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_17_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_17_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_17_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## emc ##########
create_bd_cell -type hier ip_18_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_18_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 2 CONFIG.C_MEM2_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 8 CONFIG.C_TAVDV_PS_MEM_0 16198 CONFIG.C_TAVDV_PS_MEM_1 15206 CONFIG.C_TAVDV_PS_MEM_2 13899 CONFIG.C_TCEDV_PS_MEM_0 15848 CONFIG.C_TCEDV_PS_MEM_1 15609 CONFIG.C_TCEDV_PS_MEM_2 15803 CONFIG.C_THZCE_PS_MEM_0 7427 CONFIG.C_THZCE_PS_MEM_1 6478 CONFIG.C_THZCE_PS_MEM_2 6567 CONFIG.C_THZOE_PS_MEM_0 6434 CONFIG.C_THZOE_PS_MEM_1 7310 CONFIG.C_THZOE_PS_MEM_2 6960 CONFIG.C_TLZWE_PS_MEM_0 9249 CONFIG.C_TLZWE_PS_MEM_1 9444 CONFIG.C_TLZWE_PS_MEM_2 6564 CONFIG.C_TWC_PS_MEM_0 14964 CONFIG.C_TWC_PS_MEM_1 15651 CONFIG.C_TWC_PS_MEM_2 14347 CONFIG.C_TWPH_PS_MEM_0 12732 CONFIG.C_TWPH_PS_MEM_1 11969 CONFIG.C_TWPH_PS_MEM_2 10887 CONFIG.C_TWP_PS_MEM_0 12692 CONFIG.C_TWP_PS_MEM_1 12126 CONFIG.C_TWP_PS_MEM_2 12662 CONFIG.C_WR_REC_TIME_MEM_0 25218 CONFIG.C_WR_REC_TIME_MEM_1 28642 CONFIG.C_WR_REC_TIME_MEM_2 26661 " [get_bd_cells ip_18_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_18_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_18_emc/EMC_INTF] [get_bd_intf_pins ip_18_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_18_emc/clk
connect_bd_net [get_bd_pins ip_18_emc/clk] [get_bd_pins ip_18_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_emc/rdclk
connect_bd_net [get_bd_pins ip_18_emc/rdclk] [get_bd_pins ip_18_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_emc/rst
connect_bd_net [get_bd_pins ip_18_emc/rst] [get_bd_pins ip_18_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_emc/AXI] [get_bd_intf_pins ip_18_emc/emc_0/S_AXI_MEM]


########## complex_multiplier ##########
create_bd_cell -type hier ip_19_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_19_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 17 CONFIG.aresetn 0 CONFIG.bportwidth 52 CONFIG.btuserwidth 6 CONFIG.ctrltuserwidth 234 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 1 CONFIG.hasctrltlast 1 CONFIG.hasctrltuser 1 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Mults CONFIG.optimizegoal Resources CONFIG.outputwidth 47 CONFIG.outtlastbehv AND_all_TLASTs CONFIG.roundmode Random_Rounding " [get_bd_cells ip_19_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_19_complex_multiplier/aclk] [get_bd_pins ip_19_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_19_complex_multiplier/aclken] [get_bd_pins ip_19_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_19_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_19_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_19_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_19_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_complex_multiplier/S_AXIS_CTRL
connect_bd_intf_net [get_bd_intf_pins ip_19_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_19_complex_multiplier/cmpy_0/S_AXIS_CTRL]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_19_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_19_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## reset ##########
create_bd_cell -type hier ip_20_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_20_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_reset/clk_in
connect_bd_net [get_bd_pins ip_20_reset/clk_in] [get_bd_pins ip_20_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_20_reset/reset_in
connect_bd_net [get_bd_pins ip_20_reset/reset_in] [get_bd_pins ip_20_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_20_reset/dcm_locked
connect_bd_net [get_bd_pins ip_20_reset/dcm_locked] [get_bd_pins ip_20_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_20_reset/mb_reset
connect_bd_net [get_bd_pins ip_20_reset/mb_reset] [get_bd_pins ip_20_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_20_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_20_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_20_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset] [get_bd_pins ip_20_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_20_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_20_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_21_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_21_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_in] [get_bd_pins ip_21_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_21_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_21_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_21_clk_wiz/reset
connect_bd_net [get_bd_pins ip_21_clk_wiz/reset] [get_bd_pins ip_21_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_21_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_locked] [get_bd_pins ip_21_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_22_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_22_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_22_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 7 " [get_bd_cells ip_22_intc/concat_0]
connect_bd_net [get_bd_pins ip_22_intc/concat_0/dout] [get_bd_pins ip_22_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/clk
connect_bd_net [get_bd_pins ip_22_intc/clk] [get_bd_pins ip_22_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/reset
connect_bd_net [get_bd_pins ip_22_intc/reset] [get_bd_pins ip_22_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_22_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_22_intc/AXI] [get_bd_intf_pins ip_22_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_0
connect_bd_net [get_bd_pins ip_22_intc/irq_0] [get_bd_pins ip_22_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_1
connect_bd_net [get_bd_pins ip_22_intc/irq_1] [get_bd_pins ip_22_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_2
connect_bd_net [get_bd_pins ip_22_intc/irq_2] [get_bd_pins ip_22_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_3
connect_bd_net [get_bd_pins ip_22_intc/irq_3] [get_bd_pins ip_22_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_4
connect_bd_net [get_bd_pins ip_22_intc/irq_4] [get_bd_pins ip_22_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_5
connect_bd_net [get_bd_pins ip_22_intc/irq_5] [get_bd_pins ip_22_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_22_intc/irq_6
connect_bd_net [get_bd_pins ip_22_intc/irq_6] [get_bd_pins ip_22_intc/concat_0/In6]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_22_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_22_intc/irq] [get_bd_intf_pins ip_22_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_23_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_23_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 11 CONFIG.NUM_SI 3 " [get_bd_cells ip_23_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_legacy/clk
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_23_axi_legacy/reset
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_M0] [get_bd_intf_pins ip_23_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_M1] [get_bd_intf_pins ip_23_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_M2] [get_bd_intf_pins ip_23_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S0] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S1] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S2] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S3] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S4] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S5] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S6] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S7] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S8] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S9] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_23_axi_legacy/AXI_S10] [get_bd_intf_pins ip_23_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_23_axi_legacy/clk] [get_bd_pins ip_23_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_23_axi_legacy/reset] [get_bd_pins ip_23_axi_legacy/axi_0/M10_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_24_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_24_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 4 " [get_bd_cells ip_24_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_24_axis_broadcaster/aclk] [get_bd_pins ip_24_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_24_axis_broadcaster/aresetn] [get_bd_pins ip_24_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M03_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_25_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_25_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_25_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_25_axis_broadcaster/aclk] [get_bd_pins ip_25_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_25_axis_broadcaster/aresetn] [get_bd_pins ip_25_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M01_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_26_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_26_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 5 " [get_bd_cells ip_26_axis_broadcaster/axis_broadcaster_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_broadcaster/aclk
connect_bd_net [get_bd_pins ip_26_axis_broadcaster/aclk] [get_bd_pins ip_26_axis_broadcaster/axis_broadcaster_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_broadcaster/aresetn
connect_bd_net [get_bd_pins ip_26_axis_broadcaster/aresetn] [get_bd_pins ip_26_axis_broadcaster/axis_broadcaster_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_0] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M00_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_1] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_3] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M03_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_broadcaster/M_AXIS_4
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_4] [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M04_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_27_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_27_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_27_axis_broadcaster/axis_broadcaster_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_30_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_30_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_30_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aclk] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_30_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_30_axis_dwidth_converter/aresetn] [get_bd_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_30_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_31_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_31_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_31_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aclk] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_31_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_31_axis_dwidth_converter/aresetn] [get_bd_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_31_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_32_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_32_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_32_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_33_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_34_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 48 " [get_bd_cells ip_35_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 4 " [get_bd_cells ip_36_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_37_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aclk] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_37_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_37_axis_dwidth_converter/aresetn] [get_bd_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_37_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_38_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_38_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_38_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_38_axis_combiner/aclk] [get_bd_pins ip_38_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_38_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_38_axis_combiner/aresetn] [get_bd_pins ip_38_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_38_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_38_axis_combiner/M_AXIS] [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_39_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_39_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 14 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
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


########## axis_combiner ##########
create_bd_cell -type hier ip_41_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_41_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_41_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_41_axis_combiner/aclk] [get_bd_pins ip_41_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_41_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_41_axis_combiner/aresetn] [get_bd_pins ip_41_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_41_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_41_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_41_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_41_axis_combiner/M_AXIS] [get_bd_intf_pins ip_41_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_42_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_42_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 16 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
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


########## axis_combiner ##########
create_bd_cell -type hier ip_44_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_44_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 5 " [get_bd_cells ip_44_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_44_axis_combiner/aclk] [get_bd_pins ip_44_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_44_axis_combiner/aresetn] [get_bd_pins ip_44_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_combiner/S_AXIS_3
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S03_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_combiner/S_AXIS_4
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_4] [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S04_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_combiner/M_AXIS] [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_45_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_45_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_45_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_46_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_46_slice_and_concat/out0
create_bd_pin -dir I -from 10 -to 0 ip_46_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_47_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_47_slice_and_concat/out0
create_bd_pin -dir I -from 10 -to 0 ip_47_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_47_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 5 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_47_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_47_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_47_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_48_slice_and_concat
create_bd_pin -dir O -from 10 -to 0 ip_48_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_48_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_48_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_48_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 10 -to 0 ip_48_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_48_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 10 CONFIG.DIN_TO 6 CONFIG.DIN_WIDTH 11 " [get_bd_cells ip_48_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_48_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/slice_0/dout] [get_bd_pins ip_48_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 3 -to 0 ip_48_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_1] [get_bd_pins ip_48_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_48_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_2] [get_bd_pins ip_48_slice_and_concat/concat/In2]
create_bd_pin -dir I -from 0 -to 0 ip_48_slice_and_concat/in_3
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_3] [get_bd_pins ip_48_slice_and_concat/concat/In3]


########## slice_and_concat ##########
create_bd_cell -type hier ip_49_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_49_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_49_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_49_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_49_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/in_0] [get_bd_pins ip_49_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_49_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_50_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_50_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_50_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_50_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_51_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_51_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_51_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_51_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_51_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_51_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_52_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_52_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_52_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_52_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_52_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_53_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_53_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_53_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_53_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_54_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_54_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_54_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_54_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_55_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_55_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_55_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_55_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_10_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_21_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_2_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_2_emc_EMC_INTF] [get_bd_intf_pins ip_2_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_5_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_5_emc_EMC_INTF] [get_bd_intf_pins ip_5_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_12_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic_IIC] [get_bd_intf_pins ip_12_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_14_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_14_uartlite_UART] [get_bd_intf_pins ip_14_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_15_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_15_gpio_GPIO] [get_bd_intf_pins ip_15_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_15_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_15_gpio_GPIO2] [get_bd_intf_pins ip_15_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_16_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_16_emc_EMC_INTF] [get_bd_intf_pins ip_16_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_18_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_18_emc_EMC_INTF] [get_bd_intf_pins ip_18_emc/EMC_INTF]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_30_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_36_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 4 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_49_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_50_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_51_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_52_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_53_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_54_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_55_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_21_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_22_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_2_emc/rst]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_3_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset] [get_bd_pins ip_4_dft/SCLR]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_5_emc/rst]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_8_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_9_complex_multiplier/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/mb_reset] [get_bd_pins ip_11_microblaze/Reset]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_iic/reset]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_14_uartlite/reset]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_15_gpio/rst]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_16_emc/rst]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_17_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_20_reset/peripheral_areset_n] [get_bd_pins ip_18_emc/rst]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_0_cordic/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_1_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_2_emc/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_2_emc/rdclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_3_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_4_dft/CLK]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_5_emc/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_5_emc/rdclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_6_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_6_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_7_fft/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_8_floating_point/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_9_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_10_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_10_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_11_microblaze/Clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_12_axi_iic/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_13_fft/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_14_uartlite/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_15_gpio/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_16_emc/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_16_emc/rdclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_17_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_17_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_18_emc/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_18_emc/rdclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_19_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_20_reset/clk_in]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_locked] [get_bd_pins ip_20_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_22_intc/irq_0] [get_bd_pins ip_6_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_22_intc/irq_1] [get_bd_pins ip_7_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_22_intc/irq_2] [get_bd_pins ip_10_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_22_intc/irq_3] [get_bd_pins ip_12_axi_iic/irq]
connect_bd_net [get_bd_pins ip_22_intc/irq_4] [get_bd_pins ip_13_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_22_intc/irq_5] [get_bd_pins ip_14_uartlite/irq]
connect_bd_net [get_bd_pins ip_22_intc/irq_6] [get_bd_pins ip_17_axi_hwicap/ip2intc_irpt]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_microblaze/INTERRUPT] [get_bd_intf_pins ip_22_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_cdma/M_AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_cdma/M_AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_microblaze/M_AXI_DP] [get_bd_intf_pins ip_23_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_emc/AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_emc/AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_23_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_23_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_iic/AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_uartlite/AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_gpio/AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_emc/AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_23_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_emc/AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_intc/AXI] [get_bd_intf_pins ip_23_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_24_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_25_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_26_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/M_AXIS_DATA] [get_bd_intf_pins ip_27_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_28_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_29_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_complex_multiplier/S_AXIS_CTRL] [get_bd_intf_pins ip_30_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_31_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_31_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_32_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_32_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_33_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_33_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_34_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_34_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_35_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_7_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_floating_point/S_AXIS_A] [get_bd_intf_pins ip_35_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_36_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_8_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_37_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_37_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_38_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_41_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_DATA] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_29_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_24_axis_broadcaster/M_AXIS_3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_25_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_26_axis_broadcaster/M_AXIS_4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_3] [get_bd_intf_pins ip_27_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_combiner/S_AXIS_4] [get_bd_intf_pins ip_28_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_fft/S_AXIS_DATA] [get_bd_intf_pins ip_44_axis_combiner/M_AXIS]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_17_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/in_0] [get_bd_pins ip_4_dft/RFFD]
connect_bd_net [get_bd_pins ip_45_slice_and_concat/out0] [get_bd_pins ip_45_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_IM]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_RE]
connect_bd_net [get_bd_pins ip_46_slice_and_concat/out0] [get_bd_pins ip_46_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/out0] [get_bd_pins ip_4_dft/SIZE]
connect_bd_net [get_bd_pins ip_47_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/out0] [get_bd_pins ip_4_dft/XN_RE]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_0] [get_bd_pins ip_4_dft/XK_IM]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_1] [get_bd_pins ip_4_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_2] [get_bd_pins ip_4_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_48_slice_and_concat/in_3] [get_bd_pins ip_4_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_49_slice_and_concat/out0] [get_bd_pins ip_4_dft/CE]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_4_dft/FD_IN]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_3_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_9_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_19_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_1_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_4_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_23_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_27_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_28_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_29_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_30_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_31_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_20_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_22_intc/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_23_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_24_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_25_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_26_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_27_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_28_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_29_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_30_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_31_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_32_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_33_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_34_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_35_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_36_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_37_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_38_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_41_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_21_clk_wiz/clk_out] [get_bd_pins ip_44_axis_combiner/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/S_AXIS_CARTESIAN declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_cordic/M_AXIS_DOUT declared=32 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_complex_multiplier/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_A declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_A declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_B declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/S_AXIS_B declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/M_AXIS_DOUT declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_complex_multiplier/M_AXIS_DOUT declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_fft/S_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_fft/S_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_fft/M_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_fft/M_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_7_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_7_fft/S_AXIS_CONFIG declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_7_fft/S_AXIS_CONFIG declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_8_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/M_AXIS_RESULT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_8_floating_point/M_AXIS_RESULT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_complex_multiplier/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_complex_multiplier/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_complex_multiplier/M_AXIS_DOUT declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_complex_multiplier/M_AXIS_DOUT declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_complex_multiplier/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_complex_multiplier/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_complex_multiplier/cmpy_0/S_AXIS_CTRL]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_complex_multiplier/S_AXIS_CTRL declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_complex_multiplier/S_AXIS_CTRL declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_19_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_19_complex_multiplier/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_19_complex_multiplier/M_AXIS_DOUT declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_1 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_1 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_2 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_2 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_3 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_broadcaster/M_AXIS_3 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_0 declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_0 declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_1 declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_broadcaster/M_AXIS_1 declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_1 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M03_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_3 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_3 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_broadcaster/axis_broadcaster_0/M04_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_4 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_broadcaster/M_AXIS_4 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_27_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_1 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_27_axis_broadcaster/M_AXIS_1 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_0 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_28_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_28_axis_broadcaster/M_AXIS_2 declared=64 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_30_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_30_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_31_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_31_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/S_AXIS declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_35_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_35_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_0 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_0 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_1 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/S_AXIS_1 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_combiner/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/S_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_39_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_combiner/S_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_combiner/S_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_combiner/S_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_combiner/S_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_combiner/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_combiner/M_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=128 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_0 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_0 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_1 declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_1 declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_2 declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_2 declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S03_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_3 declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_3 declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/S04_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_4 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/S_AXIS_4 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/M_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_combiner/M_AXIS declared=384 actual=ERR $__err" }


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
