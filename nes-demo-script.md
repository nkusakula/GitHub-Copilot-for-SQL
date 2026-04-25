# GitHub Copilot — Next Edit Suggestions (NES) in SSMS
### Customer Demo Script | AdventureWorks Database

---

## Setup Checklist (Before the Demo)

1. **SSMS 22.2+** installed with the AI Assistance workload
2. Signed into GitHub account with Copilot access
3. NES enabled: **Tools → Options → All Settings → Text Editor → Code Completions → General** → check **Copilot Next Edit Suggestions**
4. Connected to `adventure_works` database
5. Open a **new Query window** for each demo scenario below

---

## Talking Points — What is NES?

> *"Inline code completions finish what you're currently typing. Next Edit Suggestions are different — they watch what you just changed and predict what you'll want to change **next**, even in a completely different part of the file. It's like Copilot tracks your intent, not just your cursor."*

> *"You'll see a **gutter arrow** (▶) appear on the line where NES has a suggestion. Press **Tab** once to jump to it. Press **Tab** again to accept it. Press **Esc** to dismiss."*

---

## Demo 1 — Catch and Correct Mistakes (Typos)

**Talking point:** *"NES doesn't just complete code — it also catches errors you've already made. Watch what happens when I make a typo."*

**Step 1:** Type this query with the deliberate typo — type `SELCT` instead of `SELECT`:

```sql
SELCT
    c.FirstName,
    c.LastName,
    c.CompanyName,
    c.EmailAddress
FROM SalesLT.Customer c
WHERE c.CompanyName LIKE '%Bike%'
ORDER BY c.LastName
```

**Step 2:** After typing out the query, notice the **gutter arrow** appears next to `SELCT`.

**Step 3:** Press **Tab** to jump to the suggestion → Copilot highlights `SELCT`.

**Step 4:** Press **Tab** again to accept — it corrects it to `SELECT`.

**What to say:**
> *"I didn't have to go back and hunt for the error. Copilot spotted the typo and flagged it. This is huge in long, multi-hundred-line SQL scripts where a typo can be buried deep."*

---

## Demo 2 — Match a Change in Intent (Adding Table Aliases)

**Talking point:** *"This is where NES really shines. When I change my intent — like deciding to use shorter table aliases — Copilot propagates that intent throughout the query automatically."*

**Step 1:** Paste this fully-spelled-out query (no aliases) into a new query window:

```sql
SELECT
    SalesOrderHeader.SalesOrderID,
    SalesOrderHeader.OrderDate,
    SalesOrderHeader.TotalDue,
    Customer.FirstName,
    Customer.LastName,
    Customer.CompanyName
FROM SalesLT.SalesOrderHeader
INNER JOIN SalesLT.Customer
    ON SalesOrderHeader.CustomerID = Customer.CustomerID
WHERE SalesOrderHeader.TotalDue > 1000
ORDER BY SalesOrderHeader.OrderDate DESC
```

**Step 2:** In the `FROM` clause, change `SalesLT.SalesOrderHeader` to `SalesLT.SalesOrderHeader soh`.

**Step 3:** Watch the gutter — a NES arrow appears. Press **Tab** to jump to the first reference (`SalesOrderHeader.SalesOrderID`) → press **Tab** to accept it as `soh.SalesOrderID`.

**Step 4:** More arrows appear for the remaining `SalesOrderHeader.*` references — keep pressing **Tab + Tab** to accept each one in sequence.

**Step 5:** Now do the same: change `SalesLT.Customer` to `SalesLT.Customer c` in the JOIN — NES cascades `c.` across all `Customer.*` references.

**Final result Copilot drives you to:**

```sql
SELECT
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    c.FirstName,
    c.LastName,
    c.CompanyName
FROM SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.Customer c
    ON soh.CustomerID = c.CustomerID
WHERE soh.TotalDue > 1000
ORDER BY soh.OrderDate DESC
```

**What to say:**
> *"I made one change — added an alias in the FROM clause — and Copilot figured out that every other reference to that table should also use the alias. This is the 'change in intent' capability. It's not just autocomplete — it's logical propagation."*

---

## Demo 3 — Refactor (Rename Throughout a CTE)

**Talking point:** *"Refactoring SQL, especially renaming CTEs or column aliases used across a long script, is tedious and error-prone. Watch NES handle it."*

**Step 1:** Paste this query into a new query window:

```sql
WITH SalesData AS (
    SELECT
        c.CustomerID,
        c.FirstName + ' ' + c.LastName  AS CustomerName,
        c.CompanyName,
        SUM(soh.TotalDue)               AS TotalRevenue,
        COUNT(soh.SalesOrderID)         AS OrderCount
    FROM SalesLT.Customer c
    INNER JOIN SalesLT.SalesOrderHeader soh
        ON c.CustomerID = soh.CustomerID
    GROUP BY c.CustomerID, c.FirstName, c.LastName, c.CompanyName
)
SELECT
    SalesData.CustomerName,
    SalesData.CompanyName,
    SalesData.TotalRevenue,
    SalesData.OrderCount
FROM SalesData
WHERE SalesData.TotalRevenue > 5000
ORDER BY SalesData.TotalRevenue DESC
```

**Step 2:** In the `WITH` declaration, rename `SalesData` → `CustomerRevenueSummary`.

**Step 3:** A gutter arrow immediately appears. Press **Tab** to jump to the first downstream `SalesData` reference — press **Tab** to accept the rename.

**Step 4:** Continue pressing **Tab + Tab** through every `SalesData` reference in the `SELECT`, `FROM`, and `WHERE` clauses until the whole script is updated.

**Final result:**

```sql
WITH CustomerRevenueSummary AS (
    SELECT
        c.CustomerID,
        c.FirstName + ' ' + c.LastName  AS CustomerName,
        c.CompanyName,
        SUM(soh.TotalDue)               AS TotalRevenue,
        COUNT(soh.SalesOrderID)         AS OrderCount
    FROM SalesLT.Customer c
    INNER JOIN SalesLT.SalesOrderHeader soh
        ON c.CustomerID = soh.CustomerID
    GROUP BY c.CustomerID, c.FirstName, c.LastName, c.CompanyName
)
SELECT
    CustomerRevenueSummary.CustomerName,
    CustomerRevenueSummary.CompanyName,
    CustomerRevenueSummary.TotalRevenue,
    CustomerRevenueSummary.OrderCount
FROM CustomerRevenueSummary
WHERE CustomerRevenueSummary.TotalRevenue > 5000
ORDER BY CustomerRevenueSummary.TotalRevenue DESC
```

**What to say:**
> *"Imagine this is a 500-line stored procedure with a CTE referenced 20 times. Without NES, you'd use Find & Replace and hope you don't accidentally rename something you shouldn't. With NES, you rename it once and Copilot walks you to every relevant instance — intelligently, not just textually."*

---

## Closing Summary

| NES Use Case | What You Changed | What NES Did |
|---|---|---|
| **Fix mistakes** | Typed `SELCT` | Flagged the typo, offered `SELECT` |
| **Match intent** | Added table alias in `FROM` | Updated every column reference to use the alias |
| **Refactor** | Renamed CTE once | Cascaded the new name to all downstream references |

**Closing line:**
> *"NES keeps you in the flow. You don't break your train of thought to hunt for side effects of a change — Copilot does it for you, and you just Tab through and accept. It works in T-SQL right here in SSMS today."*

---

## Tip: Hidden/Collapsed Mode

If the customer asks about the **hidden/collapsed mode** — mention that via **Tools → Options → Collapse Next Edit Suggestions**, the suggestions stay hidden until they choose to view them with the gutter arrow, keeping the editor clean while still having Copilot track their changes in the background.

---

## References

- [Use Next Edit Suggestions in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/next-edit-suggestions)
- [Get started with GitHub Copilot in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/get-started)
- [Use Code Completions in SSMS](https://learn.microsoft.com/en-us/ssms/github-copilot/code-completions)
