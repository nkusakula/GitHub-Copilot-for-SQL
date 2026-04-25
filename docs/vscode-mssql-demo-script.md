# GitHub Copilot in VS Code — MSSQL Extension Demo
### Customer Demo Script | AdventureWorks Database

---

## Why VS Code in Addition to SSMS?

| Capability | SSMS | VS Code |
|---|---|---|
| Copilot Chat (Ask mode) | ✅ | ✅ |
| Inline chat | ✅ | ✅ |
| Next Edit Suggestions | ✅ | ✅ |
| **Agent mode** (multi-step, autonomous) | ❌ | ✅ |
| **Custom agents** (`.agent.md`) | ❌ | ✅ |
| **Skills** (`.skill.md`) | ❌ | ✅ |
| Edit files, run commands, multi-tool chaining | ❌ | ✅ |

> *"SSMS is where DBAs live. VS Code is where the full power of Copilot's Agent mode unlocks — multi-step autonomous tasks, custom specialist agents, and reusable skills. Both tools work against the same database and the same repo."*

---

## Setup Checklist (Before the Demo)

1. **VS Code** installed
2. **MSSQL extension** installed: search `ms-mssql.mssql` in the Extensions panel
3. GitHub Copilot extension installed and signed in
4. Clone this repository:
   ```bash
   git clone https://github.com/nkusakula/GitHub-Copilot-for-SQL.git
   cd GitHub-Copilot-for-SQL
   ```
5. Open the cloned folder in VS Code: `File → Open Folder`
6. Connect to `adventure_works` via the MSSQL extension (bottom status bar or Command Palette: `MSSQL: Connect`)

---

## Part 1 — Schema Exploration with Copilot Chat (Ask Mode)

**Talking point:**
> *"Before writing a single query, let's understand what's in this database. I'll use Copilot Chat — same as SSMS — but now I'm in VS Code with access to the full repo context as well as the database connection."*

### Demo 1 — Understand the Schema

**Step 1:** Open Copilot Chat (`Ctrl+Alt+I`) and ask:

```
Show me the schema for this database
```

**Step 2:** Follow up:

```
Show me all tables in the current database
```

**Step 3:**

```
Are there any views in the adventure_works database?
```

**Step 4:**

```
Show me all stored procedures in the current database
```

**What to say:**
> *"Copilot reads the live database connection — it's not guessing from schema names. Every answer is grounded in the actual objects that exist right now."*

---

### Demo 2 — Generate an ERD Diagram

**Talking point:**
> *"Here's something that takes a DBA 30 minutes manually — let's do it in seconds."*

**Step 1:** Ask in chat:

```
Create an ERD diagram of this database as a Mermaid diagram and save it
into a new file called docs/erd.md so I can visualize it
```

**What to observe:** In Agent mode, Copilot reads the schema, generates the Mermaid ER diagram, AND creates the file — no copy-paste.

**What to say:**
> *"In SSMS, Copilot generates the diagram and I copy it to a file manually. In VS Code Agent mode, it creates the file for me. That's the difference — multi-step, autonomous execution."*

---

## Part 2 — Code Generation

**Talking point:**
> *"Now let's write some T-SQL. I'll use the same natural language approach but now Copilot can also write to files, reference the repo, and chain steps together."*

### Demo 3 — Generate a Stored Procedure

**Step 1:** Open a new file: `src/stored-procedures/usp_GetCustomersByLastName.sql`

**Step 2:** In the file, press `Ctrl+I` (inline chat) and type:

```
Write a stored procedure that retrieves all customers from SalesLT.Customer
where the LastName matches a given parameter. Use T-SQL best practices.
```

**What to observe:** Because `.github/instructions/sql-sp-generation.instructions.md` is in the repo and applies to `**/*.sql` files, Copilot automatically:
- Names it `usp_GetCustomersByLastName`
- Adds the header comment block (Author, Date, Description, Parameters)
- Uses `SET NOCOUNT ON`
- Parameterizes the input
- Schema-qualifies everything

**What to say:**
> *"I didn't ask for a header comment, parameterization, or the naming convention. The instructions file in `.github/instructions/` injected those standards automatically — every SQL file in this repo gets them applied silently."*

---

### Demo 4 — Schema Validation

**Step 1:** Ask in chat:

```
Confirm that the Name column in SalesLT.ProductCategory doesn't use
nvarchar(max) and has a reasonable maximum length constraint.
```

**Step 2:**

```
Check whether the SalesLT.Address table has a primary key and all
required fields defined.
```

**Step 3:**

```
Suggest constraints for a table storing user passwords — for example,
special character requirements and length limits.
```

**What to say:**
> *"This is schema validation on demand. Instead of writing INFORMATION_SCHEMA queries, you just ask. Great for code reviews and onboarding new engineers to a database."*

---

### Demo 5 — Reverse Engineer the Schema

**Step 1:** Ask:

```
Reverse engineer the current database and generate CREATE TABLE statements
for all tables in the SalesLT schema.
```

**What to say:**
> *"Instant DDL documentation. If you've inherited a database with no scripts in source control, this gets you started in seconds."*

---

### Demo 6 — Generate Mock Data

**Step 1:** Ask:

```
Generate INSERT statements for mock data for the SalesLT.Customer
table with 10 sample records.
```

**Step 2:**

```
Generate INSERT statements for SalesLT.SalesOrderDetail with OrderQty
values at the upper boundary (1,000 units) to verify the system enforces
quantity constraints.
```

**What to say:**
> *"Test data generation, boundary testing, constraint validation — all without writing a single INSERT statement by hand. Huge time saver for QA and dev environments."*

---

## Part 3 — Code Review & Security with Skills

**Talking point:**
> *"Skills are reusable prompt templates stored in the repo. The team defines them once, and every developer gets access to them. Let me show you the two SQL skills in this repo."*

### Demo 7 — SQL Code Review Skill

**Step 1:** Open `src/stored-procedures/usp_GetCustomerOrders.sql` in the editor.

**Step 2:** In Copilot Chat, type:

```
#sql-code-review
Review this stored procedure for security vulnerabilities, code quality,
and T-SQL best practices.
```

**What to observe:** The skill triggers a structured review covering:
- SQL injection risks
- Access control issues
- Naming conventions
- Missing error handling
- SELECT * usage
- A scored assessment (Security, Performance, Maintainability)

**What to say:**
> *"The `#sql-code-review` skill is defined in `.github/skills/sql-code-review/SKILL.md` in this repo. Any team member who opens this repo in VS Code gets access to it. It's a reusable, version-controlled review checklist — not a one-off prompt."*

---

### Demo 8 — Security Review

**Step 1:** Ask:

```
Review the stored procedure SalesLT.uspGetCustomerOrders for potential
SQL injection vulnerabilities. Explain how unparameterized inputs could
be exploited and recommend secure coding practices.
```

**What to say:**
> *"This is the kind of security review that used to require a senior DBA or a separate security tool. Now it's a natural language question, grounded in the actual stored procedure code."*

---

### Demo 9 — Performance Optimization Skill

**Step 1:** Paste this stored procedure into the chat or open the file, then ask:

```
#sql-optimization
Review this stored procedure and help me optimize it.
```

```sql
CREATE OR ALTER PROCEDURE SalesLT.uspGetTopSellingProducts
    @TopN INT = 10,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@TopN)
        p.ProductID,
        p.Name,
        SUM(d.OrderQty) AS TotalQuantity,
        SUM(d.LineTotal) AS TotalSales
    FROM SalesLT.SalesOrderDetail d
    INNER JOIN SalesLT.SalesOrderHeader h
        ON h.SalesOrderID = d.SalesOrderID
    INNER JOIN SalesLT.Product p
        ON p.ProductID = d.ProductID
    WHERE (@StartDate IS NULL OR h.OrderDate >= @StartDate)
      AND (@EndDate IS NULL OR h.OrderDate < DATEADD(DAY, 1, @EndDate))
    GROUP BY p.ProductID, p.Name
    ORDER BY TotalSales DESC, TotalQuantity DESC;
END;
```

**What to observe:** The `#sql-optimization` skill triggers analysis of:
- Index strategy for the date range filter
- Parameter sniffing risk with optional `NULL` parameters
- Whether `OPTION (RECOMPILE)` should be added
- Missing covering indexes on `OrderDate`
- Universal optimization checklist scored output

**What to say:**
> *"The skill brings a structured, repeatable optimization framework. Every developer on the team runs the same review — not just the one senior DBA who remembers to check for parameter sniffing."*

---

## Part 4 — Agent Mode: The MS-SQL DBA Agent

**Talking point:**
> *"Now for the most powerful feature — Agent mode with a custom agent. This is exclusively available in VS Code. The agent in this repo is a specialist DBA that can autonomously perform multi-step database tasks: connect, query, analyze, write files, all in one conversation."*

### How to Activate the Agent

**Step 1:** In Copilot Chat, click the agent picker dropdown (top of the chat panel).

**Step 2:** Select **MS-SQL Database Administrator** (defined in `.github/agents/ms-sql-dba.agent.md`).

**What to say:**
> *"This agent is version-controlled in our repo. Anyone who clones it gets the same specialist agent. It knows to use the MSSQL extension tools, check the database connection first, and operate only on database objects — not the codebase."*

---

### Demo 10 — Multi-Step Schema Analysis

**Step 1:** With the MS-SQL DBA agent active, ask:

```
Analyze the SalesLT schema. Identify any tables missing primary keys,
foreign keys without indexes, and columns using nvarchar(max)
that could use a more restrictive type. Summarize your findings.
```

**What to observe:** The agent autonomously:
1. Connects to the database (using MSSQL extension tools)
2. Queries `INFORMATION_SCHEMA` and `sys` catalog views
3. Analyzes results
4. Produces a structured findings report

**What to say:**
> *"That was four separate DBA queries, aggregated and analyzed in one step. In Ask mode I'd have to run each query myself and interpret the results. Agent mode does the whole workflow."*

---

### Demo 11 — Autonomous Code + File Generation

**Step 1:** With the DBA agent active, ask:

```
Reverse engineer all tables in the SalesLT schema and save CREATE TABLE
statements to a new file src/schema/SalesLT-schema.sql. Include all
columns, data types, primary keys, and foreign key constraints.
```

**What to observe:** The agent:
1. Queries the database for all table definitions
2. Generates the DDL
3. Creates `src/schema/SalesLT-schema.sql` and writes to it

**What to say:**
> *"In SSMS, I'd generate scripts manually through the UI. Here, one prompt produced source-controlled DDL I can commit to Git. This is what multi-step autonomous execution looks like."*

---

## Part 5 — Custom Instructions in VS Code

**Step 1:** In VS Code, open `.github/instructions/sql-sp-generation.instructions.md`.

**Step 2:** Point out the `applyTo: '**/*.sql'` frontmatter.

**What to say:**
> *"This instruction file applies automatically to every `.sql` file I open or create — no manual invocation. It's the VS Code equivalent of SSMS custom instructions, but with the added ability to scope them to specific file types using `applyTo` patterns. I have one for stored procedures, another for DBA chat mode."*

---

## Closing: SSMS vs VS Code — When to Use What

| Scenario | Recommended Tool |
|---|---|
| Writing and debugging T-SQL interactively | SSMS |
| Managing database objects, running queries | SSMS |
| Next Edit Suggestions while typing SQL | Either |
| Database Instructions & Chat | Either |
| Multi-step autonomous tasks (generate + save files) | **VS Code** |
| Custom specialist agents for DBA workflows | **VS Code** |
| Reusable SQL review & optimization skills | **VS Code** |
| Source-controlling SQL alongside app code | **VS Code** |

**Closing line:**
> *"They're complementary tools. SSMS for interactive database work, VS Code when you want Copilot to go further — doing the whole workflow, not just answering questions. And because it's all in one repo, every prompt, every agent, every skill is version-controlled and shared across the entire team."*

---

## References

- [GitHub Copilot for SQL — Code Generation in VS Code](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/github-copilot/code-generation?view=sql-server-ver17)
- [MSSQL Extension for VS Code](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/mssql-extension-visual-studio-code?view=sql-server-ver17)
- [AdventureWorks sample database](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks)
- [Awesome Copilot — MS-SQL DBA Agent](https://github.com/github/awesome-copilot/blob/main/agents/ms-sql-dba.agent.md)
- [Awesome Copilot — SQL Code Review Skill](https://github.com/github/awesome-copilot/blob/main/skills/sql-code-review/SKILL.md)
- [Awesome Copilot — SQL Optimization Skill](https://github.com/github/awesome-copilot/blob/main/skills/sql-optimization/SKILL.md)
