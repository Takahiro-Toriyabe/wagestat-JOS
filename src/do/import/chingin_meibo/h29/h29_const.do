local path_in "${path_meibo_raw}/【賃金構造基本統計調査関係】調査対象事業所一覧/（提供用）調査対象事業所一覧/H29賃構調査対象名簿.xlsx"

import excel using "`path_in'", firstrow  allstring clear
save "${path_meibo_chingin}/chingin_meibo_h29.dta", replace
