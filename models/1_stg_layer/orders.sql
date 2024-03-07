{{
    config(
        materialized='table',
        cluster_by=['o_orderdate']
    )
}}
With orders AS (
   SELECT O_ORDERKEY, O_CUSTKEY, O_ORDERSTATUS, O_TOTALPRICE,
      O_ORDERDATE, O_ORDERPRIORITY, O_CLERK, O_SHIPPRIORITY
   FROM tpch.orders
)
Select * from orders
