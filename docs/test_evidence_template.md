# Evidências de testes

Preencher após a execução no dbt Cloud.

| Evidência | Comando | Resultado esperado | Resultado obtido | Captura |
|---|---|---|---|---|
| Conexão | `dbt debug` | Todas as verificações aprovadas | Pendente | Pendente |
| Seeds | `dbt seed` | Seed de status carregado | Pendente | Pendente |
| Modelos | `dbt run` | Todos os modelos executados | Pendente | Pendente |
| Sources | `dbt test --select source:*` | Zero falhas | Pendente | Pendente |
| Modelos e regras | `dbt test` | Zero falhas | Pendente | Pendente |
| Documentação | `dbt docs generate` | Catálogo e manifest gerados | Pendente | Pendente |

## Testes singulares críticos

- `assert_gross_sales_2011`
- `assert_order_item_to_header_subtotal`
- `assert_transaction_total_equation`
- `assert_fct_sales_financial_equation`
- `assert_bridge_allocation_weights`
- `assert_order_dates`
