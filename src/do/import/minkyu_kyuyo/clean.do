// Establishment ID
gen_id ${est_keys_minkyu}, gen(id_minkyu)
label variable id_minkyu "Establishment ID"

// Individual ID
gen_id ${est_keys_minkyu} ITIREN_NO, gen(id_minkyu_i)
qui duplicates report year id_minkyu_i
assert r(unique_value) == r(N)

label variable id_minkyu_i "Individual ID"
