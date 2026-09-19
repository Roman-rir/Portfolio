# cts script
set var(step) "cts"
set vars($var(step),start_time) [clock seconds]

source -e -v ../project_setup.tcl
source -e -v scripts/always_source.tcl

# Restore init
restoreDesign DBS/place.enc.dat ${DESIGN_NAME} 

if { [info exists CLK_BUFFERS ] } {
set_ccopt_property buffer_cells $CLK_BUFFERS
}
if { [info exists CLK_INVERTERS ] } {
set_ccopt_property inverter_cells $CLK_INVERTERS
}
ccopt_design

#Reports
timeDesign -prects -prefix $var(step) -outDir RPT/$var(step)
#
#save
saveDesign DBS/cts.enc
exit
