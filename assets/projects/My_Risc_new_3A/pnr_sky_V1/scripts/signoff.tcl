# route script
set var(step) "signoff"
set vars($var(step),start_time) [clock seconds]

source -e -v ../project_setup.tcl
source -e -v scripts/always_source.tcl

# Restore init
restoreDesign DBS/route.enc.dat ${DESIGN_NAME} 

addFiller -prefix FILLER -cell $PHYSICAL_CELL_LIST
ecoRoute

# Reports
timeDesign -postroute -prefix $var(step) -outDir RPT/$var(step)
report_power -outfile power -output RPT/$var(step)
report_area > RPT/$var(step)/area.rpt
reportGateCount -outfile RPT/$var(step)/gate_count.rpt

# Optional metrics
#create_snapshot -name final -auto default
#report_metric -format text -out_file RPT/$var(step)/metrics.rpt
#report_metric -format html -out_file RPT/$var(step)/metrics.html

# Write design data
saveNetlist final/$::env(TOP).v
saveNetlist final/$::env(TOP).lvs.v -includePowerGround
streamOut -dieAreaAsBoundary -mode ALL -units 1000 -mapfile $GDS_MAP_FILE -merge $GDS_MERGE_FILE final/$::env(TOP).gds
defOut -netlist -routing final/$::env(TOP).def

# Save database
saveDesign DBS/$var(step).enc

exit
