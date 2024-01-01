### Define test
In the `first_run` folder, create new `yml` file with name `test_sales_order_header.yml` with:
```yml
version: 2

models:
  - name: sales_order_header
    description: "Sales Order Header table"
    columns:
      - name: salesorderid
        description: "sales order id"
      
      - name: revisionnumber
        description: "revision number"
      
      - name: orderdate
        description: ""
      
      - name: duedate
        description: ""
      
      - name: shipdate
        description: ""
      
      - name: status
        description: ""
        tests:
          - accepted_values:
              values: [1,2,3,4]
      
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

Then run test by command
```bash
dbt test -s first_run
```

*Expected output*:
```bash
Running with dbt=1.7.4
Registered adapter: postgres=1.7.4
Found 3 models, 7 tests, 2 sources, 0 exposures, 0 metrics, 401 macros, 0 groups, 0 semantic models
 
Concurrency: 4 threads (target='dev')

1 of 3 START test accepted_values_sales_order_header_status__1__2__3__4 ........ [RUN]
2 of 3 START test not_null_sales_order_header_row_id ........................... [RUN]
3 of 3 START test unique_sales_order_header_row_id ............................. [RUN]
2 of 3 PASS not_null_sales_order_header_row_id ................................. [PASS in 0.07s]
1 of 3 FAIL 1 accepted_values_sales_order_header_status__1__2__3__4 ............ [FAIL 1 in 0.07s]
3 of 3 PASS unique_sales_order_header_row_id ................................... [PASS in 0.08s]

Finished running 3 tests in 0 hours 0 minutes and 0.21 seconds (0.21s).

Completed with 1 error and 0 warnings:

Failure in test accepted_values_sales_order_header_status__1__2__3__4 (models/first_run/test_sales_order_header.yml)
Got 1 result, configured to fail if != 0

compiled Code at target/compiled/dbt_postgresql/models/first_run/test_sales_order_header.yml/accepted_values_sales_order_header_status__1__2__3__4.sql

Done. PASS=2 WARN=0 ERROR=1 SKIP=0 TOTAL=3
```