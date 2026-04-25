# GitHub Copilot for SQL — AdventureWorks Demo Repository

A professional SQL development repository demonstrating **GitHub Copilot capabilities in SQL Server Management Studio (SSMS) and VS Code**, built around the AdventureWorks (`adventure_works`) database.

---

## Repository Structure

```
├── .github/
│   ├── copilot-instructions.md                    # Team T-SQL coding standards for GitHub Copilot
│   ├── PULL_REQUEST_TEMPLATE.md                   # Standard SQL PR checklist
│   ├── agents/
│   │   └── ms-sql-dba.agent.md                    # Custom Copilot agent for DBA tasks
│   ├── instructions/
│   │   ├── ms-sql-dba.instructions.md             # Copilot DBA chat mode instructions
│   │   └── sql-sp-generation.instructions.md      # Stored procedure generation standards
│   └── skills/
│       ├── sql-code-review/
│       │   └── SKILL.md                           # SQL code review skill
│       └── sql-optimization/
│           └── SKILL.md                           # SQL performance optimization skill
├── docs/
│   ├── nes-demo-script.md                         # SSMS: Next Edit Suggestions demo
│   ├── chat-and-context-demo-script.md            # SSMS: Copilot Chat & context demo
│   ├── database-and-custom-instructions-demo-script.md
│   └── vscode-mssql-demo-script.md                # VS Code: MSSQL extension + Agent mode demo
├── src/
│   ├── queries/                                   # Ad-hoc and reporting queries
│   ├── stored-procedures/                         # Reusable stored procedures
│   ├── views/                                     # Database views
│   └── database-instructions/                     # Scripts to configure Copilot database instructions
└── README.md
```

---

## Getting Started

### Prerequisites
- SQL Server Management Studio (SSMS) 22.3+ **or** VS Code with the MSSQL extension
- GitHub account with Copilot access
- Access to the `adventure_works` (AdventureWorks) database

### Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/nkusakula/GitHub-Copilot-for-SQL.git
   ```

2. Connect to the `adventure_works` database in SSMS or VS Code

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
   Enable in SSMS: **Tools → Options → GitHub → Copilot → Copilot Chat → Enable custom instructions**  
   Enable in VS Code: **Settings → GitHub Copilot → Chat: Copilot Instructions Files**

---

## Demo Scripts

### SSMS Demos

| Demo | Feature Covered | Script |
|---|---|---|
| Next Edit Suggestions | NES — typos, alias propagation, CTE refactor | [docs/nes-demo-script.md](docs/nes-demo-script.md) |
| Chat & Chat Context | Chat window, inline chat, slash commands, file refs, Mermaid | [docs/chat-and-context-demo-script.md](docs/chat-and-context-demo-script.md) |
| Database & Custom Instructions | Teaching Copilot business rules and coding style | [docs/database-and-custom-instructions-demo-script.md](docs/database-and-custom-instructions-demo-script.md) |

### VS Code Demos

| Demo | Feature Covered | Script |
|---|---|---|
| MSSQL Extension + Agent Mode | Schema exploration, code gen, review, optimize, Agent mode, custom agents & skills | [docs/vscode-mssql-demo-script.md](docs/vscode-mssql-demo-script.md) |

---

## SSMS vs VS Code — Copilot Capabilities

| Capability | SSMS | VS Code |
|---|---|---|
| Copilot Chat (Ask mode) | ✅ | ✅ |
| Inline chat (`Alt+/`) | ✅ | ✅ (`Ctrl+I`) |
| Next Edit Suggestions (NES) | ✅ | ✅ |
| **Agent mode** | ❌ | ✅ |
| Custom agents (`.agent.md`) | ❌ | ✅ |
| Skills (`.skill.md`) | ❌ | ✅ |
| Multi-step autonomous tasks | ❌ | ✅ |
| Schema visualization (`#schema`) | ✅ | ✅ |
| Results pane questions | ✅ | ✅ |

---

## Custom Copilot Assets (VS Code)

Stored in `.github/` — loaded automatically by GitHub Copilot in VS Code:

| Asset | File | Purpose |
|---|---|---|
| **Agent** | [.github/agents/ms-sql-dba.agent.md](.github/agents/ms-sql-dba.agent.md) | DBA-specialist agent with full tool access |
| **Instructions** | [.github/instructions/ms-sql-dba.instructions.md](.github/instructions/ms-sql-dba.instructions.md) | DBA chat mode behaviour rules |
| **Instructions** | [.github/instructions/sql-sp-generation.instructions.md](.github/instructions/sql-sp-generation.instructions.md) | Stored procedure coding standards (auto-applied to `.sql` files) |
| **Skill** | [.github/skills/sql-code-review/SKILL.md](.github/skills/sql-code-review/SKILL.md) | Comprehensive SQL security & code quality review |
| **Skill** | [.github/skills/sql-optimization/SKILL.md](.github/skills/sql-optimization/SKILL.md) | SQL performance optimization guidance |

---

## SQL Source Files

### Queries (`src/queries/`)

| File | Description | Used In Demo |
|---|---|---|
| `01-customer-revenue-by-category.sql` | Revenue per product category (shipped orders only) | Chat Demo 2, DB Instructions Demo 1 & 4 |
| `02-top-customers-by-revenue.sql` | Top 10 customers by total revenue with order stats | Chat Demo 2 |
| `03-product-profit-margin.sql` | Products >$500 with profit margin % | Chat Demo 3 (inline chat) |
| `04-recent-orders.sql` | Orders from the last 12 months with address details | Chat Demo 5 (file reference) |
| `05-order-status-no-aliases.sql` | Query without aliases — NES alias demo starting point | NES Demo 2 |
| `06-cte-rename-demo.sql` | CTE query — NES rename/refactor demo starting point | NES Demo 3 |

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

This repository follows the T-SQL coding standards defined in [`.github/copilot-instructions.md`](.github/copilot-instructions.md). GitHub Copilot in both SSMS and VS Code automatically applies these standards to all generated code.

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
- [GitHub Copilot for SQL — Code Generation in VS Code](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/github-copilot/code-generation?view=sql-server-ver17)
- [MSSQL Extension for VS Code](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/mssql-extension-visual-studio-code?view=sql-server-ver17)
- [Next Edit Suggestions](https://learn.microsoft.com/en-us/ssms/github-copilot/next-edit-suggestions)
- [Copilot Chat in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/chat)
- [Database Instructions](https://learn.microsoft.com/en-us/ssms/github-copilot/database-instructions)
- [Custom Instructions](https://learn.microsoft.com/en-us/ssms/github-copilot/custom-instructions)
- [Awesome Copilot — SQL Agents & Skills](https://github.com/github/awesome-copilot)
