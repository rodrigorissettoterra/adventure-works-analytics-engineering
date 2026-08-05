# Contrato de métricas — versão 2

## Decisão revisada

O termo **valor total da transação** é ambíguo na origem. Para responder a perguntas por produto, ele deve ser uma métrica aditiva no nível do item. Por isso, o dashboard utilizará `net_sales_amount` como **valor transacionado**.

`transaction_total`, equivalente a `TotalDue`, será apresentado separadamente como **valor total do pedido**, somente em análises no grão de pedido.

## Métricas certificadas

| Métrica | Modelo | Fórmula | Aditividade |
|---|---|---|---|
| Pedidos | `fct_sales` | `count(distinct sales_order_id)` | Não aditiva |
| Unidades vendidas | `fct_sales` | `sum(order_quantity)` | Aditiva |
| Receita bruta | `fct_sales` | `sum(gross_sales_amount)` | Aditiva |
| Desconto | `fct_sales` | `sum(discount_amount)` | Aditiva |
| Valor transacionado | `fct_sales` | `sum(net_sales_amount)` | Aditiva |
| Ticket médio | `fct_sales` | valor transacionado ÷ pedidos | Não aditiva |
| Valor total do pedido | `fct_sales_orders` | `sum(transaction_total)` | Aditiva somente no grão de pedido |
| Clientes ativos | `fct_sales` | `count(distinct customer_key)` | Não aditiva |

## Reconciliações

1. `sum(net_sales_amount)` por pedido deve reconciliar com `order_subtotal`.
2. `order_subtotal + tax_amount + freight_amount` deve reconciliar com `transaction_total`.
3. A receita bruta de 2011 deve reconciliar com $ 12,646,112.16 após arredondamento para duas casas.
