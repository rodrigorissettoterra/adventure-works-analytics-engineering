# Arquitetura e decisões de modelagem

## Separação por camadas

### Staging
A staging mantém uma relação 1:1 com as fontes e concentra somente aliases, tipagem, padronização textual, criação de identificadores derivados e minimização de atributos sensíveis.

### Intermediate
A camada intermediária resolve entidades que dependem de múltiplas fontes:

- cliente entre pessoa e loja;
- produto entre produto, subcategoria e categoria;
- localização entre endereço, estado e país;
- pedido enriquecido com cliente, localização e cartão.

### Marts
A camada de marts expõe contratos estáveis para BI:

- fatos com grão explícito;
- dimensões conformadas;
- ponte para relacionamento muitos-para-muitos;
- documentação e testes no mesmo ciclo de desenvolvimento.

## Duas fatos

A solução utiliza duas tabelas fato porque existem métricas em grãos diferentes:

- `fct_sales`: quantidade e receita de produto no nível do item;
- `fct_sales_orders`: subtotal, tributos, frete e total no nível do pedido.

Repetir `total_due` em cada item produziria dupla contagem. A separação evita depender de medidas defensivas no BI e torna o contrato de dados explícito.

## Chaves dimensionais

No MVP, os identificadores naturais inteiros são reutilizados como chaves dimensionais por serem estáveis, únicos e já integrarem os domínios transacionais. Cada dimensão contém um membro `-1` para valores desconhecidos. Uma evolução para SCD Tipo 2 exigirá chaves substitutas independentes.

## Motivos de venda

A ponte possui `allocation_weight`, mas a métrica padrão do dashboard não é automaticamente alocada por motivo. O peso existe para análises explicitamente fracionadas. Para filtros de pertencimento, a ponte deve ser usada como relação de filtro e não como base para somas por join direto.
