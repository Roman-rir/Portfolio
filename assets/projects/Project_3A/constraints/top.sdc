create_clock -name CLK -period $CLK_PERIOD [get_ports $CLK_PORT]
 
set data_inputs [remove_from_collection [all_inputs] [get_ports $CLK_PORT]]
set data_inputs [remove_from_collection $data_inputs [get_ports SRST]]
 
set_input_delay 0.0 -clock CLK $data_inputs
set_output_delay 0.0 -clock CLK [all_outputs]
 
set_false_path -from [get_ports SRST]
