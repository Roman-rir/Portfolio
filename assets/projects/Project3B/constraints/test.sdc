create_clock -name CLK -period $CLK_PERIOD [get_ports $CLK_PORT]

set data_inputs [remove_from_collection [all_inputs] [get_ports $CLK_PORT]]
set data_inputs [remove_from_collection $data_inputs [get_ports RST]]

set_input_delay 0.0 -clock SYS_CLOCK $data_inputs
set_output_delay 0.0 -clock SYS_CLOCK [all_outputs]


