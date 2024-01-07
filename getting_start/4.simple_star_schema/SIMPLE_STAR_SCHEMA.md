After getting a basic understanding of how dbt transformations are put together, lets build a fact table (the fact table in star schema) using two source tables: `sales.salesorderheader` and `sales.salesorderdetail`

### 1. Create source tables
Materialization: `ephemeral` when DBT execute the source tables were not created in database.

```yml
{{config(materialized='ephemeral')}}
```

Follow content in 4 files:
- `sales_order_detail.sql`
- `sales_order_detail.yml`
- `sales_order_header.sql`
- `sales_order_header.yml`

### 2. Create dimensional tables
Follow content in 2 files
- `dim_product.yml`
- `dim_product.sql`

In `dim_product.yml`, we use:
```yml
config:
      contract:
        enforced: true
```

`contract` to force the table that is created in database have exactly data type that we defined in yml.

### 3. Create fact tables
Follow content in 2 files
- `fact_sales.yml`
- `fact_sales.sql`

### 4. Execute and test model
```bash
dbt build --model simple_star_schema
```