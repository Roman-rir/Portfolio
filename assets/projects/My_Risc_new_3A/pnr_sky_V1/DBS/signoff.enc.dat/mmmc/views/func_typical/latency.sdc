set_clock_latency -source -early -min -rise  -0.302589 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -early -min -fall  -0.307383 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -early -max -rise  -0.302589 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -early -max -fall  -0.307383 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -late -min -rise  -0.302589 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -late -min -fall  -0.307383 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -late -max -rise  -0.302589 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
set_clock_latency -source -late -max -fall  -0.307383 [get_ports {SYS_CLOCK}] -clock SYS_CLOCK 
