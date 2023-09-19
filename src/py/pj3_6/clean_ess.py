import xlrd
import os
import pathlib
import csv
import pandas as pd
import matplotlib.pyplot as plt
from decimal import Decimal, ROUND_HALF_UP


def clean(x):
    try:
        return float(x.replace('1)', '').replace(',', '').strip())
    except:
        return x

def get_cell_value(ws, i, j):
    x = ws.cell_value(i, j)
    return clean(x)


def round_half_up(x, fmt):
    y = Decimal(str(x)).quantize(Decimal(str(fmt)), rounding=ROUND_HALF_UP)
    return str(y)


def get_mid_val(x):
    if x == '50万円未満':
        return 25
    if x == '1500万円以上':
        return 1500
    a, b = x.replace('万円', '').split('～')
    return (float(a) + float(b)) / 2


# Distribution of employment type
path_root = str(pathlib.Path(__file__).parents[3])
path_data = os.path.join(path_root, 'data/pj3_6/ESS')
path_in = os.path.join(path_data, 'jikei_04.xlsx')

wb = xlrd.open_workbook(path_in)
ws = wb.sheet_by_index(0)

data = [[get_cell_value(ws, i, j) for j in [5, 7, 11, 12]]
    for i in range(9, 27)]
colname = ['year', 'ntot', 'nself_w', 'nself_wo']
emp_dist = pd.DataFrame(data, columns=colname)

emp_dist['nself_all'] = emp_dist['nself_w'] + emp_dist['nself_wo']
emp_dist['frac_self_all'] = emp_dist['nself_all'] / emp_dist['ntot']
emp_dist['frac_self_w'] = emp_dist['nself_w'] / emp_dist['ntot']
emp_dist['frac_self_wo'] = emp_dist['nself_wo'] / emp_dist['ntot']
emp_dist['frac_self_wo_among_self'] = emp_dist['nself_wo'] / emp_dist['nself_all']

emp_dist['frac_all'] = emp_dist['ntot'] / emp_dist['ntot'] 
emp_dist['frac_target'] = (emp_dist['ntot'] - emp_dist['nself_wo']) / emp_dist['ntot']
emp_dist['frac_emp'] = 1 - emp_dist['frac_self_all']

emp_dist.to_csv(os.path.join(path_data, 'emp_dist.csv'), index=False)

# Income distribution
years = list(range(2002, 2022, 5))
fnames = [
    'z030.xls',
    'FEH_00200532_200923143242.csv',
    'FEH_00200532_200923142852.csv',
    'a029.xlsx'
]

table_tex = 'ess_inc_dist{}.tex'

for y, fname in zip(years, fnames):
    # Data cleaning
    p_in = os.path.join(path_data, f'{y}', fname)
    if y == 2002:
        wb = xlrd.open_workbook(p_in)
        category = [x.name for x in wb.sheets()][1:]
        d = []
        for cat in category:
            ws = wb.sheet_by_name(cat)
            d.append([get_cell_value(ws, i, 9) for i in [16, 18, 19]])
    if y in [2007, 2012]:
        with open(p_in) as f:
            l = [row for row in csv.reader(f)]

        category = [clean(l[i][9]) for i in range(16, len(l))]
        d = [[clean(l[i][j]) for j in [11, 14, 15]] for i in range(16, len(l))]
    if y == 2017:
        ws = xlrd.open_workbook(p_in).sheet_by_index(0)
        category = [get_cell_value(ws, i, 7)[3:] for i in range(44, 444, 25)]
        d = [[get_cell_value(ws, i, j) for j in [13, 16, 17]]
            for i in range(44, 444, 25)]

    # Calculate fraction for each income cateogry by employment type
    cols = ['nall', 'nself_w', 'nself_wo']
    df = pd.DataFrame(d, columns=cols, index=category)
    df['nemp'] = df['nall'] - df['nself_w'] - df['nself_wo']
    df['ntarget'] = df['nall'] - df['nself_wo']
    ntot = df.sum()

    tags = ['all', 'target', 'emp', 'self_w', 'self_wo']
    for tag in tags:
        df[f'frac_{tag}'] = (df[f'n{tag}'] / ntot[f'n{tag}'])

    # Calculate "Mean" wage
    df['mid_val'] = [get_mid_val(x) for x in category]
    rowname_mean = '平均年間所得（１万円）'
    mid_vals = pd.Series([df['mid_val'].dot(df[f'frac_{tag}']) for tag in tags],
        name=rowname_mean, index=[f'frac_{tag}' for tag in tags])
    df = df.append(mid_vals)

    # Fraction of each employment category
    emp_dist_sub = emp_dist.loc[emp_dist['year']==y, [f'frac_{tag}' for tag in tags]]
    emp_dist_sub = emp_dist_sub.rename(index={emp_dist_sub.index[0]:'就業者に占める割合'})

    # Export result
    result = emp_dist_sub.append(df.loc[:, df.columns.str.startswith('frac')])

    p_out = os.path.join(path_root, 'table/pj3_6', table_tex.format(y))
    with open(p_out, 'w', encoding='utf8') as f:
        for cat, val in zip(result.index, result.values):
            fmt = '0.1' if cat == rowname_mean else '0.001'
            tab = '\\qquad' if '万円' in cat and '平均' not in cat else ''
            return_mark = '\\\\\n'
            if cat == '50万円未満':
                f.write('所得分布' + ' &' * len(val) + return_mark)
            val_str = ' & '.join([round_half_up(x, fmt) for x in val])
            f.write(f'{tab} {cat} & {val_str} {return_mark}')
