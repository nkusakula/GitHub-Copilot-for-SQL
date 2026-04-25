# GitHub Copilot Chat & Chat Context in SSMS
### Customer Demo Script | AdventureWorks Database

---

## Setup Checklist (Before the Demo)

1. **SSMS 22+** installed with the AI Assistance workload
2. Signed into GitHub account with Copilot access
3. Connected to the `adventure_works` database
4. Open the Copilot Chat window: **View → GitHub Copilot Chat**
5. Have a couple of `.sql` files ready to demonstrate file referencing (scripts provided below)

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

**Step 4:** Accept Copilot's suggestion — select **Apply** to push the generated T-SQL into the active editor, review the diff, then press **Tab** to accept.

---

## Demo 2 — Chat Window: Generate a Business Query

**Talking point:**
> *"Let me show you how fast you can go from a business question to working T-SQL."*

**Step 1:** Start a **new thread** (`Ctrl+N` in the chat window) to keep context clean.

**Step 2:** Type:

```
Write a query to show the top 10 customers by total revenue, including their name,
company, number of orders, and total amount spent. Use the SalesLT schema.
```

**Expected output from Copilot:**

```sql
SELECT TOP 10
    c.CustomerID,
    c.FirstName + ' ' + c.LastName  AS CustomerName,
    c.CompanyName,
    COUNT(soh.SalesOrderID)         AS OrderCount,
    SUM(soh.TotalDue)               AS TotalRevenue
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
    ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.CompanyName
ORDER BY TotalRevenue DESC
```

**Step 3:** Click **Apply** → review the diff → press **Tab** to accept.

**Step 4:** Run the query and then ask Copilot about the results:

```
What is the average total revenue across these 10 customers?
```

**What to say:**
> *"It can now see the results grid and answer questions about the data it just returned — no copy-paste needed."*

---

## Demo 3 — Inline Chat (`Alt+/`): Modify a Query In-Place

**Talking point:**
> *"Sometimes you don't want to context-switch to the chat panel. You just want to ask Copilot a question right where you're working. That's inline chat."*

**Step 1:** Paste this query into a new query editor window:

```sql
SELECT
    p.Name,
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

**What to say:**
> *"Copilot modifies the query right here in a diff view. I can see exactly what changed before I accept it. Tab to apply, Alt+Delete to dismiss."*

**Step 4:** Accept with **Tab**. Then press **Alt+/** again and type:

```
Also filter to only show products that are currently available for sale
```

**What to say:**
> *"I can keep iterating inline. And if this conversation gets complex, I can promote it to the chat window using 'View in chat window' — preserving the full history."*

---

## Demo 4 — Slash Commands: `/explain`, `/fix`, `/optimize`, `/doc`

**Talking point:**
> *"These are shortcuts for the most common developer tasks on existing SQL. Highlight code, run the command — done."*

### `/explain`

**Step 1:** Paste this query:

```sql
SELECT
    pc.Name                         AS Category,
    p.Name                          AS Product,
    SUM(od.OrderQty)                AS UnitsSold,
    SUM(od.LineTotal)               AS Revenue
FROM SalesLT.SalesOrderDetail od
INNER JOIN SalesLT.Product p
    ON od.ProductID = p.ProductID
INNER JOIN SalesLT.ProductCategory pc
    ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name, p.Name
ORDER BY Revenue DESC
```

**Step 2:** Select all the code (`Ctrl+A`), then in the chat window type `/explain`.

**What to say:**
> *"This is great for onboarding — a new team member can highlight any stored proc or complex query and instantly understand what it does, without asking anyone."*

---

### `/fix`

**Step 1:** Paste this broken query into a new window:

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

**Step 2:** Select all, then type `/fix` in the chat or inline chat.

**What to say:**
> *"There are two bugs here — a missing comma after LastName and a WHERE instead of ON in the JOIN. Copilot catches both, explains what was wrong, and gives me the corrected version."*

**Expected fix:**
```sql
SELECT
    c.FirstName,
    c.LastName,
    c.EmailAddress,
    soh.OrderDate,
    soh.TotalDue
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
    ON c.CustomerID = soh.CustomerID
ORDER BY soh.TotalDue
```

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

**Step 2:** Select all, then type `/optimize`.

**What to say:**
> *"Copilot identifies the anti-patterns — SELECT *, correlated subquery — and rewrites it following T-SQL best practices. It also explains why each change is an improvement."*

---

### `/doc`

**Step 1:** Paste this query:

```sql
SELECT
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    a.City,
    a.StateProvince,
    a.CountryRegion
FROM SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.Customer c
    ON soh.CustomerID = c.CustomerID
INNER JOIN SalesLT.Address a
    ON soh.ShipToAddressID = a.AddressID
WHERE soh.OrderDate >= DATEADD(YEAR, -1, GETDATE())
ORDER BY soh.OrderDate DESC
```

**Step 2:** Select all, type `/doc`.

**What to say:**
> *"It adds meaningful inline comments explaining each join and filter — exactly the kind of documentation that never gets written but everyone wishes existed."*

---

## Demo 5 — Chat Context: Reference a File with `#`

**Talking point:**
> *"When you're working with multiple SQL files, you can pull specific files into the conversation using the # symbol — like tagging a file. Copilot uses it as additional context."*

**Step 1:** Save the optimized query from Demo 4 as `GetRecentOrders.sql`.

**Step 2:** Open a new thread (`Ctrl+N`). Type in the chat:

```
Based on #GetRecentOrders.sql, write a version that also groups results by country
and shows the count of orders per country
```

**What to say:**
> *"I didn't have to paste the code. I just referenced the file. Copilot reads it, understands it, and builds on it. This is huge when working with large scripts."*

---

## Demo 6 — Mermaid Diagram: Visualize the Schema

**Talking point:**
> *"Here's something that surprises people — Copilot can generate visual diagrams of your schema right inside SSMS."*

**Step 1:** In a new thread, type:

```
Visualize the relationships between tables in the SalesLT schema as a Mermaid entity relationship diagram
```

**Step 2:** When Copilot returns the Mermaid syntax, click **Preview** in the upper-right corner of the chat window.

**What to say:**
> *"This renders as an actual ER diagram — no external tool needed. You can save it as a Markdown file and share it with your team. Great for onboarding and documentation."*

---

## Demo 7 — Threads: Keeping Context Clean

**Talking point:**
> *"Copilot uses your full chat history as context for every new question in a thread. That's powerful, but you want to manage it — otherwise an old question about customers might bleed into a question about products."*

**Demonstrate:**
- **`Ctrl+N`** — Start a new thread (fresh context, new topic)
- **`Ctrl+Page Down / Ctrl+Page Up`** — Switch between threads
- **`Ctrl+Shift+T`** — Expand the thread dropdown
- **Delete thread** — Remove threads that gave wrong answers, to start clean

**What to say:**
> *"Think of threads like browser tabs for your AI conversations. One thread per task — write a proc, optimize a query, design a schema. Keep them separate and the answers stay accurate."*

---

## Closing Summary

| Capability | How to Invoke | Best For |
|---|---|---|
| **Chat window** | View → GitHub Copilot Chat | General T-SQL help, DBA questions, code generation |
| **Inline chat** | `Alt+/` | Modifying code without leaving the editor |
| **`/explain`** | Select code → `/explain` | Understanding unfamiliar queries |
| **`/fix`** | Select code → `/fix` | Catching syntax and logic errors |
| **`/optimize`** | Select code → `/optimize` | Improving query performance |
| **`/doc`** | Select code → `/doc` | Auto-generating inline comments |
| **File reference** | `#filename.sql` in chat | Grounding answers in a specific file |
| **Results pane** | Run query, then ask Copilot | Analyzing query output without copy-paste |
| **Mermaid diagram** | Prompt → Preview | Visualizing schema relationships |
| **Threads** | `Ctrl+N` / `Ctrl+Page Down` | Keeping conversations focused by topic |

**Closing line:**
> *"Whether you're writing new queries, debugging broken ones, optimizing slow ones, or just trying to understand what existing code does — Copilot Chat in SSMS handles it, in the context of your actual database connection, without you ever leaving the tool."*

---

## References

- [Use GitHub Copilot Chat in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/chat)
- [Add context for GitHub Copilot in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/chat-context)
- [Get started with GitHub Copilot in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/get-started)
- [Scenarios for GitHub Copilot in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/scenarios)
