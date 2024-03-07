With part AS (
   SELECT P_PARTKEY as part_key, P_NAME, P_MFGR, P_BRAND, P_TYPE, 
      P_SIZE, P_CONTAINER, P_RETAILPRICE
   FROM tpch.part
)
Select * from part

