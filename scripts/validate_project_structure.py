from pathlib import Path
import re
import sys
import yaml

ROOT = Path(__file__).resolve().parents[1]

model_files = list((ROOT / 'models').rglob('*.sql'))
seed_files = list((ROOT / 'seeds').glob('*.csv'))
model_names = {path.stem for path in model_files}
seed_names = {path.stem for path in seed_files}
known_refs = model_names | seed_names

source_yaml = yaml.safe_load((ROOT / 'models/staging/_adventure_works__sources.yml').read_text())
known_sources = {
    table['name']
    for source in source_yaml['sources']
    for table in source['tables']
}

errors = []
for path in list(ROOT.rglob('*.yml')) + list(ROOT.rglob('*.yaml')):
    try:
        yaml.safe_load(path.read_text())
    except Exception as exc:
        errors.append(f'YAML inválido em {path.relative_to(ROOT)}: {exc}')

for path in list(ROOT.rglob('*.sql')) + list(ROOT.rglob('*.yml')):
    text = path.read_text()
    for ref_name in re.findall(r"ref\(['\"]([^'\"]+)['\"]\)", text):
        if ref_name not in known_refs:
            errors.append(f'Ref desconhecido {ref_name} em {path.relative_to(ROOT)}')
    for source_name, table_name in re.findall(
        r"source\(['\"]([^'\"]+)['\"],\s*['\"]([^'\"]+)['\"]\)", text
    ):
        if source_name != 'adventure_works' or table_name not in known_sources:
            errors.append(
                f'Source desconhecida {source_name}.{table_name} em {path.relative_to(ROOT)}'
            )

if len(model_names) != len(model_files):
    errors.append('Há nomes de modelos SQL duplicados.')

required_models = {
    'fct_sales', 'fct_sales_orders', 'dim_date', 'dim_customer',
    'dim_product', 'dim_location', 'dim_credit_card',
    'dim_sales_reason', 'dim_order_status', 'bridge_order_sales_reason'
}
missing = required_models - model_names
if missing:
    errors.append(f'Modelos obrigatórios ausentes: {sorted(missing)}')

if errors:
    print('\n'.join(errors))
    sys.exit(1)

print(f'Validação estrutural aprovada: {len(model_files)} modelos SQL, '
      f'{len(known_sources)} sources e {len(seed_files)} seed(s).')
