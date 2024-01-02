Creating custom tests is supported in dbt. The way tests work is that they look for failing rows.

2 types of test:
- A `singular data test` is testing in its simplest form: If you can write a SQL query that returns failing rows, you can save that query in a .sql file within your test directory. It's now a data test, and it will be executed by the dbt test command.
- A `generic data test` is a parameterized query that accepts arguments. The test query is defined in a special test block (like a macro). Once defined, you can reference the generic test by name throughout your .yml files—define it on models, columns, sources, snapshots, and seeds. dbt ships with four generic data tests built in.

*Note:* Test failure when the sql in data test return rows.

Let get start with both of it.

### 1. Singular data test
Create sql file in `tests` folder that places in project folder (in this case is `dbt_postgresql`).

`test_due_date_before_order_date.sql`
```sql
SELECT duedate, orderdate, count(1) as occurrences
FROM {{ ref('sales_order_header') }}
WHERE duedate < orderdate
GROUP BY duedate, orderdate
```

Then run:
```bash
dbt test --select "test_type:singular"
```

*Expected output*:
```bash
16:36:04  Running with dbt=1.7.4
16:36:04  Registered adapter: postgres=1.7.4
16:36:05  Found 3 models, 8 tests, 2 sources, 0 exposures, 0 metrics, 401 macros, 0 groups, 0 semantic models
16:36:05  
16:36:05  Concurrency: 4 threads (target='dev')
16:36:05  
16:36:05  1 of 1 START test test_due_date_before_order_date .............................. [RUN]
16:36:05  1 of 1 PASS test_due_date_before_order_date .................................... [PASS in 0.04s]
16:36:05  
16:36:05  Finished running 1 test in 0 hours 0 minutes and 0.15 seconds (0.15s).
16:36:05  
16:36:05  Completed successfully
16:36:05  
16:36:05  Done. PASS=1 WARN=0 ERROR=0 SKIP=0 TOTAL=1
```

*Note*: You can change the sql test file to get test fail like:
```sql
WHERE duedate < orderdate
```

### 2. Generic data test

Create the generic folder inside tests folder, and inside it, create a file with the name `test_greater_than_column.sql`, and define the test as:
```sql
{% test greater_than_column(model, column_name, greater_than_column_name) %}

select {{column_name}}, {{greater_than_column_name}}, count(1) as num_occurrences
from {{model}}
where {{column_name}} < {{greater_than_column_name}}
group by 1, 2

{% endtest %}
```

In the above definition, the first line defines the test with the name greater_than_column. This is the Jinja syntax for defining the test as a function with parameters. This test can then be used in the model .yml files, either at model level or column level. When used at a column level, the values of first two parameters: model and column_name are passed by dbt, and only the value of the last parameter needs to be passed to the test. It can be used for validating the duedate column in the `sales_order_header.yml` file:
```yml
version: 2

models:
  - name: sales_order_header
    description: ""
    columns:
      - name: salesorderid
        description: "sales order id"
      
      - name: revisionnumber
        description: "revision number"
      
      - name: orderdate
        description: ""
      
      - name: duedate
        description: ""
        tests:
          - greater_than_column:
              greater_than_column_name: orderdate
      
      - name: shipdate
        description: ""
      
      - name: status
        description: ""
      
      - name: onlineorderflag
        description: ""
      
      - name: purchaseordernumber
        description: ""
      
      - name: subtotal
        description: ""
      
      - name: taxamt
        description: ""
      
      - name: freight
        description: ""
      
      - name: totaldue
        description: ""
      
      - name: row_id
        description: "Row Identifier"
        tests:
          - not_null
          - unique
      
      - name: modifieddate
        description: ""
```

Then run command:
```bash
dbt test --select "first_run,test_type:generic
```

*Expected output*:
```bash
16:45:03  Running with dbt=1.7.4
16:45:03  Registered adapter: postgres=1.7.4
16:45:03  Found 3 models, 8 tests, 2 sources, 0 exposures, 0 metrics, 402 macros, 0 groups, 0 semantic models
16:45:03  
16:45:03  Concurrency: 4 threads (target='dev')
16:45:03  
16:45:03  1 of 3 START test greater_than_column_sales_order_header_duedate__orderdate .... [RUN]
16:45:03  2 of 3 START test not_null_sales_order_header_row_id ........................... [RUN]
16:45:03  3 of 3 START test unique_sales_order_header_row_id ............................. [RUN]
16:45:04  1 of 3 PASS greater_than_column_sales_order_header_duedate__orderdate .......... [PASS in 0.06s]
16:45:04  2 of 3 PASS not_null_sales_order_header_row_id ................................. [PASS in 0.07s]
16:45:04  3 of 3 PASS unique_sales_order_header_row_id ................................... [PASS in 0.08s]
16:45:04  
16:45:04  Finished running 3 tests in 0 hours 0 minutes and 0.16 seconds (0.16s).
16:45:04  
16:45:04  Completed successfully
16:45:04  
16:45:04  Done. PASS=3 WARN=0 ERROR=0 SKIP=0 TOTAL=3
```