## Summary
<!-- Describe the change and why it was made -->

## Type of Change
- [ ] New query
- [ ] Stored procedure / function / view
- [ ] Schema change / migration script
- [ ] Database instruction update
- [ ] Documentation update
- [ ] Bug fix

## SQL Checklist
- [ ] All object names are schema-qualified (e.g., `SalesLT.Customer`)
- [ ] No `SELECT *` — all columns explicitly listed
- [ ] All column references are qualified with a table alias
- [ ] Large-table queries include a `TOP` clause or restrictive filter
- [ ] `JOIN` conditions use explicit `INNER JOIN` / `LEFT JOIN` syntax
- [ ] Stored procedures follow the `usp_<Action><Entity>` naming convention
- [ ] Header comment block included (Author, Date, Description, Parameters, Change History)
- [ ] Tested successfully against the `adventure_works` database

## Testing
<!-- Describe how you tested this change and what results you validated -->

## Related Issues / Work Items
<!-- Link any related items -->
