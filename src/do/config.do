// Set Stata parameters
set more off
if c(stata_version) < 16 {
	set matsize 11000
}

// Paths relating to data
global path_data "${path_root}/data"

foreach cat in meibo chosa {
	global path_`cat' "${path_data}/`cat'"
	foreach d in raw chingin maikin minkyu minkyu_kyuyo minkyu_gensen {
		global path_`cat'_`d' "${path_`cat'}/`d'"
	}
}

// Paths relating to source files
global path_src "${path_root}/src"
global path_py "${path_src}/py"
global path_do "${path_src}/do"
global path_module "${path_do}/module"
global path_import "${path_do}/import"

// Paths relating to output
global path_log "${path_root}/log"
global path_table "${path_root}/table"
global path_figure "${path_root}/figure"

foreach d in log table figure {
	capture mkdir "${path_`d'}"
	forvalues i = 3(1)8 {
		capture mkdir "${path_`d'}/pj3_`i'"
	}
}

// Figure parameters
set scheme s1color
capture set scheme tt_color

global png_w 1600
global png_h 1200
global png_w_html 600
global png_h_html 400

// Weight variable
global weight_wc_k "Fukugen"
global weight_wc_j "JigyoRitsu"
global weight_minkyu_k "SYOTOKU_BAI"
global weight_minkyu_j "GIMUSYA_BAI"

// Seed
global seed = 1120002

// Number of replications in bootstrap
global bsreps = 1000

// Establishment ID variables for Minkan Kyuyo Jittai chosa
global est_keys_minkyu "KYOKUSYO SEIRI"

// Run module files
foreach f in `: dir "${path_module}/" files "*.do", respectcase' {
	run "${path_module}/`f'"
}
