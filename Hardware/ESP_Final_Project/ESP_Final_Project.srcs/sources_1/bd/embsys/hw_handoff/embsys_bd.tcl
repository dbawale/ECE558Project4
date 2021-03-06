
################################################################
# This is a generated script based on design: embsys
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source embsys_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
}


# CHANGE DESIGN NAME HERE
set design_name embsys

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -from 0 -to 0 -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 lmb_bram ]
  set_property -dict [ list \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set PmodBT2_out [ create_bd_intf_port -mode Master -vlnv digilentinc.com:interface:pmod_rtl:1.0 PmodBT2_out ]
  set PmodOLEDrgb_out [ create_bd_intf_port -mode Master -vlnv digilentinc.com:interface:pmod_rtl:1.0 PmodOLEDrgb_out ]
  set gpio_0_GPIO [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_0_GPIO ]
  set uart_rtl [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_rtl ]

  # Create ports
  set RGB1_Blue [ create_bd_port -dir O RGB1_Blue ]
  set RGB1_Green [ create_bd_port -dir O RGB1_Green ]
  set RGB1_Red [ create_bd_port -dir O RGB1_Red ]
  set RGB2_Blue [ create_bd_port -dir O RGB2_Blue ]
  set RGB2_Green [ create_bd_port -dir O RGB2_Green ]
  set RGB2_Red [ create_bd_port -dir O RGB2_Red ]
  set an [ create_bd_port -dir O -from 7 -to 0 an ]
  set btnC [ create_bd_port -dir I btnC ]
  set btnD [ create_bd_port -dir I btnD ]
  set btnL [ create_bd_port -dir I btnL ]
  set btnR [ create_bd_port -dir I btnR ]
  set btnU [ create_bd_port -dir I btnU ]
  set dp [ create_bd_port -dir O dp ]
  set led [ create_bd_port -dir O -from 15 -to 0 led ]
  set led_out [ create_bd_port -dir O led_out ]
  set seg [ create_bd_port -dir O -from 6 -to 0 seg ]
  set sw [ create_bd_port -dir I -from 15 -to 0 sw ]
  set sysclk [ create_bd_port -dir I -type clk sysclk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {100000000} \
CONFIG.PHASE {0.000} \
 ] $sysclk
  set sysreset_n [ create_bd_port -dir I -type rst sysreset_n ]
  set_property -dict [ list \
CONFIG.POLARITY {ACTIVE_LOW} \
 ] $sysreset_n

  # Create instance: DigiLED_0, and set properties
  set DigiLED_0 [ create_bd_cell -type ip -vlnv user.org:user:DigiLED:1.0 DigiLED_0 ]
  set_property -dict [ list \
CONFIG.NUMBER_OF_LEDS {60} \
CONFIG.REFRESH_DELAY {30000} \
 ] $DigiLED_0

  # Create instance: PmodBT2_0, and set properties
  set PmodBT2_0 [ create_bd_cell -type ip -vlnv digilentinc.com:IP:PmodBT2:1.0 PmodBT2_0 ]

  # Create instance: PmodOLEDrgb_0, and set properties
  set PmodOLEDrgb_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ece544ip:PmodOLEDrgb:1.0 PmodOLEDrgb_0 ]

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS {1} \
CONFIG.C_GPIO_WIDTH {8} \
 ] $axi_gpio_0

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $axi_uartlite_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $axi_uartlite_0

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.3 clk_wiz_1 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER {130.958} \
CONFIG.CLKOUT1_PHASE_ERROR {98.575} \
CONFIG.CLKOUT2_JITTER {151.636} \
CONFIG.CLKOUT2_PHASE_ERROR {98.575} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {50.000} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.CLKOUT3_JITTER {130.958} \
CONFIG.CLKOUT3_PHASE_ERROR {98.575} \
CONFIG.CLKOUT3_USED {true} \
CONFIG.MMCM_CLKFBOUT_MULT_F {10.000} \
CONFIG.MMCM_CLKIN1_PERIOD {10.0} \
CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {10.000} \
CONFIG.MMCM_CLKOUT1_DIVIDE {20} \
CONFIG.MMCM_CLKOUT2_DIVIDE {10} \
CONFIG.MMCM_COMPENSATION {ZHOLD} \
CONFIG.MMCM_DIVCLK_DIVIDE {1} \
CONFIG.NUM_OUT_CLKS {3} \
CONFIG.PRIM_SOURCE {Single_ended_clock_capable_pin} \
CONFIG.USE_RESET {false} \
 ] $clk_wiz_1

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER.VALUE_SRC {DEFAULT} \
CONFIG.CLKOUT1_PHASE_ERROR.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKFBOUT_MULT_F.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKIN1_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKIN2_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_COMPENSATION.VALUE_SRC {DEFAULT} \
 ] $clk_wiz_1

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:9.6 microblaze_0 ]
  set_property -dict [ list \
CONFIG.C_DEBUG_ENABLED {1} \
CONFIG.C_D_AXI {1} \
CONFIG.C_D_LMB {1} \
CONFIG.C_I_LMB {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
CONFIG.C_HAS_FAST {1} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {9} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: microblaze_0_xlconcat, and set properties
  set microblaze_0_xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 microblaze_0_xlconcat ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {1} \
 ] $microblaze_0_xlconcat

  # Create instance: nexys4IO_0, and set properties
  set nexys4IO_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:nexys4IO:2.0 nexys4IO_0 ]

  # Create instance: rst_clk_wiz_1_100M, and set properties
  set rst_clk_wiz_1_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_1_100M ]

  # Create interface connections
  connect_bd_intf_net -intf_net PmodBT2_0_Pmod_out [get_bd_intf_ports PmodBT2_out] [get_bd_intf_pins PmodBT2_0/Pmod_out]
  connect_bd_intf_net -intf_net PmodOLEDrgb_0_PmodOLEDrgb_out [get_bd_intf_ports PmodOLEDrgb_out] [get_bd_intf_pins PmodOLEDrgb_0/PmodOLEDrgb_out]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports gpio_0_GPIO] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports uart_rtl] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net microblaze_0_axi_dp [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI] [get_bd_intf_pins nexys4IO_0/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins PmodOLEDrgb_0/AXI_LITE_GPIO] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins PmodOLEDrgb_0/AXI_LITE_SPI] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins PmodBT2_0/AXI_LITE_UART] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins PmodBT2_0/AXI_LITE_GPIO] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M06_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M07_AXI [get_bd_intf_pins DigiLED_0/S00_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M08_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_intc_axi [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]

  # Create port connections
  connect_bd_net -net DigiLED_0_led_out [get_bd_ports led_out] [get_bd_pins DigiLED_0/led_out]
  connect_bd_net -net PmodBT2_0_BT2_uart_interrupt [get_bd_pins PmodBT2_0/BT2_uart_interrupt] [get_bd_pins microblaze_0_xlconcat/In0]
  connect_bd_net -net btnC_1 [get_bd_ports btnC] [get_bd_pins nexys4IO_0/btnC]
  connect_bd_net -net btnD_1 [get_bd_ports btnD] [get_bd_pins nexys4IO_0/btnD]
  connect_bd_net -net btnL_1 [get_bd_ports btnL] [get_bd_pins nexys4IO_0/btnL]
  connect_bd_net -net btnR_1 [get_bd_ports btnR] [get_bd_pins nexys4IO_0/btnR]
  connect_bd_net -net btnU_1 [get_bd_ports btnU] [get_bd_pins nexys4IO_0/btnU]
  connect_bd_net -net clk_wiz_1_clk_out2 [get_bd_pins PmodOLEDrgb_0/ext_spi_clk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net -net clk_wiz_1_clk_out3 [get_bd_pins clk_wiz_1/clk_out3] [get_bd_pins nexys4IO_0/Clock]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins rst_clk_wiz_1_100M/dcm_locked]
  connect_bd_net -net clock_rtl_1 [get_bd_ports sysclk] [get_bd_pins clk_wiz_1/clk_in1]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_clk_wiz_1_100M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins DigiLED_0/s00_axi_aclk] [get_bd_pins PmodBT2_0/s_axi_aclk] [get_bd_pins PmodOLEDrgb_0/s_axi_aclk] [get_bd_pins PmodOLEDrgb_0/s_axi_aclk2] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/M07_ACLK] [get_bd_pins microblaze_0_axi_periph/M08_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins nexys4IO_0/s00_axi_aclk] [get_bd_pins rst_clk_wiz_1_100M/slowest_sync_clk]
  connect_bd_net -net microblaze_0_intr [get_bd_pins microblaze_0_axi_intc/intr] [get_bd_pins microblaze_0_xlconcat/dout]
  connect_bd_net -net nexys4IO_0_RGB1_Blue [get_bd_ports RGB1_Blue] [get_bd_pins nexys4IO_0/RGB1_Blue]
  connect_bd_net -net nexys4IO_0_RGB1_Green [get_bd_ports RGB1_Green] [get_bd_pins nexys4IO_0/RGB1_Green]
  connect_bd_net -net nexys4IO_0_RGB1_Red [get_bd_ports RGB1_Red] [get_bd_pins nexys4IO_0/RGB1_Red]
  connect_bd_net -net nexys4IO_0_RGB2_Blue [get_bd_ports RGB2_Blue] [get_bd_pins nexys4IO_0/RGB2_Blue]
  connect_bd_net -net nexys4IO_0_RGB2_Green [get_bd_ports RGB2_Green] [get_bd_pins nexys4IO_0/RGB2_Green]
  connect_bd_net -net nexys4IO_0_RGB2_Red [get_bd_ports RGB2_Red] [get_bd_pins nexys4IO_0/RGB2_Red]
  connect_bd_net -net nexys4IO_0_an [get_bd_ports an] [get_bd_pins nexys4IO_0/an]
  connect_bd_net -net nexys4IO_0_dp [get_bd_ports dp] [get_bd_pins nexys4IO_0/dp]
  connect_bd_net -net nexys4IO_0_led [get_bd_ports led] [get_bd_pins nexys4IO_0/led]
  connect_bd_net -net nexys4IO_0_seg [get_bd_ports seg] [get_bd_pins nexys4IO_0/seg]
  connect_bd_net -net reset_rtl_0_1 [get_bd_ports sysreset_n] [get_bd_pins rst_clk_wiz_1_100M/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_clk_wiz_1_100M/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_interconnect_aresetn [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins rst_clk_wiz_1_100M/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins rst_clk_wiz_1_100M/mb_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins DigiLED_0/s00_axi_aresetn] [get_bd_pins PmodBT2_0/s_axi_aresetn] [get_bd_pins PmodOLEDrgb_0/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/M07_ARESETN] [get_bd_pins microblaze_0_axi_periph/M08_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins nexys4IO_0/s00_axi_aresetn] [get_bd_pins rst_clk_wiz_1_100M/peripheral_aresetn]
  connect_bd_net -net sw_1 [get_bd_ports sw] [get_bd_pins nexys4IO_0/sw]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs DigiLED_0/S00_AXI/S00_AXI_reg] SEG_DigiLED_0_S00_AXI_reg
  create_bd_addr_seg -range 0x00002000 -offset 0x00020000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs PmodBT2_0/AXI_LITE_UART/Reg0] SEG_PmodBT2_0_Reg0
  create_bd_addr_seg -range 0x00001000 -offset 0x00030000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs PmodBT2_0/AXI_LITE_GPIO/Reg0] SEG_PmodBT2_0_Reg01
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs PmodOLEDrgb_0/AXI_LITE_GPIO/AXI_LITE_GPIO_reg] SEG_PmodOLEDrgb_0_AXI_LITE_GPIO_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs PmodOLEDrgb_0/AXI_LITE_SPI/AXI_LITE_SPI_reg] SEG_PmodOLEDrgb_0_AXI_LITE_SPI_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00020000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00020000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] SEG_microblaze_0_axi_intc_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs nexys4IO_0/S00_AXI/S00_AXI_reg] SEG_nexys4IO_0_S00_AXI_reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port uart_rtl -pg 1 -y 630 -defaultsOSRD
preplace port btnL -pg 1 -y 1040 -defaultsOSRD
preplace port led_out -pg 1 -y 60 -defaultsOSRD
preplace port RGB1_Blue -pg 1 -y 1020 -defaultsOSRD
preplace port btnC -pg 1 -y 1060 -defaultsOSRD
preplace port gpio_0_GPIO -pg 1 -y 520 -defaultsOSRD
preplace port btnD -pg 1 -y 1000 -defaultsOSRD
preplace port dp -pg 1 -y 1120 -defaultsOSRD
preplace port btnR -pg 1 -y 1020 -defaultsOSRD
preplace port RGB2_Blue -pg 1 -y 1080 -defaultsOSRD
preplace port sysclk -pg 1 -y 1160 -defaultsOSRD
preplace port RGB1_Red -pg 1 -y 980 -defaultsOSRD
preplace port sysreset_n -pg 1 -y 890 -defaultsOSRD
preplace port btnU -pg 1 -y 980 -defaultsOSRD
preplace port RGB2_Green -pg 1 -y 1060 -defaultsOSRD
preplace port RGB2_Red -pg 1 -y 1040 -defaultsOSRD
preplace port PmodBT2_out -pg 1 -y 360 -defaultsOSRD
preplace port RGB1_Green -pg 1 -y 1000 -defaultsOSRD
preplace port PmodOLEDrgb_out -pg 1 -y 210 -defaultsOSRD
preplace portBus sw -pg 1 -y 1080 -defaultsOSRD
preplace portBus an -pg 1 -y 1140 -defaultsOSRD
preplace portBus led -pg 1 -y 960 -defaultsOSRD
preplace portBus seg -pg 1 -y 1100 -defaultsOSRD
preplace inst PmodBT2_0 -pg 1 -lvl 6 -y 380 -defaultsOSRD
preplace inst microblaze_0_axi_periph -pg 1 -lvl 5 -y 340 -defaultsOSRD
preplace inst axi_gpio_0 -pg 1 -lvl 6 -y 520 -defaultsOSRD
preplace inst PmodOLEDrgb_0 -pg 1 -lvl 6 -y 220 -defaultsOSRD
preplace inst microblaze_0_xlconcat -pg 1 -lvl 2 -y 760 -defaultsOSRD
preplace inst DigiLED_0 -pg 1 -lvl 6 -y 70 -defaultsOSRD
preplace inst mdm_1 -pg 1 -lvl 3 -y 920 -defaultsOSRD
preplace inst microblaze_0_axi_intc -pg 1 -lvl 3 -y 750 -defaultsOSRD
preplace inst nexys4IO_0 -pg 1 -lvl 6 -y 1050 -defaultsOSRD
preplace inst axi_uartlite_0 -pg 1 -lvl 6 -y 640 -defaultsOSRD
preplace inst microblaze_0 -pg 1 -lvl 4 -y 780 -defaultsOSRD
preplace inst rst_clk_wiz_1_100M -pg 1 -lvl 2 -y 910 -defaultsOSRD
preplace inst clk_wiz_1 -pg 1 -lvl 1 -y 1160 -defaultsOSRD
preplace inst microblaze_0_local_memory -pg 1 -lvl 5 -y 790 -defaultsOSRD
preplace netloc PmodOLEDrgb_0_PmodOLEDrgb_out 1 6 1 NJ
preplace netloc microblaze_0_axi_periph_M08_AXI 1 5 1 1650
preplace netloc microblaze_0_axi_periph_M04_AXI 1 5 1 1700
preplace netloc microblaze_0_intr 1 2 1 NJ
preplace netloc microblaze_0_Clk 1 1 5 190 810 540 650 800 650 1280 620 1670
preplace netloc btnD_1 1 0 6 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ 1000 NJ
preplace netloc btnC_1 1 0 6 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ 1060 NJ
preplace netloc nexys4IO_0_led 1 6 1 NJ
preplace netloc microblaze_0_axi_periph_M06_AXI 1 5 1 1680
preplace netloc microblaze_0_axi_periph_M03_AXI 1 5 1 1660
preplace netloc microblaze_0_intc_axi 1 2 4 580 30 NJ 30 NJ 30 1610
preplace netloc microblaze_0_interrupt 1 3 1 N
preplace netloc btnU_1 1 0 6 NJ 980 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ
preplace netloc nexys4IO_0_RGB2_Blue 1 6 1 NJ
preplace netloc btnL_1 1 0 6 NJ 1040 NJ 1040 NJ 1040 NJ 1040 NJ 1040 NJ
preplace netloc microblaze_0_ilmb_1 1 4 1 N
preplace netloc nexys4IO_0_RGB1_Blue 1 6 1 NJ
preplace netloc microblaze_0_axi_periph_M05_AXI 1 5 1 1700
preplace netloc microblaze_0_axi_dp 1 4 1 1260
preplace netloc PmodBT2_0_BT2_uart_interrupt 1 1 6 220 0 NJ 0 NJ 0 NJ 0 NJ 0 2010
preplace netloc nexys4IO_0_dp 1 6 1 NJ
preplace netloc nexys4IO_0_RGB1_Red 1 6 1 NJ
preplace netloc nexys4IO_0_RGB2_Green 1 6 1 NJ
preplace netloc rst_clk_wiz_1_100M_interconnect_aresetn 1 2 3 NJ 160 NJ 160 N
preplace netloc rst_clk_wiz_1_100M_bus_struct_reset 1 2 3 NJ 860 NJ 860 1270
preplace netloc microblaze_0_axi_periph_M01_AXI 1 5 1 1690
preplace netloc rst_clk_wiz_1_100M_peripheral_aresetn 1 2 4 570 560 NJ 560 1270 60 1630
preplace netloc rst_clk_wiz_1_100M_mb_reset 1 2 2 560 850 820
preplace netloc clk_wiz_1_locked 1 1 1 210
preplace netloc axi_gpio_0_GPIO 1 6 1 NJ
preplace netloc axi_uartlite_0_UART 1 6 1 NJ
preplace netloc clk_wiz_1_clk_out2 1 1 5 NJ 50 NJ 50 NJ 50 NJ 50 1620
preplace netloc reset_rtl_0_1 1 0 2 NJ 890 NJ
preplace netloc microblaze_0_axi_periph_M07_AXI 1 5 1 1640
preplace netloc PmodBT2_0_Pmod_out 1 6 1 NJ
preplace netloc microblaze_0_axi_periph_M02_AXI 1 5 1 1650
preplace netloc microblaze_0_dlmb_1 1 4 1 N
preplace netloc DigiLED_0_led_out 1 6 1 2020
preplace netloc clk_wiz_1_clk_out3 1 1 5 NJ 1080 NJ 1080 NJ 1080 NJ 1080 N
preplace netloc nexys4IO_0_an 1 6 1 NJ
preplace netloc sw_1 1 0 6 NJ 1080 NJ 1090 NJ 1090 NJ 1090 NJ 1090 NJ
preplace netloc clock_rtl_1 1 0 1 NJ
preplace netloc microblaze_0_debug 1 3 1 810
preplace netloc btnR_1 1 0 6 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ 1010 NJ
preplace netloc mdm_1_debug_sys_rst 1 1 3 220 1030 NJ 1030 810
preplace netloc nexys4IO_0_RGB1_Green 1 6 1 NJ
preplace netloc nexys4IO_0_seg 1 6 1 NJ
preplace netloc nexys4IO_0_RGB2_Red 1 6 1 NJ
levelinfo -pg 1 0 100 380 690 1040 1460 1860 2040 -top -10 -bot 1240
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


