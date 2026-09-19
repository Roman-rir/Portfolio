create_clock -name CLK -period $CLK_PERIOD [get_ports $CLK_PORT]
 
set data_inputs [remove_from_collection [all_inputs] [get_ports $CLK_PORT]]

set_input_delay 0.0 -clock CLK $data_inputs
set_output_delay 0.0 -clock CLK [all_outputs]
