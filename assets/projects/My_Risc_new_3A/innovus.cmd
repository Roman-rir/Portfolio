#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sat Jul 11 17:04:30 2026                
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
zoomBox -0.05600 -0.04300 0.12400 0.12000
zoomBox -0.02500 -0.01500 0.10500 0.10300
zoomBox -0.01300 -0.00400 0.09800 0.09700
zoomBox -0.15000 -0.09200 0.36600 0.13700
zoomBox -0.00400 0.00300 0.19200 0.09000
zoomBox -0.21600 -0.06800 0.30800 0.16400
zoomBox -0.89400 -0.32800 0.74300 0.39800
is_common_ui_mode
restoreDesign /home/B2_Faysal/UDIF/aiub_vlsi_impl_demo/projects/my_risc/pnr_sky_V1/DBS/signoff.enc.dat RISC_V3
zoomBox -64.22400 74.56100 347.78000 257.34400
zoomBox -12.88500 101.77700 284.78900 233.83800
zoomBox -234.90000 -14.67100 554.37600 335.48600
zoomBox -11.93000 100.13900 285.74600 232.20100
zoomBox 79.79800 147.37100 175.23100 189.70900
zoomBox 106.75500 161.25200 142.75000 177.22100
zoomBox 117.84600 166.96300 129.38700 172.08300
zoomBox 111.28000 163.58200 137.29400 175.12300
zoomBox 91.79100 153.54900 160.77100 184.15100
zoomBox 52.56400 133.53600 208.03100 202.50800
zoomBox -63.89000 74.72900 348.33100 257.60800
zoomBox -235.09600 -11.72400 554.59300 338.61600
zoomBox -105.96100 82.55300 244.42900 238.00100
zoomBox -42.35200 127.20900 89.80000 185.83700
zoomBox -17.71100 143.81800 32.13100 165.93000
zoomBox -55.56600 133.59300 56.76700 183.42900
zoomBox -67.56100 130.35700 64.59600 188.98800
zoomBox -107.65900 121.66000 75.26100 202.81100
zoomBox -107.65900 105.43000 75.26100 186.58100
zoomBox -107.65900 97.31500 75.26100 178.46600
zoomBox -150.57200 85.40500 102.60500 197.72500
zoomBox -293.29800 47.71700 191.71400 262.88900
zoomBox -491.03300 29.03000 298.72900 379.40200
zoomBox -1015.13400 -62.93400 764.79300 726.71800
