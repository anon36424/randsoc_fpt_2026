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



########## floating_point ##########
create_bd_cell -type hier ip_0_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_0_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Double CONFIG.add_sub_value Both CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_has_overflow 1 CONFIG.c_has_underflow 0 CONFIG.c_mult_usage No_Usage CONFIG.flow_control NonBlocking CONFIG.has_a_tlast 1 CONFIG.has_a_tuser 0 CONFIG.has_aclken 1 CONFIG.has_aresetn 0 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.maximum_latency 1 CONFIG.operation_type Square_root CONFIG.result_tlast_behv Pass_A_TLAST " [get_bd_cells ip_0_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_0_floating_point/aclk
connect_bd_net [get_bd_pins ip_0_floating_point/aclk] [get_bd_pins ip_0_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_floating_point/aclken
connect_bd_net [get_bd_pins ip_0_floating_point/aclken] [get_bd_pins ip_0_floating_point/floating_point_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_0_floating_point/S_AXIS_A] [get_bd_intf_pins ip_0_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_0_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_0_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_0_floating_point/floating_point_0/M_AXIS_RESULT]


########## emc ##########
create_bd_cell -type hier ip_1_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_1_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 4 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 6 CONFIG.C_TAVDV_PS_MEM_0 15425 CONFIG.C_TCEDV_PS_MEM_0 13856 CONFIG.C_THZCE_PS_MEM_0 6365 CONFIG.C_THZOE_PS_MEM_0 7687 CONFIG.C_TLZWE_PS_MEM_0 7545 CONFIG.C_TWC_PS_MEM_0 15585 CONFIG.C_TWPH_PS_MEM_0 11338 CONFIG.C_TWP_PS_MEM_0 10921 CONFIG.C_WR_REC_TIME_MEM_0 28450 " [get_bd_cells ip_1_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_1_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_1_emc/EMC_INTF] [get_bd_intf_pins ip_1_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_1_emc/clk
connect_bd_net [get_bd_pins ip_1_emc/clk] [get_bd_pins ip_1_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_emc/rdclk
connect_bd_net [get_bd_pins ip_1_emc/rdclk] [get_bd_pins ip_1_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_emc/rst
connect_bd_net [get_bd_pins ip_1_emc/rst] [get_bd_pins ip_1_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_emc/AXI] [get_bd_intf_pins ip_1_emc/emc_0/S_AXI_MEM]


########## dft ##########
create_bd_cell -type hier ip_2_dft
create_bd_cell -type ip -vlnv xilinx.com:ip:dft:4.2 dft_0
move_bd_cells [get_bd_cells ip_2_dft] [get_bd_cells dft_0]
set_property -dict "CONFIG.Clock_Enable 0 CONFIG.Data_Width 17 CONFIG.Speed_Optimization Speed CONFIG.Support_Size_1536 0 CONFIG.Support_Size_5G 0 CONFIG.Synchronous_Clear 0 " [get_bd_cells ip_2_dft/dft_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/CLK
connect_bd_net [get_bd_pins ip_2_dft/CLK] [get_bd_pins ip_2_dft/dft_0/CLK]
create_bd_pin -dir I -from 16 -to 0 ip_2_dft/XN_RE
connect_bd_net [get_bd_pins ip_2_dft/XN_RE] [get_bd_pins ip_2_dft/dft_0/XN_RE]
create_bd_pin -dir I -from 16 -to 0 ip_2_dft/XN_IM
connect_bd_net [get_bd_pins ip_2_dft/XN_IM] [get_bd_pins ip_2_dft/dft_0/XN_IM]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/FD_IN
connect_bd_net [get_bd_pins ip_2_dft/FD_IN] [get_bd_pins ip_2_dft/dft_0/FD_IN]
create_bd_pin -dir I -from 0 -to 0 ip_2_dft/FWD_INV
connect_bd_net [get_bd_pins ip_2_dft/FWD_INV] [get_bd_pins ip_2_dft/dft_0/FWD_INV]
create_bd_pin -dir I -from 5 -to 0 ip_2_dft/SIZE
connect_bd_net [get_bd_pins ip_2_dft/SIZE] [get_bd_pins ip_2_dft/dft_0/SIZE]
create_bd_pin -dir O -from 0 -to 0 ip_2_dft/RFFD
connect_bd_net [get_bd_pins ip_2_dft/RFFD] [get_bd_pins ip_2_dft/dft_0/RFFD]
create_bd_pin -dir O -from 16 -to 0 ip_2_dft/XK_RE
connect_bd_net [get_bd_pins ip_2_dft/XK_RE] [get_bd_pins ip_2_dft/dft_0/XK_RE]
create_bd_pin -dir O -from 16 -to 0 ip_2_dft/XK_IM
connect_bd_net [get_bd_pins ip_2_dft/XK_IM] [get_bd_pins ip_2_dft/dft_0/XK_IM]
create_bd_pin -dir O -from 3 -to 0 ip_2_dft/BLK_EXP
connect_bd_net [get_bd_pins ip_2_dft/BLK_EXP] [get_bd_pins ip_2_dft/dft_0/BLK_EXP]
create_bd_pin -dir O -from 0 -to 0 ip_2_dft/FD_OUT
connect_bd_net [get_bd_pins ip_2_dft/FD_OUT] [get_bd_pins ip_2_dft/dft_0/FD_OUT]
create_bd_pin -dir O -from 0 -to 0 ip_2_dft/DATA_VALID
connect_bd_net [get_bd_pins ip_2_dft/DATA_VALID] [get_bd_pins ip_2_dft/dft_0/DATA_VALID]


########## emc ##########
create_bd_cell -type hier ip_3_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_3_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 64 CONFIG.C_MEM1_TYPE 4 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 2 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 13 CONFIG.C_TAVDV_PS_MEM_0 15486 CONFIG.C_TAVDV_PS_MEM_1 16235 CONFIG.C_TCEDV_PS_MEM_0 16226 CONFIG.C_TCEDV_PS_MEM_1 14620 CONFIG.C_THZCE_PS_MEM_0 7565 CONFIG.C_THZCE_PS_MEM_1 7413 CONFIG.C_THZOE_PS_MEM_0 7587 CONFIG.C_THZOE_PS_MEM_1 6800 CONFIG.C_TLZWE_PS_MEM_0 4870 CONFIG.C_TLZWE_PS_MEM_1 1265 CONFIG.C_TWC_PS_MEM_0 16239 CONFIG.C_TWC_PS_MEM_1 15563 CONFIG.C_TWPH_PS_MEM_0 12587 CONFIG.C_TWPH_PS_MEM_1 11189 CONFIG.C_TWP_PS_MEM_0 12593 CONFIG.C_TWP_PS_MEM_1 13072 CONFIG.C_WR_REC_TIME_MEM_0 24559 CONFIG.C_WR_REC_TIME_MEM_1 25445 " [get_bd_cells ip_3_emc/emc_0]
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


########## conv_encoder ##########
create_bd_cell -type hier ip_4_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_4_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 3 CONFIG.convolution_code0 3 CONFIG.convolution_code1 7 CONFIG.convolution_code2 6 CONFIG.convolution_code3 0 CONFIG.convolution_code4 5 CONFIG.convolution_code5 3 CONFIG.convolution_code6 0 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 2 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_4_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_4_conv_encoder/aclk] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aclken
connect_bd_net [get_bd_pins ip_4_conv_encoder/aclken] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aclken]
create_bd_pin -dir I -from 0 -to 0 ip_4_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_4_conv_encoder/aresetn] [get_bd_pins ip_4_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_4_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## axi_dma ##########
create_bd_cell -type hier ip_5_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_5_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 40 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 1 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 8 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 8 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 128 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 256 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 9 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 16 " [get_bd_cells ip_5_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_5_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_5_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_5_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_5_axi_dma/axi_resetn] [get_bd_pins ip_5_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_5_axi_dma/mm2s_introut] [get_bd_pins ip_5_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_5_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_5_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_5_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_5_axi_dma/s2mm_introut] [get_bd_pins ip_5_axi_dma/axi_dma_0/s2mm_introut]


########## gpio ##########
create_bd_cell -type hier ip_6_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_6_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_ALL_OUTPUTS_2 1 CONFIG.C_DOUT_DEFAULT 0xff CONFIG.C_DOUT_DEFAULT_2 0x60 CONFIG.C_GPIO2_WIDTH 28 CONFIG.C_GPIO_WIDTH 8 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 " [get_bd_cells ip_6_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/GPIO] [get_bd_intf_pins ip_6_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/GPIO2] [get_bd_intf_pins ip_6_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/clk
connect_bd_net [get_bd_pins ip_6_gpio/clk] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_gpio/rst
connect_bd_net [get_bd_pins ip_6_gpio/rst] [get_bd_pins ip_6_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_6_gpio/gpio_0/S_AXI]


########## axi_iic ##########
create_bd_cell -type hier ip_7_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_7_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x39 CONFIG.C_GPO_WIDTH 2 CONFIG.C_SCL_INERTIAL_DELAY 150 CONFIG.C_SDA_INERTIAL_DELAY 122 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 149.15855222912862 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_7_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic/IIC] [get_bd_intf_pins ip_7_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_iic/clk
connect_bd_net [get_bd_pins ip_7_axi_iic/clk] [get_bd_pins ip_7_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi_iic/reset
connect_bd_net [get_bd_pins ip_7_axi_iic/reset] [get_bd_pins ip_7_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_7_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_7_axi_iic/irq
connect_bd_net [get_bd_pins ip_7_axi_iic/irq] [get_bd_pins ip_7_axi_iic/axi_iic_0/iic2intc_irpt]


########## microblaze ##########
create_bd_cell -type hier ip_8_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 48 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 7 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 4 CONFIG.C_MMU_ITLB_SIZE 1 CONFIG.C_MMU_PRIVILEGED_INSTR 0 CONFIG.C_MMU_TLB_ACCESS 3 CONFIG.C_MMU_ZONES 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 1 CONFIG.C_OPCODE_0x0_ILLEGAL 1 CONFIG.C_PVR 1 CONFIG.C_PVR_USER1 0x8a CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 0 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MMU 3 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_8_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_8_microblaze/Clk
connect_bd_net [get_bd_pins ip_8_microblaze/Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_8_microblaze/Reset
connect_bd_net [get_bd_pins ip_8_microblaze/Reset] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_8_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/INTERRUPT] [get_bd_intf_pins ip_8_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/M_AXI_DP] [get_bd_intf_pins ip_8_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_8_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_8_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x4aa6f1e2e0117da CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_8_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_8_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_8_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_8_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xe3942f88a4cb9ba CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_8_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_8_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_8_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_8_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_8_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_8_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_8_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_8_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_8_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_8_microblaze/mem/BRAM_PORTB]


########## axi_iic ##########
create_bd_cell -type hier ip_9_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_9_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x10 CONFIG.C_GPO_WIDTH 3 CONFIG.C_SCL_INERTIAL_DELAY 176 CONFIG.C_SDA_INERTIAL_DELAY 179 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 648.5136362437219 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_9_axi_iic/axi_iic_0]
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


########## fft ##########
create_bd_cell -type hier ip_10_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_10_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 12 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_lite_burst_io CONFIG.run_time_configurable_transform_length 0 CONFIG.transform_length 4096 " [get_bd_cells ip_10_fft/fft_0]
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


########## complex_multiplier ##########
create_bd_cell -type hier ip_11_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_11_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 0 CONFIG.aportwidth 18 CONFIG.aresetn 0 CONFIG.bportwidth 56 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 1 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 57 CONFIG.outtlastbehv Pass_A_TLAST CONFIG.roundmode Truncate " [get_bd_cells ip_11_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_11_complex_multiplier/aclk] [get_bd_pins ip_11_complex_multiplier/cmpy_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_11_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_11_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_11_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## axi_iic ##########
create_bd_cell -type hier ip_12_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_12_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x47 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 38 CONFIG.C_SDA_INERTIAL_DELAY 14 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 737.0670788000268 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_12_axi_iic/axi_iic_0]
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
set_property -dict "CONFIG.channels 8 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 32768 " [get_bd_cells ip_13_fft/fft_0]
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


########## axi_quad_spi ##########
create_bd_cell -type hier ip_14_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_14_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 256 CONFIG.C_SPI_MEMORY 2 CONFIG.C_SPI_MODE 2 CONFIG.C_TYPE_OF_AXI4_INTERFACE 1 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 0 CONFIG.C_XIP_PERF_MODE 0 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_14_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_14_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_quad_spi/IIC] [get_bd_intf_pins ip_14_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_14_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_14_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_14_axi_quad_spi/clk4] [get_bd_pins ip_14_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_14_axi_quad_spi/reset4] [get_bd_pins ip_14_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_14_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_14_axi_quad_spi/irq] [get_bd_pins ip_14_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## axi_quad_spi ##########
create_bd_cell -type hier ip_15_axi_quad_spi
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
move_bd_cells [get_bd_cells ip_15_axi_quad_spi] [get_bd_cells axi_quad_spi_0]
set_property -dict "CONFIG.C_FIFO_DEPTH 16 CONFIG.C_SPI_MEMORY 4 CONFIG.C_SPI_MEM_ADDR_BITS 32 CONFIG.C_SPI_MODE 1 CONFIG.C_TYPE_OF_AXI4_INTERFACE 0 CONFIG.C_USE_STARTUP 0 CONFIG.C_XIP_MODE 1 CONFIG.C_XIP_PERF_MODE 1 CONFIG.FIFO_INCLUDED 1 CONFIG.Master_mode 1 " [get_bd_cells ip_15_axi_quad_spi/axi_quad_spi_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_15_axi_quad_spi/IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi/IIC] [get_bd_intf_pins ip_15_axi_quad_spi/axi_quad_spi_0/SPI_0]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/ext_spi_clk
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/ext_spi_clk] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/ext_spi_clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/clk
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/clk] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/reset
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/reset] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/clk4
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/clk4] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi4_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_quad_spi/reset4
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/reset4] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/s_axi4_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_quad_spi/AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_15_axi_quad_spi/axi_quad_spi_0/AXI_LITE]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_quad_spi/AXI_FULL
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_15_axi_quad_spi/axi_quad_spi_0/AXI_FULL]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_quad_spi/irq
connect_bd_net [get_bd_pins ip_15_axi_quad_spi/irq] [get_bd_pins ip_15_axi_quad_spi/axi_quad_spi_0/ip2intc_irpt]


########## uartlite ##########
create_bd_cell -type hier ip_16_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_16_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 115200 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Odd " [get_bd_cells ip_16_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_16_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_16_uartlite/UART] [get_bd_intf_pins ip_16_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_16_uartlite/clk
connect_bd_net [get_bd_pins ip_16_uartlite/clk] [get_bd_pins ip_16_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_uartlite/reset
connect_bd_net [get_bd_pins ip_16_uartlite/reset] [get_bd_pins ip_16_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_16_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_16_uartlite/AXI] [get_bd_intf_pins ip_16_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_16_uartlite/irq
connect_bd_net [get_bd_pins ip_16_uartlite/irq] [get_bd_pins ip_16_uartlite/uart_0/interrupt]


########## uartlite ##########
create_bd_cell -type hier ip_17_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_17_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 8 CONFIG.PARITY Odd " [get_bd_cells ip_17_uartlite/uart_0]
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


########## uartlite ##########
create_bd_cell -type hier ip_18_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_18_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 38400 CONFIG.C_DATA_BITS 7 CONFIG.PARITY Even " [get_bd_cells ip_18_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_18_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite/UART] [get_bd_intf_pins ip_18_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_18_uartlite/clk
connect_bd_net [get_bd_pins ip_18_uartlite/clk] [get_bd_pins ip_18_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_uartlite/reset
connect_bd_net [get_bd_pins ip_18_uartlite/reset] [get_bd_pins ip_18_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite/AXI] [get_bd_intf_pins ip_18_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_18_uartlite/irq
connect_bd_net [get_bd_pins ip_18_uartlite/irq] [get_bd_pins ip_18_uartlite/uart_0/interrupt]


########## conv_encoder ##########
create_bd_cell -type hier ip_19_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_19_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 4 CONFIG.convolution_code0 0 CONFIG.convolution_code1 4 CONFIG.convolution_code2 15 CONFIG.convolution_code3 4 CONFIG.convolution_code4 6 CONFIG.convolution_code5 9 CONFIG.convolution_code6 11 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 2 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_19_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_19_conv_encoder/aclk] [get_bd_pins ip_19_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_19_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_19_conv_encoder/aresetn] [get_bd_pins ip_19_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_19_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_19_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_19_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_19_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## complex_multiplier ##########
create_bd_cell -type hier ip_20_complex_multiplier
create_bd_cell -type ip -vlnv xilinx.com:ip:cmpy:6.0 cmpy_0
move_bd_cells [get_bd_cells ip_20_complex_multiplier] [get_bd_cells cmpy_0]
set_property -dict "CONFIG.aclken 1 CONFIG.aportwidth 38 CONFIG.aresetn 0 CONFIG.bportwidth 45 CONFIG.datatype Integer CONFIG.flowcontrol NonBlocking CONFIG.hasatlast 0 CONFIG.hasatuser 0 CONFIG.hasbtlast 0 CONFIG.hasbtuser 0 CONFIG.hasctrltlast 0 CONFIG.hasctrltuser 0 CONFIG.latencyconfig Automatic CONFIG.multtype Use_Luts CONFIG.optimizegoal Resources CONFIG.outputwidth 11 CONFIG.roundmode Truncate " [get_bd_cells ip_20_complex_multiplier/cmpy_0]
create_bd_pin -dir I -from 0 -to 0 ip_20_complex_multiplier/aclk
connect_bd_net [get_bd_pins ip_20_complex_multiplier/aclk] [get_bd_pins ip_20_complex_multiplier/cmpy_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_complex_multiplier/aclken
connect_bd_net [get_bd_pins ip_20_complex_multiplier/aclken] [get_bd_pins ip_20_complex_multiplier/cmpy_0/aclken]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_complex_multiplier/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_20_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/S_AXIS_A]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_complex_multiplier/S_AXIS_B
connect_bd_intf_net [get_bd_intf_pins ip_20_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/S_AXIS_B]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_20_complex_multiplier/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_20_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/M_AXIS_DOUT]


########## microblaze ##########
create_bd_cell -type hier ip_21_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_21_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 64 CONFIG.C_AREA_OPTIMIZED 2 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 6 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 1 CONFIG.C_I_LMB 1 CONFIG.C_OPCODE_0x0_ILLEGAL 0 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0xa5 CONFIG.C_PVR_USER2 0x7012e335 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 1 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 0 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 0 CONFIG.C_USE_INTERRUPT 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_21_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_microblaze/Clk
connect_bd_net [get_bd_pins ip_21_microblaze/Clk] [get_bd_pins ip_21_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_21_microblaze/Reset
connect_bd_net [get_bd_pins ip_21_microblaze/Reset] [get_bd_pins ip_21_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_21_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_21_microblaze/INTERRUPT] [get_bd_intf_pins ip_21_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_21_microblaze/M_AXI_DP] [get_bd_intf_pins ip_21_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_21_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_21_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_21_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_21_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_21_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_21_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_21_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_21_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_21_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x41dfa361b42c535 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_21_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_21_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_21_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_21_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_21_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_21_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_21_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_21_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_21_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_21_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_21_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_21_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_21_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_21_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_21_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_21_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x3a63d20c2c4b256 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_21_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_21_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_21_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_21_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_21_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_21_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_21_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_21_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_21_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_21_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_21_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_21_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_21_microblaze/mem/BRAM_PORTB]


########## conv_encoder ##########
create_bd_cell -type hier ip_22_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_22_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 0 CONFIG.constraint_length 9 CONFIG.convolution_code0 131 CONFIG.convolution_code1 263 CONFIG.convolution_code2 13 CONFIG.convolution_code3 125 CONFIG.convolution_code4 351 CONFIG.convolution_code5 65 CONFIG.convolution_code6 236 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 12 CONFIG.output_rate 20 CONFIG.puncture_code0 111101101110 CONFIG.puncture_code1 101111111111 CONFIG.punctured 1 CONFIG.tready 0 " [get_bd_cells ip_22_conv_encoder/conv_encoder_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_conv_encoder/aclk
connect_bd_net [get_bd_pins ip_22_conv_encoder/aclk] [get_bd_pins ip_22_conv_encoder/conv_encoder_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_conv_encoder/aresetn
connect_bd_net [get_bd_pins ip_22_conv_encoder/aresetn] [get_bd_pins ip_22_conv_encoder/conv_encoder_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_conv_encoder/S_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_22_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_22_conv_encoder/conv_encoder_0/S_AXIS_DATA]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_conv_encoder/M_AXIS_DATA
connect_bd_intf_net [get_bd_intf_pins ip_22_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_22_conv_encoder/conv_encoder_0/M_AXIS_DATA]


########## uartlite ##########
create_bd_cell -type hier ip_23_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_23_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 110 CONFIG.C_DATA_BITS 5 CONFIG.PARITY Odd " [get_bd_cells ip_23_uartlite/uart_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_23_uartlite/UART
connect_bd_intf_net [get_bd_intf_pins ip_23_uartlite/UART] [get_bd_intf_pins ip_23_uartlite/uart_0/UART]
create_bd_pin -dir I -from 0 -to 0 ip_23_uartlite/clk
connect_bd_net [get_bd_pins ip_23_uartlite/clk] [get_bd_pins ip_23_uartlite/uart_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_uartlite/reset
connect_bd_net [get_bd_pins ip_23_uartlite/reset] [get_bd_pins ip_23_uartlite/uart_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_23_uartlite/AXI
connect_bd_intf_net [get_bd_intf_pins ip_23_uartlite/AXI] [get_bd_intf_pins ip_23_uartlite/uart_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_23_uartlite/irq
connect_bd_net [get_bd_pins ip_23_uartlite/irq] [get_bd_pins ip_23_uartlite/uart_0/interrupt]


########## axi_iic ##########
create_bd_cell -type hier ip_24_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_24_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x2c CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 163 CONFIG.C_SDA_INERTIAL_DELAY 25 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 604.9188648572015 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_24_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_24_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_iic/IIC] [get_bd_intf_pins ip_24_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi_iic/clk
connect_bd_net [get_bd_pins ip_24_axi_iic/clk] [get_bd_pins ip_24_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axi_iic/reset
connect_bd_net [get_bd_pins ip_24_axi_iic/reset] [get_bd_pins ip_24_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_24_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_iic/AXI] [get_bd_intf_pins ip_24_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_24_axi_iic/irq
connect_bd_net [get_bd_pins ip_24_axi_iic/irq] [get_bd_pins ip_24_axi_iic/axi_iic_0/iic2intc_irpt]


########## reset ##########
create_bd_cell -type hier ip_25_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_25_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_reset/clk_in
connect_bd_net [get_bd_pins ip_25_reset/clk_in] [get_bd_pins ip_25_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_25_reset/reset_in
connect_bd_net [get_bd_pins ip_25_reset/reset_in] [get_bd_pins ip_25_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_25_reset/dcm_locked
connect_bd_net [get_bd_pins ip_25_reset/dcm_locked] [get_bd_pins ip_25_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_25_reset/mb_reset
connect_bd_net [get_bd_pins ip_25_reset/mb_reset] [get_bd_pins ip_25_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_25_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_25_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_25_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset] [get_bd_pins ip_25_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_25_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_25_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_26_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_26_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_in] [get_bd_pins ip_26_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_26_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_26_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_26_clk_wiz/reset
connect_bd_net [get_bd_pins ip_26_clk_wiz/reset] [get_bd_pins ip_26_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_26_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_locked] [get_bd_pins ip_26_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_27_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_27_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_27_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 14 " [get_bd_cells ip_27_intc/concat_0]
connect_bd_net [get_bd_pins ip_27_intc/concat_0/dout] [get_bd_pins ip_27_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/clk
connect_bd_net [get_bd_pins ip_27_intc/clk] [get_bd_pins ip_27_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/reset
connect_bd_net [get_bd_pins ip_27_intc/reset] [get_bd_pins ip_27_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_27_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_27_intc/AXI] [get_bd_intf_pins ip_27_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_0
connect_bd_net [get_bd_pins ip_27_intc/irq_0] [get_bd_pins ip_27_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_1
connect_bd_net [get_bd_pins ip_27_intc/irq_1] [get_bd_pins ip_27_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_2
connect_bd_net [get_bd_pins ip_27_intc/irq_2] [get_bd_pins ip_27_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_3
connect_bd_net [get_bd_pins ip_27_intc/irq_3] [get_bd_pins ip_27_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_4
connect_bd_net [get_bd_pins ip_27_intc/irq_4] [get_bd_pins ip_27_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_5
connect_bd_net [get_bd_pins ip_27_intc/irq_5] [get_bd_pins ip_27_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_6
connect_bd_net [get_bd_pins ip_27_intc/irq_6] [get_bd_pins ip_27_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_7
connect_bd_net [get_bd_pins ip_27_intc/irq_7] [get_bd_pins ip_27_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_8
connect_bd_net [get_bd_pins ip_27_intc/irq_8] [get_bd_pins ip_27_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_9
connect_bd_net [get_bd_pins ip_27_intc/irq_9] [get_bd_pins ip_27_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_10
connect_bd_net [get_bd_pins ip_27_intc/irq_10] [get_bd_pins ip_27_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_11
connect_bd_net [get_bd_pins ip_27_intc/irq_11] [get_bd_pins ip_27_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_12
connect_bd_net [get_bd_pins ip_27_intc/irq_12] [get_bd_pins ip_27_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_27_intc/irq_13
connect_bd_net [get_bd_pins ip_27_intc/irq_13] [get_bd_pins ip_27_intc/concat_0/In13]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_27_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_27_intc/irq] [get_bd_intf_pins ip_27_intc/intc_0/interrupt]


########## intc ##########
create_bd_cell -type hier ip_28_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_28_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_28_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 14 " [get_bd_cells ip_28_intc/concat_0]
connect_bd_net [get_bd_pins ip_28_intc/concat_0/dout] [get_bd_pins ip_28_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/clk
connect_bd_net [get_bd_pins ip_28_intc/clk] [get_bd_pins ip_28_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/reset
connect_bd_net [get_bd_pins ip_28_intc/reset] [get_bd_pins ip_28_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_28_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_28_intc/AXI] [get_bd_intf_pins ip_28_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_0
connect_bd_net [get_bd_pins ip_28_intc/irq_0] [get_bd_pins ip_28_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_1
connect_bd_net [get_bd_pins ip_28_intc/irq_1] [get_bd_pins ip_28_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_2
connect_bd_net [get_bd_pins ip_28_intc/irq_2] [get_bd_pins ip_28_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_3
connect_bd_net [get_bd_pins ip_28_intc/irq_3] [get_bd_pins ip_28_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_4
connect_bd_net [get_bd_pins ip_28_intc/irq_4] [get_bd_pins ip_28_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_5
connect_bd_net [get_bd_pins ip_28_intc/irq_5] [get_bd_pins ip_28_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_6
connect_bd_net [get_bd_pins ip_28_intc/irq_6] [get_bd_pins ip_28_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_7
connect_bd_net [get_bd_pins ip_28_intc/irq_7] [get_bd_pins ip_28_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_8
connect_bd_net [get_bd_pins ip_28_intc/irq_8] [get_bd_pins ip_28_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_9
connect_bd_net [get_bd_pins ip_28_intc/irq_9] [get_bd_pins ip_28_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_10
connect_bd_net [get_bd_pins ip_28_intc/irq_10] [get_bd_pins ip_28_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_11
connect_bd_net [get_bd_pins ip_28_intc/irq_11] [get_bd_pins ip_28_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_12
connect_bd_net [get_bd_pins ip_28_intc/irq_12] [get_bd_pins ip_28_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_28_intc/irq_13
connect_bd_net [get_bd_pins ip_28_intc/irq_13] [get_bd_pins ip_28_intc/concat_0/In13]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_28_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_28_intc/irq] [get_bd_intf_pins ip_28_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_29_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_29_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 2 CONFIG.NUM_SI 4 " [get_bd_cells ip_29_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_29_axi_legacy/clk
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_29_axi_legacy/reset
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_M0] [get_bd_intf_pins ip_29_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_M1] [get_bd_intf_pins ip_29_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_M2] [get_bd_intf_pins ip_29_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_M3] [get_bd_intf_pins ip_29_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S0] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_29_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_29_axi_legacy/AXI_S1] [get_bd_intf_pins ip_29_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_29_axi_legacy/clk] [get_bd_pins ip_29_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_29_axi_legacy/reset] [get_bd_pins ip_29_axi_legacy/axi_0/M01_ARESETN]


########## axi_legacy ##########
create_bd_cell -type hier ip_30_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_30_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 1 " [get_bd_cells ip_30_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_30_axi_legacy/clk
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_30_axi_legacy/reset
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_M0] [get_bd_intf_pins ip_30_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S0] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S1] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S2] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S3] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S4] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S5] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S6] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S7] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S8] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S9] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S10] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S11] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S12] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M12_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S13] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M13_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M13_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M13_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S14] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M14_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M14_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M14_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_30_axi_legacy/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_30_axi_legacy/AXI_S15] [get_bd_intf_pins ip_30_axi_legacy/axi_0/M15_AXI]
connect_bd_net [get_bd_pins ip_30_axi_legacy/clk] [get_bd_pins ip_30_axi_legacy/axi_0/M15_ACLK]
connect_bd_net [get_bd_pins ip_30_axi_legacy/reset] [get_bd_pins ip_30_axi_legacy/axi_0/M15_ARESETN]


########## axi_legacy ##########
create_bd_cell -type hier ip_31_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_31_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 1 CONFIG.NUM_SI 1 " [get_bd_cells ip_31_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi_legacy/clk
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_31_axi_legacy/reset
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_M0] [get_bd_intf_pins ip_31_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_31_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_31_axi_legacy/AXI_S0] [get_bd_intf_pins ip_31_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_31_axi_legacy/clk] [get_bd_pins ip_31_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_31_axi_legacy/reset] [get_bd_pins ip_31_axi_legacy/axi_0/M00_ARESETN]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_32_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_32_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_32_axis_broadcaster/axis_broadcaster_0]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_33_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_33_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_33_axis_broadcaster/axis_broadcaster_0]
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


########## axis_broadcaster ##########
create_bd_cell -type hier ip_34_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_34_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 3 " [get_bd_cells ip_34_axis_broadcaster/axis_broadcaster_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_34_axis_broadcaster/M_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2] [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]


########## axis_broadcaster ##########
create_bd_cell -type hier ip_35_axis_broadcaster
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0
move_bd_cells [get_bd_cells ip_35_axis_broadcaster] [get_bd_cells axis_broadcaster_0]
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_35_axis_broadcaster/axis_broadcaster_0]
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
set_property -dict "CONFIG.NUM_MI 2 " [get_bd_cells ip_37_axis_broadcaster/axis_broadcaster_0]
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


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_38_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_38_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_38_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_39_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_40_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 12 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_41_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 48 " [get_bd_cells ip_42_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 14 CONFIG.S_TDATA_NUM_BYTES 32 " [get_bd_cells ip_43_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 2 CONFIG.S_TDATA_NUM_BYTES 16 " [get_bd_cells ip_44_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aclk] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_44_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_44_axis_dwidth_converter/aresetn] [get_bd_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_44_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_45_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_45_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_45_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_45_axis_combiner/aclk] [get_bd_pins ip_45_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_45_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_45_axis_combiner/aresetn] [get_bd_pins ip_45_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_45_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_45_axis_combiner/M_AXIS] [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_46_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_46_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 10 CONFIG.S_TDATA_NUM_BYTES 10 " [get_bd_cells ip_46_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aclk] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_46_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_46_axis_dwidth_converter/aresetn] [get_bd_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_46_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_47_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_47_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 2 " [get_bd_cells ip_47_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_47_axis_combiner/aclk] [get_bd_pins ip_47_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_47_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_47_axis_combiner/aresetn] [get_bd_pins ip_47_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_47_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_47_axis_combiner/M_AXIS] [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_combiner ##########
create_bd_cell -type hier ip_48_axis_combiner
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0
move_bd_cells [get_bd_cells ip_48_axis_combiner] [get_bd_cells axis_combiner_0]
set_property -dict "CONFIG.NUM_SI 3 " [get_bd_cells ip_48_axis_combiner/axis_combiner_0]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_combiner/aclk
connect_bd_net [get_bd_pins ip_48_axis_combiner/aclk] [get_bd_pins ip_48_axis_combiner/axis_combiner_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_48_axis_combiner/aresetn
connect_bd_net [get_bd_pins ip_48_axis_combiner/aresetn] [get_bd_pins ip_48_axis_combiner/axis_combiner_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/S_AXIS_0
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S00_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/S_AXIS_1
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S01_AXIS]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/S_AXIS_2
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S02_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_48_axis_combiner/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_48_axis_combiner/M_AXIS] [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_49_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_49_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 6 " [get_bd_cells ip_49_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aclk] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_49_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_49_axis_dwidth_converter/aresetn] [get_bd_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_49_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_50_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_50_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 2 " [get_bd_cells ip_50_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_50_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_50_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_50_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 16 -to 0 ip_50_slice_and_concat/in_1
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_1
move_bd_cells [get_bd_cells ip_50_slice_and_concat] [get_bd_cells slice_1]
set_property -dict "CONFIG.DIN_FROM 15 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_50_slice_and_concat/slice_1]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_1] [get_bd_pins ip_50_slice_and_concat/slice_1/din]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/slice_1/dout] [get_bd_pins ip_50_slice_and_concat/concat/In1]


########## slice_and_concat ##########
create_bd_cell -type hier ip_51_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_51_slice_and_concat/out0
create_bd_pin -dir I -from 16 -to 0 ip_51_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_51_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 16 CONFIG.DIN_TO 16 CONFIG.DIN_WIDTH 17 " [get_bd_cells ip_51_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_51_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/out0] [get_bd_pins ip_51_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_52_slice_and_concat
create_bd_pin -dir O -from 16 -to 0 ip_52_slice_and_concat/out0
create_bd_pin -dir I -from 16 -to 0 ip_52_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_53_slice_and_concat
create_bd_pin -dir O -from 5 -to 0 ip_53_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_53_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_53_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_53_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 3 -to 0 ip_53_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_53_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_53_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_1] [get_bd_pins ip_53_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 0 -to 0 ip_53_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_2] [get_bd_pins ip_53_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_54_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_54_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_54_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_54_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 0 CONFIG.DIN_TO 0 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_54_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/in_0] [get_bd_pins ip_54_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_54_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_55_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_55_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_55_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_55_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 1 CONFIG.DIN_TO 1 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_55_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/in_0] [get_bd_pins ip_55_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_55_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_56_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_56_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_56_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_56_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 2 CONFIG.DIN_TO 2 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_56_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/in_0] [get_bd_pins ip_56_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_56_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_57_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_57_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_57_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_57_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 3 CONFIG.DIN_TO 3 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_57_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/in_0] [get_bd_pins ip_57_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_57_slice_and_concat/slice_0/dout]


########## slice_and_concat ##########
create_bd_cell -type hier ip_58_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_58_slice_and_concat/out0
create_bd_pin -dir I -from 4 -to 0 ip_58_slice_and_concat/in_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 slice_0
move_bd_cells [get_bd_cells ip_58_slice_and_concat] [get_bd_cells slice_0]
set_property -dict "CONFIG.DIN_FROM 4 CONFIG.DIN_TO 4 CONFIG.DIN_WIDTH 5 " [get_bd_cells ip_58_slice_and_concat/slice_0]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/in_0] [get_bd_pins ip_58_slice_and_concat/slice_0/din]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_58_slice_and_concat/slice_0/dout]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_25_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_26_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_1_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_1_emc_EMC_INTF] [get_bd_intf_pins ip_1_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_3_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_3_emc_EMC_INTF] [get_bd_intf_pins ip_3_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio_GPIO] [get_bd_intf_pins ip_6_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_6_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_6_gpio_GPIO2] [get_bd_intf_pins ip_6_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic_IIC] [get_bd_intf_pins ip_7_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_9_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_9_axi_iic_IIC] [get_bd_intf_pins ip_9_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_12_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_iic_IIC] [get_bd_intf_pins ip_12_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_14_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_quad_spi_IIC] [get_bd_intf_pins ip_14_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 ip_15_axi_quad_spi_IIC
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_quad_spi_IIC] [get_bd_intf_pins ip_15_axi_quad_spi/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_16_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_16_uartlite_UART] [get_bd_intf_pins ip_16_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_17_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_17_uartlite_UART] [get_bd_intf_pins ip_17_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_18_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_18_uartlite_UART] [get_bd_intf_pins ip_18_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_23_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_23_uartlite_UART] [get_bd_intf_pins ip_23_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_24_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_24_axi_iic_IIC] [get_bd_intf_pins ip_24_axi_iic/IIC]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_32_axis_broadcaster/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_5_axi_dma/M_AXIS_MM2S]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 0 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_51_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
create_bd_port -dir I -from 4 -to 0 control_I
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_54_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_55_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_56_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_57_slice_and_concat/in_0]
connect_bd_net [get_bd_pins control_I] [get_bd_pins ip_58_slice_and_concat/in_0]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_26_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_27_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_28_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_1_emc/rst]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_3_emc/rst]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_4_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_6_gpio/rst]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_iic/reset]
connect_bd_net [get_bd_pins ip_25_reset/mb_reset] [get_bd_pins ip_8_microblaze/Reset]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_9_axi_iic/reset]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_12_axi_iic/reset]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_quad_spi/reset]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_quad_spi/reset4]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_16_uartlite/reset]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_17_uartlite/reset]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_18_uartlite/reset]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_19_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/mb_reset] [get_bd_pins ip_21_microblaze/Reset]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_22_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_23_uartlite/reset]
connect_bd_net [get_bd_pins ip_25_reset/peripheral_areset_n] [get_bd_pins ip_24_axi_iic/reset]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_0_floating_point/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_1_emc/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_1_emc/rdclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_2_dft/CLK]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_3_emc/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_3_emc/rdclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_4_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_5_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_6_gpio/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_7_axi_iic/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_8_microblaze/Clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_9_axi_iic/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_10_fft/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_11_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_12_axi_iic/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_13_fft/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_14_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_14_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_15_axi_quad_spi/ext_spi_clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_15_axi_quad_spi/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_15_axi_quad_spi/clk4]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_16_uartlite/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_17_uartlite/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_18_uartlite/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_19_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_20_complex_multiplier/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_21_microblaze/Clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_22_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_23_uartlite/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_24_axi_iic/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_25_reset/clk_in]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_locked] [get_bd_pins ip_25_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_27_intc/irq_0] [get_bd_pins ip_5_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_27_intc/irq_1] [get_bd_pins ip_5_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_27_intc/irq_2] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_27_intc/irq_3] [get_bd_pins ip_9_axi_iic/irq]
connect_bd_net [get_bd_pins ip_27_intc/irq_4] [get_bd_pins ip_10_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_27_intc/irq_5] [get_bd_pins ip_12_axi_iic/irq]
connect_bd_net [get_bd_pins ip_27_intc/irq_6] [get_bd_pins ip_13_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_27_intc/irq_7] [get_bd_pins ip_14_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_27_intc/irq_8] [get_bd_pins ip_15_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_27_intc/irq_9] [get_bd_pins ip_16_uartlite/irq]
connect_bd_net [get_bd_pins ip_27_intc/irq_10] [get_bd_pins ip_17_uartlite/irq]
connect_bd_net [get_bd_pins ip_27_intc/irq_11] [get_bd_pins ip_18_uartlite/irq]
connect_bd_net [get_bd_pins ip_27_intc/irq_12] [get_bd_pins ip_23_uartlite/irq]
connect_bd_net [get_bd_pins ip_27_intc/irq_13] [get_bd_pins ip_24_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_microblaze/INTERRUPT] [get_bd_intf_pins ip_27_intc/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_0] [get_bd_pins ip_5_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_28_intc/irq_1] [get_bd_pins ip_5_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_28_intc/irq_2] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_3] [get_bd_pins ip_9_axi_iic/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_4] [get_bd_pins ip_10_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_28_intc/irq_5] [get_bd_pins ip_12_axi_iic/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_6] [get_bd_pins ip_13_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_28_intc/irq_7] [get_bd_pins ip_14_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_8] [get_bd_pins ip_15_axi_quad_spi/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_9] [get_bd_pins ip_16_uartlite/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_10] [get_bd_pins ip_17_uartlite/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_11] [get_bd_pins ip_18_uartlite/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_12] [get_bd_pins ip_23_uartlite/irq]
connect_bd_net [get_bd_pins ip_28_intc/irq_13] [get_bd_pins ip_24_axi_iic/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_microblaze/INTERRUPT] [get_bd_intf_pins ip_28_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_29_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_29_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_microblaze/M_AXI_DP] [get_bd_intf_pins ip_29_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_microblaze/M_AXI_DP] [get_bd_intf_pins ip_29_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axi_legacy/AXI_S0] [get_bd_intf_pins ip_30_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_emc/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_emc/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_30_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_gpio/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_axi_iic/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_iic/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_30_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_quad_spi/AXI_LITE] [get_bd_intf_pins ip_30_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_quad_spi/AXI_FULL] [get_bd_intf_pins ip_30_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_uartlite/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_uartlite/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_uartlite/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_uartlite/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axi_iic/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_27_intc/AXI] [get_bd_intf_pins ip_30_axi_legacy/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_29_axi_legacy/AXI_S1] [get_bd_intf_pins ip_31_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_28_intc/AXI] [get_bd_intf_pins ip_31_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_conv_encoder/M_AXIS_DATA] [get_bd_intf_pins ip_33_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_34_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_35_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/M_AXIS_DATA] [get_bd_intf_pins ip_36_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_complex_multiplier/M_AXIS_DOUT] [get_bd_intf_pins ip_37_axis_broadcaster/S_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_38_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_38_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_39_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_19_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_39_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_40_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_19_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_40_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_41_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_41_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_42_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_floating_point/S_AXIS_A] [get_bd_intf_pins ip_42_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_DATA] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_43_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_complex_multiplier/S_AXIS_B] [get_bd_intf_pins ip_43_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_44_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_44_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_45_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_35_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_46_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_45_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_46_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_36_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_47_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_37_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_DATA] [get_bd_intf_pins ip_47_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_0] [get_bd_intf_pins ip_32_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_1] [get_bd_intf_pins ip_33_axis_broadcaster/M_AXIS_2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_48_axis_combiner/S_AXIS_2] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_49_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_48_axis_combiner/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_complex_multiplier/S_AXIS_A] [get_bd_intf_pins ip_49_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_34_axis_broadcaster/M_AXIS_2]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/out0] [get_bd_pins ip_2_dft/XN_RE]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_0] [get_bd_pins ip_2_dft/RFFD]
connect_bd_net [get_bd_pins ip_50_slice_and_concat/in_1] [get_bd_pins ip_2_dft/XK_RE]
connect_bd_net [get_bd_pins ip_51_slice_and_concat/in_0] [get_bd_pins ip_2_dft/XK_RE]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_2_dft/XN_IM]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/in_0] [get_bd_pins ip_2_dft/XK_IM]
connect_bd_net [get_bd_pins ip_52_slice_and_concat/out0] [get_bd_pins ip_52_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/out0] [get_bd_pins ip_2_dft/SIZE]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_0] [get_bd_pins ip_2_dft/BLK_EXP]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_1] [get_bd_pins ip_2_dft/FD_OUT]
connect_bd_net [get_bd_pins ip_53_slice_and_concat/in_2] [get_bd_pins ip_2_dft/DATA_VALID]
connect_bd_net [get_bd_pins ip_54_slice_and_concat/out0] [get_bd_pins ip_0_floating_point/aclken]
connect_bd_net [get_bd_pins ip_55_slice_and_concat/out0] [get_bd_pins ip_2_dft/FD_IN]
connect_bd_net [get_bd_pins ip_56_slice_and_concat/out0] [get_bd_pins ip_4_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_57_slice_and_concat/out0] [get_bd_pins ip_2_dft/FWD_INV]
connect_bd_net [get_bd_pins ip_58_slice_and_concat/out0] [get_bd_pins ip_20_complex_multiplier/aclken]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_29_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_30_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_31_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_32_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_33_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_34_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_35_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_36_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_37_axis_broadcaster/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_38_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_39_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_40_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_41_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_42_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_43_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_44_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_45_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_46_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_47_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_48_axis_combiner/aresetn]
connect_bd_net [get_bd_pins ip_25_reset/interconnect_aresetn] [get_bd_pins ip_49_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_27_intc/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_28_intc/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_29_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_30_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_31_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_32_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_33_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_34_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_35_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_36_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_37_axis_broadcaster/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_38_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_39_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_40_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_41_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_42_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_43_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_44_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_45_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_46_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_47_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_48_axis_combiner/aclk]
connect_bd_net [get_bd_pins ip_26_clk_wiz/clk_out] [get_bd_pins ip_49_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_floating_point/S_AXIS_A declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_floating_point/S_AXIS_A declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_0_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_0_floating_point/M_AXIS_RESULT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_0_floating_point/M_AXIS_RESULT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_MM2S declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/M_AXIS_MM2S declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_5_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/S_AXIS_S2MM declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_5_axi_dma/S_AXIS_S2MM declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 36 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=36 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=36 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/S_AXIS_A declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/S_AXIS_A declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/S_AXIS_B declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/S_AXIS_B declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/M_AXIS_DOUT declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_complex_multiplier/M_AXIS_DOUT declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/M_AXIS_DATA declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_13_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 43 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=43 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_13_fft/S_AXIS_CONFIG declared=43 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/S_AXIS_A declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/S_AXIS_A declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/S_AXIS_B]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/S_AXIS_B declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/S_AXIS_B declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_complex_multiplier/cmpy_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/M_AXIS_DOUT declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_complex_multiplier/M_AXIS_DOUT declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_conv_encoder/conv_encoder_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_conv_encoder/S_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_conv_encoder/S_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_conv_encoder/conv_encoder_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_conv_encoder/M_AXIS_DATA declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_conv_encoder/M_AXIS_DATA declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_32_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_32_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_33_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_33_axis_broadcaster/M_AXIS_2 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/S_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_0 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_1 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_34_axis_broadcaster/axis_broadcaster_0/M02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_34_axis_broadcaster/M_AXIS_2 declared=32 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/S_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_0 declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_36_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_36_axis_broadcaster/M_AXIS_1 declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M00_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_0 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_37_axis_broadcaster/axis_broadcaster_0/M01_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_37_axis_broadcaster/M_AXIS_1 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_38_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_38_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
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
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_39_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_40_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_40_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_41_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_41_axis_dwidth_converter/M_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/S_AXIS declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_42_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_42_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/S_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_43_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 112 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=112 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_43_axis_dwidth_converter/M_AXIS declared=112 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/S_AXIS declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_44_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 16 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=16 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_44_axis_dwidth_converter/M_AXIS declared=16 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_2 declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/S_AXIS_2 declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_45_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_45_axis_combiner/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/S_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_46_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 80 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=80 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_46_axis_dwidth_converter/M_AXIS declared=80 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_0 declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_0 declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 128 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_1 declared=128 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/S_AXIS_1 declared=128 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_47_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 384 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/M_AXIS declared=384 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_47_axis_combiner/M_AXIS declared=384 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S00_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_0 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_0 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S01_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_1 declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_1 declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/S02_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_2 declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/S_AXIS_2 declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_48_axis_combiner/axis_combiner_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_48_axis_combiner/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/S_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_49_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_49_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }


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
