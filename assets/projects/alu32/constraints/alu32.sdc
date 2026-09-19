eval "create_clock -name CLK -period $CLK_PERIOD -waveform { 0 [expr $CLK_PERIOD/2] } $CLK_PORT"
set_input_delay [expr $CLK_PERIOD/4] [all_inputs]
set_output_delay [expr $CLK_PERIOD/4] [all_output]
