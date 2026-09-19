# place script 
#

set var(step) "place"
set vars($var(step),start_time) [clock seconds]

source -e -v ../project_setup.tcl
source -e -v scripts/always_source.tcl

# Restore init
restoreDesign DBS/init.enc.dat ${DESIGN_NAME} 


# Set Placement Modes
setPlaceMode -fp false

# Placement
place_design


# Reports
timeDesign -prects -prefix $var(step) -outDir RPT/$var(step)

# Saving Design
saveDesign DBS/place.enc
exit
