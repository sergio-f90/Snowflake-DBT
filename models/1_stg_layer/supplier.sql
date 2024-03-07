With supplier AS (
   SELECT S_SUPPKEY as supplier_key, S_NAME, S_ADDRESS, S_NATIONKEY, S_PHONE, S_ACCTBAL
   FROM tpch.supplier
)
Select * from supplier




