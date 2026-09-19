# route script
set var(step) "route"
set vars($var(step),start_time) [clock seconds]

source -e -v ../project_setup.tcl
source -e -v scripts/always_source.tcl

# Restore init
restoreDesign DBS/cts.enc.dat ${DESIGN_NAME} 

setSIMode -enable_glitch_report true
setAnalysisMode -analysisType onChipVariation

route_opt_design

#Reports
timeDesign -postroute -prefix $var(step) -outDir RPT/$var(step)

#Write design data for signoff
# Netlist for simulation
saveNetlist outputs/$::env(TOP).v

# Netlist for LVS
saveNetlist outputs/$::env(TOP).lvs.v -includePhysicalCell $PHYSICAL_CELL_LIST -includePowerGround -phys
#
# Save GDS File
streamOut -mapfile $GDS_MAP_FILE -merge $GDS_MERGE_FILE outputs/$::env(TOP).gds
#
# Save DEF for RC Extraction
defOut -netlist -routing outputs/$::env(TOP).def

#save
saveDesign DBS/route.enc
exit
