eval "create_clock -name CLK -period $CLK_PERIOD -waveform { 0 [expr $CLK_PERIOD/2] } $CLK_PORT"



