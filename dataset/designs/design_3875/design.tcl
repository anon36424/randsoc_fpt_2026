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
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_GPIO_WIDTH 23 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_0_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/GPIO] [get_bd_intf_pins ip_0_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/clk
connect_bd_net [get_bd_pins ip_0_gpio/clk] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_gpio/rst
connect_bd_net [get_bd_pins ip_0_gpio/rst] [get_bd_pins ip_0_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_0_gpio/gpio_0/S_AXI]


########## axi_hwicap ##########
create_bd_cell -type hier ip_1_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_1_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 16 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 1 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 CONFIG.C_SHARED_STARTUP 0 " [get_bd_cells ip_1_axi_hwicap/axi_hwicap_0]
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


########## microblaze ##########
create_bd_cell -type hier ip_2_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_2_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 44 CONFIG.C_AREA_OPTIMIZED 1 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 1 CONFIG.C_FPU_EXCEPTION 0 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_M_AXI_D_BUS_EXCEPTION 1 CONFIG.C_M_AXI_I_BUS_EXCEPTION 0 CONFIG.C_NUMBER_OF_PC_BRK 4 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 1 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 4 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 1 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 2 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 0 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 0 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_2_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_2_microblaze/Clk
connect_bd_net [get_bd_pins ip_2_microblaze/Clk] [get_bd_pins ip_2_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_2_microblaze/Reset
connect_bd_net [get_bd_pins ip_2_microblaze/Reset] [get_bd_pins ip_2_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_2_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_2_microblaze/INTERRUPT] [get_bd_intf_pins ip_2_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_2_microblaze/M_AXI_DP] [get_bd_intf_pins ip_2_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_2_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_2_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_2_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_2_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_2_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_2_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_2_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_2_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_2_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x29c023326bf020e CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_2_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_2_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_2_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_2_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_2_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_2_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_2_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_2_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_2_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_2_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_2_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_2_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_2_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_2_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_2_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_2_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0x652b2c540ce6855 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_2_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_2_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_2_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_2_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_2_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_2_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_2_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_2_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_2_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_2_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_2_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_2_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_2_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_2_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 3 " [get_bd_cells ip_2_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_2_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_2_microblaze/microblaze_0/DEBUG]


########## cordic ##########
create_bd_cell -type hier ip_3_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_3_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Sinh_and_Cosh CONFIG.Input_Width 45 CONFIG.Iterations 47 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 42 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 43 CONFIG.Round_Mode Truncate " [get_bd_cells ip_3_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_3_cordic/aclk
connect_bd_net [get_bd_pins ip_3_cordic/aclk] [get_bd_pins ip_3_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_cordic/S_AXIS_PHASE
connect_bd_intf_net [get_bd_intf_pins ip_3_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_3_cordic/cordic_0/S_AXIS_PHASE]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_3_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_3_cordic/cordic_0/M_AXIS_DOUT]


########## conv_encoder ##########
create_bd_cell -type hier ip_4_conv_encoder
create_bd_cell -type ip -vlnv xilinx.com:ip:convolution:9.0 conv_encoder_0
move_bd_cells [get_bd_cells ip_4_conv_encoder] [get_bd_cells conv_encoder_0]
set_property -dict "CONFIG.aclken 1 CONFIG.constraint_length 7 CONFIG.convolution_code0 83 CONFIG.convolution_code1 97 CONFIG.convolution_code2 2 CONFIG.convolution_code3 85 CONFIG.convolution_code4 120 CONFIG.convolution_code5 17 CONFIG.convolution_code6 61 CONFIG.convolution_code_radix Decimal CONFIG.dual_output 0 CONFIG.input_rate 1 CONFIG.output_rate 7 CONFIG.puncture_code0 0 CONFIG.puncture_code1 0 CONFIG.punctured 0 CONFIG.tready 1 " [get_bd_cells ip_4_conv_encoder/conv_encoder_0]
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


########## axi_iic ##########
create_bd_cell -type hier ip_5_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_5_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x31 CONFIG.C_GPO_WIDTH 6 CONFIG.C_SCL_INERTIAL_DELAY 198 CONFIG.C_SDA_INERTIAL_DELAY 155 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 576.4892929136986 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_5_axi_iic/axi_iic_0]
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


########## microblaze ##########
create_bd_cell -type hier ip_6_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 40 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 3 CONFIG.C_DEBUG_ENABLED 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_PVR 0 CONFIG.C_RESET_MSR_BIP 1 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 1 CONFIG.C_RESET_MSR_EIP 0 CONFIG.C_RESET_MSR_ICE 1 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 0 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 0 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 1 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MSR_INSTR 1 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 1 CONFIG.C_USE_STACK_PROTECTION 1 " [get_bd_cells ip_6_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_6_microblaze/Clk
connect_bd_net [get_bd_pins ip_6_microblaze/Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_6_microblaze/Reset
connect_bd_net [get_bd_pins ip_6_microblaze/Reset] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_6_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/INTERRUPT] [get_bd_intf_pins ip_6_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/M_AXI_DP] [get_bd_intf_pins ip_6_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_6_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_6_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0xf92bb24d4617d97 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_6_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_6_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_6_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_6_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xc0d1d8fee745655 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_6_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_6_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_6_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_6_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_6_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_6_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 1 CONFIG.EN_SAFETY_CKT 0 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_6_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_6_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_6_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_6_microblaze/mem/BRAM_PORTB]


########## axi_iic ##########
create_bd_cell -type hier ip_7_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_7_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0xd CONFIG.C_GPO_WIDTH 1 CONFIG.C_SCL_INERTIAL_DELAY 159 CONFIG.C_SDA_INERTIAL_DELAY 160 CONFIG.C_SDA_LEVEL 1 CONFIG.IIC_FREQ_KHZ 600.0810034537167 CONFIG.TEN_BIT_ADR 7_bit " [get_bd_cells ip_7_axi_iic/axi_iic_0]
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


########## axi_cdma ##########
create_bd_cell -type hier ip_8_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_8_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 59 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 16 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_8_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_8_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_8_axi_cdma/m_axi_aclk] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_8_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_8_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_8_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_8_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_8_axi_cdma/M_AXI] [get_bd_intf_pins ip_8_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_8_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_8_axi_cdma/cdma_introut] [get_bd_pins ip_8_axi_cdma/axi_cdma_0/cdma_introut]


########## microblaze ##########
create_bd_cell -type hier ip_9_microblaze
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells microblaze_0]
set_property -dict "CONFIG.C_ADDR_SIZE 48 CONFIG.C_AREA_OPTIMIZED 0 CONFIG.C_BRANCH_TARGET_CACHE_SIZE 5 CONFIG.C_DEBUG_ENABLED 1 CONFIG.C_DIV_ZERO_EXCEPTION 0 CONFIG.C_D_AXI 1 CONFIG.C_D_LMB 1 CONFIG.C_FAULT_TOLERANT 0 CONFIG.C_FPU_EXCEPTION 1 CONFIG.C_ILL_OPCODE_EXCEPTION 0 CONFIG.C_I_LMB 1 CONFIG.C_MMU_DTLB_SIZE 2 CONFIG.C_MMU_ITLB_SIZE 1 CONFIG.C_MMU_PRIVILEGED_INSTR 0 CONFIG.C_MMU_TLB_ACCESS 3 CONFIG.C_MMU_ZONES 6 CONFIG.C_NUMBER_OF_PC_BRK 6 CONFIG.C_NUMBER_OF_RD_ADDR_BRK 0 CONFIG.C_NUMBER_OF_WR_ADDR_BRK 3 CONFIG.C_PVR 2 CONFIG.C_PVR_USER1 0xb0 CONFIG.C_PVR_USER2 0x46281eb CONFIG.C_RESET_MSR_BIP 0 CONFIG.C_RESET_MSR_DCE 0 CONFIG.C_RESET_MSR_EE 0 CONFIG.C_RESET_MSR_EIP 1 CONFIG.C_RESET_MSR_ICE 0 CONFIG.C_RESET_MSR_IE 0 CONFIG.C_UNALIGNED_EXCEPTIONS 1 CONFIG.C_USE_BARREL 1 CONFIG.C_USE_BRANCH_TARGET_CACHE 1 CONFIG.C_USE_DIV 1 CONFIG.C_USE_FPU 1 CONFIG.C_USE_HW_MUL 2 CONFIG.C_USE_INTERRUPT 1 CONFIG.C_USE_MMU 2 CONFIG.C_USE_MSR_INSTR 0 CONFIG.C_USE_PCMP_INSTR 1 CONFIG.C_USE_REORDER_INSTR 0 CONFIG.C_USE_STACK_PROTECTION 0 " [get_bd_cells ip_9_microblaze/microblaze_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_microblaze/Clk
connect_bd_net [get_bd_pins ip_9_microblaze/Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
create_bd_pin -dir I -from 0 -to 0 ip_9_microblaze/Reset
connect_bd_net [get_bd_pins ip_9_microblaze/Reset] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_9_microblaze/INTERRUPT
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/INTERRUPT] [get_bd_intf_pins ip_9_microblaze/microblaze_0/INTERRUPT]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_9_microblaze/M_AXI_DP
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/M_AXI_DP] [get_bd_intf_pins ip_9_microblaze/microblaze_0/M_AXI_DP]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_d
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells lmb_d]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 1 " [get_bd_cells ip_9_microblaze/lmb_d]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_d/LMB_Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_d/SYS_Rst] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_d/LMB_M] [get_bd_intf_pins ip_9_microblaze/microblaze_0/DLMB]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_d
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells lmb_ctrl_d]
set_property -dict "CONFIG.C_MASK 0x143bb90ddf10ba3 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_9_microblaze/lmb_ctrl_d]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_ctrl_d/LMB_Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_ctrl_d/LMB_Rst] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_ctrl_d/SLMB] [get_bd_intf_pins ip_9_microblaze/lmb_d/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 lmb_i
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells lmb_i]
set_property -dict "CONFIG.C_EXT_RESET_HIGH 0 " [get_bd_cells ip_9_microblaze/lmb_i]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_i/LMB_M] [get_bd_intf_pins ip_9_microblaze/microblaze_0/ILMB]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_i/LMB_Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_i/SYS_Rst] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_ctrl_i
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells lmb_ctrl_i]
set_property -dict "CONFIG.C_MASK 0xe6789830bef8c31 CONFIG.C_NUM_LMB 1 " [get_bd_cells ip_9_microblaze/lmb_ctrl_i]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_ctrl_i/LMB_Clk] [get_bd_pins ip_9_microblaze/microblaze_0/Clk]
connect_bd_net [get_bd_pins ip_9_microblaze/lmb_ctrl_i/LMB_Rst] [get_bd_pins ip_9_microblaze/microblaze_0/Reset]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_ctrl_i/SLMB] [get_bd_intf_pins ip_9_microblaze/lmb_i/LMB_Sl_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mem
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells mem]
set_property -dict "CONFIG.Assume_Synchronous_Clk 0 CONFIG.EN_SAFETY_CKT 1 CONFIG.Memory_Type True_Dual_Port_RAM CONFIG.use_bram_block BRAM_Controller " [get_bd_cells ip_9_microblaze/mem]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_ctrl_i/BRAM_PORT] [get_bd_intf_pins ip_9_microblaze/mem/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/lmb_ctrl_d/BRAM_PORT] [get_bd_intf_pins ip_9_microblaze/mem/BRAM_PORTB]
create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm
move_bd_cells [get_bd_cells ip_9_microblaze] [get_bd_cells mdm]
set_property -dict "CONFIG.C_DBG_REG_ACCESS 0 CONFIG.C_JTAG_CHAIN 4 " [get_bd_cells ip_9_microblaze/mdm]
connect_bd_intf_net [get_bd_intf_pins ip_9_microblaze/mdm/MBDEBUG_0] [get_bd_intf_pins ip_9_microblaze/microblaze_0/DEBUG]


########## emc ##########
create_bd_cell -type hier ip_10_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_10_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 7 CONFIG.C_TAVDV_PS_MEM_0 14400 CONFIG.C_TCEDV_PS_MEM_0 14609 CONFIG.C_THZCE_PS_MEM_0 6520 CONFIG.C_THZOE_PS_MEM_0 6948 CONFIG.C_TLZWE_PS_MEM_0 8466 CONFIG.C_TWC_PS_MEM_0 15012 CONFIG.C_TWPH_PS_MEM_0 12985 CONFIG.C_TWP_PS_MEM_0 11093 CONFIG.C_WR_REC_TIME_MEM_0 27869 " [get_bd_cells ip_10_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_10_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_10_emc/EMC_INTF] [get_bd_intf_pins ip_10_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_10_emc/clk
connect_bd_net [get_bd_pins ip_10_emc/clk] [get_bd_pins ip_10_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_emc/rdclk
connect_bd_net [get_bd_pins ip_10_emc/rdclk] [get_bd_pins ip_10_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_10_emc/rst
connect_bd_net [get_bd_pins ip_10_emc/rst] [get_bd_pins ip_10_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_10_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_10_emc/AXI] [get_bd_intf_pins ip_10_emc/emc_0/S_AXI_MEM]


########## xadc_wiz ##########
create_bd_cell -type hier ip_11_xadc_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0
move_bd_cells [get_bd_cells ip_11_xadc_wiz] [get_bd_cells xadc_wiz_0]
set_property -dict "CONFIG.CHANNEL_AVERAGING 64 CONFIG.ENABLE_CALIBRATION_AVERAGING 0 CONFIG.ENABLE_CONVST true CONFIG.ENABLE_TEMP_BUS 1 CONFIG.ENABLE_VBRAM_ALARM 0 CONFIG.INTERFACE_SELECTION Enable_AXI CONFIG.OT_ALARM 0 CONFIG.POWER_DOWN_ADCB 0 CONFIG.TIMING_MODE Event CONFIG.USER_TEMP_ALARM 0 CONFIG.VCCAUX_ALARM 0 CONFIG.VCCINT_ALARM 1 CONFIG.XADC_STARUP_SELECTION simultaneous_sampling " [get_bd_cells ip_11_xadc_wiz/xadc_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/s_axi_aclk
connect_bd_net [get_bd_pins ip_11_xadc_wiz/s_axi_aclk] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/s_axi_aresetn
connect_bd_net [get_bd_pins ip_11_xadc_wiz/s_axi_aresetn] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/s_axi_aresetn]
create_bd_pin -dir I -from 0 -to 0 ip_11_xadc_wiz/convst_in
connect_bd_net [get_bd_pins ip_11_xadc_wiz/convst_in] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/convst_in]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/ip2intc_irpt
connect_bd_net [get_bd_pins ip_11_xadc_wiz/ip2intc_irpt] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/ip2intc_irpt]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/vccint_alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/vccint_alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/eoc_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/eoc_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/eoc_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/eos_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/eos_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/eos_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/alarm_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/alarm_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/alarm_out]
create_bd_pin -dir O -from 0 -to 0 ip_11_xadc_wiz/busy_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/busy_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/busy_out]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_11_xadc_wiz/Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_11_xadc_wiz/Vp_Vn] [get_bd_intf_pins ip_11_xadc_wiz/xadc_wiz_0/Vp_Vn]
create_bd_pin -dir O -from 11 -to 0 ip_11_xadc_wiz/temp_out
connect_bd_net [get_bd_pins ip_11_xadc_wiz/temp_out] [get_bd_pins ip_11_xadc_wiz/xadc_wiz_0/temp_out]


########## gpio ##########
create_bd_cell -type hier ip_12_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_12_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_ALL_OUTPUTS 1 CONFIG.C_DOUT_DEFAULT 0xffff CONFIG.C_GPIO_WIDTH 16 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 0 " [get_bd_cells ip_12_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/GPIO] [get_bd_intf_pins ip_12_gpio/gpio_0/GPIO]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/clk
connect_bd_net [get_bd_pins ip_12_gpio/clk] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_gpio/rst
connect_bd_net [get_bd_pins ip_12_gpio/rst] [get_bd_pins ip_12_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_12_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_gpio/irq
connect_bd_net [get_bd_pins ip_12_gpio/irq] [get_bd_pins ip_12_gpio/gpio_0/ip2intc_irpt]


########## cordic ##########
create_bd_cell -type hier ip_13_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_13_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 0 CONFIG.ARESETn 0 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 1 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 0 CONFIG.Compensation_Scaling Embedded_Multiplier CONFIG.Data_Format SignedFraction CONFIG.Flow_Control Blocking CONFIG.Functional_Selection Arc_Tanh CONFIG.Input_Width 19 CONFIG.Iterations 18 CONFIG.Optimize_Goal Performance CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 1 CONFIG.Output_Width 40 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Scaled_Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 46 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_13_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_13_cordic/aclk
connect_bd_net [get_bd_pins ip_13_cordic/aclk] [get_bd_pins ip_13_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_13_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_13_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_13_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_13_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_13_cordic/cordic_0/M_AXIS_DOUT]


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


########## intc ##########
create_bd_cell -type hier ip_17_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_17_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_17_intc/concat_0]
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
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_17_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_17_intc/irq] [get_bd_intf_pins ip_17_intc/intc_0/interrupt]


########## intc ##########
create_bd_cell -type hier ip_18_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_18_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_18_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 6 " [get_bd_cells ip_18_intc/concat_0]
connect_bd_net [get_bd_pins ip_18_intc/concat_0/dout] [get_bd_pins ip_18_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/clk
connect_bd_net [get_bd_pins ip_18_intc/clk] [get_bd_pins ip_18_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/reset
connect_bd_net [get_bd_pins ip_18_intc/reset] [get_bd_pins ip_18_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_18_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_18_intc/AXI] [get_bd_intf_pins ip_18_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_0
connect_bd_net [get_bd_pins ip_18_intc/irq_0] [get_bd_pins ip_18_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_1
connect_bd_net [get_bd_pins ip_18_intc/irq_1] [get_bd_pins ip_18_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_2
connect_bd_net [get_bd_pins ip_18_intc/irq_2] [get_bd_pins ip_18_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_3
connect_bd_net [get_bd_pins ip_18_intc/irq_3] [get_bd_pins ip_18_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_4
connect_bd_net [get_bd_pins ip_18_intc/irq_4] [get_bd_pins ip_18_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_18_intc/irq_5
connect_bd_net [get_bd_pins ip_18_intc/irq_5] [get_bd_pins ip_18_intc/concat_0/In5]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_18_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_18_intc/irq] [get_bd_intf_pins ip_18_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_19_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_19_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 10 CONFIG.NUM_SI 4 " [get_bd_cells ip_19_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_legacy/clk
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_19_axi_legacy/reset
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_M0] [get_bd_intf_pins ip_19_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_M1] [get_bd_intf_pins ip_19_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_M2] [get_bd_intf_pins ip_19_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_M3] [get_bd_intf_pins ip_19_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S0] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S1] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S2] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S3] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S4] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S5] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S6] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S7] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S8] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_19_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_19_axi_legacy/AXI_S9] [get_bd_intf_pins ip_19_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_19_axi_legacy/clk] [get_bd_pins ip_19_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_19_axi_legacy/reset] [get_bd_pins ip_19_axi_legacy/axi_0/M09_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_20_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_20_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_20_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 1 " [get_bd_cells ip_21_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aclk] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_21_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_21_axis_dwidth_converter/aresetn] [get_bd_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_21_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_22_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_22_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 6 CONFIG.S_TDATA_NUM_BYTES 5 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_22_axis_dwidth_converter/aclk] [get_bd_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_22_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_22_axis_dwidth_converter/aresetn] [get_bd_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_22_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_23_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_23_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 1 CONFIG.S_TDATA_NUM_BYTES 12 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aclk] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aresetn] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_24_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_24_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_24_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_25_slice_and_concat
create_bd_pin -dir O -from 13 -to 0 ip_25_slice_and_concat/out0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat
move_bd_cells [get_bd_cells ip_25_slice_and_concat] [get_bd_cells concat]
set_property -dict "CONFIG.NUM_PORTS 3 " [get_bd_cells ip_25_slice_and_concat/concat]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/out0] [get_bd_pins ip_25_slice_and_concat/concat/dout]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_0
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_25_slice_and_concat/concat/In0]
create_bd_pin -dir I -from 0 -to 0 ip_25_slice_and_concat/in_1
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_25_slice_and_concat/concat/In1]
create_bd_pin -dir I -from 11 -to 0 ip_25_slice_and_concat/in_2
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_2] [get_bd_pins ip_25_slice_and_concat/concat/In2]


########## slice_and_concat ##########
create_bd_cell -type hier ip_26_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_26_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_26_slice_and_concat/in_0


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_14_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_15_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_0_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_0_gpio_GPIO] [get_bd_intf_pins ip_0_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_5_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_5_axi_iic_IIC] [get_bd_intf_pins ip_5_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_7_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_7_axi_iic_IIC] [get_bd_intf_pins ip_7_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_10_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_10_emc_EMC_INTF] [get_bd_intf_pins ip_10_emc/EMC_INTF]
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 ip_11_xadc_wiz_Vp_Vn
connect_bd_intf_net [get_bd_intf_pins ip_11_xadc_wiz_Vp_Vn] [get_bd_intf_pins ip_11_xadc_wiz/Vp_Vn]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_12_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_12_gpio_GPIO] [get_bd_intf_pins ip_12_gpio/GPIO]

########## Interrupts ##########

########## AXI ##########
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_source
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 external_axis_sink
connect_bd_intf_net [get_bd_intf_pins external_axis_source] [get_bd_intf_pins ip_20_axis_dwidth_converter/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins external_axis_sink] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir O -from 13 -to 0 data_O
connect_bd_net [get_bd_pins data_O] [get_bd_pins ip_25_slice_and_concat/out0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_15_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_16_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_intc/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_18_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_0_gpio/rst]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_14_reset/mb_reset] [get_bd_pins ip_2_microblaze/Reset]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_4_conv_encoder/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_5_axi_iic/reset]
connect_bd_net [get_bd_pins ip_14_reset/mb_reset] [get_bd_pins ip_6_microblaze/Reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_7_axi_iic/reset]
connect_bd_net [get_bd_pins ip_14_reset/mb_reset] [get_bd_pins ip_9_microblaze/Reset]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_10_emc/rst]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_11_xadc_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_14_reset/peripheral_areset_n] [get_bd_pins ip_12_gpio/rst]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_0_gpio/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_1_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_2_microblaze/Clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_3_cordic/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_4_conv_encoder/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_5_axi_iic/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_6_microblaze/Clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_7_axi_iic/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_9_microblaze/Clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_10_emc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_10_emc/rdclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_11_xadc_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_12_gpio/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_13_cordic/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_14_reset/clk_in]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_locked] [get_bd_pins ip_14_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_16_intc/irq_0] [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_16_intc/irq_1] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_2] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_16_intc/irq_3] [get_bd_pins ip_8_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_16_intc/irq_4] [get_bd_pins ip_11_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_16_intc/irq_5] [get_bd_pins ip_12_gpio/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_microblaze/INTERRUPT] [get_bd_intf_pins ip_16_intc/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_0] [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_17_intc/irq_1] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_2] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_17_intc/irq_3] [get_bd_pins ip_8_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_17_intc/irq_4] [get_bd_pins ip_11_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_17_intc/irq_5] [get_bd_pins ip_12_gpio/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_microblaze/INTERRUPT] [get_bd_intf_pins ip_17_intc/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_0] [get_bd_pins ip_1_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_18_intc/irq_1] [get_bd_pins ip_5_axi_iic/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_2] [get_bd_pins ip_7_axi_iic/irq]
connect_bd_net [get_bd_pins ip_18_intc/irq_3] [get_bd_pins ip_8_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_18_intc/irq_4] [get_bd_pins ip_11_xadc_wiz/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_18_intc/irq_5] [get_bd_pins ip_12_gpio/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_microblaze/INTERRUPT] [get_bd_intf_pins ip_18_intc/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_microblaze/M_AXI_DP] [get_bd_intf_pins ip_19_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_microblaze/M_AXI_DP] [get_bd_intf_pins ip_19_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/M_AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_microblaze/M_AXI_DP] [get_bd_intf_pins ip_19_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_gpio/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_19_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_axi_iic/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_axi_iic/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_19_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_emc/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_gpio/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_intc/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_intc/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_18_intc/AXI] [get_bd_intf_pins ip_19_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_conv_encoder/S_AXIS_DATA] [get_bd_intf_pins ip_20_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_21_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_conv_encoder/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_21_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_13_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_cordic/S_AXIS_PHASE] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_cordic/M_AXIS_DOUT]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_1_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/eoc_out]
connect_bd_net [get_bd_pins ip_24_slice_and_concat/out0] [get_bd_pins ip_24_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/eos_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_1] [get_bd_pins ip_11_xadc_wiz/busy_out]
connect_bd_net [get_bd_pins ip_25_slice_and_concat/in_2] [get_bd_pins ip_11_xadc_wiz/temp_out]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_4_conv_encoder/aclken]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/vccint_alarm_out]
connect_bd_net [get_bd_pins ip_26_slice_and_concat/out0] [get_bd_pins ip_26_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_11_xadc_wiz/convst_in]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/in_0] [get_bd_pins ip_11_xadc_wiz/alarm_out]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_19_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_20_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_21_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_14_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_16_intc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_17_intc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_18_intc/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_19_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_20_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_21_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_15_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_cordic/cordic_0/S_AXIS_PHASE]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_cordic/S_AXIS_PHASE declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_cordic/S_AXIS_PHASE declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_cordic/M_AXIS_DOUT declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_cordic/M_AXIS_DOUT declared=96 actual=ERR $__err" }
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
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_20_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_20_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/S_AXIS declared=8 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_21_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_21_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 40 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=40 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=40 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 48 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=48 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=48 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 96 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=96 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=96 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 8 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=8 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=8 actual=ERR $__err" }


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
