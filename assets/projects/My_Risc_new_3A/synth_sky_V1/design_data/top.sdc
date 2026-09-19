create_clock -name SYS_CLOCK -period 10.000 [get_ports SYS_CLOCK]

set data_inputs [remove_from_collection [all_inputs] [get_ports SYS_CLOCK]]
set data_inputs [remove_from_collection $data_inputs [get_ports RST]]

set_input_delay 0.0 -clock SYS_CLOCK $data_inputs
set_output_delay 0.0 -clock SYS_CLOCK [all_outputs]
