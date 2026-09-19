# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.18-s082_1 on Sat May 02 12:19:02 +06 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design MAC_4BIT

create_clock -name "SYS_CLOCK" -period 10.0 -waveform {0.0 5.0} [get_ports SYS_CLOCK]
set_false_path -from [get_ports SRST]
group_path -weight 1.000000 -name C2C -from [list \
  [get_cells {Y_reg[6]}]  \
  [get_cells {Y_reg[1]}]  \
  [get_cells {Y_reg[0]}]  \
  [get_cells {Y_reg[7]}]  \
  [get_cells {Y_reg[4]}]  \
  [get_cells {Y_reg[3]}]  \
  [get_cells {Y_reg[2]}]  \
  [get_cells {Y_reg[5]}] ] -to [list \
  [get_cells {Y_reg[6]}]  \
  [get_cells {Y_reg[1]}]  \
  [get_cells {Y_reg[0]}]  \
  [get_cells {Y_reg[7]}]  \
  [get_cells {Y_reg[4]}]  \
  [get_cells {Y_reg[3]}]  \
  [get_cells {Y_reg[2]}]  \
  [get_cells {Y_reg[5]}] ]
group_path -weight 1.000000 -name C2O -from [list \
  [get_cells {Y_reg[6]}]  \
  [get_cells {Y_reg[1]}]  \
  [get_cells {Y_reg[0]}]  \
  [get_cells {Y_reg[7]}]  \
  [get_cells {Y_reg[4]}]  \
  [get_cells {Y_reg[3]}]  \
  [get_cells {Y_reg[2]}]  \
  [get_cells {Y_reg[5]}] ] -to [list \
  [get_ports {Y[7]}]  \
  [get_ports {Y[6]}]  \
  [get_ports {Y[5]}]  \
  [get_ports {Y[4]}]  \
  [get_ports {Y[3]}]  \
  [get_ports {Y[2]}]  \
  [get_ports {Y[1]}]  \
  [get_ports {Y[0]}] ]
group_path -weight 1.000000 -name I2C -from [list \
  [get_ports SYS_CLOCK]  \
  [get_ports SRST]  \
  [get_ports {A[3]}]  \
  [get_ports {A[2]}]  \
  [get_ports {A[1]}]  \
  [get_ports {A[0]}]  \
  [get_ports {B[3]}]  \
  [get_ports {B[2]}]  \
  [get_ports {B[1]}]  \
  [get_ports {B[0]}] ] -to [list \
  [get_cells {Y_reg[6]}]  \
  [get_cells {Y_reg[1]}]  \
  [get_cells {Y_reg[0]}]  \
  [get_cells {Y_reg[7]}]  \
  [get_cells {Y_reg[4]}]  \
  [get_cells {Y_reg[3]}]  \
  [get_cells {Y_reg[2]}]  \
  [get_cells {Y_reg[5]}] ]
group_path -weight 1.000000 -name I2O -from [list \
  [get_ports SYS_CLOCK]  \
  [get_ports SRST]  \
  [get_ports {A[3]}]  \
  [get_ports {A[2]}]  \
  [get_ports {A[1]}]  \
  [get_ports {A[0]}]  \
  [get_ports {B[3]}]  \
  [get_ports {B[2]}]  \
  [get_ports {B[1]}]  \
  [get_ports {B[0]}] ] -to [list \
  [get_ports {Y[7]}]  \
  [get_ports {Y[6]}]  \
  [get_ports {Y[5]}]  \
  [get_ports {Y[4]}]  \
  [get_ports {Y[3]}]  \
  [get_ports {Y[2]}]  \
  [get_ports {Y[1]}]  \
  [get_ports {Y[0]}] ]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports SRST]
set_input_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {A[3]}]
set_input_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {A[2]}]
set_input_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {A[1]}]
set_input_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {A[0]}]
set_input_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {B[3]}]
set_input_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {B[2]}]
set_input_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {B[1]}]
set_input_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {B[0]}]
set_output_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {Y[7]}]
set_output_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {Y[6]}]
set_output_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {Y[5]}]
set_output_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {Y[4]}]
set_output_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {Y[3]}]
set_output_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {Y[2]}]
set_output_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {Y[1]}]
set_output_delay -clock [get_clocks SYS_CLOCK] -add_delay 0.0 [get_ports {Y[0]}]
