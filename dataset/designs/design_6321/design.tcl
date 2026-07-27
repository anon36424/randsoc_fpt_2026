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



########## axi_iic ##########
create_bd_cell -type hier ip_0_axi_iic
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0
move_bd_cells [get_bd_cells ip_0_axi_iic] [get_bd_cells axi_iic_0]
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x50 CONFIG.C_GPO_WIDTH 4 CONFIG.C_SCL_INERTIAL_DELAY 217 CONFIG.C_SDA_INERTIAL_DELAY 106 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 328.6038650470192 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_0_axi_iic/axi_iic_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic/IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic/IIC] [get_bd_intf_pins ip_0_axi_iic/axi_iic_0/IIC]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_iic/clk
connect_bd_net [get_bd_pins ip_0_axi_iic/clk] [get_bd_pins ip_0_axi_iic/axi_iic_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_0_axi_iic/reset
connect_bd_net [get_bd_pins ip_0_axi_iic/reset] [get_bd_pins ip_0_axi_iic/axi_iic_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_0_axi_iic/AXI
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_0_axi_iic/axi_iic_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_0_axi_iic/irq
connect_bd_net [get_bd_pins ip_0_axi_iic/irq] [get_bd_pins ip_0_axi_iic/axi_iic_0/iic2intc_irpt]


########## axi_dma ##########
create_bd_cell -type hier ip_1_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_1_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 59 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_MM2S_BURST_SIZE 64 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 64 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 64 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 9 CONFIG.C_SINGLE_INTERFACE 1 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 64 " [get_bd_cells ip_1_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_1_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_1_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_1_axi_dma/axi_resetn] [get_bd_pins ip_1_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_dma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXI] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_1_axi_dma/mm2s_introut] [get_bd_pins ip_1_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_1_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_1_axi_dma/s2mm_introut] [get_bd_pins ip_1_axi_dma/axi_dma_0/s2mm_introut]


########## gpio ##########
create_bd_cell -type hier ip_2_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_2_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x0 CONFIG.C_DOUT_DEFAULT_2 0x3ffff CONFIG.C_GPIO2_WIDTH 17 CONFIG.C_GPIO_WIDTH 18 CONFIG.C_INTERRUPT_PRESENT 0 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x0 CONFIG.C_TRI_DEFAULT_2 0x125c7 " [get_bd_cells ip_2_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/GPIO] [get_bd_intf_pins ip_2_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/GPIO2] [get_bd_intf_pins ip_2_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/clk
connect_bd_net [get_bd_pins ip_2_gpio/clk] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_2_gpio/rst
connect_bd_net [get_bd_pins ip_2_gpio/rst] [get_bd_pins ip_2_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_2_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_2_gpio/gpio_0/S_AXI]


########## axi_dma ##########
create_bd_cell -type hier ip_3_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_3_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 40 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_MM2S_DRE 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 2 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 64 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 256 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 22 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_3_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_3_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_3_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_3_axi_dma/axi_resetn] [get_bd_pins ip_3_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_3_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_3_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_3_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_3_axi_dma/mm2s_introut] [get_bd_pins ip_3_axi_dma/axi_dma_0/mm2s_introut]


########## axi_dma ##########
create_bd_cell -type hier ip_4_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_4_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 41 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 16 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 512 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 512 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 512 CONFIG.C_NUM_MM2S_CHANNELS 11 CONFIG.C_NUM_S2MM_CHANNELS 5 CONFIG.C_S2MM_BURST_SIZE 32 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 17 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 256 " [get_bd_cells ip_4_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_4_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_4_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_4_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_4_axi_dma/axi_resetn] [get_bd_pins ip_4_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_4_axi_dma/mm2s_introut] [get_bd_pins ip_4_axi_dma/axi_dma_0/mm2s_introut]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_4_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_4_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_4_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_4_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_4_axi_dma/s2mm_introut] [get_bd_pins ip_4_axi_dma/axi_dma_0/s2mm_introut]


########## emc ##########
create_bd_cell -type hier ip_5_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_5_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 2 CONFIG.C_MEM0_WIDTH 16 CONFIG.C_NUM_BANKS_MEM 1 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 16 CONFIG.C_TAVDV_PS_MEM_0 15932 CONFIG.C_TCEDV_PS_MEM_0 13909 CONFIG.C_THZCE_PS_MEM_0 6743 CONFIG.C_THZOE_PS_MEM_0 6451 CONFIG.C_TLZWE_PS_MEM_0 6372 CONFIG.C_TWC_PS_MEM_0 13820 CONFIG.C_TWPH_PS_MEM_0 12909 CONFIG.C_TWP_PS_MEM_0 11185 CONFIG.C_WR_REC_TIME_MEM_0 26113 " [get_bd_cells ip_5_emc/emc_0]
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


########## emc ##########
create_bd_cell -type hier ip_6_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_6_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 0 CONFIG.C_MEM0_WIDTH 64 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 1 CONFIG.C_MEM2_WIDTH 8 CONFIG.C_MEM3_TYPE 1 CONFIG.C_MEM3_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 4 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_PARITY_TYPE_MEM_3 0 CONFIG.C_SYNCH_PIPEDELAY_0 1 CONFIG.C_SYNCH_PIPEDELAY_1 2 CONFIG.C_S_AXI_EN_REG 0 CONFIG.C_S_AXI_MEM_DATA_WIDTH 64 CONFIG.C_S_AXI_MEM_ID_WIDTH 5 CONFIG.C_TAVDV_PS_MEM_2 15773 CONFIG.C_TAVDV_PS_MEM_3 16406 CONFIG.C_TCEDV_PS_MEM_2 14754 CONFIG.C_TCEDV_PS_MEM_3 14553 CONFIG.C_THZCE_PS_MEM_2 6764 CONFIG.C_THZCE_PS_MEM_3 7569 CONFIG.C_THZOE_PS_MEM_2 7361 CONFIG.C_THZOE_PS_MEM_3 7380 CONFIG.C_TLZWE_PS_MEM_2 4017 CONFIG.C_TLZWE_PS_MEM_3 7765 CONFIG.C_TWC_PS_MEM_2 15254 CONFIG.C_TWC_PS_MEM_3 16310 CONFIG.C_TWPH_PS_MEM_2 11491 CONFIG.C_TWPH_PS_MEM_3 12694 CONFIG.C_TWP_PS_MEM_2 10804 CONFIG.C_TWP_PS_MEM_3 12228 CONFIG.C_WR_REC_TIME_MEM_2 28487 CONFIG.C_WR_REC_TIME_MEM_3 28777 " [get_bd_cells ip_6_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_6_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_6_emc/EMC_INTF] [get_bd_intf_pins ip_6_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_6_emc/clk
connect_bd_net [get_bd_pins ip_6_emc/clk] [get_bd_pins ip_6_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_emc/rdclk
connect_bd_net [get_bd_pins ip_6_emc/rdclk] [get_bd_pins ip_6_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_emc/rst
connect_bd_net [get_bd_pins ip_6_emc/rst] [get_bd_pins ip_6_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_emc/AXI] [get_bd_intf_pins ip_6_emc/emc_0/S_AXI_MEM]


########## uartlite ##########
create_bd_cell -type hier ip_7_uartlite
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart_0
move_bd_cells [get_bd_cells ip_7_uartlite] [get_bd_cells uart_0]
set_property -dict "CONFIG.C_BAUDRATE 19200 CONFIG.C_DATA_BITS 6 CONFIG.PARITY Even " [get_bd_cells ip_7_uartlite/uart_0]
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


########## axi_cdma ##########
create_bd_cell -type hier ip_8_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_8_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 49 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_8_axi_cdma/axi_cdma_0]
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


########## cordic ##########
create_bd_cell -type hier ip_9_cordic
create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0
move_bd_cells [get_bd_cells ip_9_cordic] [get_bd_cells cordic_0]
set_property -dict "CONFIG.ACLKEN 1 CONFIG.ARESETn 1 CONFIG.Architectural_Configuration Word_Serial CONFIG.CARTESIAN_HAS_TLAST 0 CONFIG.CARTESIAN_HAS_TUSER 0 CONFIG.Coarse_Rotation 1 CONFIG.Compensation_Scaling No_Scale_Compensation CONFIG.Data_Format SignedFraction CONFIG.Flow_Control NonBlocking CONFIG.Functional_Selection Translate CONFIG.Input_Width 12 CONFIG.Iterations 26 CONFIG.Optimize_Goal Resources CONFIG.Out_TLAST_Behaviour None CONFIG.Out_TREADY 0 CONFIG.Output_Width 28 CONFIG.PHASE_HAS_TLAST 0 CONFIG.PHASE_HAS_TUSER 0 CONFIG.Phase_Format Radians CONFIG.Pipelining_Mode Optimal CONFIG.Precision 31 CONFIG.Round_Mode Nearest_Even " [get_bd_cells ip_9_cordic/cordic_0]
create_bd_pin -dir I -from 0 -to 0 ip_9_cordic/aclk
connect_bd_net [get_bd_pins ip_9_cordic/aclk] [get_bd_pins ip_9_cordic/cordic_0/aclk]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_cordic/S_AXIS_CARTESIAN
connect_bd_intf_net [get_bd_intf_pins ip_9_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_9_cordic/cordic_0/S_AXIS_CARTESIAN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_9_cordic/M_AXIS_DOUT
connect_bd_intf_net [get_bd_intf_pins ip_9_cordic/M_AXIS_DOUT] [get_bd_intf_pins ip_9_cordic/cordic_0/M_AXIS_DOUT]


########## fft ##########
create_bd_cell -type hier ip_10_fft
create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 fft_0
move_bd_cells [get_bd_cells ip_10_fft] [get_bd_cells fft_0]
set_property -dict "CONFIG.channels 9 CONFIG.cyclic_prefix_insertion 0 CONFIG.implementation_options radix_2_burst_io CONFIG.run_time_configurable_transform_length 1 CONFIG.transform_length 4096 " [get_bd_cells ip_10_fft/fft_0]
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


########## axi_dma ##########
create_bd_cell -type hier ip_11_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_11_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 63 CONFIG.C_ENABLE_MULTI_CHANNEL 1 CONFIG.C_INCLUDE_MM2S 1 CONFIG.C_INCLUDE_S2MM 0 CONFIG.C_INCLUDE_SG 1 CONFIG.C_MICRO_DMA 0 CONFIG.C_MM2S_BURST_SIZE 2 CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH 512 CONFIG.C_M_AXI_MM2S_DATA_WIDTH 512 CONFIG.C_NUM_MM2S_CHANNELS 15 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 " [get_bd_cells ip_11_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/m_axi_sg_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/m_axi_sg_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/m_axi_sg_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/m_axi_mm2s_aclk
connect_bd_net [get_bd_pins ip_11_axi_dma/m_axi_mm2s_aclk] [get_bd_pins ip_11_axi_dma/axi_dma_0/m_axi_mm2s_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_11_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_11_axi_dma/axi_resetn] [get_bd_pins ip_11_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/M_AXI_SG
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXI_SG]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_11_axi_dma/M_AXI_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXI_MM2S]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_11_axi_dma/M_AXIS_MM2S
connect_bd_intf_net [get_bd_intf_pins ip_11_axi_dma/M_AXIS_MM2S] [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXIS_MM2S]
create_bd_pin -dir O -from 0 -to 0 ip_11_axi_dma/mm2s_introut
connect_bd_net [get_bd_pins ip_11_axi_dma/mm2s_introut] [get_bd_pins ip_11_axi_dma/axi_dma_0/mm2s_introut]


########## axi_cdma ##########
create_bd_cell -type hier ip_12_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_12_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 53 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 32 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_12_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_12_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_12_axi_cdma/m_axi_aclk] [get_bd_pins ip_12_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_12_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_12_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_12_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_12_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_12_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_12_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_12_axi_cdma/M_AXI] [get_bd_intf_pins ip_12_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_12_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_12_axi_cdma/cdma_introut] [get_bd_pins ip_12_axi_cdma/axi_cdma_0/cdma_introut]


########## emc ##########
create_bd_cell -type hier ip_13_emc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_emc:3.0 emc_0
move_bd_cells [get_bd_cells ip_13_emc] [get_bd_cells emc_0]
set_property -dict "CONFIG.C_MEM0_TYPE 1 CONFIG.C_MEM0_WIDTH 32 CONFIG.C_MEM1_TYPE 0 CONFIG.C_MEM1_WIDTH 16 CONFIG.C_MEM2_TYPE 0 CONFIG.C_MEM2_WIDTH 8 CONFIG.C_NUM_BANKS_MEM 3 CONFIG.C_PARITY_TYPE_MEM_0 0 CONFIG.C_PARITY_TYPE_MEM_1 0 CONFIG.C_PARITY_TYPE_MEM_2 0 CONFIG.C_SYNCH_PIPEDELAY_1 2 CONFIG.C_SYNCH_PIPEDELAY_2 1 CONFIG.C_S_AXI_EN_REG 1 CONFIG.C_S_AXI_MEM_DATA_WIDTH 32 CONFIG.C_S_AXI_MEM_ID_WIDTH 12 CONFIG.C_TAVDV_PS_MEM_0 16154 CONFIG.C_TCEDV_PS_MEM_0 15902 CONFIG.C_THZCE_PS_MEM_0 6628 CONFIG.C_THZOE_PS_MEM_0 6525 CONFIG.C_TLZWE_PS_MEM_0 1005 CONFIG.C_TWC_PS_MEM_0 14262 CONFIG.C_TWPH_PS_MEM_0 13098 CONFIG.C_TWP_PS_MEM_0 13180 CONFIG.C_WR_REC_TIME_MEM_0 28146 " [get_bd_cells ip_13_emc/emc_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_13_emc/EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_13_emc/EMC_INTF] [get_bd_intf_pins ip_13_emc/emc_0/EMC_INTF]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/clk
connect_bd_net [get_bd_pins ip_13_emc/clk] [get_bd_pins ip_13_emc/emc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/rdclk
connect_bd_net [get_bd_pins ip_13_emc/rdclk] [get_bd_pins ip_13_emc/emc_0/rdclk]
create_bd_pin -dir I -from 0 -to 0 ip_13_emc/rst
connect_bd_net [get_bd_pins ip_13_emc/rst] [get_bd_pins ip_13_emc/emc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_13_emc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_13_emc/AXI] [get_bd_intf_pins ip_13_emc/emc_0/S_AXI_MEM]


########## axi_dma ##########
create_bd_cell -type hier ip_14_axi_dma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
move_bd_cells [get_bd_cells ip_14_axi_dma] [get_bd_cells axi_dma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 42 CONFIG.C_ENABLE_MULTI_CHANNEL 0 CONFIG.C_INCLUDE_MM2S 0 CONFIG.C_INCLUDE_S2MM 1 CONFIG.C_INCLUDE_S2MM_DRE 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_MICRO_DMA 1 CONFIG.C_M_AXI_S2MM_DATA_WIDTH 32 CONFIG.C_S2MM_BURST_SIZE 64 CONFIG.C_SG_INCLUDE_STSCNTRL_STRM 0 CONFIG.C_SG_LENGTH_WIDTH 8 CONFIG.C_SINGLE_INTERFACE 0 CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH 32 " [get_bd_cells ip_14_axi_dma/axi_dma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/m_axi_s2mm_aclk
connect_bd_net [get_bd_pins ip_14_axi_dma/m_axi_s2mm_aclk] [get_bd_pins ip_14_axi_dma/axi_dma_0/m_axi_s2mm_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_14_axi_dma/axi_resetn
connect_bd_net [get_bd_pins ip_14_axi_dma/axi_resetn] [get_bd_pins ip_14_axi_dma/axi_dma_0/axi_resetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_14_axi_dma/M_AXI_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/M_AXI_S2MM]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_14_axi_dma/S_AXIS_S2MM
connect_bd_intf_net [get_bd_intf_pins ip_14_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXIS_S2MM]
create_bd_pin -dir O -from 0 -to 0 ip_14_axi_dma/s2mm_introut
connect_bd_net [get_bd_pins ip_14_axi_dma/s2mm_introut] [get_bd_pins ip_14_axi_dma/axi_dma_0/s2mm_introut]


########## axi_hwicap ##########
create_bd_cell -type hier ip_15_axi_hwicap
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0
move_bd_cells [get_bd_cells ip_15_axi_hwicap] [get_bd_cells axi_hwicap_0]
set_property -dict "CONFIG.C_ICAP_DWIDTH 32 CONFIG.C_ICAP_EXTERNAL 0 CONFIG.C_INCLUDE_STARTUP 0 CONFIG.C_MODE 1 CONFIG.C_NOREAD 1 CONFIG.C_OPERATION 0 " [get_bd_cells ip_15_axi_hwicap/axi_hwicap_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_15_axi_hwicap/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_15_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_15_axi_hwicap/axi_hwicap_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_hwicap/icap_clk
connect_bd_net [get_bd_pins ip_15_axi_hwicap/icap_clk] [get_bd_pins ip_15_axi_hwicap/axi_hwicap_0/icap_clk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_hwicap/eos_in
connect_bd_net [get_bd_pins ip_15_axi_hwicap/eos_in] [get_bd_pins ip_15_axi_hwicap/axi_hwicap_0/eos_in]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_hwicap/s_axi_aclk
connect_bd_net [get_bd_pins ip_15_axi_hwicap/s_axi_aclk] [get_bd_pins ip_15_axi_hwicap/axi_hwicap_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_15_axi_hwicap/s_axi_aresetn
connect_bd_net [get_bd_pins ip_15_axi_hwicap/s_axi_aresetn] [get_bd_pins ip_15_axi_hwicap/axi_hwicap_0/s_axi_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_15_axi_hwicap/ip2intc_irpt
connect_bd_net [get_bd_pins ip_15_axi_hwicap/ip2intc_irpt] [get_bd_pins ip_15_axi_hwicap/axi_hwicap_0/ip2intc_irpt]


########## floating_point ##########
create_bd_cell -type hier ip_16_floating_point
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 floating_point_0
move_bd_cells [get_bd_cells ip_16_floating_point] [get_bd_cells floating_point_0]
set_property -dict "CONFIG.a_precision_type Single CONFIG.add_sub_value Both CONFIG.axi_optimize_goal Performance CONFIG.c_bram_usage No_Usage CONFIG.c_compare_operation Programmable CONFIG.c_has_invalid_op 0 CONFIG.c_mult_usage No_Usage CONFIG.c_result_exponent_width 51 CONFIG.c_result_fraction_width 5 CONFIG.flow_control Blocking CONFIG.has_a_tlast 0 CONFIG.has_a_tuser 0 CONFIG.has_aclken 0 CONFIG.has_aresetn 1 CONFIG.has_b_tlast 0 CONFIG.has_b_tuser 0 CONFIG.has_c_tlast 0 CONFIG.has_c_tuser 0 CONFIG.has_operation_tlast 0 CONFIG.has_operation_tuser 0 CONFIG.has_result_tready 0 CONFIG.maximum_latency 1 CONFIG.operation_type Float_to_fixed CONFIG.result_precision_type Custom " [get_bd_cells ip_16_floating_point/floating_point_0]
create_bd_pin -dir I -from 0 -to 0 ip_16_floating_point/aclk
connect_bd_net [get_bd_pins ip_16_floating_point/aclk] [get_bd_pins ip_16_floating_point/floating_point_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_16_floating_point/aresetn
connect_bd_net [get_bd_pins ip_16_floating_point/aresetn] [get_bd_pins ip_16_floating_point/floating_point_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_floating_point/S_AXIS_A
connect_bd_intf_net [get_bd_intf_pins ip_16_floating_point/S_AXIS_A] [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_A]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_16_floating_point/M_AXIS_RESULT
connect_bd_intf_net [get_bd_intf_pins ip_16_floating_point/M_AXIS_RESULT] [get_bd_intf_pins ip_16_floating_point/floating_point_0/M_AXIS_RESULT]


########## axi_cdma ##########
create_bd_cell -type hier ip_17_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_17_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 37 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 1 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 32 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_17_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_17_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_17_axi_cdma/m_axi_aclk] [get_bd_pins ip_17_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_17_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_17_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_17_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_17_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_17_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_17_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_17_axi_cdma/M_AXI] [get_bd_intf_pins ip_17_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_17_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_17_axi_cdma/cdma_introut] [get_bd_pins ip_17_axi_cdma/axi_cdma_0/cdma_introut]


########## reset ##########
create_bd_cell -type hier ip_18_reset
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_0
move_bd_cells [get_bd_cells ip_18_reset] [get_bd_cells reset_0]
create_bd_pin -dir I -from 0 -to 0 ip_18_reset/clk_in
connect_bd_net [get_bd_pins ip_18_reset/clk_in] [get_bd_pins ip_18_reset/reset_0/slowest_sync_clk]
create_bd_pin -dir I -from 0 -to 0 ip_18_reset/reset_in
connect_bd_net [get_bd_pins ip_18_reset/reset_in] [get_bd_pins ip_18_reset/reset_0/ext_reset_in]
create_bd_pin -dir I -from 0 -to 0 ip_18_reset/dcm_locked
connect_bd_net [get_bd_pins ip_18_reset/dcm_locked] [get_bd_pins ip_18_reset/reset_0/dcm_locked]
create_bd_pin -dir O -from 0 -to 0 ip_18_reset/mb_reset
connect_bd_net [get_bd_pins ip_18_reset/mb_reset] [get_bd_pins ip_18_reset/reset_0/mb_reset]
create_bd_pin -dir O -from 0 -to 0 ip_18_reset/peripheral_areset_n
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_18_reset/reset_0/peripheral_aresetn]
create_bd_pin -dir O -from 0 -to 0 ip_18_reset/peripheral_areset
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset] [get_bd_pins ip_18_reset/reset_0/peripheral_reset]
create_bd_pin -dir O -from 0 -to 0 ip_18_reset/interconnect_aresetn
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_18_reset/reset_0/interconnect_aresetn]


########## clk_wiz ##########
create_bd_cell -type hier ip_19_clk_wiz
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
move_bd_cells [get_bd_cells ip_19_clk_wiz] [get_bd_cells clk_wiz_0]
create_bd_pin -dir I -from 0 -to 0 ip_19_clk_wiz/clk_in
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_in] [get_bd_pins ip_19_clk_wiz/clk_wiz_0/clk_in1]
create_bd_pin -dir O -from 0 -to 0 ip_19_clk_wiz/clk_out
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_19_clk_wiz/clk_wiz_0/clk_out1]
create_bd_pin -dir I -from 0 -to 0 ip_19_clk_wiz/reset
connect_bd_net [get_bd_pins ip_19_clk_wiz/reset] [get_bd_pins ip_19_clk_wiz/clk_wiz_0/reset]
create_bd_pin -dir O -from 0 -to 0 ip_19_clk_wiz/clk_locked
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_locked] [get_bd_pins ip_19_clk_wiz/clk_wiz_0/locked]


########## intc ##########
create_bd_cell -type hier ip_20_intc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 intc_0
move_bd_cells [get_bd_cells ip_20_intc] [get_bd_cells intc_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_0
move_bd_cells [get_bd_cells ip_20_intc] [get_bd_cells concat_0]
set_property -dict "CONFIG.NUM_PORTS 14 " [get_bd_cells ip_20_intc/concat_0]
connect_bd_net [get_bd_pins ip_20_intc/concat_0/dout] [get_bd_pins ip_20_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/clk
connect_bd_net [get_bd_pins ip_20_intc/clk] [get_bd_pins ip_20_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/reset
connect_bd_net [get_bd_pins ip_20_intc/reset] [get_bd_pins ip_20_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_20_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_20_intc/AXI] [get_bd_intf_pins ip_20_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_0
connect_bd_net [get_bd_pins ip_20_intc/irq_0] [get_bd_pins ip_20_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_1
connect_bd_net [get_bd_pins ip_20_intc/irq_1] [get_bd_pins ip_20_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_2
connect_bd_net [get_bd_pins ip_20_intc/irq_2] [get_bd_pins ip_20_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_3
connect_bd_net [get_bd_pins ip_20_intc/irq_3] [get_bd_pins ip_20_intc/concat_0/In3]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_4
connect_bd_net [get_bd_pins ip_20_intc/irq_4] [get_bd_pins ip_20_intc/concat_0/In4]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_5
connect_bd_net [get_bd_pins ip_20_intc/irq_5] [get_bd_pins ip_20_intc/concat_0/In5]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_6
connect_bd_net [get_bd_pins ip_20_intc/irq_6] [get_bd_pins ip_20_intc/concat_0/In6]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_7
connect_bd_net [get_bd_pins ip_20_intc/irq_7] [get_bd_pins ip_20_intc/concat_0/In7]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_8
connect_bd_net [get_bd_pins ip_20_intc/irq_8] [get_bd_pins ip_20_intc/concat_0/In8]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_9
connect_bd_net [get_bd_pins ip_20_intc/irq_9] [get_bd_pins ip_20_intc/concat_0/In9]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_10
connect_bd_net [get_bd_pins ip_20_intc/irq_10] [get_bd_pins ip_20_intc/concat_0/In10]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_11
connect_bd_net [get_bd_pins ip_20_intc/irq_11] [get_bd_pins ip_20_intc/concat_0/In11]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_12
connect_bd_net [get_bd_pins ip_20_intc/irq_12] [get_bd_pins ip_20_intc/concat_0/In12]
create_bd_pin -dir I -from 0 -to 0 ip_20_intc/irq_13
connect_bd_net [get_bd_pins ip_20_intc/irq_13] [get_bd_pins ip_20_intc/concat_0/In13]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_20_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_20_intc/irq] [get_bd_intf_pins ip_20_intc/intc_0/interrupt]


########## axi_legacy ##########
create_bd_cell -type hier ip_21_axi_legacy
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_0
move_bd_cells [get_bd_cells ip_21_axi_legacy] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 16 CONFIG.NUM_SI 12 " [get_bd_cells ip_21_axi_legacy/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_legacy/clk
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/ACLK]
create_bd_pin -dir I -from 0 -to 0 ip_21_axi_legacy/reset
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M0] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S00_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S00_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S00_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M1] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S01_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S01_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S01_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M2
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M2] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S02_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S02_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S02_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M3
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M3] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S03_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S03_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S03_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M4
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M4] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S04_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S04_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S04_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M5
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M5] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S05_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S05_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S05_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M6
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M6] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S06_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S06_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S06_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M7
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M7] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S07_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S07_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S07_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M8
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M8] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S08_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S08_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S08_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M9
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M9] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S09_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S09_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S09_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M10
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M10] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S10_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S10_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S10_ARESETN]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_M11
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_M11] [get_bd_intf_pins ip_21_axi_legacy/axi_0/S11_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/S11_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/S11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S0] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M00_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M00_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M00_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S1] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M01_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M01_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M01_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S2] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M02_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M02_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M02_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S3] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M03_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M03_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M03_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S4] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M04_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M04_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M04_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S5
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S5] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M05_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M05_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M05_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S6
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S6] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M06_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M06_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M06_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S7
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S7] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M07_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M07_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M07_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S8
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S8] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M08_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M08_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M08_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S9
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S9] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M09_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M09_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M09_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S10
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S10] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M10_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M10_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M10_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S11
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S11] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M11_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M11_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M11_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S12
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S12] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M12_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M12_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M12_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S13
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S13] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M13_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M13_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M13_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S14
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S14] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M14_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M14_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M14_ARESETN]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_21_axi_legacy/AXI_S15
connect_bd_intf_net [get_bd_intf_pins ip_21_axi_legacy/AXI_S15] [get_bd_intf_pins ip_21_axi_legacy/axi_0/M15_AXI]
connect_bd_net [get_bd_pins ip_21_axi_legacy/clk] [get_bd_pins ip_21_axi_legacy/axi_0/M15_ACLK]
connect_bd_net [get_bd_pins ip_21_axi_legacy/reset] [get_bd_pins ip_21_axi_legacy/axi_0/M15_ARESETN]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_22_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_22_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 8 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_22_axis_dwidth_converter/axis_dwidth_converter_0]
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
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 8 " [get_bd_cells ip_23_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aclk] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_23_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_23_axis_dwidth_converter/aresetn] [get_bd_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_23_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_24_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_24_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 7 " [get_bd_cells ip_24_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aclk] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_24_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_24_axis_dwidth_converter/aresetn] [get_bd_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_24_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_25_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_25_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 32 CONFIG.S_TDATA_NUM_BYTES 36 " [get_bd_cells ip_25_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_25_axis_dwidth_converter/aclk] [get_bd_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_25_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_25_axis_dwidth_converter/aresetn] [get_bd_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_25_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## axis_dwidth_converter ##########
create_bd_cell -type hier ip_26_axis_dwidth_converter
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
move_bd_cells [get_bd_cells ip_26_axis_dwidth_converter] [get_bd_cells axis_dwidth_converter_0]
set_property -dict "CONFIG.M_TDATA_NUM_BYTES 4 CONFIG.S_TDATA_NUM_BYTES 64 " [get_bd_cells ip_26_axis_dwidth_converter/axis_dwidth_converter_0]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aclk
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aclk] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_26_axis_dwidth_converter/aresetn
connect_bd_net [get_bd_pins ip_26_axis_dwidth_converter/aresetn] [get_bd_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/S_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 ip_26_axis_dwidth_converter/M_AXIS
connect_bd_intf_net [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS] [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]


########## slice_and_concat ##########
create_bd_cell -type hier ip_27_slice_and_concat
create_bd_pin -dir O -from 0 -to 0 ip_27_slice_and_concat/out0
create_bd_pin -dir I -from 0 -to 0 ip_27_slice_and_concat/in_0

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_12_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_17_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_18_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_19_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic_IIC] [get_bd_intf_pins ip_0_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio_GPIO] [get_bd_intf_pins ip_2_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_2_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_2_gpio_GPIO2] [get_bd_intf_pins ip_2_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_5_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_5_emc_EMC_INTF] [get_bd_intf_pins ip_5_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_6_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_6_emc_EMC_INTF] [get_bd_intf_pins ip_6_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 ip_7_uartlite_UART
connect_bd_intf_net [get_bd_intf_pins ip_7_uartlite_UART] [get_bd_intf_pins ip_7_uartlite/UART]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:emc_rtl:1.0 ip_13_emc_EMC_INTF
connect_bd_intf_net [get_bd_intf_pins ip_13_emc_EMC_INTF] [get_bd_intf_pins ip_13_emc/EMC_INTF]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_20_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########
create_bd_port -dir I -from 0 -to 0 data_I
connect_bd_net [get_bd_pins data_I] [get_bd_pins ip_27_slice_and_concat/in_0]

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_19_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_20_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_iic/reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_1_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_2_gpio/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_3_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_4_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_5_emc/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_6_emc/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_7_uartlite/reset]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_11_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_13_emc/rst]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_14_axi_dma/axi_resetn]
connect_bd_net [get_bd_pins ip_18_reset/peripheral_areset_n] [get_bd_pins ip_15_axi_hwicap/s_axi_aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_16_floating_point/aresetn]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_0_axi_iic/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_1_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_2_gpio/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_3_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_4_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_5_emc/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_5_emc/rdclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_6_emc/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_6_emc/rdclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_7_uartlite/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_8_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_9_cordic/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_10_fft/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/m_axi_sg_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_11_axi_dma/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_12_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_12_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_13_emc/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_13_emc/rdclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_14_axi_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_15_axi_hwicap/icap_clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_15_axi_hwicap/s_axi_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_16_floating_point/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_17_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_17_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_18_reset/clk_in]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_locked] [get_bd_pins ip_18_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_20_intc/irq_0] [get_bd_pins ip_0_axi_iic/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_1] [get_bd_pins ip_1_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_2] [get_bd_pins ip_1_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_3] [get_bd_pins ip_3_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_4] [get_bd_pins ip_4_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_5] [get_bd_pins ip_4_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_6] [get_bd_pins ip_7_uartlite/irq]
connect_bd_net [get_bd_pins ip_20_intc/irq_7] [get_bd_pins ip_8_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_8] [get_bd_pins ip_10_fft/event_frame_started]
connect_bd_net [get_bd_pins ip_20_intc/irq_9] [get_bd_pins ip_11_axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_10] [get_bd_pins ip_12_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_11] [get_bd_pins ip_14_axi_dma/s2mm_introut]
connect_bd_net [get_bd_pins ip_20_intc/irq_12] [get_bd_pins ip_15_axi_hwicap/ip2intc_irpt]
connect_bd_net [get_bd_pins ip_20_intc/irq_13] [get_bd_pins ip_17_axi_cdma/cdma_introut]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/M_AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_21_axi_legacy/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_21_axi_legacy/AXI_M2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_21_axi_legacy/AXI_M3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_21_axi_legacy/AXI_M4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_21_axi_legacy/AXI_M5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/M_AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_M6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/M_AXI_SG] [get_bd_intf_pins ip_21_axi_legacy/AXI_M7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/M_AXI_MM2S] [get_bd_intf_pins ip_21_axi_legacy/AXI_M8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_cdma/M_AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_M9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/M_AXI_S2MM] [get_bd_intf_pins ip_21_axi_legacy/AXI_M10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_cdma/M_AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_M11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_gpio/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S4]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_5_emc/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S5]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_emc/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S6]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_7_uartlite/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S7]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_8_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S8]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_11_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S9]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_12_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S10]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_13_emc/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S11]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S12]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_15_axi_hwicap/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S13]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_17_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_21_axi_legacy/AXI_S14]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_20_intc/AXI] [get_bd_intf_pins ip_21_axi_legacy/AXI_S15]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_22_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_3_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_22_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_23_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_1_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_16_floating_point/S_AXIS_A] [get_bd_intf_pins ip_23_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_24_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_16_floating_point/M_AXIS_RESULT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_9_cordic/S_AXIS_CARTESIAN] [get_bd_intf_pins ip_24_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_CONFIG] [get_bd_intf_pins ip_9_cordic/M_AXIS_DOUT]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_25_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_10_fft/M_AXIS_DATA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_4_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_25_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_26_axis_dwidth_converter/S_AXIS] [get_bd_intf_pins ip_4_axi_dma/M_AXIS_MM2S]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_14_axi_dma/S_AXIS_S2MM] [get_bd_intf_pins ip_26_axis_dwidth_converter/M_AXIS]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_10_fft/S_AXIS_DATA] [get_bd_intf_pins ip_11_axi_dma/M_AXIS_MM2S]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_15_axi_hwicap/eos_in]
connect_bd_net [get_bd_pins ip_27_slice_and_concat/out0] [get_bd_pins ip_27_slice_and_concat/in_0]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_21_axi_legacy/reset]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_22_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_23_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_24_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_25_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_18_reset/interconnect_aresetn] [get_bd_pins ip_26_axis_dwidth_converter/aresetn]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_20_intc/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_21_axi_legacy/clk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_22_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_23_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_24_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_25_axis_dwidth_converter/aclk]
connect_bd_net [get_bd_pins ip_19_clk_wiz/clk_out] [get_bd_pins ip_26_axis_dwidth_converter/aclk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).

########## AXIS width verification ##########
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_1_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/S_AXIS_S2MM declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_1_axi_dma/S_AXIS_S2MM declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_3_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/M_AXIS_MM2S declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_3_axi_dma/M_AXIS_MM2S declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 512 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=512 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/M_AXIS_MM2S declared=512 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_4_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/S_AXIS_S2MM declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_4_axi_dma/S_AXIS_S2MM declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_cordic/cordic_0/S_AXIS_CARTESIAN]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_cordic/S_AXIS_CARTESIAN declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_cordic/S_AXIS_CARTESIAN declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_9_cordic/cordic_0/M_AXIS_DOUT]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_9_cordic/M_AXIS_DOUT declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_9_cordic/M_AXIS_DOUT declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/M_AXIS_DATA]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/M_AXIS_DATA declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_10_fft/fft_0/S_AXIS_CONFIG]] * 8}]
  set __s [expr {$__aw == 38 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=38 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_10_fft/S_AXIS_CONFIG declared=38 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_11_axi_dma/axi_dma_0/M_AXIS_MM2S]] * 8}]
  set __s [expr {$__aw == 512 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/M_AXIS_MM2S declared=512 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_11_axi_dma/M_AXIS_MM2S declared=512 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_14_axi_dma/axi_dma_0/S_AXIS_S2MM]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/S_AXIS_S2MM declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_14_axi_dma/S_AXIS_S2MM declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_floating_point/floating_point_0/S_AXIS_A]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_A declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/S_AXIS_A declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_16_floating_point/floating_point_0/M_AXIS_RESULT]] * 8}]
  set __s [expr {$__aw == 56 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/M_AXIS_RESULT declared=56 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_16_floating_point/M_AXIS_RESULT declared=56 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_22_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_22_axis_dwidth_converter/M_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 64 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/S_AXIS declared=64 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_23_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_23_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 56 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=56 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/S_AXIS declared=56 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_24_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_24_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 288 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=288 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/S_AXIS declared=288 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_25_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 256 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=256 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_25_axis_dwidth_converter/M_AXIS declared=256 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/S_AXIS]] * 8}]
  set __s [expr {$__aw == 512 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=512 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/S_AXIS declared=512 actual=ERR $__err" }
if {[catch {
  set __aw [expr {[get_property CONFIG.TDATA_NUM_BYTES [get_bd_intf_pins ip_26_axis_dwidth_converter/axis_dwidth_converter_0/M_AXIS]] * 8}]
  set __s [expr {$__aw == 32 ? "OK" : "MISMATCH"}]
  puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=32 actual=$__aw $__s"
} __err]} { puts "RANDSOC_WIDTH_CHECK ip_26_axis_dwidth_converter/M_AXIS declared=32 actual=ERR $__err" }


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
