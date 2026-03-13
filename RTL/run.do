vdel -lib work -all
vlib work
vlog -f src_files_IF_stage.list
vsim -voptargs=+acc work.MIPS_tb
add wave *
add wave -position insertpoint  \
sim:/MIPS_tb/dut/U_datapath/DATA_MEM/address \
sim:/MIPS_tb/dut/U_datapath/DATA_MEM/write_data \
sim:/MIPS_tb/dut/U_datapath/DATA_MEM/clk \
sim:/MIPS_tb/dut/U_datapath/DATA_MEM/MemWrite \
sim:/MIPS_tb/dut/U_datapath/DATA_MEM/MemRead \
sim:/MIPS_tb/dut/U_datapath/DATA_MEM/read_data \
sim:/MIPS_tb/dut/U_datapath/DATA_MEM/data_mem

add wave -position insertpoint  \
sim:/MIPS_tb/dut/U_datapath/U_IF/next_pc \
sim:/MIPS_tb/dut/U_datapath/U_IF/rst \
sim:/MIPS_tb/dut/U_datapath/U_IF/clk \
sim:/MIPS_tb/dut/U_datapath/U_IF/instruction \
sim:/MIPS_tb/dut/U_datapath/U_IF/pc_plus4 \
sim:/MIPS_tb/dut/U_datapath/U_IF/read_address

add wave -position insertpoint  \
sim:/MIPS_tb/dut/U_datapath/U2_PCSrc/WIDTH \
sim:/MIPS_tb/dut/U_datapath/U2_PCSrc/in1 \
sim:/MIPS_tb/dut/U_datapath/U2_PCSrc/in2 \
sim:/MIPS_tb/dut/U_datapath/U2_PCSrc/sel \
sim:/MIPS_tb/dut/U_datapath/U2_PCSrc/out

add wave -position insertpoint  \
sim:/MIPS_tb/dut/U_control_unit/Jump

add wave -position insertpoint  \
sim:/MIPS_tb/dut/U_control_unit/opcode

add wave -position insertpoint  \
sim:/MIPS_tb/dut/U_datapath/U_EX/reg_file/registers

run -all
#quit -sim