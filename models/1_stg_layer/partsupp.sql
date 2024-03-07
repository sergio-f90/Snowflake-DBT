With partsupp AS (
   SELECT  CONCAT(PS_PARTKEY, '-', PS_SUPPKEY) as part_supplier_key,PS_PARTKEY as part_key,PS_SUPPKEY as supplier_key, PS_AVAILQTY, PS_SUPPLYCOST
   FROM tpch.partsupp
)
Select * from partsupp