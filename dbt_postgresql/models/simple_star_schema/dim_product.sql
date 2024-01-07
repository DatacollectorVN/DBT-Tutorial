{{ config(materialized='table')}}
SELECT 
    productid, 
    "name", 
    productnumber, 
    makeflag, 
    finishedgoodsflag, 
    color, 
    safetystocklevel, 
    reorderpoint, 
    standardcost, 
    listprice, 
    "size", 
    sizeunitmeasurecode, 
    weightunitmeasurecode, 
    "weight", 
    daystomanufacture, 
    productline, 
    "class", 
    "style", 
    productsubcategoryid, 
    productmodelid, 
    sellstartdate, 
    sellenddate, 
    discontinueddate, 
    rowguid as row_id, 
    modifieddate
FROM 
    {{ source('production', 'product') }}