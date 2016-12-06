vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/microblaze_v9_6_1
vlib msim/lmb_v10_v3_0_8
vlib msim/lmb_bram_if_cntlr_v4_0_9
vlib msim/blk_mem_gen_v8_3_3
vlib msim/axi_lite_ipif_v3_0_4
vlib msim/axi_intc_v4_1_7
vlib msim/mdm_v3_2_6
vlib msim/lib_cdc_v1_0_2
vlib msim/proc_sys_reset_v5_0_9
vlib msim/dist_mem_gen_v8_0_10
vlib msim/lib_pkg_v1_0_2
vlib msim/lib_srl_fifo_v1_0_2
vlib msim/fifo_generator_v13_1_1
vlib msim/lib_fifo_v1_0_5
vlib msim/interrupt_control_v3_1_4
vlib msim/axi_quad_spi_v3_2_8
vlib msim/axi_gpio_v2_0_11
vlib msim/axi_uart16550_v2_0_11
vlib msim/axi_uartlite_v2_0_13
vlib msim/generic_baseblocks_v2_1_0
vlib msim/axi_infrastructure_v1_1_0
vlib msim/axi_register_slice_v2_1_9
vlib msim/axi_data_fifo_v2_1_8
vlib msim/axi_crossbar_v2_1_10

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap microblaze_v9_6_1 msim/microblaze_v9_6_1
vmap lmb_v10_v3_0_8 msim/lmb_v10_v3_0_8
vmap lmb_bram_if_cntlr_v4_0_9 msim/lmb_bram_if_cntlr_v4_0_9
vmap blk_mem_gen_v8_3_3 msim/blk_mem_gen_v8_3_3
vmap axi_lite_ipif_v3_0_4 msim/axi_lite_ipif_v3_0_4
vmap axi_intc_v4_1_7 msim/axi_intc_v4_1_7
vmap mdm_v3_2_6 msim/mdm_v3_2_6
vmap lib_cdc_v1_0_2 msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_9 msim/proc_sys_reset_v5_0_9
vmap dist_mem_gen_v8_0_10 msim/dist_mem_gen_v8_0_10
vmap lib_pkg_v1_0_2 msim/lib_pkg_v1_0_2
vmap lib_srl_fifo_v1_0_2 msim/lib_srl_fifo_v1_0_2
vmap fifo_generator_v13_1_1 msim/fifo_generator_v13_1_1
vmap lib_fifo_v1_0_5 msim/lib_fifo_v1_0_5
vmap interrupt_control_v3_1_4 msim/interrupt_control_v3_1_4
vmap axi_quad_spi_v3_2_8 msim/axi_quad_spi_v3_2_8
vmap axi_gpio_v2_0_11 msim/axi_gpio_v2_0_11
vmap axi_uart16550_v2_0_11 msim/axi_uart16550_v2_0_11
vmap axi_uartlite_v2_0_13 msim/axi_uartlite_v2_0_13
vmap generic_baseblocks_v2_1_0 msim/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 msim/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_9 msim/axi_register_slice_v2_1_9
vmap axi_data_fifo_v2_1_8 msim/axi_data_fifo_v2_1_8
vmap axi_crossbar_v2_1_10 msim/axi_crossbar_v2_1_10

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work microblaze_v9_6_1 -64 -93 \
"../../../ipstatic/microblaze_v9_6/hdl/microblaze_v9_6_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/embsys/ip/embsys_microblaze_0_0/sim/embsys_microblaze_0_0.vhd" \

vcom -work lmb_v10_v3_0_8 -64 -93 \
"../../../ipstatic/lmb_v10_v3_0/hdl/vhdl/lmb_v10.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/embsys/ip/embsys_dlmb_v10_0/sim/embsys_dlmb_v10_0.vhd" \
"../../../bd/embsys/ip/embsys_ilmb_v10_0/sim/embsys_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_9 -64 -93 \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/lmb_bram_if_funcs.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/lmb_bram_if_primitives.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/xor18.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/parity.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/parityenable.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/checkbit_handler.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/correct_one_bit.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/pselect_mask.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/axi_interface.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/lmb_mux.vhd" \
"../../../ipstatic/lmb_bram_if_cntlr_v4_0/hdl/vhdl/lmb_bram_if_cntlr.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/embsys/ip/embsys_dlmb_bram_if_cntlr_0/sim/embsys_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/embsys/ip/embsys_ilmb_bram_if_cntlr_0/sim/embsys_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_3_3 -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/blk_mem_gen_v8_3/simulation/blk_mem_gen_v8_3.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../bd/embsys/ip/embsys_lmb_bram_0/sim/embsys_lmb_bram_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93 \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/ipif_pkg.vhd" \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/pselect_f.vhd" \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/address_decoder.vhd" \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd" \
"../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/axi_lite_ipif.vhd" \

vcom -work axi_intc_v4_1_7 -64 -93 \
"../../../ipstatic/axi_intc_v4_1/hdl/src/vhdl/double_synchronizer.vhd" \
"../../../ipstatic/axi_intc_v4_1/hdl/src/vhdl/shared_ram_ivar.vhd" \
"../../../ipstatic/axi_intc_v4_1/hdl/src/vhdl/pulse_synchronizer.vhd" \
"../../../ipstatic/axi_intc_v4_1/hdl/src/vhdl/intc_core.vhd" \
"../../../ipstatic/axi_intc_v4_1/hdl/src/vhdl/axi_intc.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/embsys/ip/embsys_microblaze_0_axi_intc_0/sim/embsys_microblaze_0_axi_intc_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../bd/embsys/ipshared/xilinx.com/xlconcat_v2_1/xlconcat.v" \
"../../../bd/embsys/ip/embsys_microblaze_0_xlconcat_0/sim/embsys_microblaze_0_xlconcat_0.v" \

vcom -work mdm_v3_2_6 -64 -93 \
"../../../ipstatic/mdm_v3_2/hdl/vhdl/mdm_primitives.vhd" \
"../../../ipstatic/mdm_v3_2/hdl/vhdl/arbiter.vhd" \
"../../../ipstatic/mdm_v3_2/hdl/vhdl/srl_fifo.vhd" \
"../../../ipstatic/mdm_v3_2/hdl/vhdl/bus_master.vhd" \
"../../../ipstatic/mdm_v3_2/hdl/vhdl/jtag_control.vhd" \
"../../../ipstatic/mdm_v3_2/hdl/vhdl/mdm_core.vhd" \
"../../../ipstatic/mdm_v3_2/hdl/vhdl/mdm.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/embsys/ip/embsys_mdm_1_0/sim/embsys_mdm_1_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../bd/embsys/ip/embsys_clk_wiz_1_0/embsys_clk_wiz_1_0_clk_wiz.v" \
"../../../bd/embsys/ip/embsys_clk_wiz_1_0/embsys_clk_wiz_1_0.v" \

vcom -work lib_cdc_v1_0_2 -64 -93 \
"../../../ipstatic/lib_cdc_v1_0/hdl/src/vhdl/cdc_sync.vhd" \

vcom -work proc_sys_reset_v5_0_9 -64 -93 \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/upcnt_n.vhd" \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/sequence_psr.vhd" \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/lpf.vhd" \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/proc_sys_reset.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/embsys/ip/embsys_rst_clk_wiz_1_100M_0/sim/embsys_rst_clk_wiz_1_100M_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/nexys4io_v2_0/src/rgbpwm.v" \
"../../../ipstatic/nexys4io_v2_0/src/sevensegment.v" \
"../../../ipstatic/nexys4io_v2_0/src/debounce.v" \
"../../../ipstatic/nexys4io_v2_0/hdl/nexys4IO_v2_0_S00_AXI.v" \
"../../../ipstatic/nexys4io_v2_0/hdl/nexys4IO_v2_0.v" \
"../../../bd/embsys/ip/embsys_nexys4IO_0_0/sim/embsys_nexys4IO_0_0.v" \

vlog -work dist_mem_gen_v8_0_10 -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/dist_mem_gen_v8_0/simulation/dist_mem_gen_v8_0.v" \

vcom -work lib_pkg_v1_0_2 -64 -93 \
"../../../ipstatic/lib_pkg_v1_0/hdl/src/vhdl/lib_pkg.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -64 -93 \
"../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/cntr_incr_decr_addn_f.vhd" \
"../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/dynshreg_f.vhd" \
"../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_rbu_f.vhd" \
"../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_f.vhd" \

vlog -work fifo_generator_v13_1_1 -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/fifo_generator_v13_1/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_1 -64 -93 \
"../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_1 -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.v" \

vcom -work lib_fifo_v1_0_5 -64 -93 \
"../../../ipstatic/lib_fifo_v1_0/hdl/src/vhdl/async_fifo_fg.vhd" \
"../../../ipstatic/lib_fifo_v1_0/hdl/src/vhdl/sync_fifo_fg.vhd" \

vcom -work interrupt_control_v3_1_4 -64 -93 \
"../../../ipstatic/interrupt_control_v3_1/hdl/src/vhdl/interrupt_control.vhd" \

vcom -work axi_quad_spi_v3_2_8 -64 -93 \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/comp_defs.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/pselect_f.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/counter_f.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/soft_reset.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/xip_cross_clk_sync.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/reset_sync_module.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_status_slave_sel_reg.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_startup_block.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_receive_transmit_reg.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_occupancy_reg.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_mode_control_logic.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_mode_0_module.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_look_up_logic.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_fifo_ifmodule.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_cntrl_reg.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_address_decoder.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/cross_clk_sync_fifo_1.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/cross_clk_sync_fifo_0.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/xip_status_reg.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/xip_cntrl_reg.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/qspi_core_interface.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/axi_qspi_xip_if.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/axi_qspi_enhanced_mode.vhd" \
"../../../ipstatic/axi_quad_spi_v3_2/hdl/src/vhdl/axi_quad_spi.vhd" \
"../../../bd/embsys/ip/embsys_PmodOLEDrgb_0_0/ip/PmodOLEDrgb_axi_quad_spi_0_0/sim/PmodOLEDrgb_axi_quad_spi_0_0.vhd" \

vcom -work axi_gpio_v2_0_11 -64 -93 \
"../../../ipstatic/axi_gpio_v2_0/hdl/src/vhdl/gpio_core.vhd" \
"../../../ipstatic/axi_gpio_v2_0/hdl/src/vhdl/axi_gpio.vhd" \
"../../../bd/embsys/ip/embsys_PmodOLEDrgb_0_0/ip/PmodOLEDrgb_axi_gpio_0_1/sim/PmodOLEDrgb_axi_gpio_0_1.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ip/embsys_PmodOLEDrgb_0_0/ipshared/digilentinc.com/pmod_bridge_v1_0/src/pmod_concat.v" \
"../../../bd/embsys/ip/embsys_PmodOLEDrgb_0_0/ip/PmodOLEDrgb_pmod_bridge_0_0/sim/PmodOLEDrgb_pmod_bridge_0_0.v" \
"../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/digilentinc.com/pmodoledrgb_v1_0/hdl/PmodOLEDrgb_v1_0.v" \
"../../../bd/embsys/ip/embsys_PmodOLEDrgb_0_0/sim/embsys_PmodOLEDrgb_0_0.v" \

vcom -work axi_uart16550_v2_0_11 -64 -93 \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/rx_fifo_control.vhd" \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/xuart_tx_load_sm.vhd" \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/tx_fifo_block.vhd" \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/tx16550.vhd" \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/rx_fifo_block.vhd" \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/rx16550.vhd" \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/uart16550.vhd" \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/ipic_if.vhd" \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/xuart.vhd" \
"../../../ipstatic/axi_uart16550_v2_0/hdl/src/vhdl/axi_uart16550.vhd" \
"../../../bd/embsys/ip/embsys_PmodBT2_0_0/src/PmodBT2_axi_uart16550_0_0/sim/PmodBT2_axi_uart16550_0_0.vhd" \

vcom -work axi_gpio_v2_0_11 -64 -93 \
"../../../bd/embsys/ip/embsys_PmodBT2_0_0/src/PmodBT2_axi_gpio_0_0/sim/PmodBT2_axi_gpio_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../bd/embsys/ip/embsys_PmodBT2_0_0/src/PmodBT2_pmod_bridge_0_0/sim/PmodBT2_pmod_bridge_0_0.v" \
"../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/digilentinc.com/pmodbt2_v1_0/src/PmodBT2.v" \
"../../../bd/embsys/ip/embsys_PmodBT2_0_0/sim/embsys_PmodBT2_0_0.v" \

vcom -work axi_uartlite_v2_0_13 -64 -93 \
"../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/dynshreg_i_f.vhd" \
"../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/uartlite_tx.vhd" \
"../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/uartlite_rx.vhd" \
"../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/baudrate.vhd" \
"../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/uartlite_core.vhd" \
"../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/axi_uartlite.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/embsys/ip/embsys_axi_uartlite_0_0/sim/embsys_axi_uartlite_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_0 -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_and.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_or.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v" \
"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v" \
"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v" \

vlog -work axi_register_slice_v2_1_9 -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v" \
"../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v" \

vlog -work axi_data_fifo_v2_1_8 -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v" \

vlog -work axi_crossbar_v2_1_10 -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter_sasd.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_decoder.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_arbiter_resp.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar_sasd.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_decerr_slave.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_si_transactor.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_splitter.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_mux.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_router.v" \
"../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_axi_crossbar.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../bd/embsys/ip/embsys_xbar_0/sim/embsys_xbar_0.v" \
"../../../bd/embsys/hdl/embsys.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/embsys/ip/embsys_axi_gpio_0_0/sim/embsys_axi_gpio_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/clk_wiz_v5_3" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/hdl" "+incdir+../../../../ESP_Final_Project.srcs/sources_1/bd/embsys/ipshared/xilinx.com/regbleddriver_v1_0/src" \
"../../../bd/embsys/ip/embsys_REGBLedDriver_0_0/sim/embsys_REGBLedDriver_0_0.v" \

vlog -work xil_defaultlib "glbl.v"
