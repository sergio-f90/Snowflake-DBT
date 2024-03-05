With partsupp AS (
   SELECT PS_PARTKEY, PS_SUPPKEY, PS_AVAILQTY, PS_SUPPLYCOST
   FROM tpch.partsupp
)
Select * from partsupp