#View Definition (MMMC) file

# RCWorst Slow 125C 1v0 
create_rc_corner -name rctypical \
   -T 25 \
   -qx_tech_file $QRC_TECH_FILE(typical)

create_library_set -name slow_libs \
	-timing $LIB_FILES(slow)

create_library_set -name fast_libs \
	-timing $LIB_FILES(fast)

create_library_set -name typical_libs \
	-timing $LIB_FILES(typical)

create_delay_corner -name rctypical_slow -library_set slow_libs -rc_corner rctypical
create_delay_corner -name rctypical_fast -library_set fast_libs -rc_corner rctypical
create_delay_corner -name rctypical_typical -library_set typical_libs -rc_corner rctypical

create_constraint_mode -name func \
	-sdc_files $PNR_SDC 

create_analysis_view -name func_slow \
	-constraint_mode func \
	-delay_corner rctypical_slow

create_analysis_view -name func_fast \
	-constraint_mode func \
	-delay_corner rctypical_fast

create_analysis_view -name func_typical \
	-constraint_mode func \
	-delay_corner rctypical_typical

set_analysis_view -setup [list func_slow func_typical ] -hold [list func_fast func_typical]

