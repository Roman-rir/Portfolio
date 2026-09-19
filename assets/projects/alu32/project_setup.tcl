# Setup tcl 
# Ataus Shafi (09-13056-1)
# atausshafi@gmail.com
#

##########################
# Technology Setup
##########################
#
set TECH "sky130_cadence" ;# Options: "gpdk045 | sky130_cadence | sky130_open"

# Synthesis specific setup
# Effect of these variable depends on the TECH used
# No Effect for sky130_cadence
set MULTIVT "true"
set MBFF "false"

source -e -v $::env(REPO_ROOT)/util/tech/${TECH}.tcl 


##########################
# Design Setup
##########################
set DESIGN_DIR "design_data"
set DESIGN_NAME "$::env(TOP)"
puts "TOP DESIGN SET TO: $DESIGN_NAME"
set CLK_PORT "clk" 
set CLK_PERIOD "5.0" ;# unit depends on pdk; for gpdk045 the unit is ns

set POWER_NET "VDD"
set GROUND_NET "VSS"




##########################
# Synthesis Setup
##########################

set SYNTH_EFFORT_GENERIC "medium"
set SYNTH_EFFORT_OPT "high"
set SYNTH_INFO_LEVEL 7
set SYNTH_LOW_POWER "false"

if { $var(step) == "synth" } {
set RTL_FILES "[glob $DESIGN_DIR/*v]"
set CONSTRAINTS_FILE "[glob $DESIGN_DIR/*sdc]"
#set RTL_FILES "[exec python3 $::env(REPO_ROOT)/util/compile.py $::env(REPO_ROOT)/frontend/$::env(PROJECT)/manifest.json syn]"
#set CONSTRAINTS_FILE "[exec python3 $::env(REPO_ROOT)/util/compile.py $::env(REPO_ROOT)/frontend/$::env(PROJECT)/manifest.json syn_sdc]"
}


##########################
# PnR Setup
##########################
set PNR_INIT_NETLIST "$DESIGN_DIR/${DESIGN_NAME}_gate.v"
set PNR_SDC "$DESIGN_DIR/${DESIGN_NAME}.sdc"
set PNR_VIEW_DEF "$DESIGN_DIR/viewDefinition.tcl"
set PNR_GND_NETS "VSS"
set PNR_PWR_NETS "VDD"
set PNR_MAX_ROUTE_LAYER "6"
set PNR_FP_TCL ""
set PNR_FP_DEF "../floorplan/fp.def"
set PNR_FP_PRIORITY "DEF"
