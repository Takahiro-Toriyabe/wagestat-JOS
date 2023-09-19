// Configuration (Change PATH appropriately)
global path_root "PATH"
do "${path_root}/src/do/config.do"

// Import data
do "${path_do}/import/import.do"

// Match sampling list and micro data
foreach f in chingin maikin maikin_chingin {
	do "${path_do}/match/`f'.do"
}


// Data preparation
do "${path_do}/pj3_5/make_data_chingin.do"
do "${path_do}/pj3_5/make_popcat.do"
do "${path_do}/pj3_5/make_est_info_chingin.do"
do "${path_do}/pj3_5/make_est_info_minkyu.do"
do "${path_do}/pj3_5/make_lagged_wage_chingin.do"
do "${path_do}/pj3_5/make_lagged_wage_minkyu.do"

// Figure 2
do "${path_do}/pj3_5/visualize_response_rate.do"

// Table 2
do "${path_do}/pj3_5/transition_matrix_main.do"

// Tables 3, 4, G1, G3
do "${path_do}/pj3_5/analyze_resprate_panel_chingin.do"
do "${path_do}/pj3_5/analyze_resprate_panel_minkyu.do"

// Table 5
do "${path_do}/pj3_5/analyze_resprate_panel_chingin_measurement_error.do"
do "${path_do}/pj3_5/analyze_resprate_panel_minkyu_measurement_error.do"

// Table 6
do "${path_do}/pj3_5/difficult_to_reach_chingin.do"
do "${path_do}/pj3_5/difficult_to_reach_minkyu.do"

// Tables 7, D1, D2, D3
do "${path_do}/pj3_5/check_est_outof_meibo.do"

// Tables 8, E1, E2
do "${path_do}/pj3_4/check_wc_sampling_annual_bonus.do"

// Figure 2, Table 9
do "${path_do}/pj3_4/check_minkyu_sampling.do"

// Figure 3
do "${path_do}/pj3_6/visualize_emp_dist_ess.do"

// Table 10
local wd_tmp "`c(pwd)'"
cd "${path_py}/pj3_6"
sh python ./clean_ess.py
cd "`wd_tmp'"

// Tables 11, 12
do "${path_do}/pj3_5/tax_data.do"

// Table 13
do "${path_do}/pj3_5/difficult_to_reach_chingin.do"

// Figure 4
do "${path_do}/pj3_6/inequality.do"

// Figure 5
do "${path_do}/pj3_6/top_share.do"

// Figure 6, Table G9
do "${path_do}/pj3_6/top_income.do"

// Figures A1, A2, A3, A4
do "${path_do}/pj3_5/analyze_resprate_chingin.do"
do "${path_do}/pj3_5/analyze_resprate_minkyu.do"

// Tables B1, B2
do "${path_do}/pj3_5/resp_panel_chingin.do"
do "${path_do}/pj3_5/resp_panel_minkyu.do"

// Tables C1, C2, C3
do "${path_do}/pj3_4/check_unmatched.do"

// Tables F!, F2
do "${path_do}/pj3_6/sumstat_freelance.do"

// Table G2
do "${path_do}/pj3_5/analyze_resprate_panel_chingin_robust_check.do"
do "${path_do}/pj3_5/analyze_resprate_panel_minkyu_robust_check.do"

// Table G4
do "${path_do}/pj3_4/check_wc_sampling.do"

// Table G5
do "${path_do}/pj3_6/check_minkyu_sampling_by_esize.do"

// Table G6
do "${path_do}/pj3_6/inequality_bootstrap.do"

// Tables G7, G8
do "${path_do}/pj3_6/top_share_bootstrap.do"
