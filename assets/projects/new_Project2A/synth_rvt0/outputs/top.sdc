# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.18-s082_1 on Sat May 02 11:45:15 +06 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design top

create_clock -name "CLK" -period 4.384 -waveform {0.0 2.192} [get_ports SYS_CLOCK]
set_false_path -from [get_ports SRST]
group_path -weight 1.000000 -name C2C -from [list \
  [get_cells {Y_reg[9]}]  \
  [get_cells {Y_reg[8]}]  \
  [get_cells {Y_reg[6]}]  \
  [get_cells {Y_reg[2]}]  \
  [get_cells {Y_reg[1]}]  \
  [get_cells {Y_reg[5]}]  \
  [get_cells {Y_reg[0]}]  \
  [get_cells {Y_reg[7]}]  \
  [get_cells {Y_reg[4]}]  \
  [get_cells {Y_reg[3]}] ] -to [list \
  [get_cells {Y_reg[9]}]  \
  [get_cells {Y_reg[8]}]  \
  [get_cells {Y_reg[6]}]  \
  [get_cells {Y_reg[2]}]  \
  [get_cells {Y_reg[1]}]  \
  [get_cells {Y_reg[5]}]  \
  [get_cells {Y_reg[0]}]  \
  [get_cells {Y_reg[7]}]  \
  [get_cells {Y_reg[4]}]  \
  [get_cells {Y_reg[3]}] ]
group_path -weight 1.000000 -name C2O -from [list \
  [get_cells {Y_reg[9]}]  \
  [get_cells {Y_reg[8]}]  \
  [get_cells {Y_reg[6]}]  \
  [get_cells {Y_reg[2]}]  \
  [get_cells {Y_reg[1]}]  \
  [get_cells {Y_reg[5]}]  \
  [get_cells {Y_reg[0]}]  \
  [get_cells {Y_reg[7]}]  \
  [get_cells {Y_reg[4]}]  \
  [get_cells {Y_reg[3]}] ] -to [list \
  [get_ports {Y[9]}]  \
  [get_ports {Y[8]}]  \
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
  [get_ports {X0[3]}]  \
  [get_ports {X0[2]}]  \
  [get_ports {X0[1]}]  \
  [get_ports {X0[0]}]  \
  [get_ports {X1[3]}]  \
  [get_ports {X1[2]}]  \
  [get_ports {X1[1]}]  \
  [get_ports {X1[0]}]  \
  [get_ports {X2[3]}]  \
  [get_ports {X2[2]}]  \
  [get_ports {X2[1]}]  \
  [get_ports {X2[0]}]  \
  [get_ports {X3[3]}]  \
  [get_ports {X3[2]}]  \
  [get_ports {X3[1]}]  \
  [get_ports {X3[0]}]  \
  [get_ports {C0[3]}]  \
  [get_ports {C0[2]}]  \
  [get_ports {C0[1]}]  \
  [get_ports {C0[0]}]  \
  [get_ports {C1[3]}]  \
  [get_ports {C1[2]}]  \
  [get_ports {C1[1]}]  \
  [get_ports {C1[0]}]  \
  [get_ports {C2[3]}]  \
  [get_ports {C2[2]}]  \
  [get_ports {C2[1]}]  \
  [get_ports {C2[0]}]  \
  [get_ports {C3[3]}]  \
  [get_ports {C3[2]}]  \
  [get_ports {C3[1]}]  \
  [get_ports {C3[0]}] ] -to [list \
  [get_cells {Y_reg[9]}]  \
  [get_cells {Y_reg[8]}]  \
  [get_cells {Y_reg[6]}]  \
  [get_cells {Y_reg[2]}]  \
  [get_cells {Y_reg[1]}]  \
  [get_cells {Y_reg[5]}]  \
  [get_cells {Y_reg[0]}]  \
  [get_cells {Y_reg[7]}]  \
  [get_cells {Y_reg[4]}]  \
  [get_cells {Y_reg[3]}] ]
group_path -weight 1.000000 -name I2O -from [list \
  [get_ports SYS_CLOCK]  \
  [get_ports SRST]  \
  [get_ports {X0[3]}]  \
  [get_ports {X0[2]}]  \
  [get_ports {X0[1]}]  \
  [get_ports {X0[0]}]  \
  [get_ports {X1[3]}]  \
  [get_ports {X1[2]}]  \
  [get_ports {X1[1]}]  \
  [get_ports {X1[0]}]  \
  [get_ports {X2[3]}]  \
  [get_ports {X2[2]}]  \
  [get_ports {X2[1]}]  \
  [get_ports {X2[0]}]  \
  [get_ports {X3[3]}]  \
  [get_ports {X3[2]}]  \
  [get_ports {X3[1]}]  \
  [get_ports {X3[0]}]  \
  [get_ports {C0[3]}]  \
  [get_ports {C0[2]}]  \
  [get_ports {C0[1]}]  \
  [get_ports {C0[0]}]  \
  [get_ports {C1[3]}]  \
  [get_ports {C1[2]}]  \
  [get_ports {C1[1]}]  \
  [get_ports {C1[0]}]  \
  [get_ports {C2[3]}]  \
  [get_ports {C2[2]}]  \
  [get_ports {C2[1]}]  \
  [get_ports {C2[0]}]  \
  [get_ports {C3[3]}]  \
  [get_ports {C3[2]}]  \
  [get_ports {C3[1]}]  \
  [get_ports {C3[0]}] ] -to [list \
  [get_ports {Y[9]}]  \
  [get_ports {Y[8]}]  \
  [get_ports {Y[7]}]  \
  [get_ports {Y[6]}]  \
  [get_ports {Y[5]}]  \
  [get_ports {Y[4]}]  \
  [get_ports {Y[3]}]  \
  [get_ports {Y[2]}]  \
  [get_ports {Y[1]}]  \
  [get_ports {Y[0]}] ]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports SRST]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X0[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X0[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X0[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X0[0]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X1[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X1[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X1[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X1[0]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X2[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X2[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X2[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X2[0]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X3[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X3[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X3[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {X3[0]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C0[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C0[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C0[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C0[0]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C1[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C1[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C1[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C1[0]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C2[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C2[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C2[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C2[0]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C3[3]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C3[2]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C3[1]}]
set_input_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {C3[0]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[9]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[8]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[7]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[6]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[5]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[4]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[3]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[2]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[1]}]
set_output_delay -clock [get_clocks CLK] -add_delay 0.0 [get_ports {Y[0]}]
