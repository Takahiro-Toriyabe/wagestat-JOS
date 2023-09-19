gen_id ${est_keys_minkyu}, gen(id_minkyu)
qui duplicates report year id_minkyu
assert r(unique_value) == r(N)

label variable id_minkyu "Establishment ID"
