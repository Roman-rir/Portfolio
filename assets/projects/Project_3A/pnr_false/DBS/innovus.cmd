#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon Jun 15 19:40:00 2026                
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
restoreDesign /home/B2_Abid/UDIF/aiub_vlsi_impl_demo/projects/Project_3A/pnr_false/DBS/signoff.enc.dat RISC_V3
fit
zoomBox -20.46800 -2.15200 53.63900 33.67600
zoomBox -15.28700 -1.78200 38.25600 24.10400
zoomBox -8.05500 -1.15600 19.89700 12.35800
zoomBox -4.96300 -0.88400 12.20500 7.41600
zoomBox -3.59400 -0.74400 8.81000 5.25300
zoomBox -1.89900 -0.48800 4.57700 2.64300
zoomBox -1.04700 -0.33000 2.33500 1.30500
zoomBox -0.71200 -0.25100 1.36700 0.75400
zoomBox -0.63200 -0.23300 1.13600 0.62200
zoomBox -0.50600 -0.15800 0.58000 0.36700
zoomBox -0.41200 -0.10000 0.15700 0.17500
zoomBox -0.63800 -0.23800 1.14300 0.62300
zoomBox -1.33700 -0.66600 4.22300 2.02200
zoomBox -2.62900 -1.45600 9.91000 4.60600
zoomBox -5.53300 -3.23400 22.72900 10.43000
zoomBox -8.81300 -5.24200 37.21000 17.00800
zoomBox -16.88300 -8.40700 58.06000 27.82500
zoomBox -44.00700 -17.58100 59.72200 32.56800
fit
verify_drc
zoomBox -12.23400 4.28400 61.87100 40.11100
zoomBox -6.32500 6.83700 56.66400 37.29000
zoomBox 6.59500 12.42000 45.27800 31.12200
zoomBox 9.67900 13.75300 42.56000 29.65000
zoomBox 18.03400 17.36300 35.19800 25.66100
zoomBox 20.03900 18.67800 32.44000 24.67300
zoomBox 18.03400 17.36300 35.19800 25.66100
zoomBox 6.09900 9.53600 51.61400 31.54100
zoomBox -1.25900 4.71100 61.73700 35.16700
zoomBox -11.44300 -1.96700 75.74700 40.18600
zoomBox -17.92000 -6.21400 84.65700 43.37800
fit
