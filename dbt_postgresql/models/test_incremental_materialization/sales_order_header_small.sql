{{ config(materialized='table')}}
{% set dt = modules.datetime.datetime(2011, 6, 1, 0, 0, 0) %}

SELECT 
    salesorderid
    , revisionnumber
    , orderdate
FROM {{ source('sales_test', 'salesorderheader') }}
WHERE orderdate <= '{{dt}}'
