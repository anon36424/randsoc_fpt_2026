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
set_property -dict "CONFIG.C_DEFAULT_VALUE 0x6b CONFIG.C_GPO_WIDTH 5 CONFIG.C_SCL_INERTIAL_DELAY 110 CONFIG.C_SDA_INERTIAL_DELAY 156 CONFIG.C_SDA_LEVEL 0 CONFIG.IIC_FREQ_KHZ 538.1629967093523 CONFIG.TEN_BIT_ADR 10_bit " [get_bd_cells ip_0_axi_iic/axi_iic_0]
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


########## axi_cdma ##########
create_bd_cell -type hier ip_1_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_1_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 41 CONFIG.C_INCLUDE_DRE 1 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 0 " [get_bd_cells ip_1_axi_cdma/axi_cdma_0]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_cdma/S_AXI_LITE
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_1_axi_cdma/axi_cdma_0/S_AXI_LITE]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_cdma/m_axi_aclk
connect_bd_net [get_bd_pins ip_1_axi_cdma/m_axi_aclk] [get_bd_pins ip_1_axi_cdma/axi_cdma_0/m_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_cdma/s_axi_lite_aclk
connect_bd_net [get_bd_pins ip_1_axi_cdma/s_axi_lite_aclk] [get_bd_pins ip_1_axi_cdma/axi_cdma_0/s_axi_lite_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_1_axi_cdma/s_axi_lite_aresetn
connect_bd_net [get_bd_pins ip_1_axi_cdma/s_axi_lite_aresetn] [get_bd_pins ip_1_axi_cdma/axi_cdma_0/s_axi_lite_aresetn]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_1_axi_cdma/M_AXI
connect_bd_intf_net [get_bd_intf_pins ip_1_axi_cdma/M_AXI] [get_bd_intf_pins ip_1_axi_cdma/axi_cdma_0/M_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_1_axi_cdma/cdma_introut
connect_bd_net [get_bd_pins ip_1_axi_cdma/cdma_introut] [get_bd_pins ip_1_axi_cdma/axi_cdma_0/cdma_introut]


########## axi_cdma ##########
create_bd_cell -type hier ip_2_axi_cdma
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
move_bd_cells [get_bd_cells ip_2_axi_cdma] [get_bd_cells axi_cdma_0]
set_property -dict "CONFIG.C_ADDR_WIDTH 38 CONFIG.C_INCLUDE_SF 0 CONFIG.C_INCLUDE_SG 0 CONFIG.C_M_AXI_DATA_WIDTH 64 CONFIG.C_M_AXI_MAX_BURST_LEN 64 CONFIG.C_USE_DATAMOVER_LITE 1 " [get_bd_cells ip_2_axi_cdma/axi_cdma_0]
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


########## gpio ##########
create_bd_cell -type hier ip_3_gpio
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_0
move_bd_cells [get_bd_cells ip_3_gpio] [get_bd_cells gpio_0]
set_property -dict "CONFIG.C_DOUT_DEFAULT 0x1f8509 CONFIG.C_DOUT_DEFAULT_2 0x1fffff CONFIG.C_GPIO2_WIDTH 17 CONFIG.C_GPIO_WIDTH 21 CONFIG.C_INTERRUPT_PRESENT 1 CONFIG.C_IS_DUAL 1 CONFIG.C_TRI_DEFAULT 0x39adb CONFIG.C_TRI_DEFAULT_2 0x1f00e6 " [get_bd_cells ip_3_gpio/gpio_0]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio/GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/GPIO] [get_bd_intf_pins ip_3_gpio/gpio_0/GPIO]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio/GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/GPIO2] [get_bd_intf_pins ip_3_gpio/gpio_0/GPIO2]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/clk
connect_bd_net [get_bd_pins ip_3_gpio/clk] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_3_gpio/rst
connect_bd_net [get_bd_pins ip_3_gpio/rst] [get_bd_pins ip_3_gpio/gpio_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_3_gpio/AXI
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_3_gpio/gpio_0/S_AXI]
create_bd_pin -dir O -from 0 -to 0 ip_3_gpio/irq
connect_bd_net [get_bd_pins ip_3_gpio/irq] [get_bd_pins ip_3_gpio/gpio_0/ip2intc_irpt]


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
set_property -dict "CONFIG.NUM_PORTS 4 " [get_bd_cells ip_6_intc/concat_0]
connect_bd_net [get_bd_pins ip_6_intc/concat_0/dout] [get_bd_pins ip_6_intc/intc_0/intr]
create_bd_pin -dir I -from 0 -to 0 ip_6_intc/clk
connect_bd_net [get_bd_pins ip_6_intc/clk] [get_bd_pins ip_6_intc/intc_0/s_axi_aclk]
create_bd_pin -dir I -from 0 -to 0 ip_6_intc/reset
connect_bd_net [get_bd_pins ip_6_intc/reset] [get_bd_pins ip_6_intc/intc_0/s_axi_aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_6_intc/AXI
connect_bd_intf_net [get_bd_intf_pins ip_6_intc/AXI] [get_bd_intf_pins ip_6_intc/intc_0/s_axi]
create_bd_pin -dir I -from 0 -to 0 ip_6_intc/irq_0
connect_bd_net [get_bd_pins ip_6_intc/irq_0] [get_bd_pins ip_6_intc/concat_0/In0]
create_bd_pin -dir I -from 0 -to 0 ip_6_intc/irq_1
connect_bd_net [get_bd_pins ip_6_intc/irq_1] [get_bd_pins ip_6_intc/concat_0/In1]
create_bd_pin -dir I -from 0 -to 0 ip_6_intc/irq_2
connect_bd_net [get_bd_pins ip_6_intc/irq_2] [get_bd_pins ip_6_intc/concat_0/In2]
create_bd_pin -dir I -from 0 -to 0 ip_6_intc/irq_3
connect_bd_net [get_bd_pins ip_6_intc/irq_3] [get_bd_pins ip_6_intc/concat_0/In3]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 ip_6_intc/irq
connect_bd_intf_net [get_bd_intf_pins ip_6_intc/irq] [get_bd_intf_pins ip_6_intc/intc_0/interrupt]


########## axi ##########
create_bd_cell -type hier ip_7_axi
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_0
move_bd_cells [get_bd_cells ip_7_axi] [get_bd_cells axi_0]
set_property -dict "CONFIG.NUM_MI 5 CONFIG.NUM_SI 2 " [get_bd_cells ip_7_axi/axi_0]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi/clk
connect_bd_net [get_bd_pins ip_7_axi/clk] [get_bd_pins ip_7_axi/axi_0/aclk]
create_bd_pin -dir I -from 0 -to 0 ip_7_axi/reset
connect_bd_net [get_bd_pins ip_7_axi/reset] [get_bd_pins ip_7_axi/axi_0/aresetn]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi/AXI_M0
connect_bd_intf_net [get_bd_intf_pins ip_7_axi/AXI_M0] [get_bd_intf_pins ip_7_axi/axi_0/S00_AXI]
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi/AXI_M1
connect_bd_intf_net [get_bd_intf_pins ip_7_axi/AXI_M1] [get_bd_intf_pins ip_7_axi/axi_0/S01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi/AXI_S0
connect_bd_intf_net [get_bd_intf_pins ip_7_axi/AXI_S0] [get_bd_intf_pins ip_7_axi/axi_0/M00_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi/AXI_S1
connect_bd_intf_net [get_bd_intf_pins ip_7_axi/AXI_S1] [get_bd_intf_pins ip_7_axi/axi_0/M01_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi/AXI_S2
connect_bd_intf_net [get_bd_intf_pins ip_7_axi/AXI_S2] [get_bd_intf_pins ip_7_axi/axi_0/M02_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi/AXI_S3
connect_bd_intf_net [get_bd_intf_pins ip_7_axi/AXI_S3] [get_bd_intf_pins ip_7_axi/axi_0/M03_AXI]
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ip_7_axi/AXI_S4
connect_bd_intf_net [get_bd_intf_pins ip_7_axi/AXI_S4] [get_bd_intf_pins ip_7_axi/axi_0/M04_AXI]

########## Resets ##########
create_bd_port -dir I -from 0 -to 0 reset
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_1_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aresetn]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_4_reset/reset_in]

########## Clocks ##########
create_bd_port -dir I -from 0 -to 0 clk
connect_bd_net [get_bd_pins clk] [get_bd_pins ip_5_clk_wiz/clk_in]

########## GPIO, UART ##########
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 ip_0_axi_iic_IIC
connect_bd_intf_net [get_bd_intf_pins ip_0_axi_iic_IIC] [get_bd_intf_pins ip_0_axi_iic/IIC]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio_GPIO
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio_GPIO] [get_bd_intf_pins ip_3_gpio/GPIO]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 ip_3_gpio_GPIO2
connect_bd_intf_net [get_bd_intf_pins ip_3_gpio_GPIO2] [get_bd_intf_pins ip_3_gpio/GPIO2]
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 irq

########## Interrupts ##########
connect_bd_intf_net [get_bd_intf_pins irq] [get_bd_intf_pins ip_6_intc/irq]

########## AXI ##########

########## Connecting Protocol.DATA ports ##########

########## Connecting Protocol.CONTROL ports ##########
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_5_clk_wiz/reset]
connect_bd_net [get_bd_pins reset] [get_bd_pins ip_6_intc/reset]

########## Clocks ##########

########## GPIO, UART ##########

########## IP to IP connections ##########
connect_bd_net [get_bd_pins ip_4_reset/peripheral_areset_n] [get_bd_pins ip_0_axi_iic/reset]
connect_bd_net [get_bd_pins ip_4_reset/peripheral_areset_n] [get_bd_pins ip_3_gpio/rst]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_0_axi_iic/clk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_1_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_1_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/m_axi_aclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_2_axi_cdma/s_axi_lite_aclk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_3_gpio/clk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_4_reset/clk_in]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_locked] [get_bd_pins ip_4_reset/dcm_locked]
connect_bd_net [get_bd_pins ip_6_intc/irq_0] [get_bd_pins ip_0_axi_iic/irq]
connect_bd_net [get_bd_pins ip_6_intc/irq_1] [get_bd_pins ip_1_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_6_intc/irq_2] [get_bd_pins ip_2_axi_cdma/cdma_introut]
connect_bd_net [get_bd_pins ip_6_intc/irq_3] [get_bd_pins ip_3_gpio/irq]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_cdma/M_AXI] [get_bd_intf_pins ip_7_axi/AXI_M0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/M_AXI] [get_bd_intf_pins ip_7_axi/AXI_M1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_0_axi_iic/AXI] [get_bd_intf_pins ip_7_axi/AXI_S0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_1_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_7_axi/AXI_S1]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_2_axi_cdma/S_AXI_LITE] [get_bd_intf_pins ip_7_axi/AXI_S2]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_3_gpio/AXI] [get_bd_intf_pins ip_7_axi/AXI_S3]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ip_6_intc/AXI] [get_bd_intf_pins ip_7_axi/AXI_S4]
connect_bd_net [get_bd_pins ip_4_reset/interconnect_aresetn] [get_bd_pins ip_7_axi/reset]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_6_intc/clk]
connect_bd_net [get_bd_pins ip_5_clk_wiz/clk_out] [get_bd_pins ip_7_axi/clk]

########## Address space ##########


# AXIS width verification runs before validate_bd_design so widths are reported
# even for designs that fail validation (each IP's TDATA is resolved at configure
# time, independent of connectivity).


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
