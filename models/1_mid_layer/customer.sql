With customer AS (
   SELECT
      c_custkey,
      c_name as customer_name,
      c_address as customer_address,
      c_nationkey,
      c_acctbal,C_MKTSEGMENT
   FROM tpch.customer
)

Select * from customer