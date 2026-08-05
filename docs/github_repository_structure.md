# Estrutura recomendada para o GitHub

```text
adventure-works-analytics/
├── analyses/
├── docs/
├── macros/
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
├── seeds/
├── snapshots/
├── tests/
├── .gitignore
├── dbt_project.yml
├── packages.yml
├── profiles.yml.example
└── README.md
```

## Estratégia de commits

1. `chore: initialize dbt project`
2. `feat: add adventure works sources and staging models`
3. `feat: add intermediate entity resolution models`
4. `feat: add dimensional marts and sales facts`
5. `test: add source, integrity and reconciliation tests`
6. `docs: document metrics, lineage and execution runbook`
