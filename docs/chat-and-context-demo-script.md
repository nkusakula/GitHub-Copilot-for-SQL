# GitHub Copilot Chat & Chat Context in SSMS
### Customer Demo Script | AdventureWorks Database

---

## Setup Checklist (Before the Demo)

1. **SSMS 22+** installed with the AI Assistance workload
2. Signed into GitHub account with Copilot access
3. Connected to the `adventure_works` database
4. Open the Copilot Chat window: **View → GitHub Copilot Chat**
5. This repo cloned locally so you can reference SQL files with `#`

---

## Overview — What Are We Showing?

| Feature | What It Does |
|---|---|
| **Chat window** | Ask T-SQL and DBA questions in natural language, get answers with code |
| **Inline chat** | Ask Copilot directly inside the query editor (`Alt+/`) |
| **Slash commands** | `/explain`, `/fix`, `/optimize`, `/doc` on selected T-SQL |
| **Chat context** | Use `#file`, results pane, and threads to get more precise answers |
| **Mermaid diagrams** | Visualize schema relationships without leaving SSMS |

---

## Demo 1 — Chat Window: Ask a Database Question

**Talking point:**
> *"The chat window is your AI database assistant. It's already connected to the database I have open — it knows the schema, the tables, the connection. I just ask in plain English."*

**Step 1:** Open the chat window via **View → GitHub Copilot Chat**.

**Step 2:** Type this prompt and hit **Enter**:

```
What tables are available in the SalesLT schema and how are they related?
```

**What to say:**
> *"Notice it doesn't just list tables — it explains the relationships between them. It's using the active database connection as implicit context."*

**Step 3:** Follow up in the same thread (no need to repeat context):

```
Which tables would I join to find out how much revenue each customer has generated?
```

**What to say:**
> *"This is conversational — it remembers what I asked before. I didn't have to repeat that we're talking about the SalesLT schema. That's chat history context working."*

**Step 4:** Select **Apply** to push the generated T-SQL into the active editor, review the diff, then press **Tab** to accept.

---

## Demo 2 — Chat Window: Generate a Business Query

**Step 1:** Start a **new thread** (`Ctrl+N`) to keep context clean.

**Step 2:** Type:

```
Write a query to show the top 10 customers by total revenue, including their name,
company, number of orders, and total amount spent. Use the SalesLT schema.
```

**Expected output:** See `src/queries/02-top-customers-by-revenue.sql` for the reference version.

**Step 3:** Click **Apply** → review the diff → press **Tab** to accept. Run the query.

**Step 4:** Ask Copilot about the results:

```
What is the average total revenue across these 10 customers?
```

**What to say:**
> *"It can now see the results grid and answer questions about the data it just returned — no copy-paste needed."*

---

## Demo 3 — Inline Chat (`Alt+/`): Modify a Query In-Place

**Step 1:** Open `src/queries/03-product-profit-margin.sql`. Notice it already has a profit margin column — use the version **without** the margin column as the starting point for the demo:

```sql
SELECT
    p.Name      AS ProductName,
    p.Color,
    p.ListPrice,
    p.StandardCost
FROM SalesLT.Product p
WHERE p.ListPrice > 500
ORDER BY p.ListPrice DESC
```

**Step 2:** Click anywhere in the query, then press **Alt+/** to open inline chat.

**Step 3:** Type:

```
Add a column showing the profit margin percentage for each product
```

**Step 4:** Accept with **Tab**. Press **Alt+/** again:

```
Also filter to only show products that are currently available for sale
```

**What to say:**
> *"I can keep iterating inline. And if this conversation gets complex, I can promote it to the chat window using 'View in chat window' — preserving the full history."*

---

## Demo 4 — Slash Commands

### `/explain`
**Step 1:** Open `src/queries/01-customer-revenue-by-category.sql`. Select all (`Ctrl+A`), type `/explain` in chat.

**What to say:** *"Great for onboarding — a new team member can highlight any query and instantly understand what it does."*

---

### `/fix`
**Step 1:** Paste this broken query:

```sql
SELECT
    c.FirstName,
    c.LastName
    c.EmailAddress,
    soh.OrderDate,
    soh.TotalDue
FROM SalesLT.Customer c
JOIN SalesLT.SalesOrderHeader soh
    WHERE c.CustomerID = soh.CustomerID
ORDER BY soh.TotalDue
```

**Step 2:** Select all, type `/fix`.

**What to say:** *"Two bugs — missing comma and WHERE instead of ON. Copilot catches both and explains what changed."*

---

### `/optimize`
**Step 1:** Paste this inefficient query:

```sql
SELECT *
FROM SalesLT.SalesOrderDetail
WHERE ProductID IN (
    SELECT ProductID
    FROM SalesLT.Product
    WHERE ListPrice > 1000
)
```

**Step 2:** Select all, type `/optimize`.

**What to say:** *"Copilot identifies the anti-patterns — SELECT *, subquery — and rewrites it with best practices, explaining each change."*

---

### `/doc`
**Step 1:** Open `src/queries/04-recent-orders.sql`. Select all, type `/doc`.

**What to say:** *"It adds meaningful inline comments — the documentation that never gets written but everyone wishes existed."*

---

## Demo 5 — Chat Context: Reference a File with `#`

**Step 1:** Start a new thread (`Ctrl+N`). Make sure `src/queries/04-recent-orders.sql` is open in the editor.

**Step 2:** Type:

```
Based on #recent-orders.sql, write a version that also groups results by
country and shows the count of orders per country.
```

**What to say:**
> *"I didn't paste the code. I just referenced the file. Copilot reads it, understands it, and builds on it."*

---

## Demo 6 — Mermaid Diagram

**Step 1:** In a new thread, type:

```
Visualize the relationships between tables in the SalesLT schema as a
Mermaid entity relationship diagram
```

**Step 2:** When Copilot returns the Mermaid syntax, click **Preview** in the upper-right of the chat window.

**What to say:**
> *"This renders as an actual ER diagram — no external tool needed. Save it as Markdown and share it with your team."*

---

## Demo 7 — Threads: Keeping Context Clean

| Shortcut | Action |
|---|---|
| `Ctrl+N` | Start a new thread (fresh context) |
| `Ctrl+Page Down / Up` | Switch between threads |
| `Ctrl+Shift+T` | Expand thread dropdown |
| Delete thread | Remove threads with wrong answers |

**What to say:**
> *"Think of threads like browser tabs for your AI conversations. One thread per task — keep them separate and the answers stay accurate."*

---

## Closing Summary

| Capability | How to Invoke | Best For |
|---|---|---|
| Chat window | View → GitHub Copilot Chat | General T-SQL help, code generation |
| Inline chat | `Alt+/` | Modifying code without leaving the editor |
| `/explain` | Select code → `/explain` | Understanding unfamiliar queries |
| `/fix` | Select code → `/fix` | Catching syntax and logic errors |
| `/optimize` | Select code → `/optimize` | Improving query performance |
| `/doc` | Select code → `/doc` | Auto-generating inline comments |
| File reference | `#filename.sql` in chat | Grounding answers in a specific file |
| Results pane | Run query, then ask Copilot | Analyzing output without copy-paste |
| Mermaid diagram | Prompt → Preview | Visualizing schema relationships |
| Threads | `Ctrl+N` / `Ctrl+Page Down` | Keeping conversations focused |

---

## References

- [Use GitHub Copilot Chat in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/chat)
- [Add context for GitHub Copilot in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/chat-context)
