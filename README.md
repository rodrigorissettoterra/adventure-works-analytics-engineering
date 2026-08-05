# Adventure Works Analytics

Projeto dbt para estruturar o domínio comercial da Adventure Works em uma camada dimensional confiável, auditável e orientada a consumo analítico.

## Arquitetura

```text
raw adventure_works
        |
        v
staging: padronização, tipagem e minimização de dados
        |
        v
intermediate: resolução de entidades e joins reutilizáveis
        |
        v
marts: dimensões, fatos e ponte de motivos de venda
        |
        v
Power BI / Databricks AI/BI
```

## Grãos

| Modelo | Grão |
|---|---|
| `fct_sales` | Uma linha por item do pedido (`sales_order_detail_id`) |
| `fct_sales_orders` | Uma linha por pedido (`sales_order_id`) |
| `bridge_order_sales_reason` | Uma linha por combinação pedido + motivo |
| `dim_customer` | Uma linha por cliente |
| `dim_product` | Uma linha por produto |
| `dim_location` | Uma linha por endereço de entrega |
| `dim_date` | Uma linha por data |

## Contrato de métricas

- **Receita bruta:** quantidade × preço unitário.
- **Desconto:** receita bruta × percentual de desconto.
- **Valor transacionado / receita líquida de produto:** receita bruta − desconto.
- **Valor total do pedido:** `subtotal + tax + freight`, disponível somente em `fct_sales_orders`.
- **Ticket médio:** receita líquida de produto ÷ pedidos distintos.

A métrica principal de valor transacionado utiliza a receita líquida de produto porque precisa permanecer aditiva por produto, cliente, geografia e período. `total_due` é uma métrica no grão do pedido e não deve ser distribuída entre itens sem regra formal de alocação.

## Execução no dbt Cloud

1. Conecte o projeto ao repositório GitHub.
2. Configure a conexão Databricks.
3. Defina o schema de desenvolvimento no ambiente.
4. Confirme que a variável `raw_schema` aponta para `adventure_works`.
5. Execute:

```bash
dbt debug
dbt seed
dbt run
dbt test --select source:*
dbt test
dbt docs generate
```

Para uma execução integrada, utilize:

```bash
dbt build
```

## Reconciliação financeira

O teste `assert_gross_sales_2011` valida que a receita bruta de 2011, arredondada a duas casas decimais, corresponde a **$ 12,646,112.16**, valor de referência informado pela auditoria.

## Segurança

O mart não expõe número do cartão, código de aprovação, XMLs demográficos ou outros atributos sem necessidade analítica. Apenas o tipo de cartão é disponibilizado.

## Evidências para o vídeo

Execute e registre:

```bash
dbt run
dbt test --select source:*
dbt test
```

O arquivo `docs/test_evidence_template.md` contém o checklist de evidências.
