create_clock -name SYS_CLK -period 5.0 [get_ports SYS_CLK]

set data_inputs [remove_from_collection [all_inputs] [get_ports SYS_CLK]]

set_input_delay 0.1 -clock SYS_CLK $data_inputs

set_output_delay 0.1 -clock SYS_CLK [all_outputs]

