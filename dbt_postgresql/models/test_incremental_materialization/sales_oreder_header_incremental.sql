{{ config(materialized='incremental', unique_key='orderdate')}}

SELECT 
    salesorderid
    , revisionnumber
    , orderdate
FROM {{ ref("sales_order_header_small") }}