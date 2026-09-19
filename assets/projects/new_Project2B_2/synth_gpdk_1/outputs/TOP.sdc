# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.18-s082_1 on Sat Jun 13 07:48:56 +06 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design TOP

create_clock -name "SYS_CLK" -period 5.0 -waveform {0.0 2.5} [get_ports SYS_CLK]
group_path -weight 1.000000 -name C2C -from [list \
  [get_cells {D2_REG1_reg[4]}]  \
  [get_cells {D2_REG1_reg[1]}]  \
  [get_cells {D2_REG1_reg[12]}]  \
  [get_cells {D2_REG1_reg[13]}]  \
  [get_cells {D2_REG1_reg[2]}]  \
  [get_cells {D2_REG1_reg[3]}]  \
  [get_cells {D2_REG1_reg[0]}]  \
  [get_cells {D2_REG1_reg[11]}]  \
  [get_cells {D2_REG1_reg[6]}]  \
  [get_cells {D2_REG1_reg[7]}]  \
  [get_cells {D2_REG1_reg[8]}]  \
  [get_cells {D2_REG1_reg[9]}]  \
  [get_cells {D2_REG1_reg[10]}]  \
  [get_cells {D2_REG1_reg[5]}]  \
  [get_cells {D2_X_REG_reg[0]}]  \
  [get_cells {D2_X_REG_reg[1]}]  \
  [get_cells {D2_Y_REG_reg[13]}]  \
  [get_cells {D2_X_REG_reg[3]}]  \
  [get_cells {D2_Y_REG_reg[0]}]  \
  [get_cells {D2_Y_REG_reg[1]}]  \
  [get_cells {D2_Y_REG_reg[2]}]  \
  [get_cells {D2_Y_REG_reg[3]}]  \
  [get_cells {D2_Y_REG_reg[4]}]  \
  [get_cells {D2_Y_REG_reg[5]}]  \
  [get_cells {D2_Y_REG_reg[6]}]  \
  [get_cells {D2_Y_REG_reg[7]}]  \
  [get_cells {D2_Y_REG_reg[8]}]  \
  [get_cells {D2_Y_REG_reg[9]}]  \
  [get_cells {D2_Y_REG_reg[10]}]  \
  [get_cells {D2_Y_REG_reg[11]}]  \
  [get_cells {D2_Y_REG_reg[12]}]  \
  [get_cells {D2_X_REG_reg[2]}]  \
  [get_cells {F1_P_STATE_reg[0]}]  \
  [get_cells {F1_P_STATE_reg[1]}]  \
  [get_cells {F1_P_STATE_reg[2]}] ] -to [list \
  [get_cells {D2_REG1_reg[4]}]  \
  [get_cells {D2_REG1_reg[1]}]  \
  [get_cells {D2_REG1_reg[12]}]  \
  [get_cells {D2_REG1_reg[13]}]  \
  [get_cells {D2_REG1_reg[2]}]  \
  [get_cells {D2_REG1_reg[3]}]  \
  [get_cells {D2_REG1_reg[0]}]  \
  [get_cells {D2_REG1_reg[11]}]  \
  [get_cells {D2_REG1_reg[6]}]  \
  [get_cells {D2_REG1_reg[7]}]  \
  [get_cells {D2_REG1_reg[8]}]  \
  [get_cells {D2_REG1_reg[9]}]  \
  [get_cells {D2_REG1_reg[10]}]  \
  [get_cells {D2_REG1_reg[5]}]  \
  [get_cells {D2_X_REG_reg[0]}]  \
  [get_cells {D2_X_REG_reg[1]}]  \
  [get_cells {D2_Y_REG_reg[13]}]  \
  [get_cells {D2_X_REG_reg[3]}]  \
  [get_cells {D2_Y_REG_reg[0]}]  \
  [get_cells {D2_Y_REG_reg[1]}]  \
  [get_cells {D2_Y_REG_reg[2]}]  \
  [get_cells {D2_Y_REG_reg[3]}]  \
  [get_cells {D2_Y_REG_reg[4]}]  \
  [get_cells {D2_Y_REG_reg[5]}]  \
  [get_cells {D2_Y_REG_reg[6]}]  \
  [get_cells {D2_Y_REG_reg[7]}]  \
  [get_cells {D2_Y_REG_reg[8]}]  \
  [get_cells {D2_Y_REG_reg[9]}]  \
  [get_cells {D2_Y_REG_reg[10]}]  \
  [get_cells {D2_Y_REG_reg[11]}]  \
  [get_cells {D2_Y_REG_reg[12]}]  \
  [get_cells {D2_X_REG_reg[2]}]  \
  [get_cells {F1_P_STATE_reg[0]}]  \
  [get_cells {F1_P_STATE_reg[1]}]  \
  [get_cells {F1_P_STATE_reg[2]}] ]
group_path -weight 1.000000 -name C2O -from [list \
  [get_cells {D2_REG1_reg[4]}]  \
  [get_cells {D2_REG1_reg[1]}]  \
  [get_cells {D2_REG1_reg[12]}]  \
  [get_cells {D2_REG1_reg[13]}]  \
  [get_cells {D2_REG1_reg[2]}]  \
  [get_cells {D2_REG1_reg[3]}]  \
  [get_cells {D2_REG1_reg[0]}]  \
  [get_cells {D2_REG1_reg[11]}]  \
  [get_cells {D2_REG1_reg[6]}]  \
  [get_cells {D2_REG1_reg[7]}]  \
  [get_cells {D2_REG1_reg[8]}]  \
  [get_cells {D2_REG1_reg[9]}]  \
  [get_cells {D2_REG1_reg[10]}]  \
  [get_cells {D2_REG1_reg[5]}]  \
  [get_cells {D2_X_REG_reg[0]}]  \
  [get_cells {D2_X_REG_reg[1]}]  \
  [get_cells {D2_Y_REG_reg[13]}]  \
  [get_cells {D2_X_REG_reg[3]}]  \
  [get_cells {D2_Y_REG_reg[0]}]  \
  [get_cells {D2_Y_REG_reg[1]}]  \
  [get_cells {D2_Y_REG_reg[2]}]  \
  [get_cells {D2_Y_REG_reg[3]}]  \
  [get_cells {D2_Y_REG_reg[4]}]  \
  [get_cells {D2_Y_REG_reg[5]}]  \
  [get_cells {D2_Y_REG_reg[6]}]  \
  [get_cells {D2_Y_REG_reg[7]}]  \
  [get_cells {D2_Y_REG_reg[8]}]  \
  [get_cells {D2_Y_REG_reg[9]}]  \
  [get_cells {D2_Y_REG_reg[10]}]  \
  [get_cells {D2_Y_REG_reg[11]}]  \
  [get_cells {D2_Y_REG_reg[12]}]  \
  [get_cells {D2_X_REG_reg[2]}]  \
  [get_cells {F1_P_STATE_reg[0]}]  \
  [get_cells {F1_P_STATE_reg[1]}]  \
  [get_cells {F1_P_STATE_reg[2]}] ] -to [list \
  [get_ports {Y_REG[13]}]  \
  [get_ports {Y_REG[12]}]  \
  [get_ports {Y_REG[11]}]  \
  [get_ports {Y_REG[10]}]  \
  [get_ports {Y_REG[9]}]  \
  [get_ports {Y_REG[8]}]  \
  [get_ports {Y_REG[7]}]  \
  [get_ports {Y_REG[6]}]  \
  [get_ports {Y_REG[5]}]  \
  [get_ports {Y_REG[4]}]  \
  [get_ports {Y_REG[3]}]  \
  [get_ports {Y_REG[2]}]  \
  [get_ports {Y_REG[1]}]  \
  [get_ports {Y_REG[0]}] ]
group_path -weight 1.000000 -name I2C -from [list \
  [get_ports SYS_CLK]  \
  [get_ports FSM_ARESET]  \
  [get_ports GO]  \
  [get_ports STOP]  \
  [get_ports {X[3]}]  \
  [get_ports {X[2]}]  \
  [get_ports {X[1]}]  \
  [get_ports {X[0]}] ] -to [list \
  [get_cells {D2_REG1_reg[4]}]  \
  [get_cells {D2_REG1_reg[1]}]  \
  [get_cells {D2_REG1_reg[12]}]  \
  [get_cells {D2_REG1_reg[13]}]  \
  [get_cells {D2_REG1_reg[2]}]  \
  [get_cells {D2_REG1_reg[3]}]  \
  [get_cells {D2_REG1_reg[0]}]  \
  [get_cells {D2_REG1_reg[11]}]  \
  [get_cells {D2_REG1_reg[6]}]  \
  [get_cells {D2_REG1_reg[7]}]  \
  [get_cells {D2_REG1_reg[8]}]  \
  [get_cells {D2_REG1_reg[9]}]  \
  [get_cells {D2_REG1_reg[10]}]  \
  [get_cells {D2_REG1_reg[5]}]  \
  [get_cells {D2_X_REG_reg[0]}]  \
  [get_cells {D2_X_REG_reg[1]}]  \
  [get_cells {D2_Y_REG_reg[13]}]  \
  [get_cells {D2_X_REG_reg[3]}]  \
  [get_cells {D2_Y_REG_reg[0]}]  \
  [get_cells {D2_Y_REG_reg[1]}]  \
  [get_cells {D2_Y_REG_reg[2]}]  \
  [get_cells {D2_Y_REG_reg[3]}]  \
  [get_cells {D2_Y_REG_reg[4]}]  \
  [get_cells {D2_Y_REG_reg[5]}]  \
  [get_cells {D2_Y_REG_reg[6]}]  \
  [get_cells {D2_Y_REG_reg[7]}]  \
  [get_cells {D2_Y_REG_reg[8]}]  \
  [get_cells {D2_Y_REG_reg[9]}]  \
  [get_cells {D2_Y_REG_reg[10]}]  \
  [get_cells {D2_Y_REG_reg[11]}]  \
  [get_cells {D2_Y_REG_reg[12]}]  \
  [get_cells {D2_X_REG_reg[2]}]  \
  [get_cells {F1_P_STATE_reg[0]}]  \
  [get_cells {F1_P_STATE_reg[1]}]  \
  [get_cells {F1_P_STATE_reg[2]}] ]
group_path -weight 1.000000 -name I2O -from [list \
  [get_ports SYS_CLK]  \
  [get_ports FSM_ARESET]  \
  [get_ports GO]  \
  [get_ports STOP]  \
  [get_ports {X[3]}]  \
  [get_ports {X[2]}]  \
  [get_ports {X[1]}]  \
  [get_ports {X[0]}] ] -to [list \
  [get_ports {Y_REG[13]}]  \
  [get_ports {Y_REG[12]}]  \
  [get_ports {Y_REG[11]}]  \
  [get_ports {Y_REG[10]}]  \
  [get_ports {Y_REG[9]}]  \
  [get_ports {Y_REG[8]}]  \
  [get_ports {Y_REG[7]}]  \
  [get_ports {Y_REG[6]}]  \
  [get_ports {Y_REG[5]}]  \
  [get_ports {Y_REG[4]}]  \
  [get_ports {Y_REG[3]}]  \
  [get_ports {Y_REG[2]}]  \
  [get_ports {Y_REG[1]}]  \
  [get_ports {Y_REG[0]}] ]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports FSM_ARESET]
set_input_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports GO]
set_input_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports STOP]
set_input_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {X[3]}]
set_input_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {X[2]}]
set_input_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {X[1]}]
set_input_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {X[0]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[13]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[12]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[11]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[10]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[9]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[8]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[7]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[6]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[5]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[4]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[3]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[2]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[1]}]
set_output_delay -clock [get_clocks SYS_CLK] -add_delay 0.1 [get_ports {Y_REG[0]}]
