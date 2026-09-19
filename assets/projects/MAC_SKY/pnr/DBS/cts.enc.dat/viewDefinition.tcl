if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name fast_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/sky130_ff_1.98_0_nldm.lib]
create_library_set -name slow_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/sky130_ss_1.62_125_nldm.lib]
create_library_set -name typical_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/sky130_tt_1.8_25_nldm.lib]
create_rc_corner -name rctypical\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 25\
   -qx_tech_file ${::IMEX::libVar}/mmmc/rctypical/qrcTechFile
create_delay_corner -name rctypical_fast\
   -library_set fast_libs\
   -rc_corner rctypical
create_delay_corner -name rctypical_typical\
   -library_set typical_libs\
   -rc_corner rctypical
create_delay_corner -name rctypical_slow\
   -library_set slow_libs\
   -rc_corner rctypical
create_constraint_mode -name func\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/func/func.sdc]
create_analysis_view -name func_fast -constraint_mode func -delay_corner rctypical_fast -latency_file ${::IMEX::dataVar}/mmmc/views/func_fast/latency.sdc
create_analysis_view -name func_typical -constraint_mode func -delay_corner rctypical_typical -latency_file ${::IMEX::dataVar}/mmmc/views/func_typical/latency.sdc
create_analysis_view -name func_slow -constraint_mode func -delay_corner rctypical_slow -latency_file ${::IMEX::dataVar}/mmmc/views/func_slow/latency.sdc
set_analysis_view -setup [list func_slow func_typical] -hold [list func_fast func_typical]
