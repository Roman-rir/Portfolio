set_clock_latency -source -early -min   -0.00015 [get_ports {SYS_CLOCK}] -clock CLK 
set_clock_latency -source -early -max   -0.00015 [get_ports {SYS_CLOCK}] -clock CLK 
set_clock_latency -source -late -min   -0.00015 [get_ports {SYS_CLOCK}] -clock CLK 
set_clock_latency -source -late -max   -0.00015 [get_ports {SYS_CLOCK}] -clock CLK 
