#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sat May  2 12:32:09 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.18-s099_1 (64bit) 07/18/2023 13:03 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.18-s099_1 NR230707-1955/21_18-UB (database version 18.20.605) {superthreading v2.17}
#@(#)CDS: AAE 21.18-s017 (64bit) 07/18/2023 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.18-s022_1 () Jul 11 2023 23:10:24 ( )
#@(#)CDS: SYNTECH 21.18-s010_1 () Jul  5 2023 06:32:03 ( )
#@(#)CDS: CPE v21.18-s053
#@(#)CDS: IQuantus/TQuantus 21.1.1-s966 (64bit) Wed Mar 8 10:22:20 PST 2023 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
define_proc_arguments ViaFillQor -info {This procedure extracts Viafill details from innovus db} -define_args {
		{-window "window coordinates" "" list optional}
		{-window_size "window size in microns" "" string optional}
	
	}
define_proc_arguments ProcessFills -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor_fast -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast_stampOnly -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
	
}
define_proc_arguments FillQor_fast_stampOnly -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
}
win
is_common_ui_mode
restoreDesign /home/B2_Robiul/UDIF/aiub_vlsi_impl_demo/projects/MAC_SKY/pnr/DBS/signoff.enc.dat MAC_4BIT
zoomBox -44.21800 17.25800 108.61700 85.06200
zoomBox -44.21800 24.03800 108.61700 91.84200
zoomBox -55.84300 18.54100 123.96300 98.31100
zoomBox -55.84400 50.44900 123.96300 130.21900
zoomBox -42.63900 53.34300 110.19800 121.14800
zoomBox -55.84500 50.44800 123.96300 130.21900
zoomBox -71.38200 47.04300 140.15800 140.89100
zoomBox -71.38200 56.42800 140.15800 150.27600
zoomBox -71.38200 65.81300 140.15800 159.66100
zoomBox -71.38200 56.42800 140.15800 150.27600
zoomBox -71.38200 47.04300 140.15800 140.89100
zoomBox -71.38200 28.27300 140.15800 122.12100
zoomBox -71.38200 18.88800 140.15800 112.73600
zoomBox -71.38200 9.50300 140.15800 103.35100
zoomBox -71.38200 0.11800 140.15800 93.96600
zoomBox -71.38200 -9.26700 140.15800 84.58100
fit
zoomBox -54.92000 -9.74600 124.88700 70.02400
fit
zoomOut
zoomIn
zoomIn
zoomIn
zoomIn
zoomOut
fit
