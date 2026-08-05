# Runbook de execução

## Pré-requisitos

- Tabelas raw disponíveis no schema `adventure_works`.
- Credenciais Databricks configuradas no dbt Cloud.
- Schema de desenvolvimento com permissão de criação.

## Sequência de validação

```bash
dbt debug
dbt seed
dbt run --select tag:staging
dbt test --select source:*
dbt run --select tag:marts
dbt test
dbt docs generate
```

## Diagnóstico de identifiers

Caso uma fonte não seja encontrada, execute no Databricks:

```sql
show tables in adventure_works;
```

Os identifiers padrão estão definidos em `models/staging/_adventure_works__sources.yml`. Ajuste somente os campos `identifier`, preservando os nomes lógicos utilizados pelos modelos.

## Critérios de aprovação

- zero falhas em `dbt test --select source:*`;
- zero falhas em `dbt test`;
- teste de 2011 aprovado;
- reconciliação entre itens e cabeçalho aprovada;
- reconciliação do total do pedido aprovada;
- documentação gerada sem erros.
