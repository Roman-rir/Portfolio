# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.18-s082_1 on Mon Jun 22 19:49:01 +06 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design RISC_V3

create_clock -name "CLK" -period 5.0 -waveform {0.0 2.5} [get_ports SYS_CLOCK]
group_path -weight 1.000000 -name C2C -from [list \
  [get_cells {PC1_PC_reg[3]}]  \
  [get_cells {PC1_PC_reg[1]}]  \
  [get_cells {PC1_PC_reg[2]}]  \
  [get_cells {PC1_PC_reg[0]}]  \
  [get_cells {PC1_PSTATE_reg[0]}]  \
  [get_cells {PC1_PSTATE_reg[1]}] ] -to [list \
  [get_cells {PC1_PC_reg[3]}]  \
  [get_cells {PC1_PC_reg[1]}]  \
  [get_cells {PC1_PC_reg[2]}]  \
  [get_cells {PC1_PC_reg[0]}]  \
  [get_cells {PC1_PSTATE_reg[0]}]  \
  [get_cells {PC1_PSTATE_reg[1]}] ]
group_path -weight 1.000000 -name C2O -from [list \
  [get_cells {PC1_PC_reg[3]}]  \
  [get_cells {PC1_PC_reg[1]}]  \
  [get_cells {PC1_PC_reg[2]}]  \
  [get_cells {PC1_PC_reg[0]}]  \
  [get_cells {PC1_PSTATE_reg[0]}]  \
  [get_cells {PC1_PSTATE_reg[1]}] ] -to [list \
  [get_ports {DM_IN[31]}]  \
  [get_ports {DM_IN[30]}]  \
  [get_ports {DM_IN[29]}]  \
  [get_ports {DM_IN[28]}]  \
  [get_ports {DM_IN[27]}]  \
  [get_ports {DM_IN[26]}]  \
  [get_ports {DM_IN[25]}]  \
  [get_ports {DM_IN[24]}]  \
  [get_ports {DM_IN[23]}]  \
  [get_ports {DM_IN[22]}]  \
  [get_ports {DM_IN[21]}]  \
  [get_ports {DM_IN[20]}]  \
  [get_ports {DM_IN[19]}]  \
  [get_ports {DM_IN[18]}]  \
  [get_ports {DM_IN[17]}]  \
  [get_ports {DM_IN[16]}]  \
  [get_ports {DM_IN[15]}]  \
  [get_ports {DM_IN[14]}]  \
  [get_ports {DM_IN[13]}]  \
  [get_ports {DM_IN[12]}]  \
  [get_ports {DM_IN[11]}]  \
  [get_ports {DM_IN[10]}]  \
  [get_ports {DM_IN[9]}]  \
  [get_ports {DM_IN[8]}]  \
  [get_ports {DM_IN[7]}]  \
  [get_ports {DM_IN[6]}]  \
  [get_ports {DM_IN[5]}]  \
  [get_ports {DM_IN[4]}]  \
  [get_ports {DM_IN[3]}]  \
  [get_ports {DM_IN[2]}]  \
  [get_ports {DM_IN[1]}]  \
  [get_ports {DM_IN[0]}]  \
  [get_ports {PC[3]}]  \
  [get_ports {PC[2]}]  \
  [get_ports {PC[1]}]  \
  [get_ports {PC[0]}]  \
  [get_ports {DM_ADDR[3]}]  \
  [get_ports {DM_ADDR[2]}]  \
  [get_ports {DM_ADDR[1]}]  \
  [get_ports {DM_ADDR[0]}]  \
  [get_ports DM_WR]  \
  [get_ports {IR[31]}]  \
  [get_ports {IR[30]}]  \
  [get_ports {IR[29]}]  \
  [get_ports {IR[28]}]  \
  [get_ports {IR[27]}]  \
  [get_ports {IR[26]}]  \
  [get_ports {IR[25]}]  \
  [get_ports {IR[24]}]  \
  [get_ports {IR[23]}]  \
  [get_ports {IR[22]}]  \
  [get_ports {IR[21]}]  \
  [get_ports {IR[20]}]  \
  [get_ports {IR[19]}]  \
  [get_ports {IR[18]}]  \
  [get_ports {IR[17]}]  \
  [get_ports {IR[16]}]  \
  [get_ports {IR[15]}]  \
  [get_ports {IR[14]}]  \
  [get_ports {IR[13]}]  \
  [get_ports {IR[12]}]  \
  [get_ports {IR[11]}]  \
  [get_ports {IR[10]}]  \
  [get_ports {IR[9]}]  \
  [get_ports {IR[8]}]  \
  [get_ports {IR[7]}]  \
  [get_ports {IR[6]}]  \
  [get_ports {IR[5]}]  \
  [get_ports {IR[4]}]  \
  [get_ports {IR[3]}]  \
  [get_ports {IR[2]}]  \
  [get_ports {IR[1]}]  \
  [get_ports {IR[0]}]  \
  [get_ports {ACCUM_R[31]}]  \
  [get_ports {ACCUM_R[30]}]  \
  [get_ports {ACCUM_R[29]}]  \
  [get_ports {ACCUM_R[28]}]  \
  [get_ports {ACCUM_R[27]}]  \
  [get_ports {ACCUM_R[26]}]  \
  [get_ports {ACCUM_R[25]}]  \
  [get_ports {ACCUM_R[24]}]  \
  [get_ports {ACCUM_R[23]}]  \
  [get_ports {ACCUM_R[22]}]  \
  [get_ports {ACCUM_R[21]}]  \
  [get_ports {ACCUM_R[20]}]  \
  [get_ports {ACCUM_R[19]}]  \
  [get_ports {ACCUM_R[18]}]  \
  [get_ports {ACCUM_R[17]}]  \
  [get_ports {ACCUM_R[16]}]  \
  [get_ports {ACCUM_R[15]}]  \
  [get_ports {ACCUM_R[14]}]  \
  [get_ports {ACCUM_R[13]}]  \
  [get_ports {ACCUM_R[12]}]  \
  [get_ports {ACCUM_R[11]}]  \
  [get_ports {ACCUM_R[10]}]  \
  [get_ports {ACCUM_R[9]}]  \
  [get_ports {ACCUM_R[8]}]  \
  [get_ports {ACCUM_R[7]}]  \
  [get_ports {ACCUM_R[6]}]  \
  [get_ports {ACCUM_R[5]}]  \
  [get_ports {ACCUM_R[4]}]  \
  [get_ports {ACCUM_R[3]}]  \
  [get_ports {ACCUM_R[2]}]  \
  [get_ports {ACCUM_R[1]}]  \
  [get_ports {ACCUM_R[0]}]  \
  [get_ports {PSTATE[2]}]  \
  [get_ports {PSTATE[1]}]  \
  [get_ports {PSTATE[0]}] ]
group_path -weight 1.000000 -name I2C -from [list \
  [get_ports SYS_CLOCK]  \
  [get_ports RST] ] -to [list \
  [get_cells {PC1_PC_reg[3]}]  \
  [get_cells {PC1_PC_reg[1]}]  \
  [get_cells {PC1_PC_reg[2]}]  \
  [get_cells {PC1_PC_reg[0]}]  \
  [get_cells {PC1_PSTATE_reg[0]}]  \
  [get_cells {PC1_PSTATE_reg[1]}] ]
group_path -weight 1.000000 -name I2O -from [list \
  [get_ports SYS_CLOCK]  \
  [get_ports RST] ] -to [list \
  [get_ports {DM_IN[31]}]  \
  [get_ports {DM_IN[30]}]  \
  [get_ports {DM_IN[29]}]  \
  [get_ports {DM_IN[28]}]  \
  [get_ports {DM_IN[27]}]  \
  [get_ports {DM_IN[26]}]  \
  [get_ports {DM_IN[25]}]  \
  [get_ports {DM_IN[24]}]  \
  [get_ports {DM_IN[23]}]  \
  [get_ports {DM_IN[22]}]  \
  [get_ports {DM_IN[21]}]  \
  [get_ports {DM_IN[20]}]  \
  [get_ports {DM_IN[19]}]  \
  [get_ports {DM_IN[18]}]  \
  [get_ports {DM_IN[17]}]  \
  [get_ports {DM_IN[16]}]  \
  [get_ports {DM_IN[15]}]  \
  [get_ports {DM_IN[14]}]  \
  [get_ports {DM_IN[13]}]  \
  [get_ports {DM_IN[12]}]  \
  [get_ports {DM_IN[11]}]  \
  [get_ports {DM_IN[10]}]  \
  [get_ports {DM_IN[9]}]  \
  [get_ports {DM_IN[8]}]  \
  [get_ports {DM_IN[7]}]  \
  [get_ports {DM_IN[6]}]  \
  [get_ports {DM_IN[5]}]  \
  [get_ports {DM_IN[4]}]  \
  [get_ports {DM_IN[3]}]  \
  [get_ports {DM_IN[2]}]  \
  [get_ports {DM_IN[1]}]  \
  [get_ports {DM_IN[0]}]  \
  [get_ports {PC[3]}]  \
  [get_ports {PC[2]}]  \
  [get_ports {PC[1]}]  \
  [get_ports {PC[0]}]  \
  [get_ports {DM_ADDR[3]}]  \
  [get_ports {DM_ADDR[2]}]  \
  [get_ports {DM_ADDR[1]}]  \
  [get_ports {DM_ADDR[0]}]  \
  [get_ports DM_WR]  \
  [get_ports {IR[31]}]  \
  [get_ports {IR[30]}]  \
  [get_ports {IR[29]}]  \
  [get_ports {IR[28]}]  \
  [get_ports {IR[27]}]  \
  [get_ports {IR[26]}]  \
  [get_ports {IR[25]}]  \
  [get_ports {IR[24]}]  \
  [get_ports {IR[23]}]  \
  [get_ports {IR[22]}]  \
  [get_ports {IR[21]}]  \
  [get_ports {IR[20]}]  \
  [get_ports {IR[19]}]  \
  [get_ports {IR[18]}]  \
  [get_ports {IR[17]}]  \
  [get_ports {IR[16]}]  \
  [get_ports {IR[15]}]  \
  [get_ports {IR[14]}]  \
  [get_ports {IR[13]}]  \
  [get_ports {IR[12]}]  \
  [get_ports {IR[11]}]  \
  [get_ports {IR[10]}]  \
  [get_ports {IR[9]}]  \
  [get_ports {IR[8]}]  \
  [get_ports {IR[7]}]  \
  [get_ports {IR[6]}]  \
  [get_ports {IR[5]}]  \
  [get_ports {IR[4]}]  \
  [get_ports {IR[3]}]  \
  [get_ports {IR[2]}]  \
  [get_ports {IR[1]}]  \
  [get_ports {IR[0]}]  \
  [get_ports {ACCUM_R[31]}]  \
  [get_ports {ACCUM_R[30]}]  \
  [get_ports {ACCUM_R[29]}]  \
  [get_ports {ACCUM_R[28]}]  \
  [get_ports {ACCUM_R[27]}]  \
  [get_ports {ACCUM_R[26]}]  \
  [get_ports {ACCUM_R[25]}]  \
  [get_ports {ACCUM_R[24]}]  \
  [get_ports {ACCUM_R[23]}]  \
  [get_ports {ACCUM_R[22]}]  \
  [get_ports {ACCUM_R[21]}]  \
  [get_ports {ACCUM_R[20]}]  \
  [get_ports {ACCUM_R[19]}]  \
  [get_ports {ACCUM_R[18]}]  \
  [get_ports {ACCUM_R[17]}]  \
  [get_ports {ACCUM_R[16]}]  \
  [get_ports {ACCUM_R[15]}]  \
  [get_ports {ACCUM_R[14]}]  \
  [get_ports {ACCUM_R[13]}]  \
  [get_ports {ACCUM_R[12]}]  \
  [get_ports {ACCUM_R[11]}]  \
  [get_ports {ACCUM_R[10]}]  \
  [get_ports {ACCUM_R[9]}]  \
  [get_ports {ACCUM_R[8]}]  \
  [get_ports {ACCUM_R[7]}]  \
  [get_ports {ACCUM_R[6]}]  \
  [get_ports {ACCUM_R[5]}]  \
  [get_ports {ACCUM_R[4]}]  \
  [get_ports {ACCUM_R[3]}]  \
  [get_ports {ACCUM_R[2]}]  \
  [get_ports {ACCUM_R[1]}]  \
  [get_ports {ACCUM_R[0]}]  \
  [get_ports {PSTATE[2]}]  \
  [get_ports {PSTATE[1]}]  \
  [get_ports {PSTATE[0]}] ]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports RST]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[31]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[30]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[29]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[28]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[27]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[26]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[25]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[24]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[23]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[22]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[21]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[20]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[19]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[18]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[17]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[16]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[15]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[14]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[13]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[12]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[11]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[10]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[9]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[8]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[7]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[6]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[5]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[4]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[3]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[2]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[1]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_IN[0]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {PC[3]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {PC[2]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {PC[1]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {PC[0]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_ADDR[3]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_ADDR[2]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_ADDR[1]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {DM_ADDR[0]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports DM_WR]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[31]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[30]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[29]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[28]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[27]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[26]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[25]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[24]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[23]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[22]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[21]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[20]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[19]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[18]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[17]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[16]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[15]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[14]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[13]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[12]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[11]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[10]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[9]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[8]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[7]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[6]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[5]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[4]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[3]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[2]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[1]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {IR[0]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[31]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[30]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[29]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[28]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[27]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[26]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[25]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[24]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[23]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[22]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[21]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[20]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[19]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[18]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[17]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[16]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[15]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[14]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[13]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[12]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[11]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[10]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[9]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[8]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[7]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[6]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[5]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[4]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[3]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[2]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[1]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {ACCUM_R[0]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {PSTATE[2]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {PSTATE[1]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {PSTATE[0]}]
