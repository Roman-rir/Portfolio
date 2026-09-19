# route script
set var(step) "signoff"
set vars($var(step),start_time) [clock seconds]

source -e -v ../project_setup.tcl
source -e -v scripts/always_source.tcl

# Restore init
restoreDesign DBS/route.enc.dat ${DESIGN_NAME} 

addFiller -prefix FILLER -cell $PHYSICAL_CELL_LIST
ecoRoute

#Reports
timeDesign -postroute -prefix $var(step) -outDir RPT/$var(step)

#Write design data for signoff
# Netlist for simulation
saveNetlist final/$::env(TOP).v

# Netlist for LVS
saveNetlist final/$::env(TOP).lvs.v -includePowerGround
#
# Save GDS File
streamOut -dieAreaAsBoundary -mode ALL -units 1000 -mapfile $GDS_MAP_FILE -merge $GDS_MERGE_FILE final/$::env(TOP).gds
#
# Save DEF for RC Extraction
defOut -netlist -routing final/$::env(TOP).def

#save
saveDesign DBS/$var(step).enc
exit
