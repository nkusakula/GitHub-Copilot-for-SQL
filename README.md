# GitHub Copilot for SQL — AdventureWorks Demo Repository

A professional SQL development repository demonstrating **GitHub Copilot capabilities in SQL Server Management Studio (SSMS)**, built around the AdventureWorks (`adventure_works`) database.

---

## Repository Structure

```
├── .github/
│   ├── copilot-instructions.md           # Team T-SQL coding standards for GitHub Copilot
│   └── PULL_REQUEST_TEMPLATE.md          # Standard SQL PR checklist
├── docs/
│   ├── nes-demo-script.md                # Next Edit Suggestions demo guide
│   ├── chat-and-context-demo-script.md   # Copilot Chat & context demo guide
│   └── database-and-custom-instructions-demo-script.md
├── src/
│   ├── queries/                          # Ad-hoc and reporting queries
│   ├── stored-procedures/                # Reusable stored procedures
│   ├── views/                            # Database views
│   └── database-instructions/            # Scripts to configure Copilot database instructions
└── README.md
```

---

## Getting Started

### Prerequisites
- SQL Server Management Studio (SSMS) 22.3 or later with the AI Assistance workload
- GitHub account with Copilot access
- Access to the `adventure_works` (AdventureWorks) database

### Setup

1. Clone this repository
   ```bash
   git clone https://github.com/nkusakula/GitHub-Copilot-for-SQL.git
   ```

2. Open SSMS and connect to the `adventure_works` database

3. Install business rule instructions into the database:
   ```
   Run: src/database-instructions/setup-database-instructions.sql
   ```

4. Install the database constitution:
   ```
   Run: src/database-instructions/setup-constitution.sql
   ```

5. Enable personal coding standards — copy the custom instructions file to your user profile:
   ```
   Copy .github/copilot-instructions.md → %USERPROFILE%\copilot-instructions.md
   ```
   Then enable it in SSMS: **Tools → Options → GitHub → Copilot → Copilot Chat → Enable custom instructions**

---

## Demo Scripts

| Demo | Feature Covered | Script |
|---|---|---|
| Next Edit Suggestions | NES — typos, alias propagation, CTE refactor | [docs/nes-demo-script.md](docs/nes-demo-script.md) |
| Chat & Chat Context | Chat window, inline chat, slash commands, file refs, Mermaid | [docs/chat-and-context-demo-script.md](docs/chat-and-context-demo-script.md) |
| Database & Custom Instructions | Teaching Copilot business rules and coding style | [docs/database-and-custom-instructions-demo-script.md](docs/database-and-custom-instructions-demo-script.md) |

---

## SQL Source Files

### Queries (`src/queries/`)

| File | Description | Used In Demo |
|---|---|---|
| `01-customer-revenue-by-category.sql` | Revenue per product category (shipped orders only) | Chat Demo 2, DB Instructions Demo 1 & 4 |
| `02-top-customers-by-revenue.sql` | Top 10 customers by total revenue with order stats | Chat Demo 2 |
| `03-product-profit-margin.sql` | Products >$500 with profit margin % | Chat Demo 3 (inline chat) |
| `04-recent-orders.sql` | Orders from the last 12 months with address details | Chat Demo 5 (file reference) |
| `05-order-status-no-aliases.sql` | Query without aliases — starting point for NES alias demo | NES Demo 2 |
| `06-cte-rename-demo.sql` | CTE query — starting point for NES rename/refactor demo | NES Demo 3 |

### Stored Procedures (`src/stored-procedures/`)

| File | Description |
|---|---|
| `usp_GetCustomerOrders.sql` | Returns customer orders within a date range with product details |

### Views (`src/views/`)

| File | Description |
|---|---|
| `v_CustomerRevenueSummary.sql` | Customer revenue rollup — order count, total, avg, date range |

### Database Instructions (`src/database-instructions/`)

| File | Description |
|---|---|
| `setup-database-instructions.sql` | Installs `AGENTS.md` extended properties on tables and columns |
| `setup-constitution.sql` | Installs the `CONSTITUTION.md` database-wide Copilot guardrails |

---

## Coding Standards

This repository follows the T-SQL coding standards defined in [`.github/copilot-instructions.md`](.github/copilot-instructions.md). GitHub Copilot in SSMS automatically applies these standards to all generated code.

Key conventions:
- Always schema-qualify object names (`SalesLT.Customer`, not `Customer`)
- Never use `SELECT *` — always list columns explicitly
- Use short, readable table aliases (`c`, `soh`, `sod`, `p`)
- All T-SQL keywords in UPPERCASE
- Stored procedures: `usp_<Action><Entity>`
- Views: `v_<Description>`
- Functions: `fn_<Description>`

---

## Contributing

1. Create a feature branch:
   ```bash
   git checkout -b feature/<description>
   ```
2. Write or update SQL following the standards in `.github/copilot-instructions.md`
3. Test all queries against the `adventure_works` database
4. Open a pull request — the PR template will guide you through the checklist

---

## References

- [GitHub Copilot in SSMS — Get Started](https://learn.microsoft.com/en-us/ssms/github-copilot/get-started)
- [Next Edit Suggestions](https://learn.microsoft.com/en-us/ssms/github-copilot/next-edit-suggestions)
- [Copilot Chat in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/chat)
- [Chat Context](https://learn.microsoft.com/en-us/ssms/github-copilot/chat-context)
- [Database Instructions](https://learn.microsoft.com/en-us/ssms/github-copilot/database-instructions)
- [Custom Instructions](https://learn.microsoft.com/en-us/ssms/github-copilot/custom-instructions)
