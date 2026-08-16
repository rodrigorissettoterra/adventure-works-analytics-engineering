# Adventure Works Analytics Engineering

> **A dbt project that transforms raw operational data into a tested, documented, and governed dimensional model for analytical consumption.**

This project models the commercial domain of **Adventure Works** using modern Analytics Engineering practices.

The objective is not simply to write SQL transformations, but to create a reliable analytical layer where **data grain, business metrics, quality rules, lineage, and downstream consumption are explicitly defined**.

<p>
  <img src="https://img.shields.io/badge/dbt-Analytics%20Engineering-FF694B?logo=dbt&logoColor=white" alt="dbt">
  <img src="https://img.shields.io/badge/Databricks-Data%20Platform-FF3621?logo=databricks&logoColor=white" alt="Databricks">
  <img src="https://img.shields.io/badge/SQL-Data%20Modeling-blue" alt="SQL">
  <img src="https://img.shields.io/badge/Data%20Quality-Tests-green" alt="Data Quality">
</p>

---

## The problem

Operational databases are optimized for transactions. Analytics requires a different structure.

Business users need consistent answers to questions such as:

- How much did we sell?
- Which products generate the most value?
- Who are the highest-value customers?
- Which locations perform best?
- How does revenue evolve over time?
- Which promotions and sales reasons are associated with performance?

Answering these questions directly from normalized operational tables often creates duplicated transformation logic, inconsistent metrics, ambiguous joins, and grain errors.

This project creates a reusable analytical layer to solve those problems.

---

## Architecture

```text
Raw Adventure Works
        ↓
Staging
standardization · typing · minimization
        ↓
Intermediate
entity resolution · reusable joins · business preparation
        ↓
Marts
dimensions · facts · bridges
        ↓
Governed Metrics
        ↓
Power BI / Databricks AI/BI / Analytical Queries
```

The separation of layers keeps transformation responsibilities explicit and reduces duplicated logic.

---

## What this project demonstrates

- dimensional modeling with facts, dimensions, and bridges;
- explicit grain definition;
- layered dbt architecture;
- reusable intermediate models;
- metric contracts;
- source and model testing;
- custom generic tests;
- financial reconciliation;
- data minimization;
- analytical business queries;
- documentation and runbooks;
- preparation for BI consumption.

---

## Dimensional model

The marts are built around clearly defined grains.

| Model | Grain |
|---|---|
| `fct_sales` | One row per sales order item (`sales_order_detail_id`) |
| `fct_sales_orders` | One row per sales order (`sales_order_id`) |
| `bridge_order_sales_reason` | One row per order + sales reason combination |
| `dim_customer` | One row per customer |
| `dim_product` | One row per product |
| `dim_location` | One row per delivery location |
| `dim_date` | One row per date |

Additional dimensions are included where required by the domain.

Explicit grain definition matters because many analytical errors happen when metrics from different levels are combined without a formal allocation rule.

---

## Metric contract

Business metrics are defined independently from individual dashboards.

### Gross Sales

```text
Gross Sales = Order Quantity × Unit Price
```

### Discount

```text
Discount = Gross Sales × Unit Price Discount
```

### Product Net Revenue

```text
Product Net Revenue = Gross Sales - Discount
```

### Order Total

At order grain:

```text
Order Total = Subtotal + Tax + Freight
```

### Average Order Value

```text
Average Order Value = Product Net Revenue / Distinct Orders
```

### Why Product Net Revenue is the primary additive sales metric

`total_due` exists at **order grain**, while product analytics requires a metric that remains additive across products, customers, geography, dates, and other item-level dimensions.

For that reason, Product Net Revenue is calculated from line-level information. `total_due` is intentionally **not distributed across products** without a formally defined allocation rule.

This prevents double counting and preserves metric semantics.

See [`docs/metric_contract_v2.md`](docs/metric_contract_v2.md) for the formal contract.

---

## Engineering layers

### Staging

The staging layer is responsible for:

- source standardization;
- column naming;
- data typing;
- field selection;
- minimization of unnecessary attributes;
- source-level quality assumptions.

### Intermediate

The intermediate layer centralizes reusable business logic, including entity resolution and joins that would otherwise be repeated across marts.

Examples include customer, product, location, and enriched-order preparation.

### Marts

The marts expose stable analytical entities using facts, dimensions, and bridges designed for downstream consumption.

---

## Business questions

The repository includes analytical SQL queries for questions such as:

- sales across business dimensions;
- products with the highest average order value;
- top customers;
- top cities;
- monthly sales evolution;
- promotion and product performance.

These queries live under [`analyses/business_questions`](analyses/business_questions) and consume the governed analytical layer rather than rebuilding transformations from raw sources.

---

## Data quality and testing

The project uses dbt tests to validate both source assumptions and analytical contracts.

Typical execution:

```bash
dbt test --select source:*
dbt test
```

The repository also includes a custom `accepted_range` generic test and additional assertions for business-critical values.

### Financial reconciliation

The test `assert_gross_sales_2011` validates that gross sales for 2011, rounded to two decimal places, equal:

```text
$12,646,112.16
```

This creates a concrete reconciliation point between the analytical model and the reference audit value.

---

## Security and data minimization

The analytical mart intentionally avoids exposing data that are not necessary for business analysis.

Examples of excluded attributes include:

- credit-card numbers;
- approval codes;
- demographic XML payloads;
- other operational fields without analytical need.

Only the card type is exposed where relevant to analysis.

The objective is to keep the analytical layer useful while minimizing unnecessary sensitive information.

---

## Project structure

```text
.
├── analyses/
│   └── business_questions/
├── docs/
│   ├── architecture.md
│   ├── metric_contract_v2.md
│   ├── runbook.md
│   └── test_evidence_template.md
├── macros/
│   ├── safe_divide.sql
│   └── tests/
├── models/
│   ├── staging/
│   ├── intermediate/
│   ├── marts/
│   └── exposures.yml
├── seeds/
├── tests/
├── dbt_project.yml
├── packages.yml
├── profiles.yml.example
└── README.md
```

---

## Running the project

The project is designed to run with dbt and Databricks.

Configure the connection and ensure the `raw_schema` variable points to the Adventure Works source schema.

Then run:

```bash
dbt debug
dbt seed
dbt run
dbt test --select source:*
dbt test
dbt docs generate
```

For an integrated build:

```bash
dbt build
```

Operational details are documented in [`docs/runbook.md`](docs/runbook.md).

---

## Documentation

The repository separates implementation from supporting documentation:

- [`docs/architecture.md`](docs/architecture.md) — architectural decisions and model flow;
- [`docs/metric_contract_v2.md`](docs/metric_contract_v2.md) — metric definitions and semantics;
- [`docs/runbook.md`](docs/runbook.md) — execution guidance;
- [`docs/test_evidence_template.md`](docs/test_evidence_template.md) — evidence checklist for validation.

---

## Key engineering principles

### Grain before metrics

Every fact is defined at an explicit grain before business metrics are calculated.

### Metrics before dashboards

Metric semantics live in the analytical layer rather than being recreated independently in visualization tools.

### Reuse before duplication

Shared joins and entity-resolution logic belong in intermediate models.

### Tests as contracts

Tests validate not only technical integrity but also important business expectations.

### Minimize unnecessary data

Analytical usability does not require exposing every attribute available in the operational source.

---

## Author

**Rodrigo Terra**

Data & AI professional focused on Analytics Engineering, Data Science, Artificial Intelligence, data platforms, and reliable decision-support systems.

- GitHub: [Rodrigo Terra](https://github.com/rodrigorissettoterra)
- LinkedIn: [Rodrigo Terra](https://www.linkedin.com/in/rodrigo-rissetto-terra/)