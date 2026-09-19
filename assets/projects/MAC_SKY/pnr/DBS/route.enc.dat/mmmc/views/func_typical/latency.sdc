set_clock_latency -source -early -min   -0.00025 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -early -max   -0.00025 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -late -min   -0.00025 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -late -max   -0.00025 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
